
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

# `shared_ptr`

C++11 shared_ptr智能指针（超级详细） http://c.biancheng.net/view/7898.html
- > 2、`shared_ptr<T>` 模板类提供的成员方法
  * > 为了方便用户使用 shared_ptr 智能指针，shared_ptr<T> 模板类还提供有一些实用的成员方法，它们各自的功能如表 1 所示。
- > 下面程序给大家演示了 shared_ptr 智能指针的基本用法，以及该模板类提供了一些成员方法的用法：
  ```cpp
  #include <iostream>
  #include <memory>
  using namespace std;
  int main()
  {
      //构建 2 个智能指针
      std::shared_ptr<int> p1(new int(10));
      std::shared_ptr<int> p2(p1);
      //输出 p2 指向的数据
      cout << *p2 << endl;
      p1.reset();//引用计数减 1,p1为空指针
      if (p1) {
          cout << "p1 不为空" << endl;
      }
      else {
          cout << "p1 为空" << endl;
      }
      //以上操作，并不会影响 p2
      cout << *p2 << endl;
      //判断当前和 p2 同指向的智能指针有多少个
      cout << p2.use_count() << endl;
      return 0;
  }
  //////////////////////////////////////////////////
  10
  p1 为空
  10
  1
  ```

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

C++ 智能指针的正确使用方式 https://www.cyhone.com/articles/right-way-to-use-cpp-smart-pointer/

C++中的智能指针（1）：shared_ptr 的介绍和用法 https://blog.csdn.net/thinkerleo1997/article/details/78754919
