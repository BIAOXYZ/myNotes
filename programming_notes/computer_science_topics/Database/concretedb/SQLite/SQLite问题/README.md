
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
