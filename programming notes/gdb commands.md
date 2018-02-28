
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

<<gdb signal>>
http://blog.csdn.net/maotianwang/article/details/21451271
  
GNU Debugger or GDB: A Powerful Source Code Debugging tool for Linux Programs
https://www.tecmint.com/debug-source-code-in-linux-using-gdb/

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

