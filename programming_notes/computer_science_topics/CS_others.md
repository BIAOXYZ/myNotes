
# projects

## os project

陈莉君教授《Linux内核分析与应用》课程课件、动手实践源代码、实验手册、实验源代码 https://github.com/ljrcore/linuxmooc
-> Linux内核之旅网站 http://kerneltravel.net/
-> Linux内核之旅微信公众号
- https://github.com/ljrcore/LearningLinuxKernel
- https://github.com/linuxkerneltravel/lmp

How to Make a Computer Operating System in C++ https://samypesse.gitbook.io/how-to-create-an-operating-system/ || https://github.com/SamyPesse/How-to-Make-a-Computer-Operating-System

《30天自制操作系统》源码中文版。自己制作一个操作系统（OSASK）的过程 https://github.com/yourtion/30dayMakeOS

u-root https://github.com/u-root/u-root || https://u-root.org/
- > A fully Go userland with Linux bootloaders! u-root can create a one-binary root file system (initramfs) containing a busybox-like set of tools written in Go.

xbook2操作系统内核 https://github.com/hzcx998/xbook2
- > 尽力了3个多月混合内核阶段，我发现微内核一个非常非常非常严重的问题就是效率，性能问题。我也知道我写得代码很烂，但是相比于宏内核的效率，的确差很多。于是，冥思苦想，还是做回宏内核，拥抱小可爱。

proj2-oslabs-by-history -- CS发展历史上的OS Labs https://github.com/oscomp/proj2-oslabs-by-history
- > 当前大学本科学生做OS实验面临工作量大，实验指导针对性不够强，难以对OS有整体理解等困难。为此，我们希望重新设计面向一般学生的 OS Labs。 这个OS Labs的目的是：“给学生逐步设计实现OS的线索和参考实例，提高学生的OS分析能力和动手能力，强化学生对 OS 的整体观念”。 这个OSLabs的特点是：以CS发展的历史过程为导向，以满足应用需求为基准，实现一系列相对独立的Special OS.

SimpleKernel https://github.com/Simple-XX/SimpleKernel
- > Simple kernel for learning operating systems. 用于学习操作系统的简单内核

linux-insides https://github.com/0xAX/linux-insides
- > **On other languages**
  * > Linux 内核揭秘 https://github.com/MintCN/linux-insides-zh

## complier project

A Compiler Writing Journey https://github.com/DoctorWkt/acwj

Write a simple interpreter of C. Inspired by c4 and largely based on it. https://github.com/lotabout/write-a-C-interpreter
> Let's Build a Compiler, by Jack Crenshaw https://compilers.iecc.com/crenshaw/

📚 《Go语法树入门——开启自制编程语言和编译器之旅》(开源免费图书/Go语言进阶/掌握抽象语法树/Go语言AST/LLVM/LLIR/凹语言) https://github.com/chai2010/go-ast-book

The single instruction C compiler https://github.com/xoreaxeaxeax/movfuscator
- > forked from  https://github.com/Battelle/movfuscator

