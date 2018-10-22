

# VirtualBox

- 在VirtualBox中安装CentOS 7 https://www.linuxidc.com/Linux/2016-09/135593.htm  【1】
- VirtualBox下安装CentOS7系统 https://www.cnblogs.com/hihtml5/p/8217062.html  【2】
> 为什么ifconfig 及 netstat程序centos7默认没有安装：你对 ifconfig／netstat 做了甚手脚？ https://wiki.centos.org/zh/FAQ/CentOS7#head-92797389f35e14847625dd0d1ceb5ed957e8cbec

How can I fix “cannot find a valid baseurl for repo” errors on CentOS? https://unix.stackexchange.com/questions/22924/how-can-i-fix-cannot-find-a-valid-baseurl-for-repo-errors-on-centos
> If pinging a well known host by its name (e.g. ping www.google.com) returns ping: unknown host but pinging an ip (e.g. ping 8.8.8.8) works fine then you have a DNS resolution issue -- try adding these entries to /etc/resolv.conf:
```
nameserver 8.8.8.8
nameserver 8.8.4.4
```

如何开启VirtualBox的共享粘贴板功能 https://jingyan.baidu.com/article/cbf0e500f88a4f2eaa289338.html

## VirtualBox网络问题

- `1.连外网需用网络地址转换(NAT)方式。`按照【1】的步骤把linux在虚拟机装下来（不用装图形界面！），设置网络连接时网卡1用`NAT`方式就可以连外网了。
- `2.ssh连虚拟机需用仅主机(host-only)方式。`接着按照【2】里宿主机是wifi联网的情况下，网卡2用`仅主机`方式，这样可以用ssh连虚拟机了。连ssh虚拟机的话可以先在宿主机上执行下`ip address`看看地址（比如我这边是192.168.56.101），然后在宿主机里下个ssh客户端软件，然后`ssh test2@192.168.56.101`即可。

此外还有其他连接方式（比如桥接，有的帖子里号称最好，可以同时解决虚拟机连外网和局域网互相访问。但是也有的帖子说不行，我没试这种方式。还有端口转发什么的，也是没时间不试了），并且在有的帖子设置完还要改一些参数，但是我这边就是在VB里把网络1网络2一设置就好了。
- Window下使用Xshell连接VirtualBox中CentOS SSH最佳实践 https://blog.csdn.net/donglynn/article/details/47784393
- 宿主机SSH登录VirtualBox中的Linux CentOS 7（主宿互访） https://blog.csdn.net/wlwlwlwl015/article/details/50417839
