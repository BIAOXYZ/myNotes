
# 官方

std::thread http://www.cplusplus.com/reference/thread/thread/
- > **Member functions**
  * `std::thread::joinable` http://www.cplusplus.com/reference/thread/thread/joinable/
  * `std::thread::join` https://www.cplusplus.com/reference/thread/thread/join/
  * `std::thread::hardware_concurrency` https://cplusplus.com/reference/thread/thread/hardware_concurrency/

std::thread https://en.cppreference.com/w/cpp/thread/thread
- > **Observers**
  * `std::thread::hardware_concurrency` https://en.cppreference.com/w/cpp/thread/thread/hardware_concurrency

# wiki类

C++/STL/Thread https://zh.wikibooks.org/zh-hans/C%2B%2B/STL/Thread

# 较系统攻略

c++11 多线程（1） thread 总结 https://www.jianshu.com/p/81f0b071b3e0
- > 本文主要是针对C++中多线程并发操作参见([cplusplus]())进行解释，文章从下面几个方面进行学习，分别介绍多线程中会使用到的几个文件学习。 文中代码 可编译运行版本已上传在本人github([地址](https://github.com/jorionwen/threadtest))
  >> threadtest https://github.com/jorionwen/threadtest

c++11多线程编程 https://blog.csdn.net/lijinqi1987/category_9271083.html

# 其他

C++ std::thread https://www.runoob.com/w3cnote/cpp-std-thread.html

C++11 并发指南二(std::thread 详解) https://www.cnblogs.com/haippy/p/3236136.html

Multithreading in C++ https://www.geeksforgeeks.org/multithreading-in-cpp/
- > Once a thread has started we may need to wait for the thread to finish before we can take some action. For instance, if we allocate the task of initializing the GUI of an application to a thread, we need to wait for the thread to finish to ensure that the GUI has loaded properly.
- > To wait for a thread use the `std::thread::join()` function. This function ***makes the current thread wait*** until the thread identified by `*this` has finished executing.
- > For instance, to block the `main` thread until thread `t1` has finished we would do
  ```cpp
  int main() 
  { 
      // Start thread t1 
      std::thread t1(callable); 
  
      // Wait for t1 to finish 
      t1.join(); 
  
      // t1 has finished do other stuff 
  
      ... 
  } 
  ```

C++ 多线程 - 李尧的文章 - 知乎 https://zhuanlan.zhihu.com/p/348492524

程序员的自我修养（五）：C++ 多线程编程初步 https://liam.page/2017/05/16/first-step-on-multithread-programming-of-cxx/
- > 这是[系列文章](https://liam.page/series/)的第五篇。这篇文章里，我们介绍如何使用 C++ 11 的标准库，进行多线程编程。
- > **以非静态成员函数为线程函数**

# 问题解决

Emplace back thread on vector https://stackoverflow.com/questions/39266461/emplace-back-thread-on-vector
