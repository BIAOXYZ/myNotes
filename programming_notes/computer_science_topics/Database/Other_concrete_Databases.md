
# Redis

深入学习 Redis（5）：集群 https://mp.weixin.qq.com/s/oDllfcVc5_ekIFP66kRP9w
> 来源：编程迷思 www.cnblogs.com/kismetv/p/9853040.html

😮 互联网 Java 工程师进阶知识完全扫盲 https://github.com/doocs/advanced-java {其实java的东西就占了一部分，主要是数据库分布式之类的。。。}
- 项目中缓存是如何使用的？为什么要用缓存？缓存使用不当会造成什么后果？ https://github.com/doocs/advanced-java/blob/master/docs/high-concurrency/why-cache.md
- redis 和 memcached 有什么区别？redis 的线程模型是什么？为什么 redis 单线程却能支撑高并发？ https://github.com/doocs/advanced-java/blob/master/docs/high-concurrency/redis-single-thread-model.md

# [MongoDB](https://www.mongodb.com/)

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

- http://leveldb.org/
- https://github.com/google/leveldb

LevelDB详解 - CSDN博客 https://blog.csdn.net/linuxheik/article/details/52768223

浅析Bigtable和LevelDB的实现 https://draveness.me/bigtable-leveldb


# [RocksDB](https://rocksdb.org/)

- https://rocksdb.org/
- https://github.com/facebook/rocksdb/

# [MyRocks](http://myrocks.io/)

MyRocks及其使用场景分析 - 温正湖的文章 - 知乎 https://zhuanlan.zhihu.com/p/45652076

# druid × 2

## 阿里druid 

阿里巴巴数据库事业部出品，为监控而生的数据库连接池。阿里云Data Lake Analytics(https://www.aliyun.com/product/datalakeanalytics )、DRDS、TDDL 连接池powered by Druid https://github.com/alibaba/druid/wiki || https://github.com/alibaba/druid

## Apache Druid

### Druid official

Apache Druid (Incubating) - Column oriented distributed data store ideal for powering interactive applications https://github.com/apache/incubator-druid/

Apache Druid (incubating) is a high performance real-time analytics database. http://druid.io/
- What is Druid? http://druid.io/docs/latest/design/index.html
- Powered by Druid http://druid.io/druid-powered.html
  * A Tour Through the "Big Data" Zoo https://imply.io/post/big-data-zoo 

Druid是一个快速的列式分布式数据存储。 http://druidio.cn/
- Druid Blog http://druidio.cn/blog/

### Druid paper

Druid: A Real-time Analytical Data Store http://static.druid.io/docs/druid.pdf

Paper Review: Druid: A Real-time Analytical Data Store https://xduan7.com/2016/03/23/paper-review-druid-a-real-time-analytical-data-store/

- Druid:A Real-time Analytical Data Store（上篇） https://www.jianshu.com/p/94309502540d
- Druid:A Real-time Analytical Data Store（下篇） https://www.jianshu.com/p/4731e9677a08

Learning about the Druid Architecture https://medium.com/paper-readings/learning-about-the-druid-architecture-d033e1203879

What Makes Apache Druid Great for Realtime Analytics? https://codeburst.io/what-makes-apache-druid-great-for-realtime-analytics-61f817ee5ff6

### Druid others

Apache Druid https://en.wikipedia.org/wiki/Apache_Druid

Druid 是什么 https://www.cnblogs.com/broadview/p/6423673.html
> Druid 开源后，受到不少互联网公司的青睐，包括雅虎、eBay、阿里巴巴等，其中雅虎的Committer 有5 个，谷歌有1 个，阿里巴巴有1 个。最近，MetaMarkets 之前几个Druid 发明人也成立了一家叫作Imply.io 的新公司，推动Druid 生态的发展，致力于Druid 的繁荣和应用。
>> Real-time analytics powered by Apache Druid https://imply.io/

A Comparison of Time Series Databases and Netsil’s Use of Druid https://blog.netsil.com/a-comparison-of-time-series-databases-and-netsils-use-of-druid-db805d471206

- System Properties Comparison Druid vs. Neo4j https://db-engines.com/en/system/Druid%3BNeo4j
- System Properties Comparison Druid vs. GraphDB https://db-engines.com/en/system/Druid%3BGraphDB
- System Properties Comparison Amazon Redshift vs. Druid vs. Graph Engine https://db-engines.com/en/system/Amazon+Redshift%3BDruid%3BGraph+Engine
- System Properties Comparison Druid vs. InfluxDB https://db-engines.com/en/system/Druid%3BInfluxDB

Scuba: Diving into Data at Facebook https://research.fb.com/publications/scuba-diving-into-data-at-facebook/

Druid系列基本概念 https://note.yuchaoshui.com/blog/post/yuziyue/Druid-basic-concept

### Druid实际使用相关

基于druid数据库来搭建数据分析平台的踩坑实践 - Yi Wang的文章 - 知乎 https://zhuanlan.zhihu.com/p/47026566

Druid 与知乎数据分析平台 - rainer的文章 - 知乎 https://zhuanlan.zhihu.com/p/48046671

Druid Quickstart https://blog.liexing.me/2016/03/28/druid-quickstart/

Druid调研 http://bigdatadecode.club/Druid%E8%B0%83%E7%A0%94.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# not full-fledged DBs

Fast, Distributed Graph DB https://dgraph.io https://github.com/dgraph-io/dgraph

SQLite compiled to JavaScript through Emscripten https://github.com/kripken/sql.js
> Emscripten: An LLVM-to-JavaScript Compiler https://github.com/kripken/emscripten

重磅！谷歌等推出基于机器学习的数据库SageDB https://mp.weixin.qq.com/s/8Twe3e3WKCY9pTiNtnW2sg
- SageDB: a learned database system 
  * https://blog.acolyer.org/2019/01/16/sagedb-a-learned-database-system/
  * http://cidrdb.org/cidr2019/papers/p117-kraska-cidr19.pdf

YugaByte DB is the open source, high-performance SQL database for building internet-scale, globally-distributed apps. https://www.yugabyte.com/ || https://github.com/YugaByte/yugabyte-db
- YugaByte DB vs CockroachDB Performance Benchmarks for Internet-Scale Transactional Workloads https://blog.yugabyte.com/yugabyte-db-vs-cockroachdb-performance-benchmarks-for-internet-scale-transactional-workloads/


