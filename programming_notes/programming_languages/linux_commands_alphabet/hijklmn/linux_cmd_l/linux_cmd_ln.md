
# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

Linux ln 命令 https://www.cnblogs.com/sparkdev/p/11275722.html

# 个人实战

### ln
```shell
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
  
```shell
给文件夹建链接的话要注意两点：1.只能建软链接；2.链接第二个参数不能带最后的斜杠（白话说就是软链接是个文件，不是个目录）

[ssluser@localhost tmp]$ ln -s folder1/ folder2/
ln: 目标"folder2/" 不是目录: 没有那个文件或目录
[ssluser@localhost tmp]$ ln -s folder1/ folder2
[ssluser@localhost tmp]$ ll
总用量 0
drwxrwxr-x. 2 ssluser ssluser 17 1月  25 18:03 folder1
lrwxrwxrwx. 1 ssluser ssluser  8 1月  25 18:05 folder2 -> folder1/

[ssluser@localhost tmp]$ ln folder1/ folder3
ln: "folder1/": 不允许将硬链接指向目录

--------------------------------------------------

然后cd folder2和cd folder1实际所进入的目录是一样的，
但是终端命令提示符前面显示的，以及pwd命令显示的不太一样，不再深究了。

[ssluser@localhost tmp]$ cd folder1
[ssluser@localhost folder1]$ pwd
/home/ssluser/tmp/folder1
[ssluser@localhost folder1]$ ll
总用量 0
-rw-rw-r--. 1 ssluser ssluser 0 1月  25 18:03 123

[ssluser@localhost folder1]$ cd ..

[ssluser@localhost tmp]$ cd folder2
[ssluser@localhost folder2]$ pwd
/home/ssluser/tmp/folder2
[ssluser@localhost folder2]$ ll
总用量 0
-rw-rw-r--. 1 ssluser ssluser 0 1月  25 18:03 123
```

linux 创建连接命令 ln -s 软链接 https://www.cnblogs.com/kex1n/p/5193826.html

理解 Linux 的硬链接与软链接 https://www.ibm.com/developerworks/cn/linux/l-cn-hardandsymb-links/index.html
```shell
清单 1. Linux 系统的顶层目录结构

/              根目录
├── bin     存放用户二进制文件
├── boot    存放内核引导配置文件
├── dev     存放设备文件
├── etc     存放系统配置文件
├── home    用户主目录
├── lib     动态共享库
├── lost+found  文件系统恢复时的恢复文件
├── media   可卸载存储介质挂载点
├── mnt     文件系统临时挂载点
├── opt     附加的应用程序包
├── proc    系统内存的映射目录，提供内核与进程信息
├── root    root 用户主目录
├── sbin    存放系统二进制文件
├── srv     存放服务相关数据
├── sys     sys 虚拟文件系统挂载点
├── tmp     存放临时文件
├── usr     存放用户应用程序
└── var     存放邮件、系统日志等变化文件
```
