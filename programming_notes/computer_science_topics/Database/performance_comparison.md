
HBase vs. MongoDB vs. MySQL vs. Oracle vs. Redis，三大主流开源 NoSQL 数据库的 PK 两大主流传统 SQL 数据库 
http://blog.csdn.net/defonds/article/details/48471087

主流云数仓性能对比分析 https://mp.weixin.qq.com/s/uZtBaECX1FU7K39El5Tx-Q

SQLite 的读写效率很高，有哪些使用其他数据库的理由？ - 知乎 https://www.zhihu.com/question/31417262

TPC B/C/H Benchmark for PostgreSQL https://github.com/Vonng/pgtpc
- > Figures, Numbers, Benchmarks about how fast can PostgreSQL go!
  * > `pgbench`： Meaure PostgreSQL performence on different hardwares.
  * > `sysbench`：Compare PostgreSQL performence with MySQL & other databases
  * > tpc-h：Measure PostgreSQL Analysis performence and compare to other AP systems

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# MySQL、MariaDB

吊打 MySQL，MariaDB 到底强在哪？ https://mp.weixin.qq.com/s/kVns-BHGTK-ms1Gh5P8lAg

~~MySQL 单机 QPS 是多少？ https://www.v2ex.com/t/983276~~  【//已转移】

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# MySQL v.s. PG

MySQL和PostgreSQL在多表连接算法上的差异 https://mp.weixin.qq.com/s/6cYy3lWwpxV4b08Hdb593A
- > 我们知道mysql没有hash join，也没有merge join，所以在连接的时候只有一种算法nest loop join，nl join使用驱动表的结果集作为外表到内表中查找每一条记录，如果有索引，就会走索引扫描，没有索引就会全表扫。
- > nl join并不能适用所有场景，例如两个表都是很大的表的等值连接，这种场景是hash join所擅长的，而且是生产环境中最常见的场景。mysql在这个时候就显得力不从心，所以在使用mysql时我们可能会制定如下规范：禁止使用大表连接。这也是mysql永远的痛。不过据说8.0版本已经将hash join作为一个需求纳入了，我们拭目以待吧。
- > 相比起来，postgresql的优化器十分的强劲。支持了hash join、nest loop、sort merge join，扫描算法支持seq scan、index scan、index only scan，同时还支持堆内元组技术（HOT）。在postgresql11版本中还加入了并行扫描，亲测在两张大表（一张1.6亿一张256万数据，均无索引）做join结果集300多万，pg开启并行大概20s以内就跑出结果，强于其他数据库。

MySQL和PostgreSQL的自增序列探讨 https://mp.weixin.qq.com/s/5V5nYaYawnGlY0onIvp-ww

牧云踏歌 https://space.bilibili.com/24370353
- MySQL 8.0.22 vs PostgreSQL 13.1 https://github.com/aruis/mysql_vs_postgresql
- 单表数据破亿，MySQL vs PostgreSQL！ https://www.bilibili.com/video/BV1sU4y14741
  * > 版本号：MySQL 8.0.22 vs PostgreSQL 13.1  <br>  第二期：https://www.bilibili.com/video/BV1mf4y1k7mb/  <br>  能力有限，如有疏漏还请评论指正。如果关注的人多的话，后续再详细对比一下；）
- PostgreSQL 吊打 MySQL 的一些不严谨测试 https://www.bilibili.com/video/BV1mf4y1k7mb/
  * > 第一期：https://www.bilibili.com/video/BV1sU4y14741/  <br>  这次标题起得有点找喷，不过我也想不到其它词语来描述了。只能说数据上亿后，mysql不太能打。并且mysql组合索引限制太多，给程序员增加额外负担，相比起来pg优势明显。至于最后的聚合函数加条件，当然也可以用笨方法写出来，但是论优雅，pg应该是极致的写法了。

2021年了，你真的应该考虑PostgreSQL了（1） https://www.bilibili.com/read/cv9329286 || https://www.modb.pro/db/66794
- > 往后的事，有意思也很多，但是限于篇幅，咱们不能一直扯。这里就讲一点，估计也是大家最为关心的一点，既然PG历史这么悠久，如果它真的如宣传所说，这么强的话，为什么现在大家都在用MySQL而不是PG呢？
- > 说实话，这个问题，同样困扰了我很久，我也向一些前辈请教过，至今也没有权威的答案。这里就谈谈我自己的思路，两个原因：
  * > PG支持Windows太晚了。有多晚呢？直到2005年，才原生支持Windows，2005年啊，比PG支持SQL晚了十年，比互联网在中国兴起，繁荣，泡沫戳破也晚了好几年。想想最重要的2000年前后，多少懵懂的站长都在使用Windows，PG错过了Windows就错过了最重要的一批在互联网上尝到甜头的人，从此一步错步步错（这个“错”不是“错误”的意思，而是“错过”的意思）。
  * > LAMP的崛起，继续将PG边缘化。现在很少有人提LAMP这个缩写了，最早它是Linux/Apache/MySQL/PHP的意思。我第一次听到这个缩写是08年，那年我还在读大二。可以想象一下这个缩写有多火，连一个大二的学生都听过，而且那年我还无数次的给同学们安利这套技术，因为它看起来真的很时髦。而直到我参加工作的几年后，才第一次听说PG，等在项目中正式使用PG，已是2015年之后的事了。（一不小心，又是十年）

