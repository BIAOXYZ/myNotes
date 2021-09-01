
HBase vs. MongoDB vs. MySQL vs. Oracle vs. Redis，三大主流开源 NoSQL 数据库的 PK 两大主流传统 SQL 数据库 
http://blog.csdn.net/defonds/article/details/48471087

“王者对战”之 MySQL 8 vs PostgreSQL 10 - MySQL - cnBeta.COM https://www.cnbeta.com/articles/tech/737331.htm
- Why Uber Engineering Switched from Postgres to MySQL https://eng.uber.com/mysql-migration/
- MySQL Might Be Right for Uber, but Not for You https://dzone.com/articles/on-ubers-choice-of-databases
- A PostgreSQL Response to Uber http://thebuild.com/presentations/uber-perconalive-2017.pdf

主流云数仓性能对比分析 https://mp.weixin.qq.com/s/uZtBaECX1FU7K39El5Tx-Q

吊打 MySQL，MariaDB 到底强在哪？ https://mp.weixin.qq.com/s/kVns-BHGTK-ms1Gh5P8lAg

# MySQL v.s. PG

MySQL和PostgreSQL在多表连接算法上的差异 https://mp.weixin.qq.com/s/6cYy3lWwpxV4b08Hdb593A
- > 我们知道mysql没有hash join，也没有merge join，所以在连接的时候只有一种算法nest loop join，nl join使用驱动表的结果集作为外表到内表中查找每一条记录，如果有索引，就会走索引扫描，没有索引就会全表扫。
- > nl join并不能适用所有场景，例如两个表都是很大的表的等值连接，这种场景是hash join所擅长的，而且是生产环境中最常见的场景。mysql在这个时候就显得力不从心，所以在使用mysql时我们可能会制定如下规范：禁止使用大表连接。这也是mysql永远的痛。不过据说8.0版本已经将hash join作为一个需求纳入了，我们拭目以待吧。
- > 相比起来，postgresql的优化器十分的强劲。支持了hash join、nest loop、sort merge join，扫描算法支持seq scan、index scan、index only scan，同时还支持堆内元组技术（HOT）。在postgresql11版本中还加入了并行扫描，亲测在两张大表（一张1.6亿一张256万数据，均无索引）做join结果集300多万，pg开启并行大概20s以内就跑出结果，强于其他数据库。

MySQL和PostgreSQL的自增序列探讨 https://mp.weixin.qq.com/s/5V5nYaYawnGlY0onIvp-ww
