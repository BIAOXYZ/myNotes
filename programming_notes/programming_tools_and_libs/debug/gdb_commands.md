
## GDB官网

GDB: The GNU Project Debugger https://www.gnu.org/software/gdb/

GDB Documentation https://www.gnu.org/software/gdb/documentation/

## GDB一般性知识

《100个gdb小技巧》 https://github.com/hellogcc/100-gdb-tips/blob/master/src/index.md || ~~https://www.gitbook.com/book/wizardforcel/100-gdb-tips/details~~ --> https://wizardforcel.gitbooks.io/100-gdb-tips/content/
- 配置gdb init文件 https://github.com/hellogcc/100-gdb-tips/blob/master/src/config-gdbinit.md
  * > 里面有个.gdbinit的配置文件可以参考下，这里就不列了。
- 每行打印一个结构体成员 https://github.com/hellogcc/100-gdb-tips/blob/master/src/set-print-pretty-on.md
  * > set print pretty on

## 我的gdb配置(.gdbinit， bps.cfg， .gdb_history全都在~目录下)和调试
```console
# .gdbinit 

# for postgres debug
handle SIGUSR2 noprint nostop

# for breakpoints
source ~/bps.cfg

# 保存历史命令
set history filename ~/.gdb_history
set history save on

# 退出时不显示提示信息
set confirm off

# 每行打印一个结构体成员
set print pretty on
```

### 这个新浪博客的帖子基本是最全的。下面笔记有我自己实验的一部分。

[GDB]GDB几个知识实例 http://blog.sina.com.cn/s/blog_54f82cc201013kce.html
```
info frame 
info f
这个命令会打印出更为详细的当前栈层的信息，只不过，大多数都是运行时的内内地址。比如：函数地址，调用函数的地址，
被调用函数的地址，目前的函数是由什么样的程序语言写成的、函数参数地址及值、局部变量的地址等等。

info args 打印出当前函数的参数名及其值。
info locals 打印出当前函数中所有局部变量及其值。 
info catch 打印出当前的函数中的异常处理信息。 
set listsize 设置一次显示源代码的行数。 
show listsize 查看当前 listsize的设置。
```
> 原文中问到：“whatis和ptype的区别？”
```
自己试了试发现ptype会把结构体展开，whatis不会：
(gdb) ptype edata
type = struct ErrorData {
    int elevel;
    bool output_to_server;
    bool output_to_client;
    bool show_funcname;
    bool hide_stmt;
    const char *filename;
    int lineno;
    const char *funcname;
    const char *domain;
    int sqlerrcode;
    char *message;
    char *detail;
    char *detail_log;
    char *hint;
    char *context;
    int cursorpos;
    int internalpos;
    char *internalquery;
    int saved_errno;
} *
(gdb) whatis edata
type = ErrorData *
```

```
另外再总结一下，虽然一直知道gdb可以用无歧义的简写指令，但是除了b(r)，bt，d，i，l，s，n等寥寥的几个，大部分还是用全拼。
下面总结一些其他常用的缩写，有的已经习惯，有的要多用用

i b 这个不用说了
i f 这个也不用说了

d br 这是因为仅用d b会有下述歧义
(gdb) d b
Ambiguous delete command "b": bookmark, breakpoints.

i lo = i loc = i local
i ar = i arg = i args
(gdb) i l
Ambiguous info command "l": line, locals.
(gdb) i a
Ambiguous info command "a": address, all-registers, args, auto-load, auto-load-scripts, auxv.

fin = finish
(gdb) f
#0  ReadBufferExtended (reln=0x7fb189daaf18, forkNum=MAIN_FORKNUM, blockNum=1, mode=RBM_NORMAL, strategy=0x0) at bufmgr.c:251
(gdb) fi
Ambiguous command "fi": file, files, fin, find, finish.
(gdb) fin
Run till exit from #0  ReadBufferExtended (reln=0x7fb189daaf18, forkNum=MAIN_FORKNUM, blockNum=1, mode=RBM_NORMAL, strategy=0x0) at bufmgr.c:251
ReadBuffer (reln=0x7fb189daaf18, blockNum=1) at bufmgr.c:198
Value returned is $241 = 82

u = until

//下面这俩我觉得有些疑点。使用enable时明明en也有可能是end，同理disable时dis也有可能是display等，
//但是确实断点开启，断点屏蔽操作都成功了（可能因为参数gdb能够确定）。不过感觉这两个命令还是别偷懒了，反正不是很常用。

(gdb) e
Ambiguous command "e": echo, edit, en, enable, end, eval, exec-file, explore.
(gdb) en
(gdb) i b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x00000000008109ba in exec_simple_query at postgres.c:4243
        breakpoint already hit 2 times
2       breakpoint     keep y   0x000000000059bc89 in ProcedureCreate at pg_proc.c:105
3       breakpoint     keep y   0x0000000000817660 in PortalRun at pquery.c:722

(gdb) di
Ambiguous command "di": directory, dis, disa, disable, disassemble, disconnect, display.
(gdb) dis
(gdb) i b
Num     Type           Disp Enb Address            What
1       breakpoint     keep n   0x00000000008109ba in exec_simple_query at postgres.c:4243
        breakpoint already hit 2 times
2       breakpoint     keep n   0x000000000059bc89 in ProcedureCreate at pg_proc.c:105
3       breakpoint     keep n   0x0000000000817660 in PortalRun at pquery.c:722
```

