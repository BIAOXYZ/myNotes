
HBase vs. MongoDB vs. MySQL vs. Oracle vs. Redis，三大主流开源 NoSQL 数据库的 PK 两大主流传统 SQL 数据库 
http://blog.csdn.net/defonds/article/details/48471087

“王者对战”之 MySQL 8 vs PostgreSQL 10 - MySQL - cnBeta.COM https://www.cnbeta.com/articles/tech/737331.htm
- Why Uber Engineering Switched from Postgres to MySQL https://eng.uber.com/mysql-migration/
- MySQL Might Be Right for Uber, but Not for You https://dzone.com/articles/on-ubers-choice-of-databases
- A PostgreSQL Response to Uber http://thebuild.com/presentations/uber-perconalive-2017.pdf

主流云数仓性能对比分析 https://mp.weixin.qq.com/s/uZtBaECX1FU7K39El5Tx-Q

吊打 MySQL，MariaDB 到底强在哪？ https://mp.weixin.qq.com/s/kVns-BHGTK-ms1Gh5P8lAg

SQLite 的读写效率很高，有哪些使用其他数据库的理由？ - 知乎 https://www.zhihu.com/question/31417262

TPC B/C/H Benchmark for PostgreSQL https://github.com/Vonng/pgtpc
- > Figures, Numbers, Benchmarks about how fast can PostgreSQL go!
  * > `pgbench`： Meaure PostgreSQL performence on different hardwares.
  * > `sysbench`：Compare PostgreSQL performence with MySQL & other databases
  * > tpc-h：Measure PostgreSQL Analysis performence and compare to other AP systems

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

PostgreSQL 与 MySQL 相比，优势何在？ - 知乎 https://www.zhihu.com/question/20010554

千万量级数据：
- MYSQL - 算一算1000万条数据大概占了多大磁盘空间 https://blog.csdn.net/u010235716/article/details/86629756
- 千万级数据下的Mysql优化 https://blog.csdn.net/shmnh/article/details/80753279
- PostgreSQL 如何潇洒的处理每天上百TB的数据增量 https://developer.aliyun.com/article/8528 || https://www.modb.pro/db/93340

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
