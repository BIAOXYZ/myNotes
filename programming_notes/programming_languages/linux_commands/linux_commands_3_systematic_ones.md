
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

# NFS文件系统

NFS (简体中文) https://wiki.archlinux.org/index.php/NFS_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

Linux下NFS服务器的搭建与配置 https://www.cnblogs.com/liuyisai/p/5992511.html

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

## Linux输密码时显示星号

如何在Linux中输入Sudo密码时显示星号 https://www.howtoing.com/show-asterisks-sudo-password-in-linux

## 脚本彩色输出

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
