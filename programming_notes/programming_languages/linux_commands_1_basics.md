
----------------------------------------------------------------------------------------------------
# 1.general Linux commands part:
----------------------------------------------------------------------------------------------------

## 显示类

### ps
```
ps ufx
```
<<Linux文件内容查阅 - cat, tac, nl, more, less, head, tail, od>>
http://www.linuxidc.com/Linux/2015-08/120978.htm

### ls

ls实现列文件按时间排序 https://blog.csdn.net/gtuu0123/article/details/4420424
```
1) ls -lt  时间最近的在前面
2) ls -ltr 时间从前到后
3) 利用sort
    ls -l | sort +7 (日期为第8列)   时间从前到后
    ls -l | sort -r +7      时间最近的在前面
```
**//注："+7"不是命令本身的内容，可能只是作者笔误。**

linux ls 按文件大小排序 https://blog.csdn.net/0210/article/details/41659647
```
ls -Sl
其是按照由大到小排序，如果想要反过来，从小到大，那么用:
ls -Slr
再者，如果想要输入是按照“便于人类阅读的方式”，那么就再加一个-h，表示"--human-readable"
这样单位就是k或者M ，比较容易看清楚结果。
```

## 移动类

### mv
```
这个可以用来重命名文件:
mv source destination

移动多个文件到一个目的地，此时需要把destination放到前面:
mv -t destination source1 source2 ...
```

### cp
```
复制多个文件到一个目的地:
cp -r source destination
```

### mkdir
```
递归创建目录:
mkdir -p dir1/dir2/dir3/...
```

## 查找类

### find
```
find dir -name filename

grep -n -r -i "string" dir --color=auto 
(-nir可以合一起，并且可以用alias让grep就等于grep --color=auto)
```

### 暂停和放到前台继续执行，bg是放到后台
```
ctrl + z, fg, ctrl + z, fg, ...
```
> 其他参考：<<【Bash百宝箱】shell作业控制（jobs、bg、fg）>>http://blog.csdn.net/iEearth/article/details/52703576

### diff
```
diff参数-y 是以并列方式显示; -W 指定宽度：
diff file1 file2 -y -W 200 > differencefile
```

### tar
linux下tar.gz、tar、bz2、zip等解压缩、压缩命令小结
http://www.jb51.net/LINUXjishu/43356.html

----------------------------------------------------------------------------------------------------

## 不常用命令

### xargs
<<【Bash百宝箱】xargs>> 
http://blog.csdn.net/iEearth/article/details/53941920

### dirs, pushd, popd
<<方便的目录转换－－－－－pushd、popd、dirs>>
http://blog.csdn.net/houqizhixiu12/article/details/45119407

<<linux 命令之 pushd、popd、dirs，以及栈的基础知识>>
http://blog.csdn.net/u011641885/article/details/45576533

### read
Linux之read命令使用
https://www.linuxidc.com/Linux/2013-01/77875.htm

### fdisk
linux磁盘分区fdisk命令详解
https://my.oschina.net/acmfly/blog/116167

### ln
```
ln file hardlink      //为文件file创建一个硬链接hardlink，file和hardlink都可以加上一些路径名之类的
ln -s file softlink   //为文件file创建一个符号链接softlink，创建完成后一般这么显示：softlink -> file
```
>> notes：虽然一些帖子里也解释了硬链接和软链接的区别，但是都零零散散的，这里自己总结一下吧，但是不贴手动实验的过程了。核心点就是**软链接类似快捷方式；硬链接类似一个绑定到原文件的文件副本**。
- 更新：
  * `更新file的内容或更新硬链接的内容`：变化会同步。
  * 基本不存在`更新软链接的内容`这一说法，因为它就是个快捷方式。
- 删除：
  * `删除源文件file`：软链接softlink失效；硬链接hardlink仍然有效（所谓仍然有效具体是指打开hardlink能打开，且里面内容和file一样）。
  * `重新再建一个同名文件file但里面内容不同`：此时软链接又有效了，打开软链接显示的是新的file的内容；但是硬链接打开还是过去旧的file的内容。————此时再更新file或者硬链接，变化不会同步。————说明这种情况下硬链接实际上已经断连。
- 移位： 
  * `把file换个位置，但是链接文件不换位置`：软链接失效，硬链接有效。`再把file放回原位置`：软链接又有效了，硬链接当然更不用说了，file换位置都有效，放回当然还是有效。
  * `把软(硬)链接换位置，但是file不换位置的话`：软链接依然失效。。。这点是和window的快捷方式不同的点；硬链接有效。`把软(硬)链接再放回原位`：软链接又有效了；硬链接当然还是一直有效。

linux 创建连接命令 ln -s 软链接 https://www.cnblogs.com/kex1n/p/5193826.html

----------------------------------------------------------------------------------------------------

## 非一般性命令类(运维类)

http://os.51cto.com/art/200912/173050.htm

### 创建修改用户，密码等

*创建用户*
```
su - root
useradd -d /home/liuliang -m liuliang
passwd liuliang
(输入并确认密码即可)
```

#### 用户组相关

