
Database of Databases
- LevelDB https://dbdb.io/db/leveldb

# [MongoDB](https://www.mongodb.com/)

【from draveness】:
- 『浅入浅出』MongoDB 和 WiredTiger https://draveness.me/mongodb-wiredtiger
- 如何从 MongoDB 迁移到 MySQL https://draveness.me/mongodb-to-mysql

## MongoDB安装与配置

Windows 下 MongoDB 的安装与环境配置 https://blog.csdn.net/klxh2009/article/details/78340422

## MongoDB操作

***下面这个几个标题一模一样，全都叫"MongoDB基本操作"。我都忍不住吐槽了。。。不然还以为我复制错了呢- -***
- MongoDB基本操作 https://segmentfault.com/a/1190000012096666
- MongoDB基本操作 https://www.jianshu.com/p/d5031110f936
```
mongo    #连接mongodb

>show dbs    #查看所有数据库
local 0.078125GB
test 0.203125GB

>use local    #切换到local
switched to db local

> show collections    #查看local的所有collection
startup_log

>db.startup_log.find()    #产看startup_log
{ "_id" : "jlan-pc-1466044795232", "hostname" : "jlan-pc", "startTime",...}

> db.createCollection('startup_log2')    #创建collection
{ "ok" : 1 }

>db.startup_log.remove()    #清空collection
```
- MongoDB 基本操作 https://blog.csdn.net/jeanette_zlj/article/details/79564315
- MongoDB数据库的基本操作命令以及和mysql进行比较 https://blog.csdn.net/rocky1996/article/details/75646399

zhengcongyi -- MongoDB https://blog.csdn.net/congcong68/article/category/2938211
- 学习MongoDB 二：MongoDB添加、删除、修改 https://blog.csdn.net/congcong68/article/details/46781777

# firebird

https://www.viva64.com/en/b/0542/

# [MyRocks](http://myrocks.io/)

MyRocks及其使用场景分析 - 温正湖的文章 - 知乎 https://zhuanlan.zhihu.com/p/45652076

# Dynamo and DynamoDB

Dynamo (storage system) https://en.wikipedia.org/wiki/Dynamo_(storage_system)
- > Amazon DynamoDB is "built on the principles of Dynamo" and is a hosted service within the AWS infrastructure. However, while Dynamo is based on leaderless replication, DynamoDB uses single-leader replication. 

Amazon DynamoDB https://en.wikipedia.org/wiki/Amazon_DynamoDB
- > Amazon DynamoDB is a fully managed proprietary NoSQL database service that supports key-value and document data structures and is offered by Amazon.com as part of the Amazon Web Services portfolio. DynamoDB exposes a similar data model to and derives its name from Dynamo, but has a different underlying implementation. Dynamo had a multi-master design requiring the client to resolve version conflicts and DynamoDB uses synchronous replication across multiple datacenters for high durability and availability. DynamoDB was announced by Amazon CTO Werner Vogels on January 18, 2012 and is presented as an evolution of Amazon SimpleDB solution. 

【from draveness】:
- 分布式键值存储 Dynamo 的实现原理 https://draveness.me/dynamo

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# DuckDB

