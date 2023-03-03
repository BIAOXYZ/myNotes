
# Linux工具包（里面不止一个命令）类总结

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 旧版的 v.s. 有取代的

### `net-tools` VS `iproute2`

Linux TCP/IP 网络工具对比：net-tools 和 iproute2 https://blog.csdn.net/zhaihaifei/article/details/54617516

iproute2 对决 net-tools https://linux.cn/article-4326-1.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# SELinux

- 查看SELinux状态&关闭SELinux https://blog.csdn.net/GGxiaobai/article/details/53505095
```
1.1 getenforce
    getenforce 命令是单词get（获取）和enforce(执行)连写，可查看selinux状态，与setenforce命令相反。
    setenforce 命令则是单词set（设置）和enforce(执行)连写，用于设置selinux防火墙状态，如： setenforce 0用于关闭selinux防火墙，但重启后失效
1.2 /usr/sbin/sestatus
    SELinux status：selinux防火墙的状态，enabled表示启用selinux防火墙
    Current mode： selinux防火墙当前的安全策略，enforcing 表示强

2.1 临时关闭
    setenforce 0 ：用于关闭selinux防火墙，但重启后失效。
2.1 永久关闭
    修改selinux的配置文件，重启后生效。
```

```
实战：

test@cloudsec1 ~ $ getenforce
Permissive
test@cloudsec1 ~ $ sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   permissive
Mode from config file:          permissive
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Max kernel policy version:      31

//将 /etc/selinux/config 的 SELINUX= 改为enforcing
root@cloudsec1 ~ $ vi /etc/selinux/config
root@cloudsec1 ~ $ reboot

test@cloudsec1 ~ $ getenforce
Enforcing
test@cloudsec1 ~ $ sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   enforcing
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Max kernel policy version:      31
```

```
实战2：只是改完但不重启的话，/etc/selinux/config文件是改了，
但是sestatus命令显示结果上有一点不同，getenforce命令显示结果不变，其他影响未知。

[root@openshiftsingle ~]# getenforce
Permissive
[root@openshiftsingle ~]# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   permissive
Mode from config file:          permissive
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Max kernel policy version:      31

----------------------------------------------------------------------------------------------------

//看看未修改前的/etc/selinux/config文件。
[root@openshiftsingle ~]# cd /etc/selinux/
[root@openshiftsingle selinux]# cat config

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=permissive
# SELINUXTYPE= can take one of three two values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted

----------------------------------------------------------------------------------------------------

//用sed语句直接修改。
[root@openshiftsingle selinux]# sed -i 's/SELINUX=permissive/SELINUX=enforcing/' /etc/selinux/config

----------------------------------------------------------------------------------------------------

//改完后看下/etc/selinux/config文件，文件内容肯定是已经改了的————只有一处，非常明显。
[root@openshiftsingle selinux]# cat config

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=enforcing
# SELINUXTYPE= can take one of three two values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted

----------------------------------------------------------------------------------------------------

//注意这里Current mode的值还是permissive，但是Mode from config file的值已经是enforcing了。
[root@openshiftsingle ~]# getenforce
Permissive
[root@openshiftsingle selinux]# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   permissive
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Max kernel policy version:      31
```

- 一文彻底明白linux中的selinux到底是什么 https://blog.csdn.net/yanjun821126/article/details/80828908
- Selinux详细讲解及相关的配置 https://blog.csdn.net/Kangshuo2471781030/article/details/79294506
- Selinux小结 https://blog.csdn.net/gulinxieying/article/details/78677139

# AppArmor

AppArmor https://zh.wikipedia.org/wiki/AppArmor

AppArmor https://wiki.archlinux.org/index.php/AppArmor

# Linux下文本处理

建议收藏！超全的 Linux Shell 文本处理工具集锦 https://segmentfault.com/a/1190000037480939

# 小专题

## linux目录含义

Unix目录结构的来历 http://www.ruanyifeng.com/blog/2012/02/a_history_of_unix_directory_structure.html

Linux文件系统中/bin、/sbin、/usr/bin、/usr/sbin、/usr/local/bin、/usr/local/sbin文件夹的区别是什么？ - 知乎 https://www.zhihu.com/question/21265424

Differences between /bin, /sbin, /usr/bin, /usr/sbin, /usr/local/bin, /usr/local/sbin https://askubuntu.com/questions/308045/differences-between-bin-sbin-usr-bin-usr-sbin-usr-local-bin-usr-local
```sh
● /bin : For binaries usable before the /usr partition is mounted. This is used 
for trivial binaries used in the very early boot stage or ones that you need to 
have available in booting single-user mode. Think of binaries like cat, ls, etc.
● /sbin : Same, but for binaries with superuser (root) privileges required.
● /usr/bin : Same as first, but for general system-wide binaries.
● /usr/sbin : Same as above, but for binaries with superuser (root) privileges required.

if I'm writing my own scripts, where should I add these?

None of the above. You should use /usr/local/bin or /usr/local/sbin for system-wide available scripts. The local path means it's not managed by the system packages (this is an error for Debian/Ubuntu packages).

For user-scoped scripts, use ~/bin (a personal bin folder in your home directory).
```
```sh
$ man hier | grep -E 'bin$|sbin$|^.{7}(/bin)|^.{7}(/sbin)' -A2
```
 
/usr/bin vs /usr/local/bin on Linux https://unix.stackexchange.com/questions/8656/usr-bin-vs-usr-local-bin-on-linux

## Linux设备含义

