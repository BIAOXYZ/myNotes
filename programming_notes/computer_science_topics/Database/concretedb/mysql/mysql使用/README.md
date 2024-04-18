
Task00：绪论 - 环境搭建.md https://github.com/datawhalechina/team-learning-sql/blob/main/Task00%EF%BC%9A%E7%BB%AA%E8%AE%BA%20-%20%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA.md

学会使用简单的 MySQL 常用操作 https://developer.aliyun.com/article/623047

MySQL常用操作指令大全 https://blog.csdn.net/weixin_41105242/article/details/109108573

# apt 方式安装

How to Install MySQL on Debian 10 https://serverspace.io/support/help/how-to-install-mysql-on-debian-10/

## 完全卸载

How do I uninstall MySQL? https://askubuntu.com/questions/172514/how-do-i-uninstall-mysql
```sh
# sudo apt-get remove --purge -s 'mysql*'
sudo apt-get remove --purge mysql*
sudo apt-get autoremove
sudo apt-get autoclean
sudo rm -rf /var/lib/mysql
sudo rm -rf /etc/mysql
```

# mysql 问题

## 登陆密码问题

>> 最后还是通过 `sudo mysql -u root`（注意此时不加 `-p`，并且 `sudo` 不能少 —— 说白了就是还得操作系统的 `root` 用户才能不要密码连数据库；其他操作系统用户想连数据库里的那个 `root` 用户是不行的）可以登陆上去。然后再改（数据库里名为）`root` 的用户的密码。最后用了下面的“***选择一***”，也就是把（数据库里名为）`root` 的用户对应的插件改成了 `mysql_native_password`。这样其他操作系统用户也可以用密码（也就是不加 `sudo` 的 `mysql -u root -p`）来登陆数据库里的 `root` 用户了。

解决 MySQL 的 ERROR 1698 (28000): Access denied for user 'root'@'localhost' https://blog.csdn.net/jlu16/article/details/82809937
- > 原文地址： https://stackoverflow.com/questions/39281594/error-1698-28000-access-denied-for-user-rootlocalhost
- > 原因是因为在最近的Ubuntu安装（当然也可能是其他安装）中，MySQL默认使用了UNIX auth_socket plugin插件。
- > 简单来说这意味着当db_users使用数据库时，将会通过系统用户认证表进行认证。你可以通过下面的命令看看你的root用户是否设置成了这样：
  ```console
  $ sudo mysql -u root # I had to use "sudo" since is new installation

  mysql> USE mysql;
  mysql> SELECT User, Host, plugin FROM mysql.user;

  +------------------+-----------------------+
  | User             | plugin                |
  +------------------+-----------------------+
  | root             | auth_socket           |
  | mysql.sys        | mysql_native_password |
  | debian-sys-maint | mysql_native_password |
  +------------------+-----------------------+
  ```
- > 就像你在查询语句中看到的那样，root用户在使用auth_socket插件。有两种方法来解决这个问题：
  * > 1.你可以设置你的root用户使用`mysql_native_password`插件
  * > 2.你可以创建一个与你的系统用户一致的新的数据库用户（推荐）（笔者注：方法2即满足auth_socket插件的要求）
- > **选择1**:
  ```console
  # 这里如果是普通用户，必须用 sudo。或者就干脆切换到 linux 的 root 用户。
  $ sudo mysql -u root  # I had to use "sudo" since is new installation

  mysql> USE mysql;
  mysql> UPDATE user SET plugin='mysql_native_password' WHERE User='root';
  mysql> FLUSH PRIVILEGES;
  mysql> exit;

  $ service mysql restart
  ```
- > **选择2**（ 用你的操作系统用户名代替YOUR_SYSTEM_USER）：
  ```console
  $ sudo mysql -u root # I had to use "sudo" since is new installation

  mysql> USE mysql;
  mysql> CREATE USER 'YOUR_SYSTEM_USER'@'localhost' IDENTIFIED BY '';
  mysql> GRANT ALL PRIVILEGES ON *.* TO 'YOUR_SYSTEM_USER'@'localhost';
  mysql> UPDATE user SET plugin='auth_socket' WHERE User='YOUR_SYSTEM_USER';
  mysql> FLUSH PRIVILEGES;
  mysql> exit;

  $ service mysql restart
  ```
- > 注意：在一些操作系统中（例如Debian系）`'auth_socket'` 插件被叫做 `'unix_socket'`，所以相应的SQL命令语句应该为 `UPDATE user SET plugin='unix_socket' WHERE User='YOUR_SYSTEM_USER'`。

Ubuntu使用apt安装的mysql用户名密码及修改方法(转) https://blog.csdn.net/bytes9/article/details/93326299
- > 修改用户名和密码
  * > 登录mysql之后执行如下语句
    ```console
    mysql> update mysql.user set authentication_string=password('newpassword') where user='root';
    ```

Ubuntu 18.04 安装mysql 查看默认密码以及修改密码 https://blog.csdn.net/qq_41251963/article/details/117264959

## 异常中断后起不来的问题

mysql 启动报错 Could not open mysql.plugin table 的修复 https://beltxman.com/3316.html
- > 找到mysql安装目录下的bin目录，运行：
  ```sh
  mysql_install_db
  ```
- > 这个就相当于初始化一下，会发现有了mysql和一些其他必要的库，此时默认的用户是root，并且是没有设置密码的，此时已经可以正常启动mysql了。
- > 设置root用户密码。还是在mysql安装目录下的bin目录下，运行：
  ```sh
  mysqladmin -u root password
  ```
  > 输入两遍密码即可正常。

mysql server start failed https://askubuntu.com/questions/455029/mysql-server-start-failed

