
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

ClickHouse原理解析与应用实战 https://mp.weixin.qq.com/s/Lz0KNr_hNrHfPNuIF69dng  【其实是因为文中的图片解释`数据压缩`和`向量化执行`比较好，才记录一下。跟 ClickHouse 本身的关系反而不大。】
- > ◆ 数据压缩的本质
  * > 基于列式存储的结构，同一列中的数据属于同一类型，压缩效果会更加显著。列存储往有着高达十倍甚至更高的压缩比，节省了大量的存储空间，降低了存储成本。 ![](https://mmbiz.qpic.cn/mmbiz_png/RQueXibgo0KNZM3R4Dt7sNcwe0xTGV3sMGayMcjia1LpEhY8q8CxAX2RlJCbtVL9sdoFxRDgiaiaPeot5qiaY65nu3w/640)
- > ◆ 向量化执行引擎
  * > SIMD（Single Instruction Multiple Data）即单条指令操作多条数据，它是通过数据并行以提高性能的一种方式，可以简单理解为在寄存器层面对程序中的数据做并行处理，Clickhouse 在能够提升计算效率的地方大量使用了 SIMD，通过使用 SIMD，基本上能带来几倍的性能提升，像阿里云的 PolarDB-X 也引入了向量化执行引擎，为表达式计算带来了几十倍的性能提升。 ![](https://mmbiz.qpic.cn/mmbiz_png/RQueXibgo0KNZM3R4Dt7sNcwe0xTGV3sMianiciaX3R8EnYRyPC6pcj4ibiaCTz37sg4Nr3wuwicWTIibJmBAGk04driaHA/640)

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
