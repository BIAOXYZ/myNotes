
# 官方

模板 (C++) https://zh.wikipedia.org/wiki/%E6%A8%A1%E6%9D%BF_(C%2B%2B)

模板 (C++) https://docs.microsoft.com/zh-cn/cpp/cpp/templates-cpp

Templates https://en.cppreference.com/w/cpp/language/templates

Templates https://cplusplus.com/doc/oldtutorial/templates/

# 系统性攻略

# 问题

Why can templates only be implemented in the header file? https://stackoverflow.com/questions/495021/why-can-templates-only-be-implemented-in-the-header-file

C++: 模板函数定义与声明分离； https://www.shuzhiduo.com/A/E35pgjogJv/ || https://www.cnblogs.com/yinwei-space/p/10609049.html

# 实战攻略

C++ 模板 https://www.runoob.com/cplusplus/cpp-templates.html
```cpp
#include <iostream>
#include <vector>
#include <cstdlib>
#include <string>
#include <stdexcept>
using namespace std;

template <class T>
class Stack { 
  private: 
    vector<T> elems;     // 元素 
 
  public: 
    void push(T const&);  // 入栈
    void pop();               // 出栈
    T top() const;            // 返回栈顶元素
    bool empty() const{       // 如果为空则返回真。
        return elems.empty(); 
    } 
}; 
 
template <class T>
void Stack<T>::push (T const& elem) 
{ 
    // 追加传入元素的副本
    elems.push_back(elem);    
} 
 
template <class T>
void Stack<T>::pop () 
{ 
    if (elems.empty()) { 
        throw out_of_range("Stack<>::pop(): empty stack"); 
    }
    // 删除最后一个元素
    elems.pop_back();         
} 
 
template <class T>
T Stack<T>::top () const 
{ 
    if (elems.empty()) { 
        throw out_of_range("Stack<>::top(): empty stack"); 
    }
    // 返回最后一个元素的副本 
    return elems.back();      
} 
 
int main() 
{ 
    try { 
        Stack<int>    intStack;  // int 类型的栈 
        Stack<string> stringStack;    // string 类型的栈 
 
        // 操作 int 类型的栈 
        intStack.push(7); 
        cout << intStack.top() <<endl; 
 
        // 操作 string 类型的栈 
        stringStack.push("hello"); 
        cout << stringStack.top() << std::endl; 
        stringStack.pop(); 
        stringStack.pop(); 
    } 
    catch (exception const& ex) { 
        cerr << "Exception: " << ex.what() <<endl; 
        return -1;
    } 
}
//////////////////////////////////////////////////
 clang++-7 -pthread -std=c++17 -o main main.cpp
 ./main
7
hello
Exception: Stack<>::pop(): empty stack
exit status 255
 
```
//notes：这个例子除了是模板的例子外，还是一个异常的例子（`throw-try-catch`），可以很久不写手生的时候看一下。

# 其他攻略

【from Programiz】:
- C++ Function Template https://www.programiz.com/cpp-programming/function-template
- C++ Class Templates https://www.programiz.com/cpp-programming/class-templates

C++ 模板详解 https://www.runoob.com/w3cnote/c-templates-detail.html

C++类模板，你看我就够了 https://www.jianshu.com/p/70ca94872418

C++ Template 基础篇（一）：函数模板 https://blog.csdn.net/lezardfu/article/details/56852043

C++ 模板常见特性（函数模板、类模板） - 小林coding的文章 - 知乎 https://zhuanlan.zhihu.com/p/101898043 || https://juejin.cn/post/6844904041328148493
