
----------------------------------------------------------------------------------------------------
# 1.general Linux commands part:
----------------------------------------------------------------------------------------------------

## 显示类

## ps
ps ufx

<<Linux文件内容查阅 - cat, tac, nl, more, less, head, tail, od>>
http://www.linuxidc.com/Linux/2015-08/120978.htm

## 移动类

## mv
### 这个可以用来重命名
mv source destination

### 移动多个文件到一个目的地，此时需要把destination放到前面
mv -t destination source1 source2 ...

## cp
### 复制多个文件到一个目的地
cp -r source destination

## mkdir
### 递归创建目录
mkdir -p dir1/dir2/dir3/...


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
>其他参考：<<【Bash百宝箱】shell作业控制（jobs、bg、fg）>>http://blog.csdn.net/iEearth/article/details/52703576


## diff
### diff参数-y 是以并列方式显示; -W 指定宽度
diff file1 file2 -y -W 200 > differencefile


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

*更改用户:将liuliang添加到dbgrp用户组中*
```
usermod -g dbgrp liuliang
```

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

### tty

终端、虚拟终端、shell、控制台、tty的区别
http://blog.csdn.net/ltx06/article/details/52170852

### MTU

http://blog.csdn.net/su377486/article/details/51566642

https://www.cnblogs.com/bluefrog/archive/2012/07/07/2580928.html

### /dev/random

<</dev/random和/dev/urandom的一点备忘>>
http://blog.csdn.net/ohmygirl/article/details/40385083


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
(http://www.runoob.com/linux/linux-comm-od.html) 
(https://www.cnblogs.com/Vivian517/p/7612255.html)
- http://man.linuxde.net/usermod
- http://man.linuxde.net/lsof
(https://www.cnblogs.com/the-study-of-linux/p/5501593.html)
(https://www.cnblogs.com/peter9/archive/2011/07/28/2362156.html)


<<linux运维常用命令一句话（持续更新中）>>
http://www.linuxde.net/2011/09/721.html


<<每天一个linux命令>>
http://www.cnblogs.com/peida/tag/%E6%AF%8F%E6%97%A5%E4%B8%80linux%E5%91%BD%E4%BB%A4/


有哪些高效但是不常见的CLI命令？ - 知乎
https://www.zhihu.com/question/25910725

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
