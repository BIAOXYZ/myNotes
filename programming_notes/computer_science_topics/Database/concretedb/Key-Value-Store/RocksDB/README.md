
# [RocksDB](https://rocksdb.org/)

https://rocksdb.org/
- Getting started http://rocksdb.org/docs/getting-started.html

RocksDB: A Persistent Key-Value Store for Flash and RAM Storage https://github.com/facebook/rocksdb/

Welcome to RocksDB https://github.com/facebook/rocksdb/wiki
- > Features Not in LevelDB https://github.com/facebook/rocksdb/wiki/Features-Not-in-LevelDB

RocksDB https://en.wikipedia.org/wiki/RocksDB

# RocksDB 原理/源码

布隆过滤器（Bloom Filter）在MyRocks中的使用分析 - 温正湖的文章 - 知乎 https://zhuanlan.zhihu.com/p/89687002

RocksDB零基础学习(五)  SSTable（Sorted Sequence Table） - Lavender的文章 - 知乎 https://zhuanlan.zhihu.com/p/165399524

RocksDB 写入流程详解 - 张友东的文章 - 知乎 https://zhuanlan.zhihu.com/p/33389807

RocksDB 简介 https://docs.pingcap.com/zh/tidb/dev/rocksdb-overview
- > **RocksDB 简介**
  * > RocksDB 是由 Facebook 基于 LevelDB 开发的一款提供键值存储与读写功能的 LSM-tree 架构引擎。用户写入的键值对会先写入磁盘上的 WAL (Write Ahead Log)，然后再写入内存中的跳表（SkipList，这部分结构又被称作 MemTable）。***LSM-tree 引擎由于将用户的随机修改（插入）转化为了对 WAL 文件的顺序写，因此具有比 B 树类存储引擎更高的写吞吐***。
  * > 内存中的数据达到一定阈值后，会刷到磁盘上生成 SST 文件 (Sorted String Table)，SST 又分为多层（***默认至多 6 层***），每一层的数据达到一定阈值后会挑选一部分 SST 合并到下一层，***每一层的数据是上一层的 10 倍（因此 90% 的数据存储在最后一层）***。
  * > RocksDB 允许用户创建多个 `ColumnFamily` ，这些 `ColumnFamily` ***各自拥有独立的内存跳表以及 SST 文件，但是共享同一个 WAL 文件***，这样的好处是可以根据应用特点为不同的 `ColumnFamily` 选择不同的配置，但是又没有增加对 WAL 的写次数。
- > **RocksDB 的内存占用**
  * > 为了提高读取性能以及减少对磁盘的读取，RocksDB 将存储在磁盘上的文件都按照一定大小切分成 block（默认是 64KB），读取 block 时先去内存中的 BlockCache 中查看该块数据是否存在，存在的话则可以直接从内存中读取而不必访问磁盘。
  * > BlockCache 按照 LRU 算法淘汰低频访问的数据，TiKV 默认将系统总内存大小的 45% 用于 BlockCache，用户也可以自行修改 storage.block-cache.capacity 配置设置为合适的值，但是不建议超过系统总内存的 60%。
  * > 写入 RocksDB 中的数据会写入 MemTable，当一个 MemTable 的大小超过 128MB 时，会切换到一个新的 MemTable 来提供写入。TiKV 中一共有 2 个 RocksDB 实例，合计 4 个 ColumnFamily，每个 ColumnFamily 的单个 MemTable 大小限制是 128MB，最多允许 5 个 MemTable 存在，否则会阻塞前台写入，因此这部分占用的内存最多为 4 x 5 x 128MB = 2.5GB。这部分占用内存较少，不建议用户自行更改。
- > **WriteStall**
  * > RocksDB 的 L0 与其他层不同，L0 的各个 SST 是按照生成顺序排列，各个 SST 之间的 key 范围存在重叠，因此查询的时候必须依次查询 L0 中的每一个 SST。为了不影响查询性能，当 L0 中的文件数量过多时，会触发 WriteStall 阻塞写入。

# 性能

为什么从LevelDB切换到RocksDB？ https://fisco-bcos-documentation.readthedocs.io/zh_CN/v2.8.0/docs/articles/3_features/33_storage/why_switch_to_rocksdb.html || https://www.fisco.com.cn/class_32/349.html
- > 在RocksDB的官方wiki上有一个页面叫做 ***`Features Not in LevelDB`***，这个页面中描述了RocksDB中所有新增的功能，例如对列族的支持，允许我们在逻辑上对数据库分区，对backup和checkpoint的支持，支持备份到HDFS，两种compaction方式允许用户在读放大、写放大、空间放大之间取舍，自带统计模块便于调优，支持了ZSTD等更新的压缩算法等。
- > 官方wiki中也提到RocksDB为提升性能所做的优化，包括多线程Compaction、多线程memtable插入、降低DB锁的持有时间、写锁的优化、跳表搜索时更少的比较操作等。官方文档中指出，在插入key是有序的场景下，RocksDB使用多线程Compaction，使得RocksDB的性能大幅度高于LevelDB。
- > FISCO BCOS使用RocksDB时只使用了默认参数和与LevelDB兼容的读写接口，并没有做进一步的参数调优，RocksDB在官方文档中有指出，默认参数已经可以达到很好的性能，更进一步的调参并不能带来大幅的性能提升，而用户的业务场景是多种多样的，针对业务场景优化的参数修改对于FISCO BCOS不一定合适。日后，随着对RocksDB的深入了解，如果发现更优的参数设置，我们也会采用。

rocksdb和leveldb性能比较——写性能 https://blog.51cto.com/u_15127503/4069398

rocksdb随机读性能如何？ - 知乎 https://www.zhihu.com/question/263550123

# ~~HDFS支持（放弃吧）~~
- `rocksdb/hdfs/` https://github.com/facebook/rocksdb/tree/master/hdfs
- `rocksdb/HISTORY.md` https://github.com/facebook/rocksdb/blob/main/HISTORY.md
  * > Remove HDFS support from main repo.

# 其他

【from `CockroachDB`】
- Why we built CockroachDB on top of RocksDB https://www.cockroachlabs.com/blog/cockroachdb-on-rocksd/
- Introducing Pebble: A RocksDB Inspired Key-Value Store Written in Go https://www.cockroachlabs.com/blog/pebble-rocksdb-kv-store/

RocksDB Is Eating the Database World https://rockset.com/blog/rocksdb-is-eating-the-database-world/

LevelDB vs. RocksDB https://www.modb.pro/db/323288

有哪些数据库用的了RocksDB，有哪些优劣势？ - 知乎 https://www.zhihu.com/question/533045476

HBase和Leveldb、Rocksdb有哪些异同,并做了哪些提升？ - jameswhale的回答 - 知乎 https://www.zhihu.com/question/351366744/answer/862704911

RocksDB 相关资料 https://xie.infoq.cn/article/202df2fa5f9002acd114aa06f
