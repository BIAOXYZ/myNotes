
c 语言中打印指针的值打印的是 OS 分配的虚拟地址的值吗？要怎么知道 OS 给这个 c 程序进程分配的虚拟地址的大小呢？ https://www.v2ex.com/t/1025538
- > 1.c 语言中打印指针的值打印的是 OS 分配的虚拟地址的值吗？ -- 是的，应用程序看到的地址都是虚拟地址 <br> 2.要怎么知道 OS 给这个 c 程序进程分配的虚拟地址的大小呢？ -- 每一个应用都会分配到整个物理内存大小的虚拟内存 <br> 3.如何知道哪一块内存大小是可以读可以写？ -- 使用更高特权等级（默认的 user 等级应该是无权访问的），查询 PMP 相关配置可以拿到内存地址的读写权限
  >> "每一个应用都会分配到整个物理内存大小的虚拟内存" -- 并不准确，分配的空间大小和物理内存大小没关系。精简点的程序的用户地址空间甚至可能就只有程序和动态库的映射+自己的栈，花哨点的可以上来就要 TB 量级的匿名 `mmap` 自己分配。 <br> "使用更高特权等级（默认的 user 等级应该是无权访问的），查询 PMP 相关配置可以拿到内存地址的读写权限" -- 其实可以读自己的 `maps 文件`/`smaps 文件`来查询（怎么看怎么不清真） 或者想办法直接干了然后捕获 `SIGSEGV` 就知道是不是可读可写了...
- > 你有没有想过把这个转成汇编，汇编基本上一目了然
  >> 这和汇编没关系，虚拟地址分配，虚拟地址到物理地址的映射和 segmentation fault 都发生在 `mmu` 和 OS 内部，对你的程序是透明的
- > 进入 `x86 实模式`，就能打出实际内存地址了

Linux 是如何隐藏`DIR`结构体定义的 https://www.v2ex.com/t/1015775
- > C 语言不要求所有 struct 都有定义，只要声明之后就可以使用指针。（当然用 sizeof 作用，或者定义该类型对象或数组，是需要该结构体的定义的。）所谓它是 opaque 就是说不提供定义。 <br> 从 C 的 ABI 的角度，结构体指针和 void 指针没啥区别。实现 opendir 的人可能知道 DIR 的定义，并分配好内存、填充好数据返回给调用者。

C 语言用户态函数可观测性 https://www.v2ex.com/t/1010847
- > 用 logpoint 也可以达到类似的功能。一般来说 gdb 需要用 breakpoint 来断点，输出变量内容。而 logpoint 顾名思义，就是不中断程序的前提下，直接用 log 输出指定变量/函数运行的日志信息。

为什么 C 语言程序员更偏爱使用宏定义一组常量, 而不使用枚举？ https://www.v2ex.com/t/935684
- > K&R C 一路沿袭下来的习惯吧, 枚举是 C89 的特性
- > 主要是历史原因，最初的 K&R 版本的 C 还不支持 enum 。后来 ANSI C 也没明确 enum 的长度，而是可以由编译器决定。另外如果常量是 flag ，需要用 or 来连接的话，用 enum 也不合适。
- > 我说一点：宏可以嵌套宏，但是宏不能嵌套枚举常量。

C 语言级联内存池之轻松零拷贝 IPC https://www.v2ex.com/t/874168

C 语言 循环下 创建动态数组 非常慢 应该如何解决 https://www.v2ex.com/t/864227
```console
我简单阐述下背景: 我不是专业 C 开发人员， 我是 python 开发。 因为 python 部分功能实现慢，故使用 C 来重写然后进行封装动态库进行调用。
所有项目用的是 C 不是 C++ 。 目前是已经完成了 速度也有很大的提升。 但是我发现应该还能提升 。 下面代码就是一个例子。。

我要循环一个很大的值 百万级别甚至上亿。 然后动态数组， 但是这个创建动态数组非常慢，各位 C 大佬有什么方法可以解决吗？
还是说我的操作有问题？？？ 非专 C 人员，勿喷， 如果可以的话，救救孩纸吧.

下面迭代了 132963138 次数的耗时情况
```
```c
for (int ii = 0; ii < arr_cnt_copy; ii++) {
count += 1;
int min_score = 7462; // 200 ms
int* res_card_lst = (int*)malloc(c_ * sizeof(int)); // 25s
}
```
- > 不要用循环，一次性分一大块内存，然后用指针运算来寻址
- > 不清楚你要的业务逻辑，但如果有可能的话，把内存申请拿到循环外来做。
- > 兄弟们， 报喜了。。。。是要拿出来快很多了。 感谢各位。。 我也蠢了 唉 ，， 在外面定义数组 ， 然后里面会赋值，下一次循环又重新赋值 这个操作 比在里面重新创建要快很多 。。。

gcc 为什么连这种代码都能编译通过？ https://www.v2ex.com/t/860466
```c
#include <stdio.h>

int main(int argc, char *argv[])
{
	char *s = argv[argc-1];
	printf("%s\n", s);

	char *s2 = argc[argv-1];
	printf("%s\n", s2);

	return 0;
}
```
```console
打印最后一个参数，上面的写法是正确的，问题是下面的写法也能编译通过，而且打印输出和上面的写法一样，不明白为什么编译器允许 argc[argv-1] 这种写法。
```
- > 问题是把 int 类型直接当成数组用，不符合 c 语言的语法规范啊
  >> ***实际上数组是个语法糖，本质是指针操作***
- > `a[b]` 等价于 `*(a + b)`。C 语言标准就是这样规定的。 https://en.cppreference.com/w/c/language/operator_member_access
- > `a[b]` 就是 `*(a+b)`。加法的两端是可以交换的。所以 `a[b]` 就是 `b[a]`。
- > `a[3]` 等价于 `3[a]`，c 语言混乱编码里经常看到，最终都是 `*(a+3)` 的意思，至于是不是符合语言规范就不知道了，反正 `gcc` 可以通过
- > 翻了一下 C 标准，`6.2.5.1 Array subscripting`
  * > `1: One of the expressions shall have type ‘‘pointer to complete object type’’, the other expression shall have integer type, and the result has type ‘‘type’’.`
  * > `2: ... The definition of the subscript operator [] is that E1[E2] is identical to (*((E1)+(E2))) ...`
- > 没有你想的那种巧合，楼上已经讲的很清楚了，因为 `a[b]` 的本质还是指针操作，有：`a[b]=*(a+b)=*(b+a)=b[a]`
- > 虽然我知道为什么它们相等，也知道符合规范，但是不妨碍我认为这规范就是坨 shi ，这坨 shi 除了玩花样以外没有带来任何用处，`a[b]=*(a+b)=*(b+a)=b[a]` 这个等式只在 a 和 b 当中有 1 个是可以用下标访问的，1 个是整数才成立； 2 个都是可以用下标访问的或都是整数就过不了，这规范跟个八股文似的

哪位大兄弟给推荐一个简单，无版权风险的 C/C++ log 库？万分感谢 https://www.v2ex.com/t/860294
- > `spdlog` 吧，性能好，接口易用，许可是 mit 协议的

闲来无聊，修改纯 C 实现一个 http server https://www.v2ex.com/t/857246
- 后续：
  * 基于上次的 C 语言 http server，仿造做了一个文件上传下载功能。 https://www.v2ex.com/t/860605

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