*更改用户:将liuliang添加到dbgrp用户组中*
```
usermod -g dbgrp liuliang  

// 最近看的比较多的是用-aG参数的，比如 usermod -aG docker test2。但是我明明记得我用-g参数没问题啊。
// 还有说-a，-G单独用也可以的，比如这个帖子：https://www.cnblogs.com/fnng/archive/2012/05/13/2498366.html

[root@bogon hzh]# usermod -G testing chongshi      用户chongshi添加到组testing
[root@bogon hzh]# gpasswd -a bugmaster testing     用户bugmaster添加到组testing
Adding user bugmaster to group testing
注意：上面两种方式不同，但作用是一样的，都是将用户添加到组中。
```

*或者用如下方法添加test用户到docker用户组*
```
gpasswd -a test docker
```

*查看某个user所在的组,以及组内成员*
`groups ${user}` 
```
[root@dhcp-9-186-54-39 ~]# groups test
test : test wheel docker
[root@dhcp-9-186-54-39 ~]# groups root
root : root
```
*查看某个组有哪些user的话灵活点，想想就明白了*：`cat /etc/group`

### 修改主机名

*总结*
```
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
```
df -h 
du -sh
```

### coredump文件

<<详解coredump>>
http://blog.csdn.net/tenfyguo/article/details/8159176

```
查看数据库core_dump文件的位置
vi /proc/sys/kernel/core_pattern
```

gdb调试coredump(使用篇)
http://blog.csdn.net/sunxiaopengsun/article/details/72974548

### 查看网卡信息
```
/sbin/ifconfig
```

#### firefox上网
https://zhidao.baidu.com/question/364840654.html


### 查看80端口被哪个程序占用
```
netstat -anp | grep 80
```

<<Linux查看物理CPU个数、核数、逻辑CPU个数>>
http://www.cnblogs.com/emanlee/p/3587571.html

### 查看操作系统信息

<<查看Linux版本系统信息方法汇总>>
https://www.cnblogs.com/lanxuezaipiao/archive/2012/10/22/2732857.html

```
1、# uname －a   （Linux查看版本当前操作系统内核信息）
 
Linux localhost.localdomain 2.4.20-8 #1 Thu Mar 13 17:54:28 EST 2003 i686 athlon i386 GNU/Linux
 
2、# cat /proc/version （Linux查看当前操作系统版本信息）
 
Linux version 2.4.20-8 (bhcompile@porky.devel.redhat.com)
(gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Thu Mar 13 17:54:28 EST 2003
 
3、# cat /etc/issue  或cat /etc/redhat-release（Linux查看版本当前操作系统发行版信息）
 
Red Hat Linux release 9 (Shrike)
```

### 查看CPU信息
```
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

***延伸：*** 
使用dd命令快速生成大文件或者小文件的方法 - CSDN博客 https://blog.csdn.net/cywosp/article/details/9674757
```
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
http://www.cnblogs.com/peida/tag/%E6%AF%8F%E6%97%A5%E4%B8%80linux%E5%91%BD%E4%BB%A4/
- 每天一个linux命令（13）：less 命令 http://www.cnblogs.com/peida/archive/2012/11/05/2754477.html
- 每天一个linux命令（35）：ln 命令 http://www.cnblogs.com/peida/archive/2012/12/11/2812294.html
- 每天一个linux命令（40）：wc命令 http://www.cnblogs.com/peida/archive/2012/12/18/2822758.html
  ```
  实例3：用来统计当前目录下的文件数
  ls -l | wc -l 
  
  (个人注解：实际上"wc -l"部分是关键，比如也可以写成 ll | wc -l)
  ```

有哪些高效但是不常见的CLI命令？ - 知乎
https://www.zhihu.com/question/25910725

## Linux运维类

<<linux运维常用命令一句话（持续更新中）>>
http://www.linuxde.net/2011/09/721.html

【Linux运维入门】PSSH-轻量集群管理工具
https://blog.csdn.net/u010028869/article/details/51547926

## Linux小技巧

**linux里目录有空格的时候得用反斜杠加空格才能进去**
```
SZX1000126633:/home/liuliang/svndir # ll
total 8
drwxr-xr-x 2 root root 4096 Aug 31 15:26 svn on linux
drwxr-xr-x 2 root root 4096 Aug 31 15:24 svnonlinux
SZX1000126633:/home/liuliang/svndir # cd svn
svn on linux/ svnonlinux/   
SZX1000126633:/home/liuliang/svndir # cd svn\ on\ linux/
SZX1000126633:/home/liuliang/svndir/svn on linux # 
```

<<Linux最常用命令及快捷键整理>>
http://www.cnblogs.com/wqsbk/p/5649037.html
```
Ctrl + a            光标移动到行首（ahead of line），相当于通常的Home键
Ctrl + e            光标移动到行尾（end of line）
Ctrl + u            删除光标之前到行首的字符
Ctrl + k            删除光标之前到行尾的字符
Ctrl + f            光标向前（forward）移动一个字符位置
Ctrl + b            光标往回（backward）移动一个字符位置
```

<<linux反向搜索执行过的命令>>
http://blog.csdn.net/rangf/article/details/6399897
```
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

