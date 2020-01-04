
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

[并发控制](https://zh.wikipedia.org/wiki/%E5%B9%B6%E5%8F%91%E6%8E%A7%E5%88%B6) || Concurrency control https://en.wikipedia.org/wiki/Concurrency_control
- > 数据库管理系统（DBMS）中的并发控制的任务是确保在多个事务同时存取数据库中同一数据时不破坏事务的隔离性和统一性以及数据库的统一性。下面举例说明并发操作带来的数据不一致性问题：
  >> 现有两处火车票售票点，同时读取某一趟列车车票数据库中车票余额为 X。两处售票点同时卖出一张车票，同时修改余额为 X -1写回数据库，这样就造成了实际卖出两张火车票而数据库中的记录却只少了一张。
  >>> 产生这种情况的原因是因为两个事务读入同一数据并同时修改，其中一个事务提交的结果破坏了另一个事务提交的结果，导致其数据的修改被丢失，破坏了事务的隔离性。并发控制要解决的就是这类问题。
- > 封锁、时间戳、乐观并发控制和悲观并发控制是并发控制主要采用的技术手段。 
- > The main categories of concurrency control mechanisms are: 
  * > Optimistic - Delay the checking of whether a transaction meets the isolation and other integrity rules (e.g., serializability and recoverability) until its end, without blocking any of its (read, write) operations ("...and be optimistic about the rules being met..."), and then abort a transaction to prevent the violation, if the desired rules are to be violated upon its commit. An aborted transaction is immediately restarted and re-executed, which incurs an obvious overhead (versus executing it to the end only once). If not too many transactions are aborted, then being optimistic is usually a good strategy.
  * > Pessimistic - Block an operation of a transaction, if it may cause violation of the rules, until the possibility of violation disappears. Blocking operations is typically involved with performance reduction.
  * > Semi-optimistic - Block operations in some situations, if they may cause violation of some rules, and do not block in other situations while delaying rules checking (if needed) to transaction's end, as done with optimistic.
- > Many methods for concurrency control exist. Most of them can be implemented within either main category above. The major methods, which have each many variants, and in some cases may overlap or be combined, are: 

[封锁 (数据库)](https://zh.wikipedia.org/wiki/%E5%B0%81%E9%94%81_(%E6%95%B0%E6%8D%AE%E5%BA%93)) || Record locking https://en.wikipedia.org/wiki/Record_locking
- > 封锁是一项用于多用户同时访问数据库的技术，是实现并发控制的一项重要手段，能够防止当多用户改写数据库时造成数据不一致与冲突。当有一个用户对数据库内的数据进行操作时，在读取数据前先锁住数据，这样其他用户就无法访问和修改该数据，直到这一数据修改并写回数据库解除封锁为止。詹姆斯·尼古拉·格雷最早完整描述了数据库锁。
- > 按照粒度可分为：
  * > 表锁（文件锁）
  * > 页锁（page-level lock）
  * > 记录锁（行锁，因为SQL标准使用“行”的表述）
- > 按照使用方式分为：
  * > 互斥锁（exclusive lock，读锁） ***//【:star:】这行和下面那行读锁写锁弄反了，坑！***
  * > 共享锁（sharing lock，写锁）
- > 一般说来，获得锁并不是禁止其他事务对加锁的数据的读/写，而是阻塞了其他事务对这些数据的加锁操作。例如，如果一般的select语句根本不申请加锁，所以能直接读取其他事务已经加了互斥锁的数据。 

Timestamp-based concurrency control https://en.wikipedia.org/wiki/Timestamp-based_concurrency_control
- > In computer science, a timestamp-based concurrency control algorithm is a non-lock concurrency control method. It is used in some databases to safely handle transactions, using timestamps. 

[乐观并发控制](https://zh.wikipedia.org/wiki/%E4%B9%90%E8%A7%82%E5%B9%B6%E5%8F%91%E6%8E%A7%E5%88%B6) || Optimistic concurrency control (OCC) https://en.wikipedia.org/wiki/Optimistic_concurrency_control
- > 在关系数据库管理系统里，乐观并发控制（又名“乐观锁”，Optimistic Concurrency Control，缩写“OCC”）是一种并发控制的方法。它假设多用户并发的事务在处理时不会彼此互相影响，各事务能够在不产生锁的情况下处理各自影响的那部分数据。在提交数据更新之前，每个事务会先检查在该事务读取数据后，有没有其他事务又修改了该数据。如果其他事务有更新的话，正在提交的事务会进行回滚。乐观事务控制最早是由孔祥重（H.T.Kung）教授提出。
- > 乐观并发控制多数用于数据争用不大、冲突较少的环境中，这种环境中，偶尔回滚事务的成本会低于读取数据时锁定数据的成本，因此可以获得比其他并发控制方法更高的吞吐量。
- > 乐观并发控制的事务包括以下阶段：
  * > 读取：事务将数据读入缓存，这时系统会给事务分派一个时间戳。
  * > 校验：事务执行完毕后，进行提交。这时同步校验所有事务，如果事务所读取的数据在读取之后又被其他事务修改，则产生冲突，事务被中断回滚。
  * > 写入：通过校验阶段后，将更新的数据写入数据库。
- > 乐观并发控制相信事务之间的数据竞争(data race)的概率是比较小的，因此尽可能直接做下去，直到提交的时候才去锁定，所以不会产生任何锁和死锁。但如果直接简单这么做，还是有可能会遇到不可预期的结果，例如两个事务都读取了数据库的某一行，经过修改以后写回数据库，这时就遇到了问题。   

[悲观并发控制](https://zh.wikipedia.org/wiki/%E6%82%B2%E8%A7%82%E5%B9%B6%E5%8F%91%E6%8E%A7%E5%88%B6) || 目前还没有英文wiki页面，很少见。
- > 在关系数据库管理系统里，悲观并发控制（又名“悲观锁”，Pessimistic Concurrency Control，缩写“PCC”）是一种并发控制的方法。它可以阻止一个事务以影响其他用户的方式来修改数据。如果一个事务执行的操作读某行数据应用了锁，那只有当这个事务把锁释放，其他事务才能够执行与该锁冲突的操作。
- > 悲观并发控制主要用于数据争用激烈的环境，以及发生并发冲突时使用锁保护数据的成本要低于回滚事务的成本的环境中。
- > 悲观并发控制实际上是“先取锁再访问”的保守策略，为数据处理的安全提供了保证。但是在效率方面，处理加锁的机制会让数据库产生额外的开销，还有增加产生死锁的机会；另外，在只读型事务处理中由于不会产生冲突，也没必要使用锁，这样做只能增加系统负载；还有会降低了并行性，一个事务如果锁定了某行数据，其他事务就必须等待该事务处理完才可以处理那行数据。  

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

在线就能用的 SQL 练习平台我给你找好了！ - Rocky0429的文章 - 知乎 https://zhuanlan.zhihu.com/p/92590262
- SQLZOO -- Learn SQL using: SQL Server, Oracle, MySQL, DB2, and PostgreSQL. https://sqlzoo.net/
- SQLBolt -- Learn SQL with simple, interactive exercises. https://sqlbolt.com/

# 故障恢复

容灾管理中的RTO与RPO的关系 https://www.cnblogs.com/kouryoushine/p/8301372.html

# 待分类

【[:star:][`*`]】 分库分表 or NewSQL数据库？终于看懂应该怎么选！ https://dbaplus.cn/news-159-2690-1.html || https://mp.weixin.qq.com/s/ymVxSe8nueuG7knKwcIAMw

数据架构选型必读：1月数据库产品技术解析 https://dbaplus.cn/news-141-2437-1.html