```console
# 查看进程信息，最简形式甚至可以到 i i，但是感觉还是 i inf 最靠谱？
info inferiors

# 查看线程信息，最简形式为 i th。
info threads
```

## 较系统攻略

GDB调试指南 https://www.yanbinghu.com/2019/04/20/41283.html  || https://github.com/yanbinghu/yanbinghu.github.io/blob/master/2019/04/20/41283.html || https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzI2OTA3NTk3Ng==&action=getalbum&album_id=1337122386575147009 || GDB调试入门指南 - 守望的文章 - 知乎 https://zhuanlan.zhihu.com/p/74897601

【[:star:][`*`]】 掌握gdb调试从入门到进阶（一） - Xin Lee的文章 - 知乎 https://zhuanlan.zhihu.com/p/100385553
- > **二. 运行**
  * > 包含三个命令： run : 开始运行 start ： 运行并停在main函数上 continue ：继续运行 ignore ： 忽略某函数或文件 checkpoint: 设置书签

【[:star:][`*`]】 掌握gdb调试从入门到进阶（二） - Xin Lee的文章 - 知乎 https://zhuanlan.zhihu.com/p/100403438 【这个还包括了对coredump文件、以及对线程的调试】

陈皓GDB调试教程链接汇总 https://developer.aliyun.com/article/681075

## 其他实战或配置参考部分(包含了一个.gdbinit设置的例子，看起来设置得更整洁，不过还是习惯了断点文件叫bps.cfg- -)

### 调试实战

linux下C的GBD调试学习笔记 http://blog.csdn.net/risingsun001/article/details/50464366
```
我们做一个实验，把源代码改名或移到别处再用gdb调试，这样就列不出源代码了：
.
.
.
可见gcc的-g选项并不是把源代码嵌入到可执行文件中的，在调试时也需要源文件。
```

linux下gdb调试方法与技巧整理 https://blog.csdn.net/niyaozuozuihao/article/details/91802994

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

### 用了一阵VS后又回头用GDB（因为kernel停摆，虽然后面又很快局部的恢复）

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
```sh
save breakpoints bps.cfg
source bps.cfg
```

<<gdb调试断点的保存>> http://blog.csdn.net/yang15225094594/article/details/29599117


#### 后来发现用.gdbinit加断点文件的办法更好

gdb中忽略信号处理 https://blog.csdn.net/brucexu1978/article/details/7721321
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

## gdb layout

GDB技巧分享，让你的调试变得更方便 https://developer.aliyun.com/article/740313
- > 大家在IDE工具，如CDS、CDK、Keil中可以通过源代码对照着进行调试，非常方便。那gdb中有没有方法，能让大家也对照着源码进行调试呢。有，那就是tui模式。 在gdb命令行中输入 `tui enable` 即可进入tui模式 当然还有更快捷的方式，直接输入`Ctrl-X A`即可直接进入tui模式
  >> 好久不用，都忘了gdb里同步显示代码框的快捷键了。。。今天查了下，然后才知道除了`Ctrl-X A`外，还有命令直接调出这个窗口。

