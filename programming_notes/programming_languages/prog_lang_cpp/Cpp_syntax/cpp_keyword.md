
关键字 (C++) https://docs.microsoft.com/zh-cn/cpp/cpp/keywords-cpp

# `nullptr`

nullptr, the pointer literal https://en.cppreference.com/w/cpp/language/nullptr

std::nullptr_t https://en.cppreference.com/w/cpp/types/nullptr_t

nullptr https://docs.microsoft.com/en-us/cpp/cpp/nullptr

Why isn't 'nullptr' in the 'std' namespace? https://stackoverflow.com/questions/21510121/why-isnt-nullptr-in-the-std-namespace
- > `nullptr` is a C++11 keyword (no different to `if`, `public`, `true`, `void`, etc.), so namespaces don't apply.
- > `nullptr` is a pointer literal the same way as for example `true` is a boolean literal. This literal has type `std::nullptr_t` that is as you see this type is defined in name space `std::`. The pointer literal is described in section 2.14.7 Pointer literals of the C++ Standard.

# `static_cast`

static_cast conversion https://en.cppreference.com/w/cpp/language/static_cast

static_cast in C++ | Type Casting operators https://www.geeksforgeeks.org/static_cast-in-c-type-casting-operators/

# `constexpr`

constexpr https://zh.wikipedia.org/wiki/Constexpr
- > **`constexpr`** 是C++11引入的关键字，用于编译时的常量与常量函数。
- > 声明为 `constexpr` 函数的意义是：如果其参数均为合适的编译期常量，则对这个 `constexpr函数` 的调用就可用于期望常量表达式的场合（如模板的非类型参数，或枚举（enum）常量的值）。如果参数的值在运行期才能确定，或者虽然参数的值是编译期常量，但不匹配这个函数的要求，则对这个函数调用的求值只能在运行期进行。
- > C++编译时可确定常量表达式的结果，因此可在编译时优化。C++规范在一些地方要求使用常量表达式，如声明数组的维数。但常量表达式不允许包含函数调用或者对象构造。因此下述代码无效：
  ```cpp
  int get_five() {return 5;}
  int some_value[get_five() + 7]; // 创建包含12个整数的数组. C++03中非法，因为get_five() + 7不是常量表达式
  ```
  > C++11引入了关键字`constexpr`，允许编程者保证函数或对象的构造函数是编译时常量。上述代码可以改写为：
  ```cpp
  constexpr int get_five() {return 5;}
  int some_value[get_five() + 7]; // Create an array of 12 integers. Valid C++11
  ```
