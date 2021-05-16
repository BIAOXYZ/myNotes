
# 官方

std::thread http://www.cplusplus.com/reference/thread/thread/
- `std::thread::joinable` http://www.cplusplus.com/reference/thread/thread/joinable/

std::thread https://en.cppreference.com/w/cpp/thread/thread

# wiki类

C++/STL/Thread https://zh.wikibooks.org/zh-hans/C%2B%2B/STL/Thread

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