GDB同步显示源代码——layout https://www.cnblogs.com/postw/p/9670739.html
```console
1. 显示源代码窗口
(gdb) layout src
5. 显示窗口的大小
info win
```

`1. gdb 调试利器` https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/gdb.html

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:
--------------------------------------------------

## gdb stackexchange/stackoverflow

https://www.systutorials.com/docs/linux/man/5-gdbinit/
```
~/.gdbinit
User initialization file. It is executed unless user specified GDB options "-nx", "-n" or "-nh".

从这一句以及我个人的实践结果来看。放在~目录下的.gdbinit是不会自动随着gdb启动的。
还是必须得用alias来实现，比如：
alias gdb='gdb -x ~/.gdbinit'
```
https://stackoverflow.com/questions/9573683/where-is-gdbinit-is-located-and-how-can-i-edit-it
```
上面那个帖子和这个帖子都说了可以对不同程序使用不同的.gdbinit文件。但是我没有自己试过。
```

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

GDB调试多线程和多进程(三)：调试多进程应用 https://www.bilibili.com/video/BV1Y4411m7Z5/

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

GDB 7.0 与 回溯调试 - CSDN博客 https://blog.csdn.net/haoel/article/details/4674547

### Newly added

gdb各种调试命令和技巧 https://www.cnblogs.com/youxin/p/4305227.html

使用gdb调试程序完全教程 https://blog.csdn.net/gatieme/article/details/51671430

### 带参数调试

GDB调试带参数的程序 https://www.jianshu.com/p/1948eab69fe7
```sh
$ gdb --args ./A V1 V2 V3

$ gdb ./A，进入gdb后 r V1 V2 V3

$ gdb ./A，进入gdb后 设置参数set args V1 V2 V3 再直接 r。
```

### 带外部符号表调试

gdb使用symbol文件调试程序 https://www.jianshu.com/p/7050a8f8841c

gdb加载调试符号（符号表) https://blog.csdn.net/weixin_45375062/article/details/115870495

### 信号

gdb 调试总结 https://markrepo.github.io/tools/2018/06/22/gdb/

GDB命令基础，让你的程序bug无处躲藏 https://deepzz.com/post/gdb-debug.html

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# 其他调试工具

Linux调试工具 http://blog.csdn.net/hzrandd/article/details/50849329

### cgdb

cgdb - the curses debugger http://cgdb.github.io/
```
$ ./configure --prefix=/usr/local
$ make
$ sudo make install
```

CGDB中文手册 https://legacy.gitbook.com/book/leeyiw/cgdb-manual-in-chinese/details
> 这个手册不全，看的时候注意。不过其实cgdb也不太需要手册。命令和gdb通用，主要就是按ESC键进入上层代码窗口，按i键进入下层gdb命令窗口。然后按/键搜索之类的。可以参见这个书的"CGDB命令部分"

## DDD (Data Display Debugger)

```sh
yum -y groupinstall "X Window System"
mkdir dddpackage
cd dddpackage/
wget https://rpmfind.net/linux/epel/7/x86_64/Packages/d/ddd-3.3.12-20.el7.x86_64.rpm
yum install -y ddd-3.3.12-20.el7.x86_64.rpm
```

GNU DDD https://www.gnu.org/software/ddd/
- https://www.gnu.org/software/ddd/#Getting
  * > Where do I get DDD binaries? <br> The FSF does not distribute DDD binaries. You can ask for help if you need technical support. <br> DDD binaries for GNU/Linux are typically available via your GNU/Linux distributor:
    + > DDD packages for Debian GNU/Linux are found [here](https://packages.debian.org/sid/devel/ddd).
    + > DDD RPMs can be found in https://rpmfind.net/linux/rpm2html/search.php?query=ddd

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

### gdbgui

终端调试哪家强？ - 韦易笑的文章 - 知乎 https://zhuanlan.zhihu.com/p/32843449
- gdbgui https://www.gdbgui.com/

### xxgdb

xxgdb - X window system interface to the gdb debugger. http://manpages.ubuntu.com/manpages/bionic/man1/xxgdb.1.html

An X front-end to the GNU debugger gdb https://packages.debian.org/sid/xxgdb
