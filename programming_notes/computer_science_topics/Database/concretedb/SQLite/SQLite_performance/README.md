
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

每天4亿行SQLite订单大数据测试（源码） https://developer.aliyun.com/article/385232

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

sqlite多进程并发读写模式下，返回SQLITE_BUSY错误的处理方法 https://blog.csdn.net/lijinqi1987/article/details/51754846

Python+SQLite数据库实现服务端高并发写入 https://cloud.tencent.com/developer/article/1771861

sqlite解决并发性问题 https://blog.csdn.net/feiyeyangyang/article/details/71632048
- > 验证了sqlite脚本的并发性，弱爆了，一个脚本写，一个脚本查询，查询的脚本运行down掉了。
- > 如何处理这种并发性问题？使用linux系统中的**消息队列**完美解决，将写、查询操作都放到一个消息队列中，获取消息队列中数据进行先进先出的数据库读写操作
