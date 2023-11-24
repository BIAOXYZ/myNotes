
<<Postgres Changelog - All Versions>> https://bucardo.org/postgres_all_versions.html

# postgresql 16 release notes

PostgreSQL国际社区授予PG 16版本贡献者荣誉奖章 https://mp.weixin.qq.com/s/_O7FI-O7JKlN-Piss6yLsw

请不要固步自封，升级到 PostgreSQL 16 的 7 大理由！ https://www.modb.pro/db/1702125315795537920
- > 1.生命周期
  * > PostgreSQL 16 是第三十个发行版本，您可以找到它的发布说明。 https://www.postgresql.org/about/news/postgresql-16-released-2715/
- > 5.详细的I/O诊断信息，方便DBA甩锅
  * > PostgreSQL 16引入了一个非常重要的 I/O 统计视图 `pg_stat_io`，`pg_stat_io视图`对I/O的统计粒度比较细，分为三个大的标签维度：进程类型(backend_type字段)、关系类型(object字段)、操作上下文类型(context字段) ，以及如下八个指标维度：
    ```
    reads/read_time：读操作及花费的时间
    writes/write_time：写操作及花费的时间
    writebacks/writeback_time：请求操作系统内核持久化回写存储的次数及时间开销
    extends/extend_time：表数据文件空间不够而扩块的次数及花费的时间
    hits：命中shared buffers数据块的次数
    evictions：从shared buffers或local buffer未找到可保留的数据块而必须淘汰置换一个数据块的次数
    reuses：在bulkread、bulkwrite、vacuum操作类型上重用环形缓冲区的次数
    fsyncs/fsync_time：fsync系统调用的次数及花费的时间(只统计normal context)
    ```
  * > 从上面三个大的维度以及八个细粒度的指标，可以从数据库侧清晰地看到I/O详情。例如观测到I/O写压力是由数据大量写入而对表数据文件扩块引起，这是正常行为。如果是由刷盘写入引起，则可以进行参数调优。
- > 7.`SQL:2023`新标准，PostgreSQL比商业数据库支持更全面
  * > PostgreSQL 16对最新的`SQL标准2023`新增了如下支持：
    + > ANY_VALUE
      - > PostgreSQL 16实现的 `any_value函数` 可以在 select 列表包含非聚合列而不会影响 group by 的正常行为，否则会出现如下错误提示。
        ```console
        ERROR: column "XXX" must appear in the GROUP BY clause or be used in an aggregate function
        ```
      - > `any_value函数`不仅提供了查询的便利性，***而且只从每个分组获取一个值***，降低了计算成本，也提升了性能。

PostgreSQL16新特性解读 https://mp.weixin.qq.com/s/Jniz0016bxbzRwhxSgeIbw

PostgreSQL 16发布，原来华人贡献者有这么多！ https://mp.weixin.qq.com/s/YAW4fwDSIn3e6RsRwe1VDQ

PostgreSQL 16 正式登场，拓数派代码贡献揭示中国顶尖技术实力 https://mp.weixin.qq.com/s/k4vUMesCTjJ4CM-vgBZFxg
- > 本次发布，拓数派团队以其卓越的技术实力和专业精神，在这 33 位贡献者中占据了 5 个席位，这五位贡献者分别为：

## 16.1

PostgreSQL 16.1, 15.5, 14.10, 13.13, 12.17, and 11.22 Released! https://www.postgresql.org/about/news/postgresql-161-155-1410-1313-1217-and-1122-released-2749/
