
## GDB官网

GDB: The GNU Project Debugger https://www.gnu.org/software/gdb/

GDB Documentation https://www.gnu.org/software/gdb/documentation/
- 【[:star:][`*`]】 Debugging with GDB https://sourceware.org/gdb/current/onlinedocs/gdb/ || https://sourceware.org/gdb/onlinedocs/gdb/index.html
- https://sourceware.org/gdb/download/onlinedocs/
  * Debugging with gdb https://sourceware.org/gdb/download/onlinedocs/gdb.pdf

10.5 Output Formats https://sourceware.org/gdb/onlinedocs/gdb/Output-Formats.html

## GDB原理

一文看懂 | GDB 底层实现原理 https://mp.weixin.qq.com/s/TYqXPtanCKmBa-UeWoJLDA

## GDB一般性知识

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

gdb中查看数组各项的值 https://blog.csdn.net/scusyq/article/details/7034082
- > 于是，在 GDB调试过程中，你可以以如下命令显示出这个动态 数组的取值：
```sh
p *array@len
```

GDB调试 打印二维数组 https://blog.csdn.net/leoufung/article/details/104565003
```console
int matrix1[3][3] = {{1,2,3},{4,5,6},{7,8,9}};
gdb打印的命令为：
p **matrix@3@3
```

gdb打印技巧 https://www.jianshu.com/p/98c923a671ae
- > **打印数组中任意连续元素值**
  * > 在gdb中，如果要打印数组中任意连续元素的值，可以使用 ***`p array[index]@num`*** 命令（p是print命令的缩写）。其中index是数组索引（从0开始计数），num是连续多少个元素。
  * > 如果要打印从数组开头连续元素的值，也可使用这个命令：***`p *array@num`***
- > **打印静态变量的值**
  * > 你可以显式地指定文件名（上下文）：
    ```sh
    (gdb) p 'static-1.c'::var
    $1 = 1
    (gdb) p 'static-2.c'::var
    $2 = 2
    ```

gdb调试打印 `void*` 或者 `void **` 类型的成员方法 https://blog.csdn.net/ljb825802164/article/details/106301826
- > linux gdb调试时，使用p命令打印一个 `(void *)` 变量时会报错：`Attempt to dereference a generic pointer.`
- > 此时，只需要将 `(void *)` 变量强制类型转化成需要打印的类型，使用p命令即可打印。例如，需要打印 `(int *)` 型entries变量，则使用命令格式：
  ```console
  (gdb) p *(int *)map->entries
  $38 = 0
  ```

GDB print all values in char array https://stackoverflow.com/questions/29528732/gdb-print-all-values-in-char-array
- https://stackoverflow.com/questions/29528732/gdb-print-all-values-in-char-array/29528983#29528983
  * > `x/19bc 变量名`

What is the x command in GDB? https://www.educative.io/answers/what-is-the-x-command-in-gdb

x command https://visualgdb.com/gdbreference/commands/x

## 较系统攻略

GDB调试指南 https://www.yanbinghu.com/2019/04/20/41283.html  || https://github.com/yanbinghu/yanbinghu.github.io/blob/master/2019/04/20/41283.html || https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzI2OTA3NTk3Ng==&action=getalbum&album_id=1337122386575147009 || GDB调试入门指南 - 守望的文章 - 知乎 https://zhuanlan.zhihu.com/p/74897601

【[:star:][`*`]】 掌握gdb调试从入门到进阶（一） - Xin Lee的文章 - 知乎 https://zhuanlan.zhihu.com/p/100385553
- > **二. 运行**
  * > 包含三个命令： run : 开始运行 start ： 运行并停在main函数上 continue ：继续运行 ignore ： 忽略某函数或文件 checkpoint: 设置书签

【[:star:][`*`]】 掌握gdb调试从入门到进阶（二） - Xin Lee的文章 - 知乎 https://zhuanlan.zhihu.com/p/100403438 【这个还包括了对coredump文件、以及对线程的调试】

