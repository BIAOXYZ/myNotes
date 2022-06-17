
哪位大兄弟给推荐一个简单，无版权风险的 C/C++ log 库？万分感谢 https://www.v2ex.com/t/860294
- > `spdlog` 吧，性能好，接口易用，许可是 mit 协议的

闲来无聊，修改纯 C 实现一个 http server https://www.v2ex.com/t/857246

怎么通过 VS2019 看 strlen()的源码？ https://www.v2ex.com/t/825671
- > msvc 的源码是没有公开的。MS 开源了 STL 的部分 https://github.com/microsoft/STL 。`strlen` 的实现比较简单，类似下面这样。你可以参考 `wine` 项目的一些 api 实现。
  ```c
  size_t __cdecl strlen( const char *str )
  {
  const char *s = str;
  while (*s) s++;
  return s - str;
  }
  ```
- > 其实 `strlen` 各家的实现可能都有差别，而且可能会有魔法优化。。。。这种基础库函数反而不容易读代码。比如 `gcc` 的 `strlen`： https://github.com/lattera/glibc/blob/master/string/strlen.c#L33 <br> 你看这个实现，`/* Instead of the traditional loop which tests each character, we will test a longword at a time. The tricky part is testing if *any of the four* bytes in the longword in question are zero. */`
- > 稍微查了查，至少对 vs2008 而言，`strlen` 是直接用汇编写的，不是 C 代码 <br> `First CRT's one is written directly in assembler. you can see it's source code here C:\Program Files\Microsoft Visual Studio 9.0\VC\crt\src\intel\strlen.asm (this is for VS 2008)`

c 语言条件编译宏太多, 有什么办法解决吗 https://www.v2ex.com/t/810041
```console
嵌入式代码需要兼容的版本太多了, 同一个函数里面条件宏比代码逻辑还多了, 然后用 vscode 看代码头都大了, 大家有什么办法解决一下吗?
```
- > 你可以直接看预处理的输出结果，不过头文件不多还行，不然头文件展开以后就是一大坨，更不好看。
- > `gcc -E x.c > dumped.c`
- > 有个玩意叫 unifdef ，听说 linux 内核开发者都在用🐶

今天用学习用 C 实现队列结构时，编译执行阶段出现非常邪乎的问题 https://www.v2ex.com/t/792765

跨越 7 年的 long long ago https://www.v2ex.com/t/783998
```console
大概 2013 年前后看 C Primer Plus 的时候，出于对 printf 函数原理的理解，写下了下面的代码(ago 变成了 verybig)

#include <stdio.h>
int main(void)
{
    long long verybig = 12345678908642;
    printf("%ld %ld", verybig, verybig);
    return 0;
}

7 年前的输出：
1942899938 2874

7 年后的今天的输出（ gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) ）：
$ gcc test2.c -o test -g && ./test                                      
test2.c: In function ‘main’:
test2.c:5:15: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘long long int’ [-Wformat=]
     printf("%ld %ld", verybig, verybig);
             ~~^
             %lld
test2.c:5:19: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 3 has type ‘long long int’ [-Wformat=]
     printf("%ld %ld", verybig, verybig);
                 ~~^
                 %lld
12345678908642 12345678908642%  

我已记不清 7 年前用的是什么编译器了，C Primer Plus 书中写的 printf 从右至左压栈却依稀可见~
7 年后的解释可以参见： https://blog.iret.xyz/article.aspx/printf_magic_float
难不成 7 年前 printf 是把所有参数都压栈，7 年后是整型和浮点型存寄存器，其他压栈？
```
- > 你说的部分是对的，但关键点不对。这个就是 32 位和 64 位的区别，可能你之前是 32 位机器，现在是 64 位。验证方法很简单，你加参数 `-m32` 重新编一下，结果应该就和你之前一样了。
  >> 老哥厉害，果然如你所说，第一次真切感受到 32 位和 64 位的区别
    ```sh
    $ gcc -m32 test2.c -o test -g && ./test
    test2.c: In function ‘main’:
    test2.c:5:15: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘long long int’ [-Wformat=]
    printf("%ld %ld", verybig, verybig);
    ~~^
    %lld
    test2.c:5:19: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 3 has type ‘long long int’ [-Wformat=]
    printf("%ld %ld", verybig, verybig);
    ~~^
    %lld
    1942899938 2874%
    ```
- > printf 函数从右向左压栈是因为 x86 架构下函数调用时是通过栈传参，amd64 架构下函数调用是通过寄存器传参。

C 语言有没有办法通过在 lib 下放置动态库文件来实现程序功能启用？ https://www.v2ex.com/t/722487

用 C 写一个动态库，需要注意什么，不想暴露任何数据结构，只提供 api。应该怎么去做？ https://www.v2ex.com/t/719689

函数外有分配内存的 char *outside，函数内有分配内存的 char *inside，如果先将 outside 所指的内存释放掉，然后将 inside 指针赋值给 outside，可行吗？函数结束后会被释放吗？有没有风险。 https://www.v2ex.com/t/709858

求解一个简单的 C 语言的问题, 事实证明我一直是错的 https://www.v2ex.com/t/701272

C 的语法基本看完了，下面该学什么？ https://www.v2ex.com/t/649748
- > http://akaedu.github.io/book/index.html 《 Linux C 编程一站式学习》

用 c 分配内存，为什么普遍都是用 malloc 而不是用 calloc？ https://www.v2ex.com/t/572612

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
