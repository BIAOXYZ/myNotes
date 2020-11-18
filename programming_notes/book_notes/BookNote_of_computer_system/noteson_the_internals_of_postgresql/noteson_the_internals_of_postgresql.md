
# general info

The Internals of PostgreSQL http://www.interdb.jp/pg/index.html

# [Introduction](http://www.interdb.jp/pg/index.html)

The Chinese version of this document has been published in May 2019.
> PostgreSQL指南：内幕探索 https://book.douban.com/subject/33477094/

```console
Contents
  • Chapter 1. Database Cluster, Databases and Tables
  • Chapter 2. Process and Memory Architecture
  • Chapter 3. Query Processing
  • Chapter 4. Foreign Data Wrappers (FDW) and Parallel Query
  • Chapter 5. Concurrency Control
  • Chapter 6. VACUUM Processing
  • Chapter 7. Heap Only Tuple (HOT) and Index-Only Scans
  • Chapter 8. Buffer Manager
  • Chapter 9. Write Ahead Logging (WAL)
  • Chapter 10. Base Backup and Point-In-Time Recovery (PITR)
  • Chapter 11. Streaming Replication
```

# [Chapter 1. Database Cluster, Databases, and Tables](http://www.interdb.jp/pg/pgsql01.html) || 第1章 数据库集簇、数据库和数据表

## 1.1. Logical Structure of Database Cluster || 1.1 数据库集簇的逻辑结构

> A **database cluster** is a collection of *databases* managed by a ***`PostgreSQL server`***.

> A database is a collection of ***`database objects`***. In the relational database theory, a database object is a data structure used either to store or to reference data. A ***(heap) table*** is a typical example of it, and there are many more like an ***index***, a ***sequence***, a ***view***, a ***function*** and so on. In PostgreSQL, databases themselves are also database objects and are logically separated from each other. 

