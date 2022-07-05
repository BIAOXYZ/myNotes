
# GCC官方

GCC online documentation https://gcc.gnu.org/onlinedocs/

3.1 Option Summary https://gcc.gnu.org/onlinedocs/gcc/Option-Summary.html
- `-fopenmp`  `-fopenmp-simd`

3.11 Options That Control Optimization https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html

Chapter 18. Parallel Mode https://gcc.gnu.org/onlinedocs/libstdc++/manual/parallel_mode.html

# GCC内部原理

Why doesn't GCC optimize `a*a*a*a*a*a` to `(a*a*a)*(a*a*a)`? https://stackoverflow.com/questions/6430448/why-doesnt-gcc-optimize-aaaaaa-to-aaaaaa

# GCC其他

【[:star:][`*`]】 GCC常用参数详解 https://www.cnblogs.com/zhangsir6/articles/2956798.html
>> 笔记见：[《1--GCC常用参数详解.md》](articles/1--GCC常用参数详解.md)

[翻译]15个最常用的GCC编译器参数 https://colobu.com/2018/08/28/15-Most-Frequently-Used-GCC-Compiler-Command-Line-Options/ || 15 Most Frequently Used GCC Compiler Command Line Options https://www.thegeekstuff.com/2012/10/gcc-compiler-options/
- > 21 全部参数介绍 https://gcc.gnu.org/onlinedocs/gcc/Option-Summary.html

## 如何知道你的编译器支持哪些C/C++标准

Compiler standards support (c++11, c++14, c++17) https://stackoverflow.com/questions/34836775/compiler-standards-support-c11-c14-c17
- https://stackoverflow.com/questions/34836775/compiler-standards-support-c11-c14-c17/65483397#65483397
  * > So, after a bit of a struggle trying to dust off my sed skills, I was able to come up with this command:
    ```sh
    gcc -v --help 2> /dev/null | sed -n '/^ *-std=\([^<][^ ]\+\).*/ {s//\1/p}'
    ```

Which gcc and g++ version support which standard of c and c++? https://stackoverflow.com/questions/10029437/which-gcc-and-g-version-support-which-standard-of-c-and-c
