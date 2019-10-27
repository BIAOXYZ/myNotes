
# general info

The Internals of PostgreSQL http://www.interdb.jp/pg/index.html

# [Introduction](http://www.interdb.jp/pg/index.html)

The Chinese version of this document has been published in May 2019.
> PostgreSQL指南：内幕探索 https://book.douban.com/subject/33477094/

```
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

# [Chapter 1. Database Cluster, Databases, and Tables](http://www.interdb.jp/pg/pgsql01.html)

## 1.1. Logical Structure of Database Cluster 

> A **database cluster** is a collection of *databases* managed by a ***`PostgreSQL server`***.

> A database is a collection of ***`database objects`***. In the relational database theory, a database object is a data structure used either to store or to reference data. A (heap) table is a typical example of it, and there are many more like an index, a sequence, a view, a function and so on. In PostgreSQL, databases themselves are also database objects and are logically separated from each other. 

> All the database objects in PostgreSQL are internally managed by respective **object identifiers (OIDs)**, which are ***unsigned 4-byte integers***. The relations ***between database objects and the respective OIDs*** are stored in appropriate [system catalogs](https://www.postgresql.org/docs/current/catalogs.html), depending on the type of objects. For example, OIDs of databases and heap tables are stored in *pg_database* and *pg_class* respectively, so you can find out the OIDs you want to know by issuing the queries such as the following: 
```
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

## 1.2. Physical Structure of Database Cluster

> A *database cluster* basically is ***one directory*** referred to as ***`base directory`***, and it contains ***some subdirectories and lots of files***. If you execute the [initdb](https://www.postgresql.org/docs/current/app-initdb.html) utility to initialize a new database cluster, a base directory will be created under the specified directory. Though it is not compulsory, the path of the base directory is usually set to the environment variable ***`PGDATA`***. 

> ***A database is a subdirectory*** under the ***`base` subdirectory***, and ***each of the tables and indexes is (at least) one file*** stored under the subdirectory of the database to which it belongs. Also there are several subdirectories containing particular data, and configuration files. While PostgreSQL supports tablespaces, the meaning of the term is different from other RDBMS. ***A tablespace in PostgreSQL is one directory*** that contains some data ***outside of the base directory***. 
>> notes：注意这里的 `base subdirectory`，其实就是`$PGDATA/base`。

### 1.2.1. Layout of a Database Cluster
