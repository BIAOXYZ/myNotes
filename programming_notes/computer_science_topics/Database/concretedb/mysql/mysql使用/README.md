
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

# 登陆密码问题

## 1
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
  * > 1.你可以设置你的root用户使用mysql_native_password插件
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

# 结果列垂直（以竖行）显示，类似 `psql` 的 `\x`

mysql查询结果格式化输出 https://www.cnblogs.com/panbin2006/p/16534702.html
- > **使用`\G`输出结果按行垂直显示结果**
  * > 当使用命令 select 结果，如果表属性特别多的时候，查看起来非常难受，在 select 语句后使用`\G`(必须大写)，可以让结果按行垂直显示：
    ```sql
    select * from user \G
    ```
