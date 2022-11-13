
# 官方

52.22. pg_extension https://www.postgresql.org/docs/14/catalog-pg-extension.html
- > The catalog pg_extension stores information about the installed extensions. See [Section 38.17](https://www.postgresql.org/docs/14/extend-extensions.html) for details about extensions.

52.22. pg_extension http://www.postgres.cn/docs/14/catalog-pg-extension.html
- > 目录pg_extension存储有关已安装扩展的信息。有关扩展的细节请参见[第 38.17 节](http://www.postgres.cn/docs/14/extend-extensions.html)。

Extensions https://wiki.postgresql.org/wiki/Extensions

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# pg插件网站

PGXN: PostgreSQL Extension Network https://pgxn.org/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他类似数据库

## gp

pg_extension https://gpdb.docs.pivotal.io/6-20/ref_guide/system_catalogs/pg_extension.html
- > The system catalog table pg_extension stores information about installed extensions.

pg_extension https://gp-docs-cn.github.io/docs/ref_guide/system_catalogs/pg_extension.html
- > 该系统目录表 pg_extension 存储了关于安装的扩展的信息。

## opengauss

PG_EXTENSION https://opengauss.org/zh/docs/2.0.0/docs/Developerguide/PG_EXTENSION.html
- > PG_EXTENSION系统表存储关于所安装扩展的信息。openGauss默认有2个扩展，即PLPGSQL和MOT_FDW。

PG_EXTENSION https://support.huaweicloud.com/devg-opengauss/opengauss_devg_0765.html
- > PG_EXTENSION系统表存储关于所安装扩展的信息。GaussDB(for openGauss)默认有14个扩展，即PLPGSQL、DIST_FDW、FILE_FDW、HDFS_FDW 、LOG_FDW、GC_FDW、PACKAGES、ROACH_API、STREAMING、TSDB、HSTORE、DIMSEARCH、GSREDISTRIBUTE和SECURITY_PLUGIN。

## CockroachDB
>> //notes：奇怪，我记得小强数据库主要是要兼容MySQL的啊。。。

pg_extension https://www.cockroachlabs.com/docs/stable/pg-extension.html

## YugabyteDB

PostgreSQL extensions https://docs.yugabyte.com/preview/explore/ysql-language-features/pg-extensions/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 文章

pg_extension https://pgpedia.info/p/pg_extension.html
- > pg_extension was added in PostgreSQL 9.1.
- > psql command
  * > `\dx` lists the available extensions
  * > `\dx+` lists all objects in each extension.

未来数据库方向 - PostgreSQL 有价值的插件、可改进功能、开放接口 (202005) https://github.com/digoal/blog/blob/master/202005/20200527_06.md || https://www.modb.pro/db/25598

PostgreSQL 最常用的插件 https://github.com/digoal/blog/blob/master/202009/20200915_01.md

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

PostgreSQL 插件编写 https://blog.japinli.top/2018/12/write-postgresql-extension/
- https://github.com/japinli/fibonacci

Template project for building PostgreSQL extensions https://github.com/mkindahl/pg_extension

PostgreSQL之使用扩展Extension https://blog.csdn.net/pg_hgdb/article/details/79490509

为PostgreSQL添加插件 https://my.oschina.net/Suregogo/blog/550201

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 待分类扩展

【from Hironobu Suzuki】
- pg_plan_inspector https://github.com/s-hironobu/pg_plan_inspector
- pg_median https://github.com/s-hironobu/pg_median

Pigsty —— 图形化PostgreSQL环境 （Pigsty -- PostgreSQL in Graphic Style） https://github.com/Vonng/pigsty

bg_mon: Background worker for monitoring PostgreSQL https://github.com/CyberDem0n/bg_mon

aqo: Adaptive query optimization for PostgreSQL https://github.com/postgrespro/aqo

pg_flame: A flamegraph generator for Postgres EXPLAIN ANALYZE output. https://github.com/mgartner/pg_flame

PgHero: A performance dashboard for Postgres https://github.com/ankane/pghero

pg_query_state: Tool for query progress monitoring in PostgreSQL https://github.com/postgrespro/pg_query_state

【[:start:][`*`]】 pg_query_go https://github.com/pganalyze/pg_query_go
- > Go version of [pganalyze/pg_query](https://pganalyze.com/blog/parse-postgresql-queries-in-ruby)
- > This Go library and its cgo extension use the actual PostgreSQL server source to parse SQL queries and return the internal PostgreSQL parse tree.
- > You can find further background to why a query's parse tree is useful here: pganalyze.com/blog/parse-postgresql-queries-in-ruby.html

PgSQL · 特性分析 · Plan Hint http://mysql.taobao.org/monthly/2016/01/09/

PostgreSQL SQL HINT的使用(pg_hint_plan) https://billtian.github.io/digoal.blog/2016/02/03/01.html

PostgresML https://github.com/postgresml/postgresml

pgAudit -- Open Source PostgreSQL Audit Logging https://github.com/pgaudit/pgaudit

Wasmer Postgres https://github.com/wasmerio/wasmer-postgres
- > A complete and mature WebAssembly runtime for Postgres based on [Wasmer](https://wasmer.io/). It's an original way to extend your favorite database capabilities.
