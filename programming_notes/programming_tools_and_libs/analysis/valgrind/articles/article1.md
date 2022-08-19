
# 1

Linux 性能分析valgrind（一）之memcheck使用 - Xin Lee的文章 - 知乎 https://zhuanlan.zhihu.com/p/92074597 || 【//notes：这篇主要是把知乎那篇实战了一下，95%的内容都是一样的。】 使用Valgrind工具进行C/C++内存泄漏检测 https://www.cnblogs.com/JCpeng/p/15125638.html
- > **Valgrind 怎么用**
  * > 2.运行
    + > `valgrind --tool=toolname args-val program args-pro`
- > **使用 Valgrind Memcheck**
  * > memcheck工具的使用方式如下:
    + > `valgrind --tool=memcheck ./a.out`
- > **工程实践注意**：
  * > 需要测试 ***运行中*** 的内存泄漏问题，可以使用如下命令：
    + > `valgrind --log-file=valgrind.log --tool=memcheck --leak-check=full --show-leak-kinds=all ./your_app arg1 arg2`
    + > `--log-file` 报告文件名。如果没有指定，输出到stderr。
    + > `--tool=memcheck` 指定Valgrind使用的工具。Valgrind是一个工具集，包括Memcheck、Cachegrind、Callgrind等多个工具。`memcheck`是缺省项。
    + > `--leak-check` 指定如何报告内存泄漏（memcheck能检查多种内存使用错误，内存泄漏是其中常见的一种），可选值有:
      - > `no` 不报告
      - > `summary` 显示简要信息，有多少个内存泄漏。summary是缺省值。
      - > `yes` 和 `full` 显示每个泄漏的内存在哪里分配。
    + > `show-leak-kinds` 指定显示内存泄漏的类型的组合。类型包括`definite, indirect, possible,reachable`。也可以指定`all`或`none`。缺省值是definite,possible。 运行一段时间后想停止进程不要kill掉，需要ctrl + c来结束，输出的log会在上述命令中的valgrind.log中。
- > **该工具可以检测下列与内存相关的问题**:
  ```console
  未释放内存的使用
  对释放后内存的读/写
  对已分配内存块尾部的读/写
  内存泄露
  不匹配的使用malloc/new/new[] 和 free/delete/delete[]
  重复释放内存
  ```
- > 注意: 下面讨论的所有测试代码都应该使用gcc并且加上`-g`选项(用来在memcheck的输出中生成行号)进行编译.

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

使用 Valgrind 检测 C++ 内存泄漏 http://senlinzhan.github.io/2017/12/31/valgrind/ || C/C++ 内存泄漏检测工具：Valgrind https://murphypei.github.io/blog/2019/04/valgrind-memory-leaky
- > **检测内存泄漏**
  * > 使用 Valgrind 分析 C++ 程序时，有一些问题需要留意。例如，这个程序并没有发生内存泄漏，但是从`HEAP SUMMARY`可以看到，程序分配了 2 次内存，但却只释放了 1 次内存，为什么会这样呢？
  * > 实际上这是由于 C++ 在分配内存时，为了提高效率，使用了它自己的内存池。当程序终止时，内存池的内存才会被操作系统回收，所以 Valgrind 会将这部分内存报告为 reachable 的，需要注意，***reachable 的内存不代表内存泄漏***，例如，从上面的输出中可以看到，有 72704 个字节是 reachable 的，但没有报告内存泄漏。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

valgrind排查内存泄露 - 涛哥的文章 - 知乎 https://zhuanlan.zhihu.com/p/111530078
- > **如何发现内存泄露**
  * > 内存泄漏较大的情况下，机器cpu使用率飙升，cpu的wait百分比增加，通过top可以看到swap内存使用量不断增加，kswap进程不时出现在进程列表当中。linux中可以通过 `watch -n1 "ps -o vsz -p <PID>"`，实时看到特定进程的内存使用量不断地增加。
