
# 官方

starrocks https://github.com/StarRocks/starrocks

# 文章

StarRocks vs Doris，是否青出于蓝胜于蓝？浅析StarRocks功能改进 - 中启乘数科技（杭州）有限公司的文章 - 知乎 https://zhuanlan.zhihu.com/p/702254375
- > Apache Doris最初是百度为解决凤巢统计报表的专用系统而开发的。随着百度业务的快速发展，它逐渐承担起更多内部业务的统计报表和多维分析需求。由于其在大数据处理方面的卓越表现，Apache Doris最终贡献给了Apache软件基金会，成为开源社区的一员。
- > 2020年2月，百度Doris团队的部分成员离职创业，他们基于Apache Doris开发了一款商业化闭源产品，命名为`DorisDB`。这就是`StarRocks`的前身，后面因为涉及到版权问题，最终改名为StarRocks。
- > **StarRocks功能改进**
  * > **存算分离架构**
  * > **数据分布**
  * > **行列混存表**
    + > StarRocks默认按照列存的方式存储数据，相比与按行存储的方式，可以大大提高复杂查询的性能。在v3.2.3之后，StarRocks支持了行列混存的表存储格式，会自动创建一个额外的`__row`列存储二进制的行数据，额外占用部分存储空间。在保留原有列存的高效分析能力的同时，***还可以支撑基于主键的高并发，低延时点查，以及数据部分列更新等场景***。
  * > **数据压缩**
    + > StarRocks 支持四种数据压缩算法：`LZ4`、Zstandard（或 `zstd`）、`zlib` 和 `Snappy`。
    + > 对于7.4G的裸数据，各自压缩的大小如下所示，可以看到，在这个数据集中四个压缩算法的压缩率排名为：`zlib > zstd > Snappy > LZ4`
- > **性能测试**
  * > **TPCH性能测试**
