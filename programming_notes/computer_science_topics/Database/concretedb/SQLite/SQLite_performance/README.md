
# SQLite性能之`PRAGMA`

【[:star:][`*`]】 Sqlite3写性能优化-每秒百万条写入 https://blog.csdn.net/Ango_/article/details/122074816
- > **优化方式**
  * > 通过查阅资料和其他大牛们的博客，确定有几个点可以尝试：
    + > 关闭写同步，PRAGMA synchronous = OFF，在 sqlite3 中 synchronous 有三种模式，分别是 FULL，NORMAL 和 OFF，在系统意外终止的时候，安全性逐级减弱，FULL模式下，保证数据不会损坏，安全性最高，写入速度也最慢。OFF 模式会比 FULL 模式快50倍以上。
    + > 使用事务，如果有许多数据需要插入数据库，逐条插入，导致频繁的提交以及磁盘IO，使用事务机制，可以批量插入数据，可以极大的提升写入速度。实际测试中的情况是，开启事务之后，写入速度也可以提升近50倍。
    + > 执行准备，执行准备相当于将sql语句提前编译，省去每次执行sql语句时候的语法检查等操作，可以极大的优化sql语句的执行效率，其原理有点像 LuaJit 将 Lua 语言成静态机器码，提高运行速度。实测情况中，使用执行准备可以提升40倍的写入速度。
    + > 内存模式，sqlite3 支持内存模式，将数据库直接创建到内存中，打开地址传入”:memory:”即可，内存模式相比正常模式，可以省区IO的时间，使用内存模式的加速思路是，先将数据库创建到内存中，数据写入完整之后，再调用 “VACUUM INTO ‘out.db3’;” 语句将其写入到磁盘，在开启了执行准备的情况下，这种方式会稍微快上一点点。
- > **效率对比**
- > **测试代码**

In SQLite, do prepared statements really improve performance? https://stackoverflow.com/questions/1703203/in-sqlite-do-prepared-statements-really-improve-performance

Improve INSERT-per-second performance of SQLite https://stackoverflow.com/questions/1711631/improve-insert-per-second-performance-of-sqlite

sqlite3数据库最大可以是多大？可以存放多少数据？读写性能怎么样？ https://www.cnblogs.com/derekhan/p/10897421.html
- > **SQLite极致性能提升方法**:
  ```console
  关闭同步，Synchronous=Off，提升性能。添删改操作时不必同步等待写入磁盘，操作系统会延迟若干毫秒批量写入
  设置WAL模式，Journal Mode=WAL，减少锁定。写入向前日志模式，避免多线程访问时锁定数据库，写入时不必使用排它锁影响其它线程读取，而是把事务操作写入到WAL文件中，延迟合并
  加大缓存，Cache Size=5000，提升性能。操作系统通过文件映射MapFile把整个数据库文件映射进入内存，实际查询时会把用到数据所在附近页预先加载进入缓存，极大提升查询性能
  插入速度 5000~16000tps，依赖CPU，HDD/SSD差别不大，主要受限于SQLite.Data.dll的Prepare
  查询速度 非首次查询，缓存命中以后，索引查询基本上都是毫秒级。数据库较大则相应加大缓存，速度不变。
  查记录数 单表数据超过一千万行以后，尽量不要使用Select Count，否则可能需要十几秒到半分钟的样子才能返回。NewLife.XCode封装了'Meta.Count'
  ```
- > **SQLite大数据测试**

每天4亿行SQLite订单大数据测试（源码） https://developer.aliyun.com/article/385232 || https://www.cnblogs.com/nnhy/p/BigData.html || https://github.com/nnhy/BigData

Sqlite 数据库的性能 https://www.jianshu.com/p/facd602175ce

Improve INSERT-per-second performance of SQLite https://stackoverflow.com/questions/1711631/improve-insert-per-second-performance-of-sqlite

SQLite performance tuning https://gist.github.com/phiresky/978d8e204f77feaa0ab5cca08d2d5b27

Sqlite大批量导入数据提高效率的几种方式 https://www.cnblogs.com/HPAHPA/articles/7662268.html

