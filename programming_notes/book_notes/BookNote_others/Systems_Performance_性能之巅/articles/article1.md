
https://www.zhihu.com/people/shang-shang-qian-67-10/posts
- 《性能之巅》学习笔记之Dtrace - 上上谦的文章 - 知乎 https://zhuanlan.zhihu.com/p/71437161
- 《性能之巅》学习笔记之内存和文件系统 其三 vm_area_struct 与 虚拟内存 - 上上谦的文章 - 知乎 https://zhuanlan.zhihu.com/p/79554619

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

《性能之巅》学习笔记之Dtrace - 上上谦的文章 - 知乎 https://zhuanlan.zhihu.com/p/71437161
- > **前言**：
  * > 但是因为这本书实在是把这个工具写的太神了，再怎么难用也想学习一下，于是就各种百度，然后查到了这篇文章[动态追踪技术漫谈](https://blog.csdn.net/scdxmoe/article/details/73326099),然后打开了新世界的大门。。。
  * > (ps:后来查到，Mac在 `/usr/share/examples/DTTk/` 目录下有 `dtrace` 各种使用的例子，可以直接用)
- > **正文**：

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

【[:star:][`*`]】 动态追踪技术漫谈 https://blog.csdn.net/scdxmoe/article/details/73326099
- > **DTrace 与 SystemTap**
  * > DTrace 的优势是它采取了跟操作系统内核紧密集成的一种方式。D 语言的实现其实是一个虚拟机（VM），有点像 Java 虚拟机（JVM）。它的一个好处在于 D 语言的运行时是常驻内核的，而且非常小巧，所以每个调试工具的启动时间和退出时间都很短。但是我觉得 DTrace 也是有明显缺点的。其中一个让我很难受的缺点是 D 语言缺乏循环结构，这导致许多针对目标进程中的复杂数据结构的分析工具很难编写。虽然 DTrace 官方声称缺少循环的原因是为了避免过热的循环，但显然 DTrace 是可以在 VM 级别上面有效限制每一个循环的执行次数的。另外一个较大的缺点是，DTrace 对于用户态代码的追踪支持比较弱，没有自动的加载用户态调试符号的功能，需要自己在 D 语言里面声明用到的用户态 C 语言结构体之类的类型。
  * > ***SystemTap 的优点是它有非常成熟的用户态调试符号的自动加载***，同时也有循环这样的语言结构可以去编写比较复杂的探针处理程序，可以支持很多很复杂的分析处理。由于 SystemTap 早些年在实现上的不成熟，导致互联网上充斥着很多针对它的已经过时了的诟病和批评。最近几年 SystemTap 已然有了长足的进步。
  * > 当然，SystemTap 也是有缺点的。首先，它并不是 Linux 内核的一部分，就是说它并没有与内核紧密集成，所以它需要一直不停地追赶主线内核的变化。另一个缺点是，它通常是把它的“小语言”脚本（有点像 D 语言哦）动态编译成一个 Linux 内核模块的 C 源码，因此经常需要在线部署 C 编译器工具链和 Linux 内核的头文件，同时需要动态地加载这些编译出来的内核模块，以运行我们的调试逻辑。在我们的调试工具运行完毕之后，又存在动态卸载 Linux 内核模块的问题。出于这些原因，SystemTap 脚本的启动相比 DTrace 要慢得多，和 JVM 的启动时间倒有几分类似。虽然存在这些缺点，但总的来说，SystemTap 还是一个非常成熟的动态追踪框架。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

【[:star:][`*`]】 Linux内核调试技术——kprobe使用与实现 https://blog.csdn.net/luckyapple1028/article/details/52972315

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
