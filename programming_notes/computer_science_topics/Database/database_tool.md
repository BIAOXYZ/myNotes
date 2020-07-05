
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

# 异构数据同步工具

异构数据库双向同步调研 https://blog.csdn.net/jingya_charmworker/article/details/81365604

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
