
非 CS, 想弄弄编译, 还啃龙书吗? https://www.v2ex.com/t/883710
- > 我当前学习的路线供参考
  ```console
  一
  - Computer Systems: A Programmer's Perspective
  - Crafting Interpreters （替代 自己动手实现 Lua 虚拟机、编译器和标准库）
  - 程序员的自我修养：链接、装载与库（替代 上面的 CSAPP ）

  二
  - 清华大学的《数据结构（ C++ 语言版）》邓俊辉（看了一部分，很棒！）学习中

  三
  - **南京大学 软件分析 [**https://tai-e.pascal-lab.net/**](https://tai-e.pascal-lab.net/) 国内顶级的静态分析课程，最近看完了所有的视频，也完成了 OJ 作业，非常棒的课程**
  - Compilers: Principles, Techniques, and Tools （以下几章可以算是上面的软件分析的下一步学习的扩展）
  - 6.2 Three-Address Code
  - 8 Code Generation
  - 9 Machine-Independent Optimizations
  - 12 Interprocedural Analysis （还没开始看）计划待看
  - CS 6120: Advanced Compilers γ https://www.cs.cornell.edu/courses/cs6120/2020fa/ 看了一半搁置了

  四
  - **LLVM Techniques, Tips, and Best Practices Clang and Middle-End Libraries 上手 LLVM 前一定要看**
  - https://github.com/banach-space/llvm-tutor ​学习中
  - Learn LLVM 12: A Beginner's Guide to Learning LLVM Compiler Tools and Core Libraries With C++

  其他参考
  - [编译高级教程｜学习笔记]( https://leiblog.wang/%E7%BC%96%E8%AF%91%E9%AB%98%E7%BA%A7%E6%95%99%E7%A8%8B%EF%BD%9C%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0/)
  - [2019 EuroLLVM Developers’ Meeting: V. Bridgers & F. Piovezan “LLVM IR Tutorial - Phis, GEPs ...”](https://www.youtube.com/watch?v=m8G_S5LwlTo)
  - [Creating the Bolt Complier 系列]( https://mukulrathi.com/create-your-own-programming-language/intro-to-compiler/)
  ```
- > 我推荐一下哈工大姜守旭老师的编译原理视频课程吧，思路清晰，这门课靠他的讲述拿了个不错的分
- > 推荐 https://book.douban.com/review/13617730/ 已经有中文版。
- > 看 crafting interpreter 就够了 还有龙书太重 parse 了 你不搞学术的话 搞懂 recursive decent 就行了 后面可能也是用 antlr 之类的多
- > 看了 OP 13 楼的进一步说明，那就 https://craftinginterpreters.com/
- > 啃龙书没啥意义。
  * > 如果你想整体了解编译，不要在 parser 上浪费时间，parser 是一个非常“符合直觉”的事情，本质上就是如何把一段文本变成结构化的数据，所以不要被各种名词唬住，自己写一个简单的表达式解析器，就能大概明白了。同时 parser 在整个编译过程中只占了很小的一部分，基本没啥值得关注的东西。
  * > 编译整体看是一个不断 lower （ desuger ）的过程，用简单代替复杂，具体代替抽象。所以整体看的话，你需要大概了解一下体系结构和指令集，也就是编译的终点是什么样的。中间的过程不管是 AST 也好，IR 也好，no-target machine code 还是 target machine code ，从认知上来讲，都不是必须的（你完全可以设计一个非常简单的表达式语言，然后直接翻译成汇编指令），这些步骤只是为了满足某种需求（ native code or Interpreter ？ JIT or AOT ？ interprocedural or intraprocedural ？）而增加的、便于使用的中间层。
  * > 明确输入（语言、特性、功能）和输出（目标指令集），剩下的就是取舍和拼接。现在编译体系复杂之处在于为了某些目标（性能、功能、复杂的语言特性）而在不同层次间不得不产生耦合，使用某些约定（而不是设计）。当这种情况越多，原本清晰的结构就会变成一坨。。。

【[:star:][`*`]】 C++ 利用条件编译来避免重复引用为什么需要手写？编译器不能自动做这件事情吗？ https://www.v2ex.com/t/842838
- > 说一个会的人都知道但没学过可能无法想象的事：c++的编译器只会处理「一个文件」，include 的作用是把所有<>里的文件全都拼在一起。字面意思，拼在一起。include 两次就拼两次。
- > 微软干过这种事情.发明了 `#progma once` <br> 后来人们发现头文件是个憨批设定，严重影响了编译速度。已经在 C++20 里开始推进 module 了。
- > 重复引用会冲突。但是自动过滤重复引用以后又等于是扼杀了故意多次引用文件的能力。所以你只能每次老老实实写上 `#pragma once` 来告诉编译器你不想重复引用。
  >> 为啥会需要引用两次？引用一次后不就可以编译了吗？
  >>> "为啥会需要引用两次" -- 你先再看一眼 1L ，然后看这个 https://onlinegdb.com/b4qgRG-ZS 哎，你别说以前可能还真有人认为会有需要 include 两次的地方
    * > `main.cpp`，`print.hh`，`half-L`，`half-R`
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
      ```cpp
      #include <cstdio>
      fputs("Ha",stdout); 
      ```
      ```cpp
      printf(
      ```
      ```cpp
      );
      ```
      ```console
      Hello WorldHaHa
      foo of you
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
