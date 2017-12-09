
----------------------------------------------------------------------------------------------------
# 1.general Linux commands part:
----------------------------------------------------------------------------------------------------

## 显示类

## ps
ps ufx

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
find dir -name filename

grep -n -r -i "string" dir --color=auto

ctrl + z, fg, ctrl + z, fg, ...

## diff
### diff参数-y 是以并列方式显示; -W 指定宽度
diff file1 file2 -y -W 200 > differencefile


----------------------------------------------------------------------------------------------------

## 非一般性命令类

### 查看空间类

df -h 

du -sh

### coredump文件

<<详解coredump>>
http://blog.csdn.net/tenfyguo/article/details/8159176

```
查看数据库core_dump文件的位置
vi /proc/sys/kernel/core_pattern
```

### 查看网卡信息
```
/sbin/ifconfig
```

### 查看80端口被哪个程序占用
```
netstat -anp | grep 80
```

<<Linux查看物理CPU个数、核数、逻辑CPU个数>>
http://www.cnblogs.com/emanlee/p/3587571.html

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

### MTU

http://blog.csdn.net/su377486/article/details/51566642

https://www.cnblogs.com/bluefrog/archive/2012/07/07/2580928.html

### /dev/random

<</dev/random和/dev/urandom的一点备忘>>
http://blog.csdn.net/ohmygirl/article/details/40385083


## 问题处理

<<已解决：登录Linux的 -bash-4.2$ 问题 >>
http://blog.csdn.net/fly43108622/article/details/48155953

----------------------------------------------------------------------------------------------------
# 2.other part:
----------------------------------------------------------------------------------------------------

<<Linux命令大全>>系列
- http://man.linuxde.net/kill 
- http://man.linuxde.net/ldconfig
- http://man.linuxde.net/od (http://www.runoob.com/linux/linux-comm-od.html)

<<每天一个linux命令>>
http://www.cnblogs.com/peida/tag/%E6%AF%8F%E6%97%A5%E4%B8%80linux%E5%91%BD%E4%BB%A4/

<<linux 怎么把^M去掉>> 
http://blog.csdn.net/yangzhenzhen/article/details/8862236

<<linux运维常用命令一句话（持续更新中）>>
http://www.linuxde.net/2011/09/721.html

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

