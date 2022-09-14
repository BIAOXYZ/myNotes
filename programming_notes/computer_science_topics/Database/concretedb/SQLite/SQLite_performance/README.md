
# SQLite性能

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
