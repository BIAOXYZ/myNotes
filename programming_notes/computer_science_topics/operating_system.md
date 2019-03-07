
# OS general

开源版“Windows 操作系统” ReactOS 0.4.9 版发布 - 软件和应用 - cnBeta.COM
https://www.cnbeta.com/articles/soft/751203.htm

最受欢迎的10个Linux发行版 https://www.linuxprobe.com/linux-welcome.html

# OS Kernel

Linux 内核揭密 https://github.com/MintCN/linux-insides-zh
  > Linux Insides中文 https://xinqiu.gitbooks.io/linux-insides-cn/content/index.html

# Windows系

微软团队成员谈Windows Kernel的结构 - Windows - cnBeta.COM
https://www.cnbeta.com/articles/tech/781961.htm

# RedHat系

浅析CentOS和RedHat Linux的区别 https://www.cnblogs.com/zjoch/p/6394150.html

## [CentOS](https://www.centos.org/)

> VirtualBox虚拟机里装了CentOS7.5，装完后yum update等都没法用。然后发现ping命令ping数字形式的ip地址可以，但是ping网址就不行，于是猜测是DNS的问题。经过查询后发现应该是要在 `/etc/resolv.conf` 里增加一些可用的DNS（比如8.8.8.8，114.114.114.114等），然后用`service network restart`重启一下网络服务即可。道理是这个道理，但是蛋疼的是只要一重启网络， `/etc/resolv.conf` 这个文件内容就还原了。。。擦！于是后面就是查一查怎样让修改永久生效。下面三个帖子综合看一下吧，反正核心点是修改 `/etc/sysconfig/network-scripts/ifcfg-eth<N>`，在这个文件里添加 `PEERDNS=no DNS1=XXX.XXX.XXX.XXX DNS2=XXX.XXX.XXX.XXX`等。我是加了如下的就好了。
`PEERDNS=no
DNS1=192.168.1.1
DNS2=8.8.8.8
DNS3=114.114.114.114`

- CentOS修改DNS重启或者重启network服务后丢失问题处理 https://www.linuxidc.com/Linux/2015-09/122761.htm
- /etc/resolv.conf 的更改在重启后丢失的解决办法 https://blog.csdn.net/qq_29350001/article/details/51785176
- linux resolv.conf 配置信息丢失解决方法 https://blog.csdn.net/wt346326775/article/details/56840619

--------------------------------------------------

CentOS 7 中 hostnamectl 的使用 https://www.linuxprobe.com/centos-7-hostnamectl.html
```
1.查看状态

# hostnamectl 或者 # hostnamectl status   (显示的结果都一样）

   Static hostname: localhost.localdomain
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 049717292ec9452890e50401d432e43c
           Boot ID: 2e69a66a7c724db6a44a8536f1670f7f
    Virtualization: kvm
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-229.el7.x86_64
      Architecture: x86_64
```
```
2.修改主机名称

# hostnamectl set-hostname Linuxprobe
# hostnamectl status

   Static hostname: linuxprobe
   Pretty hostname: Linuxprobe
         Icon name: computer-vm
           Chassis: vm
        Machine ID: dc99c115d7414d159fa4c5c0c0541c55
           Boot ID: 6236b67c13af4d98b5fa3780e66dfdeb
    Virtualization: kvm
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-229.el7.x86_64
      Architecture: x86_64
```

centos7 最小化安装 无 ifconfig,netstat 的安装 https://www.cnblogs.com/cocoajin/p/4064547.html
```
今天要用netstat命令，然后知道了两件事：
(1)CentOS Minimal不带netstat
(2)netstat工具对应的包不叫netstat（之前也碰到过这种情况，忘了是哪个软件了）

[root@cloudsec2 ~]# yum install -y netstat
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
No package netstat available.
Error: Nothing to do

--------------------------------------------------

然后是下面的内容是上面那个帖子里的解决方法以及一丢丢知识：

centos7 最小化安装之后，默认是没有 ifconfig,netstat命令的；我们可以直接使用 yum -y install net-tools 即可；

1. 先来看下 net-tools的信息
    yum info net-tools
2. 安装net-tools ，需要管理员权限
    yum -y install net-tools
```

# 嵌入式设备OS

BusyBox: The Swiss Army Knife of Embedded Linux https://busybox.net/about.html

BusyBox 简化嵌入式 Linux 系统 https://www.ibm.com/developerworks/cn/linux/l-busybox/index.html

# 移动设备OS

PrimeOS开启公测：在笔记本上运行Android应用和游戏 - 软件和应用 - cnBeta.COM https://www.cnbeta.com/articles/tech/785527.htm

# 其他OS

用于年幼学童教学的 Linux 发行版 PrimTux 发布第 4 版 - Linux - cnBeta.COM
https://www.cnbeta.com/articles/soft/781939.htm
