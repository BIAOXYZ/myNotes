
List of Unix commands https://en.wikipedia.org/wiki/List_of_Unix_commands 【[Unix实用程序列表](https://zh.wikipedia.org/wiki/Unix%E5%AE%9E%E7%94%A8%E7%A8%8B%E5%BA%8F%E5%88%97%E8%A1%A8)】

----------------------------------------------------------------------------------------------------
# 1.general Linux commands part:
----------------------------------------------------------------------------------------------------

## 显示类

### ps
```shell
ps ufx
```
<<Linux文件内容查阅 - cat, tac, nl, more, less, head, tail, od>>
http://www.linuxidc.com/Linux/2015-08/120978.htm

```bash
有时某个进程的命令太长（比如k8s, etcd），为了显示完整命令，可以用：
ps -ef -w -w   // -ef可以换成-ufx，-w -w可以合并写成-ww。所以基本等价于下面这个：
ps ufx -ww

另外一种思路就是通过管道给cat：
ps ufx | cat  
ps -ef | cat

突然发现 ps -ef 和 ps ef 是不一样的（ps ufx带不带横杠都一样），回头看吧。
```

### ls

ls实现列文件按时间排序 https://blog.csdn.net/gtuu0123/article/details/4420424
```shell
1) ls -lt  时间最近的在前面
2) ls -ltr 时间从前到后
3) 利用sort
    ls -l | sort +7 (日期为第8列)   时间从前到后
    ls -l | sort -r +7      时间最近的在前面
```
**//注："+7"不是命令本身的内容，可能只是作者笔误。**

linux ls 按文件大小排序 https://blog.csdn.net/0210/article/details/41659647
```shell
ls -Sl
其是按照由大到小排序，如果想要反过来，从小到大，那么用:
ls -Slr
再者，如果想要输入是按照“便于人类阅读的方式”，那么就再加一个-h，表示"--human-readable"
这样单位就是k或者M ，比较容易看清楚结果。
```

Linux统计文件夹下的文件数目 http://noahsnail.com/2017/02/07/2017-02-07-Linux%E7%BB%9F%E8%AE%A1%E6%96%87%E4%BB%B6%E5%A4%B9%E4%B8%8B%E7%9A%84%E6%96%87%E4%BB%B6%E6%95%B0%E7%9B%AE/ || https://www.jianshu.com/p/ff2db451a26a || https://cloud.tencent.com/developer/article/1434091
- > Linux下有三个命令：`ls`、`grep`、`wc`。通过这三个命令的组合可以统计目录下文件及文件夹的个数。
  * > 统计当前目录下文件的个数（不包括目录）
    ```sh
    $ ls -l | grep "^-" | wc -l
    ```
  * > 统计当前目录下文件的个数（包括子目录）
    ```sh
    $ ls -lR | grep "^-" | wc -l
    ```
  * > 查看某目录下文件夹(目录)的个数（包括子目录）
    ```sh
    $ ls -lR | grep "^d" | wc -l
    ```
- > **命令解析**：
  * > `grep "^-"` -- 过滤ls的输出信息，只保留一般文件，只保留目录是 `grep "^d"`。

----------------------------------------------------------------------------------------------------

## 移动类

### mv
```shell
这个可以用来重命名文件:
mv source destination

移动多个文件到一个目的地，此时需要把destination放到前面:
mv -t destination source1 source2 ...
```

### cp
```shell
复制多个文件到一个目的地:
cp -r source destination
```

### mkdir
```shell
递归创建目录:
mkdir -p dir1/dir2/dir3/...
```

----------------------------------------------------------------------------------------------------

## 查找类

### find
```shell
find dir -name filename

grep -n -r -i "string" dir --color=auto 
(-nir可以合一起，并且可以用alias让grep就等于grep --color=auto)
```

#### find, grep, which, whereis, locate, type等的区别

***which/whereis differences https://superuser.com/questions/40301/which-whereis-differences***
```shell
How about learning about whereis and which using whatis?

----------------------------------------------------------------------------------------------------
$  whatis which
which                (1)  - shows the full path of (shell) commands

$  whatis whereis
whereis              (1)  - locate the binary, source, and manual page files for a command
----------------------------------------------------------------------------------------------------

Basically, whereis searches for "possibly useful" files, while which only searches for executables.

I rarely use whereis. On the other hand, which is very useful, specially in scripts. which is the 
answer for the following question: Where does this command come from?

----------------------------------------------------------------------------------------------------
$  which ls
/bin/ls

$  whereis ls
ls: /bin/ls /usr/share/man/man1p/ls.1p.bz2 /usr/share/man/man1/ls.1.bz2
----------------------------------------------------------------------------------------------------
```

