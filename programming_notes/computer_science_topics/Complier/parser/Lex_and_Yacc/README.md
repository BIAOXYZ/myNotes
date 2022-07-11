
# 官方

Lex (software) https://en.wikipedia.org/wiki/Lex_(software) || lex https://zh.wikipedia.org/wiki/Lex
- > 在计算机科学里面，lex是一个产生词法分析器（lexical analyzer，"扫描仪"（scanners）或者"lexers"）的程序。Lex常常与 [yacc]() 语法分析器产生程序（parser generator）一起使用。Lex(最早是埃里克·施密特和迈克·莱斯克制作）是许多UNIX系统的标准词法分析器（lexical analyzer）产生程序，而且这个工具所作的行为被详列为POSIX标准的一部分。
- > Lex读进一个代表词法分析器规则的输入字符串流，然后输出以C语言实做的词法分析器源代码。
- > 虽然传统上是商业软件，但是有些根据原本AT&T代码这些版本的Lex可以以公开源代码的形式获得，并被视为某些系统的一部分，例如说OpenSolaris和贝尔实验室九号项目。另一个有名的Lex公开源代码版本是 [flex]()，代表"快速的词法分析器"（fast lexical analyzer）。

flex https://github.com/westes/flex
- > The Fast Lexical Analyzer - scanner generator for lexing in C and C++

Yacc https://en.wikipedia.org/wiki/Yacc || yacc https://zh.wikipedia.org/wiki/Yacc
- > yacc（Yet Another Compiler Compiler），是Unix/Linux上一个用来生成编译器的编译器（编译器代码生成器）。yacc生成的编译器主要是用C语言写成的语法解析器（Parser），需要与词法解析器 [Lex]() 一起使用，再把两部分产生出来的C程序一并编译。yacc本来只在（类）Unix系统上才有，但现时已普遍移植往Windows及其他平台。
- > yacc最初由AT&T的Steven C. Johnson为Unix操作系统开发，后来一些兼容的程序如Berkeley Yacc，[GNU bison]()，MKS yacc和Abraxas yacc陆续出现。它们都在原先基础上做了少许改进或者增加，但是基本概念是相同的。

# 其他

USING LEX WITH YACC https://silcnitc.github.io/ywl.html

What is the difference between Flex/Lex and Yacc/Bison? https://stackoverflow.com/questions/623503/what-is-the-difference-between-flex-lex-and-yacc-bison

what is the difference between lex and yacc https://stackoverflow.com/questions/1189684/what-is-the-difference-between-lex-and-yacc/1189732

Flex(scanner)/Bison(parser)工作原理 - 扬眉的文章 - 知乎 https://zhuanlan.zhihu.com/p/120812270
- > **Unix Lex/YACC 发展为 Linux FLex/Bison**
  * > Lex是1975年由Mike Lesk和当时尚在AT&T实习的Eric Schmidt共同完成的（Schmidt做的更多），是一个词法分析器的生成程序，可以单独使用也可以与Johnson的yacc协同工作。lex很有名气，但是无奈效率太低加上有bug。大概在1987年，Lawrence Berkeley实验室的Vern Paxson用C重新写了Lex，并命名为FLex（the Fast Lexical Analyzer Generator），基于伯克利许可证。flex现在是SourceForge的一个项目，依然基于伯克利许可，
  * > [Flex](https://github.com/westes/flex "Flex") 是起初unix版lex的free (but non-GNU) implementation，用于c/c ++ 的词法扫描生成器。
  * > （注意：Schmidt曾是google的CEO）
  * > bison的前身是yacc。yacc是由贝尔实验室的S.C.Johnson基于Knuth大神的LR语法分析理论，于1975～1978年写成。大约1985年，UC Berkeley 的研究生Bob Corbett使用改进的内部算法实现了伯克利yacc，来自FSF的Richard Stallman改写了伯克利yacc并将其用于GNU项目，添加了很多特性，形成了今天的GNU Bison。bison现在作为FSF的项目被维护，基于GNU公共许可证发布，[Bison](http://www.gnu.org/software/bison/manual/)是兼容yacc的free的语法生成器。
  * > 早期Unix的Lex/YACC，发展为FLex/Bison，新版本的程序是向上兼容的(即兼容老版本)
