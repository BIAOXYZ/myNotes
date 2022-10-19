
### 老版本 sqlite3 二进制不支持 `alter table tb_name drop column col_name;`

```sh
# 这个是 apt install -y sqlite 默认安装的 3.27.2 版本
$ sqlite3
SQLite version 3.27.2 2019-02-25 16:06:06
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> .open 4567
sqlite> create table t1 (id int, name text);
sqlite> insert into t1 values (1, 'a');
sqlite> insert into t1 values (2, 'b');
sqlite> select * from t1;
1|a
2|b
sqlite> alter table t1 drop column id;
Error: near "drop": syntax error
```
```sh
# 这个是目前（2022.10.10）官网最新的 3.39.4 版本
$ wget https://www.sqlite.org/2022/sqlite-tools-linux-x86-3390400.zip
$ unzip sqlite-tools-linux-x86-3390400.zip
$ cd sqlite-tools-linux-x86-3390400
$ ls
sqldiff  sqlite3  sqlite3_analyzer

$ ./sqlite3
bash: ./sqlite3: No such file or directory
# 这个问题出现的原因是现在大多数机器都是 64 位了，然而 sqlite 官方下载页面上的二进制还是 32 位。。。
$ file ./sqlite3
./sqlite3: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, for GNU/Linux 4.3.0, stripped

# 解决办法参考这里： https://stackoverflow.com/questions/14082152/sqlite3-no-such-file-or-directory/14082813#14082813
$ sudo apt-get install lib32z1 -y
...
...
...

$ ./sqlite3
SQLite version 3.39.4 2022-09-29 15:55:41
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> 
sqlite> .open 1234
sqlite> create table t1 (id int, name text);
sqlite> insert into t1 values (1, 'a');
sqlite> insert into t1 values (2, 'b');
sqlite> select * from t1;
1|a
2|b
sqlite> alter table t1 drop column id;
sqlite> select * from t1;
a
b
sqlite>
```
```sh
# （注意，如果你是用 apt install 安装的二进制，那个是跟机器有关的，64 位机器也能正确安装 64 位的二进制）
$ which sqlite3
/usr/bin/sqlite3
$ file /usr/bin/sqlite3
/usr/bin/sqlite3: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=f8a2bb2b99fe8eae437455d74347d1750d7018dc, for GNU/Linux 3.2.0, stripped
```

### `SQL error: database is locked`

Fix SQLite Database File is Locked Error https://www.nucleustechnologies.com/blog/fix-sqlite-database-file-is-locked/

How do I unlock a SQLite database? https://stackoverflow.com/questions/151026/how-do-i-unlock-a-sqlite-database
- https://stackoverflow.com/questions/151026/how-do-i-unlock-a-sqlite-database/218622#218622
  * > https://www2.sqlite.org/cvstrac/wiki?p=DatabaseIsLocked
  * > https://www.sqlite.org/lockingv3.html

解决SQLite database is locked https://www.cnblogs.com/xienb/p/3455562.html
- > SQLite只支持库级锁，库级锁意味着什么？——意味着同时只能允许一个写操作，也就是说，即事务T1在A表插入一条数据，事务T2在B表中插入一条数据，这两个操作不能同时进行，即使你的机器有100个CPU，也无法同时进行，而只能顺序进行。表级都不能并行，更别说元组级了——这就是库级锁。但是，SQLite尽量延迟申请X锁，直到数据块真正写盘时才申请X锁，这是非常巧妙而有效的。
- > 上面的介绍可以看出Sqlite其实是一个客户端嵌入数据库，在高并发的服务器上是无法适用的，同事百度后，发现连接串中加入 "`Journal Mode=WAL;`"可以缓解并发压力，可是客户生产环境仍然出现“database is locked”错误。
- > 解决办法：
  * > 事实证明Sqlite不支持并发执行写入操作，即使是不同的表，只支持库级锁，而且这个Sqlite本身没有实现，必须自己实现这个库级锁。