陈皓GDB调试教程链接汇总 https://developer.aliyun.com/article/681075
- 用GDB调试程序（五） https://blog.csdn.net/haoel/article/details/2883
- 用GDB调试程序（七） https://blog.csdn.net/haoel/article/details/2885
  * > **一、修改变量值**

【[:star:][`*`]】 GDB调试：打印 https://ivanzz1001.github.io/records/post/cplusplus/2018/11/11/cpluscplus-gdbusage_part6
- > 1.打印ASCII字符串和宽字符串
  * > 用GDB调试程序时，可以使用 `x/s` 命令打印ASCII字符串。以上面程序为例：
- > 2.打印大数组中的内容
- > 3.打印数组的索引下标
- > 4.打印函数局部变量的值
  * > 如果要打印函数局部变量的值，可以使用 `bt full` 命令。首先我们在函数fun_a()中打上断点，当程序断住时，显示调用栈信息：
  * > 也可以使用如下 `bt full n`，意思是从内向外显示n个栈帧，及其局部变量，例如：
  * > 而 `bt full -n`，意思是从外向内显示n个栈桢，及其局部变量，例如：
- 设置 GDB 代码搜索路径 https://blog.csdn.net/caspiansea/article/details/42447203
  * > 在用GDB进行 debug 的时候，可以用 `directory` 设置搜索目录，用 `show direcories` 显示设置的搜索目录：
    ```console
    (gdb) show directories 
    Source directories searched: $cdir:$cwd
    (gdb) directory  /home
    Source directories searched: /home:$cdir:$cwd
    (gdb) show directories 
    Source directories searched: /home:$cdir:$cwd
    (gdb) 
    ```

gdb学习笔记 https://github.com/yifengyou/gdb

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

Buffer overflow works in gdb but not without it https://stackoverflow.com/questions/17775186/buffer-overflow-works-in-gdb-but-not-without-it
- https://stackoverflow.com/questions/17775186/buffer-overflow-works-in-gdb-but-not-without-it/17775280#17775280

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

### GDB插件

http://blog.csdn.net/gatieme/article/details/63254211

GDB实用插件(peda, gef, gdbinit)全解
https://blog.csdn.net/gatieme/article/details/63254211

存在实现了后退功能的调试器吗？这种功能在实现上有什么难点呢？ - 知乎
https://www.zhihu.com/question/57574574
> 常用 GDB 命令中文速览 - Linux中国的文章 - 知乎 http://zhuanlan.zhihu.com/p/29663631
>> reverse-next -- 反向单步跟踪，如果有函数调用，不会进入该函数

gdb Debugging Full Example (Tutorial): ncurses - ETIN的文章 - 知乎
http://zhuanlan.zhihu.com/p/28769268
> gdb 调试入门，大牛写的高质量指南 http://blog.jobbole.com/107759/

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

### 带外部符号表调试

gdb使用symbol文件调试程序 https://www.jianshu.com/p/7050a8f8841c

gdb加载调试符号（符号表) https://blog.csdn.net/weixin_45375062/article/details/115870495

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# 其他调试工具

Linux调试工具 http://blog.csdn.net/hzrandd/article/details/50849329

### VS

VS2017远程调试 
http://blog.csdn.net/dybb8999/article/details/72625062


### UndoDB

<CppCon 2015: Greg Law 'Give me 15 minutes & I'll change your view of GDB'>
https://undo.io/resources/presentations/cppcon-2015-greg-law-give-me-15-minutes-ill-change/
>来源是Liam Huang翻译的一篇文章 <GDB 入门教程：调试 ncurses 相关 bug 的完整范例 >  https://liam0205.me/2017/05/27/tutorial-to-GDB-taking-ncurses-as-an-example/
>https://undo.io/products/undodb/

### xxgdb

xxgdb - X window system interface to the gdb debugger. http://manpages.ubuntu.com/manpages/bionic/man1/xxgdb.1.html

An X front-end to the GNU debugger gdb https://packages.debian.org/sid/xxgdb
