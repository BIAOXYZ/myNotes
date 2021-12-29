
# 相关命令

- `spawn`
- `send`
- `tclsh`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

Expect https://en.wikipedia.org/wiki/Expect
- > **Alternatives**:
  * > GoExpect https://github.com/google/goexpect
  * > go-expect https://github.com/Netflix/go-expect
  * > Pexpect is a Pure Python Expect-like module https://github.com/pexpect/pexpect

# 其他博客类链接

每次进步一点点——linux expect 使用 https://blog.csdn.net/houmou/article/details/53102051
```sh
yum 安装
yum install -y expect

源码编译安装
expect 依赖于 tcl, 所以需要首先安装 tcl。可以使用rpm检查是否已经安装tcl:
rpm -qa | grep tcl
```

How to install expect on Ubuntu https://howtoinstall.co/en/expect
- > Installing expect package on Ubuntu is as easy as running the following command on terminal:
```sh
sudo apt-get update
sudo apt-get install expect -y
```

使用expect在script中切换到root用户 https://www.cnblogs.com/gx-303841541/archive/2012/11/08/2761679.html

Ubuntu使用Spawn和expect实现ssh自动登陆 https://blog.csdn.net/donglynn/article/details/51536212
```sh
使用以下代码检测expect是否已经安装
ls /usr/bin | grep expect 

如果显示为空，则使用以下命令安装
sudo apt-get install tcl tk expect
```

Linux下使用expect命令编写自动化交互脚本 https://www.jb51.net/article/151099.htm

# 个人实战

## 从harbor1.2.2到1.3.0过程中有一步（升级完启新数据库那步）会弹出一个提示然后让你选择y或n。本来也没什么，但是后来项目完成后工行的人又来问他们脚本化的时候怎么跳过