Fast Bulk Inserts into SQLite http://blog.quibb.org/2010/08/fast-bulk-inserts-into-sqlite/
- > **Inserts within a Transaction**
- > **PRAGMA Statements**
  * > PRAGMA statements control the behavior of SQLite as a whole. They can be used to tweak options such as how often the data is flushed to disk of the size of the cache. These are some that are commonly used for performance. The SQLite documentation fully explains what they do and the implications of using them. For example, synchronous off will cause SQLite to not stop and wait for the data to get written to the hard drive. In the event of a crash or power failure, it is more likely the database could be corrupted.
    ```c
    sqlite3_exec(mDb, "PRAGMA synchronous=OFF", NULL, NULL, &errorMessage);
    sqlite3_exec(mDb, "PRAGMA count_changes=OFF", NULL, NULL, &errorMessage);
    sqlite3_exec(mDb, "PRAGMA journal_mode=MEMORY", NULL, NULL, &errorMessage);
    sqlite3_exec(mDb, "PRAGMA temp_store=MEMORY", NULL, NULL, &errorMessage);
    ```
    >> //notes：最关键的是第一个 `PRAGMA synchronous = OFF`，也就是关闭同步写。其他三个还没试。
    >>> //notes2：实际上 ***关闭同步写 + 开启事务 + Prepared语句*** 三个优化一上就基本已经够用了。
- > **Prepared Statements**
- > **Storing Data as Binary Blob**

关闭SQLite3中的journal暂存档 https://blog.csdn.net/chinaclock/article/details/50358439
- > 第一种方法:在系统开机后第一次开启或每一次使用SQLite数据库时，先检查是否已经存在journal档案了，如果是则透过程序自动去删除该journal档案。但是这有个问题，因为自动删除该journal档案，导致没有Rollback (还原)作用，无法保障数据完整与一致性。缺点二:有时候会发生程序无法自动删除(如:journal档案严重损毁)，而导致上面的问题(无法开启数据库)[问题1]再度发生。
- > 第二种方法:使用"`PRAGMA journal_mode = OFF`"指令，这个指令能关闭自动产生journal暂存档动作。但是如此一来当在写入数据库的过程，一旦发生意外状况，将会导致SQLite数据库无法保障数据完整与一致性。***缺点二:journal_mode设定为OFF时，无法使用交易模式(Transaction)进行操作***。第二种方法的缺点二在如果需要使用交易模式(Transaction)进行操作时，可以透过"`PRAGMA journal_mode = DELETE`"指令，修改回原本的journal模式(journal_mode)，就可以使用交易模式(Transaction)。

Sqlite3的synchronous的模式选择 https://blog.csdn.net/chinaclock/article/details/48622243
- > 个人理解最关键的地方在于：
  * > 数据库为了执行备份，备份文件依赖于写磁盘，然后才会写到数据库文件磁盘中。关键在于这里的写磁盘，都是调用系统的write接口，绝大部分都是直接写缓冲区的，只有调用sync才会将缓冲区中的数据flush到磁盘。所以在write，sync，再wirte再sync的过程中，**掉电后是否能恢复数据，依赖于sync是否有真正执行**。从这个角度看，FULL和NORMAL的区别，似乎就只有sync调用的频率，***FULL按照多人的意见是一个transaction一个sync，而NORMAL是多个transactions调一个sync***

SQLite3开启事务和关闭事务模式下，性能测试对比 https://blog.csdn.net/thomashtq/article/details/45029889

SQLite Pragma Cheatsheet for Performance and Consistency https://cj.rs/blog/sqlite-pragma-cheatsheet-for-performance-and-consistency/
- > **TL;DR**
  * > When Opening the DB
    ```console
    PRAGMA journal_mode = wal; -- different implementation of the atomicity properties
    PRAGMA synchronous = normal; -- synchronise less often to the filesystem
    PRAGMA foreign_keys = on; -- check foreign key reference, slightly worst performance
    ```
    > And check user_version to apply any migrations, for instance with this Rust library.
  * > When Closing the DB
    ```console
    PRAGMA analysis_limit=400; -- make sure pragma optimize does not take too long
    PRAGMA optimize; -- gather statistics to improve query optimization
    ```
