

# VirtualBox

***--------------------------------------------------分割线--------------------------------------------------***

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

***--------------------------------------------------分割线--------------------------------------------------***

- 基于VirtualBox安装Ubuntu图文教程 http://www.cnblogs.com/rocedu/p/6012545.html 【基本是按照这个来的，因为之前已经安了CentOS了，所以只是把系统安装好，进去看了看，网什么的都没来及管。】
- VirtualBox安装部署Ubuntu 16.04 图文详解 https://www.linuxidc.com/Linux/2016-08/134580.htm

***--------------------------------------------------分割线--------------------------------------------------***

## VirtualBox网络问题

***--------------------------------------------------分割线--------------------------------------------------***

- `1.连外网需用网络地址转换(NAT)方式。`按照【1】的步骤把linux在虚拟机装下来（不用装图形界面！），设置网络连接时网卡1用`NAT`方式就可以连外网了。
- `2.ssh连虚拟机需用仅主机(host-only)方式。`接着按照【2】里宿主机是wifi联网的情况下，网卡2用`仅主机`方式，这样可以用ssh连虚拟机了。连ssh虚拟机的话可以先在宿主机上执行下`ip address`看看地址（比如我这边是192.168.56.101），然后在宿主机里下个ssh客户端软件，然后`ssh test2@192.168.56.101`即可。

此外还有其他连接方式（比如桥接，有的帖子里号称最好，可以同时解决虚拟机连外网和局域网互相访问。但是也有的帖子说不行，我没试这种方式。还有端口转发什么的，也是没时间不试了），并且在有的帖子设置完还要改一些参数，但是我这边就是在VB里把网络1网络2一设置就好了。
- Window下使用Xshell连接VirtualBox中CentOS SSH最佳实践 https://blog.csdn.net/donglynn/article/details/47784393
- 宿主机SSH登录VirtualBox中的Linux CentOS 7（主宿互访） https://blog.csdn.net/wlwlwlwl015/article/details/50417839

***--------------------------------------------------分割线--------------------------------------------------***


- VirtualBox的Ubuntu16.04安装下来就直接能连外网。
- 但是不能用MobaXterm之类的软件从Windows系统ssh连接，原因是Ubuntu默认没有装ssh服务，需要自己手动装一下，安装参考下面链接前几步（实际上就执行了第一步安装一下openssh-server似乎就可以了，服务应该安完自己启动了）。此外，当然也需要在VB的虚拟机网络设置里把一个新的网卡（一般就网卡2了）设置成`仅主机`方式，这一步和上面在CentOS里做的一样。
> windows通过ssh连接虚拟机中的ubuntu步骤 https://blog.csdn.net/shengmingqijiquan/article/details/52367657


***--------------------------------------------------分割线--------------------------------------------------***

## CentOS 7安装VirtualBox

- CentOS 7 安装VirtualBox https://www.cnblogs.com/harry-h/p/6405433.html
- 在 CentOS 上安装及使用 VirtualBox https://wiki.centos.org/zh/HowTos/Virtualization/VirtualBox
- Installing and using VirtualBox on CentOS https://wiki.centos.org/HowTos/Virtualization/VirtualBox

### 最后因为Softlayer的虚拟机也是Xen虚拟的，所以估计是没办法了，坑死窝了。

- https://stackoverflow.com/questions/29116166/virtual-box-installation-issue-running-virtualbox-in-a-xen-environment-is-not-s
- https://blog.51cto.com/passover/760740

```
root@cloudsec1 ~ $ cd /etc/yum.repos.d/
root@cloudsec1 yum.repos.d $ ll
total 36
-rw-r--r--. 1 root root 1708 Feb 20 00:50 CentOS-Base.repo
-rw-r--r--. 1 root root 1309 Feb 20 00:50 CentOS-CR.repo
-rw-r--r--. 1 root root  649 Feb 20 00:50 CentOS-Debuginfo.repo
-rw-r--r--. 1 root root  314 Feb 20 00:50 CentOS-fasttrack.repo
-rw-r--r--. 1 root root  630 Feb 20 00:50 CentOS-Media.repo
-rw-r--r--. 1 root root 1331 Feb 20 00:50 CentOS-Sources.repo
-rw-r--r--. 1 root root 5701 Feb 20 00:50 CentOS-Vault.repo
-rw-r--r--. 1 root root 2424 Oct 24 12:22 docker-ce.repo
root@cloudsec1 yum.repos.d $ wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
root@cloudsec1 yum.repos.d $ ll
total 40
-rw-r--r--. 1 root root 1708 Feb 20 00:50 CentOS-Base.repo
-rw-r--r--. 1 root root 1309 Feb 20 00:50 CentOS-CR.repo
-rw-r--r--. 1 root root  649 Feb 20 00:50 CentOS-Debuginfo.repo
-rw-r--r--. 1 root root  314 Feb 20 00:50 CentOS-fasttrack.repo
-rw-r--r--. 1 root root  630 Feb 20 00:50 CentOS-Media.repo
-rw-r--r--. 1 root root 1331 Feb 20 00:50 CentOS-Sources.repo
-rw-r--r--. 1 root root 5701 Feb 20 00:50 CentOS-Vault.repo
-rw-r--r--. 1 root root 2424 Oct 24 12:22 docker-ce.repo
-rw-r--r--. 1 root root  259 Sep 30  2015 virtualbox.repo
root@cloudsec1 yum.repos.d $ yum install binutils qt gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms -y
.
.
.
Complete!

root@cloudsec1 yum.repos.d $ yum install VirtualBox-5.2
.
.
.
Complete!

root@cloudsec1 yum.repos.d $ cd /usr/lib/virtualbox/
root@cloudsec1 virtualbox $ pwd
/usr/lib/virtualbox
root@cloudsec1 virtualbox $ ./vboxdrv.sh setup
vboxdrv.sh: Stopping VirtualBox services.
vboxdrv.sh: Starting VirtualBox services.
vboxdrv.sh: failed: Running VirtualBox in a Xen environment is not supported.
root@cloudsec1 virtualbox $ uname -ar
Linux cloudsec1.sl.cloud9.ibm.com 3.10.0-957.1.3.el7.x86_64 #1 SMP Thu Nov 29 14:49:43 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
```

