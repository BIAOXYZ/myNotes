
----------------------------------------------------------------------------------------------------
# 1.general Linux commands part:
----------------------------------------------------------------------------------------------------

## 显示类
### ps
ps ufx

### mv
mv source destination
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


# 查看网卡信息
/sbin/ifconfig

----------------------------------------------------------------------------------------------------
# 2.vim part：
----------------------------------------------------------------------------------------------------
## vim设置和取消显示行号
:set nu  
:set nonu
最好的办法是直接修改/etc/vimrc文件，在末尾添加
set nu

## vim移动命令
### vim跳转到文件头和文件尾
:1 或 gg
:$ 或 G


----------------------------------------------------------------------------------------------------
# 3.other part:
----------------------------------------------------------------------------------------------------
<<shell基础十二篇>>
http://www.cnblogs.com/woxing/articles/3427131.html

<<linux 怎么把^M去掉>> 
http://blog.csdn.net/yangzhenzhen/article/details/8862236

<<Samba 的多用户共享目录配置>>
http://blog.sina.com.cn/s/blog_545f2b4701010t8i.html

<<yum与rpm、apt的区别：rpm的缺陷及yum的优势>>
http://www.aboutyun.com/thread-9226-1-1.html
