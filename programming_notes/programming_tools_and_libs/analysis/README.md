
# performance general

How do I achieve the theoretical maximum of 4 FLOPs per cycle? https://stackoverflow.com/questions/8389648/how-do-i-achieve-the-theoretical-maximum-of-4-flops-per-cycle

General C++ Performance Improvement Tips [closed] https://stackoverflow.com/questions/2030189/general-c-performance-improvement-tips

《提高C++性能的编程技术》笔记 - WeTiGY的文章 - 知乎 https://zhuanlan.zhihu.com/p/97046347

循环展开 https://zh.wikipedia.org/wiki/%E5%BE%AA%E7%8E%AF%E5%B1%95%E5%BC%80 || Loop unrolling https://en.wikipedia.org/wiki/Loop_unrolling

## 变量是否需要在for循环内部定义 --> 看来是没必要

Is it good to define a variable inside a loop? [closed] https://softwareengineering.stackexchange.com/questions/296721/is-it-good-to-define-a-variable-inside-a-loop

Is it efficient to declare a variable in a loop? [duplicate] https://stackoverflow.com/questions/16761618/is-it-efficient-to-declare-a-variable-in-a-loop

## if语句对性能的影响

【译】if语句的性能：现代处理器的分支预测 https://wgrape.github.io/2018/12/10/if%E8%AF%AD%E5%8F%A5%E7%9A%84%E6%80%A7%E8%83%BD-%E7%8E%B0%E4%BB%A3%E5%A4%84%E7%90%86%E5%99%A8%E7%9A%84%E5%88%86%E6%94%AF%E9%A2%84%E6%B5%8B/
- > 原文 [《Fast and slow if-statements: branch prediction in modern processors》](http://igoro.com/archive/fast-and-slow-if-statements-branch-prediction-in-modern-processors/)

If vs. Switch Speed https://stackoverflow.com/questions/445067/if-vs-switch-speed

# SIMD

单指令流多数据流 https://zh.wikipedia.org/wiki/%E5%8D%95%E6%8C%87%E4%BB%A4%E6%B5%81%E5%A4%9A%E6%95%B0%E6%8D%AE%E6%B5%81
- > **单指令流多数据流**（英语：**Single Instruction Multiple Data**，缩写：**SIMD**）是一种采用一个控制器来控制多个处理器，同时对一组数据（又称“数据向量”）中的每一个分别执行**相同**的操作从而实现空间上的并行性的技术。
- > 在微处理器中，单指令流多数据流技术则是一个控制器控制多个平行的处理微元，例如 Intel 的 [MMX](https://zh.wikipedia.org/wiki/MMX) 或 [SSE](https://zh.wikipedia.org/wiki/SSE)，以及 AMD 的 [3D Now!](https://zh.wikipedia.org/wiki/3DNow!) 指令集。
- > 图形处理器（GPU）拥有强大的并发处理能力和可编程流水线，面对单指令流多数据流时，运算能力远超传统CPU。[OpenCL](https://zh.wikipedia.org/wiki/OpenCL) 和 [CUDA](https://zh.wikipedia.org/wiki/CUDA) 分别是目前最广泛使用的开源和专利通用图形处理器（GPGPU）运算语言。

SIMD简介 - 吉良吉影的文章 - 知乎 https://zhuanlan.zhihu.com/p/55327037

SIMD指令集 - Sinaean Dean的文章 - 知乎 https://zhuanlan.zhihu.com/p/31271788

## SSE

SSE https://zh.wikipedia.org/wiki/SSE
- > **SSE（Streaming SIMD Extensions）** 是英特尔在AMD的 [3D Now!]() 发布一年之后，在其计算机芯片 [Pentium III]() 中引入的指令集，是继 [MMX]() 的扩展指令集。SSE指令集提供了70条新指令。AMD后来在 [Athlon XP]() 中加入了对这个新指令集的支持。
