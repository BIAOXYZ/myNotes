
# `std::size_t`

https://en.cppreference.com/w/cpp/types/size_t
```cpp
#include <cstddef>
#include <iostream>
#include <array>
 
int main()
{
    std::array<std::size_t,10> a;
    std::size_t i{};
 
    for (i = 0; i != a.size(); ++i)
        std::cout << (a[i] = i) << ' ';
    std::cout << "│ i = " << i << '\n';
 
    for (i = a.size()-1; i < a.size(); --i)
        std::cout << a[i] << ' ';
    std::cout << "│ i = " << i << '\n';
}
//////////////////////////////////////////////////
0 1 2 3 4 5 6 7 8 9 │ i = 10
9 8 7 6 5 4 3 2 1 0 │ i = 18446744073709551615
```

# 其他

C语言中size_t的陷阱 https://blog.csdn.net/shisiye15/article/details/7846833
- > 今天写了一个类似这样的程序：
  ```cpp
  #include <stdio.h>
  #include <string.h>
  int main()
  {
      int i = -1;
      if(i > strlen("Demon"))
          printf("Hello World");
      else
          printf("Hello Demon");
      return 0;
  }
  ```
- > 输出的竟然是Hello World！**`-1 > 5`** ？！
- > 仔细想想，原来问题出在 `strlen` 上，`strlen` 返回的类型是 `size_t`，`size_t` 的定义为：
  ```cpp
  typedef unsigned int size_t;
  ```
- > 即无符号的整型，而i的类型是 `int`，即有符号的整型。当有符号整型和无符号整型进行运算时，有符号整型会先自动转化成无符号。`-1` 转化成无符号数为 `4294967295`，远远大于5。

should use size_t or ssize_t [duplicate] https://stackoverflow.com/questions/15739490/should-use-size-t-or-ssize-t
