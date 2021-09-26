
# `operator`

C++ operator关键字（重载操作符） https://blog.csdn.net/My_heart_/article/details/51534624

# `= delete`

C++11 =default 和 =delete https://www.jianshu.com/p/ef66ba66916c

C++类的特殊成员函数及default/delete特性 - LitoNeo的文章 - 知乎 https://zhuanlan.zhihu.com/p/77806109
- > **3.C++11特性之default/delete**
  * > 在未显式的定义类的特殊成员函数时，如果被调用，系统会自动隐式的创建该特殊成员函数，且隐式的创建方式比显式的创建方式执行效率高。
  * > 只需在函数声明后加上 `=default;`，就可将该函数声明为 defaulted 函数，编译器将为显式声明的 defaulted 函数自动生成函数体，以获得更高的执行效率。
  * > 有些时候，我们需要禁用某些函数(`=delete` 不仅可以禁用类内的特殊成员函数，也可以禁用一般函数)，此时就需要在该函数后面增加 `=delete；`，则该函数将变的不可调用，比如不可复制等。
