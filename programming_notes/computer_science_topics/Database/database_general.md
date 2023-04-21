
# DB newsletter

Database Weekly http://databaseweekly.com/

Database of Databases https://dbdb.io/
- https://dbdb.io/db/yugabyte-db

DB-Engines https://db-engines.com/en/
- > The DB-Engines Ranking is a list of DBMS ranked by their current popularity. The list is updated monthly.
- > DB-Engines has been created and is maintained by solid IT.

阿里云数据库内核月报分类整理（定时更新） https://github.com/tangwz/db-monthly

## Publications by cooperpress https://cooperpress.com/publications/

DB Weekly https://dbweekly.com/
- https://dbweekly.com/issues/246

Postgres Weekly https://postgresweekly.com/

# DB books

db-readings https://github.com/rxin/db-readings

# DB videos

德哥PostgreSQL-天天象上沙龙-第1讲-掀起盖头 https://www.bilibili.com/video/BV1d54y157yA

# DB from github

Awesome Database Learning https://github.com/pingcap/awesome-database-learning

# 一般性的

### 查看数据库core_dump文件的位置
vi /proc/sys/kernel/core_pattern

<<详解coredump>>
http://blog.csdn.net/tenfyguo/article/details/8159176

# 数据库相关知识

## 构架

Shared-nothing architecture https://en.wikipedia.org/wiki/Shared-nothing_architecture
- > A shared-nothing architecture (SN) is a distributed-computing architecture in which each update request is satisfied by a single node (processor/memory/storage unit). ***The intent is to eliminate contention among nodes***. Nodes do not share (independently access) ***memory*** or ***storage***. One alternative architecture is ***shared everything***, in which requests are satisfied by ***arbitrary combinations of nodes***. This may introduce contention, as multiple nodes may seek to update the same data at the same time.
- > SN eliminates single points of failure, allowing the overall system to continue operating despite failures in individual nodes and allowing individual nodes to upgrade without a system-wide shutdown.
- > A SN system can scale simply by adding nodes, since no central resource bottlenecks the system. Another term for SN is ***sharding***. A SN system typically partitions its data among many nodes.
- > Michael Stonebraker at the University of California, Berkeley used the term in a 1986 database paper. Teradata delivered the first SN database system in 1983.
  >> The Case for Shared Nothing https://dsf.berkeley.edu/papers/hpts85-nothing.pdf

Shared disk architecture https://en.wikipedia.org/wiki/Shared_disk_architecture
- > A shared disk architecture (SD) is a distributed computing architecture in which all disks are accessible from all cluster nodes. It contrasts with shared nothing architecture, in which all nodes have sole access to distinct disks. Multiple processors can access all disks directly via intercommunication network and ***every processor has local memory***.
- > Shared Disk has ***two advantages*** over Shared memory. Firstly, each processor has its own memory, the memory bus is not a bottleneck; secondly, the system offers a simple way to provide a degree of fault tolerance.

数据库架构设计的三种模式：share nothing , share everythong , share disk https://www.cnblogs.com/kzwrcom/p/6397709.html
- > Shared Everthting:一般是针对单个主机，完全透明共享CPU/MEMORY/IO，并行处理能力是最差的，`典型的代表SQLServer`
- > Shared Disk：各个处理单元使用自己的`私有 CPU和Memory`，共享磁盘系统。`典型的代表Oracle Rac`， 它是数据共享，可通过增加节点来提高并行处理的能力，扩展能力较好。其类似于`SMP（对称多处理）`模式，但是当存储器接口达到饱和的时候，增加节点并不能获得更高的性能 。
- > Shared Nothing：各个处理单元都有自己私有的CPU/内存/硬盘等，不存在共享资源，类似于`MPP（大规模并行处理）`模式，各处理单元之间通过协议通信，并行处理和扩展能力更好。`典型代表DB2 DPF和Hadoop` ，各节点相互独立，各自处理自己的数据，处理后的结果可能向上层汇总或在节点间流转。 <br> 我们常说的 `Sharding` 其实就是Share Nothing架构，它是把某个表从物理存储上被水平分割，并分配给多台服务器（或多个实例），每台服务器可以独立工作，具备共同的schema，比如MySQL Proxy和Google的各种架构，只需增加服务器数就可以增加处理能力和容量。

What are the differences between shared nothing, shared memory, and shared storage architectures in the context of scalable computing/analytics? https://www.quora.com/What-are-the-differences-between-shared-nothing-shared-memory-and-shared-storage-architectures-in-the-context-of-scalable-computing-analytics
- > Let me explain with an example.
  <br><br> Lets say you and your friend are tasked with solving 2 problems. You can use **blackboards** and **notebooks** as you solve the problems. You are expected to produce the solutions in the notebooks.
  <br><br> If you and your friend solve this in different classrooms, with different blackboards, and write the answer down in separate notebooks, this is **shared nothing** architecture -- each of you are solving the problem on your own. You could each solve one of the problems independently.
  <br><br> If you and your friend solve the problem in the same classroom with the same blackboard, so that you can see each other working through the problem, this is similar to **shared memory** architecture. You rub the blackboard clean when you finish, but it helps you both to solve the problems.
  <br><br> If you and your friend solve both problems together, and write down the solutions in the same notebook, it is similar to the **shared storage** architecture - you are sharing the notebook where the final solutions are going to be.
  <br><br> I am equating memory to the blackboard, and storage to your notebooks. Assuming you both know how to solve both problems, **shared nothing** architecture is going to be fastest -- you don't have to wait to use the blackboard or the notebook.

