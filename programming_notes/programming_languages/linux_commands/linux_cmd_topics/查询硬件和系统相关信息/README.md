
:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 硬件类

## CPU相关

### 查看CPU信息

Linux查看物理CPU个数、核数、逻辑CPU个数 http://www.cnblogs.com/emanlee/p/3587571.html
```shell
# 总核数 = 物理CPU个数 X 每颗物理CPU的核数 
# 总逻辑CPU数 = 物理CPU个数 X 每颗物理CPU的核数 X 超线程数

# 查看物理CPU个数
cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l

# 查看每个物理CPU中core的个数(即核数)
cat /proc/cpuinfo| grep "cpu cores"| uniq

# 查看逻辑CPU的个数
cat /proc/cpuinfo| grep "processor"| wc -l

# 查看CPU信息（型号）
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c
```

// 除了上面的 `cat /proc/cpuinfo` 再加上各种 `grep` 过滤，还有下面这个：
```sh
# lscpu命令，查看的是cpu的统计信息.
lscpu
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 内存相关

### 查看内存、硬盘等其他资源

Linux 查看系统硬件信息(实例详解) https://www.cnblogs.com/ggjucheng/archive/2013/01/14/2859613.html
- > 内存
  ```sh
  # 概要查看内存情况
  free -m

  # 查看内存详细使用
  cat /proc/meminfo

  # 查看内存硬件信息
  dmidecode -t memory
  ```
- > 磁盘
  ```sh
  # 查看硬盘和分区分布
  lsblk

  # 如果要看硬盘和分区的详细信息
  fdisk -l
  ```
- > 网卡
  ```sh
  # 查看网卡硬件信息
  lspci | grep -i 'eth'
  
  # 查看系统的所有网络接口
  ifconfig -a
  # 或者是
  ip link show
  
  # 如果要查看某个网络接口的详细信息，例如eth0的详细参数和指标
  ethtool eth0
  ```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 磁盘相关

### 查看磁盘空间
```shell
df -h 
du -sh
```

## 查看磁盘是SSD还是HDD
>> 【[:star:][`*`]】 //notes：以下查询结果为 `1` 表示磁盘可旋转，所以是 `HDD`；为 `0` 表示磁盘不可旋转，所以是 `SSD`。

How to know if a disk is an SSD or an HDD https://unix.stackexchange.com/questions/65595/how-to-know-if-a-disk-is-an-ssd-or-an-hdd

```sh
# 1. 使用 lsblk

$ lsblk -d -o name,rota
NAME ROTA
vda     1
vdb     1

## 或者查询更多的内容：
$ lsblk -d -o name,rota,size,type,mountpoint
NAME ROTA  SIZE TYPE MOUNTPOINT
vda     1  120G disk
vdb     1  500G disk /data00

# 2. 使用 cat /sys/block/<your_disk_device_name>/queue/rotational
$ cat /sys/block/vda/queue/rotational
1
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 网络相关

### 查看网卡信息
```shell
/sbin/ifconfig
```

### 查看80端口被哪个程序占用

查看linux中某个端口（port）是否被占用 https://blog.csdn.net/hsd2012/article/details/51384907
```shell
netstat -anp | grep 80

# 或者 lsof -i:port
lsof -i:80 
```

### 修改主机名
*总结*
```shell
# 查询linux机器的 hostname 命令很简单，大家应该都会用：使用root用户登录时，前面的登录符就是了

# 修改分为两种：1.暂时修改；2.永久修改
## 1.暂时修改
$ hostname newname

### newname即要设置的新的hostname，运行后立即生效，但是在系统重启后会丢失所做的修改，如果要永久更改系统的hostname，就要修改相关的设置文件。

## 2.永久修改
### suse操作系统是保存在 /etc/HOSTNAME 中的，修改该文件中的内容，重启之后就会生效。（重启时其实执行的 /etc/rc.d/boot.localnet 脚本，生效 hostname ）
### 如果想不重启永久修改主机名，需要做如下操作：
### 1.修改 /etc/HOSTNAME 文件
### 2.修改当前的 $HOSTNAME 变量
### 3.停掉 /etc/rc.d/boot.localnet
### 4.启动 /etc/rc.d/boot.localnet
```
- Linux hostname主机名配置文件/etc/hosts详解 http://www.jb51.net/LINUXjishu/77329.html
- IP、主机名和域名 http://blog.csdn.net/houjixin/article/details/52604941

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 软件系统类

