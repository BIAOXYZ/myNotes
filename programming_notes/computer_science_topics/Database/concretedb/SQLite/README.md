
# SQLite官方

SQLite https://en.wikipedia.org/wiki/SQLite

SQLite https://www.sqlite.org/index.html
- Getting Started https://www.sqlite.org/quickstart.html
  * > See also the [Introduction To The SQLite C/C++ Interface](https://www.sqlite.org/cintro.html) for an introductory overview and roadmap to the dozens of SQLite interface functions.
  * > See the [How To Compile SQLite](https://www.sqlite.org/howtocompile.html) document for instructions and hints on how to compile the program shown above.

Appropriate Uses For SQLite https://www.sqlite.org/whentouse.html
- > **Situations Where A Client/Server RDBMS May Work Better**
  * > **Client/Server Applications**
  * > **High-volume Websites**
  * > **Very large datasets**
    + > An SQLite database is limited in size to `281 terabytes` (2<sup>48</sup> bytes, `256 tibibytes`). And even if it could handle larger databases, ***SQLite stores the entire database in a single disk file and many filesystems limit the maximum size of files to something less than this***. So if you are contemplating databases of this magnitude, you would do well to consider using a client/server database engine that spreads its content across multiple disk files, and perhaps across multiple volumes.
    >> //notes：所以目前看最大支持数据量为 281 T。
  * > **High Concurrency**
    + > SQLite supports an ***unlimited number of simultaneous readers***, but it will only allow ***one writer at any instant in time***. For many situations, this is not a problem. Writers queue up. Each application does its database work quickly and moves on, and no lock lasts for more than a few dozen milliseconds. But there are some applications that require more concurrency, and those applications may need to seek a different solution.

Documentation https://www.sqlite.org/docs.html
- Dynamic Memory Allocation In SQLite https://www.sqlite.org/malloc.html || SQLite中的动态内存分配 https://www.sqlite.net.cn/malloc.html  【这个不一定是中文官网，但是看样子好像翻译得还行。】
- In-Memory Databases https://www.sqlite.org/inmemorydb.html
  * > The most common way to force an SQLite database to exist purely in memory is to open the database using the special filename "`:memory:`". In other words, instead of passing the name of a real disk file into one of the `sqlite3_open()`, `sqlite3_open16()`, or `sqlite3_open_v2()` functions, pass in the string "`:memory:`". For example:
    ```c
    rc = sqlite3_open(":memory:", &db);
    ```
    > When this is done, no disk file is opened. Instead, a new database is created purely in memory. The database ceases to exist as soon as the database connection is closed. Every `:memory:` database is distinct from every other. So, opening two database connections each with the filename "`:memory:`" will create two independent in-memory databases.
  * > **Temporary Databases**
- SQLite Shared-Cache Mode https://www.sqlite.org/sharedcache.html
- SQLite中的限制 https://www.sqlite.net.cn/limits.html || Limits In SQLite https://www.sqlite.org/limits.html

Official Git mirror of the SQLite source tree https://github.com/sqlite/sqlite || SQLite Source Repository https://sqlite.org/src/doc/trunk/README.md

Why SQLite Does Not Use Git https://sqlite.org/whynotgit.html
- > SQLite does not use the Git version control system. SQLite uses Fossil instead, which is a version control system that was specifically designed and written to support SQLite.

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 官方文章

Atomic Commit In SQLite https://sqlite.org/atomiccommit.html

The SQLite Query Optimizer Overview https://www.sqlite.org/optoverview.html || SQLite查询优化器概述 https://www.sqlite.net.cn/optoverview.html

PRAGMA Statements https://www.sqlite.org/pragma.html || PRAGMA声明 https://www.sqlite.net.cn/pragma.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他较权威链接

SQLite https://en.wikipedia.org/wiki/SQLite

SQLite https://db-engines.com/en/system/SQLite

SQLite权威指南 (The Definitive Guide to SQLite) https://wizardforcel.gitbooks.io/the-definitive-guide-to-sqlite/content/index.html
- 第1章 SQLite介绍
  * > **可靠性**
    + > SQLite的源代码不但免费，还编写得很好。SQLite源代码包含大约30000行标准C代码，它是干净的、模块化的和完好注释的。SQLite源代码易理解、易定制。
    + > SQLite的核心软件(库和工具)由约30000行代码组成，但分发的程序中还包含有超过30000行的回归测试代码，它们覆盖了97%的核心代码。也就是说，超过一半的SQLite项目代码是专门用于回归测试的，也就是说，差不多每写一行功能代码，都要写一行测试代码对它进行测试。
  * > **性能和限制**
    + > SQLite是一个快速数据库。但“快速”这个词本身是一个主观的和不明确的词。诚实地讲，有些事情SQLite能比其它数据库做得快，也有些事情不能。这么说吧，利用SQLite提供的配置参数，SQLite是足够快速和高效的。跟大多数其它数据库一样，SQLite使用B-tree处理索引，使用B+tree处理表数据。因此，***在对单表进行查询时，SQLite要快于(或至少相当于)其它数据库的速度***。
    + > 在一些情况下SQLite可能不如大型数据库快，但大多数这些情况是可理解的。SQLite是一个内嵌式的数据库，设计用于中小规模的应用程序。这些限制是符合设计目的的。很多新用户错误地假设使用SQLite可以代替大型关系型数据库，这有时行，但有时不行，依赖于你准备用SQLite来做什么。一般情况下，SQLite在三个主要的方面具有局限性：
- 第5章 设计和概念 https://wizardforcel.gitbooks.io/the-definitive-guide-to-sqlite/content/7.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
# SQLite SQL

SQLite INSERT OR REPLACE使用 https://www.jianshu.com/p/bfa617a0b9b1

SQLite 触发器（Trigger） https://www.runoob.com/sqlite/sqlite-trigger.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 在 CMake 中使用 SQLite

FindSQLite3 https://cmake.org/cmake/help/latest/module/FindSQLite3.html  【PS：尽管官方有这种更现成的方式，但是我用 `apt install -y libsqlite3-dev` 装的貌似只有一个头文件，用这种方式找不到。。。回头再看看了。】

cmake 如何引入本地已安装软件 https://www.jianshu.com/p/9bf66d8d306e
- > **4.编写`CMakeLists.txt`**
  ```cmake
  cmake_minimum_required(VERSION 3.10)
  project(sqlite_demo)

  set(CMAKE_CXX_STANDARD 14)
  aux_source_directory(. SOURCE_DIR)
  add_executable(sqlite_demo ${SOURCE_DIR})
  #target_link_directories(sqlite_demo .)
  # 链接本地的sqlite3库
  target_link_libraries(sqlite_demo sqlite3)
  ```

How can I link CMake and SQLite without an external script? https://stackoverflow.com/questions/41640029/how-can-i-link-cmake-and-sqlite-without-an-external-script

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# SQLite连接池（是否需要都不一定，只是随便记一下）

sqlite需要连接池吗？ https://segmentfault.com/q/1010000040020650/

sqlite连接池的简单实现 https://www.cnblogs.com/ngxianyu/archive/2013/06/08/3126543.html

SQLite/C# Connection Pooling and Prepared Statement Confusion https://stackoverflow.com/questions/10703814/sqlite-c-connection-pooling-and-prepared-statement-confusion

## 其他连接问题

Python 操作 SQLite 异常 https://www.v2ex.com/t/881675
```py
# coding=utf-8
import sqlite3
import random
import threading
import time

db_path = "./test.sqlite"
connection = sqlite3.connect(db_path, check_same_thread=False)
CREATE_SQL = """CREATE TABLE IF NOT EXISTS test_table (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)"""
write_count = 0

def write_handle():
    while True:
        connection.cursor().execute("INSERT INTO test_table (name) VALUES ('%s')" % random.random())
        connection.commit()
        global write_count
        write_count += 1
        print(str(int(time.time())) + "Insert_" + str(write_count))

def read_handle():
    while True:
        res = connection.cursor().execute("SELECT * FROM test_table LIMIT 1").fetchone()
        if res is None or res[0] is None:
            continue
        print(str(int(time.time())) + "Read")

if __name__ == '__main__':
    c = connection.cursor()
    c.execute(CREATE_SQL)
    connection.commit()
    time.sleep(1)
    threading.Thread(target=write_handle).start()
    threading.Thread(target=read_handle).start()
    time.sleep(1000)
```
```console
代码缩进没有了 ... 总结就是两个线程循环执行，
一个线程执行 `connection.cursor().execute("INSERT INTO test_table (name) VALUES ('%s')" % random.random())`
一个线程去读 然后程序必定崩溃 ...
```
- > 又遇到字符串拼接 SQL 语句：`connection.cursor().execute("INSERT INTO test_table (name) VALUES ('%s')" % random.random())` 有 SQL 注入的风险 <br> 明明 `.execute()` 就有占位符功能的，为何不用呢？ https://docs.python.org/3/library/sqlite3.html#sqlite3-placeholders
- > 似乎 `connection` 非 threadsafe
  >> 但是 Google 了一圈，网上基本都是说 <多写> 是非 ThreadSafe ，我这个场景是 单读单写 按道理没问题呀 ...
- > 我这里测试没崩啊 Windows 10 Python 3.10 PyCharm 2021 <br> 另外，根据[文档](https://sqlite.org/isolation.html)所说，你不应该在同一个连接内同时读写数据库，此行为未定义 <br> 最后，贴代码起码用下 Markdown 啊。回复用不了就算了，帖子还不用。。
  >> 9 楼给的官方文档说了，一个 `connection` 内同时读写的行为是未定义的。即，按道理，是有问题的 你试试每个线程一个 `connection` ？
  >>> 可以了！程序总算不崩溃了！感谢大佬！每个线程一个 Connect 就可以了

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# SQLite新闻

Fedora Linux：计划将 RPM 数据库从 Berkeley DB 迁移到 SQLite https://www.ithome.com/0/478/504.htm
```
祖安卢本伟2020/3/19 9:54:58
…现在就在搞数据库迁移。原来Oracle不支持主键，删掉用来自增的序列和触发器，换成现在的主键自增；还
有前后索引长度限制不同；函数支持不同；字段类型不同；甚至还有优化器导致的性能问题，三个join的语句，
在Oracle神优化器加持下，秒出数据，现在两个小时都不出数据你敢信？基本断定是卡死了。还有那种with as
的树状递归select，也是一样的情况。反正切数据库是个巨坑
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# SQLite类型

SQLite3 实践教程 https://linux.cn/article-13117-1.html
- > SQLite 中有五种数据类型（实际上是 储存类别）：

## 反人类的动态类型列- -

Datatypes In SQLite https://www.sqlite.org/datatype3.html
- > **3. Type Affinity**
  * > SQL database engines that use rigid typing will usually try to automatically convert values to the appropriate datatype. Consider this:
    ```sql
    CREATE TABLE t1(a INT, b VARCHAR(10));
    INSERT INTO t1(a,b) VALUES('123',456);
    ```

SQLite3's dynamic typing https://stackoverflow.com/questions/2489936/sqlite3s-dynamic-typing

**个人实验**：
```console
sqlite> .open ./12345
sqlite> create table t (col1, col2);
sqlite> insert into t values (1, 'a');
sqlite> insert into t values (2, 2);
sqlite> select * from t;
1|a
2|2
sqlite> select typeof(col1), typeof(col2) from t;
integer|text
integer|integer
sqlite> 
```

### 一大坏处就是有些SQL语义都不正常了

What is the sqlite default column type? https://stackoverflow.com/questions/36782671/what-is-the-sqlite-default-column-type
- https://stackoverflow.com/questions/36782671/what-is-the-sqlite-default-column-type/49574690#49574690
  * > https://www.sqlite.org/datatype3.html
    ```console
    3.1. Determination Of Column Affinity
    If the declared type for a column contains the string "BLOB" or if no type is specified then the column has affinity BLOB.
    ```
    > So we can assume that default type is a `BLOB`.

***下面这个例子就说明了如果没有显式指定类型，又恰好被 type affinity 搞成了 `BLOB`，那么 `where` 过滤就失效了。***
```console
sqlite> .open 12345
sqlite> .table
t1            t_input_data
sqlite> .schema
CREATE TABLE t1 (row int, col int, val text);
CREATE TABLE t_input_data (col1, col2, col3);
sqlite> 
sqlite> select * from t1;
7|8|9
8|9|10
9|10|11
sqlite> select * from t1 where row > 8;
9|10|11
sqlite> select * from t_input_data;
7|8|9
8|9|10
9|10|11
sqlite> select * from t_input_data where col1 > 8;
7|8|9
8|9|10
9|10|11
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他文章

SQLite页缓冲区管理 https://www.cnblogs.com/amdb/p/4035614.html || https://blog.csdn.net/apple7912/article/details/101962813

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
