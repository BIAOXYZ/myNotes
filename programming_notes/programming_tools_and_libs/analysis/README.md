
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

因为一个循环，CPU 搞了个新技术！ https://www.ithome.com/0/656/472.htm || https://mp.weixin.qq.com/s/dllxt-uSAvgkyMNrgqhC7Q  【from `编程技术宇宙`】
- > **一个简单的循环**
  * > 那天，我们遇到了一段代码：
    ```c
    void array_add(int data[], int len) {
      for (int i = 0; i < len; i++) {
        data[i] += 1;
      }
    }
    ```
  * > 循环了好几百次之后，才把这段代码执行完成，每次循环都是做简单又重复的工作，把我累得够呛。
  * > 一旁负责结果回写的老K也是累的满头大汗，吐槽道：“每次都是取出来加1又写回去，***要是能一次多取几个数，批量处理就好了***”
  * > 老K的话让我眼前一亮，对啊，能不能批量操作呢？
- > **并行计算**
  * > “是这样的，我们一号车间那天遇到了一段循环代码，循环体的内容很简单，就是给数组中的每一个元素加1。我们执行的时候，就是不断取出每一个元素，然后将其执行加法计算后，再写回去。这样一个一个来加1，我们感觉太慢了，***要是可以一次多取几个，并行加1***，那一定比一个一个加快上不少。”
  * > “我上面举的例子只是一个简单的情况，并行计算还可能不是固定的数，可能是一个数组和另一个数组相加。还有可能不是整数相加，而是浮点数，甚至，还可能不是加法，而是减法或者乘法，再或者不是算术运算，而是逻辑运算”
  * > “我琢磨着你说的这一系列东西，咱们是要新增一套专门用来并行计算的指令集啊”，小虎说道。“这可是大工程啊”
  * > “我觉得阿Q说的有道理，咱们确实需要提升处理这类数据运算的能力了。不过不用一下搞那么复杂，先支持整数并行运算就行了。新增寄存器这个也不用着急，可以先借用一下`浮点数运算单元FPU`的寄存器。这件事先这么定下来，具体的方案你们再继续讨论。”，说完便离开了会议室。
- > **SIMD**
  * > 又经过一阵紧张的讨论，我们终于敲定了方案。
  * > 我们借用浮点数运算单元的寄存器，还给它们起了新的名字：`MM0-MM7`。因为是`64位`的寄存器，所以可以同时存储两个32位的整数或者4个16位整数或者8个8位的整数。
  * > 我们还新增了一套叫 `MMX` 的指令集，用来并行执行整数的运算。
  * > 我们把这种在一条指令中同时处理多个数据的技术叫做 ***`单指令多数据流（Single Instruction Multiple Data）`***，简称 ***`SIMD`***。
  * > 不过渐渐地发现了两个很麻烦的问题：
    + > 第一个问题，因为是借用`FPU`的寄存器，所以当执行SIMD指令的时候，就不能用FPU计算单元，反过来也一样，同时使用的话就会出乱子，所以要经常在不同的模式之间切换，实在是有些麻烦。
    + > 另一个更重要的问题，咱们这套指令集只能处理整数的并行运算，可现在浮点数的并行运算越来越多，尤其是图像、视频还有深度学习的一些数据处理，浮点数情况越来越多，这时候都派不上用场。
  * > 这一次，我们扩展了一套新的`SSE`指令集出来，新增了`XMM0-XMM7`总共`8个128位`的寄存器，再也不用跟FPU共享寄存器了。而且位宽加了一倍，能容纳的数据更多了，能同时处理的数据自然也变多了。
  * > 后来，我们又不断的修改升级，不仅支持了对浮点数并行处理，还推出了新一代的`AVX`指令集，把寄存器再一次扩大为`256位`，现在我们的SIMD技术更加先进，处理数据运算的能力越来越强了！

SIMD简介 - 吉良吉影的文章 - 知乎 https://zhuanlan.zhihu.com/p/55327037

SIMD指令集 - Sinaean Dean的文章 - 知乎 https://zhuanlan.zhihu.com/p/31271788

## SSE

SSE https://zh.wikipedia.org/wiki/SSE
- > **SSE（Streaming SIMD Extensions）** 是英特尔在AMD的 [3D Now!]() 发布一年之后，在其计算机芯片 [Pentium III]() 中引入的指令集，是继 [MMX]() 的扩展指令集。SSE指令集提供了70条新指令。AMD后来在 [Athlon XP]() 中加入了对这个新指令集的支持。
