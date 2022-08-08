
# 1

如何在PostgreSQL中查找代码 - 王硕的文章 - 知乎 https://zhuanlan.zhihu.com/p/125140739
- > **使用GPROF查找函数**
  * > 当我们对函数一无所知时，连报错信息或者关键字都不清楚时，我们可以使用GPROF进行调试，找到对应函数。`gprof是GNU profile工具，可以运行于linux、AIX、Sun等操作系统进行C、C++、Pascal、Fortran程序的性能分析，用于程序的性能优化以及程序瓶颈问题的查找和解决。`虽然他不是专门用来定位搜索函数的，但是其记录所有函数执行时间，这会缩减我们代码定位时间的消耗。比如我最近在看排序的代码，但是我对排序完全不清楚，那么我可以使用此方法来查找，排序时都使用了哪些函数，然后依次对函数进行判断找到我需要的函数。
  * > 1.编译数据库时添加编译选项 `--enable-profiling`
    ```sh
    ./configure --prefix=/home/postgres/db13 --enable-debug --enable-profiling
    make; make install
    ```
  * > 2.准备数据，准备完成后退出当前会话，因为`gprof`只会统计当前进程的函数调用，避免其他操作干扰，建议只执行最简单的命令来获取相应信息
    ```sql
    postgres=# create table aa(a1 int);
    CREATE TABLE
    postgres=# insert into aa select generate_series(1, 10000);
    INSERT 0 10000
    postgres=# checkpoint ;
    postgres=# \q
    ```
  * > 3.查询排序
    ```sql
    postgres=# select pg_backend_pid();
     pg_backend_pid 
    ----------------
              18713
    (1 row)

    postgres=# select * from aa order by ctid;
      a1   
    -------
         1
         2
         3
         4
         5
         6
         7
         8
         9
        10
        11
        12
        13
        14
        15
        16
        17
        18
        19
        20
        21
        22
        23
        24
    postgres=# \q
    ```
  * > 4.找到对应文件，并转换数据为可读信息
    ```sh
    [postgres@izj6ccelicizfq7z026sowz bin]$ cd ../data/
    [postgres@izj6ccelicizfq7z026sowz data]$ ls
    base          pg_hba.conf    pg_replslot   pg_subtrans  pg_xact
    global        pg_ident.conf  pg_serial     pg_tblspc    postgresql.auto.conf
    gprof         pg_logical     pg_snapshots  pg_twophase  postgresql.conf
    pg_commit_ts  pg_multixact   pg_stat       PG_VERSION   postmaster.opts
    pg_dynshmem   pg_notify      pg_stat_tmp   pg_wal       postmaster.pid
    [postgres@izj6ccelicizfq7z026sowz data]$ cd gprof/
    [postgres@izj6ccelicizfq7z026sowz gprof]$ ls
    18685  18687  18688  18690  18695  18703  18713  avworker
    [postgres@izj6ccelicizfq7z026sowz gprof]$ cd 18713
    [postgres@izj6ccelicizfq7z026sowz 18713]$ ls
    gmon.out
    [postgres@izj6ccelicizfq7z026sowz 18713]$ gprof /home/postgres/db13/bin/postgres gmon.out > gmon.txt
    [postgres@izj6ccelicizfq7z026sowz 18713]$ vim gmon.txt
    ```
  * > 5.相应信息
    ```console
    Flat profile:

    Each sample counts as 0.01 seconds.
      %   cumulative   self              self     total           
     time   seconds   seconds    calls  ms/call  ms/call  name    
    100.00      0.01     0.01      103     0.10     0.10  _bt_binsrch
      0.00      0.01     0.00    34270     0.00     0.00  LWLockInitialize
      0.00      0.01     0.00    30063     0.00     0.00  internal_putbytes
      0.00      0.01     0.00    30044     0.00     0.00  enlargeStringInfo
      0.00      0.01     0.00    23506     0.00     0.00  AllocSetAlloc
      0.00      0.01     0.00    20010     0.00     0.00  tts_virtual_clear
      0.00      0.01     0.00    20008     0.00     0.00  MemoryContextReset
      0.00      0.01     0.00    20000     0.00     0.00  slot_getsomeattrs_int
      0.00      0.01     0.00    11331     0.00     0.00  palloc
      0.00      0.01     0.00    10432     0.00     0.00  palloc0
      0.00      0.01     0.00    10142     0.00     0.00  CheckForSerializableConflictOutNeeded
      0.00      0.01     0.00    10142     0.00     0.00  HeapCheckForSerializableConflictOut
      0.00      0.01     0.00    10130     0.00     0.00  ExecStoreBufferHeapTuple
      0.00      0.01     0.00    10025     0.00     0.00  pg_server_to_any
      0.00      0.01     0.00    10025     0.00     0.00  pg_server_to_client
      0.00      0.01     0.00    10023     0.00     0.00  appendBinaryStringInfoNT
      0.00      0.01     0.00    10021     0.00     0.00  AllocSetReset
      0.00      0.01     0.00    10021     0.00     0.00  MemoryContextStatsPrint
      0.00      0.01     0.00    10021     0.00     0.00  socket_putmessage
      0.00      0.01     0.00    10009     0.00     0.00  AllocSetGetChunkSpace
      0.00      0.01     0.00    10009     0.00     0.00  GetMemoryChunkSpace
    ```
  * > 通过GPROF找到相应函数后，可以再使用GDB方法来定位函数调用栈。
