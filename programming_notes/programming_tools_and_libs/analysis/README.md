
# performance general

How do I achieve the theoretical maximum of 4 FLOPs per cycle? https://stackoverflow.com/questions/8389648/how-do-i-achieve-the-theoretical-maximum-of-4-flops-per-cycle

General C++ Performance Improvement Tips [closed] https://stackoverflow.com/questions/2030189/general-c-performance-improvement-tips

《提高C++性能的编程技术》笔记 - WeTiGY的文章 - 知乎 https://zhuanlan.zhihu.com/p/97046347

G++ optimization beyond -O3/-Ofast https://stackoverflow.com/questions/14492436/g-optimization-beyond-o3-ofast
- 【[:cow::beer:][:star:][`*`]】 https://stackoverflow.com/questions/14492436/g-optimization-beyond-o3-ofast/38511897#38511897 【//notes：看了这个人的回答只想说——性能优化真是一门大学问！就仅仅只是在编译阶段，都有这么多知识和技巧。PS：原来 `-Ofast` 不但不是终点，离终点还远着呢。。。】
  * > Most of the answers suggest alternative solutions, such as different compilers or external libraries, which would most likely bring a lot of rewriting or integration work. I will try to stick to what the question is asking, and focus on what can be done with GCC alone, by activating compiler flags or doing minimal changes to the code, as requested by the OP. This is not a "you must do this" answer, but more a collection of GCC tweaks that have worked out well for me and that you can give a try if they are relevant in your specific context.
  * > **Warnings regarding original question**
    + > Before going into the details, a few warning regarding the question, typically for people who will come along, read the question and say "the OP is optimising beyond O3, I should use the same flags than he does!".
      - > `-march=native` enables usage of **instructions specific to a given CPU architecture**, and that are not necessarily available on a different architecture. <ins>The program may not work at all if run on a system with a different CPU</ins>, or be significantly slower (as this also enables `mtune=native`), so be aware of this if you decide to use it. More information [here](https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html).
      - > `-Ofast`, as you stated, enables some **non standard compliant** optimisations, so it should used with caution as well. More information [here](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html).
  * > **Other GCC flags to try out**
    + > The details for the different flags are listed [here](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html).
      - > `-Ofast` enables `-ffast-math`, which in turn enables `-fno-math-errno`, `-funsafe-math-optimizations`, `-ffinite-math-only`, `-fno-rounding-math`, `-fno-signaling-nans` and `-fcx-limited-range`. You can go even further on **floating point calculation optimisations** by selectively adding some **extra flags** such as `-fno-signed-zeros`, `-fno-trapping-math` and others. These are not included in `-Ofast` and can give some additional performance increases on calculations, but you must check whether they actually benefit you and don't break any calculations.
      - > GCC also features a large amount of **other optimisation flags** which aren't enabled by any "`-O`" options. They are listed as "experimental options that may produce broken code", so again, they should be used with caution, and their effects checked both by testing for correctness and benchmarking. Nevertheless, I do often use `-frename-registers`, this option has never produced unwanted results for me and tends to give a noticeable performance increase (ie. can be measured when benchmarking). This is the type of flag that is very dependant on your processor though. `-funroll-loops` also sometimes gives good results (and also implies `-frename-registers`), but it is dependent on your actual code.
  * > **PGO**
    + > GCC has **Profile-Guided Optimisations** features. There isn't a lot of precise GCC documentation about it, but nevertheless getting it to run is quite straightforward.
      - > first compile your program with `-fprofile-generate`.
      - > let the program run (the execution time will be significantly slower as the code is also generating profile information into .gcda files).
      - > recompile the program with `-fprofile-use`. If your application is multi-threaded also add the `-fprofile-correction` flag.
    + > PGO with GCC can give amazing results and really significantly boost performance (I've seen a 15-20% speed increase on one of the projects I was recently working on). Obviously the issue here is to have some **data that is sufficiently representative** of your application's execution, which is not always available or easy to obtain.
  * > **GCC's Parallel Mode**
    + > GCC features a **Parallel Mode**, which was first released around the time where the GCC 4.2 compiler was out.
    + > Basically, it provides you with **parallel implementations of many of the algorithms in the C++ Standard Library**. To enable them globally, you just have to add the `-fopenmp` and the `-D_GLIBCXX_PARALLEL` flags to the compiler. You can also selectively enable each algorithm when needed, but this will require some minor code changes.
    + > All the information about this parallel mode can be found [here](https://gcc.gnu.org/onlinedocs/libstdc++/manual/parallel_mode.html).
    + > If you frequently use these algorithms on large data structures, and have many hardware thread contexts available, these parallel implementations can give a huge performance boost. I have only made use of the parallel implementation of `sort` so far, but to give a rough idea I managed to reduce the time for sorting from 14 to 4 seconds in one of my applications (testing environment: vector of 100 millions objects with custom comparator function and 8 cores machine).
  * > **Extra tricks**
    + > Unlike the previous points sections, this part does **require some small changes in the code**. They are also GCC specific (some of them work on Clang as well), so <ins>compile time macros should be used to keep the code portable on other compilers</ins>. This section contains some more advanced techniques, and <ins>should not be used if you don't have some assembly level understanding of what's going on</ins>. Also note that processors and compilers are pretty smart nowadays, so it may be tricky to get any noticeable benefit from the functions described here.
      - > GCC builtins, which are listed [here](https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html). Constructs such as `__builtin_expect` can help the compiler do better optimisations by providing it with **branch prediction** information. Other constructs such as `__builtin_prefetch` brings data into a cache before it is accessed and can help reducing **cache misses**.
      - > function attributes, which are listed [here](https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html). In particular, you should look into the `hot` and `cold` attributes; the former will indicate to the compiler that the function is a **hotspot** of the program and optimise the function more aggressively and place it in a special subsection of the text section, for better locality; the later will optimise the function for size and place it in another special subsection of the text section.
  * 回复里的：
    + > Thanks, this answer describes pretty much what we ended up doing, especially PGO proved to be quite useful. Additionally I also liked the ACOVEA project suggested by @zaufi, although it didn't work out for this project.
    + > Wow, didn't know about the PGO options! About 30% improvement in my case.
    + > "These are not included in `-Ofast`" —— I am pretty sure that is wrong. If you look at the GCC docs for `-ffast-math` (turned on by `-Ofast`), it also turns on `-funsafe-math-optimizations`, which turns on `-fassociative-math`. (among others) There is a phrase in the docs "This option is not turned on by any `-O` option", that I consider a documentation error, since `-Ofast` does turn them on. Also, PGO turn on `-funroll-loops`, which turns on `-frename-registers`.
      >> @uLoop: the GCC documentation is indeed not always clear. I have checked those flags using the compiler's `-Q` flag and have tweaked the answer accordingly.
    + > @Pyves I also came across another method to compliment along with yours: Feedback directed optimization with GCC and Perf: https://blog.wnohang.net/index.php/2015/04/29/feedback-directed-optimization-with-gcc-and-perf/ . However, having snags with this one, the article isn't up-to-date, some commands are depracated and gcov_create is having problems with reading perf's perf.data file. Maybe you can investigate and provide some guidance.
    + > See also: https://developer.ibm.com/articles/gcc-profile-guided-optimization-to-accelerate-aix-applications/ and https://stackoverflow.com/questions/13881292/what-information-does-gcc-profile-guided-optimization-pgo-collect-and-which-op
    + > Note: when linking, after compiling with `-fprofile-generate` on to generate special files for the Profile-Guided Optimizations (PGO), you need to also pass the `-lgcov` option to the build/linking `gcc` command. See this answer and my comment underneath it: https://stackoverflow.com/questions/16682606/how-to-resolve-gcov-init-undefined-reference-issue-when-linking/16863478#16863478
- https://stackoverflow.com/questions/14492436/g-optimization-beyond-o3-ofast/14492561#14492561
  * > huh, then final thing you may try: [ACOVEA](https://github.com/Acovea/libacovea) project: Analysis of Compiler Optimizations via an Evolutionary Algorithm -- as obvious from the description, it tries a genetic algorithm to pick the best compiler options for your project (doing compilation maaany times and check for timing, giving a feedback to the algorithm :) -- but results could be impressive! :)
- https://stackoverflow.com/questions/14492436/g-optimization-beyond-o3-ofast/45388350#45388350
  * > Some notes about the currently chosen answer (I do not have enough reputation points yet to post this as a comment):
  * > The answer says: "`-fassociative-math`, `-freciprocal-math`, `-fno-signed-zeros`, and `-fno-trapping-math`. These are not included in `-Ofast` and can give some additional performance increases on calculations"
  * > Perhaps this was true when the answer was posted, but the [GCC documentation](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html) says that all of these are enabled by `-funsafe-math-optimizations`, which is enabled by `-ffast-math`, which is enabled by `-Ofast`. This can be checked with the command `gcc -c -Q -Ofast --help=optimizer`, which shows which optimizations are enabled by `-Ofast`, and confirms that all of these are enabled.
  * > The answer also says: "other optimisation flags which aren't enabled by any "`-O`" options... `-frename-registers`"
  * > Again, the above command shows that, at least with my GCC 5.4.0, `-frename-registers` is enabled by default with `-Ofast`.

What information does GCC Profile Guided Optimization (PGO) collect and which optimizations use it? https://stackoverflow.com/questions/13881292/what-information-does-gcc-profile-guided-optimization-pgo-collect-and-which-op

profile-guided optimization (C) https://stackoverflow.com/questions/52557/profile-guided-optimization-c
- https://stackoverflow.com/questions/52557/profile-guided-optimization-c/57553#57553

## 变量是否需要在for循环内部定义 --> 看来是没必要

Is it good to define a variable inside a loop? [closed] https://softwareengineering.stackexchange.com/questions/296721/is-it-good-to-define-a-variable-inside-a-loop

Is it efficient to declare a variable in a loop? [duplicate] https://stackoverflow.com/questions/16761618/is-it-efficient-to-declare-a-variable-in-a-loop

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