千万量级数据：
- MYSQL - 算一算1000万条数据大概占了多大磁盘空间 https://blog.csdn.net/u010235716/article/details/86629756
- 千万级数据下的Mysql优化 https://blog.csdn.net/shmnh/article/details/80753279
- PostgreSQL 如何潇洒的处理每天上百TB的数据增量 https://developer.aliyun.com/article/8528 || https://www.modb.pro/db/93340

MariaDB 市值暴跌，收入不足以支持运营 https://www.v2ex.com/t/934297
- > PG 的写入效率实在没法让人拒绝， https://www.liuquanhao.com/posts/postgresql-14-vs-mariadb-10.6-vs-mysql-8-benchmark/

寻求个反内卷的分布式/集群数据库 https://www.v2ex.com/t/948360
- > 我们测过 pg 的性能，相同配置的实例，在某些统计上比 mysql 快很多，但是一般的查询并没有比 mysql 快很多，甚至有些还慢，所以最终也没有用 pg 替换 MySQL 。 <br> lz 的需求，也是我们目前碰到的，并没有太好的办法。只能建立 Hadoop 数仓，实时导数据进去，然后定期删除 MySQL 的历史数据。
  >> 当然，原理上也不可能性能差很多啊。。。很多 pg 的索引其实都利用不上，我觉得适合是因为分布式和楼主需要数据库。普通用户用 mysql 就行，有 OLAP ，物理视图，想要时序数据库，存 json ，又怕麻烦，就可以选择 PG 。 <br> pg 跑 a 股历史分钟级数据应该没啥问题。DuckDB 线性回归预测股价的例子 https://github.com/digoal/blog/blob/master/202209/20220902_01.md <br> 选 PG 主要是有 https://github.com/digoal/blog

MySQL & PostgreSQL 终极大比拼 https://www.bilibili.com/video/BV1qG411m7Tg
- 回复里的：
  * > 专业。mysql很好，但是pg太优秀，我只说一个pg比较接地气的小优点，varchar不用指定长度，而且比指定长度更节省空间。

“王者对战”之 MySQL 8 vs PostgreSQL 10 - MySQL - cnBeta.COM https://www.cnbeta.com/articles/tech/737331.htm
- Why Uber Engineering Switched from Postgres to MySQL https://eng.uber.com/mysql-migration/
- MySQL Might Be Right for Uber, but Not for You https://dzone.com/articles/on-ubers-choice-of-databases
- A PostgreSQL Response to Uber http://thebuild.com/presentations/uber-perconalive-2017.pdf

## 非性能对比

postgresql也很强大，为何在中国大陆，mysql成为主流，postgresql屈居二线呢？ - 知乎 https://www.zhihu.com/question/31955622 || 为何在国内MySQL成为主流，PG只能屈居二线？ https://mp.weixin.qq.com/s/_3pE0gTVgpOX7JXxYXArDg
- postgresql也很强大，为何在中国大陆，mysql成为主流，postgresql屈居二线呢？ - 大宽宽的回答 - 知乎 https://www.zhihu.com/question/31955622/answer/1625152059

PostgreSQL 与 MySQL 相比，优势何在？ - 知乎 https://www.zhihu.com/question/20010554

Postgres 在中国还能起来么？ https://www.v2ex.com/t/1010986
- > 这是 aws 里面对比 pg 和 mysql 的文章。 https://aws.amazon.com/cn/compare/the-difference-between-mysql-vs-postgresql/ <br> 然后对于 pg 和 mysql 来说，我在部分场景下，有发现老版本的 mysql 不严谨的地方，比如说数据类型太多，pg 的数据类型很单一很明确，减少了混淆的可能。例如 pg 的 text 和 mysql 的各种 text 的区别。。 <br> 再就是数据库字符集的问题，pg 默认是 utf8 ，mysql 里面的则需要自己改成 utf8 ，而且 utf8 还分了好几个类别。。。
  >> `utf8mb4` hahhahahah