- > **Allow Using More Memory**
  * > These two pragma could result in better performance, depending on your hardware and software configuration.
    + > Keep temporary storage in memory: `PRAGMA temp_store = 2`. However, setting this pragma does not guarantee that the temporary storage will be held in memory. Please refer to the documentation for other parameters that may change the final outcome.
    + > Keep more of the database pages in memory: for instance, ***use 32 MiB of memory for this purpose with `PRAGMA cache_size = -32000`***. Note that the OS cache is already keeping parts of the database file in RAM, so this might end up wasting memory.

SQLite performance tuning -- Scaling SQLite databases to many concurrent readers and multiple gigabytes while maintaining 100k SELECTs per second https://phiresky.github.io/blog/2020/sqlite-performance-tuning/
- > SQLite is an embedded SQL database. It’s extremely easy to setup, buildable as a single C file with libraries existing for basically all common programming languages. It doesn’t need any server setup or configuration since the SQL logic is run in the host process, and the database consists of only two files you can easily copy or move around. You can still connect to and query the same database concurrently with multiple processes, though only one write operation can happen at the same time.
- > SQLite is often seen as a toy database only suitable for databases with a few hundred entries and without any performance requirements, but you can scale a SQLite database to multiple GByte in size and many concurrent readers while maintaining high performance by applying the below optimizations.
- > **Run these every time you connect to the DB**
  * > Journal Mode
    ```console
    pragma journal_mode = WAL;
    ```
    > Instead of writing changes directly to the db file, write to a write-ahead-log instead and regularily commit the changes. This allows multiple concurrent readers even during an open write transaction, and can significantly improve performance.
  * > Synchronous Commit
    ```console
    pragma synchronous = normal;
    ```
    > or even synchronous=off. The default is full, which means every single update has to wait for FSYNC. Normal is still completely corruption safe in WAL mode, and means only WAL checkpoints have to wait for FSYNC. Off can cause db corruption, though I’ve never had problems. See here: https://www.sqlite.org/pragma.html#pragma_synchronous
  * > Temporary files location
    ```console
    pragma temp_store = memory;
    ```
    > Stores temporary indices / tables in memory. sqlite automatically creates temporary indices for some queries. Not sure how much this one helps. If your SQLite is creating temporary indices (check with EXPLAIN QUERY PLAN) you should probably create those indexes yourself in any case.
  * > Enable memory mapping
    ```console
    pragma mmap_size = 30000000000;
    ```
    > Uses memory mapping instead of read/write calls when the database is < mmap_size in bytes. Less syscalls, and pages and caches will be managed by the OS, so the performance of this depends on your operating system. Note that it will not use the amount of physical memory, it will just reserve virtual memory. The OS will then decide which pages are evicted and which stay in memory based on its usual "disk caching" logic. Should be much faster, at least on Linux and if you have a fair amount of memory for your SQLite process. If your database is larger than the given mmap_size, the first part of the database will still be memory mapped, the rest will be handled with read() / write() syscalls.
    > 
    > If you are on a 32-bit system you can probably only set this to less than $2^{32}$ bytes since the size of the virtual memory space is limited. Memory mapping can also have implications when there are I/O errors, see the official documentation.
  * > Increase the page size
    ```console
    pragma page_size = 32768;
    ```
    > This improved performance and db size a lot for me in one project, but it’s probably only useful if you are storing somewhat large blobs in your database and might not be good for other projects where rows are small. For writing queries SQLite will always only replace whole pages, so this increases the overhead of write queries.
- > **Summary**
  * > If you’re too lazy to read all the above, just run this on every database connect:
    ```console
    pragma journal_mode = WAL;
    pragma synchronous = normal;
    pragma temp_store = memory;
    pragma mmap_size = 30000000000;
    ```
