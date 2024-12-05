
# 官方

`<cstdlib> (stdlib.h)` http://www.cplusplus.com/reference/cstdlib/
- **String conversion**
  * atoi http://www.cplusplus.com/reference/cstdlib/atoi/
- **Dynamic memory management**
  * malloc http://www.cplusplus.com/reference/cstdlib/malloc/
- **Integer arithmetics**
  * abs http://www.cplusplus.com/reference/cstdlib/abs/
- **Environment**
  * `getenv()` https://cplusplus.com/reference/cstdlib/getenv/

`std::getenv` https://en.cppreference.com/w/cpp/utility/program/getenv

# `malloc` 

malloc https://en.cppreference.com/w/c/memory/malloc

C动态内存分配 https://zh.wikipedia.org/wiki/C%E5%8A%A8%E6%80%81%E5%86%85%E5%AD%98%E5%88%86%E9%85%8D
- > 函数概述

  | 函数 | 描述 |
  | --- | --- |
  | malloc	| 分配指定数量的字节 |
  | realloc | 调整指定内存块的大小，必要时会重新分配 |
  | calloc | 分配指定数量的字节，并初始化为 0 |
  | free | 释放指定的内存块 |

- > **类型安全**
  * > `malloc` 所执行的内存分配基于字节数而不是类型，其返回类型为 void 指针 `（void *）`，表示该指针所指向区域的数据类型未知。C++ 由于其强类型系统，***实际使用该指针时需要进行强制类型转换***，而 C 语言中则不必进行。
    ```c
    int * ptr;
    ptr = malloc(10 * sizeof(int));		/* 不进行强制类型转换 */
    ptr = (int *)malloc(10 * sizeof(int));	/* 进行强制类型转换 */
    ```

# `qsort()`

qsort http://www.cplusplus.com/reference/cstdlib/qsort/

qsort, qsort_s https://en.cppreference.com/w/c/algorithm/qsort

qsort https://en.wikipedia.org/wiki/Qsort

qsort(3) - Linux man page https://linux.die.net/man/3/qsort

qsort https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/qsort

C语言qsort函数用法 https://www.cnblogs.com/eniac12/p/4769229.html

# `getenv()`

C/C++ 获取系统环境变量方法. https://www.cnblogs.com/algorithmic/archive/2012/09/23/2698604.html

C/C++ 获取环境变量的值 https://blog.csdn.net/xuebing1995/article/details/110659393

# `strtoul()`

C语言strtoul函数简介 https://blog.csdn.net/qq_37858386/article/details/78458401

# 其他

Is there any difference in the way `atof` and `strtod` work? https://stackoverflow.com/questions/67353927/is-there-any-difference-in-the-way-atof-and-strtod-work
- https://stackoverflow.com/questions/67353927/is-there-any-difference-in-the-way-atof-and-strtod-work/67353969#67353969