chibicc: A Small C Compiler https://github.com/rui314/chibicc
- > (The old master has moved to [historical/old](https://github.com/rui314/chibicc/tree/historical/old) branch. This is a new one uploaded in September 2020.)
- > chibicc is yet another small C compiler that implements most C11 features. Even though it still probably falls into the "toy compilers" category just like other small compilers do, chibicc can compile several real-world programs, including [Git](https://git-scm.com/), [SQLite](https://sqlite.org/), [libpng](http://www.libpng.org/pub/png/libpng.html) and chibicc itself, without making modifications to the compiled programs. Generated executables of these programs pass their corresponding test suites. So, chibicc actually supports a wide variety of C11 features and is able to compile hundreds of thousands of lines of real-world C code correctly.

craftinginterpreters_zh https://github.com/GuoYaxiang/craftinginterpreters_zh
- > 手撸解释器教程《Crafting Interpreters》中文翻译。
- > 这是一个还在进行中的翻译项目，原项目是[craftinginterpreters](https://github.com/munificent/craftinginterpreters)，同时还有配套的英文书，可免费[在线阅读](http://www.craftinginterpreters.com/)。

## DB project

Let's make a SQL parser so we can provide a familiar interface to non-sql datastores! https://github.com/mozilla/moz-sql-parser

BusTub https://github.com/cmu-db/bustub || https://15445.courses.cs.cmu.edu/
- > BusTub is a relational database management system built at Carnegie Mellon University for the Introduction to Database Systems (15-445/645) course. This system was developed for educational purposes and should not be used in production environments.

原文链接： https://cstack.github.io/db_tutorial/parts/part1.html
- 手把手教你从零开始实现一个数据库系统 https://mp.weixin.qq.com/s/1UXfQ1rv68Jz8V9VOVMcXw
- 一起做个简单的数据库（二）：世上最简单的SQL编译器和虚拟机 https://mp.weixin.qq.com/s/edusjWkvE2q8Tre59hFcrw
- 一起做个简单的数据库（三）：一个在内存中仅能做追加操作的单表数据库 https://mp.weixin.qq.com/s/AQ6g8CCVqbyRdGjZFRzrRg
- 一起做个简单的数据库（四）：第一次测试 （含bug处理） https://mp.weixin.qq.com/s/1U80Wwgh6whVDW9TGD0SYg
- 一起做个简单的数据库（六）：The Cursor Abstraction https://mp.weixin.qq.com/s/JbetQWlP9mwlRQ3xgVvcDg

Build a distributed SQL database from the ground up 从零开始写分布式数据库 https://github.com/ngaut/builddatabase

VLDB Summer School 2021 Labs https://github.com/vldbss-2021/vldb-2021-labs

## network project

互联网体系结构/庖丁解牛Linux网络协议栈 https://github.com/mengning/net

## crypto and security project (hard to be placed into the academic related repo)

Sparse Merkle Tree https://github.com/aergoio/SMT
- > A performance oriented implementation of a binary SMT with parallel update, node batching and storage shortcuts. Details of the SMT implementation: https://medium.com/@ouvrard.pierre.alain/sparse-merkle-tree-86e6e2fc26da

Urkel -- An optimized and cryptographically provable key-value store. Written in C. https://github.com/chjj/liburkel 

zkrypt: Zero-Knowledge Proof Toolbox https://github.com/guanzhi/zkrypt
- > Zkrypt是一个开源的C语言零知识证明算法库，旨在向用户提供简洁、高效的非交互式零知识证明协议接口，用户可以通过调用接口实现完整的零知识证明协议的流程，包括公共参数设置、证明生成和验证等步骤。
- > 本项目由北京大学关志的密码学研究组开发维护。
  ```
  支持多种零知识证明协议（包括Groth16, Plonk等）
  通过算法优化提供零知识证明协议的高效实现
  支持包括BN254、BLS381等在内的多种主流曲线，特别地支持国密SM2、SM9等算法中的推荐曲线，可与国密算法兼容
  支持X86、ARM等硬件运行环境及Linux、Windows、Mac、Android等软件运行环境
  ```

## other project

【 From: https://github.com/yifengyou 】
- Qemu KVM(Kernel Virtual Machine)学习笔记 https://github.com/yifengyou/learn-kvm
- 《一个64位操作系统的设计与实现》学习笔记 https://github.com/yifengyou/The-design-and-implementation-of-a-64-bit-os

A toy JVM in Go https://github.com/zserge/tojvm

一个轻量级容器引擎（实现 docker 的一小部分功能） https://github.com/TensShinet/islands_show

开发一个 Linux 调试器（二）：断点 - Linux中国的文章 - 知乎 https://zhuanlan.zhihu.com/p/27655662 || Writing a Linux Debugger Part 2: Breakpoints https://blog.tartanllama.xyz/writing-a-linux-debugger-breakpoints/

CEO 亲自写代码登上热榜，从零开始打造“裸金属”树莓派 https://www.ithome.com/0/579/698.htm
- > 所谓“裸金属”就是没有操作系统的计算机，直接在逻辑硬件上执行指令。这位 CEO 说，打造一个裸金属系统是他儿时的志向。
- > 项目 GitHub 链接： https://github.com/isometimes/rpi4-osdev

Getting started with static program analysis. 静态程序分析入门教程。 https://github.com/RangerNJU/Static-Program-Analysis-Book

## programming language project

Single-file public-domain/open source libraries with minimal dependencies https://github.com/nothings/single_file_libs

C++ 资源大全中文版 https://github.com/jobbole/awesome-cpp-cn
- > awesome-cpp 就是 fffaraz 发起维护的 C++ 资源列表，内容包括：标准库、Web应用框架、人工智能、数据库、图片处理、机器学习、日志、代码分析等。
  * A curated list of awesome C++ (or C) frameworks, libraries, resources, and shiny things. Inspired by awesome-... stuff. https://github.com/fffaraz/awesome-cpp || http://fffaraz.github.io/awesome-cpp/

C in four functions https://github.com/rswier/c4

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 非硬核类

k8s、docker源码分析、读书笔记 https://github.com/Kevin-fqh/learning-k8s-source-code
- Linux
  * (05)Unix-Linux编程实践之线程机制.md  https://github.com/Kevin-fqh/learning-k8s-source-code/blob/master/Linux/(05)Unix-Linux%E7%BC%96%E7%A8%8B%E5%AE%9E%E8%B7%B5%E4%B9%8B%E7%BA%BF%E7%A8%8B%E6%9C%BA%E5%88%B6.md
- docker
  * (05)Client端与Daemon端的通信.md https://github.com/Kevin-fqh/learning-k8s-source-code/blob/master/docker/(05)Client%E7%AB%AF%E4%B8%8EDaemon%E7%AB%AF%E7%9A%84%E9%80%9A%E4%BF%A1.md
  * (06)daemon的创建过程.md https://github.com/Kevin-fqh/learning-k8s-source-code/blob/master/docker/(06)daemon%E7%9A%84%E5%88%9B%E5%BB%BA%E8%BF%87%E7%A8%8B.md

📚 Tech Interview Guide 技术面试必备基础知识、Leetcode 题解、Java、C++、Python、后端面试、操作系统、计算机网络、系统设计 https://github.com/CyC2018/CS-Notes
> https://cyc2018.github.io/CS-Notes/

程序猿成长计划 https://github.com/mylxsw/growing-up

🚀 fullstack tutorial 2019，后台技术栈/架构师之路/全栈开发社区，春招/秋招/校招/面试 https://github.com/frank-lam/fullstack-tutorial
> https://frank-lam.github.io/fullstack-tutorial/

## 系统设计

The System Design Primer https://github.com/donnemartin/system-design-primer
- 系统设计入门 https://github.com/donnemartin/system-design-primer/blob/master/README-zh-Hans.md

System design interview for IT companies https://github.com/checkcheckzz/system-design-interview

PershingSquared https://www.zhihu.com/column/c_1253614849646895104
- 读书笔记 | System Design Interview Alex Xu Pt. 1 - 水心记的文章 - 知乎 https://zhuanlan.zhihu.com/p/439908039
  * Caching Strategies and How to Choose the Right One https://codeahoy.com/2017/08/11/caching-strategies-and-how-to-choose-the-right-one/
- 读书笔记 | System Design Interview Alex Xu Pt. 2+Pt. 3 - 水心记的文章 - 知乎 https://zhuanlan.zhihu.com/p/443602320

缓存模式（Cache Aside、Read Through、Write Through） - Charles的文章 - 知乎 https://zhuanlan.zhihu.com/p/150740291
- > **Cache-Aside**
- > **Read-Through**
  * > `Read-Through`和`Cache-Aside`很相似，***不同点在于程序不需要再去管理从哪去读数据（缓存还是数据库）。相反它会直接从缓存中读数据***，该场景下是缓存去决定从哪查询数据。当我们比较两者的时候这是一个优势因为它会让程序代码变得更简洁。
- > **Write-Through**
  * > `Write-Through`下 ***所有的写操作都经过缓存***，每次我们向缓存中写数据的时候，缓存会把数据持久化到对应的数据库中去，且这两个操作都在一个事务中完成。因此，只有两次都写成功了才是最终写成功了。这的确带来了一些写延迟但是它保证了数据一致性。
- > **Write-Behind**
  * > `Write-Behind`和`Write-Through`在“程序只和缓存交互且只能通过缓存写数据”这一点上很相似。***不同点在于`Write-Through`会把数据立即写入数据库中，而`Write-Behind`会在一段时间之后（或是被其他方式触发）把数据一起写入数据库，这个异步写操作是`Write-Behind`的最大特点***。
    >> //notes：注：有些[文章](https://codeahoy.com/2017/08/11/caching-strategies-and-how-to-choose-the-right-one/)里 ***`Write-Behind` cache*** 也被称为 ***``Write-Back` cache***。

A Hitchhiker’s Guide to Caching Patterns https://hazelcast.com/blog/a-hitchhikers-guide-to-caching-patterns/