- > **More things that must be run manually**
  * > Reorganize the database
    ```console
    pragma vacuum;
    ```
    > Run once to completely rewrite the db. Very expensive if your database is 100MB+.
  * > Re-analyze the database
    ```console
    pragma optimize;
    ```
    > `To achieve the best long-term query performance without the need to do a detailed engineering analysis of the application schema and SQL, it is recommended that applications run "PRAGMA optimize" (with no arguments) just before closing each database connection. Long-running applications might also benefit from setting a timer to run "PRAGMA optimize" every few hours.` https://www.sqlite.org/pragma.html#pragma_optimize
  * > Vacuum the database
    ```console
    pragma auto_vacuum = incremental; -- once on first DB create
    pragma incremental_vacuum; -- regularily
    ```
    > Probably not useful unless you expect your DB to shrink significantly regularily.
    > 
    > `The freelist pages are moved to the end of the database file and the database file is truncated to remove the freelist pages […]. Note, however, that auto-vacuum only truncates the freelist pages from the file. Auto-vacuum does not defragment the database nor repack individual database pages the way that the VACUUM command does. In fact, because it moves pages around within the file, auto-vacuum can actually make fragmentation worse.` https://www.sqlite.org/pragma.html#pragma_incremental_vacuum
- > **Regarding WAL mode**
  * > WAL mode has some issues where depending on the write pattern, the WAL size can grow to infinity, slowing down performance a lot. I think this usually happens when you have lots of writes that lock the table so sqlite never gets to doing wal_autocheckpoint. There’s a few ways to mitigate this:
    + > Reduce wal_autocheckpoint interval. No guarantees since all autocheckpoints are passive.
    + > Run pragma wal_checkpoint(full) or pragma wal_checkpoint(truncate) sometimes. With full, the WAL file won’t change size if other processes have the file open but still commit everything so new data will not cause the WAL file to grow. If you run truncate it will block other processes and reset the WAL file to zero bytes. Note that you can run these from a separate process, it will just block other write queries for a bit.

How can I synchronize to disk SQLite database with PRAGMA synchronous=OFF https://stackoverflow.com/questions/8150598/how-can-i-synchronize-to-disk-sqlite-database-with-pragma-synchronous-off
- https://stackoverflow.com/questions/8150598/how-can-i-synchronize-to-disk-sqlite-database-with-pragma-synchronous-off/10045134#10045134
  * > I would suggest you use the recently implemented WAL journal_mode. This way, you can leave synchronous to normal and have all your writes written to disk as you go: `Write transactions are very fast since they only involve writing the content once (versus twice for rollback-journal transactions) and because the writes are all sequential. Further, syncing the content to the disk is not required, as long as the application is willing to sacrifice durability following a power loss or hard reboot. (Writers sync the WAL on every transaction commit if PRAGMA synchronous is set to FULL but omit this sync if PRAGMA synchronous is set to NORMAL.)`
  * > The above is taken from: http://www.sqlite.org/wal.html
  * > If that is not enough, you can still then invoke PRAGMA database.wal_checkpoint; when you want to be certain that your writes are not only written to disk, but also "integrated" to your DB. Check the following for more information: http://www.sqlite.org/pragma.html#pragma_wal_checkpoint

# SQLite性能之多线程/多进程

