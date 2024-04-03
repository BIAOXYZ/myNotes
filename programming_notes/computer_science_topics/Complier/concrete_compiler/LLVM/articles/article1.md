
# 1

深入浅出让你理解什么是LLVM https://www.jianshu.com/p/1367dad95445
- > 美国计算机协会 (ACM) 将其2012 年软件系统奖项颁给了LLVM，之前曾经获得此奖项的软件和技术包括:Java、Apache、 Mosaic、the World Wide Web、Smalltalk、UNIX、Eclipse等等
创始人:Chris Lattner，亦是Swift之父
- > 趣闻：Chris Latter本来只是想写一个底层的虚拟机，这也是LLVM名字的由来，`low level virtual machine`，跟Java的JVM虚拟机一样，可是后来，llvm从来没有被用作过虚拟机，哪怕LLVM的名气已经传开了。所以人们决定仍然叫他LLVM，更多的时候只是当作“商标”一样的感觉在使用，其实它跟虚拟机没有半毛钱关系。官方描述如下：`The name "LLVM" itself is not an acronym; it is the full name of the project.` “LLVM”这个名称本身不是首字母缩略词; 它是项目的全名。
- > **传统的编译器架构**
  * > ![](https://upload-images.jianshu.io/upload_images/3008243-6951acfcbe4e9eff.jpg)
  * > **Frontend:前端**
    + > 词法分析、语法分析、语义分析、生成中间代码
  * > **Optimizer:优化器**
    + > 中间代码优化
  * > **Backend:后端**
    + > 生成机器码
- > **LLVM架构**
  * > ![](https://upload-images.jianshu.io/upload_images/3008243-b517c768f5a97607.png)
  * > ***不同的前端后端使用统一的中间代码LLVM Intermediate Representation (`LLVM IR`)***
  * > 如果需要支持一种新的编程语言，那么只需要实现一个新的前端
  * > 如果需要支持一种新的硬件设备，那么只需要实现一个新的后端
  * > 优化阶段是一个通用的阶段，它针对的是统一的LLVM IR，不论是支持新的编程语言，还是支持新的硬件设备，都不需要对优化阶段做修改
  * > ***相比之下，<ins>GCC的前端和后端没分得太开，前端后端耦合在了一起</ins>。所以GCC为了支持一门新的语言，或者为了支持一个新的目标平台，就变得特别困难***
  * > LLVM现在被作为实现各种静态和运行时编译语言的通用基础结构(GCC家族、Java、.NET、Python、Ruby、Scheme、Haskell、D等)
- > **什么是Clang**
  * > LLVM项目的一个子项目，基于LLVM架构的C/C++/Objective-C编译器前端。
  * > **相比于GCC，Clang具有如下优点**
    ```console
    • 编译速度快:在某些平台上，Clang的编译速度显著的快过GCC(Debug模式下编译OC速度比GGC快3倍)
    • 占用内存小:Clang生成的AST所占用的内存是GCC的五分之一左右
    • 模块化设计:Clang采用基于库的模块化设计，易于 IDE 集成及其他用途的重用
    • 诊断信息可读性强:在编译过程中，Clang 创建并保留了大量详细的元数据 (metadata)，有利于调试和错误报告
    • 设计清晰简单，容易理解，易于扩展增强
    ```
- > **Clang与LLVM关系**
  * > ![](https://upload-images.jianshu.io/upload_images/3008243-a7c02c2c24265d98.png)
  * > LLVM整体架构，前端用的是clang，广义的LLVM是指整个LLVM架构，一般狭义的LLVM指的是LLVM后端（包含代码优化和目标代码生成）。
  * > `源代码（c/c++）经过clang--> 中间代码(经过一系列的优化，优化用的是Pass) --> 机器码`
- > **OC源文件的编译过程**

# 2

LLVM基本概念入门 - P2Tree的文章 - 知乎 https://zhuanlan.zhihu.com/p/140462815
- > **LLVM和Clang的背景**
  * > 而在这之前，Apple公司一直使用gcc作为编译器，后来GCC对Objective-C的语言特性支持一直不够，Apple自己开发的GCC模块又很难得到GCC委员会的合并，所以老乔不开心。等到Chris Lattner毕业时，Apple就把他招入靡下，去开发自己的编译器，所以LLVM最初受到了Apple的大力支持。
  * > 因为LLVM只是一个编译器框架，所以还需要一个前端来支撑整个系统，所以Apple又拨款拨人一起研发了Clang，作为整个编译器的前端，Clang用来编译C、C++和Objective-C。所以当我接触Apple编译器时，当时的帖子里都说使用Clang/LLVM来和gcc做对比，当然是在代码优化、速度和敏捷性上比gcc强不少。这里我有两个文章，一个是gcc评价它在代码诊断方面和Clang的比较( [ClangDiagnosticsComparison - GCC Wiki](https://gcc.gnu.org/wiki/ClangDiagnosticsComparison) )，另一个是Clang评价它和gcc（以及其他几个开源编译器）的优缺点( http://clang.llvm.org/comparison.html )，还是很客观的。相比来说，Clang/LLVM的完整性还不够，毕竟还在发展中。
  * > 对了，Clang的发音是 `/ˈklæŋ/`，这是官方确认过的，我现在还在纠正发音过程中（后续：半个月后已纠正完毕，无缝衔接）。
  * > 后来Apple推出了Swift，也是基于LLVM作为编译器框架的。
  * > 至于Chris Lattner，17年的时候跳到了特斯拉，再后来去了Google，在TensorFlow团队，还是挺厉害的。而LLVM开源之后由LLVM委员会负责维护，当然发展势头也很猛。