> All the database objects in PostgreSQL are internally managed by respective **object identifiers (OIDs)**, which are ***unsigned 4-byte integers***. The relations ***between database objects and the respective OIDs*** are stored in appropriate [`system catalogs`](https://www.postgresql.org/docs/current/catalogs.html), depending on the type of objects. For example, OIDs of databases and heap tables are stored in *pg_database* and *pg_class* respectively, so ***you can find out the OIDs you want to know*** by issuing the queries such as the following: 
```sql
sampledb=# SELECT datname, oid FROM pg_database WHERE datname = 'sampledb';
 datname  |  oid  
----------+-------
 sampledb | 16384
(1 row)

sampledb=# SELECT relname, oid FROM pg_class WHERE relname = 'sampletbl';
  relname  |  oid  
-----------+-------
 sampletbl | 18740 
(1 row)
```
>> notes: 上面那段中一个核心的信息就是：`system catalogs`那些表里存的都是`OID`和`数据库对象`的对应关系信息（比如`pg_database`是OID和数据库，`pg_class`是OID和表）。以前只知道`system catalogs`存储了各种pg系统相关的信息，但是确实没注意到这点。

## 1.2. Physical Structure of Database Cluster || 1.2 数据库集簇的物理结构

> A *database cluster* basically is ***one directory*** referred to as ***`base directory`***, and it contains ***some subdirectories and lots of files***. If you execute the [initdb](https://www.postgresql.org/docs/current/app-initdb.html) utility to initialize a new database cluster, a base directory will be created under the specified directory. Though it is not compulsory, the path of the base directory is usually set to the environment variable ***`PGDATA`***. || `数据库集簇在本质上就是一个文件目录，即基础目录，包含着一系列子目录与文件。执行initdb 命令会在指定目录下创建基础目录，从而初始化一个新的数据库集簇。通常基础目录的路径会被配置到环境变量PGDATA中，但这并不是必要的。`

> ***A database is a subdirectory*** under the ***`base` subdirectory***, and ***each of the tables and indexes is (at least) one file*** stored under the subdirectory of the database to which it belongs. Also there are several subdirectories containing particular data, and configuration files. While PostgreSQL supports tablespaces, the meaning of the term is different from other RDBMS. ***A tablespace in PostgreSQL is one directory*** that contains some data ***outside of the base directory***. || `base子目录中的每一个子目录都对应一个数据库，数据库中的每个表和索引都至少在相应子目录下存储为一个文件；还有几个包含特定数据的子目录，以及配置文件。虽然PostgreSQL支持表空间，但是该术语的含义与其他关系型数据库管理系统（RelationalDatabase Management System，RDBMS）不同。PostgreSQL中的表空间对应一个包含基础目录之外数据的目录。`
![](http://www.interdb.jp/pg/img/fig-1-02.png)
>> notes：注意这里的 `base subdirectory`，其实就是指`$PGDATA/base`这个目录——也就是`PGDATA`目录下名称为`base`（并且必须叫`base`！）的一级子目录，里面存的都是数据库数据。此外，虽然`PGDATA`被称为`base directory`，但这里的base只是个称呼而已，`PGDATA`本身叫啥名字都行。

### 1.2.1. Layout of a Database Cluster || 1.2.1 数据库集簇的布局

>> notes：表1.1是`base directory`（也就是`$PGDATA`）下的文件和子目录的名称和用途。本身内容不少，文档又可以随时查，就不赘述了。唯一需要强调一下的大概就是`pg10`之后的两个大的目录名称变更（变更原因之一都是为了防止萌新们删无用的日志时直接正则表达式匹配到log。。。）：
1. `pg_clog/`变更为`pg_xact`。
2. `pg_xlog/`变更为`pg_wal/`。

### 1.2.2. Layout of Databases || 1.2.2 数据库布局

> A database is a ***subdirectory*** under the `base subdirectory`; and ***the database directory names are identical to the respective OIDs***. For example, when the OID of the database sampledb is 16384, its subdirectory name is 16384. || `一个数据库与 base 子目录下的一个子目录对应，且该子目录的名称与相应数据库的 oid相同。例如，当数据库sampledb的oid为16384时，它对应的子目录名称就是16384。`
```sh
$ cd $PGDATA
$ ls -ld base/16384
drwx------  213 postgres postgres  7242  8 26 16:33 16384
```

### 1.2.3. Layout of Files Associated with Tables and Indexes || 1.2.3 表和索引相关文件的布局

> Each ***table or index*** whose size is less than ***`1GB`*** is ***a single file*** stored under the database directory it belongs to. Tables and indexes as database objects are internally managed by individual OIDs, while those data files are managed by the variable, ***`relfilenode`***. The relfilenode values of tables and indexes basically but **not** always match the respective OIDs, the details are described below. || `每个小于1GB的表或索引都在相应的数据库目录中存储为单个文件。在数据库内部，表和索引作为数据库对象是通过oid来管理的，而这些数据文件由变量relfilenode管理。表和索引的relfilenode值通常与其oid一致，但也有例外，下面将详细展开。`
>> notes：单个表和索引文件的大小以1GB为单位（这个值当然可以改，不过只改配置文件是不行的，得重新build数据库）。它们作为数据库对象的话对应的是OID，而它们的数据文件则对应的是`relfilenode`。

>  Let's show the OID and relfilenode of the table sampletbl:
```sql
sampledb=# SELECT relname, oid, relfilenode FROM pg_class WHERE relname = 'sampletbl';
  relname  |  oid  | relfilenode
-----------+-------+-------------
 sampletbl | 18740 |       18740 
(1 row)
```
> From the result above, you can see that ***both oid and relfilenode values are equal***. You can also see that the data file path of the table sampletbl is ***'base/16384/18740'***.
```sh
$ cd $PGDATA
$ ls -la base/16384/18740
-rw------- 1 postgres postgres 8192 Apr 21 10:21 base/16384/18740
```

> The relfilenode values of tables and indexes are changed by issuing some commands (e.g., ***`TRUNCATE, REINDEX, CLUSTER`***). For example, if we truncate the table sampletbl, PostgreSQL assigns a new relfilenode (18812) to the table, removes the old data file (18740), and creates a new one (18812).
```sql
sampledb=# TRUNCATE sampletbl;
TRUNCATE TABLE

sampledb=# SELECT relname, oid, relfilenode FROM pg_class WHERE relname = 'sampletbl';
  relname  |  oid  | relfilenode
-----------+-------+-------------
 sampletbl | 18740 |       18812 
(1 row)
```

> In version 9.0 or later, the built-in function ***`pg_relation_filepath`*** is useful as this function returns the file path name of the relation with the specified OID or name.
```sql
sampledb=# SELECT pg_relation_filepath('sampletbl');
 pg_relation_filepath 
----------------------
 base/16384/18812
(1 row)
```

>  When the file size of tables and indexes exceeds 1GB, PostgreSQL creates a new file named like ***`relfilenode.1`*** and uses it. If the new file has been filled up, next new file named like ***`relfilenode.2`*** will be created, and so on.
```sh
$ cd $PGDATA
$ ls -la -h base/16384/19427*
-rw------- 1 postgres postgres 1.0G  Apr  21 11:16 data/base/16384/19427
-rw------- 1 postgres postgres  45M  Apr  21 11:20 data/base/16384/19427.1
...
```

> The maximum file size of tables and indexes can be changed using the configuration, option ***`--with-segsize`*** when building PostgreSQL. 

>  Looking carefully at the database subdirectories, you will find out that each table has two associated files suffixed respectively with ***'`_fsm`'*** and ***'`_vm`'***. Those are referred to as ***`free space map`*** and ***`visibility map`***, storing the information of the free space capacity and the visibility on each page within the table file, respectively (see more detail in `Section 5.3.4` and `Section 6.2`). ***Indexes only have individual free space maps*** and ***don't*** have visibility map.
```sh
$ cd $PGDATA
$ ls -la base/16384/18751*
-rw------- 1 postgres postgres  8192 Apr 21 10:21 base/16384/18751
-rw------- 1 postgres postgres 24576 Apr 21 10:18 base/16384/18751_fsm
-rw------- 1 postgres postgres  8192 Apr 21 10:18 base/16384/18751_vm
```
> They may also be internally referred to as the forks of each relation; the free space map is the first fork of the table/index data file (the fork number is 1), the visibility map the second fork of the table's data file (the fork number is 2). The fork number of the data file is 0. 

### 1.2.4. Tablespaces

> A tablespace in PostgreSQL is an additional data area ***outside the base directory***. This function has been implemented in `version 8.0`.

> Figure 1.3 shows the internal layout of a tablespace, and the relationship with the main data area. 
![](http://www.interdb.jp/pg/img/fig-1-03.png)

> A tablespace is created under the directory specified when you issue [CREATE TABLESPACE](https://www.postgresql.org/docs/current/sql-createtablespace.html) statement, and under that directory, the `version-specific subdirectory` (e.g., PG_9.4_201409291) will be created. The naming method for version-specific one is shown below.
```
PG _ 'Major version' _ 'Catalogue version number'
```
> For example, if you create a tablespace ***'new_tblspc'*** at ***'/home/postgres/tblspc'***, whose ***oid is 16386***, a subdirectory such as 'PG_9.4_201409291' would be created under the tablespace.
```sh
$ ls -l /home/postgres/tblspc/
total 4
drwx------ 2 postgres postgres 4096 Apr 21 10:08 PG_9.4_201409291
```
> The tablespace directory is addressed by a ***`symbolic link`*** from the ***`pg_tblspc` subdirectory***, and ***the `link name` is the same as the `OID value of tablespace`***.
```sh
$ ls -l $PGDATA/pg_tblspc/
total 0
lrwxrwxrwx 1 postgres postgres 21 Apr 21 10:08 16386 -> /home/postgres/tblspc
```

> If you create `a new database` (***OID is 16387***) under the tablespace, its directory is created under the version-specific subdirectory.
```sh
$ ls -l /home/postgres/tblspc/PG_9.4_201409291/
total 4
drwx------ 2 postgres postgres 4096 Apr 21 10:10 16387
```
>> notes：整个database可以完全属于一个表空间（比如图里的“newdb数据库”整个都在“new_tblspc表空间”里）。紧接着在下面我们还将会看到，一个database也可以跨多个表空间。

> If you create a new table which ***belongs to the database created `under the base directory`***, first, the new directory, whose name is the same as the existing database OID, is created under the version specific subdirectory, and then the new table file is placed under the created directory.
```sql
sampledb=# CREATE TABLE newtbl (.....) TABLESPACE new_tblspc;

sampledb=# SELECT pg_relation_filepath('newtbl');
             pg_relation_filepath             
----------------------------------------------
 pg_tblspc/16386/PG_9.4_201409291/16384/18894
 ```
>> notes：从这里看出来，一个database是可以跨不同的表空间的！所以PG的database和tablespace没有绝对的包含关系：一个数据库（里所有的表）可以属于一个表空间也可以分属于多个表空间（***但是单个表只能属于某个确定的表空间！***）；一个表空间（里所有的表）可以在一个数据库中，也可以分别在多个数据库中（***但是单个表只能属于某个确定的数据库！***）。

>> notes：但是注意，一个表是不能跨不同表空间的（创建的时候的SQL语句就说明了这点；此外，任何数据库的表空间的作用之一都是为了在不同的表空间下可以有同名的表，所以从这点看也说明一个表是无法跨表空间的；同理，表也是无法跨数据库的。）

## 1.3. Internal Layout of a Heap Table File

> Inside the `data file` (`heap table` and `index`, as well as `the free space map` and `visibility map`), it is divided into **pages** (or **blocks**) of fixed length, the default is `8192 byte` (`8 KB`). Those pages within each file are ***numbered sequentially from 0***, and such numbers are called as **block numbers**. If the file has been filled up, PostgreSQL adds a new empty page to the end of the file to increase the file size. 

> Fig. 1.4. Page layout of a heap table file.
![](http://www.interdb.jp/pg/img/fig-1-04.png)

> A page ***within a table*** contains three kinds of data described as follows: 
1. **heap tuple(s)** – A heap tuple is a `record data` itself. They are stacked in order ***from the bottom of the page***. The internal structure of tuple is described in `Section 5.2 and Chapter 9` as the knowledge of both ***Concurrency Control(CC)*** and ***WAL*** in PostgreSQL are required.
2. **line pointer(s)** – A line pointer is `4 byte long` and holds ***`a pointer` to each `heap tuple`***. It is also called an `item pointer`.
<br> Line pointers form `a simple array`, which plays the role of index to the tuples. Each index is ***numbered sequentially from 1***, and called ***`offset number`***. When a new tuple is added to the page, a new line pointer is also pushed onto the array to point to the new one.
3. **header data** – A header data defined by the structure `PageHeaderData` is allocated ***in the beginning of the page***. It is `24 byte long` and contains general information about the page. The major variables of the structure are described below.
    - *pd_lsn* – This variable stores the `LSN of XLOG record` written by ***the last change of this page***. It is an `8-byte unsigned integer`, related to the ***WAL (Write-Ahead Logging) mechanism***. The details are described in `Chapter 9`.
    - *pd_checksum* – This variable stores the `checksum value of this page`. (Note that this variable is ***supported in version 9.3 or later***; in earlier versions, this part had stored the `timelineId of the page`.)
    - *pd_lower*, *pd_upper* – pd_lower points to ***the end of line pointers***, and pd_upper to ***the beginning of the newest heap tuple***.
      >> note：也就是说，`pd_lower`指向***free space的开头/低位***（因为按规定它指向序号最大的line pointer的末尾，这个末尾就是free space的开头）；`pd_upper`指向***free space的末尾/高位***（因为按规定它指向序号最大的tuple的开头，这个开头就是free space的末尾）。这个参考一下图1.4.很容易看出来。
    - *pd_special* – This variable is for `indexes`. In the page within tables, it points to ***the end of the page***. (In the page within indexes, it points to ***the beginning of special space*** which is the data area held only by indexes and contains the particular data according to the kind of index types such as B-tree, GiST, GiN, etc.)

> An empty space between the end of line pointers and the beginning of the newest tuple is referred to as **free space** or **hole**.
>> notes：line pointer末尾（也就是最新的line pointer）和最新的tuple之间的空间叫free space或者hole。

> To identify a tuple within the table, **tuple identifier (TID)** is internally used. A TID comprises a pair of values: ***the block number of the page*** that contains the tuple, and ***the offset number of the line pointer*** that points to the tuple. A typical example of its usage is index. See more detail in `Section 1.4.2`. 
>> notes：TID由两部分组成：页号/块号 + 偏移号

> The structure PageHeaderData is defined in [src/include/storage/bufpage.h](https://github.com/postgres/postgres/blob/master/src/include/storage/bufpage.h). 

> In addition, heap tuple whose size is ***greater than about 2 KB (about 1/4 of 8 KB)*** is stored and managed using a method called **TOAST** (The Oversized-Attribute Storage Technique). Refer [PostgreSQL documentation](https://www.postgresql.org/docs/current/storage-toast.html) for details. 
>> notes：大于2KB的heap tuple就得用TOAST来存储和管理了。

## 1.4. The Methods of Writing and Reading Tuples

### 1.4.1. Writing Heap Tuples

>  Suppose a table composed of one page which contains just one heap tuple. The pd_lower of this page points to the first line pointer, and both the line pointer and the pd_upper point to the first heap tuple. See Fig. 1.5(a).
>
> When the second tuple is inserted, it is placed after the first one. The second line pointer is pushed onto the first one, and it points to the second tuple. The pd_lower changes to point to the second line pointer, and the pd_upper to the second heap tuple. See Fig. 1.5(b). ***Other header data within this page (e.g., pd_lsn, pg_checksum, pg_flag) are also rewritten to appropriate values***; more details are described in `Section 5.3 and Chapter 9`. 
> ![](http://www.interdb.jp/pg/img/fig-1-05.png)
>> notes：整个过程比较直观，对比图片和上面两段文字就可以了。

### 1.4.2. Reading Heap Tuples

> Two typical access methods, `sequential scan` and `B-tree index scan`, are outlined here:
  - **Sequential scan** – All tuples in all pages are sequentially read by scanning all line pointers in each page. See Fig. 1.6(a).
  - **B-tree index scan** – An index file contains index tuples, each of which is ***composed of an index key and a TID pointing to the target heap tuple***. If the index tuple with the key that you are looking for has been found, PostgreSQL reads the desired heap tuple using the obtained TID value. (The description of the way to find the index tuples in B-tree index is not explained here as it is very common and the space here is limited. See the relevant materials.) For example, in Fig. 1.6(b), TID value of the obtained index tuple is ‘(block = 7, Offset = 2)’. It means that the target heap tuple is 2nd tuple in the 7th page within the table, so PostgreSQL can read the desired heap tuple without unnecessary scanning in the pages.
> ![](http://www.interdb.jp/pg/img/fig-1-06.png)

> This document does not explain indexes in details. To understand them, I recommend to read the valuable posts shown below: 
  - Indexes in PostgreSQL — 1 https://postgrespro.com/blog/pgsql/3994098
  - ...
  - ...
  - Indexes in PostgreSQL — 9 (BRIN) https://habr.com/en/company/postgrespro/blog/452900/

> PostgreSQL also supports `TID-Scan`, `Bitmap-Scan`, and `Index-Only-Scan`.

> TID-Scan is a method that accesses a tuple directly by using TID of the desired tuple. For example, to find the 1st tuple in the 0-th page within the table, issue the following query:
```sql
sampledb=# SELECT ctid, data FROM sampletbl WHERE ctid = '(0,1)';
 ctid  |   data    
-------+-----------
 (0,1) | AAAAAAAAA
(1 row)
```
> Index-Only-Scan will be described in details in `Chapter 7`.

# [Chapter 3. Query Processing](http://www.interdb.jp/pg/pgsql03.html)

## 3.1. Overview
### 3.1.1. Parser
### 3.1.2. Analyzer/Analyser
### 3.1.3. Rewriter
### 3.1.4. Planner and Executor

## 3.2. Cost Estimation in Single-Table Query

> In PostgreSQL, there are three kinds of costs: start-up, run and total. The total cost is the sum of start-up and run costs; thus, only the start-up and run costs are independently estimated. || "在PostgreSQL中有三种代价，分别是启动代价、运行代价和总代价。总代价是启动代价和运行代价的和，因此只有启动代价和运行代价是单独估计的。"
- > 1.启动代价：在读取到第一条元组前花费的代价，比如索引扫描节点的启动代价就是读取目标表的索引页，获取到第一个元组的代价。
- > 2.运行代价：获取全部元组的代价。

### 3.2.1. Sequential Scan

> 中译版：“注意，这种类型的过滤器只会在读取所有元组的时候使用，它并不会减少需要扫描的表页面数量。” || 英文版："Note that this type of filter is used when reading all the tuples in the table, and it does not narrow the scanned range of table pages."
>> notes：这段中文版翻译的不是很好，意思稍有偏颇——人家英文原文的意思准确说是指`WHERE id < 8000`这个filter在使用的时候是对全表的所有tuple进行过滤（那么执行器肯定所有的tuple都要读）；而不是说“只会在读取所有元组的时候才会使用（这个filter）”。