【[:star:][`*`]】 14 | 存储优化（下）：数据库SQLite的使用和优化 https://blog.yorek.xyz/android/paid/master/storage_3/
- > 所以当时微信专门开展了一个重度用户优化的专项。一开始的时候我们集中在 SQLite 使用上的优化，例如表结构、索引等。但很快就发现由于系统版本的不同，SQLite 的实现也有所差异，经常会出现一些兼容性问题，并且也考虑到加密的诉求，我们决定单独引入自己的 SQLite 版本。
- > “源码在手，天下我有”，从此开启了一条研究数据库的“不归路”。那时我们投入了几个人专门去深入研究 SQLite 的源码，从 SQLite 的 PRAGMA 编译选项、Cursor 实现优化，到 SQLite 源码的优化，最后打造出从实验室到线上的整个监控体系。
- > 在 2017 年，我们开源了内部使用的 SQLite 数据库WCDB。这里多说两句，看一个开源项目是否靠谱，就看这个项目对产品本身有多重要。微信开源坚持内部与外部使用同一个版本，虽然我现在已经离开了微信团队，但还是欢迎有需要的同学使用 WCDB。
- > 在开始学习前我要提醒你，SQLite 的优化同样也很难通过一两篇文章就把每个细节都讲清楚。今天的内容我选择了一些比较重要的知识点，并且为你准备了大量的参考资料，遇到陌生或者不懂的地方需要结合参考资料反复学习。
- > **多进程并发**
- > **多线程并发**
- > **索引优化**
  * > 正确使用索引在大部分的场景可以大大降低查询速度，微信的数据库优化也是通过索引开始。下面是索引使用非常简单的一个例子，我们先从索引表找到数据对应的 rowid，然后再从原数据表直接通过 rowid 查询结果。 <br> ![](https://blog.yorek.xyz/assets/images/android/master/storage_3_1.gif)
  * > 关于 SQLite 索引的原理网上有很多文章，在这里我推荐一些参考资料给你：
    + > [SQLite 索引的原理](https://www.cnblogs.com/huahuahu/p/sqlite-suo-yin-de-yuan-li-ji-ying-yong.html)
    + > 官方文档：[Query Planning](https://www.sqlite.org/queryplanner.html#searching)
    + > [MySQL 索引背后的数据结构及算法原理](http://blog.codinglabs.org/articles/theory-of-mysql-index.html)
  * > 这里的关键在于如何正确的建立索引，很多时候我们以为已经建立了索引，但事实上并没有真正生效。例如使用了 `BETWEEN`、`LIKE`、`OR` 这些操作符、使用`表达式`或者 `case when` 等。更详细的规则可参考官方文档 [The SQLite Query Optimizer Overview](https://www.sqlite.org/optoverview.html)，下面是一个通过优化转换达到使用索引目的的例子。
    ```sql
    ## BETWEEN：myfiedl索引无法生效
    SELECT * FROM mytable WHERE myfield BETWEEN 10 and 20;
    ## 转换成：myfiedl索引可以生效
    SELECT * FROM mytable WHERE myfield >= 10 AND myfield <= 20;
    ```
  * > 建立索引是有代价的，需要一直维护索引表的更新。比如对于一个很小的表来说就没必要建索引；如果一个表经常是执行插入更新操作，那么也需要节制的建立索引。总的来说有几个原则：
    + > 建立正确的索引。这里不仅需要确保索引在查询中真正生效，我们还希望可以选择最高效的索引。如果一个表建立太多的索引，那么在查询的时候 SQLite 可能不会选择最好的来执行。
    + > 单列索引、多列索引与复合索引的选择。索引要综合数据表中不同的查询与排序语句一起考虑，如果查询结果集过大，还是希望可以通过复合索引直接在索引表返回查询结果。
    + > 索引字段的选择。整型类型索引效率会远高于字符串索引，而对于主键 SQLite 会默认帮我们建立索引，所以主键尽量不要用复杂字段。
  * > **总的来说索引优化是 SQLite 优化中最简单同时也是最有效的，但是它并不是简单的建一个索引就可以了，有的时候我们需要进一步调整查询语句甚至是表的结构，这样才能达到最好的效果**。
- > **页大小与缓存大小**
- 本文相关链接：
  * WCDB https://github.com/Tencent/wcdb/wiki
  * 微信WCDB进化之路 - 开源与开始 https://mp.weixin.qq.com/s/tzy-fr55t1zqTbxOeKg4RA
  * 微信移动端数据库组件WCDB系列（二） — 数据库修复三板斧 https://mp.weixin.qq.com/s/Ln7kNOn3zx589ACmn5ESQA

【[:star:][`*`]】 Sqlite事务模型、性能优化Tips、常见误区 https://www.51cto.com/article/603560.html
- > **2.1 sqlite多进程安全及Linux & windows文件锁**
  * > 关于`建议锁(advisory lock)`和`强制锁(mandatory lock)`
    + > 建议锁并不由内核强制实行，如果有进程不检查目标文件是否已经由别的进程加了锁就往其中写入数据，内核也不会加以阻拦。因此，建议锁并不能阻止进程对文件的访问，而是需要进程事先对锁的状态做一个约定，并根据锁的当前状态和相互关系来确定其他进程是否能对文件执行指定的操作。
    + > 强制锁是由内核强制采用的 ***`文件锁`***——由于内核对每个read()和write()操作都会检查相应的锁，会降低系统性能。
  * > 典型的建议锁
    + > 锁文件; 锁文件是最简单的对文件加锁的方法，每个需要加锁的数据文件都有一个锁文件(lock file)。但这种方式存在比较大的问题是无法强制保护需要加锁的文件，并且当加锁进程非正常退出之后，会造成其他进程的死锁。
    + > 记录锁; `System V`和`BSD4.3`引入了 ***`记录锁`***，相应的系统调用为`lockf()`和`flock()`。而POSIX对于记录锁提供了另外一种机制，其系统调用为`fcntl()`。记录锁和锁文件有两个很重要的区别：1)记录锁可以对文件的任何一部分加锁，这对DBMS有极大的帮助，2)记录锁的另一个优点就是它由进程持有，而不是文件系统持有，当进程结束时，所有的锁也随之释放。对于一个进程本身而言，多个锁绝不会冲突。(Windows中的锁都是强制锁，具体不是很熟，***只知道在由于windows上文锁的限制，sqlite多进程下的并发性会受影响***)。
- > **2.2 事务模型(Without WAL)**
  * > sqlite对每个连接设计了五钟锁的状态(`UNLOCKED, PENDING, SHARED, RESERVED, EXCLUSIVE`), sqlite的事务模型中通过锁的状态保证读写事务(包括显式的事务和隐式的事务)的一致性和读写安全。sqlite官方提供的事务生命周期如下图所示，我在这里稍微加了一些个人的理解： <br> ![](https://s3.51cto.com/oss/201909/26/3b12e86e9bdef741a3ed0d13f7380db0.jpeg)
  * > 这里有几点需要注意：
    + > `UNLOCKED、PENDING、SHARED、RESERVED`状态是非独占的，也就是说同一个连接中多个线程并发只读不会被阻塞。
    + > 写操作的数据修改会先写入page cache，内容包括journal日志、b-tree的修改等;正是由于page cache的存在，很多耗时的“重”操作都可以不干扰其他连接和当前连接的读操作，真正意义上保证了sqlite可以同时处理一个写连接和多个读连接。
    + > 连接由`RESERVED`状态进入`EXCLUSIVE`状态，需要等待读线程释放`SHARED`锁，也即写操作会被读操作阻塞
    + > 连接由`RESERVED`状态进入`EXCLUSIVE`状态后(***显式或隐式的调用commit***)，数据库进入独占状态，其他任何连接都无法由`UNLOCK`状态进入`SHARED`状态;也即写操作会阻塞所有连接的读操作(***不包括已经进入SHARED状态的操作***)，直到page caches写入数据库文件(成功或失败)。
    + > 数据库独占状态越久，其他操作的等待时间越久，即`SQLITE_BUSY`产生的一个原因。
- > **2.3 WAL对事务模型的影响**
- > **2.3.1 结论**
  * > 只有开了WAL，再使用读写(连接)分离才能有较大的性能提升。
  * > ***WAL本质上是将部分随机写操作(数据库文件和journal日志)变成了串行写WAL文件，并进行了锁分离***。
  * > WAL文件的大小设置很关键，过大的WAL文件，会让查找操作从B-Tree查找退化成线性查找(WAL中page连续存储);但大的WAL文件对写操作较友好。
- > **3，性能优化tips**
- > **3.1 合理使用事务**
- > **3.2 启用WAL + 读写(连接)分离**
- > **3.3 针对具体业务场景，设置合适的WAL SIZE**
- > **3.4 针对业务场景分库分表**
- > **3.5 其他**
  * > 包括WAL checkpoint策略、WAL size优化、page size优化等，均需要根据具体的业务场景设置。
- > **4，常见问题 & 误区**
- > **4.1 线程安全设置及误区**
  * > sqlites configuration options: https://sqlite.org/c3ref/c_config_getmalloc.html
  * > 按照sqlite文档，sqlite线程安全模式有以下三种：
    + > SQLITE_CONFIG_SINGLETHREAD(单线程模式) <br> This option sets the threading mode to Single-thread. In other words, it disables all mutexing and puts SQLite into a mode where it can only be used by a single thread.
    + > SQLITE_CONFIG_MULTITHREAD(多线程模式) <br> This option sets the threading mode to Multi-thread. In other words, it disables mutexing on database connection and prepared statement objects. The application is responsible for serializing access to database connections and prepared statements. But other mutexes are enabled so that SQLite will be safe to use in a multi-threaded environment as long as no two threads attempt to use the same database connection at the same time.
    + > SQLITE_CONFIG_SERIALIZED(串行模式) <br> This option sets the threading mode to Serialized. In other words, this option enables all mutexes including the recursive mutexes on database connection and prepared statement objects. In this mode (which is the default when SQLite is compiled with SQLITE_THREADSAFE=1) the SQLite library will itself serialize access to database connections and prepared statements so that the application is free to use the same database connection or the same prepared statement in different threads at the same time.
  * > **4.1.1 误区一：多线程模式是线程安全的**
    + > 产生这个误区主的主要原因是官方文档里的最后一句话：`SQLite will be safe to use in a multi-threaded environment as long as no two threads attempt to use the same database connection at the same time.`
    + > 但大家往往忽略了前面的一句话：`it disables mutexing on database connection and prepared statement objects`
    + > 即对于单个连接的读、写操作，包括创建出来的prepared statement操作，都没有线程安全的保护。也即在多线程模式下，对单个连接的操作，仍需要在业务层进行锁保护。
  * > **4.1.2 误区二：多线程模式下，并发读操作是安全的**
    + > 关于这一点，#2.4给出了具体的解释;多线程模式下(SQLITE_CONFIG_MULTITHREAD)对prepared statement、connection的操作都不是线程安全的
  * > **4.1.3 误区三：串行模式下，所有数据库操作都是串行执行**
    + > 这个问题比较笼统;即使在串行模式下，所有的数据库操作仍需遵循事务模型;而事务模型已经将数据库操作的锁进行了非常细粒度的分离，串行模式的锁也是在上层保证了事务模型的完整性。
  * > **4.1.4 误区四：多线程模式性能最好，串行模式性能差**
    + > 多线程模式下，仍需要业务上层进行锁保护，串行模式则是在sqlite内部进行了锁保护;认为多线程模式性能好的兄弟哪来的自信认为业务层的锁实现比sqlite内部锁实现性能更高?  

sqlite多进程并发读写模式下，返回SQLITE_BUSY错误的处理方法 https://blog.csdn.net/lijinqi1987/article/details/51754846

Python+SQLite数据库实现服务端高并发写入 https://cloud.tencent.com/developer/article/1771861

sqlite解决并发性问题 https://blog.csdn.net/feiyeyangyang/article/details/71632048
- > 验证了sqlite脚本的并发性，弱爆了，一个脚本写，一个脚本查询，查询的脚本运行down掉了。
- > 如何处理这种并发性问题？使用linux系统中的**消息队列**完美解决，将写、查询操作都放到一个消息队列中，获取消息队列中数据进行先进先出的数据库读写操作

SQLite在多线程环境下的应用 https://blog.csdn.net/diyagoanyhacker/article/details/7209888
- Sqlite数据库多线程并发问题 https://blog.csdn.net/wsmrcool/article/details/8287904

sqlite3 多线程和锁 ，优化插入速度及性能优化 https://www.cnblogs.com/jaejaking/p/5383403.html || https://blog.csdn.net/majiakun1/article/details/79193658

# SQLite性能之索引

Squeezing Performance from SQLite: Indexes? Indexes! https://medium.com/@JasonWyatt/squeezing-performance-from-sqlite-indexes-indexes-c4e175f3c346
