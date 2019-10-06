
# DB newsletter

Database Weekly http://databaseweekly.com/

Database of Databases https://dbdb.io/
- https://dbdb.io/db/yugabyte-db

DB-Engines https://db-engines.com/en/
- > The DB-Engines Ranking is a list of DBMS ranked by their current popularity. The list is updated monthly.
- > DB-Engines has been created and is maintained by solid IT.

## Publications by cooperpress https://cooperpress.com/publications/

DB Weekly https://dbweekly.com/
- https://dbweekly.com/issues/246

Postgres Weekly https://postgresweekly.com/


# DB from zhihu

数据库前沿技术 https://zhuanlan.zhihu.com/c_190483659

数据库内核 https://zhuanlan.zhihu.com/c_206071340

数据库内核技术专栏 https://zhuanlan.zhihu.com/dbtech

图数据库杂谈 https://zhuanlan.zhihu.com/graphdbs

# 一般性的

### 查看数据库core_dump文件的位置
vi /proc/sys/kernel/core_pattern

<<详解coredump>>
http://blog.csdn.net/tenfyguo/article/details/8159176

# 数据库相关知识

【from draveness】
- 浅谈数据库并发控制 - 锁和 MVCC https://draveness.me/database-concurrency-control

## 事务

### ACID

ACID https://en.wikipedia.org/wiki/ACID 【[ACID](https://zh.wikipedia.org/wiki/ACID)】
- > Processing a transaction often requires a sequence of operations that is subject to failure for a number of reasons. For instance, the system may have no room left on its disk drives, or it may have used up its allocated CPU time. There are two popular families of techniques: [write-ahead logging](https://en.wikipedia.org/wiki/Write-ahead_logging) and [shadow paging](https://en.wikipedia.org/wiki/Shadow_paging). In both cases, locks must be acquired on all information to be updated, and depending on the level of isolation, possibly on all data that may be read as well. In write ahead logging, atomicity is guaranteed by copying the original (unchanged) data to a log before changing the database. That allows the database to return to a consistent state in the event of a crash. In shadowing, updates are applied to a partial copy of the database, and the new copy is activated when the transaction commits. 
- > Locking vs multiversioning
- > Distributed transactions

### 两阶段提交

http://www.jobbole.com/members/hollischuang/
- 关于分布式事务、两阶段提交协议、三阶提交协议 http://blog.jobbole.com/95632/
- 分布式系统的一致性探讨 http://blog.jobbole.com/95618/

http://www.hollischuang.com/
- 分布式系统的CAP理论 http://www.hollischuang.com/archives/666
- 分布式系统的BASE理论 http://www.hollischuang.com/archives/672
- 深入分析事务的隔离级别 http://www.hollischuang.com/archives/943

- 二阶段提交 https://zh.wikipedia.org/zh-hans/%E4%BA%8C%E9%98%B6%E6%AE%B5%E6%8F%90%E4%BA%A4
- 事务隔离 https://zh.wikipedia.org/wiki/%E4%BA%8B%E5%8B%99%E9%9A%94%E9%9B%A2

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

How does database indexing work? [closed] https://stackoverflow.com/questions/1108/how-does-database-indexing-work

## 位图索引

Bitmap index https://en.wikipedia.org/wiki/Bitmap_index
- > Their drawback is they are less efficient than the traditional B-tree indexes for columns whose data is frequently updated: consequently, they are more often employed in read-only systems that are specialized for fast query - e.g., data warehouses, and generally unsuitable for online transaction processing applications.

位图索引:原理（BitMap index） https://www.cnblogs.com/LBSer/p/3322630.html

## SQL

SQL编程大赛总结 https://blog.csdn.net/yzsind/article/details/6328864

# 待分类

【[:star:][`*`]】 分库分表 or NewSQL数据库？终于看懂应该怎么选！ https://dbaplus.cn/news-159-2690-1.html || https://mp.weixin.qq.com/s/ymVxSe8nueuG7knKwcIAMw
