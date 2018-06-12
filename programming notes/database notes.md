
# PostgreSQL

![PostgreSQL](https://wiki.postgresql.org/images/3/30/PostgreSQL_logo.3colors.120x120.png)

PostgreSQL(数据库)资料
https://github.com/ty4z2008/Qix/blob/master/pg.md

<<PostgreSQL 中文资料汇总>>
https://github.com/francs/PostgreSQL

给PostgreSQL爱好者的参考资料
http://blog.csdn.net/postgrechina/article/details/49132791

PostgreSQL Tutorial
http://www.postgresqltutorial.com/

<<Postgres Changelog - All Versions>>
https://bucardo.org/postgres_all_versions.html


## pgcon and pgcon China

### PGCon (https://www.pgcon.org/)

#### PGCon 2012 (http://www.pgcon.org/2012/)

WAL Internals Of PostgreSQL
http://www.pgcon.org/2012/schedule/events/408.en.html

#### PGCon 2016 (http://www.pgcon.org/2016/)

Index Internals http://www.pgcon.org/2016/schedule/events/934.en.html

#### PGCon 2017 (http://www.pgcon.org/2017/)

Pgcrypto avast!
http://www.pgcon.org/2017/schedule/events/1029.en.html

Logical Replication in PostgreSQL 10
http://www.pgcon.org/2017/schedule/events/1077.en.html

### PGconChina

https://wiki.postgresql.org/wiki/Pgconchina2011

数据库多版本实现内幕 
http://www.postgres.cn/downfiles/pg2016conf_day2_s1_pm3.pdf

###  PGConf APAC

http://2018.pgconfapac.org/


### Postgres Wiki

https://wiki.postgresql.org/wiki/Developer_FAQ

Pgsrcstructure
https://wiki.postgresql.org/wiki/Pgsrcstructure

Pgkernel
https://wiki.postgresql.org/wiki/Pgkernel


### 关于postgresql.auto.conf文件

<<PostgreSQL9.4: 新增 ALTER SYSTEM 命令>> by francs

http://francs3.blog.163.com/blog/static/4057672720144194492582/

### ctid

<<postgresql之ctid的浅谈>>
http://www.cnblogs.com/lottu/p/5613098.html


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

### xmax xmin

对PostgreSQL xmax的理解
http://www.cnblogs.com/gaojian/p/3164792.html


# PG代码

https://doxygen.postgresql.org/snapbuild_8c.html

https://doxygen.postgresql.org/reloptions_8c_source.html

<postgres /src/include/access/reloptions.h>
https://searchcode.com/codesearch/view/5324466/

----------------------------------------------------------------------------------------------------

跟我一起读postgresql源码(一)——psql命令
http://www.cnblogs.com/flying-tiger/p/6004314.html

<<跟我一起读postgresql源码(二)——Parser(查询分析模块)>>
http://blog.csdn.net/zdy0_2004/article/details/53106260

<<PG 内存上下文>>
http://www.zhangxiaojian.name/pg-%E5%86%85%E5%AD%98%E4%B8%8A%E4%B8%8B%E6%96%87/

postgresql源码阅读快速上手
http://blog.csdn.net/postgres20/article/details/53354330

PostgreSQL执行引擎简介
http://www.leehao.org/postgresql-executioneng/

postgres 源码分析 之 insert (1)
http://blog.csdn.net/huguangshanse00/article/details/37045847




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

## PG锁

PostgreSQL中的锁
http://www.postgres.cn/news/viewone/1/241




## PG BUGs

https://stackoverflow.com/questions/25071360/row-number-0-is-out-of-range-0-1-returned-when-using-setsinglerowmode-libpq

http://grokbase.com/t/postgresql/pgsql-bugs/056wfat3ar/bug-1735-row-number-1-is-out-of-range-0-1-error

## PG其他

https://www.ibm.com/developerworks/cn/opensource/os-postgresecurity/

Postgresql数据库的一些字符串操作函数
https://www.cnblogs.com/wuhenke/archive/2010/08/02/1790750.html


### PG扩展

- postgresql模块——pg_stat_statements详解和安装测试
https://blog.csdn.net/lengzijian/article/details/8133471
- PostgreSQL每日一贴-pg_stat_statements工具安装使用
https://blog.csdn.net/enzesheng/article/details/42807367
```
实际上现在已经不需要手动做这些拷贝操作了
拷贝 .so 文件到数据库服务器的 XXX/lib 目录
拷贝 .control 和 .sql 文件到数据库服务器的 XXX/share/extension目录
```
- PostgreSQL之使用扩展Extension
https://blog.csdn.net/pg_hgdb/article/details/79490509
- 为PostgreSQL添加插件
https://my.oschina.net/Suregogo/blog/550201

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


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:




# PGXC

<<PGXC两阶段提交与事务一致性（1）>>
http://www.cnblogs.com/databaseaffair/p/6864070.html

<<Postgres-XC 1.1 Documentation>>
http://postgres-xc.sourceforge.net/docs/1_1/index.html

<<PostgreSQL-XC : Data Replication or Distribution ? >>
http://francs3.blog.163.com/blog/static/4057672720125453315201/



:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# Oracle

<<oracle数据库，表空间和表之间是什么关系？>>
http://bbs.csdn.net/topics/320169443

>在sqlserver2000(不好意思,本人只用过2000)服务运行后,里面可以有好几个数据库(包括temp,pubs什么的)
我们可以自己建库和这些并列,一个库可以有好几个不同的数据文件,可以放在不同的驱动器里面,然后在库里面建表,根据我个人的理解,谁建的表关系不大,反正都在这个库里面

>而oracle就不同了,他一个服务就是一个库,库下面是表空间,一个表空间可以有几个不同的数据文件,这点有点象sqlserver的库,然后就是表了,oracle里的表,每个用户有个缺省的表空间,也就是说这个用户建的表会在这个表空间里面,a用户建的表ta,用a用户登录可以直接select * from ta这样访问,而其他用户(有权限的)要用select * from a.ta这样来访问


<<oracle 体系结构 >>
http://blog.csdn.net/wanghai__/article/details/4683983

<<Oracle表空间（tablespaces）>>
http://www.cnblogs.com/fnng/archive/2012/08/12/2634485.html

Oracle数据安全解决方案透明数据加密TDE
http://www.linuxidc.com/Linux/2011-12/48689.htm


## Oracle连接

- <<ORA-12560:TNS:协议器错误>>
https://jingyan.baidu.com/article/d71306350fa53b13fdf4753d.html
- <<ORA-01031: insufficient privileges>>
https://jingyan.baidu.com/article/8cdccae946893f315413cdf4.html
```
C:\Users\l00384038>sqlplus /nolog

SQL> conn /as sysdba
```

## Oralce FLASHBACK(闪回)

Oracle 闪回特性(FLASHBACK DATABASE) - CSDN博客
https://blog.csdn.net/leshami/article/details/6100429


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# MySQL

HBase vs. MongoDB vs. MySQL vs. Oracle vs. Redis，三大主流开源 NoSQL 数据库的 PK 两大主流传统 SQL 数据库 
http://blog.csdn.net/defonds/article/details/48471087


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:



# 中间件

## MyCAT, DRDS等

https://www.cnblogs.com/ivictor/p/5111495.html

<<数据库相关中间件介绍>>
http://www.cnblogs.com/grefr/p/6087942.html

http://www.cnblogs.com/leejean/p/4914228.html


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:



# 一般性的

### 查看数据库core_dump文件的位置
vi /proc/sys/kernel/core_pattern

<<详解coredump>>
http://blog.csdn.net/tenfyguo/article/details/8159176

## books

Become a Postgres Expert with Free Training
https://www.enterprisedb.com/free-postgres-training

<<The Internals of PostgreSQL - for database administrators and system developers>> by SUZUKI Hironobu
http://www.interdb.jp/pg/

<<PostgreSQL: Introduction and Concepts >>
http://momjian.us/main/writings/pgsql/aw_pgsql_book/

PostgreSQL 有哪些经典入门书籍？
https://www.zhihu.com/question/28085660
> https://github.com/ty4z2008/Qix/blob/master/pg.md
> PostgreSQL数据库从入门到精通 - 阿里云大学 https://edu.aliyun.com/course/52

PostgreSQL 9 Administration Cookbook
http://download.chekiang.info/blog/PostgreSQL-9-Admin-Cookbook.pdf

PostgreSQL修炼之道 - 从小工到专家
http://www.gaofi.cn/book/detail/892

PostgreSQL Server Programming
http://pdf.th7.cn/down/files/1312/PostgreSQL%20Server%20Programming.pdf

## 事务

### 两阶段提交

http://blog.jobbole.com/95632/

https://zh.wikipedia.org/zh-hans/%E4%BA%8C%E9%98%B6%E6%AE%B5%E6%8F%90%E4%BA%A4

## 并发管理

### 两阶段锁

https://www.cnblogs.com/zszmhd/p/3365220.html


https://www.2cto.com/database/201403/286730.html

## 索引

<<深入 聚集索引与非聚集索引(一)>>
http://www.cnblogs.com/lwzz/archive/2012/08/05/2620824.html

<<聚集索引和非聚集索引（整理）>>
http://www.cnblogs.com/aspnethot/articles/1504082.html

<<唯一性索引（Unique Index）与普通索引（Normal Index）差异（上）>>
http://blog.itpub.net/17203031/viewspace-700089/


###

<<对PostgreSQL中 pg_各表的RelationId的认识>> by 健哥的数据花园
http://www.cnblogs.com/gaojian/p/3169560.html

<<PostgreSQL建表动作分析>> by 健哥的数据花园
http://www.cnblogs.com/gaojian/archive/2013/07/05/3171433.html

<<>>
http://beigang.iteye.com/blog/1680797

http://momjian.us/main/blogs/pgblog.html

http://momjian.us/main/writings/pgsql/aw_pgsql_book/


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# firebird

https://www.viva64.com/en/b/0542/


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# DATABASE SECURITY

## AWS

Thread: Explain the difference between HSM and HSA
https://forums.aws.amazon.com/thread.jspa?threadID=232163

## SQL Server and Azure

<< SQL SERVER COLUMN LEVEL ENCRYPTION >>
https://info.townsendsecurity.com/sql-server-column-level-encryption
>https://info.townsendsecurity.com/definitive-guide-to-encryption-key-management-fundamentals  

- << Getting Started with Always Encrypted with SSMS >>
https://channel9.msdn.com/Shows/Data-Exposed/Getting-Started-with-Always-Encrypted-with-SSMS
- << Always Encrypted in SQL Server and Azure SQL Database >>
https://channel9.msdn.com/Events/Community-Poland/Data-Community-106/Always-Encrypted
- << Enabling Confidential Computing with Always Encrypted using Enclaves (Early Access Preview) >>
https://blogs.msdn.microsoft.com/sqlsecurity/2017/10/05/enabling-confidential-computing-with-always-encrypted-using-enclaves-early-access-preview/




