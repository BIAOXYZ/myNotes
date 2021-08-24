
# 1

使用 gdb 调试 C++ 多线程程序 http://senlinzhan.github.io/2018/01/01/gdb-on-multithreaded/
- > 分析死锁问题是比较简单的，因为当发生死锁时，进程会僵住，这时我们只需要杀死进程，让系统产生一个 core dump 文件，然后再对这个 core dump 文件进行分析即可。至于如何才能在 Linux 生成 core dump 文件，可以参见[这篇文章](http://senlinzhan.github.io/2017/12/31/coredump/)。
- > 下面的 C++ 程序，有可能出现两个线程都在等待对方释放互斥锁，从而导致死锁：
  ```cpp
  #include <iostream>
  #include <thread>
  #include <mutex>
  std::mutex m1, m2;
  void foo()
  {
      std::lock_guard<std::mutex> g1(m1);
      std::lock_guard<std::mutex> g2(m2);
      std::cout << "I'm foo!" << std::endl;
  }
  void bar()
  {
      std::lock_guard<std::mutex> g1(m2);
      std::lock_guard<std::mutex> g2(m1);
      std::cout << "I'm bar!" << std::endl;
  }
  int main()
  {
      std::thread t1(foo);
      std::thread t2(bar);
      t1.join();
      t2.join();
      return 0;
  }
  ```
- > 编译好这个程序，并运行：
  ```sh
  $ g++ -std=c++11 -g -o main main.cpp -lpthread
  $ while true ; do
  > ./main 
  > done &
  ```
- > 查看发生死锁的进程 ID，杀死这个进程，让系统生成它的 core dump 文件：
  ```sh
  $ ps aux | grep main
  ubuntu    4184  0.0  0.1  31844  1792 pts/0    Sl   03:01   0:00 ./main
  $ kill -s SIGSEGV 4184
  $ ls /var/crash
  !home!ubuntu!main.4184.1514790137.11
  ```
- > 可以看到，系统生成了core dump 文件，放在了/var/crash目录下，这样就可以使用 gdb 进行分析：
  ```sh
  $ gdb ./main /var/crash/\!home\!ubuntu\!main.4184.1514790137.11
  ```
- > 查看进程有哪些线程正在执行：
  ```console
  (gdb) info threads
    Id   Target Id         Frame
  * 1    Thread 0x7f109b2e4740 (LWP 4184) 0x00007f109aebd9dd in pthread_join (
      threadid=139709282297600, thread_return=0x0) at pthread_join.c:90
    2    Thread 0x7f1099a49700 (LWP 4186) __lll_lock_wait ()
      at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
    3    Thread 0x7f109a24a700 (LWP 4185) __lll_lock_wait ()
      at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
  ```
- > 可以看到，线程 2 和线程 3 正在等待互斥锁，可以查看线程 2 的信息：
  ```console
  (gdb) thread 2
  [Switching to thread 2 (Thread 0x7f1099a49700 (LWP 4186))]
  #0  __lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
  ```
- > 打印线程 2 的堆栈信息，可以看到是哪一行代码正在尝试获取锁：
  ```console
  (gdb) backtrace
  #0  __lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
  #1  0x00007f109aebee0d in __GI___pthread_mutex_lock (mutex=0x6052e0 <m1>)
      at ../nptl/pthread_mutex_lock.c:80
  #2  0x0000000000401007 in __gthread_mutex_lock (__mutex=0x6052e0 <m1>)
      at /usr/include/x86_64-linux-gnu/c++/5/bits/gthr-default.h:748
  #3  0x0000000000401536 in std::mutex::lock (this=0x6052e0 <m1>)
      at /usr/include/c++/5/mutex:135
  #4  0x00000000004015bc in std::lock_guard<std::mutex>::lock_guard (
      this=0x7f1099a48e50, __m=...) at /usr/include/c++/5/mutex:386
  #5  0x00000000004011b7 in bar () at main.cpp:18
  #6  0x000000000040289f in std::_Bind_simple<void (*())()>::_M_invoke<>(std::_Index_tuple<>) (this=0x153bdb8) at /usr/include/c++/5/functional:1531
  #7  0x00000000004027f8 in std::_Bind_simple<void (*())()>::operator()() (
      this=0x153bdb8) at /usr/include/c++/5/functional:1520
  #8  0x0000000000402788 in std::thread::_Impl<std::_Bind_simple<void (*())()> >::_M_run() (this=0x153bda0) at /usr/include/c++/5/thread:115
  #9  0x00007f109abebc80 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
  #10 0x00007f109aebc70a in start_thread (arg=0x7f1099a49700) at pthread_create.c:333
  #11 0x00007f109a65a82d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
  ```
- > 从上面的输出可以发现，线程 2 在`main.cpp`的第 18 行的位置等待互斥锁。
- > 参考资料

## 个人实战部分
