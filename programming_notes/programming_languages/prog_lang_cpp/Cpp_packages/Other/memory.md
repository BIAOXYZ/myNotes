
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

# `unique_ptr` 

如何：创建和使用 unique_ptr 实例 https://docs.microsoft.com/zh-cn/cpp/cpp/how-to-create-and-use-unique-ptr-instances

为何优先选用unique_ptr而不是裸指针？ - 守望的文章 - 知乎 https://zhuanlan.zhihu.com/p/91328039

C++11智能指针（六）：unique_ptr介绍与例子 https://blog.csdn.net/lijinqi1987/article/details/79005794

# 其他

Difference in make_shared and normal shared_ptr in C++ https://stackoverflow.com/questions/20895648/difference-in-make-shared-and-normal-shared-ptr-in-c

C++11 make_shared https://www.jianshu.com/p/03eea8262c11

搞定技术面试：C++ 11 智能指针详解 https://juejin.cn/post/6844903993055920141

# 已阅

C++中的智能指针（1）：shared_ptr 的介绍和用法 https://blog.csdn.net/thinkerleo1997/article/details/78754919
