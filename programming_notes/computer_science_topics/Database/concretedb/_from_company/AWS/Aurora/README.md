
# 官方

Amazon Aurora https://aws.amazon.com/rds/aurora/

Amazon Aurora 冉冉升起：我们是如何设计原生云关系数据库的 https://aws.amazon.com/cn/blogs/china/amazon-aurora-design-cloud-native-relational-database/

# paper

Amazon Aurora解读(SIGMOD 2017)  https://www.cnblogs.com/cchust/p/7476876.html

Aurora论文理解 https://www.jianshu.com/p/dd6aa53c3af5

Amazon Aurora 总结 https://blog.csdn.net/plm199513100/article/details/107941114

# 视频

Amazon Aurora 数据库新特性及深入探讨 https://www.bilibili.com/video/BV12Q4y1K7KL

Amazon Aurora —— 为云计算而生的关系型数据库 https://www.bilibili.com/video/BV1oE41137ie

# 其他

Amazon Aurora 深度探索 - 腾讯技术工程的文章 - 知乎 https://zhuanlan.zhihu.com/p/33603518
- > 作者简介：李海翔，腾讯金融云数据库技术专家。网名`那海蓝蓝`，熟悉PostgreSQL、MySQL、Informix等。数据库内核技术。腾讯金融云数据库技术专家。著有《数据库查询优化器的艺术》，即将出版新书《数据库事务处理的艺术》。

Amazon Aurora DSQL：具有多活高可用性的分布式 SQL 数据库 https://mp.weixin.qq.com/s/pl0QDPpNAWNPhU98XLo--Q
- > Aurora 已经通过 Global Database 提供了跨多个区域的 与 PostgreSQL 兼容的数据库，但 DSQL 背后的技术有很大不同。在 DSQL 中，两个区域都以多活模式运行，都接受写入和交叉复制数据。相比之下，Global Database 只能将数据从一个区域复制到另一个区域，并且只允许一个区域写入数据库。次级区域充当只读副本，如果需要可以提升为主区域。
- > 正如另一篇文章中解释的那样，Aurora DSQL 采用乐观并发控制 (OCC) 而不是传统的锁定方法。亚马逊云科技高级数据库专家 Rajesh Kantamani 和公司数据库专家 Prasad Matkar 写道：`由于其分布式架构，将 OCC 与 Aurora DSQL 结合使用非常合适，因为它可以避免在事务执行期间锁定资源，从而实现更高的吞吐量和系统效率。`
- > 社区中的许多人认为，亚马逊云科技的这些新产品是对兼容 PostgreSQL 的 `Neon`、`Cloudflare D1` 和 `Google Cloud Spanner` 的挑战。亚马逊的首席执行官在台上声称，通过将事务逻辑与存储层分离并以强一致性处理事务，新数据库的读写速度达到了 Spanner 的四倍。
- > Hacker News 上的反应褒贬不一，许多开发人员强调了一系列重大局限性。虽然该实现依赖于亚马逊云科技的`精确时间基础设施`——该基础设施提供了具有强错误界限的精确时钟，但一些专家认为 DSQL 是一个给开源数据库带来启发的项目。用户 Edwinr95 写道：`没有临时表、没有外键、没有视图，事务中不超过 10k 行。除了与 Postgres 协议的一些基本线路兼容性外，我很难将其称为“数据库”，而更像是一个键值存储。`
