
最大顺序读写 10000 MB/s，威刚推出 LEGEND 970 PCIe Gen5 SSD https://www.ithome.com/0/704/113.htm
- 回复里的：
  * > 一顿顺读一万五，一看4K二十五
  * > 顺序读写再快体感已经不显著了，4K快才是真的快

AMD 与群联演示 PCIe 5.0 M.2 SSD，顺序读写破 10GB/s https://www.ithome.com/0/633/012.htm
- > 据报道，本次展示的 PCIe 5.0 SSD 为 M.2 规格，采用的是美光 232 层 B58R TLC 闪存，由于这款闪存还在调整阶段，这款 SSD 的速度仅突破 10GB / s，最终成品应该可以实现 12/11 GB / s 的顺序读 / 写速度。
- 回复里的：
  * > 顺序读写卷上天，一看4k美如画
  * > 随机提升一下吧，现在的顺序提升已经没啥感知了。
    >> 随机速度提升很难，主要受存储材质的物理限制

# tools

MegPeak—让你更懂你的处理器 https://www.v2ex.com/t/900266
- > **MegPeak 介绍**
  * > 为了更懂我们的处理器，MegEngine 团队开发了一个工具 [MegPeak](https://github.com/MegEngine/MegPeak)，可以帮助开发人员进行性能评估，开发指导等，目前已经开源到 [GitHub](https://github.com/MegEngine/MegPeak)。
- > **MegPeak 功能**
- > **MegPeak 原理**
  * > MegPeak 测试的主要参数是
    + > CPU 不同指令的计算峰值，以及指令延迟，以及内存带宽
    + > OpenCL 中不同内存的数据访存带宽，以及不同计算数据类型的计算峰值
  * > 要了解 MegPeak 是如何测试出上面这些性能数据，并且做到和数据手册上查询到尽量一致，因此需要读者了解下面 CPU 流水线相关细节。
- > **处理器流水线**
  * > 现代处理器为了增加指令的吞吐，引入了指令流水线，指令流水线可以将一条指令的执行过程划分为多个阶段，经典的 5 级流水线有：取指令，翻译指令，执行指令，访问寄存器，写回数据，这 5 个阶段，处理器中执行每个阶段的物理单元独立，因此理想状态下，每个时钟周期每个阶段对应的物理单元都能执行一次对应的操作，这样就形成了流水线，这样处理器每个时钟周期就可以完成执行一条指令。如下表所示，从第 5 个时钟周期之后，每个时钟周期都会完成一条指令执行： <br> ![](https://oscimg.oschina.net/oscnet/up-df792aa9178e28cb88e6b8a4ce9fe5b206c.png)
  * > 但是，流水线在实际执行时候不可能一直这样流畅的执行下去，会存在以下的冒险，阻塞流水线。
    + > 结构冒险——如果硬件无法同时支持指令的所有可能组合方式，就会出现资源冲突，从而导致结构冒险
    + > 数据冒险——流水线指令存在先后顺序，如果一条指令取决于先前指令的结果，就可能导致数据冒险
    + > 控制冒险——分支指令及其他改变程序计数器的指令实现流水化时，可能导致控制冒险
  * > MegPeak 中测量处理器指令的计算峰值和延迟就是通过控制指令间的数据冒险，尽可能排除结构冒险和控制冒险来实现的，因为 MegPeak 中需要通过写 Code 来控制处理器的数据冒险，为了排除编译器编译 code 时候的优化带来的干扰，所以在 MegPeak 在测试中的核心代码使用汇编来实现的。
- > **测试指令峰值**
- > **测试指令延迟**
- > **用 MegPeak 测到的数据，可以用来干什么**

## 磁盘性能测试

Linux如何查看与测试磁盘IO性能 https://www.cnblogs.com/mauricewei/p/10502539.html

How to Test Disk Speed Using the Linux Command Line?|(Measure Disk Performance with fio,dd and Graphical Method) https://cloudzy.com/blog/test-disk-speed-in-linux/
- > **Test disk speed in Linux using commands**
  * > **Test Disk Speed in Linux using `dd`**
- > **Test your HDD, SSD Read Speed using `Hdparm`**
- > **Better Test Disk Speed in Linux via `fio`**

How to check hard disk performance https://askubuntu.com/questions/87035/how-to-check-hard-disk-performance

Disk Speed Test (Read/Write): HDD, SSD Performance in Linux https://gist.github.com/ntamvl/84d234a48fa22a83449b3c1e39db06b8
