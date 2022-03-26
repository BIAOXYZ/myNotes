
【[:star:][`*`]】 C++ 利用条件编译来避免重复引用为什么需要手写？编译器不能自动做这件事情吗？ https://www.v2ex.com/t/842838
- > 说一个会的人都知道但没学过可能无法想象的事：c++的编译器只会处理「一个文件」，include 的作用是把所有<>里的文件全都拼在一起。字面意思，拼在一起。include 两次就拼两次。
- > 微软干过这种事情.发明了 `#progma once` <br> 后来人们发现头文件是个憨批设定，严重影响了编译速度。已经在 C++20 里开始推进 module 了。
- > 重复引用会冲突。但是自动过滤重复引用以后又等于是扼杀了故意多次引用文件的能力。所以你只能每次老老实实写上 `#pragma once` 来告诉编译器你不想重复引用。
  >> 为啥会需要引用两次？引用一次后不就可以编译了吗？
  >>> "为啥会需要引用两次" -- 你先再看一眼 1L ，然后看这个 https://onlinegdb.com/b4qgRG-ZS 哎，你别说以前可能还真有人认为会有需要 include 两次的地方
  ```cpp
  #include <iostream>
  #include <cstdio>
  using namespace std;
  int main()
  {
      cout<<"Hello World";
      if(1) { 
          #include "print.hh" 
      }
      #include "print.hh"
      #include "half-L"
      "\nfoo of %s","you"
      #include "half-R"
      return 0;
  }
  ```
- > 你说得很好，不要再说了，再说就要请你去写 C++编译器了。因为 C++的编译器继承 C 编译器的特点，可以独立编译文件，这样每一个文件就是一个编译单元，可以分布式编译。编译的时候，编译器是不知道一个符号在全局中有没有被编译的。能知道全局符号信息的那个叫连接器。所以人们为了避免重复编译，所以就在头文件写宏，防止多次编译（不是多次 include ）。
因为只要编译了，连接器就能在连接的过程中找到对应的符号的实现。
- > 你说对了，源码长度就是很长，而且还很复杂。
  * > 纯 C 语言的头文件一般只有声明所以速度相对快，但是 C++ 不同。为了追求 zero-cost abstraction ，C++ 的很多东西声明和定义全部都在头文件里面，而且模板 meta-programming 对于编译器是复杂的东西。这样叠加上去就，超级慢。一个 C++ 源代码文件 include 展开以后有几百上千 KB ，几百上千个 template class ，我觉得毫不意外。每个源文件都给你来这一套，想想多复杂。
  * > C++20 的 module 就是规定，一些头文件不受其他头文件 macro 的影响。这样你就能预编译这些头文件，就不会有那么多重新编译的开销了。
  * > 在 C++20 module 前，业界最佳的实践是 Qt ，大量使用 private class + pointer ，尽量避免使用 template ，达到了很好的编译速度。然而，由于使用这两个技术，所以毕竟不是 zero-cost abstraction ，因此在运行速度上是打折了的。当然比起 node.js 还是秒杀。
  * > 最后简要介绍 zero-cost abstraction 。这东西看一个例子：
    + > C 语言的库函数 qsort 要传入一个函数指针。
    + > C++ 的库函数 std::sort 传入的是模板函数。
  * > 函数指针是不能内联优化的，因此每两个元素比较都不得不进行一次函数调用，有固有性能损失。
  * > 模板函数是可以内联优化的，相当于消除了这一次函数调用。更何况消除以后 C++ 可以进一步做指令集优化。
  * > 所以 C 语言 qsort 比 C++ 慢。
- > 引用两次的情况存在啊 见过一些代码，define 个东西，include 一个文件，然后 define 另一个东西，再一次 include ，这样就能包含进来不一样的东西了
- > 多次 include 是有意义的（ c 里用的比较多），可以起到类似代码生成的作用 <br> 你可以在某个文件里放一堆类似 GEN(a, int, "some text")的“语句”，然后在不同的地方 include 的时候定义 GEN 宏展开成不同的东西（比如一边展开成 enum ，另一边展开成 switch case ，就可以实现 enum 值打印） <br> C++显然没必要打破这种兼容性，自然就保留下来了
- > 头文件在设计的时候就是做成像复制粘贴一样引入源码文件里的。比如你头文件里写一个 printf 语句，然后在函数里每次#include 这个头文件就相当于把这个 printf 语句复制粘贴到代码里一样，你引用 3 次就等于复制粘贴了 3 次语句进来。因为头文件本来实现的就是复制粘贴功能，所以很难直接处理语言本身的含义。简单来说就是 Ctrl-V 这个功能为什么要的管你 Ctrl-V 了几次呢。
  * > 再举一个现实中会用到的例子。比如你写了一个头文件，封装在一个命名空间里，然后把命名空间做成宏。那么你就可以用类似：
    ```cpp
    #define NS ns1
    #include <code.h>
    #undef NS
    #define NS ns2
    #include <code.h>
    #undef NS
    ```
  * > 这样前后生成两个不同命名空间的两套代码。
  * > x265 就是用类似的方法把 8bit 10bit 12bit 的编码器分别装在三个命名空间里然后链接在一起的。

一段源码， Visual Studio 2019 上编译不成功， Linux 上可以 https://www.v2ex.com/t/758288
- > gcc 肯定是报 warning 了，编译成功不代表运行不 core
- > 因为你没加 `-Wall -Wextra -Werror`，加了 gcc 就也会拒绝编译了
- > 第一个问题是指针变量未初始化就使用。 <br> 第二个问题是 unsigned long 在不同平台上长度不一致，建议改成 strtoull 。
- > 用 gcc/clang 编译的时候，加参数 `-Wall -Wextra -Wpedantic` 是基操，加上以后可以看到如下警告：warning: variable 'str' is uninitialized when used here [-Wuninitialized]
- > 局部变量没有初始化的话初值不一定为 0，指针好像也是这样的，所以 char*还是习惯初始化为 NULL 或者 malloc 。 <br> 如果需求定长 64 位的 int 类型，应该用 stdint.h 标头里的 uint64_t，在 printf/scanf 中用 inttypes.h 标头里的宏 PRIu64/SCNu64，如果是地址应该用 intptr_t/PRIiPTR/SCNiPTR。

一个 msvc 与 gcc/clang 不一致的例子，哪边是对的？ https://www.v2ex.com/t/729105

求问 gcc9 中-O1 比-O0 多了哪些优化选项？ https://www.v2ex.com/t/722402

不懂就问：其他电脑编译好的二进制文件可以直接到其他机器使用吗？ https://www.v2ex.com/t/720696
