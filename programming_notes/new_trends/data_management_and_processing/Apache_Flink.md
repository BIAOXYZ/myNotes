

# Flink official

Apache Flink China https://flink-china.org/


# Flink general

sunglasses A curated list of amazingly awesome Flink and Flink ecosystem resources https://github.com/wuchong/awesome-flink
> http://awesome.flink-china.org/

Apache Flink 中文文档 https://github.com/apachecn/flink-doc-zh
> https://flink.apachecn.org

# Flink 源码相关

Apache Flink 源码分析系列，基于 git tag 1.1.2 https://github.com/danny0405/flink-source-code-analysis

# Flink 构架相关

批处理计算与流处理计算的区别是什么？ - 大数据羊说的回答 - 知乎 https://www.zhihu.com/question/313869609/answer/2398291030

# Flink others

阿里 7 亿元收购 Apache Flink 商业公司 DataArtisans https://mp.weixin.qq.com/s/MTEhwnfMAN9hCE749G_6uA
> "Flink最区别于其他流计算引擎的，其实就是状态管理。
>
> 什么是状态？例如开发一套流计算的系统或者任务做数据处理，可能经常要对数据进行统计，如Sum,Count,Min,Max,这些值是需要存储的。因为要不断更新，这些值或者变量就可以理解为一种状态。如果数据源是在读取Kafka,RocketMQ，可能要记录读取到什么位置，并记录Offset，这些Offset变量都是要计算的状态。
>
> Flink提供了内置的状态管理，可以把这些状态存储在Flink内部，而不需要把它存储在外部系统。这样做的好处是第一降低了计算引擎对外部系统的依赖以及部署，使运维更加简单；第二，对性能带来了极大的提升：如果通过外部去访问，如Redis,HBase它一定是通过网络及RPC。如果通过Flink内部去访问，它只通过自身的进程去访问这些变量。同时Flink会定期将这些状态做Checkpoint持久化，把Checkpoint存储到一个分布式的持久化系统中，比如HDFS。这样的话，当Flink的任务出现任何故障时，它都会从最近的一次Checkpoint将整个流的状态进行恢复，然后继续运行它的流处理。对用户没有任何数据上的影响。
>
> Flink是如何做到在Checkpoint恢复过程中没有任何数据的丢失和数据的冗余？来保证精准计算的？
>
> 这其中原因是Flink利用了一套非常经典的Chandy-Lamport算法，它的核心思想是把这个流计算看成一个流式的拓扑，定期从这个拓扑的头部Source点开始插入特殊的Barries，从上游开始不断的向下游广播这个Barries。每一个节点收到所有的Barries,会将State做一次Snapshot，当每个节点都做完Snapshot之后，整个拓扑就算完整的做完了一次Checkpoint。接下来不管出现任何故障，都会从最近的Checkpoint进行恢复。
>
> Flink利用这套经典的算法，保证了强一致性的语义。这也是Flink与其他无状态流计算引擎的核心区别。

Apache Flink，流计算？不仅仅是流计算！ https://mp.weixin.qq.com/s/DiE0NEoAAKkJCO7bT1djhQ

Flink RocksDB 状态后端参数调优实践 - Flink 中文社区的文章 - 知乎 https://zhuanlan.zhihu.com/p/256351671 || https://segmentfault.com/a/1190000024522233

数据库/数据仓库 https://www.jianshu.com/nb/41027753
- Flink RocksDB托管内存机制的幕后——Cache & Write Buffer Manager https://www.jianshu.com/p/47a40259a450 || https://blog.csdn.net/nazeniwaresakini/article/details/124012385

投入上百人、经历多次双11，Flink已经足够强大了吗？ https://mp.weixin.qq.com/s/inWGrQvQimniqvJTMM7rMQ
