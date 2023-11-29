
Awesome Database Tools https://github.com/mgramin/awesome-db-tools

Awesome-Database-Testing https://github.com/zhangysh1995/awesome-database-testing
- > Sysbench - MySQL benchmarks

# 性能测试

ASBench：Another Sysbench https://mp.weixin.qq.com/s/EX3_2LKvq1-zaTOuYcS2-w
- > ASBench是一款可以同时对Oracle、PostgreSQL和MySQL数据库做性能对比测试的数据库压测工具
- > 近年来互联网行业的新兴崛起使得诞生了很多的国产数据库，而多数国产数据库都是以去“O”为己任。多数银行、保险、证券等金融公司以及一些政企，如电力也开始使用国产数据库。但如何对这些大量的国产数据库与Oracle进行对比测试，这是一个考验。很多人使用MySQL AB公司出品的sysbench做对比测试。早些年的sysbench，如sysbench0.5版本，可以同时测试Oracle、PostgreSQL和MySQL数据库。因为sysbench的简单易用，同时可以非常灵活的自定义测试SQL和Lua脚本，所以深受大家的喜爱。但从Sysbench1.0版本开始，去掉了对Oracle数据库的支持。而旧版本的sysbench0.5一直没有新发展，一些旧bug也没有修复，导致用户再使用sysbench0.5版本做不同的数据库对比测试时出现了一些问题。
- > 为了解决大家对不同数据库对比测试的困难，中启乘数科技本着从开源中汲取也奉献于开源的思想，在原先sysbench0.5的源码中做出一个分支，发展了一个开源的测试工具“ASBench”。
“ASBench”，寓意着“Another Sysbench”，可以继续提供对Oracle数据库测试的支持。 
- > 新的ASBench的源码在gitee上: https://gitee.com/csudata/asbench
- > 在Centos7.X下编译好的版本在relase页面看到: https://gitee.com/csudata/asbench/releases/v0.1，可以直接下载使用。

# 其他工具

SQLancer -- Detecting Logic Bugs in DBMS https://github.com/sqlancer/sqlancer || www.sqlancer.com
- > SQLancer (Synthesized Query Lancer) is a tool to automatically test Database Management Systems (DBMS) in order to find logic bugs in their implementation. We refer to logic bugs as those bugs that cause the DBMS to fetch an incorrect result set (e.g., by omitting a record).

# 在线工具

DB Fiddle - SQL Database Playground https://www.db-fiddle.com/
> 源头：看《The Internals of PostgreSQL》第三章时，忘了 MCV (Most Common Value) 的计算方法了。搜了一下发现下面链接里有个Demo的link，于是很偶然发现了DB Fiddle。
>> Get the most common value in mysql https://stackoverflow.com/questions/55460912/get-the-most-common-value-in-mysql
>>> Demo: https://www.db-fiddle.com/f/8YHdSVAvUTNGRxaBRkKfHw/0

后来googel以关键词“db fiddle”搜一下，还有几个类似的：
- db<>fiddle https://dbfiddle.uk/
- SQL Fiddle http://sqlfiddle.com/

Alternatives to DB Fiddle for all platforms with any license https://alternativeto.net/software/db-fiddle/

Postgres Explain Visualizer 2 https://github.com/dalibo/pev2
- > A VueJS component to show a graphical vizualization of a PostgreSQL execution plan.
- > Dalibo service (recommended): https://explain.dalibo.com/

PostgreSQL online editor https://onecompiler.com/postgresql/

PostgreSQL online https://extendsclass.com/postgresql-online.html

SQLite Online https://sqliteonline.com/  【这个感觉挺好用的～也有 pg 和 mysql】

# 异构数据同步工具

异构数据库双向同步调研 https://blog.csdn.net/jingya_charmworker/article/details/81365604

mysql 同步数据到 SQLite 和 SQLserver https://www.v2ex.com/t/995814
- > Debezium
- > 这个帖子 https://www.v2ex.com/t/995792 第 13 点
- > 阿里开源的 canal ， 自带一个 adapter 可以写 SQL 的方式同步 但性能效率非常差，因为代码质量很差， 同时也提供 client ，可以自定义解析过来的 SQL
- > 定时同步用阿里的 datax ，实时同步用 canal
- > 直接用阿里的 DTS, 或者自己写一个, 模拟 mysql 从数据库订阅 mysql 的 binlog, 解析 binlog, 生成变更前后字段值, 再转换成 sqlite 和 sqlserver 的语法
- > datax 实时就 flink cdc 这些