C.4. Linux 里面的设备名称 https://www.debian.org/releases/stable/i386/apcs04.zh-cn.html  【这个真就官方翻译版现在还没翻译完，所以中英文混杂- -】
- > Linux 的磁盘和分区命名可能与其它操作系统不同。您需要知道创建和挂接分区时 Linux 所使用的设备名称。这里是基本的命名方案：
  * > 第一个软盘驱动器被命名为 `/dev/fd0`。
  * > 第二个软盘驱动器被命名为 `/dev/fd1`。
  * > The first hard disk detected is named `/dev/sda`.
  * > The second hard disk detected is named `/dev/sdb`, and so on.
- > 第一个 SCSI 光盘驱动器被命名为 `/dev/scd0`，也叫 `/dev/sr0`。
- > 每个磁盘分区的表示，是通过在磁盘名称后面附加一个十进制数字：`sda1` 和 `sda2` 代表系统里的第一个 SCSI 磁盘驱动器的第一个和第二个分区。
- > 这里有一个具体的例子。假设您有一个系统带有两个 SCSI 磁盘，一个 SCSI 地址是 2 并且另外一个地址是 4。第一个磁盘(在 2 上)会被命名为 `sda` 并且第二个是 `sdb`。如果 `sda` 驱动器有 3 个分区，它们将被命名为 `sda1`、`sda2` 和 `sda3`。这同样适用于 `sdb` 及其分区。
- > 注意如果您有两个 SCSI 主机总线适配器(控制器)，设备的顺序可能会比较混乱。最好的解决方案是观察引导信息，如果您知道驱动器型号和/或者容量。
- > Linux represents the primary partitions as the drive name, plus the numbers 1 through 4. For example, the first primary partition on the first drive is /dev/sda1. The logical partitions are numbered starting at 5, so the first logical partition on that same drive is /dev/sda5. Remember that the extended partition, that is, the primary partition holding the logical partitions, is not usable by itself.

SDB:Basics of partitions, filesystems, mount points https://en.opensuse.org/SDB:Basics_of_partitions,_filesystems,_mount_points
- > At boot time, the Linux system scans the hardware and associates to each of the discovered devices a special file a.k.a. device file. This special file - name given because it has no content on the disc, but it is used as a file - is a kind of interface between the device driver and hardware. 

## 判断当前主机是物理机还是虚拟机

如何判断当前主机是物理机还是虚拟机？ https://blog.csdn.net/yangzhenping/article/details/49996765
> Easy way to determine virtualization technology https://unix.stackexchange.com/questions/89714/easy-way-to-determine-virtualization-technology

## Linux输密码时显示星号

如何在Linux中输入Sudo密码时显示星号 https://www.howtoing.com/show-asterisks-sudo-password-in-linux

## Linux颜色相关

### 终端显示彩色

【[:star:][`*`]】 Linux基础命令和修改Linux终端输出颜色 https://www.cnblogs.com/Zzbj/p/10241935.html 【然而这个文章主要不在于彩色显示的部分。。。】
- > 3、touch还可以修改文件的时间
  ```sh
  touch -t '年月日时分秒' 文件   其中年和秒是可选的
  touch -t '201901072220' test.py  2019年1月7日22点20分
  ```
- > 28、拓展
  ```console
  127.0.0.1和0.0.0.0的区别
  假设我的电脑ip是192.168.3.16，那么
  127.0.0.1        代表本机回环地址
  0.0.0.0          代表着127.0.0.1加上192.168.3.16
  
  那么，如果我在本机起了一个服务，
  如果我设置的服务ip地址为127.0.0.1，就代表这个服务只有我自己本机才能访问，
  如果我设置的服务ip地址为0.0.0.0，就代表这个服务我自己本机可以访问，你使用192.168.3.16也可以访问到。
  
  因此，为什么Xshell可以远程连接到linux服务器
  1.因为服务器运行着sshd服务
  2.且sshd服务运行在0.0.0.0:22端口 
  3.我们就可以使用   ssh root@192.168.3.16:22去访问sshd服务，这个服务就是让我们连接到服务器
  ```

linux设置ls显示的各种文件颜色 https://blog.csdn.net/csCrazybing/article/details/50836434

### 脚本彩色输出

shell脚本输出输出带颜色内容 https://blog.csdn.net/David_Dai_1108/article/details/70478826

【by 直死之邪王灼眼】 Linux之Shell脚本自动化编程四（命令排序，元字符，echo实现彩色输出和printf） https://www.bilibili.com/read/cv933397/

## 获取ip地址的数字内容
- Which terminal command to get just IP address and nothing else? https://stackoverflow.com/questions/8529181/which-terminal-command-to-get-just-ip-address-and-nothing-else
```sh
harbor2:~ # /sbin/ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 52:54:00:F3:A5:43  
          inet addr:30.0.1.32  Bcast:30.0.255.255  Mask:255.255.0.0
          inet6 addr: fe80::5054:ff:fef3:a543/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:22037048 errors:0 dropped:358202 overruns:0 frame:0
          TX packets:489531 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:6231397965 (5942.7 Mb)  TX bytes:72839948 (69.4 Mb)

harbor2:~ # /sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}'
30.0.1.32

```
- How to get my own IP address and save it to a variable in a shell script? https://unix.stackexchange.com/questions/8518/how-to-get-my-own-ip-address-and-save-it-to-a-variable-in-a-shell-script
```sh

```

## linux时间

linux中文件的三种time（atime,mtime,ctime） https://www.cnblogs.com/zhaojiedi1992/p/zhaojiedi_linux_031_linuxtime.html

计算机时间到底是怎么来的？程序员必看的时间知识！ https://mp.weixin.qq.com/s/CWJ5axuD5JJVC4tBxf2FBQ
