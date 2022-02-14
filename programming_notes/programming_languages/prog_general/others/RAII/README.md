
RAII https://zh.wikipedia.org/wiki/RAII

# RAII for C++

c++经验之谈一：RAII原理介绍 - allen的文章 - 知乎 https://zhuanlan.zhihu.com/p/34660259
- > 1.什么是RAII
  * > RAII（Resource Acquisition Is Initialization）是由c++之父Bjarne Stroustrup提出的，中文翻译为 ***`资源获取即初始化`***，他说：***使用`局部对象`来管理`资源`的技术称为`资源获取即初始化`；这里的`资源`主要是指操作系统中有限的东西如`内存、网络套接字`等等，`局部对象`是指存储在`栈`的对象，它的生命周期是由操作系统来管理的，无需人工介入***。
- > 2.RAII的原理
  * > 资源的使用一般经历三个步骤a.获取资源 b.使用资源 c.销毁资源，但是资源的销毁往往是程序员经常忘记的一个环节，所以程序界就想如何在程序员中让资源自动销毁呢？c++之父给出了解决问题的方案：RAII，它充分的利用了C++语言局部对象自动销毁的特性来控制资源的生命周期。给一个简单的例子来看下局部对象的自动销毁的特性：
- > **3.RAII的应用**
  * > 本节主要通过一个简单的例子来说明如何将RAII应用到我们的代码中。linux下经常会使用多线程技术，说到多线程，就得提到互斥锁，互斥锁主要用于互斥，互斥是一种竞争关系，用来保护临界资源一次只被一个线程访问，按照我们前面的分析，我们封装一下POSIX标准的互斥锁：
    ```cpp
    #include <pthread.h>
    #include <cstdlib>
    #include <stdio.h>
    
    class Mutex {
     public:
      Mutex();
      ~Mutex();
    
      void Lock();
      void Unlock(); 
    
     private:
      pthread_mutex_t mu_;

      // No copying
      Mutex(const Mutex&);
      void operator=(const Mutex&);
    };
    
    #include "mutex.h"
    
    static void PthreadCall(const char* label, int result) {
      if (result != 0) {
        fprintf(stderr, "pthread %s: %s\n", label, strerror(result));
      }
    }
    
    Mutex::Mutex() { PthreadCall("init mutex", pthread_mutex_init(&mu_, NULL)); }
    Mutex::~Mutex() { PthreadCall("destroy mutex", pthread_mutex_destroy(&mu_)); }
    void Mutex::Lock() { PthreadCall("lock", pthread_mutex_lock(&mu_)); }
    void Mutex::Unlock() { PthreadCall("unlock", pthread_mutex_unlock(&mu_)); }
    ```
    >> 【[:star:][`*`]】 //notes：这一个例子就足以说明 `RAII` 的实质了——在这个例子里的表现就是：用自己定义的 Mutex 类来管理 mutex 锁这种资源，可以达到类似**智能指针**或者**STL中的各种容器**的（***<ins>只管申请了用，不用考虑用完后手动释放</ins>***）的效果。
    >>> 更具体地说，每次通过申请新的 Mutex 对象来获得锁资源，在 Mutex 的构造函数里会调用 `pthread_mutex_init` 去获取真正的锁资源。随着程序结束，后面也不用再自己写（那些过去需要自己手动写的）释放锁资源的代码逻辑了，因为随着（操作系统管理的、栈上的） Mutex 生命周期结束，Mutex 对象会自动调用其析构函数 `~Mutex()`，在析构函数内部执行原始资源的释放逻辑，也就是 `pthread_mutex_destroy`。
    >>>> 所以不会有忘了释放的问题，但是可能有重复释放的问题？

RAII https://en.cppreference.com/w/cpp/language/raii

Object lifetime and resource management (RAII) https://docs.microsoft.com/en-us/cpp/cpp/object-lifetime-and-resource-management-modern-cpp

# RAII for Rust

15.1 RAII https://doc.rust-lang.org/rust-by-example/scope/raii.html
