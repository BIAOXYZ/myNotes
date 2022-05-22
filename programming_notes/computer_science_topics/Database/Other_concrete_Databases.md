
Database of Databases
- LevelDB https://dbdb.io/db/leveldb

# Redis

深入学习 Redis（5）：集群 https://mp.weixin.qq.com/s/oDllfcVc5_ekIFP66kRP9w
> 来源：编程迷思 www.cnblogs.com/kismetv/p/9853040.html

😮 互联网 Java 工程师进阶知识完全扫盲 https://github.com/doocs/advanced-java {其实java的东西就占了一部分，主要是数据库分布式之类的。。。}
- 项目中缓存是如何使用的？为什么要用缓存？缓存使用不当会造成什么后果？ https://github.com/doocs/advanced-java/blob/master/docs/high-concurrency/why-cache.md
- redis 和 memcached 有什么区别？redis 的线程模型是什么？为什么 redis 单线程却能支撑高并发？ https://github.com/doocs/advanced-java/blob/master/docs/high-concurrency/redis-single-thread-model.md

【from draveness】:
- Redis 和 I/O 多路复用 https://draveness.me/redis-io-multiplexing
- Redis 中的事件循环 https://draveness.me/redis-eventloop
- Redis 是如何处理命令的（客户端） https://draveness.me/redis-cli

万字总结Redis知识点 https://mp.weixin.qq.com/s/uIdJN67CCD5GUvCCBZIwpw

redis7.0 中文注释 https://github.com/CN-annotation-team/redis7.0-chinese-annotated

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

# [LevelDB](http://leveldb.org/)

- http://leveldb.org/  //官网都砍了。。。
- https://github.com/google/leveldb

LevelDB key/value database in Go. https://github.com/syndtr/goleveldb

LevelDB详解 - CSDN博客 https://blog.csdn.net/linuxheik/article/details/52768223

【from draveness】:
- 浅析Bigtable和LevelDB的实现 https://draveness.me/bigtable-leveldb

深入浅出LevelDB https://mrcroxx.github.io/categories/%E6%B7%B1%E5%85%A5%E6%B5%85%E5%87%BAleveldb/
- 深入浅出LevelDB —— 01 Architecture https://mrcroxx.github.io/posts/code-reading/leveldb-made-simple/1-architecture/
- 深入浅出LevelDB —— 10 Read & Write https://mrcroxx.github.io/posts/code-reading/leveldb-made-simple/10-read-write/

# [RocksDB](https://rocksdb.org/)

- https://rocksdb.org/
- https://github.com/facebook/rocksdb/

【from `CockroachDB`】
- Why we built CockroachDB on top of RocksDB https://www.cockroachlabs.com/blog/cockroachdb-on-rocksd/
- Introducing Pebble: A RocksDB Inspired Key-Value Store Written in Go https://www.cockroachlabs.com/blog/pebble-rocksdb-kv-store/

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