Efficient SQL on Pandas with DuckDB https://duckdb.org/2021/05/14/sql-on-pandas.html
- > TLDR: DuckDB, a free and open source analytical data management system, can efficiently ***run SQL queries directly on Pandas DataFrames***.
- > Recently, an article was published [advocating for using SQL for Data Analysis](https://hakibenita.com/sql-for-data-analysis).
- > **SQL on Pandas**
- > **SQL on Pandas Performance**

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# not full-fledged DBs

Dolt is Git for data! https://github.com/liquidata-inc/dolt
- > Dolt is a relational database, i.e. it has tables, and you can execute SQL queries against those tables. It also has version control primitives that operate at the level of table cell. Thus Dolt is a database that supports fine grained value-wise version control, where all changes to data and schema are stored in commit log.

Scuba: Diving into Data at Facebook https://research.fb.com/publications/scuba-diving-into-data-at-facebook/

Fast, Distributed Graph DB https://dgraph.io https://github.com/dgraph-io/dgraph

SQLite compiled to JavaScript through Emscripten https://github.com/kripken/sql.js
> Emscripten: An LLVM-to-JavaScript Compiler https://github.com/kripken/emscripten

重磅！谷歌等推出基于机器学习的数据库SageDB https://mp.weixin.qq.com/s/8Twe3e3WKCY9pTiNtnW2sg
- SageDB: a learned database system 
  * https://blog.acolyer.org/2019/01/16/sagedb-a-learned-database-system/
  * http://cidrdb.org/cidr2019/papers/p117-kraska-cidr19.pdf

YugaByte DB is the open source, high-performance SQL database for building internet-scale, globally-distributed apps. https://www.yugabyte.com/ || https://github.com/YugaByte/yugabyte-db
- YugaByte DB vs CockroachDB Performance Benchmarks for Internet-Scale Transactional Workloads https://blog.yugabyte.com/yugabyte-db-vs-cockroachdb-performance-benchmarks-for-internet-scale-transactional-workloads/

Pebble: RocksDB/LevelDB inspired key-value database in Go https://github.com/cockroachdb/pebble

EdgeDB: The next generation relational database. https://github.com/edgedb/edgedb
- > EdgeDB is an open-source object-relational database built on top of PostgreSQL. The goal of EdgeDB is to empower its users to build safe and efficient software with less effort.

BadgerDB https://github.com/dgraph-io/badger
- > BadgerDB is an embeddable, persistent and fast key-value (KV) database written in pure Go. It is the underlying database for [Dgraph](), a fast, distributed graph database. It's meant to be a performant alternative to non-Go-based key-value stores like [RocksDB]().

go-memdb https://github.com/hashicorp/go-memdb
- > Provides the `memdb` package that implements a simple in-memory database built on immutable radix trees. ***The database provides `Atomicity`, `Consistency` and `Isolation` from `ACID`. Being that it is in-memory, it does not provide `durability`***. The database is instantiated with a schema that specifies the tables and indices that exist and allows transactions to be executed.
- > The database provides the following:
  * > Multi-Version Concurrency Control (`MVCC`) - By leveraging immutable radix trees the database is able to support any number of concurrent readers without locking, and allows a writer to make progress.
  * > Transaction Support - The database allows for rich transactions, in which multiple objects are inserted, updated or deleted. The transactions can span multiple tables, and are applied atomically. The database provides `atomicity` and `isolation` in `ACID` terminology, such that until commit the updates are not visible.
  * > Rich Indexing - Tables can support any number of indexes, which can be simple like a single field index, or more advanced compound field indexes. Certain types like UUID can be efficiently compressed from strings into byte indexes for reduced storage requirements.

malbrain/database https://github.com/malbrain/database  【主要原因是这老哥的 Github 主页介绍里说自己是有 50 年基础设施编程经验的程序员：`I have 50 years of experience developing programming frameworks to efficiently solve problems.` —— 所以回头看看他写的数据库什么水平。】
- > Key-Value/Document store database library with btree and ARTree indexing methods, SSN-MVCC concurrency

Hyrise is a research in-memory database. https://github.com/hyrise/hyrise || https://hpi.de/plattner/projects/hyrise.html
- > Hyrise is a research in-memory database system that has been developed [by HPI since 2009](https://www.vldb.org/pvldb/vol4/p105-grund.pdf) and has been entirely [rewritten in 2017](https://openproceedings.org/2019/conf/edbt/EDBT19_paper_152.pdf). Our goal is to provide a clean and flexible platform for research in the area of in-memory data management. Its architecture allows us, our students, and other researchers to conduct experiments around new data management concepts. To enable realistic experiments, Hyrise features comprehensive SQL support and performs powerful query plan optimizations. Well-known benchmarks, such as TPC-H or TPC-DS, can be executed with a single command and without any preparation.

rqlite -- The lightweight, distributed relational database built on SQLite https://github.com/rqlite/rqlite || https://www.philipotoole.com/tag/rqlite/
- > rqlite is an easy-to-use, lightweight, distributed relational database, which uses SQLite as its storage engine. rqlite is simple to deploy, operating it is very straightforward, and its clustering capabilities provide you with fault-tolerance and high-availability. rqlite is available for Linux, macOS, and Microsoft Windows.