- > **valgrind定位内存泄露**  【//notes：一个 valgrind 的文章，反而是非 valgrind 的部分更值得学习- -🐶】
- > **`mallinfo`手动打印内存信息定位**
  * > 通过valgrind的log可以基本定位到内存泄漏的位置，在valgrind的log中可以清楚地看到，new和delete或者malloc和free不能一一对应：
  * > 第二种方式是通过打log的方式来进行观察，在每次调用完可疑的接口之后都可以调用mallinfo函数来打印当前进程所占用的内存数量，如果通过log文件发现当前进程的内存使用量在不停地增加，则可以认为可疑的接口是造成内存泄漏的元凶。通过这个方式可以不断地缩小怀疑的范围，直到最终定位到泄漏的代码。
    ```c
    #include <stdlib.h>
    #include <stdio.h>
    #include <malloc.h>
    void func()
    {
        printf("func\n");
        void *p=malloc(sizeof(int));
     //free(p);
    }
    void displayMallInfo()
    {
        struct mallinfo info  = mallinfo();
        printf("===========================\n");
        printf("arena:%d\n",info.arena);
        printf("ordblks:%d\n",info.ordblks);
        printf("smblks:%d\n",info.smblks);
        printf("hblks:%d\n",info.hblks);
        printf("hblkhd:%d\n",info.hblkhd);
        printf("usmblks:%d\n",info.usmblks);
        printf("uordblks:%d\n",info.uordblks);
        printf("fordblks:%d\n",info.fordblks);
        printf("keepcost:%d\n",info.keepcost);
        printf("===========================\n");
    }
    int main()
    {
        displayMallInfo();
        func();
        displayMallInfo();
        getchar();
        return 0;
    }
    ```
  * > 重新编译运行程序可以看到如下信息：
    ```console
    itcast@ubuntu:~/workspace/memleak$ ./a.out 
    ===========================
    arena:0
    ordblks:1
    smblks:0
    hblks:0
    hblkhd:0
    usmblks:0
    uordblks:0
    fordblks:0
    keepcost:0
    ===========================
    func
    ===========================
    arena:135168
    ordblks:1
    smblks:0
    hblks:0
    hblkhd:0
    usmblks:0
    uordblks:1072
    fordblks:134096
    keepcost:134096
    ===========================
    ```
  * > 使用这种方法来跟综某个函数的内存分配需要对linux的虚拟内存分配的原理非常熟悉，`malloc`在linux中的实现也都是调用linux的系统接口`brk`、`sbrk`、`mmap`等来实现内存申请
  * > 释义：
    ```console
    arena 在malloc中使用sbrk分配内存的总大小（单位字节）
    ordblks 普通（即非fastbin）空闲块的数量。
    smblks fastbin free块的数量（参见mallopt（3））。（该字典未被使用）
    hblks 当前使用mmap（2）分配的块数。（见的讨论M_MMAP_THRESHOLD在mallopt（3） 。）
    hblkhd 当前使用mmap（2）分配的块中的字节数
    usmblks 分配空间的“高水位线” - 即最大值（该字段未被使用并且总为0）,分配的空间量。这个领域是,仅在非线程环境中维护。
    fsmblks fastbin空闲块中的总字节数。（该字典未被使用）
    uordblks 使用中分配使用的总字节数。
    fordblks 空闲块中的总字节数。
    ```
- > **监控系统内存相关调用**
  * > 一般我们的运营环境中都没有安装valgrind，所以这种情况无法用valgrind来跟踪，所以这种情况一般只能用打log的方式来跟踪，如果无法打印log，可以用另外一个比较简单的方式来进行：
直接`strace`发生内存泄漏的进程。
    ```sh
    strace -p <pid>
    ```
  * > 通过`strace`的内容可以看到，发生大量内存泄漏的进程都会有不少申请系统内存的系统调用，如下:
- > **重写`malloc`实现自定义跟踪**
  * > 如果我们能够在自己程序的每个malloc和free的调用中添加一些自定义的代码，配合一些跟踪记录的实现手段，那么也可以自行实现内存的泄露跟踪，以下是一个例子
    ```c
    #define free(p) {\
        printf("#%s:%d:%s():free(0x%lx)\n", __FILE__, __LINE__,\
                __func__, (unsigned long)p); \
        free(p);\
    }
    #define malloc(size) ({\
        void *ptr=malloc(size);\
        printf("#%s:%d:%s():malloc(0x%lx)\n", __FILE__, __LINE__,\
                __FUNCTION__, (unsigned long)ptr); \
        ptr;\
    })
    ```
  * > 编译程序后执行可以看到如下的日志输出
    ```console
    ...
    #main.c:19:func():malloc(0x1b61420)
    #main.c:20:func():free(0x1b61420)
    ...
    ```
  * > 如果每次`malloc`的过程中能够将这些地址信息使用诸如链表之类的容器来进行记录，每次`free`都从中去除记录，最终程序执行结束也可以打印没有被释放的内存。但是这种方法的限制是只能对自己写的代码生效，如果调用了第三方库，而第三方库中使用`malloc`和`free`，那么这种方法无法跟踪第三方库的内存泄露问题。
  * > ***C中可以使用定义宏的方式将`malloc`和`free`重新定义，C++中也可以重载`new`和`delete`操作符实现相同的功能***，这里不做太多讨论。
- > **总结**
  * > 以上几种方式都比较适合内存泄漏比较快，每次泄漏比较多情况，如果内存泄漏每次只泄一点点，这个是非常难跟踪到的，只能依靠工具valgrind来协助或者依靠代码的阅读来进行排查。
  * > 另外的，STL造成的内存泄漏也是一个比较容易忽略的问题，也是最难排查的，之前我们就发生过使用`string.append()`的方式来保存日志信息，***不停地append，然后在最后一步写到本地磁盘，并释放掉申请的内存，但是由于本地磁盘的相关目录没有创建，造成写入失败，导致内存也没有释放，从而引起了内存泄漏，服务器宕机***。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

【代码质量】如何使用Valgrind检测内存泄漏 https://blog.csdn.net/qq_20553613/article/details/106503929

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