## OS

### 查看操作系统版本

<<查看Linux版本系统信息方法汇总>> https://www.cnblogs.com/lanxuezaipiao/archive/2012/10/22/2732857.html
```shell
1、# uname －a   （Linux查看版本当前操作系统内核信息）
 
Linux localhost.localdomain 2.4.20-8 #1 Thu Mar 13 17:54:28 EST 2003 i686 athlon i386 GNU/Linux
 
2、# cat /proc/version （Linux查看当前操作系统版本信息）
 
Linux version 2.4.20-8 (bhcompile@porky.devel.redhat.com)
(gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Thu Mar 13 17:54:28 EST 2003
 
3、# cat /etc/issue  或 cat /etc/redhat-release（Linux查看版本当前操作系统发行版信息）
 
Red Hat Linux release 9 (Shrike)
```

```shell
# 补充： cat /etc/os-release

root@cloudsec1 openshift $ cat /etc/os-release
NAME="CentOS Linux"
VERSION="7 (Core)"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="7"
PRETTY_NAME="CentOS Linux 7 (Core)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:7"
HOME_URL="https://www.centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"

CENTOS_MANTISBT_PROJECT="CentOS-7"
CENTOS_MANTISBT_PROJECT_VERSION="7"
REDHAT_SUPPORT_PRODUCT="centos"
REDHAT_SUPPORT_PRODUCT_VERSION="7"
```

```sh
# 补充2，也可以用如下命令：
lsb_release -a

# 此外，CentOS下可能需要先安装：
yum install -y redhat-lsb
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 用户和用户组类

### 创建修改用户，密码等

*创建用户*
```shell
su - root
useradd -d /home/biaoxyz -m biaoxyz
passwd biaoxyz
(输入并确认密码即可)
```

### 创建用户组 testgroup
```shell
root@cloudsec1 ~ $ groupadd testgroup
```

### 更改用户组:将 biaoxyz 添加到 dbgrp 用户组中
```shell
usermod -g dbgrp biaoxyz  # --> 注意，这种方式不是增量添加，所以尽量不要用。

# 最近看的比较多的是用-aG参数的，比如 usermod -aG docker test2。但是我明明记得我用-g参数没问题啊。
# 还有说-a，-G单独用也可以的，比如这个帖子：https://www.cnblogs.com/fnng/archive/2012/05/13/2498366.html

[root@bogon hzh]# usermod -G testing chongshi      # 用户chongshi添加到组testing
[root@bogon hzh]# gpasswd -a bugmaster testing     # 用户bugmaster添加到组testing
Adding user bugmaster to group testing

# 注意：上面两种方式不同，但作用是一样的，都是将用户添加到组中。
```

***最终证明还是如下两种方法靠谱：以`添加test用户到docker用户组`为例***
```shell
usermod -aG docker test   # usermod -aG ${组名} ${用户名}
gpasswd -a test docker    # gpasswd -a ${用户名} ${组名}
```

```shell
# 这几个或多或少有些毛病，别用就是了！！！

usermod -a docker test   # 不能单独用-a参数
usermod -g docker test   # 这个似乎是把用户所有组里第一个替换成命令里的组
usermod -G docker test   # 这个似乎是把用户所有组里最后一个替换成命令里的组

# 初始时test用户属于testgr和test两个用户组。实验一下小g参数，发现docker组替换掉了第一个testgr组：
root@cloudsec1 ~ $ groups test
test : testgr test
root@cloudsec1 ~ $ usermod -g docker test
root@cloudsec1 ~ $ groups test
test : docker test

# 把test用户的组还原回来，再试大G参数，发现docker组替换掉了最后一个test组：
root@cloudsec1 ~ $ groups test
test : testgr test
root@cloudsec1 ~ $ usermod -G docker test
root@cloudsec1 ~ $ groups test
test : testgr docker
```

### 查看某个user所在的组，以及组内成员
`groups ${user}` 
```shell
# 用户 test 在三个组：test组、wheel组、docker组
[root@dhcp-9-186-54-39 ~]# groups test
test : test wheel docker
[root@dhcp-9-186-54-39 ~]# groups root
root : root
```

### 看某个组有哪些user的话
>> //notes：灵活点，从 `cat /etc/passwd` 想想就明白了：
```shell
cat /etc/group

# 嫌内容多的话可以 grep 再过滤下：
$ cat /etc/group | grep docker
docker:x:998:biaoxyz
```
