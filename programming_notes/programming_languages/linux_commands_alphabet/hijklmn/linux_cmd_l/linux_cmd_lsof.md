
lsof https://en.wikipedia.org/wiki/Lsof

# 文章

Linux lsof 命令 https://www.cnblogs.com/sparkdev/p/10271351.html  【from `sparkdev`】

3.lsof 一切皆文件 https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/lsof.html
- > 实例3：列出某个用户打开的文件信息
  ```sh
  $lsof -u username
  ```
- > 实例4：列出某个程序进程所打开的文件信息
  ```sh
  $lsof -c mysql
  ```
- > 实例6：通过某个进程号显示该进程打开的文件
  ```sh
  $lsof -p 11968
  ```
- > 实例7：列出所有的网络连接
  ```sh
  $lsof -i
  ```
- > 实例9：列出谁在使用某个端口
  ```sh
  $lsof -i :3306
  ```

# 其他

使用 lsof 查找打开的文件 https://www.ibm.com/developerworks/cn/aix/library/au-lsof.html

每天一个linux命令（51）：lsof命令 https://www.cnblogs.com/peida/archive/2013/02/26/2932972.html

linux lsof命令详解 https://www.cnblogs.com/ggjucheng/archive/2012/01/08/2316599.html

从 lsof 开始，深入理解 Linux 虚拟文件系统 https://mp.weixin.qq.com/s/OSENnCexQlbXNVkF7lVzjw || https://www.cyningsun.com/09-18-2020/learn-virtual-filesystem-from-lsof.html
