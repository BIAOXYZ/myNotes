
# 官方

https://github.com/torvalds/linux/tree/master/tools/perf

# wiki

perf (Linux) https://en.wikipedia.org/wiki/Perf_(Linux)

perf: Linux profiling with performance counters https://perf.wiki.kernel.org/index.php/Main_Page

perf(1) — Linux manual page https://man7.org/linux/man-pages/man1/perf.1.html

perf Examples https://www.brendangregg.com/perf.html

# perf 文章

在Linux下做性能分析3：perf - 知乎用户G0K17q的文章 - 知乎 https://zhuanlan.zhihu.com/p/22194920
- > `perf` 的原理是这样的：每隔一个固定的时间，就在CPU上（每个核上都有）产生一个中断，在中断上看看，当前是哪个pid，哪个函数，然后给对应的pid和函数加一个统计值，这样，我们就知道CPU有百分几的时间在某个pid，或者某个函数上了。这个原理图示如下： ![](https://pic1.zhimg.com/80/9a1cce72e02b748c02d182d56dc5df40_1440w.jpg)
- > 很明显可以看出，这是一种采样的模式，我们预期，运行时间越多的函数，被时钟中断击中的机会越大，从而推测，那个函数（或者pid等）的CPU占用率就越高。
- > 这种方式可以推广到各种事件，比如上一个博文我们介绍的ftrace的事件，你也可以在这个事件发生的时候上来冒个头，看看击中了谁，然后算出分布，我们就知道谁会引发特别多的那个事件了。

Linux 性能诊断 perf使用指南 https://developer.aliyun.com/article/65255

Linux性能分析工具Perf简介 https://segmentfault.com/a/1190000021465563

火焰图（Flame Graphs）的安装和基本用法 https://www.cnblogs.com/wx170119/p/11459995.html
- > 火焰图（flame graph）是性能分析的利器，通过它可以快速定位性能瓶颈点。
- > perf 命令（performance 的缩写）是 Linux 系统原生提供的性能分析工具，会返回 CPU 正在执行的函数名以及调用栈（stack）。
