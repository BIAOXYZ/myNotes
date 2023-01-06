
# 官方

OpenMP https://zh.wikipedia.org/wiki/OpenMP

OpenMP https://www.openmp.org/
- The OpenMP Examples document has been updated with new features found in the OpenMP 5.0 Specification https://www.openmp.org/openmp-updates/openmp-examples-updated-with-5-0-features/
  * OpenMP Examples document https://github.com/OpenMP/Examples
- Resources https://www.openmp.org/resources/

gcc/libgomp/omp.h.in https://github.com/gcc-mirror/gcc/blob/master/libgomp/omp.h.in

# 较系统攻略

OpenMP Functions https://learn.microsoft.com/en-us/cpp/parallel/openmp/reference/openmp-functions

# 其他

openMP 函数总结（并行程序设计导论） https://www.jianshu.com/p/ec76277f510b

OpenMP | Hello World program https://www.geeksforgeeks.org/openmp-hello-world-program/

OpenMP并行编程笔记 http://zhaoxuhui.top/blog/2017/12/02/OpenMP%E5%B9%B6%E8%A1%8C%E7%BC%96%E7%A8%8B%E7%AC%94%E8%AE%B0.html
- > 并行区里每个线程执行的代码是一样的，计算机若有N个核，相当于同时重复执行了N次，并没有提高效率、节省时间。 我们希望的是把同一工作分配给不同线程来做，每个线程完成一部分，这样运行速率才会快。这就需要对for并行了。 而对于for循环，可以使用for制导语句，将for循环分配给各个线程执行，这里要求数据不存在依赖。 当编译器发现`#pragma omp parallel for`后，自动将下面的for循环分成N份，(N为电脑CPU核数)，然后把每份指派给一个核去执行，而且多核之间为并行执行。形式为：

OpenMP的简单使用教程 https://www.cnblogs.com/wxquare/p/5584662.html
- > **编写OpenMP程序**
  * > 输出了8次 Hello World！。这是为什么呢？原因是那个directive之后的代码被多线程操作了，默认情况下GCC的 `-fopenmp` flag会调用和你CPU内核数相同数量的线程来执行程序。这个线程数量是可以控制，只需要修改环境变量中`OMP_NUM_THREADS`参数，例如：
    ```sh
    export OMP_NUM_THREADS=2
    ```
    > 之后也不需要重新编译，直接执行之前的程序，就会发现 Hello World！的数量变成了两个了。
- > **for循环**
  * > 这里有一点一定要主要，将要进行多线程处理的for循环一定是独立的（independent），也就是说下面这种情况是不可以的。
    ```cpp
    for(i=0;i<10000;i++){
      a[i] = a[i-1]+1;
    }
    ```
    > 每一次循环都需要之前的结果，这种循环没有办法进行多线程处理，因为每一次都要等待之前的输出，强行处理还会出错。

OpenMP并行开发（C++） - TeddyZhang的文章 - 知乎 https://zhuanlan.zhihu.com/p/51173703

# 问题

Do I need to `#include <omp.h>` in my C/C++ sources? https://stackoverflow.com/questions/2358613/do-i-need-to-include-omp-h-in-my-c-c-sources
