
# 0

PostgreSQL中的锁 http://www.postgres.cn/news/viewone/1/241
- > **2.`spinLock`使用场景分析.**
  * > 下面我们讨论对于spinlock的使用场景，***spinlock属于轻量级的锁，适用于对某个share object操作较多，并且占用时间不长的情景下使用***，即我们在较小的代码中使用，对于复杂场景下的使用我们一般不采用spinlock，而采取其他方式。实例代码如下：
  * > 从上述的使用可以看出，spinlock所包含的临界区通常较小，通常为数行代码范围内，正是由于spinlock的特点要求我们在临界区内进行快进快出的操作；相反，如果临界区属于一大段具有复杂逻辑关系的代码则不适合使用spinlock进行。首先，大段临界区代码需要执行较长的时间，而spinlock又属于wait-and-loop方式，从而使得大量的CPU处于空转状态严重消耗资源；再者，在一大段逻辑复杂的临界区内当执行发生异常程序流程跳转后，不容易确定spinlock释放的正确位置，容易造成死锁。而spinlock又不存在死锁检查机制来消除死锁。因此，我们需要一种能够解决上述问题的一种新的锁。幸好，Postgres提供了`轻量锁（Light Weight Lock）`-`LWLock`；
- > **3.`LWLock`原理分析.**
  * > ***`LigthWeight Lock`我们称为`轻量锁`***，其主要是以互斥访问的方式用来保护共享内存数据结构，下面是Postgres对于LWLock的说明，从中我们可以清楚的看到该种类型的锁的目的和作用以及执行保护的方式。其提供两种锁访问方式：共享锁和独享锁。其相应的代码分别在：`storage/lmgr/lwlock.xxx`文件中。 与`spinlock`相比较而言，`LWLock`又是基于什么样的机制来实现的呢？ 在早期的`LwLock`实现过程中使用了 `spinlock` 作为其底层实现。我们可以从其相应如下的数据结构可以看出。在早期的版本中：`LWLock`使用一个链表( `PGPROC *head ,PGPROC *tail` )来保存那些正在争取访问锁而暂时无法得到满足的进程，我们称之为 Waiting List；同时，使用shared来描述先在共同持有该共享锁的进程数，`LWlock`在所有已知的平台下其大小在16-32个字节。
  * > 但在最新的版本中，我们可以其已经将`spinlock`从`LWLock`的定义中移除，去而代之是一个uint32类型的状态-state。与spinlock的机制相似我们通过对该state对象的操作来实现高效的锁机制，可以说其实质也是由spinlock来支持的。相应的waiting list也将链表形式由直接通过指针访问方式改为通过进程编号在PGPROC进程链表中获取链表节点的方式来获取是哪个进程处于等待锁的状态。
  * > 除了上述的独享和共享模式之外，LWLock也可以用来执行对某个变量满足特定条件的等待操作，LWLockWaitForVar。
  * > ***为了系统在访问LWLock时的速度，我们通常将LWLock的大小限制为2的幂保证每个LWLock对象不会跨越cache line边界，因而可以降低了cache竞争***；在9.4版本之前，每个LWLock将会保存在一个单独的数组中并存放于主共享内存中（Main Shared Memory），但在最新的版本中我们还可以将LWLock保存动态共享内存段中（Dynamic Shared Segment，DSM），最后形成一个含有32槽（Lock Tranches）的锁槽，LWLockTranche。其中有：main，buffer_mapping，lock_manager，predicate_lock_mangaer等。

【[ :star: ][`*`]】 一文搞懂PostgreSQL中所有的锁 https://mp.weixin.qq.com/s/a3xmcJSzLQV4cUxNJGXaiQ || https://www.modb.pro/db/70021
- > **锁**
  * > 为了确保复杂的事务可以安全地同时运行，PostgreSQL提供了各种级别的锁来控制对各种数据对象的并发访问，使得对数据库关键部分的更改序列化。事务并发运行，直到它们尝试获取互相冲突的锁为止(比如两个事务更新同一行时)。当多个事务同时在数据库中运行时，并发控制是一种用于维持一致性和隔离性的技术，在PostgreSQL中，使用快照隔离Sanpshot Isolation (简称SI) 来实现多版本并发控制，同时以两阶段锁定 (2PL) 机制为辅。***在执行DDL时使用2PL，在执行DML时使用SI***。 <br> `PostgreSQL uses SSI for DML (Data Manipulation Language, e.g, SELECT, UPDATE, INSERT, DELETE), and 2PL for DDL (Data Definition Language, e.g., CREATE TABLE, etc).`
  * > 2PL (两阶段锁定)算法是关系数据库系统用来保证数据完整性的最古老的并发控制机制之一。
