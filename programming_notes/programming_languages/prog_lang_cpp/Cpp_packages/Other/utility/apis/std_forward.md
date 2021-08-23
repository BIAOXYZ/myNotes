
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
