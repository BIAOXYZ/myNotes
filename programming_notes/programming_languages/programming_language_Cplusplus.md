
# official

Slides and other materials from CppCon 2018 https://github.com/CppCon/CppCon2018

# 基本教程

C++教程 -- 易百教程 https://www.yiibai.com/cplusplus/

C++教程 -- 菜鸟教程 http://www.runoob.com/cplusplus/cpp-tutorial.html

C++ Tutorial https://www.tutorialspoint.com/cplusplus/index.htm
- C++ STL Tutorial https://www.tutorialspoint.com/cplusplus/cpp_stl_tutorial.htm

C++在线教程 http://www.gitbook.net/cplusplus/index.html

鱼C工作室 https://ilovefishc.com/
- 【C++语法】《C++快速入门》（小甲鱼） https://www.bilibili.com/video/av28127959/

C++基础教程-多线程 http://wiki.jikexueyuan.com/project/cplusplus/multithreading.html

## C++优秀博客

### L_XRUI的博客
- 多态概念总结
https://blog.csdn.net/l_xrui/article/details/52965676
- 继承与多态虚函数分析
https://blog.csdn.net/l_xrui/article/details/62238442
- C语言实现继承与多态
https://blog.csdn.net/L_XRUI/article/details/70231250

### skynet

- C++静态库与动态库
http://www.cnblogs.com/skynet/p/3372855.html
> C++对象模型 http://www.cnblogs.com/skynet/p/3343726.html
> C/C++ Memory Layout http://www.cnblogs.com/skynet/archive/2011/03/07/1975479.html
> {PS:这个叫skynet博主的博文那图真是详细！}
>> 介绍linux/windows OS下静态库（.a、.lib）和动态库（.so、.dll）的 link & load http://www.cnblogs.com/scotth/p/3977928.html
- C/C++内存泄漏及检测 http://www.cnblogs.com/skynet/archive/2011/02/20/1959162.html


你可能不知道的 C++（一）
https://segmentfault.com/a/1190000004301563


# 语法知识

## 重载重写重定义多态等等

C++重载、重写、重定义区别
http://glgjing.github.io/blog/2014/12/27/c-plus-plus-zhong-zai-,-zhong-xie-,-zhong-ding-yi-qu-bie/

C++的函数重载
https://www.cnblogs.com/skynet/archive/2010/09/05/1818636.html


C++重写（覆盖）、重载、重定义、多态
https://www.cnblogs.com/DannyShi/p/4593735.html
> C++局部变量、全局变量、静态变量（堆、栈、静态存储区） http://www.cnblogs.com/DannyShi/p/4584750.html

## 继承相关

关于C++中的友元函数的总结
http://www.cnblogs.com/BeyondAnyTime/archive/2012/06/04/2535305.html

C++中实现代码重用的手段----继承和聚合
http://blog.csdn.net/lyxaiclr/article/details/7402838

<<C++构造函数与析构函数的解析>>
http://blog.csdn.net/u011392772/article/details/42772697
```
int main( )
{
   Student stud1(10010,"Wang_li",'f'); //建立对象stud1
   stud1.display( ); //输出学生1的数据
   Student stud2(10011,"Zhang_fun",'m'); //定义对象stud2
   stud2.display( ); //输出学生2的数据
   return 0;
}

Destructor called. The num is 10011.    (执行stud2的析构函数)
Destructor called. The num is 10010.    (执行stud1的析构函数)

————为啥 return 0; 以后是先调用stud2的析构函数？猜测是因为栈的关系。也就是stud2定义在stud1后，所以在栈中比stud1更靠上。
栈是后进先出原则，所以先调用stud2？
```

- c++虚函数的作用是什么？ - 郭无心的回答 - 知乎
https://www.zhihu.com/question/23971699/answer/69592611
> https://my.csdn.net/Hackbuteer1 (这个地址里好多面试题目)
- c++虚函数的作用是什么？ - afraid的回答 - 知乎
https://www.zhihu.com/question/23971699/answer/84337233
> C++ 对象的内存布局 https://coolshell.cn/articles/12176.html

类可以没有构造函数和析构函数吗 https://www.jianshu.com/p/638aebc8175b
- > 即使程序没定义任何成员，编译器也会插入以上的函数，也就是说当用户没有定义构造函数和析构函数时编译器会自动添加默认的构造函数和析构函数。但是某些情况下，由于成员的特殊性，需要自己进行构造函数与析构函数的编写。
- > **构造函数基础**
  * > 一句话记住三者：对象不存在，且没用别的对象来初始化，就是调用了构造函数；对象不存在，且用别的对象来初始化，就是拷贝构造函数（上面说了三种用它的情况！） 对象存在，用别的对象来给它赋值，就是赋值函数。
- > **需要自己写构造函数的情况**
  * > **倘若类中含有指针变量，则需要自己写构造函数**。不能仅仅使用默认的构造函数。因为“缺省的拷贝构造函数”和“缺省的赋值函数”均采用浅拷贝而非“深拷贝”的方式来实现。
- > **需要自己写析构函数的情况**
  * > **倘若类中有通过 `malloc` 或 `new` 动态分配的资源，则需要重写析构函数**
  * > 如果一个类没有定义析构函数，那么编译器会为其提供一个缺省析构函数,功能如下：
    + > 对基本类型的成员变量，什么也不做
    + > 对类类型的成员变量和基类子对象，调用相应类型的析构函数
  * > 这是因为缺省析构函数由编译器提供，它只负责释放编译器看得到资源，如成员子对象、基类子对象等。对于编译器看不到的资源，如通过malloc或new动态分配的资源，缺省析构函数不负责释放，必须通过自己定义的析构函数予以释放，否则将形成内存泄漏

