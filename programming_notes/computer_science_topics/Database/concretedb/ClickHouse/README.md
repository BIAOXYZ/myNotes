
# 官方

ClickHouse® is a free analytics DBMS for big data https://github.com/ClickHouse/ClickHouse
- `ClickHouse/utils/antlr/README.md` https://github.com/ClickHouse/ClickHouse/blob/master/utils/antlr/README.md
  * https://github.com/ClickHouse/ClickHouse/blob/master/utils/antlr/ClickHouseParser.g4
  * https://github.com/ClickHouse/ClickHouse/blob/master/utils/antlr/ClickHouseLexer.g4
- https://github.com/ClickHouse/ClickHouse/blob/master/src/Parsers/ParserQuery.cpp
- https://github.com/ClickHouse/ClickHouse/blob/master/src/Parsers/ParserSelectQuery.cpp

SQL参考 https://clickhouse.com/docs/zh/sql-reference/
- 条件函数 https://clickhouse.com/docs/zh/sql-reference/functions/conditional-functions/
- ORDER BY https://clickhouse.com/docs/zh/sql-reference/statements/select/order-by/
- 操作符 https://clickhouse.com/docs/zh/sql-reference/operators/
- Window Functions https://clickhouse.com/docs/zh/sql-reference/window-functions/
- JSON函数 https://clickhouse.com/docs/zh/sql-reference/functions/json-functions/
- quantile https://clickhouse.com/docs/zh/sql-reference/aggregate-functions/reference/quantile/

# Parser

How to parse a Clickhouse-SQL statement using ANTRL4? https://stackoverflow.com/questions/68687065/how-to-parse-a-clickhouse-sql-statement-using-antrl4

ClickHouse SQL formal grammar or parser implementation #7595 https://github.com/ClickHouse/ClickHouse/issues/7595

# 其他

