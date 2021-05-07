
# 来，把你排第一

面对舆论，方舟编译器首次公布源码分析及基础架构 https://www.infoq.cn/article/qcfC3pa21xGeWxiu5vq9

# GCC/G++

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