## SymmetricDS

SymmetricDS https://www.symmetricds.org/

多种数据库之间的同步工具SymmetricDS https://www.cnblogs.com/kuang17/p/10395286.html

## OGG

GoldenGate https://www.oracle.com/technetwork/cn/community/developer-day/3-goldengate-289794-zhs.pdf

Oracle GoldenGate https://www.oracle.com/technetwork/cn/middleware/goldengate/overview/index.html

Oracle GoldenGate快速入门篇（详解GoldenGate概念到原理） http://www.chinastor.com/oracle/goldengate/042623M12016.html

[Oracle] Golden Gate - 概念和机制 https://blog.csdn.net/dbanote/article/details/33322601

Oracle GoldenGate 详解 https://www.cnblogs.com/rangle/p/8987063.html

# 数据迁移

migrate -- Database migrations written in Go. Use as CLI or import as library. https://github.com/golang-migrate/migrate
- > Forked from [mattes/migrate](https://github.com/mattes/migrate)

有一个上百 G 的 Oracle 数据库，要整体迁移至 MySql，麻烦各位大佬给个思路 https://www.v2ex.com/t/675899
```console
navicat 数据传输 /导出 sql 等功能，跑单表都内存溢出。
dbeaver 也一样直接卡主。
oracle 数据库表设计还很坑爹地用了浮点型做主键，然后利用序列自增
自动化迁移 mysql 之后还要修改字段为整型才能改自增
--------------------------------------------------
第 1 条附言  ·  6 小时 6 分钟前
经过测试 应该可以处理好了 DataX 牛 X ！
```
- > 用 datax 啊，https://github.com/alibaba/DataX 迁移过近百 T 的数据
- > 【楼主】16G 内存+12G 虚拟内存 跑不赢 13g 单表 直接报内存不足 卡死
- > datax 是 etl 工具，阿里开发的，但不需要上云啊，你要迁也只能用这种东西稍微方便点
- > 【楼主】我的也就几个大表数据特别多，其他的可以 navicat 一键迁移
- > kettle 可以吧
- > DATAX 好评加一 迁移过上亿数据
- > 虽然我用的 mongoDb,但也应该差不多。之前我遇到的情况是迁移 2000 万记录的单表，整体查出来肯定爆内存，用游标十几分钟就能全表迁移走
- > 说下我用的比较多的工具 <br> kettle 这样的 etl 工具 适用表不多的情况 比较好用，msdts 也能用 <br> ESF Database Migration Toolkit - Professional，这个比较简单
- > 用过 kettle 做 mysql 到 postgres 的迁移，还不错
- > streamsets 也行吧

## DataX

DataX https://github.com/alibaba/DataX

# 数据库应用开发

ODBC https://zh.wikipedia.org/wiki/ODBC
- > 在ODBC诞生之前，如果要开发数据库应用程序，则必须要使用数据库厂商随数据库产品一同发布的一些工具集来访问数据库，或者在程序中使用嵌入式SQL来访问数据库。当时，对于访问数据库的方法，缺乏一个基于C语言的统一编程接口。在这种背景下，微软于1992年发表了ODBC。之后，X/Open组织以及ISO标准化组织基于ODBC 3.0的规范，进一步进行了标准化，于1995年发表了SQL/CLI标准。该标准已经成为了SQL标准的一部分。
- > ODBC的运用形态通常是由应用程序经过一个称之为ODBC管理器的工具，创建一个`DSN`，指明需要调用的ODBC驱动程序，从而访问对应的数据库。对于用户的应用程序而言，ODBC驱动程序是相对不可见的。用户只需要在ODBC管理器中配置相应的数据库的数据源信息，并登录相应的ODBC驱动程序即可。DSN分为三种：
  * > 用户DSN
  * > 系统DSN
  * > 文件DSN
- > 也可以用连接字符串而不需要事先创建DSN，例如
  ```console
  connstr="DRIVER={SQL SERVER};SERVER=servername;UID=xyz;PWD=xxx"
  connstr="DRIVER={Microsoft Access Driver};SERVER=D:\abc\defg.mdb"
  ```