### 拷贝构造函数/深拷贝浅拷贝

C++构造函数详解（复制构造函数） https://www.cnblogs.com/raichen/p/4752025.html

c++拷贝构造函数详解 https://www.cnblogs.com/alantu2018/p/8459250.html

### 模板

C++ 模板 - 菜鸟教程 http://www.runoob.com/cplusplus/cpp-templates.html

## 其他语法

C++项目中的extern "C" {}
http://www.cnblogs.com/skynet/archive/2010/07/10/1774964.html

How can I profile C++ code running in Linux?
https://stackoverflow.com/questions/375913/how-can-i-profile-c-code-running-in-linux

ofstream和ifstream详细用法
https://blog.csdn.net/Augusdi/article/details/8865378

C++委员会决定在C++20 中弃用原始指针
https://www.cnbeta.com/articles/soft/712627.htm

介绍一个C++奇巧淫技 - CSDN博客
https://blog.csdn.net/maray/article/details/11096459

# 实战过程

<<linux环境下编译C++ 程序 -- 易百教程>>
https://www.yiibai.com/cplusplus/cpp-linux-gnu-compiler-collection.html
```
多个源文件生成可执行程序
如果多于一个的源码文件在 g++ 命令中指定，它们都将被编译并被链接成一个单一的可执行文件。
下面是一个名为 speak.h 的头文件；它包含一个仅含有一个函数的类的定义：

/* speak.h */
#include <iostream>
class Speak
{
    public:
        void sayHello(const char *);
};

下面列出的是文件 speak.cpp 的内容：包含 sayHello()函数的函数体：

/* speak.cpp */
#include "speak.h"
void Speak::sayHello(const char *str)
{
    std::cout << "Hello " << str << "\n";
}

文件hellospeak.cpp内是一个使用 Speak 类的程序：

/* hellospeak.cpp */
#include "speak.h"
int main(int argc,char *argv[])
{
    Speak speak;
    speak.sayHello("world");
    return(0);
}

下面这条命令将上述两个源码文件编译链接成一个单一的可执行程序：

$ g++ hellospeak.cpp speak.cpp -o hellospeak

提示： 这里说一下为什么在命令中没有提到“speak.h“文件(原因是：在“speak.cpp“中包含有”#include"speak.h““这句代码，
它的意思是搜索系统头文件目录之前将先在当前目录中搜索文件“speak.h“。而”speak.h“正在该目录中，不用再在命令中指定了)。
```
***但是实际发现加了 speak.h 再编译也是一样的***
```
liuliang3@SZX1000126633:~/codetest/multiple_file_complie> ll
total 12
-rw-r--r-- 1 liuliang3 users 137 Mar 16 10:29 hellospeak.cpp
-rw-r--r-- 1 liuliang3 users 119 Mar 16 10:23 speak.cpp
-rw-r--r-- 1 liuliang3 users 100 Mar 16 10:23 speak.h
liuliang3@SZX1000126633:~/codetest/multiple_file_complie> g++ hellospeak.cpp speak.cpp -o hellospeak
liuliang3@SZX1000126633:~/codetest/multiple_file_complie> g++ hellospeak.cpp speak.cpp speak.h -o hellospeak2
liuliang3@SZX1000126633:~/codetest/multiple_file_complie> ll
total 44
-rwxr-xr-x 1 liuliang3 users 12601 Mar 16 10:43 hellospeak
-rwxr-xr-x 1 liuliang3 users 12601 Mar 16 10:43 hellospeak2
-rw-r--r-- 1 liuliang3 users   137 Mar 16 10:29 hellospeak.cpp
-rw-r--r-- 1 liuliang3 users   119 Mar 16 10:23 speak.cpp
-rw-r--r-- 1 liuliang3 users   100 Mar 16 10:23 speak.h
liuliang3@SZX1000126633:~/codetest/multiple_file_complie> ./hellospeak
Hello world
liuliang3@SZX1000126633:~/codetest/multiple_file_complie> ./hellospeak2
Hello world
liuliang3@SZX1000126633:~/codetest/multiple_file_complie> diff hellospeak hellospeak2
liuliang3@SZX1000126633:~/codetest/multiple_file_complie>
```
***偶然间又发现换了文件顺序也能编译成功。。。回头还得再仔细研究下***
```
liuliang3@SZX1000126633:~/codetest/multiple_file_complie> ll
total 12
-rw-r--r-- 1 liuliang3 users 137 Mar 16 10:29 hellospeak.cpp
-rw-r--r-- 1 liuliang3 users 119 Mar 16 10:23 speak.cpp
-rw-r--r-- 1 liuliang3 users 100 Mar 16 10:23 speak.h
liuliang3@SZX1000126633:~/codetest/multiple_file_complie> g++ speak.cpp hellospeak.cpp -o hellospeak3
liuliang3@SZX1000126633:~/codetest/multiple_file_complie> ll
total 28
-rwxr-xr-x 1 liuliang3 users 12601 Mar 16 10:56 hellospeak3
-rw-r--r-- 1 liuliang3 users   137 Mar 16 10:29 hellospeak.cpp
-rw-r--r-- 1 liuliang3 users   119 Mar 16 10:23 speak.cpp
-rw-r--r-- 1 liuliang3 users   100 Mar 16 10:23 speak.h
liuliang3@SZX1000126633:~/codetest/multiple_file_complie> ./hellospeak3
Hello world
```
