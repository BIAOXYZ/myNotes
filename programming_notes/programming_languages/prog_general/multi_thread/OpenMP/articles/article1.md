
# 1

OpenMP中文教程 https://www.jianshu.com/p/9931c05f4058 || OpenMP https://www.hz-bin.cn/OpenMP
- > 博客地址：https://www.hz-bin.cn/OpenMP
- > 原文链接：https://github.com/LLNL/HPC-Tutorials/blob/main/openmp/index.md

【[:star:][`*`]】 在C++中使用openmp进行多线程编程 https://blog.csdn.net/acaiwlj/article/details/49818965  【//notes：大部分个人实战的例子放到了 [example1.md](../examples/example1.md) 里。】
- > **Schedule指令**
  * > Schedule指令提供对for指令中线程调度更多的控制能力。它有两种调度方式：`static`和`dynamic`。
- > **ordered指令**
  * > `ordered`指令用于控制一段代码在for循环中的执行顺序，它保证这段代码一定是按照for中的顺序依次执行的。
    ```cpp
    for (int i = 0; i < 10; ++i)
    {
        Data data = ReadFile(files[i]);
    #pragma omp ordered
        PutDataToDataset(data);
    }
    ```
  * > 这个循环负责读取10个文件，然后将数据放入一个内存结构中。读文件的操作是并行的，但是将数据存入内存结构中则是严格串行的。即先存第一个文件数据，然后第二个...，最后是第十个文件。假设一个线程已经读取了第七个文件的，但是第六个文件还没有存入内存结构，那么这个线程会阻塞，知道第六个文件存入内存结构之后，线程才会继续运行。
  * > 在每一个ordered for循环中，有且仅有一个“`#pragma omp ordered`"指令限定的代码块。
- > **sections指令**
  * > `section`指令用于指定哪些程序块可以并行运行。***一个section块内的代码必须串行运行，而section块之间是可以并行运行的***。如，
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
  * > 以上代码表明，Work1, Work2 + Work3 以及 Work4 可以并行运行，但是work2和work3的运行必须是串行运行，并且每个work都只会被运行一次。
- > **task 指令(OpenMP 3.0新增)**
  * > 当觉得for和section指令用着不方便时，可以用task指令。它用于告诉编译器其后续的指令可以并行运行。如OpenMP 3.0用户手册上的一个示例：
- > **atomic指令**
- > **critical 指令**
- > **openmp中的锁**
  * > `omp_lock_t` 相当于 `mutex`, 如果线程已经获得了锁，那在释放锁之前，当前线程不能对锁进行上锁。为了满足这种递归锁的需求，omp提供了 `omp_nest_lock_t`，这种锁相当于 `recursive_mutex` 可以递归上锁，但是释放操作必须与上锁操作一一对应，否则锁不会得到释放。
- > **flush 指令**
- > **private, firstprivate,lastprivate 及 shared指令控制变量共享方式**
- > **default 指令**
- > **reduction 指令**
- > **barrier和nowait指令**
- > **single 和 master 指令**
- > **循环嵌套**
  * > 如下代码并不会按照我们期望的方式运行：
    ```cpp
    #pragma omp parallel for
    for(int y=0; y<25;++y)
    {
    #pragma omp parallel for
        for(int x=0; x<80;++x)
        {
            tick(x,y);
        }
    }
    ```
  * > 实际上内部的那个“`parallel for`"会被忽略，自始至终只创建了一个线程组。假如将上述代码改为如下所示，将无法通过编译：
    ```cpp
    #pragma omp parallel for
    for(int y=0; y<25;++y)
    {
    #pragma omp for // ERROR, nesting like this is not allowed.
    for(int x=0; x<80;++x)
    {
         tick(x,y);
    }
    }
    ```
  * > **OpenMP 3.0中的解决方案**
    + > 在OpenMP 3.0中，可以利用collapse指令来解决循环嵌套问题，如：
      ```cpp
      #pragma omp parallel for collapse(2)
      for(int y=0; y<25;++y)
      for(int x=0; x<80;++x)
      {
           tick(x,y);
      }
      ```
    + > `collapse`指令传递的数字就代表了循环嵌套的深度，这里为2层。
  * > **OpenMP 2.5中正确的做法**
    * > 在OpenMP 2.5中，我们可以通过将多层循环改为单层循环的方法来达到目的，这样便无需循环嵌套:
      ```cpp
      #pragma omp parallel for
      for(int pos=0; pos<(25*80);++pos)
      {
        int x = pos%80;
        int y = pos/80;
        tick(x,y);
      }
      ```
    * > 然而重写这样的代码也并非易事，另一个办法是采用`omp_set_nested`方法开启循环嵌套支持，默认是关闭的：
      ```cpp
      omp_set_nested(1);
      #pragma omp parallel for
      for(int y=0; y<25;++y)
      {
      #pragma omp parallel for
      for(int x=0; x<80;++x)
      {
           tick(x,y);
      }
      }
      ```
    * > 现在内层循环中，也会创建一个大小为N的线程组，因此实际上我们将得到`N*N`个线程，这便会导致频繁的线程切换，会带来较大的性能损失，这也就是为什么循环嵌套默认是关闭的。也许最好的方法就是将外层循环的`parallel`指令删除，只保留内层循环的`parallel`：
      ```cpp
      for(int y=0; y<25;++y)
      {
      #pragma omp parallel for
      for(int x=0; x<80;++x)
      {
           tick(x,y);
      }
      }
      ```
- > **取消线程（退出循环）**
  * > 我们最直观的想法应该是在for循环外加上“`#pragma omp parallel for`"，但是让人失望的是这将无法通过编译。因为omp要求必须每个循环迭代都能得到处理，因此不允许直接退出循环，***这也就是说在循环中不能使用`return`、`break`、`goto`、`throw`等能够中断循环的语句***。为了能够提前退出循环，我们需要退出时，通知线程组的其他线程，让它们结束运行：
- > **延伸阅读**