ClickHouse原理解析与应用实战 https://mp.weixin.qq.com/s/Lz0KNr_hNrHfPNuIF69dng  【[:star:][`*`] 其实是因为文中的图片解释`数据压缩`和`向量化执行`比较好，才记录一下。跟 ClickHouse 本身的关系反而不大。】
- > ◆ 数据压缩的本质
  * > 基于列式存储的结构，同一列中的数据属于同一类型，压缩效果会更加显著。列存储往有着高达十倍甚至更高的压缩比，节省了大量的存储空间，降低了存储成本。 ![](https://mmbiz.qpic.cn/mmbiz_png/RQueXibgo0KNZM3R4Dt7sNcwe0xTGV3sMGayMcjia1LpEhY8q8CxAX2RlJCbtVL9sdoFxRDgiaiaPeot5qiaY65nu3w/640)
- > ◆ 向量化执行引擎
  * > SIMD（Single Instruction Multiple Data）即单条指令操作多条数据，它是通过数据并行以提高性能的一种方式，可以简单理解为在寄存器层面对程序中的数据做并行处理，Clickhouse 在能够提升计算效率的地方大量使用了 SIMD，通过使用 SIMD，基本上能带来几倍的性能提升，像阿里云的 PolarDB-X 也引入了向量化执行引擎，为表达式计算带来了几十倍的性能提升。 ![](https://mmbiz.qpic.cn/mmbiz_png/RQueXibgo0KNZM3R4Dt7sNcwe0xTGV3sMianiciaX3R8EnYRyPC6pcj4ibiaCTz37sg4Nr3wuwicWTIibJmBAGk04driaHA/640)

漫谈SIMD、SSE指令集与ClickHouse向量化执行 https://www.jianshu.com/p/c36f4e142b8a
- > **前言**
  * > ClickHouse之所以会像闪电一样快（"blazing fast"），是多方面优化的结果，包括且不限于：高效且磁盘友好的列式存储，高效的数据压缩，精心设计的各类索引，并行分布式查询，运行时代码生成等。
  * > 另外，ClickHouse为了最大限度地压榨硬件——尤其是CPU——的性能，实现了**向量化查询执行**（vectorized query execution）机制。这个名词相对于上面的那些可能没那么平易近人，但它毫无疑问是CK相对于传统OLAP引擎的大杀器。鉴于现有资料中讲解CK向量化执行的内容很少，本文就来试图探究一下，先从基础知识SIMD说起。
- > **SIMD**
- > **SSE指令集**
- > **ClickHouse向量化执行示例**

ClickHouse学习系列之六【访问权限和账户管理】 https://www.cnblogs.com/zhoujinyi/p/14931219.html

Clickhouse基础知识 https://blog.csdn.net/Yanxu_Jin/article/details/108829848

Clickhouse错误问题汇总（持续更新） https://blog.csdn.net/xsm666/article/details/117929952
- > **code 62，Max query size exceeded：Select语句中使用in方式查询报错**
  * > 解决方案：这其实是因为查询语句特别的大造成的(我的in()里面有5万多个id号)，而默认的max_query_size最大是256 KiB。打开/etc/clickhouse-server/user.d/newuser.xml(我新建的自己的newuser.xml配置文件),也可以是其他的users.xml，其中有两个部分，一部分是profiles和quotas。profiles保存了用户的配置，quotas保存了用户的配额。配额使您可以限制一段时间内的资源使用，或仅跟踪资源的使用。像max_query_size这种配置，就需要在profiles部分中配置。
  * > 注意这里的单位是bytes(字节),我这里设置了102410241024=1,073,741,824,就解决问题了
  * > 参考：
    + > https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_query_size

云数据库 ClickHouse https://www.aliyun.com/product/clickhouse
- > 云数据库ClickHouse 是分布式实时分析型列式数据库服务。具有高性能、开箱即用、企业特性支持。广泛应用于流量分析、广告营销分析、行为分析、人群划分、***客户画像***、敏捷BI、数据集市、网络监控、分布式服务和链路监控等业务场景。

Clickhouse建表语法、视图语法、数据表DDL（数据定义语言）、数据DML（数据操作语言） https://www.cnblogs.com/biehongli/p/14430153.html
- > 2、Clickhouse数据表的定义语法，是在标准SQL的基础之上建立的。Clickhouse目前提供了三种最基本的建表方法，但是注意的是在Clickhouse中建表一定要指定表的引擎，在指定数据表字段之后，最后一定要指定数据表的引擎。

# 缺点

没想到 clickhouse 这么牛逼，比 es 强太多了，搞 quant 适合吗 https://www.v2ex.com/t/865427
- > clickhouse 和 es 的应用场景不同啊大哥
- > 并发不行把
- > 模拟 30 个用户一起聚合查询就能看出问题了，感觉做业务的话 CH 不适合直查，用物化视图输出聚合报表方便些
- > ch 不支持更新哦
  >> replacemergingtree 相当于更新了，不过是异步的
  >>> insert 走 maxversion 其实也可。
- > 
  ```console
  1. ck 对硬件有要求;内存要求高;
  2. 集群副本的话数据量太大 zk 又是一个炸弹; (推荐单节点 zk;)
  3. qps 不会很高;
  4. 不支持事务;不支持更新删除;(虽然有 update 和 delete 的 dml, 但是这个 ck 离线处理的;)
  但是做 olap 报表分析确实不错;
  ```
- > clickhouse 我直接限制 5 用户登录，单连接查询最大 100G 内存，百亿 10 多秒就能汇聚好
- > 一直有个疑问。。。clickhouse 的简称到底是 ck 还是 ch 比较好？ 好像这两种都有很多人用
  >> https://clickhouse.com/docs/en/faq/general/dbms-naming/
- > 我们公司日志系统从 es 换到了 ck ，感觉查询语法更丰富，性能更强。估计每天就得上百 tb 的日志数据。
- > 上周测试环境 zk 炸了连带 ck 全崩了，重建数据搞得怀疑人生