MySQL 数据库报错 Plugin ‘InnoDB‘ init function returned error 的解决办法 https://blog.csdn.net/peng2hui1314/article/details/129686915

**个人（综合上述链接）实战**：
```sh
# 首先是先看看 mysql 的 log：
$ cd /var/log/mysql
$ cat /var/log/mysql/error.log
2024-04-18 17:58:15 0 [Note] Starting MariaDB 10.3.39-MariaDB-0+deb10u2 source revision ca001cf2048f0152689e1895e2dc15486dd0b1af as process 3435150
2024-04-18 17:58:15 0 [Note] InnoDB: Using Linux native AIO
2024-04-18 17:58:15 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2024-04-18 17:58:15 0 [Note] InnoDB: Uses event mutexes
2024-04-18 17:58:15 0 [Note] InnoDB: Compressed tables use zlib 1.2.11
2024-04-18 17:58:15 0 [Note] InnoDB: Number of pools: 1
2024-04-18 17:58:15 0 [Note] InnoDB: Using SSE2 crc32 instructions
2024-04-18 17:58:15 0 [Note] InnoDB: Initializing buffer pool, total size = 128M, instances = 1, chunk size = 128M
2024-04-18 17:58:15 0 [Note] InnoDB: Completed initialization of buffer pool
2024-04-18 17:58:15 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
2024-04-18 17:58:15 0 [ERROR] InnoDB: MySQL-8.0 tablespace in ./ibdata1
2024-04-18 17:58:15 0 [ERROR] InnoDB: Restart in MySQL for migration/recovery.
2024-04-18 17:58:15 0 [ERROR] InnoDB: Plugin initialization aborted with error Unsupported
2024-04-18 17:58:16 0 [Note] InnoDB: Starting shutdown...
2024-04-18 17:58:16 0 [ERROR] Plugin 'InnoDB' init function returned error.
2024-04-18 17:58:16 0 [ERROR] Plugin 'InnoDB' registration as a STORAGE ENGINE failed.
2024-04-18 17:58:16 0 [Note] Plugin 'FEEDBACK' is disabled.
2024-04-18 17:58:16 0 [ERROR] Could not open mysql.plugin table. Some plugins may be not loaded
2024-04-18 17:58:16 0 [ERROR] Unknown/unsupported storage engine: InnoDB
2024-04-18 17:58:16 0 [ERROR] Aborting

# 也没什么信息，估计肯定是因为各种异常关闭，起不来了。反正数据不重要，打算直接清理已有的文件再重启了。
```

```sh
# 直接删掉所有当前数据库服务器端相关的文件（也不管里面有啥了，有些看着有点熟悉，比如 undo 相关的）
root:~# cd /var/lib/mysql
root:/var/lib/mysql# rm -rf ./*

# 重新初始化数据库，类似 pg 的 init_db
root:/var/lib/mysql# /usr/bin/mysql_install_db
Installing MariaDB/MySQL system tables in '/var/lib/mysql' ...
OK

To start mysqld at boot time you have to copy
support-files/mysql.server to the right place for your system


PLEASE REMEMBER TO SET A PASSWORD FOR THE MariaDB root USER !
To do so, start the server, then issue the following command:

'/usr/bin/mysql_secure_installation'

which will also give you the option of removing the test
databases and anonymous user created by default.  This is
strongly recommended for production servers.

See the MariaDB Knowledgebase at http://mariadb.com/kb

You can start the MariaDB daemon with:
cd '/usr' ; /usr/bin/mysqld_safe --datadir='/var/lib/mysql'

You can test the MariaDB daemon with mysql-test-run.pl
cd '/usr/mysql-test' ; perl mysql-test-run.pl

Please report any problems at http://mariadb.org/jira

The latest information about MariaDB is available at http://mariadb.org/.

Consider joining MariaDB's strong and vibrant community:
https://mariadb.org/get-involved/
```

```sh
# 也不知道用 systemctl 这种启动方式为啥失败了，我猜大概率是没有加 sudo？
# 但是也忘试了，直接用下面那种方式且加上 sudo，就好了- -
$ systemctl start mariadb.service
Failed to start mariadb.service: Access denied
See system logs and 'systemctl status mariadb.service' for details.
$
$ sudo /etc/init.d/mysql start
[ ok ] Starting mysql (via systemctl): mysql.service.
$

# 启动成功后就是登陆和改密码，这次按最早那种方式，只是把使用的认证插件改了，密码是用 mysqladmin 改的。
```

## 结果列垂直（以竖行）显示，类似 `psql` 的 `\x`

mysql查询结果格式化输出 https://www.cnblogs.com/panbin2006/p/16534702.html
- > **使用`\G`输出结果按行垂直显示结果**
  * > 当使用命令 select 结果，如果表属性特别多的时候，查看起来非常难受，在 select 语句后使用`\G`(必须大写)，可以让结果按行垂直显示：
    ```sql
    select * from user \G
    ```

## 不登陆直接执行命令

不登陆数据库执行 MySQL 命令 https://blog.csdn.net/u010649766/article/details/78694318
- > 有的时候需要查看数据库的某些信息，然后继续接下来的 shell 命令操作，登录数据库在退出嫌麻烦可以使用这招：
- > 例 1：列出所有数据库
```sh
mysql -h host_name -P3306 -u user_name -p'password' -se "show databases;"
```
- > 例 2：列出 database 下的所有表
```sh
mysql -h host_name -P3306 -u user_name -p'password' -D database -se "show tables;"
```
>> //notes：`-h` 和 `-P` （大写P）可以不用；`-se` 还不如 `-e` 显示的效果好看。实际使用时经常把 user_name 和 password 和命令行参数连一起：
```sh
mysql -uroot -pnewpassword -D mydb -e "show tables;"
```
