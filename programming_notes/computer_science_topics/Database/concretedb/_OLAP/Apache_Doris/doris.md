
# 新闻

Apache Doris 创始人：何为“现代化”的数据仓库？ https://mp.weixin.qq.com/s/cMeyuOskrrRn5MPvDFcmDQ

# 文章

MPP 是什么？以 Doris 为例 https://www.ihnfsa.com/database/mpp-in-doris/
- > 实验室的 OLAP 项目被砍，不知之后是否还有机会再学习 OLAP。我会把这段时间看到的资料整理出来，第一篇就讲讲 MPP 以及分布式优化。本文主要来源于 Doris 在 B 站开设的[课程](https://space.bilibili.com/362350065/channel/collectiondetail?sid=296007)的第四讲和第八讲，该课程是了解 Doris 非常好的资料。
- > **MPP 在 Doris 中的应用**
  * > **Doris 的 share-nothing 架构**
  * > **MPP 架构中的查询流程**
    + > 为了实现并行查询，HASH JOIN 所在的 fragment 2 会有多个实例分别在不同节点执行。扫表所在节点与 HASH JOIN 所在节点间的数据传输由 DataStreamSink 和 Exchange 算子负责。
    + > 例如，join 条件为 tbl1.k1 = tbl2.k1，则 fragment 0 中的 DataStreamSink 算子计算元组中 k1 的哈希值，作为接收方的 ID。这样一来，哈希值相同的元组被传输到同一节点继续做 HASH JOIN。
    + > ***MapReduce 也包含类似过程，我们统一称为 Shuffle 操作***。
  * > **分布式查询优化**
- > **MPP vs. 批处理**
  * > **MPP 的缺陷**
    + > MPP 数据库为了高吞吐量和低时延，牺牲了并发性能和可扩展性。***有资料显示，<ins>对比当前的 MPP 系统和 Spark 这类系统（相同的硬件环境），Spark 普遍比 MPP 慢 3 到 5 倍</ins>。50 个节点的 MPP 集群，性能和 250 的节点的 Spark 集群性能相当，<ins>但是 Spark 集群规模可以超过 250 个节点，MPP 做不到</ins>***。
- > 存算分离？
  * > 存算分离架构的优点是计算集群和存储集群可独立地弹性扩展。***显然，传统 MPP 和批处理系统都不适应这样的要求。MPP 数据库存算耦合，而批处理系统不得不通过计算和存储部署在同一物理集群拉近计算与数据的距离，仅在同一集群下构成逻辑存算分离***。
  * > 国外的 Snowflake, Databricks 实现了存算完全分离，它们是如何做到的？又是如何保障高并发要求和高性能要求的呢？这里我挖一个坑，希望未来能谈一下这些产品的存算分离架构。
- > 参考资料
  * > Apache Doris 源码阅读与解析系列直播——第四讲 一条SQL的执行过程 https://www.bilibili.com/video/BV1Kr4y117SC/
  * > Apache Doris 源码阅读与解析系列直播—— 第八讲 查询优化器详解 https://www.bilibili.com/video/BV1Lr4y1Q7Ho/
- 合集·《Apache Doris 源码阅读与解析》 系列直播 https://space.bilibili.com/362350065/channel/collectiondetail?sid=296007