- > **Table-Level Locks**
  * > 在PostgreSQL中，表级锁分为8种，如下：![](https://mmbiz.qpic.cn/mmbiz_png/lniadOK6Dzb61cYiaZZ3NiaCeyMdBjRxfSBSM0tyiaIMbN5Fsialaj7LevOSicbUvzqgduzmBRkzlgu6rxiaeV1TLvKTw/640)
  * > 上图不方便理解和记忆，将对应的锁转换成常见的SQL就明了了，如下：![](https://mmbiz.qpic.cn/mmbiz_png/lniadOK6Dzb61cYiaZZ3NiaCeyMdBjRxfSBGoJcu0BUt0VTxwwknKnbaZYZmRqia3vbvQdmypDvAHED1PvicDhUt1Hw/640)
  * > 快速记忆法：
    + > `ACCESS SHARE`和`ACCESS EXCLUSIVE`可以理解为多版本读/写，SELECT会在查询的表上获取ACCESS SHARE，而那些很硬的操作，诸如TRUNCATE、DROP TABLE等都会获取ACCESS EXCLUSIVE。
    + > `ROW SHARE`和`ROW EXCLUSIVE`可以理解为`意向读/写锁`，`意向锁`根据名字，就是意向做一件事，但并非实际执行，所以可以看到ROW SHARE和ROW EXCLUSIVE之间互不冲突。当要更新插入时，需要先在对应的表上获取ROW EXCLUSIVE锁。
    + > `SHARE`和`EXCLUSIVE`为传统的读写锁，在PostgreSQL中有点变化，EXCLUSIVE锁出现频率很低，***`SHARE`锁用在了<ins>创建索引的时候</ins>，因为SHARE锁不自斥，所以也就意味着在一张表上可以同时创建多个索引，但是会堵塞插入更新等(和`ROW EXCLUSIVE`冲突)***。
    + > 而`SHARE UPDATE EXCLUSIVE`和`SHARE ROW EXCLUSIVE`两种锁比较难记忆，SHARE UPDATE EXCLUSIVE在VACUUM和ALTER TABLE SET(XXX)等操作时会获取，因为SHARE UPDATE EXCLUSIVE是自斥的，所以目前PostgreSQL无法做到表级的并行VACUUM，但可以做到库级的并行VACUUM(好消息是，在刚刚发布不久的POSTGRESQL13中，对索引的清理支持并行了)；SHARE ROW EXCLUSIVE出现的概率较低，一般常见的是创建触发器。
- > **Row-Level Locks**
  * > 表级锁存在于PostgreSQL的shared buffers中，所以可以很直观的通过pg_locks查看。但是行级锁不一样，PostgreSQL不会将已获得的行级锁信息存储在内存中，如果在pg_locks中查看到了行锁信息，并不代表行锁信息存储在内存中，这种情况往往出现在行锁等待，比如后文会介绍的“tuple锁”，行锁通常只在tuple的header中设置标记位来标识此行记录已经被锁。这两个关键的标记为`xmax`和`infomask`(`HEAP_UPDATED`)。xmax放置当前事务的xid，infomask放置标记位，可能还有HOT
  * > 行级锁的冲突矩阵如下： <br> ![](https://mmbiz.qpic.cn/mmbiz_png/lniadOK6Dzb61cYiaZZ3NiaCeyMdBjRxfSBs6iaVvA8NPdiclX6wjq2Fn1q8tOh5w9I9agHS1kdlB149ksia1AxhCSwg/640) <br> ![](https://mmbiz.qpic.cn/mmbiz_png/lniadOK6Dzb61cYiaZZ3NiaCeyMdBjRxfSB365lzfNjibmlIFT4zfKlBicIibRZ41IdAX8umZhX6Vk0VFcFR5SpAz7dw/640)
    + > FOR UPDATE：对整行进行更新，包括删除行
    + > FOR NO KEY UPDATE：对除主(唯一)键外的字段更新
    + > FOR SHARE：读该行，不允许对行进行更新
    + > FOR KEY SHARE：读该行的键值，但允许对除键外的其他字段更新。在外键检查时使用该锁
- > **Page-Level Locks**
  * > PostgreSQL中，有对于表的数据页的共享/互斥锁，一旦这些行读取或者更改完成后，相应的页锁就被释放。比较常见的有：
    + > `WalInsertLock`，wal buffer是固定大小的，向wal buffer中写wal record需要竞争的锁，如果把synchronous_commit关闭，这个锁的竞争会更加激烈；
    + > `WALWriteLock`：一般都是同步提交，要保证commit时，wal是刷盘的，那么刷盘就会竞争这个锁。将页面写入磁盘会受WALWriteLock锁保护，一次只能有一个进程可以执行此操作。
    + > `ProcArrayLock`，对于每一个连接，在shared buffer中都有一个结构体 PGPROC 用于追踪正在运行的后端进程和事务，每个backend在事务在commit或abort时，都要对其 PGPROC 和 PGXACT 中关于事务状态的属性进行设置，标记对应的事务不再运行。
  * > 一般不怎么需要关心页锁，但是假如在 `pg_stat_activity` 视图里面看到了大量相关的等待事件，也需要特别注意。比如出现了大量的BufferMapping，说明buffer发生了频繁替换导致了锁等待，可能存在大量表扫描，buffer太小了或io存在瓶颈、磁盘太烂了等原因。
  * > 目前PostgreSQL13.3定义了这么多LWLock：
- > **Spin Lock**
  * > 编程中常听说的自旋锁，PostgreSQL中同样也有，SpinLock主要用于对于临界变量的并发访问控制，所保护的临界区通常是简单的赋值语句，读取语句等。另外，***自旋锁的显著特点就是死等，占着茅坑不拉屎，<ins>SpinLock没有等待队列、死锁检测机制，在事务结束之后不会自动释放</ins>，需要每次显式释放***。在PostgreSQL中，使用CPU指令集test-and-set或者信号量来实现自旋锁。
- > **Deadlocks**
  * > 死锁在各大主流数据库中都有，当一个事务试图获取另一个事务已在使用的资源，而第二个事务又试图获取第一个事务在使用的资源时，就会发生死锁，在PostgreSQL中，有`lock_timeout`、`deadlock_timeout`、`log_lock_waits(日志记录)`等参数控制。死锁检测是一件十分耗费资源的事情，大多数时候，一旦检测到死锁，则其中一个事务(大多数情况下是发起检查的事务)将被迫中止。
- > **advisory Locks**
  * > 当MVCC模型和锁策略不符合应用时，采用`咨询锁`。***PostgreSQL允许用户创建咨询锁，<ins>该锁与数据库本身没有关系</ins>，比如多个进程访问同一个数据库时，如果想协调这些进程对一些非数据库资源的并发访问，就可以使用咨询锁***。咨询锁是提供给应用层显示调用的锁方法，***在表中存储一个标记位能够实现同样的功能，但是咨询锁更快；并且避免表膨胀，且会话(或事务)结束后能够被自动清理***。 <br> `Once acquired at session level, an advisory lock is held until explicitly released or the session ends. Unlike standard lock requests, session-level advisory lock requests do not honor transaction semantics: a lock acquired during a transaction that is later rolled back will still be held following the rollback, and likewise an unlock is effective even if the calling transaction fails later. A lock can be acquired multiple times by its owning process; for each completed lock request there must be a corresponding unlock request before the lock is actually released.` <br> `Transaction-level lock requests, on the other hand, behave more like regular lock requests: they are automatically released at the end of the transaction, and there is no explicit unlock operation. This behavior is often more convenient than the session-level behavior for short-term usage of an advisory lock.`
  * > 以下内容引自德哥：
    + > 某些业务会利用数据库来作为一种可靠的锁，例如任务调度系统，或者其他需要可靠的锁机制的系统。通常他们可能会使用数据库的一条记录来实现锁的SLOT和状态信息。比如：
    + > 当多个客户端并行获得同一个任务时，就会引发冲突，导致等待（***虽然等待时间可能不长，但是在大型任务调度系统中，一点点的等待都无法忍受***）。如何解决这个冲突等待呢？`advisory lock`登场，***实际上在`秒杀业务`中我们也看到了它的踪影***。
- > **实战**
- > **小结**
  * > 本篇主要介绍了PostgreSQL中常见的锁，其中最为常见的是RegularLock，RegularLock又可以分为`表级锁`和`行级锁`，***由于行级锁不在内存中，一般行级锁的等待表现为等待另一个会话的`transacitonid Exclusive Lock`的释放，显示的形式通常是一个事务等待另一个事务，而不是等待某个具体的行锁***。
  * > 相比于SpinLock、LWLock，RegularLock加锁的开销更大，但是提供更加丰富的锁模式，为数据库不同的操作场景提供了更细粒度的锁冲突控制，尽可能地提供了数据库的高并发访问。
  * > 而`LWLock`主要提供对`共享内存变量`的互斥访问，比如`Clog buffer(事务提交状态缓存)`、`Shared buffers(数据页缓存)`、`Substran buffer(子事务缓存)`等等，***所以backend进程独有的buffer是不需要锁的，因为它只被本backend进程独享，是local的。如临时表等***。
  * > `SpinLock`主要用于对于`临界变量`的并发访问控制，另外PostgreSQL中的`咨询锁`对于应用来说也是一个福音，可以避免争用数据库资源，至于死锁，在任何数据库中都是需要特别注意的DB Killer。

# 1

Postgres Locks — A Deep Dive https://medium.com/@hnasr/postgres-locks-a-deep-dive-9fc158a5641c || https://web.archive.org/web/20241115114426/https://medium.com/@hnasr/postgres-locks-a-deep-dive-9fc158a5641c
- > **Table Locks 表锁**
- > **Row Locks 行锁**
  * > Worth noting that INSERTed tuples don’t require row locks in postgres because they are only visible to the transaction that creates them. One reason probably why Postgres doesn’t support read uncommitted isolation level. 值得注意的是，***`INSERT` 元组不需要 postgres 中的行锁，因为它们仅对创建它们的事务可见***。 Postgres 不支持读未提交隔离级别的原因之一可能是。

Postgresql源码（69）常规锁细节分析 https://blog.csdn.net/jackgo73/article/details/126260915

~~PostgreSQL中的锁 https://mp.weixin.qq.com/s/JCKKM8vDkBlq0-PlPqfh7Q || https://pigsty.cc/zh/blog/dev/pg-lock/~~  【//已转移】

~~PostgreSQL技术内幕12：PostgreSQL事务原理解析-锁管理 https://mp.weixin.qq.com/s/qvMRW4fiwZaiLuasUK3ktg~~  【//已转移】

PostgreSQL locking, part 3: lightweight locks https://www.percona.com/blog/postgresql-locking-part-3-lightweight-locks/
- > Potential heavy contention places
  * > `WALInsertLock`: protects WAL buffers. You can increase the number of wal buffers to get a slight improvement. Incidentally, `synchronous_commit=off` increases pressure on the lock even more, but it’s not a bad thing. `full_page_writes=off` reduces contention, but it’s generally not recommended.
  * > `WALWriteLock`: accrued by PostgreSQL processes while WAL records are flushed to disk or during a WAL segments switch. `synchronous_commit=off` removes the wait for disk flush, `full_page_writes=off` reduces the amount of data to flush.
  * > `LockMgrLock`: appears in top waits during a read-only workload. It latches relations regardless of its size. It’s not a single lock, but at least 16 partitions. Thus it’s important to use multiple tables during benchmarks and avoid single table anti-pattern in production.
  * > `ProcArrayLock`: Protects the ProcArray structure. Before PostgreSQL 9.0, every transaction acquired this lock exclusively before commit.
  * > `CLogControlLock`: protects CLogControl structure, if it shows on the top of pg_stat_activity, you should check the location of $PGDATA/pg_clog—it should be on a buffered file system.
  * > `SInvalidReadLock`: protects sinval array. Readers using shared lock. SICleanupQueue, and other array-wide updates, requires an exclusive lock. It shows at the top of the pg_stat_activity when the shared buffer pool is under stress. Using a higher number of shared_buffers helps to reduce contention.
  * > `BufMappingLocks`: protects regions of buffers. Sets 128 regions (16 before 9.5) of buffers to handle the whole buffer cache.
- > **Spinlocks**
  * > The lowest level for locking is spinlocks. Therefore, it’s implemented within CPU-specific instructions. PostgreSQL is trying to change an atomic variable value in a loop. If the value is changed from zero to one – the process obtained a spinlock. If it’s not possible to get a spinlock immediately, the process will increase its wait delay exponentially.  There is no monitoring on spinlocks and it’s not possible to release all accrued spinlocks at once. Due to the single state change, it’s also an exclusive lock. In order to simplify the porting of PostgreSQL to exotic CPU and OS variants, PostgreSQL uses OS semaphores for its spinlocks implementation. Of course, it’s significantly slower compared to native CPU instructions port.
