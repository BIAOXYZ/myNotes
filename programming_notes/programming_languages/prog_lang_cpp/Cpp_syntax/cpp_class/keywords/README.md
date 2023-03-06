
# `operator`

C++运算符重载详解 https://juejin.cn/post/6844903566608433160
- > C++语言的一个很有意思的特性就是除了支持函数重载外还支持运算符重载，原因就是在C++看来运算符也算是一种函数。比如一个 `a + b` 的加法表达式也可以用函数的形式：`operator + (a, b)` 来表达。这里的 `operator +` 代表的就是加法函数。高级语言中的表达式和数学表达式非常相似，在一定的程度上通过运算符来描述表达式会比通过函数来描述表达式更加利于理解和阅读。一般情况下在重载某个运算符的实现时最好要和运算符本身的数学表示意义相似，当然你也可以完全实现一个和运算符本身意义无关的功能或者相反的功能(比如对某个+运算符实现为相减)。运算符函数和类的成员函数以及普通函数一样，同样可分为类运算符和普通运算符。要定义一个运算符函数总是按如下的格式来定义和申明:
  ```console
  返回类型 operator 运算符(参数类型1 [,参数类型2] [,参数类型3] [, 参数类型N]);
  ```
- > 运算符重载需要在运算符前面加上关键字 **`operator`**。一般情况下参数的个数不会超过2个，因为运算符大多只是一元或者二元运算，而只有`函数运算符()`以及`new`和`delete`这三个运算符才支持超过2个参数的情况。
- > **可重载的运算符的种类**
  * > 并不是所有C++中的运算符都可以支持重载，我们也不能创建一个新的运算符出来(比如Σ)。有的运算符只能作为类成员函数被重载，而有的运算符则只能当做普通函数来使用。
    + > 不能被重载的运算符有：`. .* :: ?: sizeof`
    + > 只能作为类成员函数重载的运算符有：`() [] -> =`
  * > 下面我将会对各种运算符重载的方法进行详细的介绍。**同时为了更加表现通用性，我这边对参数类型的定义都采用模板的形式，并给出运算符的一些大体实现的逻辑。实际中进行重载时则需要根据具体的类型来进行定义和声明**。

C++ operator关键字（重载操作符） https://blog.csdn.net/My_heart_/article/details/51534624
- > 二、如何声明一个重载的操作符？
  * > A:操作符重载实现为类成员函数
  * > B:操作符重载实现为非类成员函数(全局函数)

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `= delete`

C++11 =default 和 =delete https://www.jianshu.com/p/ef66ba66916c

C++类的特殊成员函数及default/delete特性 - LitoNeo的文章 - 知乎 https://zhuanlan.zhihu.com/p/77806109
- > **3.C++11特性之default/delete**
  * > 在未显式的定义类的特殊成员函数时，如果被调用，系统会自动隐式的创建该特殊成员函数，且隐式的创建方式比显式的创建方式执行效率高。
  * > 只需在函数声明后加上 `=default;`，就可将该函数声明为 defaulted 函数，编译器将为显式声明的 defaulted 函数自动生成函数体，以获得更高的执行效率。
  * > 有些时候，我们需要禁用某些函数(`=delete` 不仅可以禁用类内的特殊成员函数，也可以禁用一般函数)，此时就需要在该函数后面增加 `=delete；`，则该函数将变的不可调用，比如不可复制等。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `explicit`关键字

【[:star:][`*`]】 c++ explicit 关键字 https://www.jianshu.com/p/af8034ec0e7a
- > `explicit`的作用是用来声明类构造函数是显示调用的，而非隐式调用，所以只用于修饰单参构造函数。***因为无参构造函数和多参构造函数本身就是显示调用的。再加上`explicit`关键字也没有什么意义***。
- > `explicit`关键字的官方解释：`This keyword is a declaration specifier that can only be applied to in-class constructor declarations . An explicit constructor cannot take part in implicit conversions. It can only be used to explicitly construct an object 。`
- > 从上面的解释可以看出 `explicit` 的主要作用是：
  * > **只能用来修饰类构造函数**
  * > **`explicit`修饰的构造函数不能被隐式调用**
  * > **禁止类对象之间的隐式转换**
- > 举例如下：
  ```cpp
  #include<cstring>
  #include<string>
  #include<iostream>
  class Explicit
  {
      private:
      public:
          Explicit(int size)
          {
              std::cout << " the size is " << size << std::endl;
          }
          Explicit(const char* str)
          {
              std::string _str = str;
              std::cout << " the str is " << _str << std::endl;
          }

          Explicit(const Explicit& ins)
          {
              std::cout << " The Explicit is ins" << std::endl;
          }

          Explicit(int a,int b)
          {
              std::cout << " the a is " << a  << " the b is " << b << std::endl;
          }
  };
  int main()
  {
      Explicit test0(15);
      Explicit test1 = 10;// 隐式调用Explicit(int size)

      Explicit test2("RIGHTRIGHT");
      Explicit test3 = "BUGBUGBUG";// 隐式调用Explicit(const char* str)

      Explicit test4(1, 10);
      Explicit test5 = test1;
  }
  ```
- > 上面的程序虽然没有错误，但是对于 `Explicit test1 = 10;` 和 `Explicit test3 = "BUGBUGBUG";` 这样的句子，把一个 `int` 类型或者 `const char*` 类型的变量赋值给 `Explicit` 类型的变量看起来总归不是很好，并且当程序很大的时候出错之后也不容易排查。所以 ***为了禁止上面那种隐式转换可能带来的风险，一般都把`类的单参构造函数`声明的显示调用的***，就是在构造函数加关键字 `explicit`。如下：
  ```cpp
  #include<cstring>
  #include<string>
  #include<iostream>
  class Explicit
  {
      private:
      public:
          explicit Explicit(int size)
          {
              std::cout << " the size is " << size << std::endl;
          }
          explicit Explicit(const char* str)
          {
              std::string _str = str;
              std::cout << " the str is " << _str << std::endl;
          }

          Explicit(const Explicit& ins)
          {
              std::cout << " The Explicit is ins" << std::endl;
          }

          Explicit(int a,int b)
          {
              std::cout << " the a is " << a  << " the b is " << b << std::endl;
          }
  };
  int main()
  {
      Explicit test0(15);
      Explicit test1 = 10;// 无法调用

      Explicit test2("RIGHTRIGHT");
      Explicit test3 = "BUGBUGBUG"; // 无法调用

      Explicit test4(1, 10);
      Explicit test5 = test0;
  }
  ```
- > 上面再写 `Explicit test1=10; Explicit test3 = "BUGBUGBUG";` 这样的句子的时候程序就会报如下错误：
  ```console
  error: conversion from ‘int’ to non-scalar type ‘Explicit’ requested
  error: conversion from ‘const char [10]’ to non-scalar type ‘Explicit’ requested
  ```

What does the explicit keyword mean? https://stackoverflow.com/questions/121162/what-does-the-explicit-keyword-mean

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
