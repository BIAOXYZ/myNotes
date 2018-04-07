
## GDB一般性知识

《100个gdb小技巧》
https://www.gitbook.com/book/wizardforcel/100-gdb-tips/details


## 旧的GDB知识总结

<<使用GDB命令行调试器调试C/C++程序>>
https://linux.cn/article-4302-1.html
```
info locals
ptype [变量]
```

<<GDB命令使用总结（二）>>
http://blog.chinaunix.net/uid-20788636-id-1841301.html
```
finish
until
```

<<gdb 调试时指定跳到第几行>>
http://blog.csdn.net/yasi_xi/article/details/40075267

<< gdb signal >>
http://blog.csdn.net/maotianwang/article/details/21451271


### 调试实战

- linux下C的GBD调试学习笔记
http://blog.csdn.net/risingsun001/article/details/50464366
```
我们做一个实验，把源代码改名或移到别处再用gdb调试，这样就列不出源代码了：
.
.
.
可见gcc的-g选项并不是把源代码嵌入到可执行文件中的，在调试时也需要源文件。
```

- LINUX下GDB调试
http://blog.csdn.net/yeyuangen/article/details/6825542

- GDB 命令行调试之路(全 1-9)
http://www.cnblogs.com/syncg/archive/2012/12/26/2834503.html

GNU Debugger or GDB: A Powerful Source Code Debugging tool for Linux Programs
https://www.tecmint.com/debug-source-code-in-linux-using-gdb/


### 调试实战2

```
调试已启动的dn:

postgres=# alter table row_type_tbl_001 add column id int;
ERROR:  dn_6017_6018: role 16760 was concurrently dropped

- 用 "select * from pgxc_node_env;" 查到报错dn的主dn所在的主机ip和目录。
- 连上该主机，用 "ps aux | grep gaussdb" 找到该主dn的进程号dnpid。
- "gdb attach dnpid" 或 "gdb" 启动，然后在gdb内 "att dnpid"。
- gdb内: "handle SIGUSR2 nostop noprint"
- gdb内: "b elog.cpp:271"
- 到另一个已经连上cn的窗口执行语句，然后回到该窗口gdb内 "c"，有时候"c"一下不行，可以多"c"几次，注意看堆栈，在正确位置停下就行。
（注：也可以先在gdb内按 "c" 继续运行，然后到另一个已经连上cn的窗口执行语句。但这样有时候断不住，不知道为啥，回来再研究下。）
- 调试完成后gdb内执行 "detach"，然后 "q" 退出gdb。

cn和dn一起调试的话和该过程类似，只是除了执行语句的窗口，要额外开两个gdb，一个挂cn进程，一个挂dn进程。
各自打好断点，屏蔽好信号。
```

## 用了一阵VS后又回头用GDB（因为kernel停摆，虽然后面又很快局部的恢复）

```
handle SIGPIPE nostop
handle all nostop // 应该是这句？
```


*一个小技巧，大家在gdb调试mppdb时，总需要屏蔽信号：
可以这样让gdb每次自动加载这个屏蔽功能，不用每次自己输入*
```
alias gdb="gdb -x ~/.gdbinit"
wangct@linux207:~> cat ~/.gdbinit 
handle SIGUSR2 noprint nostop
```

### 保存断点

```
save breakpoints bps.cfg
source bps.cfg
```

<<gdb调试断点的保存>>
http://blog.csdn.net/yang15225094594/article/details/29599117


#### 后来发现用.gdbinit加断点文件的办法更好

gdb中忽略信号处理
https://blog.csdn.net/brucexu1978/article/details/7721321
```
info signals
info handle
查看有哪些信号在被GDB检测中。
```
```
启动配置文件
GDB使用中比较麻烦的事情，就是每次启动，还要手动敲一把命令，特别是断点比较多的情况，这个特便影响，工作效率。
查了一下gdb info，gdb支持自动读取一个启动脚本文件.gdbinit，所以经常输入的启动命令，就都可以写在gdb启动目录的.gdbinit里面。
比如
.gdbinit:
   file myapp
   handle SIGPIPE nostop
   break ss.c:100
   break ss.c:200
   run
GDB和bash类似，也支持source这个命令，执行另外一个脚本文件。所以可以修改一下.gdbinit:
.gdbinit:
   file myapp
   handle SIGPIPE nostop
   source gdb.break
   run
gdb.break:
   break ss.c:100
   break ss.c:200
这样修改的断点配置，只需要编辑gdb.break就可以了。再后来，偶而还是需要单独启动GDB，不想执行自动脚本，于是又改进了一下。
首先把.gdbinit命名为gdb.init，然后定义一个shell alias:
   $ alias .gdb=”gdb -x gdb.init”

这样如果需要使用自动脚本，就用.gdb命令，否则用gdb进入交互状态的gdb。这样配置以后可以一个简单命令就开始调试，整个效率就能提高不少。
```