过来人说说， postgresql 和 mysql 究竟怎么选 https://www.v2ex.com/t/1109357
- > 看业务，如果未来业务对 json 需求高的可以上 pg ，如果不高就 mysql 又成熟又稳 <br> 以基础框架为例，优先适配、测试用例覆盖更全的也是 mysql ，找库也好找些
- > 那么必须是扩展有几百个的 pg 啊。装一个扩展，就变身了！！！
- > mysql 的时序支持度不如 pgsql ，所以 pgsql 完爆 mysql
- > sql server 2000 转 pg 8 后从没用过其它数据库，pg 实在太省心了
- > 秒选 postgres ，信创的东西都是 postgres 翻版
  >> 也不全是，oceanbase 不是吧，虽然是分布式， 但是符合信创，且兼容 mysql 的程序 ：）
- > PG 原生支持 全文搜索, 数据统计物化视图洗数据, AI 支持空间数据'向量数据,中文分词,免费,大量的开源扩展.
- > 我用的 pg ，如果要让我重新选的话，我肯定会用 mysql 。***因为 pg 占用内存太高了，买机器都要多花点钱***。
- > 这里有个类似的讨论 https://www.reddit.com/r/node/comments/rv6u8u/why_do_you_choose_mysql_over_postgres/
- > 没人说 pg 的 sql 语句更严格吗 需要把 groupby 后面的字段都出现在 select 子句里 <br> mysql 我一直以来都把 sql_mode 设为空
- > 我在国内的时候如果自建几乎都是 MySQL ，来了硅谷发现他们都用 Postgres （以上均不分大厂小厂），我也不是很理解……
  >> 因为国内 mysql 的 DBA 多，好招人
- > ***之前在 12306  互联网层用的是 MySQL  客票底层用的是 PG***
- > 能说说为什么国产信创大多用 pg 吗？
  >> 因为国内有 HighGo 啊
  >>> pg 的源码写的好，易读易修改
  >>>> 许可证不同，基于 MySQL 做二开对外发布，理论上是需要开放所有源代码的（如果要脸的话），PG 的许可证宽松很多，二开后允许闭源
- > pg，用过 pg+citus 你就懂了，处理大数据分片很方便，也不需要额外引入一个 TiDB 。处理 GIS 又有 PostGIS ，各种空间几何运算，很方便。
- > 必须 MySQL , pg 和 mysql 占有率不是一个量级的
- > pg ，说实话 my 会死锁这个设计始终非常弱智，但是 pg 的 vacuum 有时候有写入性能和占用空间的坑，上个透明压缩会好很多。
- > ***讲一个事情，500w 级别的表数据，三表联查，pg 毫无压力，mysql cpu,内存打满，响应是六七倍的耗时***。。。
- > 有足够技术自信 、 有用到 pg 特性而 mysql 没有的、对性能有要求的， 三者符合一个选 pg ，其余情况用 mysql
- > 我们项目中用到了 pg 做归档，好几年了，我翻代码从来没有触碰过这一块，所以稳定性上还是不错的。坐等大佬发言，学习下

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# SQLite v.s. DuckDB

DuckDB Profiling 1: vs SQLite3.md https://github.com/jtommaney/blog/blob/blog/posts/DuckDB%20Profiling%201%3A%20%20vs%20SQLite3.md

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# TPC

## tpcc

TPC-C https://www.tpc.org/tpcc/

where to find TPC-C queries https://dba.stackexchange.com/questions/142188/where-to-find-tpc-c-queries
```console
As I'm aware of, TPC-H only has 22 queries which could be easily found here http://www.qdpma.com/tpch/TPCH100_Query_plans.html 
and here https://github.com/hortonworks/hive-testbench/tree/hive14/sample-queries-tpch.

I was wondering if it's the same case for TPC-C benchmark. Does it also have a fixed number of distinct queries and where could I find them? I just 
have a specific task in which I need to measure the performance of each query and I thought both TPC-H and TPC-C queries are good references. Thanks!
```
- https://dba.stackexchange.com/questions/142188/where-to-find-tpc-c-queries/143982#143982
  * > TPC-C contains a fixed number of ***`transactions`, not `queries`***. They are described in `Clause 2` of http://www.tpc.org/tpc_documents_current_versions/pdf/tpc-c_v5.11.0.pdf. Sample implementations including SQL are in `Appendix A`.

如何对 TiDB 进行 TPC-C 测试 https://docs.pingcap.com/zh/tidb/v3.0/benchmark-tidb-using-tpcc

## TPCH

TPC-H Vesion 2 and Version 3 https://www.tpc.org/tpch/
- > Over the past few years the industry has seen increases in performance and decreases in costs of computer and database systems. <br> The TPC is introducing V3.0 of the TPC-H Benchmark to accommodate these trends and maintain the relevance of the Price/Performance metric. <br> The primary change in this major revision is to adjust the Price/Performance metric by a multiplier of 1,000.
- > The results shown for TPC-H V3 contain results that were converted from TPC-H V2 to the new specification.

TPC-H表结构与22条查询SQL语句介绍 - 大数据研学社的文章 - 知乎 https://zhuanlan.zhihu.com/p/458228811

## TPC-DS

TPC-DS https://www.tpc.org/tpcds/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
