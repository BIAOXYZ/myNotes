
# PostgreSQL

<<Postgres Changelog - All Versions>> https://bucardo.org/postgres_all_versions.html

![PostgreSQL](https://wiki.postgresql.org/images/3/30/PostgreSQL_logo.3colors.120x120.png)

A Tour of PostgreSQL Internals https://www.postgresql.org/files/developer/tour.pdf

PostgreSQL 有哪些经典入门书籍？ - 知乎 https://www.zhihu.com/question/28085660
- > PostgreSQL 有哪些经典入门书籍？ - 云大学小编的回答 - 知乎 https://www.zhihu.com/question/28085660/answer/193819026
- > PostgreSQL 有哪些经典入门书籍？ - 廖君的回答 - 知乎 https://www.zhihu.com/question/28085660/answer/60621283
  * > PostgreSQL(数据库)资料 https://github.com/ty4z2008/Qix/blob/master/pg.md
- > PostgreSQL 有哪些经典入门书籍？ - francs的回答 - 知乎 https://www.zhihu.com/question/28085660/answer/142689538
  * > 【by francs】 <<PostgreSQL 中文资料汇总>> https://github.com/francs/PostgreSQL
    >> PostgreSQL 中文资料汇总.md https://github.com/francs/PostgreSQL/blob/master/PostgreSQL%20%E4%B8%AD%E6%96%87%E8%B5%84%E6%96%99%E6%B1%87%E6%80%BB.md

给PostgreSQL爱好者的参考资料
http://blog.csdn.net/postgrechina/article/details/49132791

PostgreSQL Tutorial
http://www.postgresqltutorial.com/

--------------------------------------------------

PostgreSQL内核开发学习资料 - 王硕的文章 - 知乎 https://zhuanlan.zhihu.com/p/98021328

## PG releted blog

由社区志愿者谭峰整理的PostgreSQL资料集锦，值得收藏 http://www.postgres.cn/news/viewone/1/101

健哥的数据花园 https://www.cnblogs.com/gaojian/
- PostgreSQL索引页 http://www.cnblogs.com/gaojian/p/topindex.html

深入理解PostgreSQL https://blog.csdn.net/beiigang 或 http://beigang.iteye.com/
- PostgreSQL内核 https://blog.csdn.net/beiigang/article/category/947307
- PostgreSQL接口编程 https://blog.csdn.net/beiigang/article/category/947320
- PostgreSQL其他 https://blog.csdn.net/beiigang/article/category/947308

http://www.cnblogs.com/stephen-liu74/
- PostgreSQL学习手册(目录) http://www.cnblogs.com/stephen-liu74/archive/2012/06/08/2315679.html

PostgreSQL中文技术 http://www.pgsql.tech/
- 新手指引 http://www.pgsql.tech/doc_401
- 精品读 http://www.pgsql.tech/supreme_0
  * 对PostgreSQL中权限的理解(初学者必读) http://www.pgsql.tech/supreme_101_10000036

## PG wechat

开源软件联盟PostgreSQL分会
- PostgreSQL中的索引介绍（三） https://mp.weixin.qq.com/s/gqhSNakCeLit1YFNXKwjXw
- 原创|一文搞懂PostgreSQL物化视图 https://mp.weixin.qq.com/s/R5RhZkuOYmfIXbIS4KlIGw

## Postgres Wiki

https://wiki.postgresql.org/wiki/Main_Page
- https://wiki.postgresql.org/wiki/Development_information
  * https://wiki.postgresql.org/wiki/Todo
  * https://wiki.postgresql.org/wiki/Developer_FAQ
  * https://wiki.postgresql.org/wiki/Working_with_Git

Pgsrcstructure https://wiki.postgresql.org/wiki/Pgsrcstructure

【[:star:][`*`]】 Pgkernel https://wiki.postgresql.org/wiki/Pgkernel
- > PG源码解析项目概要
- > 内核相关项目
- > 相关资料

Bitmap Indexes https://wiki.postgresql.org/wiki/Bitmap_Indexes

## Postgres Mailing Lists

PostgreSQL Mailing Lists https://www.postgresql.org/list/
- User lists
  * pgsql-sql https://www.postgresql.org/list/pgsql-sql/
- Developer lists
  * pgsql-hackers https://www.postgresql.org/list/pgsql-hackers/
- Regional lists
  * pgsql-zh-general https://www.postgresql.org/list/pgsql-zh-general/

### 关于postgresql.auto.conf文件

<<PostgreSQL9.4: 新增 ALTER SYSTEM 命令>> by francs

http://francs3.blog.163.com/blog/static/4057672720144194492582/

### ctid

<<postgresql之ctid的浅谈>>
http://www.cnblogs.com/lottu/p/5613098.html

What is the Equivalent of ROWID in PostgreSQL? https://www.enterprisedb.com/postgres-tutorials/what-equivalent-rowid-postgresql

### pg_depend

<<PostgreSQL的依赖约束（系统表pg_depend和pg_constraint）详解>>
http://blog.csdn.net/prettyshuang/article/details/49638641

<<postgres中pg_depend表实验性分析>>
http://blog.csdn.net/yibei8811/article/details/46623253

http://www.codeweblog.com/postgresql%E7%9A%84pg_depend%E8%AF%A6%E8%A7%A3/


### vacuum

<<PostgreSQL的autovacuum 与 vacuum full>> by 技术者高健
http://www.cnblogs.com/gaojian/p/3272620.html

### information_schema & schema

<<PostgreSQL的information_schema>>
http://blog.itpub.net/22818880/viewspace-1966636/


```
select * from information_schema.tables where table_schema='public';
```
<<查询schema下面所有表>>
http://blog.csdn.net/chang1976272446/article/details/75050383


```
select * from INFORMATION_SCHEMA.role_table_grants where grantee='dwetl';
```
<<PostgreSQL的权限查询>>
https://www.cnblogs.com/xiaotengyi/p/5404733.html

<<Postgresql的Schema(模式)的出现是出于什么目的，不理解schema的具体用途？>>
https://segmentfault.com/q/1010000010303335

### xmax xmin & MVCC

对PostgreSQL xmax的理解
http://www.cnblogs.com/gaojian/p/3164792.html

SQL优化（六） MVCC PostgreSQL实现事务和多版本并发控制的精华 http://www.jasongj.com/sql/mvcc/

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

### 临时表和unlogged table

<<postgresql----TEMPORARY TABLE和UNLOGGED TABLE>>
https://www.cnblogs.com/alianbog/p/5605068.html

### GUC

<<PostgreSQL GUC 参数级别介绍>>
http://blog.csdn.net/yunqishequ1/article/details/78084592

PostgreSQL数据库配置文件之postgresql.conf全部参数详解
https://blog.csdn.net/prettyshuang/article/details/50495347


## PG SQL

PostgreSQL 动态表复制（CREATE TABLE...LIKE）
https://blog.csdn.net/wlwlwlwl015/article/details/52493197

postgreSQL常用维护命令
https://blog.csdn.net/aoerqileng/article/details/39721845

## PG存储

<<数据库系统概念笔记之存储和文件系统及PostgreSQL实现>>
http://www.postgres.cn/news/viewone/1/220

## PG日志

漫谈postgresql的日志实现机制
http://blog.csdn.net/xabc3000/article/details/7658439

【转发博文】：WAL日志文件名称格式详解 http://www.postgres.cn/news/viewone/1/96

## PG锁

PostgreSQL中的锁
http://www.postgres.cn/news/viewone/1/241



## PG BUGs

https://stackoverflow.com/questions/25071360/row-number-0-is-out-of-range-0-1-returned-when-using-setsinglerowmode-libpq

http://grokbase.com/t/postgresql/pgsql-bugs/056wfat3ar/bug-1735-row-number-1-is-out-of-range-0-1-error

## PG故障恢复

25.3. Continuous Archiving and Point-in-Time Recovery (PITR) https://www.postgresql.org/docs/9.6/continuous-archiving.html

## PG其他

https://www.ibm.com/developerworks/cn/opensource/os-postgresecurity/

Postgresql数据库的一些字符串操作函数
https://www.cnblogs.com/wuhenke/archive/2010/08/02/1790750.html


### PG工具/组件

Pgpool http://www.pgpool.net/mediawiki/index.php/Main_Page

Patroni: A Template for PostgreSQL HA with ZooKeeper, etcd or Consul https://github.com/zalando/patroni

### PG扩展

- postgresql模块——pg_stat_statements详解和安装测试 https://blog.csdn.net/lengzijian/article/details/8133471
- PostgreSQL每日一贴-pg_stat_statements工具安装使用 https://blog.csdn.net/enzesheng/article/details/42807367
```
实际上现在已经不需要手动做这些拷贝操作了
拷贝 .so 文件到数据库服务器的 XXX/lib 目录
拷贝 .control 和 .sql 文件到数据库服务器的 XXX/share/extension目录
```
- PostgreSQL之使用扩展Extension https://blog.csdn.net/pg_hgdb/article/details/79490509
- 为PostgreSQL添加插件 https://my.oschina.net/Suregogo/blog/550201

PostgreSQL 插件编写 https://blog.japinli.top/2018/12/write-postgresql-extension/
- https://github.com/japinli/fibonacci

#### Citus

微软收购Citus Data | 再次肯定对开源的承诺，并加速了Azure PostgreSQL的性能和扩展 https://mp.weixin.qq.com/s/gu4H2JNV4SIbTOGv3kDPPg

#### pgcrypto扩展实战

```
/* 编译安装PG */ 
//如果是已安装的PG数据库，前两步忽略。这种情况下要注意第三步配置正确的prefix。
1. 进入代码主目录，后续用当前目录"./"表示。执行下述语句：
./configure --prefix=/home/liuliang3/app/pgsql20 --without-zlib --enable-debug --enable-cassert --enable-thread-safety CFLAGS='-O0' --with-pgport=6920 --enable-depend
2. 接着依然在该目录执行：
make;make install

/* 编译安装pgcrypto */
3. ./configure --prefix=/home/liuliang3/app/pgsql20 
(第3步为可选，如果是一个刚装的数据库接着装扩展，由于刚配过prefix，可以省略这步;但如果是一个之前已经安装好的数据库，可能需要再配一下，不然下一步可能把扩展装到别的PG里了)
4. 进入./contrib/pgcrypto目录，执行下述语句：make;make install
(成功后会自动将pgcrypto.so拷贝到数据库服务器的XXX/lib目录，将pgcrypto.control和几个pgcrypto相关的.sql文件拷贝到数据库服务器的XXX/share/extension目录)
```

```
testdb=# create table employee (id int, name varchar, sal int);
CREATE TABLE

//test hash

testdb=# insert into employee values (1,'alice',10000);
INSERT 0 1
testdb=# select * from employee;
 id | name  |  sal
----+-------+-------
  1 | alice | 10000
(1 row)

testdb=# insert into employee values (2,digest('bob','md5'),10002);
INSERT 0 1
testdb=# select * from employee ;
 id |                name                |  sal
----+------------------------------------+-------
  1 | alice                              | 10000
  2 | \x9f9d51bc70ef21ca5c14f307980a29d8 | 10002
(2 rows)

testdb=# select digest('bob','md5');
               digest
------------------------------------
 \x9f9d51bc70ef21ca5c14f307980a29d8
(1 row)

//test encryption

testdb=# insert into employee values (3,pgp_sym_encrypt('carol', 'pwd', 'cipher-algo=bf, compress-algo=2, compress-level=9'),10003);
ERROR:  Unsupported compression algorithm
testdb=# insert into employee values (3,pgp_sym_encrypt('carol', 'pwd', 'cipher-algo=bf'),10003);
INSERT 0 1
testdb=# select * from employee ;
 id |                                                               name                                                               |  sal
----+----------------------------------------------------------------------------------------------------------------------------------+-------
  1 | alice                                                                                                                            | 10000
  2 | \x9f9d51bc70ef21ca5c14f307980a29d8                                                                                               | 10002
  3 | \xc30d04040302fd924bb772a27a0771d22e01be9e65e361e050d34dfaea618d677260013de1faf7bc969ecbd860a38c0fa5fbe2405d0d8bae5a0ff2c8254731 | 10003
(3 rows)

testdb=# select pgp_sym_decrypt('\xc30d04040302fd924bb772a27a0771d22e01be9e65e361e050d34dfaea618d677260013de1faf7bc969ecbd860a38c0fa5fbe2405d0d8bae5a0ff2c8254731','pwd');
 pgp_sym_decrypt
-----------------
 carol
(1 row)

testdb=# select pgp_sym_decrypt('\xc30d04040302fd924bb772a27a0771d22e01be9e65e361e050d34dfaea618d677260013de1faf7bc969ecbd860a38c0fa5fbe2405d0d8bae5a0ff2c8254731'::bytea,'pwd');
 pgp_sym_decrypt
-----------------
 carol
(1 row)
```

#### PG自定义函数
```
<<使用C语言写PostgreSQL函数>>
http://blog.csdn.net/bqw2008/article/details/50957507

按照上面帖子写的在PG10 beta1版本的过程为：
1. gcc -I`pg_config --includedir-server` -fPIC  -c cfunc.c
2. gcc -shared -o cfunc.so cfunc.o
3. cp cfunc.so `pg_config --libdir`
4. load cfunc.so
5. CREATE OR REPLACE FUNCTION add_one(integer) RETURNS integer AS '$libdir/cfunc', 'add_one' LANGUAGE C STRICT;

但是会报错：
postgres=# CREATE FUNCTION add_one(integer) RETURNS integer AS '$libdir/cfunc', 'add_one' LANGUAGE C STRICT;
ERROR:  could not find function information for function "add_one"
HINT:  SQL-callable functions need an accompanying PG_FUNCTION_INFO_V1(funcname).

然后查了下，在这个帖子里（https://stackoverflow.com/questions/48892087/using-c-functions-in-postresql）提到
是因为version-1的调用要用PG内部的宏来处理，从而避免复杂的细节问题。然后再查找手册（PG 9.6.0 中文版 36.9.4部分）
用version-1格式就可以了。最后再附几个例子（没有验证，不一定靠谱）。

PostgreSQL扩展函数和触发器
http://valleylord.github.io/post/201410-postgres-trigger-example/

Writing Postgres Extensions - the Basics
http://big-elephants.com/2015-10/writing-postgres-extensions-part-i/

使用C编写的动态链接库为PostgreSQL数据库添加自定义函数
http://blog.csdn.net/iihero/article/details/8218753

C 中调用 PostgreSQL 内置动态加载函数的方法
http://blog.csdn.net/davidzwb/article/details/53172453
```

#### 其他扩展/类扩展

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

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# PGXC

## pgxc官方

Postgres-XC https://wiki.postgresql.org/wiki/Postgres-XC

~~Postgres-XC https://sourceforge.net/projects/postgres-xc/~~  -->  // 从2015年开始迁移到了Github，并改名为`pgx2`，但是实际上Github上的`pgx2`在2016年末也停止开发了。

Master Postgres-XC source repository https://github.com/postgres-x2/postgres-x2
> This project used the name `Postgres-XC` originally, it is renamed to `Postges-X2` from 2015 after it was moved to Github. In many of the documents and code, we still use Postgres-XC.

<<Postgres-XC 1.1 Documentation>> http://postgres-xc.sourceforge.net/docs/1_1/index.html

## pgxc其他

<<PGXC两阶段提交与事务一致性（1）>>
http://www.cnblogs.com/databaseaffair/p/6864070.html

<<PostgreSQL-XC : Data Replication or Distribution ? >>
http://francs3.blog.163.com/blog/static/4057672720125453315201/

# PGXL

## pgxl官方

Postgres-XL https://en.wikipedia.org/wiki/Postgres-XL
> Postgres-XL is based on Postgres-XC, an earlier distributed PostgreSQL system developed by NTT Data and EnterpriseDB. In 2012, the cloud database startup StormDB adopted Postgres-XC and developed some proprietary extensions and improvements to it. In 2013, StormDB was acquired by TransLattice, and the improved software was open-sourced under the name "Postgres-XL" in 2014. Since 2015, Postgres-XL development has also been supported by 2ndQuadrant.

Postgres-XL https://www.postgres-xl.org/

Postgres-XL 10r1.1 Documentation https://www.postgres-xl.org/documentation/index.html

## pgxl其他

Postgres-XL https://www.2ndquadrant.com/en/resources/postgres-xl/

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


## PG books

Become a Postgres Expert with Free Training https://www.enterprisedb.com/free-postgres-training

<<The Internals of PostgreSQL - for database administrators and system developers>> by SUZUKI Hironobu http://www.interdb.jp/pg/

<<PostgreSQL: Introduction and Concepts >> http://momjian.us/main/writings/pgsql/aw_pgsql_book/ || http://www.banshujiang.cn/e_books/1484

Education https://postgrespro.com/education
- Postgres: The First Experience https://postgrespro.com/education/books/introbook

搬书匠 -- 数据库 -- PostgreSQL http://www.banshujiang.cn/category/database/PostgreSQL/

CS-Notes 数据库系统原理.md https://github.com/CyC2018/CS-Notes/blob/master/notes/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%B3%BB%E7%BB%9F%E5%8E%9F%E7%90%86.md

PostgreSQL 有哪些经典入门书籍？
https://www.zhihu.com/question/28085660
> https://github.com/ty4z2008/Qix/blob/master/pg.md
> PostgreSQL数据库从入门到精通 - 阿里云大学 https://edu.aliyun.com/course/52

PostgreSQL 9 Administration Cookbook http://download.chekiang.info/blog/PostgreSQL-9-Admin-Cookbook.pdf

PostgreSQL修炼之道 - 从小工到专家 http://www.gaofi.cn/book/detail/892

PostgreSQL Server Programming http://pdf.th7.cn/down/files/1312/PostgreSQL%20Server%20Programming.pdf


### PG待整理？

<<对PostgreSQL中 pg_各表的RelationId的认识>> by 健哥的数据花园
http://www.cnblogs.com/gaojian/p/3169560.html

<<PostgreSQL建表动作分析>> by 健哥的数据花园
http://www.cnblogs.com/gaojian/archive/2013/07/05/3171433.html

<<>>
http://beigang.iteye.com/blog/1680797

http://momjian.us/main/blogs/pgblog.html

http://momjian.us/main/writings/pgsql/aw_pgsql_book/


PostgreSQL mailing lists Unsubscribe https://lists.postgresql.org/unsubscribe/
> gmail退订pg的mailing list还略麻烦，不过参考这页就行。


stolon -- PostgreSQL cloud native High Availability and more. https://github.com/sorintlab/stolon

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