### GDB的set用法

follow-fork-mode的用法为：
```
set follow-fork-mode [parent|child]
```
parent: fork之后继续调试父进程，子进程不受影响。
child: fork之后调试子进程，父进程不受影响。
因此如果需要调试子进程，在启动gdb后：set follow-fork-mode child

此外还有：
```
set detach-on-fork [on|off]
```
on: 断开调试follow-fork-mode指定的进程。
off: gdb将控制父进程和子进程。follow-fork-mode指定的进程将被调试，另一个进程置于暂停（suspended）状态。

线程跳转吧？？锁定线程
```
set scheduler-locking on
```

### GDB插件

http://blog.csdn.net/gatieme/article/details/63254211

GDB实用插件(peda, gef, gdbinit)全解
https://blog.csdn.net/gatieme/article/details/63254211

终端调试哪家强？ - 韦易笑的文章 - 知乎
http://zhuanlan.zhihu.com/p/32843449
- gdbgui
- Emacs GDB
- .gdbinit 上配置 peda

存在实现了后退功能的调试器吗？这种功能在实现上有什么难点呢？ - 知乎
https://www.zhihu.com/question/57574574
> 常用 GDB 命令中文速览 - Linux中国的文章 - 知乎 http://zhuanlan.zhihu.com/p/29663631
>> reverse-next -- 反向单步跟踪，如果有函数调用，不会进入该函数

gdb Debugging Full Example (Tutorial): ncurses - ETIN的文章 - 知乎
http://zhuanlan.zhihu.com/p/28769268
> gdb 调试入门，大牛写的高质量指南 http://blog.jobbole.com/107759/

### GDB多进程多线程调试

gdb调试多进程和多线程命令
http://blog.csdn.net/pbymw8iwm/article/details/7876797

linux gdb-多线程调试
http://blog.csdn.net/lhl_blog/article/details/8888010

使用 GDB 调试多进程程序
https://www.ibm.com/developerworks/cn/linux/l-cn-gdbmp/index.html


***旧的:***

fork 多进程调试
http://blog.csdn.net/fingding/article/details/46459095

用gdb调试程序的子进程
http://blog.csdn.net/cjfeii/article/details/21647663

## 其他参考链接：

<<gdb学习笔记(一)>>
http://simohayha.iteye.com/blog/493091

<Linux gdb调试器用法全面解析>
http://blog.csdn.net/21cnbao/article/details/7385161

Windows远程调试Linux上的C++程序
http://www.heimizhou.com/windows-remote-debug-linux-c-plus-plus.html
- 如何查看和停止Linux启动的服务 https://www.linuxidc.com/Linux/2016-05/131748.htm
- Linux 查看服务状态（服务与进程）https://blog.csdn.net/tanga842428/article/details/79040089


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# 其他调试工具

Linux调试工具
http://blog.csdn.net/hzrandd/article/details/50849329

## DDD (Data Display Debugger)

宇宙最强调试器DDD（Data Display Debugger）
http://blog.csdn.net/mirage1993/article/details/50883824

离线安装ddd调试器
http://blog.csdn.net/mifan88/article/details/8913684

### VS

VS2017远程调试 
http://blog.csdn.net/dybb8999/article/details/72625062


### UndoDB

<CppCon 2015: Greg Law 'Give me 15 minutes & I'll change your view of GDB'>
https://undo.io/resources/presentations/cppcon-2015-greg-law-give-me-15-minutes-ill-change/
>来源是Liam Huang翻译的一篇文章 <GDB 入门教程：调试 ncurses 相关 bug 的完整范例 >  https://liam0205.me/2017/05/27/tutorial-to-GDB-taking-ncurses-as-an-example/
>https://undo.io/products/undodb/

