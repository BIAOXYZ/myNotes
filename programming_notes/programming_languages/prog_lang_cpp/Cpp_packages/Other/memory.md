
# 官方

`header <memory>` http://www.cplusplus.com/reference/memory/
- **Managed pointers**
  * std::shared_ptr http://www.cplusplus.com/reference/memory/shared_ptr/
  * std::unique_ptr https://www.cplusplus.com/reference/memory/unique_ptr/
- **Functions and classes related to shared_ptr:**
  * std::make_shared http://www.cplusplus.com/reference/memory/make_shared/

Dynamic memory management https://en.cppreference.com/w/cpp/memory
- **Smart pointers**
  * std::unique_ptr https://en.cppreference.com/w/cpp/memory/unique_ptr
  * std::shared_ptr https://en.cppreference.com/w/cpp/memory/shared_ptr
    + **Member functions**
      - `std::shared_ptr<T>::get` https://en.cppreference.com/w/cpp/memory/shared_ptr/get
    + **Non-member functions**
      - std::make_shared https://en.cppreference.com/w/cpp/memory/shared_ptr/make_shared

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `unique_ptr` 

如何：创建和使用 unique_ptr 实例 https://docs.microsoft.com/zh-cn/cpp/cpp/how-to-create-and-use-unique-ptr-instances

为何优先选用unique_ptr而不是裸指针？ - 守望的文章 - 知乎 https://zhuanlan.zhihu.com/p/91328039

C++11智能指针（六）：unique_ptr介绍与例子 https://blog.csdn.net/lijinqi1987/article/details/79005794

# 其他

What is a smart pointer and when should I use one? https://stackoverflow.com/questions/106508/what-is-a-smart-pointer-and-when-should-i-use-one

Difference in make_shared and normal shared_ptr in C++ https://stackoverflow.com/questions/20895648/difference-in-make-shared-and-normal-shared-ptr-in-c

C++11 make_shared https://www.jianshu.com/p/03eea8262c11

搞定技术面试：C++ 11 智能指针详解 https://juejin.cn/post/6844903993055920141

# 已阅

C++ 教程 | C11 智能指针 https://aiden-dong.github.io/2020/01/26/cpp%E6%99%BA%E8%83%BD%E6%8C%87%E9%92%88/
- > 对于编译器来说，***智能指针实际上是一个栈对象，并非指针类型***，在栈对象生命期即将结束时，智能指针通过析构函数释放有它管理的堆内存。***所有智能指针都重载了 `operator->` 操作符，直接返回对象的引用，用以操作对象。访问智能指针原来的方法则使用 `.` 操作符***。
- > 访问智能指针包含的裸指针则可以用 `get()` 函数。由于智能指针是一个对象，所以 `if (my_smart_object)` 永远为真，要判断智能指针的裸指针是否为空，需要这样判断：`if (my_smart_object.get())`。
- > 智能指针包含了 `reset()` 方法，如果不传递参数（或者传递 NULL），则智能指针会释放当前管理的内存。如果传递一个对象，则智能指针会释放当前对象，来管理新传入的对象。
- > **`auto_ptr`**
  * > `std::auto_ptr` 属于 STL，当然在 `namespace std` 中，包含头文件 `#include<memory>` 便可以使用。`std::auto_ptr` 能够方便的管理单个堆内存对象。
  * > 所以，**使用 `std::auto_ptr` 时，绝对不能使用“`operator=`”操作符**。作为一个库，不允许用户使用，确没有明确拒绝，多少会觉得有点出乎预料。

C++ 智能指针的正确使用方式 https://www.cyhone.com/articles/right-way-to-use-cpp-smart-pointer/

C++中的智能指针（1）：shared_ptr 的介绍和用法 https://blog.csdn.net/thinkerleo1997/article/details/78754919
