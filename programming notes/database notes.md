
# PostgreSQL

![PostgreSQL](https://wiki.postgresql.org/images/3/30/PostgreSQL_logo.3colors.120x120.png)

https://github.com/ty4z2008/Qix/blob/master/pg.md

### 关于postgresql.auto.conf文件

<<PostgreSQL9.4: 新增 ALTER SYSTEM 命令>> by francs

http://francs3.blog.163.com/blog/static/4057672720144194492582/

### ctid

<<postgresql之ctid的浅谈>>
http://www.cnblogs.com/lottu/p/5613098.html


### pg_depend

http://blog.csdn.net/prettyshuang/article/details/49638641

http://blog.csdn.net/yibei8811/article/details/46623253

http://www.codeweblog.com/postgresql%E7%9A%84pg_depend%E8%AF%A6%E8%A7%A3/


### vacuum

<<PostgreSQL的autovacuum 与 vacuum full>> by 技术者高健
http://www.cnblogs.com/gaojian/p/3272620.html

### information_schema

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




<<跟我一起读postgresql源码(二)——Parser(查询分析模块)>>
http://blog.csdn.net/zdy0_2004/article/details/53106260


### 临时表和unlogged table

<<postgresql----TEMPORARY TABLE和UNLOGGED TABLE>>
https://www.cnblogs.com/alianbog/p/5605068.html

### GUC

<<PostgreSQL GUC 参数级别介绍>>
http://blog.csdn.net/yunqishequ1/article/details/78084592




## PG存储

<<数据库系统概念笔记之存储和文件系统及PostgreSQL实现>>
http://www.postgres.cn/news/viewone/1/220



:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# PGXC

<<PGXC两阶段提交与事务一致性（1）>>
http://www.cnblogs.com/databaseaffair/p/6864070.html

<<Postgres-XC 1.1 Documentation>>
http://postgres-xc.sourceforge.net/docs/1_1/index.html

<<PostgreSQL-XC : Data Replication or Distribution ? >>
http://francs3.blog.163.com/blog/static/4057672720125453315201/

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


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


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# MySQL

## MyCAT

https://www.cnblogs.com/ivictor/p/5111495.html

# 一般性的

### 查看数据库core_dump文件的位置
vi /proc/sys/kernel/core_pattern

<<详解coredump>>
http://blog.csdn.net/tenfyguo/article/details/8159176

## books

<<The Internals of PostgreSQL - for database administrators and system developers>> by SUZUKI Hironobu
http://www.interdb.jp/pg/


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

# firebird

https://www.viva64.com/en/b/0542/