```shell
Quoting their man pages :

whereis :

whereis locates source/binary and manuals sections for specified files.

For instance :

----------------------------------------------------------------------------------------------------
$ whereis php
php: /usr/bin/php /usr/share/php /usr/share/man/man1/php.1.gz
----------------------------------------------------------------------------------------------------

ie, the "php" executable, and some other stuff (like man pages).


and which :

which returns the pathnames of the files which would be executed in the current environment

For instance :

----------------------------------------------------------------------------------------------------
$ which php
/usr/bin/php
----------------------------------------------------------------------------------------------------

ie, only the "php" executable.
```

Linux的五个查找命令 http://www.ruanyifeng.com/blog/2009/10/5_ways_to_search_for_files_using_the_terminal.html

shell端查找和搜索：which, whereis, locate, find and grep https://my.oschina.net/u/2274721/blog/407228

Linux下which、whereis、locate、find 区别 https://blog.csdn.net/ithomer/article/details/9391279   by 阳光岛主

----------------------------------------------------------------------------------------------------

## 杀删类

### pkill和pgrep，pidof，killall，xkill等等

Finding the ID of a process and killing it https://unix.stackexchange.com/questions/27087/finding-the-id-of-a-process-and-killing-it
- ***answer from Hanan N.***
  * `killall ProcessName` (there is a disadvantage with this command in that you don't always know the process name of a program).
  * `pidof ProccessName` and `kill the result form pidof`
  * `ps xu | grep <process name> | grep -v grep | awk '{ print $2 }' | xargs kill -9` Try this one line and reuse it form the history of your bash, or better create an alias for it .
- ***answer from Kevin***
  * While Hanan has some good suggestions, I'll add `pgrep` / `pkill`. They allow much finer control over which process you find, and regular expressions if you don't know the precise process you'll need to kill.
  * P.S. Hanan's `pidof` can be fed to `kill` directly with backticks: **kill `pidof processname`**
- ***answer from jaypal singh***
  * `ps -e | awk '$4~/<process name>/{print $1}' | xargs kill`
  ```shell
  [jaypal:~/Temp] sleep 100&
  [1] 74863
  [jaypal:~/Temp] ps -e | awk '$4~/sleep/{print $1}' | xargs kill
  [1]+  Terminated: 15          sleep 100
  
  Sorry, this obviously does not meet the requirement of less typing so a good way of doing it would be to add 
  a function to your .bashrc, .profile or whatever the startup script. The function can be something like this
  
  killp() {
  awk -v pname="$1" '($4==pname){print $1}' <(ps -e) | xargs kill
  }
  
  Once added, you can simply pass the name of your process:

  [jaypal:~] sleep 100&
  [1] 77212
  [jaypal:~] killp sleep
  [1]+  Terminated: 15          sleep 100
  ```

- Linux中kill，pkill，killall和xkill命令汇总讲解 https://blog.csdn.net/simongeek/article/details/46429243
- kill 和 pgrep 和 pidof 和 awk 和 pkill 和 killall https://blog.csdn.net/freeking101/article/details/53445749
> "为了避免 kill 掉错误的进程，你应该用一下 " pgrep -l [进程名] " 列表来匹配进程名称。"
>
> "killall 同样使用 进程名 替代 PID，**并且它会 kill 掉所有的同名进程**。例如，如果你正在运行多个Firefox浏览器的实例，可以用命令把它们全部 kill 掉：（ killall 和 pkill 是相似的，**不过如果给出的进程名不完整，killall 会报错。pkill 不需要完整的进程名就行**）"

```shell
pgrep加-l参数可以防止错误，但是如果是作为脚本的一部分的话我觉得反而碍事。

[root@cloudsec2 ~]# pgrep etcd
25177
[root@cloudsec2 ~]# pgrep -l etcd
25177 etcd
[root@cloudsec2 ~]# pkill etcd

然后再看一下发现成功杀死etcd进程。killall就不试了，以前搞pg的时候用过，多进程的程序杀起来方便。
PS: etcd官方文档里用的是 kill `pgrep etcd` ，我想了想应该和 pkill etcd 是任何情形下都等价的吧，即使有多个etcd集群。
```

pkill命令详解 https://www.cnblogs.com/machangwei-8/p/10391688.html

----------------------------------------------------------------------------------------------------

## 其他暂未分类

### 暂停和放到前台继续执行，bg是放到后台
```shell
ctrl + z, fg, ctrl + z, fg, ...
```
> 其他参考：
- <<【Bash百宝箱】shell作业控制（jobs、bg、fg）>> http://blog.csdn.net/iEearth/article/details/52703576
- bg，fg，job命令详解 https://www.cnblogs.com/machangwei-8/p/10391440.html

### diff
```shell
diff参数-y 是以并列方式显示; -W 指定宽度：
diff file1 file2 -y -W 200 > differencefile
```

### tar
```shell
//有没有z主要看是不是zip文件；f参数必须放在最后；短横杠有没有都可以。

tar -zxvf {FILE_NAME}
```

Linux下tar命令解压到指定的目录 https://blog.csdn.net/libing_zeng/article/details/73268032
```shell
tar -zxvf /bbs.tar.zip -C /zzz/bbs

//把根目录下的bbs.tar.zip解压到/zzz/bbs下，前提要保证存在/zzz/bbs这个目录 
//这个和cp命令有点不同，cp命令如果不存在这个目录就会自动创建这个目录！
```

linux下tar.gz、tar、bz2、zip等解压缩、压缩命令小结 http://www.jb51.net/LINUXjishu/43356.html
```shell
----------------------------------------------------------------------------------------------------
tar命令参数：
----------------------------------------------------------------------------------------------------
这五个是独立的命令，压缩解压都要用到其中一个，可以和别的命令连用但只能用其中一个。

-c: 建立压缩档案 
-x：解压 
-t：查看内容 
-r：向压缩归档文件末尾追加文件 
-u：更新原压缩包中的文件
----------------------------------------------------------------------------------------------------
下面的参数是根据需要在压缩或解压档案时可选的。

-z：有gzip属性的 
-j：有bz2属性的 
-Z：有compress属性的 
-v：显示所有过程 
-O：将文件解开到标准输出 
---------------------------------------------------------------------------------------------------- 
下面的参数-f是必须的。

-f: 使用档案名字，切记，这个参数是最后一个参数，后面只能接档案名。
----------------------------------------------------------------------------------------------------
```

----------------------------------------------------------------------------------------------------

## 不常用命令

### [tee (command)](https://en.wikipedia.org/wiki/Tee_(command))

为初学者介绍的 Linux tee 命令（6 个例子） - Linux中国的文章 - 知乎 https://zhuanlan.zhihu.com/p/34510815

### xargs
<<【Bash百宝箱】xargs>> 
http://blog.csdn.net/iEearth/article/details/53941920

### dirs, pushd, popd

参见`linux_cmd_pushd`部分。

### read
Linux之read命令使用
https://www.linuxidc.com/Linux/2013-01/77875.htm

### fdisk
linux磁盘分区fdisk命令详解
https://my.oschina.net/acmfly/blog/116167

----------------------------------------------------------------------------------------------------

## 非一般性命令类(运维类)

http://os.51cto.com/art/200912/173050.htm

### 创建修改用户，密码等

*创建用户*
```shell
su - root
useradd -d /home/liuliang -m liuliang
passwd liuliang
(输入并确认密码即可)
```

#### 用户组相关

***创建用户组testgroup：***
```shell
root@cloudsec1 ~ $ groupadd testgroup
```

***更改用户组:将liuliang添加到dbgrp用户组中***
```shell
usermod -g dbgrp liuliang --> 注意，这种方式不是增量添加，所以尽量不要用。

// 最近看的比较多的是用-aG参数的，比如 usermod -aG docker test2。但是我明明记得我用-g参数没问题啊。
// 还有说-a，-G单独用也可以的，比如这个帖子：https://www.cnblogs.com/fnng/archive/2012/05/13/2498366.html

[root@bogon hzh]# usermod -G testing chongshi      用户chongshi添加到组testing
[root@bogon hzh]# gpasswd -a bugmaster testing     用户bugmaster添加到组testing
Adding user bugmaster to group testing
注意：上面两种方式不同，但作用是一样的，都是将用户添加到组中。
```

***最终证明还是如下两种方法靠谱：以`添加test用户到docker用户组`为例***
```shell
usermod -aG docker test   //usermod -aG ${组名} ${用户名}
gpasswd -a test docker   //gpasswd -a ${用户名} ${组名}
```

```shell
//这几个或多或少有些毛病，别用就是了！！！

usermod -a docker test   //不能单独用-a参数
usermod -g docker test   //这个似乎是把用户所有组里第一个替换成命令里的组
usermod -G docker test   //这个似乎是把用户所有组里最后一个替换成命令里的组

//初始时test用户属于testgr和test两个用户组。实验一下小g参数，发现docker组替换掉了第一个testgr组：
root@cloudsec1 ~ $ groups test
test : testgr test
root@cloudsec1 ~ $ usermod -g docker test
root@cloudsec1 ~ $ groups test
test : docker test

//把test用户的组还原回来，再试大G参数，发现docker组替换掉了最后一个test组：
root@cloudsec1 ~ $ groups test
test : testgr test
root@cloudsec1 ~ $ usermod -G docker test
root@cloudsec1 ~ $ groups test
test : testgr docker
```

***查看某个user所在的组,以及组内成员***
`groups ${user}` 
```shell
[root@dhcp-9-186-54-39 ~]# groups test
test : test wheel docker
[root@dhcp-9-186-54-39 ~]# groups root
root : root
```
***查看某个组有哪些user的话，灵活点，从`cat /etc/passwd`想想就明白了***：
```shell
cat /etc/group
```

### 修改主机名

*总结*
```shell
查询linux机器的hostname命令很简单，大家应该都会用：使用root用户登录时，前面的登录符就是了

修改分为两种：1.暂时修改；2.永久修改

1.暂时修改

#hostname newname

newname即要设置的新的hostname，运行后立即生效，但是在系统重启后会丢失所做的修改，如果要永久更改系统的hostname，就要修改相关的设置文件。

2.永久修改

suse操作系统是保存在/etc/HOSTNAME中的，修改该文件中的内容，重启之后就会生效。（重启时其实执行的/etc/rc.d/boot.localnet脚本，生效hostname）


如果想不重启永久修改主机名，需要做如下操作：

1.修改/etc/HOSTNAME文件

2.修改当前的$HOSTNAME变量

3.停掉/etc/rc.d/boot.localnet

4.启动/etc/rc.d/boot.localnet
```

- Linux hostname主机名配置文件/etc/hosts详解
http://www.jb51.net/LINUXjishu/77329.html
- IP、主机名和域名
http://blog.csdn.net/houjixin/article/details/52604941

### 查看空间类
```shell
df -h 
du -sh
```

### 查看网卡信息
```shell
/sbin/ifconfig
```

#### firefox上网
https://zhidao.baidu.com/question/364840654.html


### 查看80端口被哪个程序占用

查看linux中某个端口（port）是否被占用 https://blog.csdn.net/hsd2012/article/details/51384907
```shell
netstat -anp | grep 80

或者

// lsof -i:端口号
lsof -i:80 
```

<<Linux查看物理CPU个数、核数、逻辑CPU个数>>
http://www.cnblogs.com/emanlee/p/3587571.html

### 查看操作系统信息

<<查看Linux版本系统信息方法汇总>> https://www.cnblogs.com/lanxuezaipiao/archive/2012/10/22/2732857.html
```shell
1、# uname －a   （Linux查看版本当前操作系统内核信息）
 
Linux localhost.localdomain 2.4.20-8 #1 Thu Mar 13 17:54:28 EST 2003 i686 athlon i386 GNU/Linux
 
2、# cat /proc/version （Linux查看当前操作系统版本信息）
 
Linux version 2.4.20-8 (bhcompile@porky.devel.redhat.com)
(gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Thu Mar 13 17:54:28 EST 2003
 
3、# cat /etc/issue  或cat /etc/redhat-release（Linux查看版本当前操作系统发行版信息）
 
Red Hat Linux release 9 (Shrike)
```

```shell
补充：   cat /etc/os-release

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
再次补充，也可以用如下命令：
    lsb_release -a
此外，CentOS下可能需要先安装：
    yum install -y redhat-lsb
```

### 查看CPU信息
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

### .bashrc & /etc/profile

- Linux 之 /etc/profile、~/.bash_profile 等几个文件的执行过程 https://blog.csdn.net/ithomer/article/details/6322892
- Linux环境变量设置/etc/profile、/etc/bashrc、~/.profile、~/.bashrc区别 https://blog.csdn.net/c406495762/article/details/62902871

### tty

终端、虚拟终端、shell、控制台、tty的区别
http://blog.csdn.net/ltx06/article/details/52170852

### MTU

http://blog.csdn.net/su377486/article/details/51566642

https://www.cnblogs.com/bluefrog/archive/2012/07/07/2580928.html

### /dev/random

<</dev/random和/dev/urandom的一点备忘>>
http://blog.csdn.net/ohmygirl/article/details/40385083

Is a rand from /dev/urandom secure for a login key? https://security.stackexchange.com/questions/3936/is-a-rand-from-dev-urandom-secure-for-a-login-key

/dev/random vs /dev/urandom and are they secure? https://linuxhint.com/dev_random_vs_dev_urandom/

***延伸：*** 
使用dd命令快速生成大文件或者小文件的方法 - CSDN博客 https://blog.csdn.net/cywosp/article/details/9674757
```shell
dd if=/dev/zero of=test bs=1M count=1000
在当前目录下会生成一个1000M的test文件，文件内容为全0
```

## 问题处理

<<已解决：登录Linux的 -bash-4.2$ 问题 >>
http://blog.csdn.net/fly43108622/article/details/48155953

<<linux 怎么把^M去掉>> 
http://blog.csdn.net/yangzhenzhen/article/details/8862236
> https://www.zhihu.com/question/22130727

----------------------------------------------------------------------------------------------------
# 2.other part:
----------------------------------------------------------------------------------------------------

Linux命令简写和全称 https://blog.csdn.net/chinayuan/article/details/51291666

List of Unix commands https://en.wikipedia.org/wiki/List_of_Unix_commands

## 系列教程

<<Linux命令大全>>系列
- http://man.linuxde.net/kill 
- http://man.linuxde.net/ldconfig
- http://man.linuxde.net/od 
  * 课后练习：C语言实现Linux命令——od https://www.cnblogs.com/Vivian517/p/7612255.html
- http://man.linuxde.net/usermod
- http://man.linuxde.net/lsof
  * lsof命令详解 https://www.cnblogs.com/the-study-of-linux/p/5501593.html
  * Linux下通过端口杀死进程 https://www.cnblogs.com/peter9/archive/2011/07/28/2362156.html

Linux 命令大全 -- 菜鸟教程 http://www.runoob.com/linux/linux-command-manual.html
- Linux od命令 http://www.runoob.com/linux/linux-comm-od.html

<<每天一个linux命令>>系列
http://www.cnblogs.com/peida/tag/%E6%AF%8F%E6%97%A5%E4%B8%80linux%E5%91%BD%E4%BB%A4/ || https://www.cnblogs.com/peida/archive/2012/12/05/2803591.html
- 每天一个linux命令（13）：less 命令 http://www.cnblogs.com/peida/archive/2012/11/05/2754477.html
- 每天一个linux命令（35）：ln 命令 http://www.cnblogs.com/peida/archive/2012/12/11/2812294.html
- 每天一个linux命令（40）：wc命令 http://www.cnblogs.com/peida/archive/2012/12/18/2822758.html
  ```shell
  实例3：用来统计当前目录下的文件数
  ls -l | wc -l 
  
  (个人注解：实际上"wc -l"部分是关键，比如也可以写成 ll | wc -l)
  ```
- 每天一个linux命令（52）：ifconfig命令 http://www.cnblogs.com/peida/archive/2013/02/27/2934525.html
  ```
  说明：
  eth0 表示第一块网卡， 其中 HWaddr 表示网卡的物理地址，可以看到目前这个网卡的物理地址(MAC地址）是 00:50:56:BF:26:20
  inet addr 用来表示网卡的IP地址，此网卡的 IP地址是 192.168.120.204，广播地址， Bcast:192.168.120.255，掩码地址Mask:255.255.255.0 
  lo 是表示主机的回坏地址，这个一般是用来测试一个网络程序，但又不想让局域网或外网的用户能够查看，只能在此台主机上运行和查看所用的网络接口。比如把 HTTPD服务器的指定到回坏地址，在浏览器输入 127.0.0.1 就能看到你所架WEB网站了。但只是您能看得到，局域网的其它主机或用户无从知道。
  第一行：连接类型：Ethernet（以太网）HWaddr（硬件mac地址）
  第二行：网卡的IP地址、子网、掩码
  第三行：UP（代表网卡开启状态）RUNNING（代表网卡的网线被接上）MULTICAST（支持组播）MTU:1500（最大传输单元）：1500字节
  第四、五行：接收、发送数据包情况统计
  第七行：接收、发送数据字节数统计信息。
  ```

有哪些高效但是不常见的CLI命令？ - 知乎
https://www.zhihu.com/question/25910725

## Linux运维类

<<linux运维常用命令一句话（持续更新中）>>
http://www.linuxde.net/2011/09/721.html

brctl 命令详解 https://www.cnblogs.com/xieshengsen/p/5857415.html
```shell
yum install bridge-utils -y   //安装网桥管理工具包：bridge-utile
brctl show   //查询网桥信息
```

### pssh

【Linux运维入门】PSSH-轻量集群管理工具 https://blog.csdn.net/u010028869/article/details/51547926

使用PSSH批量管理Linux https://www.jianshu.com/p/d6c8b7aac221

## Linux小技巧

**linux里目录有空格的时候得用反斜杠加空格才能进去**
```shell
SZX1000126633:/home/liuliang/svndir # ll
total 8
drwxr-xr-x 2 root root 4096 Aug 31 15:26 svn on linux
drwxr-xr-x 2 root root 4096 Aug 31 15:24 svnonlinux
SZX1000126633:/home/liuliang/svndir # cd svn
svn on linux/ svnonlinux/   
SZX1000126633:/home/liuliang/svndir # cd svn\ on\ linux/
SZX1000126633:/home/liuliang/svndir/svn on linux # 
```

<<Linux最常用命令及快捷键整理>> http://www.cnblogs.com/wqsbk/p/5649037.html
```shell
Ctrl + a            光标移动到行首（ahead of line），相当于通常的Home键
Ctrl + e            光标移动到行尾（end of line）
Ctrl + u            删除光标之前到行首的字符
Ctrl + k            删除光标之前到行尾的字符
Ctrl + f            光标向前（forward）移动一个字符位置
Ctrl + b            光标往回（backward）移动一个字符位置
```

linux命令行常用光标移动快捷键 https://www.jianshu.com/p/de98af781829
```sh
Alt – b ：往回(左)移动一个单词
Alt – f ：往后(右)移动一个单词
```
>> //notes：上面的6个（尤其是前四个）貌似 Linux 下和 Mac 下都没问题，但是就是“***向前/向后移动一个单词***”这俩的快捷键跟 OS 和 ssh 客户端都有关系。。。目前在 Mac 下的 iTerm 里用下述帖子里的方法试了可以达到目的。但是唯一比较挫的是每次都得 `ESC + f/b`，而不是像别的一样 “按下 `Alt` 不放，每次只需要单独按 `f/b` 即可”。
- Linux命令行——光标快速移动的快捷键 https://blog.csdn.net/u010865136/article/details/95628409
```console
Esc b 左移一个单词[back]
Esc f 右移一个单词[forward]

注意：每次按下快捷键，需抬起后再按下快捷键，方可多次移动单词
```

<<linux反向搜索执行过的命令>> http://blog.csdn.net/rangf/article/details/6399897
```shell
linux命令行的history是一个熟知但不常用的命令，原因是要查某个命令的编号需要输入 history|grep xxx ，
又因为!?xxx,!xxx 属于运行即执行也不方便，ctrl+r则方便多了。

ctrl+r
用途：反向搜索执行过的命令。(reverse-i-search)

若对于现有history
611 ruby foo.rb
612 ruby bar.rb
613 ruby fo.rb
614 ruby ba.rb
615 ...
...
700 ...

在不知道序号的情况下，若要运行ruby foo.rb。
1、ctrl+r
2、foo
或
1、ctrl+r
2、fo
3、ctrl+r (继续反向搜索)
只需要寥寥几键。当然若仅是上几个命令还是[上]键更有效率
```

Linux目录多个斜杠是否完全等同单个斜杠？
https://unix.stackexchange.com/questions/12283/unix-difference-between-path-starting-with-and/12285


### 碰到了一个自己造成的搞笑问题，记一下吧~还挺有意思。

- 问题症状：
1. 用liuliang用户直接登录，或者从root用户su - liuliang切到该用户时，Linux系统命令提示符卡死，等了一阵以后或者登录不上，或者切换不过去还留在root用户。
2. 但是我发现在切到liuliang用户卡死的过程中按下ctrl+c终止，竟然可以切过去。但此时liuliang用户下的很多东西没法用，比如git会提示command not found。

- DEBUG(如果这也能算DEBUG的话，哈哈)过程：
1. 这个问题就昨天才出现，想想昨天就只是在.bashrc里加了一行```source /home/liuliang/bashrcfiles/bashrcap3```。**参见下面的Part I**。
2. 把这句注释掉，再切换到liuliang用户就没有这个问题了。奇怪了。。。此时改动方法肯定有了，就是每次登陆上去以后用个alias手动source那个新环境变量文件（其实这样也不对，同样会卡死，不过当时根本没有试，而是直接按下面步骤找根因去了），比如加一句```alias AP3='source /home/liuliang/bashrcfiles/bashrcap3'```。尽管不麻烦，但是根因没找到啊。
3. 试着在```source /home/liuliang/bashrcfiles/bashrcap3```前面加上```echo 12345```，后面加上```echo 67890```。再次用root切liuliang用户，还是卡死，并且在我手动ctrl+c终止前，一直在不停地往屏幕上打印12345。手动终止后，git还是用不了。**如下面的Part II所示**。
4. 想了想为啥会重复打这么多12345，再仔细看了看bashrcap3的内容（**参见下面的Part III**），明白了。。。就是那句```source ~/.bashrc```造成了脚本循环调用，所以卡死了。。。之所以会这么做是因为当时bashrcap3是从bashrcap2改过来的，改完顺手加了```source ~/.bashrc```这句。之前没出问题是因为之前每次启动的时候都是手动去source这个bashrcap3的，尽管它里面又source了一下.bashrc，但是.bashrc里没有bashrcap3相关的内容，所以到此就结束了。但是一旦.bashrc里加了bashrcap3相关的内容，就循环调用了。。。

PS：那个bashrcap3里主要是ap新版本需要的各种环境变量，它的内容里那一堆export ...跟这个问题没啥关系，就省略了。


```bash
--------------------------------------------------
### Part I
### contents of .bashrc at /home/liuliang/.bashrc
--------------------------------------------------

export LESS='R'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

####################
# for automatically displaying branch information in linux shell

function parse_git_branch_and_add_brackets {
git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \{\1\}/'
}
PS1="\u@\h:\033[1;33m\]\W\[\033[1;32m\]\$(parse_git_branch_and_add_brackets)\[\033[0m\]\> "
####################

####################
# for git auto completion

source ~/.git-completion.bash
####################

####################
# problem reason and DEBUG!!! 

echo 12345                                     // added today for DEBUG
source /home/liuliang/bashrcfiles/bashrcap3    // added yesterday, incurring dead loop
echo 67890                                     // added today for DEBUG
####################

```

```
--------------------------------------------------
### Part II
--------------------------------------------------

12345
12345
12345
12345
12345
12345
12345
12345
12345
12345
12345
12345
12345
12345
12345
12345
12345
12345
^Cliuliang@SZX1000126633:~\> git
If 'git' is not a typo you can run the following command to lookup the package that contains the binary:
    command-not-found git
-bash: git: command not found
liuliang@SZX1000126633:~\> which git
which: no git in (/home/liuliang/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib/mit/bin:/usr/lib/mit/sbin)
liuliang@SZX1000126633:~\> whereis git
git: /usr/local/git
```

```bash
--------------------------------------------------
### Part III
### contents of bashrcap3 at /home/liuliang/bashrcfiles/bashrcap3
--------------------------------------------------

source ~/.bashrc

#### enviroment variables for new mppdb cluster
export ...
export ...
.
.
.
```

