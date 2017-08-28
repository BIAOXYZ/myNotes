
----------------------------------------------------------------------------------------------------
# 1.general Linux commands part:
----------------------------------------------------------------------------------------------------

## 显示类
### ps
ps ufx

## mv

### 这个可以用来重命名
mv source destination

### 移动多个文件到一个目的地，此时需要把destination放到前面
mv -t destination source1 source2 ...

### mkdir
mkdir dir
mkdir -p dir1/dir2/dir3/...

### 查找类
find dir -name filename

grep -n -r "string" dir


ctrl + z, fg, ctrl + z, fg, ...

### -y 是以并列方式显示; -W 指定宽度
diff file1 file2 -y -W 200 > differencefile


### 查看网卡信息
/sbin/ifconfig

----------------------------------------------------------------------------------------------------

## 非通用类

### 查看数据库core_dump文件的位置
vi /proc/sys/kernel/core_pattern




----------------------------------------------------------------------------------------------------
# 2.other part:
----------------------------------------------------------------------------------------------------
<<shell基础十二篇>>
http://www.cnblogs.com/woxing/articles/3427131.html

<<linux 怎么把^M去掉>> 
http://blog.csdn.net/yangzhenzhen/article/details/8862236

<<Samba 的多用户共享目录配置>>
http://blog.sina.com.cn/s/blog_545f2b4701010t8i.html

<<yum与rpm、apt的区别：rpm的缺陷及yum的优势>>
http://www.aboutyun.com/thread-9226-1-1.html
