
Hulo 编程语言开发 —— 包管理与模块解析 https://www.v2ex.com/t/1152449

Hulo 编程语言开发 —— 从源代码到 AST 的魔法转换 https://www.v2ex.com/t/1151707
```console
书接上回，在《Hulo 语言架构：从源代码到目标代码的完整流程》一文中，我们介绍了Hulo编程语言的整体架构和编译流程。今天，让我们深入探讨编译流程中的第一个关键环节——解析器。

解析器可以说是源代码到目标语言最重要的基础，它负责将结构化的文本实例化为抽象语法树(AST)，这个过程也被称之为编译前端。解析器通过词法分析器(Lexer)将源代码分解为标记流(Token Stream)，再通过语法分析器(Parser)将标记流转换为抽象语法树，最终将人类可读的源代码转换为机器可处理的树形数据结构。这个树形结构保留了源代码的语法结构信息，为后续的语义分析、类型检查、优化和代码生成等编译后端阶段提供了必要的数据基础。
```
- > 为什么需要一种脚本编译成另一种脚本？ 自身的定位就是脚本，那支持跨平台不就可以了吗？
  >> 因为 bash powershell batch vbs 直接与操作系统捆绑着，他们自带 runtime ，其他语言如 python 、js 都需要安装运行时。而且 bash 在 linux 上面的地位有目共睹，大部分的批处理基本上都用 bash 实现。
- > 木兰项目用 rply 生成 python 语法树： https://gitee.com/MulanRevive/mulan-rework 项目源码用中文命名，方便阅览： ![分析器]( https://pic1.zhimg.com/80/v2-09c2cd22c6908f3869fc53900100280f_1440w.webp?source=2c26e567)
  >> Hulo 使用 ANTLR4 生成语法树 https://github.com/hulo-lang/hulo/blob/main/syntax/hulo/parser/grammar/huloParser.g4 使用 ANTLR4 有很高的容错性，一旦语法树解析错误也能继续递归，这种机制使其在处理不完整或有误的输入时仍能保持一定的解析能力（例如 IDE 中的实时语法检查）
- > https://github.com/goplus/xgo 怎么感觉跟这个的功能有点重合，直接编译到机器码得了？
- > 还有 Julia1.12 也会开始实验支持编译类型稳定代码到小体积二进制了
  >> 这差的很多吧，Hulo 的目标是编译成 Bash 、Powershell 、VBS 、Batch 统一批处理脚本，***作为批处理脚本的中间语言，你可以理解成批处理脚本的 LLVM*** ，然后在写一个提升器，将 Bash 转化成 Hulo ，就可以实现 Hulo 到其他批处理脚本的转换
  >>> 几年前试过一点 antlr： https://zhuanlan.zhihu.com/p/32792684 https://zhuanlan.zhihu.com/p/32939695

打算设计一门集所有语言的缺点短板于一体的语言，可能从哪里开始或者有哪些功能建议呢？ https://www.v2ex.com/t/1097722
```console
这个想法大概一开始是从某语言的变量提升开始的，刚学到那语言就觉得怎么会有这么天才的设计，真是太符合心目中的「语言的经典设计」（恶趣味角度）了。

虽然后来慢慢也理解到了这个设计的缘由，而且其实对这个语言接近 Lisp 和函数式的一些角度还是蛮喜欢的。

后来接触了一些其他的语言，例如某个 J 开头的语言，包括各种设计模式，有时候写着代码的时候，看到一些奇怪的约束和很不方便的地方，也会想，是不是可以做个集这一些短处为一体的语言呢。

现在想的话，大概想到的可能还有这些想法吧：
- for 关键字同时用于不同的循环、分支里面
- 混淆 true/false 、0 、非 0 、void 等概念
- 遍历集合的时候会改变原集合的结构
- 用 plunk 之类的字符串匹配而不是 map/forEach/filter
- 用同一个东西和语法表达列表、字典等多种数据结构，并且不关心顺序
- 每个函数都有个 this 指针
- 没有泛型，并且需要强转
- 所有的对象都可以 call ，函数也可以 new

目前大概想到的是这么多吧。
```
- > 有个叫 `brainfucker` 的语言我记得,看懂一段用它编写的代码需要一定的大脑算力
- > 您要找的是不是： 汇编
- > 不用设计，已经有现成的 GO 语言了
- > 
  ```console
  所有的对象都可以 call ，函数也可以 new
  混淆 true/false 、0 、非 0
  用同一个东西和语法表达列表、字典等多种数据结构，并且不关心顺序
  每个函数都有个 this 指针
  ```
  > 我怀疑你在内涵 JS 。
