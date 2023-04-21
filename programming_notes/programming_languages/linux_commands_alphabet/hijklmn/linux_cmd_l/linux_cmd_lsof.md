
lsof https://en.wikipedia.org/wiki/Lsof

# 文章

【[:star:][`*`]】 Linux lsof 命令 https://www.cnblogs.com/sparkdev/p/10271351.html  【from `sparkdev`】
- > **基本输出**
  * > 如果不带任何选项执行 lsof 命令，会输出系统中所有 active 进程打开的所有文件，结果就是我们被输出的信息所淹没，这没有任何的意义。我们先让 lsof 命令输出当前 Bash 进程打开的文件，并截取其中的一部分结果来介绍输出内容中都包含哪些信息： <br> ![](https://img2018.cnblogs.com/blog/952033/201901/952033-20190115130705738-1932625228.png)
    ```console
    COMMAND：程序的名称
    PID：进程标识符
    USER：进程所有者
    FD：文件描述符，应用程序通过文件描述符识别该文件
    TYPE：文件类型，如 DIR、REG 等
    DEVICE：以逗号分隔设备编号
    SIZE：文件的大小(bytes)
    NODE：索引节点(文件在磁盘上的标识)
    NAME：打开文件的确切名称
    ```
- > **查看被打开的与网络相关的文件**
  * >
    ```console 
    -i 选项用来查看被打开的和网络相关的文件，其参数的格式如下：
    [46][protocol][@hostname|hostaddr][:service|port]
    46 表示 IP 协议的版本
    protocol 表示网络协议的名称，比如 TCP 或 UDP  
    hostname 或 hostaddr 表示主机地址
    service 指 /etc/services 中的名称，比如 smtp 或多个服务的列表
    port 表示端口号，可以指定一个或多个
    ```
  * > `-i` 选项默认会同时输出 IPv4 和 IPv6 打开的文件：
    ```sh
    $ sudo lsof -i
    ```
  * > **列出与 22 号端口相关的文件**
    ```sh
    $ sudo lsof -i:22
    ```
- > **查看某个用户打开的所有文件**
  * > **杀掉某个用户打开了文件的所有进程**
    ```sh
    $ kill -9 $(lsof -t -u nick)
    ```
    > 该命令中的 `-t` 选项让 lsof 命令只输出进程的 PID：![](https://img2018.cnblogs.com/blog/952033/201901/952033-20190115132038422-864167888.png)
    >> 【[:star:][`*`]】 //notes：实测可以用类似 `kill -9 $(lsof -i:12345 -t)` 命令一键杀掉所有正在使用 `12345` 端口的进程。

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

lsof命令 https://www.yiibai.com/linux/lsof.html

lsof https://wangchujiang.com/linux-command/c/lsof.html

Linux 命令神器：lsof 入门 https://linux.cn/article-4099-1.html
