
# 1

Linux 性能分析valgrind（一）之memcheck使用 - Xin Lee的文章 - 知乎 https://zhuanlan.zhihu.com/p/92074597
- > **Valgrind 怎么用**
  * > 2.运行
    + > `valgrind --tool=toolname args-val program args-pro`
- > **使用 Valgrind Memcheck**
  * > memcheck工具的使用方式如下:
    + > `valgrind --tool=memcheck ./a.out`
- > **工程实践注意**：
  * > 需要测试***运行中***的内存泄漏问题，可以使用如下命令：
    + > `valgrind --log-file=valgrind.log --tool=memcheck --leak-check=full --show-leak-kinds=all ./your_app arg1 arg2`
- > **该工具可以检测下列与内存相关的问题**:
  ```console
  未释放内存的使用
  对释放后内存的读/写
  对已分配内存块尾部的读/写
  内存泄露
  不匹配的使用malloc/new/new[] 和 free/delete/delete[]
  重复释放内存
  ```

使用Valgrind工具进行C/C++内存泄漏检测 https://www.cnblogs.com/JCpeng/p/15125638.html

【代码质量】如何使用Valgrind检测内存泄漏 https://blog.csdn.net/qq_20553613/article/details/106503929

使用 Valgrind 检测 C++ 内存泄漏 http://senlinzhan.github.io/2017/12/31/valgrind/ || C/C++ 内存泄漏检测工具：Valgrind https://murphypei.github.io/blog/2019/04/valgrind-memory-leaky
