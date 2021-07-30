
# 官方

`header <utility>` http://www.cplusplus.com/reference/utility/
- **Functions**
  * std::forward http://www.cplusplus.com/reference/utility/forward/
  * std::move http://www.cplusplus.com/reference/utility/move/
    + > Generally, ***<ins>`rvalues` are values whose address cannot be obtained by dereferencing them</ins>***, either because they are literals or because they are temporary in nature (such as values returned by functions or explicit constructor calls). By passing an object to this function, an rvalue that refers to it is obtained.
    + > Many components of the standard library implement ***move semantics***, allowing to transfer ownership of the assets and properties of an object directly without having to copy them when the argument is an `rvalue`.
    + > Although note that -in the standard library- moving implies that the moved-from object is left in a valid but unspecified state. Which means that, after such an operation, the value of the moved-from object should only be destroyed or assigned a new value; accessing it otherwise yields an unspecified value.
- **Types**
  * std::pair https://www.cplusplus.com/reference/utility/pair/ 【这个不应该实现在 `<unordered_map>` 里才更适合嘛？】

`Standard library header <utility>` https://en.cppreference.com/w/cpp/header/utility
- **Swap and type operations**
  * std::forward https://en.cppreference.com/w/cpp/utility/forward
  * std::move https://en.cppreference.com/w/cpp/utility/move

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

## 其他 `std::move()` 帖子

std::move in C++ https://www.geeksforgeeks.org/stdmove-in-c/
- > Moves the elements in the range [first,last] into the range beginning at result.
- > The value of the elements in the [first,last] is transferred to the elements pointed by result. After the call, the elements in the range [first,last] are left in an unspecified but valid state.

How does std::move() transfer values into RValues? https://stackoverflow.com/questions/7510182/how-does-stdmove-transfer-values-into-rvalues

C++右值引用（std::move） - niediao的文章 - 知乎 https://zhuanlan.zhihu.com/p/94588204

std:move基本用法和理解 https://blog.csdn.net/swartz_lubel/article/details/59620868
- > **例子2**
  * > 自定义自己的类对象支持moved from 操作,需要实现 Move Constructors and Move Assignment Operators

# `std::forward`

Quick Q: What's the difference between std::move and std::forward? https://isocpp.org/blog/2018/02/quick-q-whats-the-difference-between-stdmove-and-stdforward

C++11 std::move和std::forward https://www.jianshu.com/p/b90d1091a4ff
- > 下文先从C++11引入的几个规则，如引用折叠、右值引用的特殊类型推断规则、`static_cast` 的扩展功能说起，然后通过例子解析 `std::move` 和 `std::forward` 的推导解析过程，说明 `std::move` 和 `std::forward` 本质就是一个转换函数，`std::move` 执行到右值的无条件转换，`std::forward` 执行到右值的有条件转换，在参数都是右值时，二者就是等价的。其实 `std::move` 和 `std::forward` 就是在C++11基本规则之上封装的语法糖。
- > **4 `std::move()` 和 `std::forward()` 对比**
  * > `std::move` 执行到右值的无条件转换。就其本身而言，它没有move任何东西。
  * > `std::forward` 只有在它的参数绑定到一个右值上的时候，它才转换它的参数到一个右值。
  * > `std::move` 和 `std::forward` 只不过就是执行类型转换的两个函数；`std::move` 没有move任何东西，`std::forward` 没有转发任何东西。在运行期，它们没有做任何事情。它们没有产生需要执行的代码，一byte都没有。
  * > `std::forward<T>()` 不仅可以保持左值或者右值不变，同时还可以保持 `const`、`Lreference`、`Rreference`、`validate`等属性不变。

C++11朝码夕解: move和forward - minmin的文章 - 知乎 https://zhuanlan.zhihu.com/p/55856487
- > 太长不看细节: TL;DR:
  * > (1) 问题: 临时变量copy开销太大
  * > (2) 引入: rvalue, lvalue, rvalue reference概念
  * > (3) 方法: rvalue reference传临时变量, move语义避免copy
  * > (4) 优化: forward同时能处理rvalue/lvalue reference和const reference

浅谈std::move和std::forward原理 https://blog.csdn.net/qq_33850438/article/details/107193177