你不得不知的SQLite https://www.googleplus.party/2017/10/20/%E4%BD%A0%E4%B8%8D%E5%BE%97%E4%B8%8D%E7%9F%A5%E7%9A%84SQLite/
- > **那SQLite如何优化了？**
  * > FMDB是基于SQLite封装的。早期的FMDB是不支持并发的，但是后来的版本中，FMDB已经解决了在并发问题。
  * > 四种锁：
    ```console
    共享锁（shared lock）
    预留锁（reserved lock）
    未决锁（pending lock）
    排他锁（exclusive lock）
    ```
  * > SQLite读操作（如：select），可以并发的读取数据库，如果有一个读存在，那么就不允许写
  * > SQLite写操作（如：insert/update/delete）
    + > 1.它首先会申请一个预留锁（reserved lock），在启用预留锁后，如果已存在的读操作可以继续，新的读请求也可以有；
    + > 2.然后，它会把需要更新的数据写到缓冲区中；
    + > 3.需要写到缓冲区的更新写完以后，就需要将更新刷到硬盘DB了，但是此时它会申请未决锁（pending lock），申请了该锁后，就不能再有新的共享锁被申请了，也就是阻止了新的读操作。但是已经存在的读操作还是可以继续读的。然后它就等待读操作全部完毕后，它就会申请排他锁（exclusive lock），此时不能再有其他的锁存在了，然后就进行commit操作，最后，将缓冲区的数据写到DB中。
  * > 事务，就是一组SQL语句操作让它们顺序执行，要么都成功了，要么只要有一个错误，全部操作回滚；它们的特点如下，一般都是四个命令来控制，begin transaction，commit或者end transaction，rollback：
    ```console
    原子性（Atomicity）：确保工作单位内的所有操作都成功完成，否则，事务会在出现故障的地方终止，并且回滚到以前的状态
    一致性（Consistency）：确保数据库在成功提交的事务上正确的改变状态
    隔离性（Isolation）：使事务操作相互独立和透明
    持久性（Durability）：确保已提交事务的结果或效果在系统发生故障的情况下仍然存在
    ```
- > **SQLite优化要点**
  * > 1.设计数据库时遵循三范式
    + > 第一范式：每个字段（每一列）都不可再分，意思就是说：一列就是一个数据类型并且存储一种类型的值
    + > 第二范式：满足第一范式的情况下，我们还需要保证一条数据在表中有一个主键（唯一标识），不一定是id，也可以是身份证号（只要表示唯一性就行）
    + > 第三范式：满足第二范式的情况下，我们要确保数据表中的每一列数据都和主键有直接关系，而不是简介关系
  * > 2.数据量比较大的话，可以对数据表（data table）进行分片（sharding）
  * > 3.从业务上可以分离，且数据量也较大的话，也可以分库（sub-database）
  * > 4.查询数据太频繁的地方，不建议使用连表查询
  * > 对数据表进行分片，对数据库也分子库
    + > https://stackoverflow.com/questions/15778716/sqlite-insert-speed-slows-as-number-of-records-increases-due-to-an-index/17110004#17110004
    + > https://stackoverflow.com/questions/128919/extreme-sharding-one-sqlite-database-per-user
- > **读写死锁案例**
  >> //notes：这里作者原文没有用 `begin;` 开启事务，于是就复现不了。下面是我自己手动试的，两个窗口都用 `begin;` 开启下事务就可以了。反正感觉（作者文章这里）还是有些问题的，需要后续再看看。
  ```console
  sqlite> begin;
  sqlite> select * from t1;
  1|a
  2|b
  3|c
  sqlite> insert into t1 values (5, "a");
  Error: database is locked
  sqlite> 
  ```
  ```console
  sqlite> begin;
  sqlite> insert into t1 values (6,"c");
  sqlite> commit;
  Error: database is locked
  sqlite> 
  ```
- > **关系型数据库**
  * > [SQLCiper 加密](https://github.com/sqlcipher/sqlcipher)
  * > [FMDB 包含SQLCiper，多线程安全的](https://github.com/ccgus/fmdb)
