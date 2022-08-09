
# `std::move()`

https://en.cppreference.com/w/cpp/utility/move
```cpp
#include <iomanip>
#include <iostream>
#include <utility>
#include <vector>
#include <string>
 
int main()
{
    std::string str = "Salut";
    std::vector<std::string> v;
 
    // uses the push_back(const T&) overload, which means 
    // we'll incur the cost of copying str
    v.push_back(str);
    std::cout << "After copy, str is " << std::quoted(str) << '\n';
 
    // uses the rvalue reference push_back(T&&) overload, 
    // which means no strings will be copied; instead, the contents
    // of str will be moved into the vector.  This is less
    // expensive, but also means str might now be empty.
    v.push_back(std::move(str));
    std::cout << "After move, str is " << quoted(str) << '\n';
 
    std::cout << "The contents of the vector are { " << quoted(v[0])
                                             << ", " << quoted(v[1]) << " }\n";
}
//////////////////////////////////////////////////
After copy, str is "Salut"
After move, str is ""
The contents of the vector are { "Salut", "Salut" }
```

http://www.cplusplus.com/reference/utility/move/
```cpp
// move example
#include <utility>      // std::move
#include <iostream>     // std::cout
#include <vector>       // std::vector
#include <string>       // std::string

int main () {
  std::string foo = "foo-string";
  std::string bar = "bar-string";
  std::vector<std::string> myvector;

  myvector.push_back (foo);                    // copies
  myvector.push_back (std::move(bar));         // moves

  std::cout << "myvector contains:";
  for (std::string& x:myvector) std::cout << ' ' << x;
  std::cout << '\n';

  return 0;
}
//////////////////////////////////////////////////
myvector contains: foo-string bar-string
```
> The first call to `myvector.push_back` copies the value of `foo` into the vector (`foo` keeps the value it had before the call).
>
> The second call moves the value of `bar` into the vector. This transfers its content into the vector (while `bar` loses its value, and now is ***in a valid but unspecified state***).

# 其他 `std::move()` 帖子

std::move in C++ https://www.geeksforgeeks.org/stdmove-in-c/
- > Moves the elements in the range [first,last] into the range beginning at result.
- > The value of the elements in the [first,last] is transferred to the elements pointed by result. After the call, the elements in the range [first,last] are left in an unspecified but valid state.

How does std::move() transfer values into RValues? https://stackoverflow.com/questions/7510182/how-does-stdmove-transfer-values-into-rvalues

C++右值引用（std::move） - niediao的文章 - 知乎 https://zhuanlan.zhihu.com/p/94588204

std:move基本用法和理解 https://blog.csdn.net/swartz_lubel/article/details/59620868
- > **例子2**
  * > 自定义自己的类对象支持moved from 操作,需要实现 Move Constructors and Move Assignment Operators

第14课 移动语义(std::move) https://www.cnblogs.com/5iedu/p/11318729.html

## 函数返回值不需要move

c++11：函数内部返回对象使用move语义 https://blog.csdn.net/zzhongcy/article/details/86703619
- > 一句话，直接返回即可，一般不用任何特殊写法。

C++函数返回值拷贝问题？ - 知乎 https://www.zhihu.com/question/29511959
