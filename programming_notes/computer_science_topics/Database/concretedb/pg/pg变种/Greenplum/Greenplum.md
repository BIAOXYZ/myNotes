
学习分布式事务一致性？这几个重点别忘划 https://mp.weixin.qq.com/s/OTdLnxaoXqs6xtwxkrSiIQ

Greenplum 6.0： 从 OLAP 到 HTAP https://mp.weixin.qq.com/s/Z1MBsqMBZM0UI8dNAgZaxg
- > Greenplum 创立于2003年（ https://en.wikipedia.org/wiki/Greenplum ），第一款产品发布于2005年，当时产品名字叫Bizgres，2008年改名为 Greenplum。2015年10月份正式以 Apache 协议开源（ https://github.com/greenplum-db/gpdb )。经过16年的发展，Greenplum 成为全球知名的大规模并行处理（MPP）无共享架构（Shared Nothing）数据库。Greenplum 传统的业务场景为数据仓库、OLAP（OnLine Analytical Processing）和即席（ad-hoc）查询。Gartner 2019年评测报告中 Greenplum 在这一领域位于 Teradata 和 Oracle 之后，世界排名第三。
- > HTAP 一词最早由 Gartner 于2014年左右 ( https://www.zdnet.com/article/what-is-hybrid-transactionanalytical-processing-htap/ )提出。Forrester 也提出了类似的概念，称为 Translytical 。其主要思想是避免传统OLTP和OLAP分离的架构，而采用混合 OLTP + OLAP 的架构。
( https://www.forrester.com/report/Emerging+Technology+Translytical+Databases+Deliver+Analytics+At+The+Speed+Of+Transactions/-/E-RES116487 )
- > 作为一款主打 OLAP 和数据分析的数据库，过去十几年来 Greenplum 团队一直以分析型查询作为主要优化对象。近年来随着 PostgreSQL 内核的升级（Greenplum 6.0 搭载 PostgreSQL 9.4 内核，Master 分支目前是 PostgreSQL 9.6内核）和客户对 OLTP 型查询需求的提升， 6.0 开发周期中投入部分精力，对OLTP型查询进行了优化。总体看起来效果非常不错。这儿有一个完整的带有评测环境（基于GCP，可验证）和步骤的评测结果（ https://greenplum.cn/2019/05/14/greenplum-6-oltp-60x/ ），感兴趣者可以参考。摘录主要结果如下：
  ```
  TPCB:             4,500 tps
  SELECT:         80,000 tps
  INSERT:          18,000 tps
  Update:           7,000 tps
  ```
- > 这个性能可以满足很多 OLTP 的业务场景。当然 Greenplum HTAP 的现阶段目标不是处理极致的 OLTP 场景，而是希望达到单个 PostgreSQL 的能力，根据该评测，目前 Greenplum 6.0 和单节点的 PostgreSQL 的OLTP能力在同一个数量级上。

Greenplum ：基于 PostgreSQL 的分布式数据库内核揭秘 (上篇) https://www.infoq.cn/article/3ij7l8hvr2mxhqaqi2ra
