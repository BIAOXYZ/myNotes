
# 来，把你排第一

面对舆论，方舟编译器首次公布源码分析及基础架构 https://www.infoq.cn/article/qcfC3pa21xGeWxiu5vq9

# general

## debug 和 release的区别

Debug与Release版本的区别 https://blog.51cto.com/gragel/728668 || https://developer.aliyun.com/article/6307 || https://cloud.tencent.com/developer/article/1024760 || https://www.huaweicloud.com/articles/8355815.html 【一篇文章四个网站转。。。真有你们的- -】
- > `1. Runtime Library：链接哪种运行时刻函数库通常只对程序的性能产生影响。调试版本的 Runtime Library 包含了调试信息，并采用了一些保护机制以帮助发现错误，因此性能不如发布版本。编译器提供的 Runtime Library 通常很稳定，不会造成 Release 版错误；倒是由于 Debug 的 Runtime Library 加强了对错误的检测，如堆内存分配，有时会出现 Debug 有错但 Release 正常的现象。应当指出的是，如果 Debug 有错，即使 Release 正常，程序肯定是有 Bug 的，只不过可能是 Release 版的某次运行没有表现出来而已。`
  >> //notes：起因是有同事碰到了一个现象：Release模式编的能正常运行，Debug模式编的跑起来会出coredump。

Debug模式和Release模式有什么区别？ - 知乎 https://www.zhihu.com/question/443340911
- Debug模式和Release模式有什么区别？ - 程序喵大人的回答 - 知乎 https://www.zhihu.com/question/443340911/answer/1720297063
  * > `Ofast`：更加激进的编译选项，它不会严格遵循标准，在O3的优化基础上，它又开启了一些可能导致不符合IEEE浮点数等标准的性能优化选项，如 -fast-math，-fallow-store-data-races 等。
  * > Debug模式下在内存分配上有所区别，在我们申请内存时，Debug模式会多申请一部分空间，分布在内存块的前后，用于存放调试信息。
  * > 对于未初始化的变量，Debug模式下会默认对其进行初始化，而Release模式则不会，所以就有个常见的问题，局部变量未初始化时，Debug模式和Release模式表现有所不同。
  * > Debug模式下可以使用assert，运行过程中有异常现象会及时crash，Release模式下模式下不会编译assert，遇到不期望的情况不会及时crash，稀里糊涂继续运行，到后期可能会产生奇奇怪怪的错误，不易调试，殊不知其实在很早之前就出现了问题。编译器在Debug模式下定义 **`_DEBUG`** 宏，Release模式下定义 **`NDEBUG`** 宏，预处理器就是根据对应宏来判断是否开启assert的。
  * > 数据溢出问题，在一个函数中，存在某些从未被使用的变量，且函数内存在数据溢出问题，在Debug模式下可能不会产生问题，因为不会对该变量进行优化，它在栈空间中还是占有几个字节，但是Release模式下可能会出问题，Release模式下可能会优化掉此变量，栈空间相应变小，数据溢出就会导致栈内存损坏，有可能会产生奇奇怪怪的错误。例如：

Release编译有什么特点？我的程序用Debug编译能运行但是用Release却不行，说明了什么? - 知乎 https://www.zhihu.com/question/440569610
- Release编译有什么特点？我的程序用Debug编译能运行但是用Release却不行，说明了什么? - P2Tree的回答 - 知乎 https://www.zhihu.com/question/440569610/answer/1693046512

Debug模式下不崩溃， Release模式下偶尔发生崩溃的解决思路 https://www.cnblogs.com/azbane/p/12500715.html

### 个人经验1
>> 【[:star:][`*`]】 //notes：今天碰到了一个现象：***<ins>Debug版本编译和执行都没问题；Release版本编译没问题</ins>，执行时会出 coredump，报错说 double free***。但是明明没有找到 double free 啊，不管是肉眼查还是用了 `valgrind` 去查，都没有找到。还用了 `ldd <your_prog_name>` 和 `objdump -x <your_prog_name> | grep NEEDED` 查是不是依赖库的问题，都没有发现什么端倪（当然，方法还没有用尽，还可以 `gdb` 单步调试一步一步执行下看变量和堆栈排查问题）。最后是怎么解决的呢？是偶然看到下面这个帖子里的`“规则 8”`，想到是不是有哪些小细节没注意，这些小细节在debug版本下不会出现，但是在release版本会出现。
>>> 进而想到，***那第一步应该就是保证debug版本编译告警清零，如果还有告警，可以先看看是不是debug版本的编译告警处引起的***。结果沿着这条思路一下子就发现问题了，有个返回值类型为 `int` 的函数最后没有 `return` 语句去返回一个整型值导致的。。。直接加了个 `return 0;` 就好了：debug版本告警消失了，release版本coredump没了。

