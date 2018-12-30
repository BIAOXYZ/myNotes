

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