- > "2006-01-02 15:04:05"
- > 无论你的项目有多少行代码，你的项目文件夹里面，必须嵌套 10 倍的空文件夹，项目才能正常运行。例如：
  ```java
  com/xxx/yyy/zzz/ppp/ttt/mmm/qqq/service/head/break/main.java
  ```
- > parody 的话，可以考虑 https://github.com/TodePond/DreamBerd
- > 你说得对，但是《 Golang 》是一门由 Google 自主研发的全新编程语言，语言发生在一个被称作「 goroutine 」的幻想世界，在这里，被 func 选中的人将被授予「 pointer 」，导引 GO111MODULE 之力，你将扮演一位名为「 20060102150405 」的神秘角色，在自由的 interface 中邂逅性格各异、能力独特的 struct 们，和他们一起击败 err ，找回失散的泛型——同时，逐步发掘「 panic 」的真相。
- > http://esolangs.org/wiki/Main_Page 去集齐这些语言的缺点吧
  >> 回答 esolangs 多少有点算跑题了 核心还是让各种语言特性相互冲突和耦合 建议直接干掉过程的形参列表，类型系统随便乱来
- 个人补充链接：
  * Go 的时间格式化为什么是 2006-01-02 15:04:05？ https://polarisxu.studygolang.com/posts/go/why-time-use-2006/

你遇到过哪些比较难理解的编程语言概念 https://www.v2ex.com/t/1069983

为什么不同语言对 `99.1*1.05` 的四舍五入结果不一样 https://www.v2ex.com/t/1020406
- > 因为 ruby 的实现里 https://github.com/ruby/ruby/blob/master/numeric.c#L2536C13-L2536C25 发现数字的小数位数大于 14 位就会用另一个算法了
- > 浮点数常用的舍入有 6/7 种，每种舍入都有自己的具体使用场景。你先搞清楚，每个方法的具体舍入算法再看。只要使用的是 IEEE64 ，则最终同一个算法的结果应该是相同的。
- > 实际上大部分语言对浮点数运算都没有特殊处理，因为二进制就是没办法精确表示十进制小数，你压根处理不完特殊情况。0.1 + 0.2 都不等于 0.3 ，也没有哪个语言为浮点数重载一下等于号。你要是追求精确，就不该用浮点数。

关于编程语言内存对齐的疑问 https://www.v2ex.com/t/872792
- > https://stackoverflow.com/questions/381244/purpose-of-memory-alignment
- > x86 架构对于对齐的内存，写入读取都是原子的（但自增运算需要用专门的指令，另说）其他一些架构甚至不支持非对齐内存的原子操作。你搜一下 unaligned access 就可以搜到很多内容了。 <br> struct 内部重排以减少不必要的 padding ，这是性能优化的基础技巧之一。一般我们会把 64 位变量放前面，然后 32 位，然后 16 位。因为 64 位对齐一定同时也是 32 位和 16 位对齐，反之未必。 <br> ***<ins>编译器不会对 struct 内的顺序进行重排，因为有些操作可能会默认各个变量之间的顺序</ins>***。
- > Linux Kernel 里的文章： https://github.com/torvalds/linux/blob/master/Documentation/core-api/unaligned-memory-access.rst <br> 但实际来说，最新的一些 x86 处理器实际是支持未对齐内存访问的，而且也可以认为没有性能下降。旧一些的 x86 处理器也支持，但是会有性能下降。当然指令还是那个指令。其他的要看具体 arch 支持程度了，不支持的话甚至会出现 misaligned access 异常。

枚举类型是从 0 开始还是从 1 开始 https://v2ex.com/t/868018
- > 有设计文档说应该从 1 开始不过有争论。有个例子：Mysql 的枚举是从 1 开始的，0 会报错。
  ```
  文档写： （✔）
  0 ，保留字
  1 ，状态 1
  2 ，状态 2

  文档： （ X ）
  1 ，状态 1
  2 ，状态 2
  ```

webAssembly 目前是个啥情况 https://www.v2ex.com/t/865575
- > 我看到好几个游戏领域的应用，把旧的 C++的客户端游戏搬到浏览器端。 https://universe.flyff.com/ 对我影响很大的一款游戏，飞飞。

这个各大语言性能测试结果挺有意思 https://www.v2ex.com/t/862452
```console
来自 https://github.com/GoodManWEN/Programming-Language-Benchmarks-Visualization
```
- > 这有另外一个更知名的： https://github.com/kostya/benchmarks
