
# OS general

开源版“Windows 操作系统” ReactOS 0.4.9 版发布 - 软件和应用 - cnBeta.COM
https://www.cnbeta.com/articles/soft/751203.htm

最受欢迎的10个Linux发行版 https://www.linuxprobe.com/linux-welcome.html

# OS Kernel

Linux 内核揭密 https://github.com/MintCN/linux-insides-zh
  > Linux Insides中文 https://xinqiu.gitbooks.io/linux-insides-cn/content/index.html

## inode

linux下普通文件和目录文件区别 https://blog.csdn.net/mrjy1475726263/article/details/34436769

inode https://en.wikipedia.org/wiki/Inode 【[inode](https://zh.wikipedia.org/wiki/Inode)】
- > 文件系统创建（格式化）时，就把存储区域分为两大连续的存储区域。一个用来保存文件系统对象的元信息数据，这是由inode组成的表，每个inode默认是256字节或者128字节。另一个用来保存“文件系统对象”的内容数据，划分为512字节的扇区，以及由8个扇区组成的4K字节的块。块是读写时的基本单位。一个文件系统的inode的总数是固定的。这限制了该文件系统所能存储的文件系统对象的总数目。典型的实现下，所有inode占用了文件系统1%左右的存储容量。
  >
  > 文件系统中每个“文件系统对象”对应一个“inode”数据，并用一个整数值来辨识。这个整数常被称为inode号码（“i-number”或“inode number”）。由于文件系统的inode表的存储位置、总条目数量都是固定的，因此可以用inode号码去索引查找inode表。
  >
  > Inode存储了文件系统对象的一些元信息，如所有者、访问权限（读、写、执行）、类型（是文件还是目录）、内容修改时间、inode修改时间、上次访问时间、对应的文件系统存储块的地址，等等。知道了1个文件的inode号码，就可以在inode元数据中查出文件内容数据的存储地址。
  >
  > 文件名与目录名是“文件系统对象”便于使用的别名。一个文件系统对象可以有多个别名，但只能有一个inode，并用这个inode来索引文件系统对象的存储位置。
  >
  * inode不包含文件名或目录名的字符串，只包含文件或目录的“元信息”。
  * Unix的文件系统的目录也是一种文件。打开目录，实际上就是读取“目录文件”。目录文件的结构是一系列目录项（dirent）的列表。每个目录项，由两部分组成：所包含文件或目录的名字，以及该文件或目录名对应的inode号码。
  * 文件系统中的一个文件是指存放在其所属目录的“目录文件”中的一个目录项，其所对应的inode的类别为“文件”；文件系统中的一个目录是指存放在其“父目录文件”中的一个目录项，其所对应的inode的类别为“目录”。可见，多个“文件”可以对应同一个inode;多个“目录”可以对应同一个inode。
  * 文件系统中如果两个文件或者两个目录具有相同的inode号码，那么就称它们是“硬链接”关系。实际上都是这个inode的别名。换句话说，一个inode对应的所有文件（或目录）中的每一个，都对应着文件系统某个“目录文件”中唯一的一个目录项。
  * 创建一个目录时，实际做了3件事：在其“父目录文件”中增加一个条目；分配一个inode；再分配一个存储块，用来保存当前被创建目录包含的文件与子目录。被创建的“目录文件”中自动生成两个子目录的条目，名称分别是：“.”和“..”。前者与该目录具有相同的inode号码，因此是该目录的一个“硬链接”。后者的inode号码就是该目录的父目录的inode号码。所以，任何一个目录的"硬链接"总数，总是等于它的子目录总数（含隐藏目录）加2。即每个“子目录文件”中的“..”条目，加上它自身的“目录文件”中的“.”条目，再加上“父目录文件”中的对应该目录的条目。
  * 通过文件名打开文件，实际上是分成三步实现：首先，操作系统找到这个文件名对应的inode号码；其次，通过inode号码，获取inode信息；最后，根据inode信息，找到文件数据所在的block，读出数据。
- > 推论
  * 一个文件系统对象可以有多个名字，这些具有硬链接关系的文件系统对象名字具有相同的inode号码，彼此是平等的。即首个被创建的文件并没有特殊的地位。这与符号链接不同。一个符号链接文件有自己的inode，符号链接文件的内容是它所指向的文件的名字。因此删除符号链接所指向的文件，将导致这个符号链接文件在访问时报错。
  * 删除一个文件或目录，实际上是把它的inode的链接数减1。这并不影响指向此inode的别的硬链接。
  * 一个inode如果没有硬链接，此时inode的链接数为0，文件系统将回收该inode所指向的存储块，并回收该inode自身。
  * 从一个inode，通常是无法确定是用哪个文件名查到此inode号码的。打开一个文件后，操作系统实际上就抛掉了文件名，只保留了inode号码来访问文件的内容。库函数getcwd()用来查询当前工作目录的绝对路径名。其实现是从当前工作目录的inode逐级查找其上级目录的inode，最后拼出整个绝对路径的名字。
  * 历史上，对目录的硬链接是可能的。这可以使目录结构成为一个有向图，而不是通常的目录树的有向无环图。一个目录甚至可以是自身的父目录。现代文件系统一般禁止这些混淆状态，只有根目录保持了特例：根目录是自身的父目录。ls /..就是根目录的内容。
  * 一个文件或目录在文件系统内部移动时，其inode号码不变。文件系统碎片整理可能会改变一个文件的物理存储位置，但其inode号码不变。非UNIX的FAT及其派生的文件系统是无法实现inode不变这一特点。
  * inode文件系统中安装新库十分容易。当一些进程正在使用一个库时，其它进程可以替换该库文件名字的inode号码指向新创建的inode，随后对该库的访问都被自动引导到新inode所指向的新的库文件的内容。这减少了替换库时重启系统的需要。而旧的inode的链接数已经为0，在使用旧库的进程结束后，旧的inode与旧库文件会被系统自动回收。


理解inode http://www.ruanyifeng.com/blog/2011/12/inode.html


# Windows系

微软团队成员谈Windows Kernel的结构 - Windows - cnBeta.COM https://www.cnbeta.com/articles/tech/781961.htm

【IT之家学院】如何在Windows 10中重置和注销Linux子系统 https://www.ithome.com/0/415/133.htm

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