Debug 运行正常，Release版本不能正常运行总结（转） https://www.cnblogs.com/chensheng-zhou/p/6732068.html
- > **规则 8**:
  * > 如果关闭Release模式的优化选项可以使您的应用程序运行正常，而打开优化选项则出现问题的化，原因多半在于您的不良编码习惯造成的. 这意味着必须仔细检查您的代码，清理出那些错误的假设，悬空指针等等. 等同的这告诉您，在Debug模式和关闭优化选项的Release模式下您的应用程序工作正常全是因为系统隐含的运气，您必须着手更正存在隐患的代码，否则在日后可能会造成巨大的损失。

## 编译器优化

[翻译]C++编译器中的优化 https://fuzhe1989.github.io/2020/01/22/optimizations-in-cpp-compilers/
- > 原文：  Optimizations in C++ Compilers - A practical journey https://queue.acm.org/detail.cfm?id=3372264

# GCC/G++

## `undefined reference to XXX`

"undefined reference to XXX"问题总结 - 船长的文章 - 知乎 https://zhuanlan.zhihu.com/p/81681440
- > Case 2, 链接顺序不对
  * > 总之在给编译器输入源文件，目标文件或者动态库静态库文件时，如果B文件依赖A文件中的内容，那么B文件应该放在A文件的**左边**。这个问题很隐蔽，而且莫名其妙，权且当个结论记住吧。
- > Case 3, 函数符号修饰不一样
  * > 先说一下符号修饰（Name Mangling），函数从源代码编译到目标文件时，函数在目标文件中的名字是会改变的（这个改变的规则是编译器厂商定的，一般会包含函数参数列表信息、name space信息等），后面在链接阶段，链接器是按照函数改变后的名字来索引函数的实现机器码，函数改变后的名字不一样的函数，在链接器看来就是不一样的函数。至于为什么要有符号修饰这个机制，能不能直接用函数名来在目标文件内表示不同函数呢？答案是，能，而且在远古时期，就是这么干的。但是随着语言各种特性的发展，渐渐地就不能这么简单粗暴了，继续这样搞很容易造成符号冲突，而符号修饰在函数名上加上了名字空间信息和参数列表等信息，就可以允许不同名字空间里面的同名函数不冲突，允许函数重载机制。
  * > 3.1 函数定义和声明不一致
  * > 3.2 C和C++混合编程
    + > 先用gcc编译C文件`baz.c`得到目标文件`baz.o`，然后用g++编译C++文件`main.cpp`和`baz.o`，就出现了错误：
    + > 解决方案，加上`extern "C"`，就可以了：
- > 杂项
  * > 怎么查看动态库文件里面提供了哪些函数符号？
    + > 首先，我们把bar.cpp文件编译成动态库`bar.so`文件，这个文件提供了函数`void bar(int)`的实现
    + > 要查看`bar.so`这个库里面提供了哪些函数符号，可以用`nm`命令
    + > 这里我们可以看到，在`bar.so`文件的代码段（.Text段），有函数`_Z3bari`的定义。这个`_Z3bari`就是`bar(int)`这个函数在名字修饰后在库文件中的名字，链接器就是看这个名字来进行链接活动。`nm -C`可以查看函数名字修饰之前的名字，大家可以试试看。
  * > 知道了函数修饰后的名字，怎么推函数声明？
    + > 那么，如果我们知道了某个库里面的函数修饰后的名字，有没有什么方法可以反推函数源文件中的声明呢？用`c++filt`这个命令就可以。还是以上文中`_Z3bari`为例：
    + > 可以看到，`_Z3bari`这个符号是`bar(int)`这个函数修饰而成。可能有人会问，为什么不是`void bar(int)`，是不是由于是void型的返回值，所以略去了？这里要注意，***函数修饰不会管函数的返回值是什么***。函数的返回值不同，而函数名和参数列表一样，经过函数修饰产生的符号是一样的，***这也为什么C++规定，函数只有返回值不一样的话，是不能算重载的原因***。
  * > 题外话，有时候我们不愿意让别人看到我们发布的库文件的符号表（泄露内部实现信息），我们也可以将符号信息从库文件中删除（`strip`命令，还有`-fvisibility=hidden`)。
- > 总结
  * > 以上差不多就是"undefined reference to XXX"的这个问题的常见原因和解决方案了，总结起来就是三点：1.是不是编译器找不到定义了XXX的文件；2.是不是定义了XXX的文件，由于函数修饰的原因里面没有想要的XXX符号; 3.找到了想要的符号，但是该符号是隐藏属性，不能链接使用。如果不确定库里面有没有这个XXX符号，用`nm`找，用`c++filt`可以从修饰后的符号找函数声明。

