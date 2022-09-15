
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
- 回复里的：
  * > 官方的maillist和git commit记录也是学习pg功能设计，掌握内核开发的重要途径吧，只是很多人没兴趣好好翻一下git记录，毕竟英文劝退。另外阿里也有postgresql的数据库内核月报，也很有深度。2ndQuadrant的blog可以看看。C语言有一定基础后我选择《深入理解计算机系统》

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

### PG cursor (游标)

WITH HOLD CURSORS AND TRANSACTIONS IN POSTGRESQL https://www.cybertec-postgresql.com/en/with-hold-cursors-and-transactions-in-postgresql/
- > **Cursors in PostgreSQL**
  * > When a query is ready for execution, PostgreSQL creates a `portal` from which the result rows can be fetched. During normal query execution, you receive the whole result set in one step. In contrast, a cursor allows you to fetch the result rows one by one. A cursor marks a position within a result set. Cursors are particularly useful in procedural code on the client or in the database, because they allow you to loop through the query results. Another advantage is that a cursor allows you to have more than one SQL statement running at the same time, which is normally not possible in a single database session.

介绍PostgreSQL游标(Cursor) https://blog.csdn.net/neweastsun/article/details/90645200
- > **概述**
  * > PostgreSQL游标可以封装查询并对其中每一行记录进行单独处理。当我们想对大量结果集进行分批处理时可以使用游标，因为一次性处理可能造成内存溢出。
  * > 另外我们可以定义函数返回游标类型变量，这是函数返回大数据集的有效方式，函数调用者根据返回游标对结果进行处理。

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

一文搞懂PostgreSQL中所有的锁 https://www.modb.pro/db/70021

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
- Postgres Operator https://github.com/zalando/postgres-operator

### PG扩展

#### Citus

微软收购Citus Data | 再次肯定对开源的承诺，并加速了Azure PostgreSQL的性能和扩展 https://mp.weixin.qq.com/s/gu4H2JNV4SIbTOGv3kDPPg

v11.0 (Jun 2022) https://www.citusdata.com/updates/v11-0/
- > Citus is now fully open source!

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

PostgreSQL好书推荐 https://mp.weixin.qq.com/s/-dqSiJWCMVAYaQZUX0MW6Q
- > 另外postgrespro于最近出了一本书《PostgreSQL 14 Internals》， https://edu.postgrespro.com/postgresql_internals-14_parts1-2_en.pdf
  >> PostgreSQL 14 Internals https://postgrespro.com/community/books/internals

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