Parallel Programming - Architecture (Shared nothing, Shared disk, Shared Memory) https://gerardnico.com/data/concurrency/architecture
> ![](https://gerardnico.com/_media/data/concurrency/taxonomy_of_parallel_architecture.jpg)
>> 注：上图出自论文《Parallel Database Systems: The Future of Database Processing or a Passing Fad?》 https://www.microsoft.com/en-us/research/publication/parallel-database-systems-the-future-of-database-processing-or-a-passing-fad/ 所以可见 `share disk` 和 `share memory` 是比 `share storage` 更正式的。

**关于share nothing、share everything、share disk、share memory、share storage的总结**：
- 首先不论是 share xxx 或者 shared xxx（或者中间有连字符），都只是不同的表达形式。
- share nothing连wiki词条都有，并且也有大牛背书。share everything是share nothing的反面，也很直观。这两个本身意义上也很明显。
- share disk不论wiki词条还是民间/网上，目前看都认为是“**磁盘共享，但内存是独立**（CPU在这种情况下更是独立，无需赘述）”，所以这个争议也不大，该词汇正式程度仅次于前两个。
- share memory好歹有大牛文章，所以正式程度和share disk差不多。但这里一个关键的问题是：“**CPU肯定独立，内存share，那disk呢？**”——论文[《Parallel Database Systems: The Future of Database Processing or a Passing Fad?》](https://jimgray.azurewebsites.net/papers/CacmParallelDB.pdf)里给出的答案是：**disk也是共享的(或者至少是每个CPU都能访问到每块磁盘)**。——个人认为：内存一旦是共享的，内存又介于磁盘和CPU之间，磁盘基本也就等于共享了。
  * > How can we build scaleable multi-processor systems? Stonebraker suggested the following simple taxonomy for the spectrum of designs (see Figures 3 and 4) [STON86]:
    + > `shared-memory`: All processors share direct access to a common global memory ***and to all disks***. The IBM/370, and Digital VAX, and Sequent Symmetry multi-processors typify this design.
    + > shared-disks: Each processor has a private memory but has direct access to all disks. The IBM Sysplex and original Digital VAXcluster typify this design.
    + > shared-nothing: Each memory and disk is owned by some processor that acts as a server for that data. Mass storage in such an architecture is distributed among the processors by connecting one or more disks. The Teradata, Tandem, and nCUBE machines typify this design.
- share storage则更像是一个民间口口相传出来的词。至于其意义，有时是接近share disk（各个节点还是有自己的独立内存，但是磁盘是公共的）；有时是接近share memory（除了CPU是独立的，内存和磁盘都是共享的）。该词汇的正式程度最低。

## 

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

一篇讲透如何理解数据库并发控制 - 阿里云云栖号的文章 - 知乎 https://zhuanlan.zhihu.com/p/139697896

## 事务

第七章：事务 https://github.com/Vonng/ddia/blob/master/ch7.md

### ACID

ACID https://en.wikipedia.org/wiki/ACID 【[ACID](https://zh.wikipedia.org/wiki/ACID)】
- > Processing a transaction often requires a sequence of operations that is subject to failure for a number of reasons. For instance, the system may have no room left on its disk drives, or it may have used up its allocated CPU time. There are two popular families of techniques: [write-ahead logging](https://en.wikipedia.org/wiki/Write-ahead_logging) and [shadow paging](https://en.wikipedia.org/wiki/Shadow_paging). In both cases, locks must be acquired on all information to be updated, and depending on the level of isolation, possibly on all data that may be read as well. In write ahead logging, atomicity is guaranteed by copying the original (unchanged) data to a log before changing the database. That allows the database to return to a consistent state in the event of a crash. In shadowing, updates are applied to a partial copy of the database, and the new copy is activated when the transaction commits. 
- > Locking vs multiversioning
- > Distributed transactions

### 隔离级别

【[:star:][`*`]】 通俗易懂 事务、ACID、脏读、脏写、幻读、读已提交、快照隔离、读写锁、两阶段锁定 的区别与联系 - Pickle Pee的文章 - 知乎 https://zhuanlan.zhihu.com/p/69380112
- > **两阶段锁定、共享锁、互斥锁**
  * > 你可能听说过两阶段提交（2PC），但两阶段锁定（2PL）与它是完全不同的东西。
  * > 两阶段锁定要求：只要没有写入，就允许多个事务同时读取同一行。但只要有写入（修改或删除），就独占访问权限。换句话说，写入不仅会阻塞其他写入，也会阻塞读——这是和快照隔离之间的关键区别。
  * > 为什么叫“两阶段”锁定呢？
    + > 第一阶段（只加锁）：事务开始前，进程尝试对所有此事务需要的行进行加锁，按顺序一次锁一行，查询就加共享锁，修改就加互斥锁。
    + > 若第一阶段全部加锁成功，就开始第二阶段（只解锁）：执行更新然后释放所有锁。若在第一阶段某个进程加锁时发生冲突，则该进程释放它所有加锁的行，然后重试第一阶段。
  * > 两阶段提交用到了两种锁，`共享锁`（也称为`读锁`，允许多个事务同时读取同一行）或`互斥锁`（也称为`写锁`，只要有写入就独占访问权限），这是它们的经典使用场景。
  * > 两阶段锁定真正实现了串行化性质，它可以防止之前讨论的所有并发问题，也是性能损耗最大的选择，尤其是它可能会更频繁地导致死锁出现。事务由于死锁而被中止后只能重试，这意味着巨大的开销。
- > **参考**
  * > 用事务ID标识不同版本的数据，就意味着数据库从来不修改值，而是每次值改变时创建一个新版本。在稍后的时间，当确定没有事务可以再访问某些数据时，数据库系统的垃圾回收线程会将它们删除，并释放其空间。
>> //notes：`ACID`和`隔离级别`都讲的不错，不过隔离级别有的名字不是常见的。自己总结下吧，应该是这样的：
>>> 【[:star:][`*`]】【隔离级别：**`读未提交`**】-->（现象：***`脏读`***）-->【隔离级别：**`读已提交`**】-->（现象：***`不可重复读`***）-->【隔离级别：**`可重复读`**】-->（现象：***`幻读`***）-->【隔离级别：**`(可)串行化`**】

【[:star:][`*`]】 MySQL 四种事务隔离级的说明 https://www.cnblogs.com/zhoujinyi/p/3437475.HTML  【这个还有实操的例子】
- Innodb中的事务隔离级别和锁的关系 https://tech.meituan.com/2014/08/20/innodb-lock.html

【[:star:][`*`]】 20个数据库常见面试题讲解() - 奔波小码农的文章 - 知乎 https://zhuanlan.zhihu.com/p/163196566
- > **2.1事务的并发问题**
  * > （1）脏读：事务A读取了事务B更新的数据，然后B回滚操作，那么A读取到的数据是脏数据
  * > （2）不可重复读：事务 A 多次读取同一数据，事务 B 在事务A多次读取的过程中，对数据作了更新并提交，导致事务A多次读取同一数据时，结果因此本事务先后两次读到的数据结果会不一致。
  * > （3）幻读：幻读解决了不重复读，保证了同一个事务里，查询的结果都是事务开始时的状态（一致性）。
  * > 例如：***事务T1对一个表中所有的行的某个数据项做了从“1”修改为“2”的操作 这时事务T2又对这个表中插入了一行数据项，而这个数据项的数值还是为“1”并且提交给数据库。 而操作事务T1的用户如果再查看刚刚修改的数据，会发现还有跟没有修改一样，其实这行是从事务T2中添加的，就好像产生幻觉一样，这就是发生了幻读***。
  * > 小结：不可重复读的和幻读很容易混淆，***不可重复读侧重于修改，幻读侧重于新增或删除***。<ins>解决不可重复读的问题只需锁住满足条件的行，解决幻读需要锁表</ins>。
- > **6、什么是临时表，临时表什么时候删除？**
  * > 临时表只在当前连接可见，当关闭连接时，MySQL会自动删除表并释放所有空间。因此在不同的连接中可以创建同名的临时表，并且操作属于本连接的临时表。
- > **9、聚集索引和非聚集索引区别？**
- > **10、有哪些锁（乐观锁悲观锁），select 时怎么加排它锁？**
- > **20、数据库崩溃时事务的恢复机制（REDO日志和UNDO日志）？**
  * > Undo Log是为了实现事务的原子性，在MySQL数据库InnoDB存储引擎中，还用了Undo Log来实现多版本并发控制(简称：MVCC)。
  * > 原理和Undo Log相反，Redo Log记录的是新数据的备份。在事务提交前，只要将Redo Log持久化即可，不需要将数据持久化。当系统崩溃时，虽然数据没有持久化，但是Redo Log已经持久化。系统可以根据Redo Log的内容，将所有数据恢复到最新的状态。

## redo log 和 undo log

MySQL事务实现及Redo Log和Undo Log详解 https://cheng-dp.github.io/2019/05/09/mysql-tx-redo-undo/
- > **Redo Log**
  * > 重做日志(Redo Log)用来实现事务的持久性(Duration)，记录每次操作上页的物理修改。
- > **Undo Log**
  * > Undo Log(回滚日志)用来实现事务的原子性(回滚)和隔离性(MVCC)。

浅析MySQL事务中的redo与undo https://segmentfault.com/a/1190000017888478

MySQL中的重做日志（redo log），回滚日志（undo log），以及二进制日志（binlog）的简单总结 https://www.cnblogs.com/wy123/p/8365234.html

undo log与redo log原理分析 - 张友东的文章 - 知乎 https://zhuanlan.zhihu.com/p/35574452
- 回复里的：
  * > 因为数据的修改 就是对数据页里面保存的数据做修改 而一个数据页16kb 你每次修改一条或多条数据 如果就以页为单位刷回到硬盘里是得不偿失的 杀鸡焉用牛刀 而且如果涉及多个页 它们物理位置可能是不连续的 这里就有几个问题 一个问题就是 无效的刷新磁盘 修改的数据就几条 但是连带其他没有修改的数据也一起刷新 还有个问题是 页的物理位置不连续 随机io 效率低下 还有个问题是 页的大小16kb 不能保证磁盘页刷新原子性 如果中途宕机 页的刷新数据不完整 而redo日志就是 把每次修改记录单独管理 顺序写io 并且数据小保证数据落盘原子性 如果事务已提交 但是修改后的数据页还没有落盘的时候发生宕机 重启的时候能根据redo日志恢复数据 这也就是redo日志保证持久性的根本原因 持久的意义代表的是 正常情况下的事务提交 但是数据页还没落盘 发生宕机 给第二次机会去恢复 如果你说redo日志没落盘怎么办？那也好办 就相当于什么都不做

【图文详解】MySQL系列之redo log、undo log和binlog详解 https://cloud.tencent.com/developer/article/1801920
- > **为什么需要redo log**
  * > 我们都知道，事务的四大特性里面有一个是持久性，具体来说就是只要事务提交成功，那么对数据库做的修改就被永久保存下来了，不可能因为任何原因再回到原来的状态。那么mysql是如何保证一致性的呢？最简单的做法是在每次事务提交的时候，将该事务涉及修改的数据页全部刷新到磁盘中。但是这么做会有严重的性能问题，主要体现在两个方面：
    + > 因为Innodb是以页为单位进行磁盘交互的，而一个事务很可能只修改一个数据页里面的几个字节，这个时候将完整的数据页刷到磁盘的话，太浪费资源了！
    + > 一个事务可能涉及修改多个数据页，并且这些数据页在物理上并不连续，使用随机IO写入性能太差！
  * > 因此mysql设计了redo log，具体来说就是只记录事务对数据页做了哪些修改，这样就能完美地解决性能问题了(相对而言文件更小并且是顺序IO)。

### 分布式事务

七种分布式事务的解决方案，一次讲给你听 https://mp.weixin.qq.com/s/uO3QMkygkEi64rvwDZEQIw

### 两阶段提交

http://www.jobbole.com/members/hollischuang/
- 关于分布式事务、两阶段提交协议、三阶提交协议 http://blog.jobbole.com/95632/
- 分布式系统的一致性探讨 http://blog.jobbole.com/95618/

http://www.hollischuang.com/
- 分布式系统的CAP理论 http://www.hollischuang.com/archives/666
- 分布式系统的BASE理论 http://www.hollischuang.com/archives/672
- 深入分析事务的隔离级别 http://www.hollischuang.com/archives/943

https://www.zhihu.com/people/Pickle-Pee/posts
- 通俗易懂 RPC、REST、Dubbo、HTTP、RMI 的区别与联系 - Pickle Pee的文章 - 知乎 https://zhuanlan.zhihu.com/p/66311537
- 通俗易懂 索引、单列索引、复合索引、主键、唯一索引、聚簇索引、非聚簇索引、唯一聚簇索引 的区别与联系 - Pickle Pee的文章 - 知乎 https://zhuanlan.zhihu.com/p/66553466
- 通俗易懂 强一致性、弱一致性、最终一致性、读写一致性、单调读、因果一致性 的区别与联系 - Pickle Pee的文章 - 知乎 https://zhuanlan.zhihu.com/p/67949045
- 【[:star:][`*`]】 通俗易懂 事务、ACID、脏读、脏写、幻读、读已提交、快照隔离、读写锁、两阶段锁定 的区别与联系 - Pickle Pee的文章 - 知乎 https://zhuanlan.zhihu.com/p/69380112
- 通俗易懂 悲观锁、乐观锁、可重入锁、自旋锁、偏向锁、轻量/重量级锁、读写锁、各种锁及其Java实现！ - Pickle Pee的文章 - 知乎 https://zhuanlan.zhihu.com/p/71156910
- 通俗易懂 从线性一致、全序、共识 到 两/三阶段提交、Zookeeper原子广播协议、Paxos算法 - Pickle Pee的文章 - 知乎 https://zhuanlan.zhihu.com/p/76209860

二阶段提交 https://zh.wikipedia.org/zh-hans/%E4%BA%8C%E9%98%B6%E6%AE%B5%E6%8F%90%E4%BA%A4

事务隔离 https://zh.wikipedia.org/wiki/%E4%BA%8B%E5%8B%99%E9%9A%94%E9%9B%A2

## 并发管理

### 两阶段锁

2PL（两阶段锁定）算法是如何工作的 https://tonytancoder.github.io/2016/05/11/2PL-%E4%B8%A4%E9%98%B6%E6%AE%B5%E9%94%81%E5%AE%9A-%E7%AE%97%E6%B3%95%E5%A6%82%E4%BD%95%E5%B7%A5%E4%BD%9C/ || https://github.com/tonytanCoder/tonytancoder.github.io/blob/master/_posts/2016-05-11-2PL%EF%BC%88%E4%B8%A4%E9%98%B6%E6%AE%B5%E9%94%81%E5%AE%9A%EF%BC%89%E7%AE%97%E6%B3%95%E5%A6%82%E4%BD%95%E5%B7%A5%E4%BD%9C.md
- > 最初，所有数据库系统都采用2PL来实现可串行化事务，但是随着时间的流逝，许多供应商已转向[MVCC（多版本并发控制）](https://vladmihalcea.com/how-does-mvcc-multi-version-concurrency-control-work/)并发控制机制。

https://www.cnblogs.com/zszmhd/p/3365220.html

https://www.2cto.com/database/201403/286730.html

## 索引

### 倒排索引 (Inverted index)

倒排索引 https://zh.wikipedia.org/wiki/%E5%80%92%E6%8E%92%E7%B4%A2%E5%BC%95 || Inverted index https://en.wikipedia.org/wiki/Inverted_index

倒排索引为什么叫倒排索引？ - 武培轩的回答 - 知乎 https://www.zhihu.com/question/23202010/answer/1054033556

### clustered index

<<深入 聚集索引与非聚集索引(一)>>
http://www.cnblogs.com/lwzz/archive/2012/08/05/2620824.html

<<聚集索引和非聚集索引（整理）>>
http://www.cnblogs.com/aspnethot/articles/1504082.html

聚合索引(clustered index) / 非聚合索引(nonclustered index) https://blog.csdn.net/lp_cq242/article/details/87861672
- > 其实，我们的汉语字典的正文本身就是一个聚集索引。比如，我们要查"安"字，就会很自然地翻开字典的前几页，因为"安"的拼音是"an"，而按照拼音排序汉字的字典是以英文字母"a"开头并以"z"结尾的，那么"安"字就自然地排在字典的前部。如果您翻完了所有以"a"开头的部分仍然找不到这个字，那么就说明您的字典中没有这个字；同样的，如果查"张"字，那您也会将您的字典翻到最后部分，因为"张"的拼音是"zhang"。也就是说，字典的正文部分本身就是一个目录，您不需要再去查其他目录来找到您需要找的内容。      
<br> 我们把这种正文内容本身就是一种按照一定规则排列的目录称为"聚集索引"。
- > 如果您认识某个字，您可以快速地从自动中查到这个字。但您也可能会遇到您不认识的字，不知道它的发音，这时候，您就不能按照刚才的方法找到您要查的字，而需要去根据"偏旁部首"查到您要找的字，然后根据这个字后的页码直接翻到某页来找到您要找的字。但您结合"部首目录"和"检字表"而查到的字的排序并不是真正的正文的排序方法，比如您查"张"字，我们可以看到在查部首之后的检字表中"张"的页码是672页，检字表中"张"的上面是"驰"字，但页码却是63页，"张"的下面是"弩"字，页面是390页。很显然，这些字并不是真正的分别位于"张"字的上下方，现在您看到的连续的"驰、张、弩"三字实际上就是他们在非聚集索引中的排序，是字典正文中的字在非聚集索引中的映射。我们可以通过这种方式来找到您所需要的字，但它需要两个过程，先找到目录中的结果，然后再翻到您所需要的页码。      
<br> 我们把这种目录纯粹是目录，正文纯粹是正文的排序方式称为"非聚集索引"。 
- > 进一步引申一下，我们可以很容易的理解：每个表只能有一个聚集索引 ，因为目录只能按照一种方法进行排序。

MySQL聚合索引与非聚合索引 "聚合索引（ClusteredIndex）" https://www.jianshu.com/p/cd697a425232

<<唯一性索引（Unique Index）与普通索引（Normal Index）差异（上）>>
http://blog.itpub.net/17203031/viewspace-700089/

How does database indexing work? [closed] https://stackoverflow.com/questions/1108/how-does-database-indexing-work

## 位图索引

Bitmap index https://en.wikipedia.org/wiki/Bitmap_index
- > Their drawback is they are less efficient than the traditional B-tree indexes for columns whose data is frequently updated: consequently, they are more often employed in read-only systems that are specialized for fast query - e.g., data warehouses, and generally unsuitable for online transaction processing applications.

位图索引:原理（BitMap index） https://www.cnblogs.com/LBSer/p/3322630.html

## SQL

SQL编程大赛总结 https://blog.csdn.net/yzsind/article/details/6328864

17 Sites for SQL Practice https://www.databasestar.com/sql-practice/
- SQLZoo
- HackerRank
- Oracle Live SQL

【from datacamp】
- Introduction to SQL https://learn.datacamp.com/courses/introduction-to-sql

在线就能用的 SQL 练习平台我给你找好了！ - Rocky0429的文章 - 知乎 https://zhuanlan.zhihu.com/p/92590262
- SQLZOO -- Learn SQL using: SQL Server, Oracle, MySQL, DB2, and PostgreSQL. https://sqlzoo.net/
- SQLBolt -- Learn SQL with simple, interactive exercises. https://sqlbolt.com/

SQL面试72题 - 丁哥开讲的文章 - 知乎 https://zhuanlan.zhihu.com/p/81731308

52条SQL语句性能优化策略，建议收藏 https://mp.weixin.qq.com/s/1QTZawn0OU2ktE_XGOfpRw

## SQL Join

left join,right join,inner join,full join之间的区别 https://www.cnblogs.com/lijingran/p/9001302.html

Mysql 多表连接查询 inner join 和 outer join 的使用 https://www.cnblogs.com/wanglijun/p/8916790.html

What's the difference between INNER JOIN, LEFT JOIN, RIGHT JOIN and FULL JOIN? [duplicate] https://stackoverflow.com/questions/5706437/whats-the-difference-between-inner-join-left-join-right-join-and-full-join

Hash join算法原理 https://www.cnblogs.com/qlee/archive/2011/04/11/2012572.html
- > 自从oracke 7.3以来，oracle提供了一种新的join技术，就是hash join。Hash Join只能用于相等连接，且只能在CBO优化器模式下。相对于nested loop join，hash join更适合处理大型结果集。Hash join不需要在驱动表上存在索引。

## 关系代数

Relational algebra https://en.wikipedia.org/wiki/Relational_algebra

Relational Algebraic Equivalence Transformation Rules https://www.postgresql.org/message-id/attachment/32513/EquivalenceRules.pdf

Relational algebra -- Basic Operations Algebra of Bags http://infolab.stanford.edu/~ullman/fcdb/aut07/slides/ra.pdf

### 证明两个SQL相当或者说语意是一样的

Mathematical equality of two SQL statements https://dba.stackexchange.com/questions/96865/mathematical-equality-of-two-sql-statements

Introducing Cosette https://medium.com/@uwdb/introducing-cosette-527898504bd6

Check if two "select"s are equivalent https://stackoverflow.com/questions/5727882/check-if-two-selects-are-equivalent

automated check if two SQL queries are semantically equal https://stackoverflow.com/questions/36304088/automated-check-if-two-sql-queries-are-semantically-equal

## 优化器

ORACLE优化器RBO与CBO介绍总结 https://www.cnblogs.com/kerrycode/p/3842215.html
- > Oracle数据库中的优化器又叫查询优化器（Query Optimizer）。它是SQL分析和执行的优化工具，它负责生成、制定SQL的执行计划。Oracle的优化器有两种，基于规则的优化器（RBO）与基于代价的优化器（CBO)
  * > RBO: Rule-Based Optimization 基于规则的优化器
  * > CBO: Cost-Based Optimization 基于代价的优化器
- > RBO自ORACLE 6以来被采用，一直沿用至ORACLE 9i. ORACLE 10g开始，ORACLE已经彻底丢弃了RBO，它有着一套严格的使用规则，只要你按照它去写SQL语句，无论数据表中的内容怎样，也不会影响到你的“执行计划”，也就是说RBO对数据不“敏感”；它根据ORACLE指定的优先顺序规则，对指定的表进行执行计划的选择。比如在规则中，索引的优先级大于全表扫描;RBO是根据可用的访问路径以及访问路径等级来选择执行计划，在RBO中，SQL的写法往往会影响执行计划，它要求开发人员非常了解RBO的各项细则，菜鸟写出来的SQL脚本性能可能非常差。随着RBO的被遗弃，渐渐不为人所知。也许只有老一辈的DBA对其了解得比较深入。关于RBO的访问路径，官方文档做了详细介绍：
  >> 【[:star:][`*`]】 //notes：一共 `15` 条优化器规则，官网链接如下：
  >>> 8 Using the Rule-Based Optimizer https://docs.oracle.com/cd/B10501_01/server.920/a96533/rbo.htm

24 Optimization of Joins https://docs.oracle.com/cd/F49540_01/DOC/server.815/a67781/c20c_joi.htm

优化规则与表达式下推的黑名单 https://docs.pingcap.com/zh/tidb/stable/blocklist-control-plan

| **优化规则** | **规则名称** | **简介** |
|--|--|--|
| 列裁剪 | column_prune | 对于上层算子不需要的列，不在下层算子输出该列，减少计算 |
| 子查询去关联|decorrelate | 尝试对相关子查询进行改写，将其转换为普通 join 或 aggregation 计算 |
| 聚合消除 | aggregation_eliminate | 尝试消除执行计划中的某些不必要的聚合算子 |
| 投影消除 | projection_eliminate | 消除执行计划中不必要的投影算子 |
| 最大最小消除 | max_min_eliminate | 改写聚合中的 max/min 计算，转化为 `order by` + `limit 1` |
| 谓词下推 | predicate_push_down | 尝试将执行计划中过滤条件下推到离数据源更近的算子上 |
| 外连接消除 | outer_join_eliminate | 尝试消除执行计划中不必要的 left join 或者 right join |
| 分区裁剪 | partition_processor | 将分区表查询改成为用 union all，并裁剪掉不满足过滤条件的分区 |
| 聚合下推 | aggregation_push_down | 尝试将执行计划中的聚合算子下推到更底层的计算节点 |
| TopN 下推 | topn_push_down | 尝试将执行计划中的 TopN 算子下推到离数据源更近的算子上 |
| Join 重排序 | join_reorder | 对多表 join 确定连接顺序 |

StarRocks 技术内幕 | Join 查询优化 - StarRocks的文章 - 知乎 https://zhuanlan.zhihu.com/p/580164199

# 执行引擎

【[:star:][`*`]】 数据库内核杂谈（顾仲贤） https://www.infoq.cn/theme/46
- 数据库内核杂谈（四）：执行模式 https://www.infoq.cn/article/spfisufzenc6utrftsdd
- 数据库内核杂谈（七）：数据库优化器（上） https://www.infoq.cn/article/GhhQlV10HWLFQjTTxRtA
- 数据库内核杂谈（八）：数据库优化器（下） https://www.infoq.cn/article/JCJyMrGDQHl8osMFQ7ZR
- 数据库内核杂谈（九）：开源优化器 ORCA https://www.infoq.cn/article/5o16ehoz5zk6fzpsjpt2

SQL是如何在数据库中执行的？ https://segmentfault.com/a/1190000037792613

## 向量化执行

深入解析 TiFlash丨面向编译器的自动向量化加速 https://mp.weixin.qq.com/s/7K90wCDc6mSdT1SfddlVaw
- > **SIMD 介绍**
  * > SIMD 是重要的程序加速手段。CMU DB 组在 `Advanced Database Systems` 中有专门的两个章节（`vectorization-1`, `vectorization-2`）介绍 SIMD 向量化在数据库中的应用，可见其对现代数据库系统的重要性。
  * > TiFlash 目前支持的架构是 x86-64 和 Aarch64，操作系统平台有 Linux 和 MacOS。受制于平台 ISA 和操作系统 API，在不同环境中做 SIMD 支持会遇到不同的麻烦。

SQL优化之火山模型、向量化、编译执行 https://blog.csdn.net/u011436427/article/details/121805600

向量化引擎对HTAP的价值与技术思考 https://mp.weixin.qq.com/s/cq4tPEBPfKAesrgviEq1CA
- > 在详细介绍向量化引擎特点前，我们先了解一下火山模型以及火山模型存在的典型问题。在数据库发展早期，由于 IO 速度低下、内存和 CPU 资源非常昂贵，为了避免爆内存的情况出现，每次只计算一行数据的火山模型成为了经典的 SQL 计算引擎。火山模型又叫迭代器模型，正式提出是在 1994 年论文《Volcano—An Extensible and Parallel Query Evaluation System》。早期很多关系型数据库都在使用火山模型，如 Oracle、Db2、SQLServer、MySQL、PostgreSQL、MongoDB 等。
- > 2005 年，一篇题为《MonetDB/X100: Hyper-Pipelining Query Execution》的论文首次提出“向量化引擎”的概念。不同于传统的火山模型按行迭代的方式，向量化引擎采用批量迭代方式，可以在算子间一次传递一批数据。换句话说，向量化实现了从一次对一个值进行运算，到一次对一组值进行运算的跨越。
- > 论文《DBMSs On A Modern Processor: Where Does Time Go?》还介绍了分支预测失败对数据库性能的影响。由于 CPU 中断了流水执行，重新刷新流水线，因此分支预测失败对数据库处理性能的影响很大。SIGMOD13 的论文《Micro Adaptivity in Vectorwise》也对分支在不同选择率下的执行效率有详细论述（下图）。

# 故障恢复

容灾管理中的RTO与RPO的关系 https://www.cnblogs.com/kouryoushine/p/8301372.html

一文带你了解 RTO 和 RPO https://leehao.me/%E4%B8%80%E6%96%87%E5%B8%A6%E4%BD%A0%E4%BA%86%E8%A7%A3-RTO-%E5%92%8C-RPO/ || https://blog.csdn.net/lihao21/article/details/103950110
- > ![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9sZWVoYW8ub3NzLWNuLXNoZW56aGVuLmFsaXl1bmNzLmNvbS8yMDIwLTAxLTEyLTE0MDA0My5qcGc)
- > **RTO**
  * > RTO，Recovery time objective，恢复时间目标，是指所能容忍的业务系统停止服务的最长时间，也就是灾难发生到业务系统恢复服务功能所需要的最短时间，即如上图所示，How long to recover? 所标示灾难发生到系统服务恢复的时间。
  * > 例如，如果 RTO 为 1 小时，这意味着能容忍业务系统停止服务的时间为 1 小时，即虽然业务系统在这 1 小时内不能提供服务，但业务可以正常维持进行。如果业务系统在 1 小时后仍不能恢复，则业务可能会遭受无法弥补的损失。
- > **RPO**
  * > RPO，Recovery point objective，恢复点目标，是指业务系统所能容忍的数据丢失量，即如上图所示，How far back? 所标示的灾难发生到最近数据一次备份的时间。
  * > 例如，业务系统数据在每天零点进行备份，在某天上午 8 点发生事故，导致有 8 个小时间数据丢失。如果原先设置的业务系统 RPO 为 24 小时，则并无大碍，但如果 RPO 为 4 小时，则会导致业务受到影响以致造成损失。
- > **相同点与不同点**
  * > RTO 和 RPO 都是使用时间来度量。对于 RTO 时间，是指灾难发生到服务恢复的时间，这个时间也包含了数据恢复的时间。对于 RPO 时间，是指灾难发生到数据上一次备份的时间。
  * > 虽然 RTO 和 RPO 都使用时间来度量，但是使用它们的目的却不相同。RTO 关注于应用或系统的可用性，RTO 虽然包含数据恢复的时间，但更多地是描述应用停机的时间限制。
  * > RPO 关注于数据的完整性，描述所能容忍的最大数据丢失限制。业务系统服务不可用会带来经济损失，但如果丢失的是客户交易数据则导致的损失更是灾难性的。
  * > 在制定企业的容灾计划时，需要考虑 RTO 和 RPO 目标，然而 RTO 和 RPO 目标的成本存在差异。***维护一个高要求的 RTO 目标的成本可能比 RPO 目标的成本要高，这是因为 RTO 涉及到整个业务基础架构，而不仅仅是数据***。
  * > 要实现 RPO 目标，只需要以正确的时间间隔执行数据备份，数据备份可以很容易地自动化实现，因此自动化的 RPO 策略很容易实现。另一方面，由于 RTO 涉及恢复所有 IT 操作，因此完全自动化的 RTO 策略实现更复杂。

携程DBA负责人俞榕刚：OceanBase在携程的落地和实践 https://www.163.com/dy/article/GULGPE7P0552THQJ.html
- > OceanBase 使用优化的 paxos 协议结合物理日志复制强保证多数派的数据一致性，也就是三副本情况下强保证至少两个副本数据一致性，使用 OceanBase 保证了 `RPO=0`，实际测试下来`RTO＜30s`，满足携程金融业务的数据一致性的要求。

# OLAP

列存（Column-Oriented）数据库学习笔记：内存数据压缩 https://www.jianshu.com/p/2e169006798f

# 其他

## 数据库面试

数据库面试题(开发者必看) https://juejin.im/post/5a9ca0d6518825555c1d1acd || https://segmentfault.com/a/1190000013517914

数据库面试知识点汇总 https://ac.nowcoder.com/discuss/135748

常见面试题整理--数据库篇（每位开发者必备） - 路人甲的文章 - 知乎 https://zhuanlan.zhihu.com/p/23713529

面试必备之乐观锁与悲观锁 https://juejin.im/post/5b4977ae5188251b146b2fc8
- > 悲观锁  总是假设最坏的情况，每次去拿数据的时候都认为别人会修改，所以每次在拿数据的时候都会上锁，这样别人想拿这个数据就会阻塞直到它拿到锁（**共享资源每次只给一个线程使用，其它线程阻塞，用完后再把资源转让给其它线程**）。传统的关系型数据库里边就用到了很多这种锁机制，比如行锁，表锁等，读锁，写锁等，都是在做操作之前先上锁。Java中synchronized和ReentrantLock等独占锁就是悲观锁思想的实现。
- > 乐观锁  总是假设最好的情况，每次去拿数据的时候都认为别人不会修改，所以不会上锁，但是在更新的时候会判断一下在此期间别人有没有去更新这个数据，可以使用版本号机制和CAS算法实现。**乐观锁适用于多读的应用类型，这样可以提高吞吐量**，像数据库提供的类似于write_condition机制，其实都是提供的乐观锁。在Java中java.util.concurrent.atomic包下面的原子变量类就是使用了乐观锁的一种实现方式**CAS**实现的。
- > 两种锁的使用场景  从上面对两种锁的介绍，我们知道两种锁各有优缺点，不可认为一种好于另一种，像**乐观锁适用于写比较少的情况下（多读场景）**，即冲突真的很少发生的时候，这样可以省去了锁的开销，加大了系统的整个吞吐量。但如果是多写的情况，一般会经常产生冲突，这就会导致上层应用会不断的进行retry，这样反倒是降低了性能，所以**一般多写的场景下用悲观锁就比较合适**。
- > 乐观锁一般会使用版本号机制或CAS算法实现。
  * 外部链接：《无锁算法——CAS原理》 https://blog.csdn.net/Roy_70/article/details/69799845

Mysql高频面试题 -为什么 B+ 树比 B 树更适合应用于数据库索引？ - 派派的文章 - 知乎 https://zhuanlan.zhihu.com/p/337724181

数据库常见面试题（附答案） https://blog.csdn.net/qq_22222499/article/details/79060495

https://leetcode-cn.com/circle/discuss/6xECGC/
- https://blog.csdn.net/w139074301/article/details/112004430

https://blog.csdn.net/w139074301/article/details/112004430
- > **Mysql 事务是如何实现的**
  * > 原子性：通过undo log实现的。每条数据变更都伴随一条undo log日志的生成，当系统发生错误或执行回滚根据undo log做逆向操作
  * > 持久性：通过redo log实现的。redo log记录了数据的修改日志。数据持久化到磁盘，先是储存到缓冲池里，然后缓冲池中的数据定期同步到磁盘中，如果系统宕机，可能会丢失数据，系统重启后会读取redo log恢复数据
- > **谈一谈 MVCC 多版本并发控制**
  * > MVCC是通过在每行记录后面保存两个隐藏的列来实现的。这两个列，一个保存了行的创建时间，一个保存行的过期时间（或删除时间）。当然存储的并不是实际的时间值，而是系统版本号（system version number)。每开始一个新的事务，系统版本号都会自动递增。事务开始时刻的系统版本号会作为事务的版本号，用来和查询到的每行记录的版本号进行比较。
- > **Mysql 读写分离有哪些解决办法**
  * > 参考文章：[MySQL读写分离](https://www.jianshu.com/p/bc45c8bccf3c)

## 1NF, 2NF, BCNF

如何理解关系型数据库的常见设计范式？ - 刘慰的回答 - 知乎 https://www.zhihu.com/question/24696366/answer/29189700

Normalization of Database——数据库的正规化 https://blog.csdn.net/qq_37174526/article/details/82776291

# 待分类

【[:star:][`*`]】 分库分表 or NewSQL数据库？终于看懂应该怎么选！ https://dbaplus.cn/news-159-2690-1.html || https://mp.weixin.qq.com/s/ymVxSe8nueuG7knKwcIAMw

数据架构选型必读：1月数据库产品技术解析 https://dbaplus.cn/news-141-2437-1.html
