
# 各个发行版的关系

浅析CentOS和RedHat Linux的区别 https://www.cnblogs.com/zjoch/p/6394150.html
- > CentOS是Community ENTerprise Operating System的简称，我们有很多人叫它社区企业操作系统，不管你怎么叫它，它都是Linux操作系统的一个发行版本。
  >
  > CentOS并不是全新的Linux发行版，倘若一说到Red Hat这个大名，大家似乎都听过。在Red Hat家族中有企业版的产品，它是Red Hat Enterprise Linux（以下称之为RHEL），CentOS正是这个RHEL的克隆版本。RHEL是很多企业采用的Linux发行版本，需要向Red Hat付费才可以使用，并能得到付过费用的服务和技术支持和版本升级。CentOS可以像RHEL一样的构筑Linux系统环境，但不需要向Red Hat付任何的产品和服务费用，同时也得不到任何有偿技术支持和升级服务。
  >
  > Red Hat公司的产品中，有Red Hat Linux（如Redhat8,9）和针对企业发行的版本Red Hat Enterprise Linux，都能够通过网络FTP免费的获得并使用，但是在2003年的时候，Red Hat Linux停止了发布，它的项目由Fedora Project这个项目所取代，并以Fedora Core这个名字发行并提供给普通用户免费使用。Fedora Core这个Linux发行版更新很快，大约半年左右就有新的版本发布。目前的版本是Fedora Core 6，这个Fedora Core试验的韵味比较浓厚，每次发行都有新的功能被加入到其中，得到的成功结果将被采用道RHEL的发布中。虽说这样，频繁的被改进更新的不安定产品对于企业来说并不是最好的选择，大多数企业还是会选择有偿的RHEL产品（这里面有很深的含义，比如说企业用Linux赚钱，赚到的钱回报给企业，资金在企业间流通，回报社会，提高服务水准等）。
- > RHEL 一直都提供源代码的发行方式，CentOS 就是将 RHEL 发行的源代码从新编译一次，形成一个可使用的二进制版本。由于 LINUX 的源代码是 GNU，所以从获得 RHEL 的源代码到编译成新的二进制，都是合法。只是 REDHAT 是商标，所以必须在新的发行版里将 REDHAT 的商标去掉。

Linux江湖之群雄割据的发行版本 https://www.jianshu.com/p/596acf900d8a
- > <div align="center"><img width="800" height="200" src="https://upload-images.jianshu.io/upload_images/3845101-728c5840ae4b8458.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp"/></div>

最全Linux的发行版简介，一文读懂各发行版之间的联系和区别 https://cloud.tencent.com/developer/article/1114589

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# RedHat系

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

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

CentOS 8 正式版发布 https://www.ithome.com/0/447/093.htm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
