
# 主页

C++ 语言文档 https://docs.microsoft.com/zh-cn/cpp/cpp/ || C++ language documentation https://docs.microsoft.com/en-us/cpp/cpp/

# `声明和定义`

## 别名和 typedef (C++)

https://docs.microsoft.com/zh-cn/cpp/cpp/aliases-and-typedefs-cpp
- > 在 `typedef` 很大程度上支持使用具有类类型的说明符，因为在声明中声明未命名的结构存在 ANSI C 的做法 `typedef` 。 例如，许多 C 程序员都使用：
  ```c
  // typedef_with_class_types1.cpp
  // compile with: /c
  typedef struct {   // Declare an unnamed structure and give it the typedef name POINT.
     unsigned x;
     unsigned y;
  } POINT;
  ```
  > 此类声明的优点是它允许如下声明：
  ```c
  POINT ptOrigin;
  ```

# `内置运算符、优先级和关联性`

## C + + 内置运算符、优先级和结合性

C + + 内置运算符、优先级和结合性 https://docs.microsoft.com/zh-cn/cpp/cpp/cpp-built-in-operators-precedence-and-associativity

C++ 运算符优先级 https://zh.cppreference.com/w/cpp/language/operator_precedence

C和C++运算符 https://zh.wikipedia.org/wiki/C%E5%92%8CC%2B%2B%E9%81%8B%E7%AE%97%E5%AD%90

## 作用域解析运算符： `::`

https://docs.microsoft.com/zh-cn/cpp/cpp/scope-resolution-operator
- > 没有范围限定符的范围解析运算符表示全局命名空间。

# 待分类

decltype (C++) https://docs.microsoft.com/en-us/cpp/cpp/decltype-cpp
