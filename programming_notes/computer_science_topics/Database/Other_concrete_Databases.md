
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


# not full-fledged DBs

Fast, Distributed Graph DB https://dgraph.io https://github.com/dgraph-io/dgraph

SQLite compiled to JavaScript through Emscripten https://github.com/kripken/sql.js
> Emscripten: An LLVM-to-JavaScript Compiler https://github.com/kripken/emscripten

重磅！谷歌等推出基于机器学习的数据库SageDB https://mp.weixin.qq.com/s/8Twe3e3WKCY9pTiNtnW2sg
- SageDB: a learned database system 
  * https://blog.acolyer.org/2019/01/16/sagedb-a-learned-database-system/
  * http://cidrdb.org/cidr2019/papers/p117-kraska-cidr19.pdf