## `multiple definition of xxxx`

【[:star:][`*`]】 multiple definition of `xxxx`问题解决及其原理 https://blog.csdn.net/mantis_1984/article/details/53571758
- > 一般在.h文件中定义一个变量声明时，在其他文件中只要包含了这个.h文件，编译的时候就会独立被编译器解释，然后每个.C文件会生成独立的标识符和符号表，所以上述代码在单独编译的时候并不会报错，语法是合法的。但是，最后在编译器链接的时候，就会将工程中所有的符号整合在一起，由于文件中有重复的变量，于是就会出现重复定义的错误,系统就是提示你“multiple definition of `xxx`”。
- > 进一步解释，我们可以这样想象编译每一个C源文件时，相当于一条有管道包围的纵向水流，二者互不干扰。当链接时两条原本相互独立的水管横向流了，所有就出现了重复的元素。所以当进行链接时就会出现重复定义的标示符。重复定义的标示符在这里只是变量，函数不会。因为函数确实只在.c中定义了一次，多次声明是没有问题的，而变量确实出现了两次定义。两次重复的变量定义链接器就不知道该已那个地址作为变量的内存，所以报错。
- > 怎么解决这个问题呢?
  >
  > ***<ins>其实只需要将全局变量定义从.h文件中挪到.c文件里，然后在.h文件中用extern做外部声明即可</ins>***。即在.c文件中声明变量，然后在头文件.h所有的变量声明前加上extern，注意在.h文件中就不要对变量进行初始化赋值了。然后其他需要使用全局变量的.c文件中包含.h文件即可。编译器会为.c生成目标文件，然后链接时，如果该.c文件使用了全局变量，链接器就会链接到此.c文件。其他文件需要使用此全局变量也是同样的方式，目的其实只有一个，就是使变量在内存中唯一化。

gcc: multiple definition of [转] https://www.cnblogs.com/longdouhzt/archive/2012/07/03/2574071.html

C++ multiple definition 总结 https://www.jianshu.com/p/c028fee0f202

## 参数

15 Most Frequently Used GCC Compiler Command Line Options https://www.thegeekstuff.com/2012/10/gcc-compiler-options/
- > 8.Create position independent code using `-fPIC` option

## 动态库和静态库

为什么不能在动态库里静态链接？ https://liam.page/2017/04/03/not-to-link-libstdc-statically-and-why/

g++链接动态库和静态库问题 https://www.jianshu.com/p/fdd516337c76

C++静态库与动态库 https://www.runoob.com/w3cnote/cpp-static-library-and-dynamic-library.html

在Linux下，如何强制让GCC静态链接？ - qin meng的回答 - 知乎 https://www.zhihu.com/question/22940048/answer/222625910
- > gcc使用-Wl传递连接器参数，ld使用-Bdynamic强制连接动态库，-Bstatic强制连接静态库。所以部分静态，部分动态连接这么写： `gcc ... -Wl,-Bstatic -l<your-static-lib> -Wl,-Bdynamic -l<your-dynamic-lib> ...`
- > 举个例子，你想静态连接libA.a同时动态连接libB.so，(先保证你的连接路径-L里面能找到对应的静态或者动态库)，这么写： `gcc ... -Wl,-Bstatic -lA -Wl,-Bdynamic -lB ...`

## header 和 lib

What's the difference between a header file and a library? https://stackoverflow.com/questions/924485/whats-the-difference-between-a-header-file-and-a-library

What are Header Files and Library Files? [duplicate] https://stackoverflow.com/questions/6407975/what-are-header-files-and-library-files

include directories vs. lib directory concept question https://stackoverflow.com/questions/5022374/include-directories-vs-lib-directory-concept-question
- https://stackoverflow.com/questions/5022374/include-directories-vs-lib-directory-concept-question/5023086#5023086

C++ : Difference between linking library and adding include directories https://stackoverflow.com/questions/7096152/c-difference-between-linking-library-and-adding-include-directories

### header only

Header-only https://en.wikipedia.org/wiki/Header-only
- > In the context of the C or C++ programming languages, a library is called **header-only** if the full definitions of all macros, functions and classes comprising the library are visible to the compiler in a header file form. ***Header-only libraries do not need to be separately compiled, packaged and installed in order to be used***. All that is required is to point the compiler at the location of the headers, and then `#include` the header files into the application source. Another advantage is that the compiler's optimizer can do a much better job when all the library's source code is available.
- > The disadvantages include:
  * > brittleness – most changes to the library will require recompilation of all compilation units using that library
  * > longer compilation times – the compilation unit must see the implementation of all components in the included files, rather than just their interfaces
- > ***For C++ templates, including the definitions in header is the only way to compile***, since the compiler needs to know the full definition of the templates in order to instantiate.