```sh
// 首先要装好expect，这个就不说了。
// 然后有个测试脚本test.sh，内容如下
// （其实就是把要执行的语句放到spawn后面，把提示语镶嵌到expect里，把你想的输出镶嵌到send里）

$ cat test.sh
#!/usr/bin/expect
spawn docker run -ti --rm -e DB_USR=root -e DB_PWD=root123 -v /data/database:/var/lib/mysql vmware/harbor-db-migrator:1.3 up
expect "Enter y to continue updating or n to abort:"
send "y\r"
interact
$

//单独运行该脚本，成功跳过交互。

$ ./test.sh
spawn docker run -ti --rm -e DB_USR=root -e DB_PWD=root123 -v /data/database:/var/lib/mysql vmware/harbor-db-migrator:1.3 up
Please backup before upgrade.
Enter y to continue updating or n to abort:y
Trying to start mysql server...
Waiting for MySQL start...
2020-03-09 13:12:12 139954564696000 [Note] mysqld (mysqld 10.2.10-MariaDB) starting as process 7 ...
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Uses event mutexes
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Compressed tables use zlib 1.2.8
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Number of pools: 1
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Using SSE2 crc32 instructions
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Initializing buffer pool, total size = 256M, instances = 1, chunk size = 128M
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Completed initialization of buffer pool
2020-03-09 13:12:12 139953556141824 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. Seethe man page of setpriority().
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Highest supported file format is Barracuda.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Starting crash recovery from checkpoint LSN=1763340
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/access.ibd' with space ID 21, since the redo log references ./registry/access.ibd with space ID 6.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/access_log.ibd' with space ID 22, since the redo log references ./registry/access_log.ibd with space ID 11.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/alembic_version.ibd' with space ID 23, since the redo log references ./registry/alembic_version.ibd with space ID 20.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/clair_vuln_timestamp.ibd' with space ID 24, since the redo log references ./registry/clair_vuln_timestamp.ibd with space ID 18.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/img_scan_job.ibd' with space ID 25, since the redo log references ./registry/img_scan_job.ibd with space ID 16.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/img_scan_overview.ibd' with space ID 26, since the redo log references ./registry/img_scan_overview.ibd with space ID 17.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/project.ibd' with space ID 37, since the redo log references ./registry/project.ibd with space ID 9.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/project_member.ibd' with space ID 28, since the redo log references ./registry/project_member.ibd with space ID 10.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/properties.ibd' with space ID 29, since the redo log references ./registry/properties.ibd with space ID 19.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/replication_job.ibd' with space ID 30, since the redo log references ./registry/replication_job.ibd with space ID 15.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/replication_policy.ibd' with space ID 31, since the redo log references ./registry/replication_policy.ibd with space ID 13.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/replication_target.ibd' with space ID 38, since the redo log references ./registry/replication_target.ibd with space ID 14.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/repository.ibd' with space ID 33, since the redo log references ./registry/repository.ibd with space ID 12.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/role.ibd' with space ID 34, since the redo log references ./registry/role.ibd with space ID 7.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/user.ibd' with space ID 35, since the redo log references ./registry/user.ibd with space ID 8.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/project.ibd' with space ID 37, since the redo log references ./registry/project.ibd with space ID 27.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/replication_target.ibd' with space ID 38, since the redo log references ./registry/replication_target.ibd with space ID 32.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/#sql-ib42-2572416687.ibd' with space ID 37. Another data filecalled ./registry/project.ibd exists with the same space ID.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/#sql-ib42-2572416687.ibd' with space ID 37. Another data filecalled ./registry/project.ibd exists with the same space ID.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/#sql-ib47-2572416689.ibd' with space ID 38. Another data filecalled ./registry/replication_target.ibd exists with the same space ID.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Ignoring data file './registry/#sql-ib47-2572416689.ibd' with space ID 38. Another data filecalled ./registry/replication_target.ibd exists with the same space ID.
2020-03-09 13:12:12 139954564696000 [Note] InnoDB: Starting final batch to recover 161 pages from redo log.
2020-03-09 13:12:13 139954564696000 [Note] InnoDB: 128 out of 128 rollback segments are active.
2020-03-09 13:12:13 139954564696000 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
2020-03-09 13:12:13 139954564696000 [Note] InnoDB: Creating shared tablespace for temporary tables
2020-03-09 13:12:13 139954564696000 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
2020-03-09 13:12:13 139954564696000 [Note] InnoDB: File './ibtmp1' size is now 12 MB.
2020-03-09 13:12:13 139954564696000 [Note] InnoDB: 5.7.20 started; log sequence number 2016794
2020-03-09 13:12:13 139953312884480 [Note] InnoDB: Loading buffer pool(s) from /var/lib/mysql/ib_buffer_pool
2020-03-09 13:12:13 139953312884480 [Note] InnoDB: Cannot open '/var/lib/mysql/ib_buffer_pool' for reading: No such file or directory
2020-03-09 13:12:13 139954564696000 [Note] Plugin 'FEEDBACK' is disabled.
2020-03-09 13:12:13 139954564696000 [Note] Recovering after a crash using tc.log
2020-03-09 13:12:13 139954564696000 [Note] Starting crash recovery...
2020-03-09 13:12:13 139954564696000 [Note] Crash recovery finished.
2020-03-09 13:12:13 139954564696000 [Note] Server socket created on IP: '::'.
2020-03-09 13:12:13 139954564696000 [ERROR] Missing system table mysql.roles_mapping; please run mysql_upgrade to create it
2020-03-09 13:12:13 139954564696000 [ERROR] Incorrect definition of table mysql.event: expected column 'sql_mode' at position 14 to have type set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','IGNORE_BAD_TABLE_OPTIONS','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH'), found type set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','NOT_USED','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_A
2020-03-09 13:12:13 139954564696000 [ERROR] mysqld: Event Scheduler: An error occurred when initializing system tables. Disabling the Event Scheduler.
2020-03-09 13:12:13 139954563831552 [Warning] Failed to load slave replication state from table mysql.gtid_slave_pos: 1146: Table 'mysql.gtid_slave_pos' doesn't exist
2020-03-09 13:12:13 139954564696000 [Note] Reading of all Master_info entries succeded
2020-03-09 13:12:13 139954564696000 [Note] Added new Master_info '' to hash table
2020-03-09 13:12:13 139954564696000 [Note] mysqld: ready for connections.
Version: '10.2.10-MariaDB'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  Source distribution
Version is not specified. Default version is head.
Performing upgrade head...
INFO  [alembic.runtime.migration] Context impl MySQLImpl.
INFO  [alembic.runtime.migration] Will assume non-transactional DDL.
1.3.0 (head)
INFO  [alembic.runtime.migration] Context impl MySQLImpl.
INFO  [alembic.runtime.migration] Will assume non-transactional DDL.
INFO  [alembic.runtime.migration] Context impl MySQLImpl.
INFO  [alembic.runtime.migration] Will assume non-transactional DDL.
1.3.0 (head)
Upgrade performed.
0
$

// 搞了一个test_parent.sh脚本，其实就是想试试expect的脚本包到bash脚本里会不会有问题
// （因为不可能为了这一句整个升级脚本都变expect脚本了），结果一切正常。

$ cat test_parent.sh
#!/bin/bash
echo 1234567 start
./test.sh
echo 8888888 end
$
$ ./test_parent.sh
1234567 start
spawn docker run -ti --rm -e DB_USR=root -e DB_PWD=root123 -v /data/database:/var/lib/mysql vmware/harbor-db-migrator:1.3 up
Please backup before upgrade.
Enter y to continue updating or n to abort:y
Trying to start mysql server...
Waiting for MySQL start...
2020-03-09 13:17:23 140306726090688 [Note] mysqld (mysqld 10.2.10-MariaDB) starting as process 7 ...
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Uses event mutexes
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Compressed tables use zlib 1.2.8
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Number of pools: 1
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Using SSE2 crc32 instructions
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Initializing buffer pool, total size = 256M, instances = 1, chunk size = 128M
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Completed initialization of buffer pool
2020-03-09 13:17:23 140305787098880 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. Seethe man page of setpriority().
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Highest supported file format is Barracuda.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Starting crash recovery from checkpoint LSN=1763340
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/access.ibd' with space ID 21, since the redo log references ./registry/access.ibd with space ID 6.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/access_log.ibd' with space ID 22, since the redo log references ./registry/access_log.ibd with space ID 11.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/alembic_version.ibd' with space ID 23, since the redo log references ./registry/alembic_version.ibd with space ID 20.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/clair_vuln_timestamp.ibd' with space ID 24, since the redo log references ./registry/clair_vuln_timestamp.ibd with space ID 18.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/img_scan_job.ibd' with space ID 25, since the redo log references ./registry/img_scan_job.ibd with space ID 16.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/img_scan_overview.ibd' with space ID 26, since the redo log references ./registry/img_scan_overview.ibd with space ID 17.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/project.ibd' with space ID 37, since the redo log references ./registry/project.ibd with space ID 9.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/project_member.ibd' with space ID 28, since the redo log references ./registry/project_member.ibd with space ID 10.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/properties.ibd' with space ID 29, since the redo log references ./registry/properties.ibd with space ID 19.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/replication_job.ibd' with space ID 30, since the redo log references ./registry/replication_job.ibd with space ID 15.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/replication_policy.ibd' with space ID 31, since the redo log references ./registry/replication_policy.ibd with space ID 13.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/replication_target.ibd' with space ID 38, since the redo log references ./registry/replication_target.ibd with space ID 14.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/repository.ibd' with space ID 33, since the redo log references ./registry/repository.ibd with space ID 12.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/role.ibd' with space ID 34, since the redo log references ./registry/role.ibd with space ID 7.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/user.ibd' with space ID 35, since the redo log references ./registry/user.ibd with space ID 8.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/project.ibd' with space ID 37, since the redo log references ./registry/project.ibd with space ID 27.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/replication_target.ibd' with space ID 38, since the redo log references ./registry/replication_target.ibd with space ID 32.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/#sql-ib42-2572416687.ibd' with space ID 37. Another data filecalled ./registry/project.ibd exists with the same space ID.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/#sql-ib42-2572416687.ibd' with space ID 37. Another data filecalled ./registry/project.ibd exists with the same space ID.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/#sql-ib47-2572416689.ibd' with space ID 38. Another data filecalled ./registry/replication_target.ibd exists with the same space ID.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Ignoring data file './registry/#sql-ib47-2572416689.ibd' with space ID 38. Another data filecalled ./registry/replication_target.ibd exists with the same space ID.
2020-03-09 13:17:23 140306726090688 [Note] InnoDB: Starting final batch to recover 161 pages from redo log.
2020-03-09 13:17:24 140306726090688 [Note] InnoDB: 128 out of 128 rollback segments are active.
2020-03-09 13:17:24 140306726090688 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
2020-03-09 13:17:24 140306726090688 [Note] InnoDB: Creating shared tablespace for temporary tables
2020-03-09 13:17:24 140306726090688 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
2020-03-09 13:17:24 140306726090688 [Note] InnoDB: File './ibtmp1' size is now 12 MB.
2020-03-09 13:17:24 140306726090688 [Note] InnoDB: 5.7.20 started; log sequence number 2018102
2020-03-09 13:17:24 140304879437568 [Note] InnoDB: Loading buffer pool(s) from /var/lib/mysql/ib_buffer_pool
2020-03-09 13:17:24 140304879437568 [Note] InnoDB: Cannot open '/var/lib/mysql/ib_buffer_pool' for reading: No such file or directory
2020-03-09 13:17:24 140306726090688 [Note] Plugin 'FEEDBACK' is disabled.
2020-03-09 13:17:24 140306726090688 [Note] Recovering after a crash using tc.log
2020-03-09 13:17:24 140306726090688 [Note] Starting crash recovery...
2020-03-09 13:17:24 140306726090688 [Note] Crash recovery finished.
2020-03-09 13:17:24 140306726090688 [Note] Server socket created on IP: '::'.
2020-03-09 13:17:24 140306726090688 [ERROR] Missing system table mysql.roles_mapping; please run mysql_upgrade to create it
2020-03-09 13:17:24 140306726090688 [ERROR] Incorrect definition of table mysql.event: expected column 'sql_mode' at position 14 to have type set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','IGNORE_BAD_TABLE_OPTIONS','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH'), found type set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','NOT_USED','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_A
2020-03-09 13:17:24 140306726090688 [ERROR] mysqld: Event Scheduler: An error occurred when initializing system tables. Disabling the Event Scheduler.
2020-03-09 13:17:24 140306725226240 [Warning] Failed to load slave replication state from table mysql.gtid_slave_pos: 1146: Table 'mysql.gtid_slave_pos' doesn't exist
2020-03-09 13:17:24 140306726090688 [Note] Reading of all Master_info entries succeded
2020-03-09 13:17:24 140306726090688 [Note] Added new Master_info '' to hash table
2020-03-09 13:17:24 140306726090688 [Note] mysqld: ready for connections.
Version: '10.2.10-MariaDB'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  Source distribution
Version is not specified. Default version is head.
Performing upgrade head...
INFO  [alembic.runtime.migration] Context impl MySQLImpl.
INFO  [alembic.runtime.migration] Will assume non-transactional DDL.
1.3.0 (head)
INFO  [alembic.runtime.migration] Context impl MySQLImpl.
INFO  [alembic.runtime.migration] Will assume non-transactional DDL.
INFO  [alembic.runtime.migration] Context impl MySQLImpl.
INFO  [alembic.runtime.migration] Will assume non-transactional DDL.
1.3.0 (head)
Upgrade performed.
0
8888888 end
$
```

## 用 `expect` 脚本响应类似 `kinit` 那种交互式登陆。
// 参见 `kinit` 部分的笔记吧。
