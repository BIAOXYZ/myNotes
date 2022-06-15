
# [RocksDB](https://rocksdb.org/)

https://rocksdb.org/

RocksDB: A Persistent Key-Value Store for Flash and RAM Storage https://github.com/facebook/rocksdb/

Welcome to RocksDB https://github.com/facebook/rocksdb/wiki
- > Features Not in LevelDB https://github.com/facebook/rocksdb/wiki/Features-Not-in-LevelDB

RocksDB https://en.wikipedia.org/wiki/RocksDB

# RocksDB 原理/源码

布隆过滤器（Bloom Filter）在MyRocks中的使用分析 - 温正湖的文章 - 知乎 https://zhuanlan.zhihu.com/p/89687002

RocksDB零基础学习(五)  SSTable（Sorted Sequence Table） - Lavender的文章 - 知乎 https://zhuanlan.zhihu.com/p/165399524

RocksDB 写入流程详解 - 张友东的文章 - 知乎 https://zhuanlan.zhihu.com/p/33389807

# 性能

为什么从LevelDB切换到RocksDB？ https://fisco-bcos-documentation.readthedocs.io/zh_CN/v2.8.0/docs/articles/3_features/33_storage/why_switch_to_rocksdb.html || https://www.fisco.com.cn/class_32/349.html
- > 在RocksDB的官方wiki上有一个页面叫做 ***`Features Not in LevelDB`***，这个页面中描述了RocksDB中所有新增的功能，例如对列族的支持，允许我们在逻辑上对数据库分区，对backup和checkpoint的支持，支持备份到HDFS，两种compaction方式允许用户在读放大、写放大、空间放大之间取舍，自带统计模块便于调优，支持了ZSTD等更新的压缩算法等。
- > 官方wiki中也提到RocksDB为提升性能所做的优化，包括多线程Compaction、多线程memtable插入、降低DB锁的持有时间、写锁的优化、跳表搜索时更少的比较操作等。官方文档中指出，在插入key是有序的场景下，RocksDB使用多线程Compaction，使得RocksDB的性能大幅度高于LevelDB。
- > FISCO BCOS使用RocksDB时只使用了默认参数和与LevelDB兼容的读写接口，并没有做进一步的参数调优，RocksDB在官方文档中有指出，默认参数已经可以达到很好的性能，更进一步的调参并不能带来大幅的性能提升，而用户的业务场景是多种多样的，针对业务场景优化的参数修改对于FISCO BCOS不一定合适。日后，随着对RocksDB的深入了解，如果发现更优的参数设置，我们也会采用。

rocksdb和leveldb性能比较——写性能 https://blog.51cto.com/u_15127503/4069398

# 其他

【from `CockroachDB`】
- Why we built CockroachDB on top of RocksDB https://www.cockroachlabs.com/blog/cockroachdb-on-rocksd/
- Introducing Pebble: A RocksDB Inspired Key-Value Store Written in Go https://www.cockroachlabs.com/blog/pebble-rocksdb-kv-store/

LevelDB vs. RocksDB https://www.modb.pro/db/323288