Benefits of header-only libraries https://stackoverflow.com/questions/12671383/benefits-of-header-only-libraries

### 只使用lib，不使用header
>> 【[:star:][`*`]】 //notes：对于普通的库，我们在 `cmake` 或 `gcc/g++` 中使用时需要做到三点：1.根据库的名字用 `-l` 链接这个库；2.如果库文件（`.so` 或 `.a`）不在默认的库文件搜索目录里，需要用 `-L` 添加进去；3.用 `-I` 去 include 相应的头文件。
>>> 而像 `Eigen`、`pybind11` 等著名的库都是 header only 的，那么使用这些库的时候不需要去链接，只需要 include 相应的头文件即可。
>>>> 那么很自然的一个问题：是否存在只需要链接库，但是不用 include 头文件的情况呢？搜一下发现也是存在的。

Linking library without a header file? https://stackoverflow.com/questions/11852329/linking-library-without-a-header-file

DUMPBIN Reference https://docs.microsoft.com/en-us/cpp/build/reference/dumpbin-reference

C/C++ Extern and Use of Library Without Header http://www.l3oc.com/2015/06/cc-extern-and-use-of-library-without.html

Call function in c++ dll without header https://stackoverflow.com/questions/554551/call-function-in-c-dll-without-header

In C, can we run a program without header files? https://www.quora.com/In-C-can-we-run-a-program-without-header-files

## GCC版本升级

CentOS 7 升级gcc/g++编译器 https://www.cnblogs.com/ToBeExpert/p/10297697.html

CentOS 下安装高版本 GCC https://www.hi-linux.com/posts/25767.html

CentOS7 升级gcc版本 https://www.cnblogs.com/Hi-blog/p/How-To-Update-Gcc-On-CentOS7.html
> 在一些使用场景下需要高版本的GCC编译器，网上有介绍的下载源码编译，但个人在编译的时候老是会出一些问题，而且编译过程较为冗长，现简单copy stackoverflow上的回答。
>> How to Install gcc 5.3 with yum on CentOS 7.2? https://stackoverflow.com/questions/36327805/how-to-install-gcc-5-3-with-yum-on-centos-7-2
```sh
sudo yum install centos-release-scl
sudo yum install devtoolset-7-gcc*
scl enable devtoolset-7 bash
which gcc
gcc --version
```

***个人实战（就是加了`-y`）***：
```sh
[root@temptest ~]# yum install centos-release-scl -y
//输出省略
[root@temptest ~]# yum install devtoolset-7-gcc* -y
//输出省略


[root@temptest ~]# gcc --version
gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[root@temptest sci]# which gcc
/usr/bin/gcc
[root@temptest ~]# scl enable devtoolset-7 bash
[root@temptest ~]#
[root@temptest ~]# gcc --version
gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[root@temptest sci]# which gcc
/opt/rh/devtoolset-7/root/usr/bin/gcc
```

# gcc/g++错误处理

### `libstdc++.so.6: error adding symbols: DSO missing from command line`

```sh
$ gcc hdfsclass.cpp -I/usr/local/hadoop/include -L/usr/local/hadoop/lib/native -lhdfs -o hdfsclass
/usr/bin/ld: /tmp/ccaQjUxW.o: undefined reference to symbol '_ZTVN10__cxxabiv117__class_type_infoE@@CXXABI_1.3'
//usr/lib/x86_64-linux-gnu/libstdc++.so.6: error adding symbols: DSO missing from command line
$

# 错误原因就是：因为是cpp代码，所以换了g++就直接编过了。。。
$ g++ hdfsclass.cpp -I/usr/local/hadoop/include -L/usr/local/hadoop/lib/native -lhdfs -o hdfsclass
$
```

- libstdc++: DSO missing from command line https://stackoverflow.com/questions/33263288/libstdc-dso-missing-from-command-line
- gcc 错误 //usr/lib/x86_64-linux-gnu/libstdc++.so.6 ... https://www.cnblogs.com/Hocker/p/8242155.html
- ubuntu16.04 Qt调试caffe代码 - 高知的文章 - 知乎 https://zhuanlan.zhihu.com/p/38077007

### `error: call of overloaded ‘abs(double&)’ is ambiguous`

g++编译时abs()遇到无法理解的问题(已解决) https://blog.csdn.net/zsc2014030403015/article/details/44724391

## GCC新闻

2020年，GCC项目代码终于从SVN完全切换至Git https://www.ithome.com/0/468/228.htm

# LLVM

# Zapcc [https://github.com/yrnkrn/zapcc]

缓存型C++编译器Zapcc开源 号称比Clang更快 - Open Source 开源 - cnBeta.COM
https://www.cnbeta.com/articles/soft/737459.htm
