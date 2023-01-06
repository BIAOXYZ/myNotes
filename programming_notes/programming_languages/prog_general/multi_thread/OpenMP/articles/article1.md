
# 1

OpenMP中文教程 https://www.jianshu.com/p/9931c05f4058 || OpenMP https://www.hz-bin.cn/OpenMP
- > 博客地址：https://www.hz-bin.cn/OpenMP
- > 原文链接：https://github.com/LLNL/HPC-Tutorials/blob/main/openmp/index.md

【[:star:][`*`]】 在C++中使用openmp进行多线程编程 https://blog.csdn.net/acaiwlj/article/details/49818965  【//notes：大部分个人实战的例子放到了 [example1.md](../examples/example1.md)里。】
- > **Schedule指令**
  * > Schedule指令提供对for指令中线程调度更多的控制能力。它有两种调度方式：static和dynamic。
- > **ordered指令**
  * > ordered指令用于控制一段代码在for循环中的执行顺序，它保证这段代码一定是按照for中的顺序依次执行的。
    ```cpp
    for (int i = 0; i < 10; ++i)
    {
        Data data = ReadFile(files[i]);
    #pragma omp ordered
        PutDataToDataset(data);
    }
    ```
  * > 这个循环负责读取10个文件，然后将数据放入一个内存结构中。读文件的操作是并行的，但是将数据存入内存结构中则是严格串行的。即先存第一个文件数据，然后第二个...，最后是第十个文件。假设一个线程已经读取了第七个文件的，但是第六个文件还没有存入内存结构，那么这个线程会阻塞，知道第六个文件存入内存结构之后，线程才会继续运行。
  * > 在每一个ordered for循环中，有且仅有一个“#pragma omp ordered"指令限定的代码块。
- > **sections指令**
  * > section指令用于指定哪些程序块可以并行运行。一个section块内的代码必须串行运行，而section块之间是可以并行运行的。如，
    ```cpp
    #pragma omp parallel sections
    {
        { Work1();}
    #pragma omp section
        { Work2();
          Work3();}
    #pragma omp section
        { Work4();}
    }
    ```
  * > 以上代码表明，work1， Work1,  Work2 + Work3 以及  Work4可以并行运行，但是work2和work3的运行必须是串行运行，并且每个work都只会被运行一次。
- > **task 指令(OpenMP 3.0新增)**
  * > 当觉得for和section指令用着不方便时，可以用task指令。它用于告诉编译器其后续的指令可以并行运行。如OpenMP 3.0用户手册上的一个示例：
