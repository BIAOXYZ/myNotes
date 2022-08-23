
# general

Classes https://en.cppreference.com/w/cpp/language/classes

Classes (I) http://www.cplusplus.com/doc/tutorial/classes/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 继承

C++ 继承 https://www.runoob.com/cplusplus/cpp-inheritance.html
- > **继承类型**
  * > 当一个类派生自基类，该基类可以被继承为 `public`、`protected` 或 `private` 几种类型。继承类型是通过上面讲解的访问修饰符 access-specifier 来指定的。
  * > ***我们几乎不使用 `protected` 或 `private` 继承，通常使用 `public` 继承***。当使用不同类型的继承时，遵循以下几个规则：
    + > **公有继承（`public`）**：当一个类派生自公有基类时，基类的公有成员也是派生类的公有成员，基类的保护成员也是派生类的保护成员，基类的私有成员不能直接被派生类访问，但是可以通过调用基类的公有和保护成员来访问。
    + > **保护继承（`protected`）**： 当一个类派生自保护基类时，基类的公有和保护成员将成为派生类的保护成员。
    + > **私有继承（`private`）**：当一个类派生自私有基类时，基类的公有和保护成员将成为派生类的私有成员。

Difference between private, public, and protected inheritance https://stackoverflow.com/questions/860339/difference-between-private-public-and-protected-inheritance

C++中public、protected、private继承的区别 https://blog.csdn.net/qq583083658/article/details/80740299
- > 首先记住以下三点：
  * > 用户代码（类外）只能访问public成员变量和public成员函数。
  * > 子类（继承类）能访问基类的public和protected成员（包括变量和函数），但不能访问基类的private成员（包括变量和函数），本质原因不是基类的private变量不能被继承，而是基类的private成员不能被子类直接访问。但可以通过在基类中增加一个public函数用来返回基类的private成员，再在子类用调用该public函数来访问基类的private成员。
  * > private成员只能被类内成员和友元friend成员访问。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 重载

operator overloading https://en.cppreference.com/w/cpp/language/operators
- > Customizes the C++ operators for operands of user-defined types.

Classes (II) https://www.cplusplus.com/doc/tutorial/templates/

Operator overloading https://docs.microsoft.com/en-us/cpp/cpp/operator-overloading

Overloading the `<<` Operator for Your Own Classes https://docs.microsoft.com/en-us/cpp/standard-library/overloading-the-output-operator-for-your-own-classes

13.4 — Overloading the I/O operators https://www.learncpp.com/cpp-tutorial/overloading-the-io-operators/
- > Of course, it makes more sense to do this as a reusable function. And in previous examples, you’ve seen us create `print()` functions that work like this:
  ```cpp
  #include <iostream>
  
  class Point
  {
  private:
      double m_x{};
      double m_y{};
      double m_z{};
  public:
      Point(double x=0.0, double y=0.0, double z=0.0)
        : m_x{x}, m_y{y}, m_z{z}
      {
      }
      double getX() const { return m_x; }
      double getY() const { return m_y; }
      double getZ() const { return m_z; }
      void print() const
      {
          std::cout << "Point(" << m_x << ", " << m_y << ", " << m_z << ')';
      }
  };
  
  int main()
  {
      const Point point{5.0, 6.0, 7.0};
      std::cout << "My point is: ";
      point.print();
      std::cout << " in Cartesian space.\n";
  }
  //////////////////////////////////////////////////
  My point is: Point(5, 6, 7) in Cartesian space.
  ```
  * > While this is much better, it still has some downsides. Because `print()` returns `void`, it can’t be called in the middle of an output statement.
- > **Overloading operator<<**
  ```cpp
  #include <iostream>
  
  class Point
  {
  private:
      double m_x{};
      double m_y{};
      double m_z{};
  public:
      Point(double x=0.0, double y=0.0, double z=0.0)
        : m_x{x}, m_y{y}, m_z{z}
      {
      }
      friend std::ostream& operator<< (std::ostream &out, const Point &point);
  };
  std::ostream& operator<< (std::ostream &out, const Point &point)
  {
      // Since operator<< is a friend of the Point class, we can access Point's members directly.
      out << "Point(" << point.m_x << ", " << point.m_y << ", " << point.m_z << ')'; // actual output done here
      return out; // return std::ostream so we can chain calls to operator<<
  }

  int main()
  {
      const Point point1{2.0, 3.0, 4.0};
      std::cout << point1 << '\n';
      return 0;
  }
  //////////////////////////////////////////////////
  Point(2, 3, 4)
  ```

C++ Operator Overloading https://www.programiz.com/cpp-programming/operator-overloading

Operator Overloading in C++ https://www.geeksforgeeks.org/operator-overloading-c/

Overloading stream insertion (<>) operators in C++ https://www.geeksforgeeks.org/overloading-stream-insertion-operators-c/

How to properly overload the << operator for an ostream? https://stackoverflow.com/questions/476272/how-to-properly-overload-the-operator-for-an-ostream

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 成员变量初始化

c++类的成员变量初始化 https://www.jianshu.com/p/497b4fc4a310
- > 普通成员变量的初始化可以在构造函数中进行赋值， 也可以在初始化列表中进行赋值。
- > 静态成员变量必须在类外进行初始化, 且初始化时不加static前缀。
- > ***`const`变量在初始化列表中进行初始化***。
- > 引用成员变量也需要在初始化列表中进行初始化， 类似于const型。

类的成员变量初始化总结 https://blog.csdn.net/tham_/article/details/44938731
```console
首先把需要初始化的成员变量分为几类：
Ø  一般变量(int)
Ø  静态成员变量(static int)
Ø  常量(const int )
Ø  静态常量(static const int)

对应的初始化方式是：
Ÿ  一般变量可以在初始化列表里或者构造函数里初始化，不能直接初始化或者类外初始化
Ÿ  静态成员变量必须在类外初始化
Ÿ  常量必须在初始化列表里初始化
Ÿ  静态常量必须只能在定义的时候初始化(定义时直接初始化)
```

## 初始化列表

C++ 类构造函数初始化列表 https://www.runoob.com/w3cnote/cpp-construct-function-initial-list.html || https://www.cnblogs.com/BlueTzar/articles/1223169.html
- > 构造函数初始化列表以一个冒号开始，接着是以逗号分隔的数据成员列表，每个数据成员后面跟一个放在括号中的初始化式。例如：
  ```cpp
  class CExample {
  public:
      int a;
      float b;
      //构造函数初始化列表
      CExample(): a(0),b(8.8)
      {}
      //构造函数内部赋值
      CExample()
      {
          a=0;
          b=8.8;
      }
  };
  ```
- > 上面的例子中两个构造函数的结果是一样的。上面的构造函数（使用初始化列表的构造函数）显式的初始化类的成员；而没使用初始化列表的构造函数是对类的成员赋值，并没有进行显式的初始化。
- > 初始化和赋值对内置类型的成员没有什么大的区别，像上面的任一个构造函数都可以。对非内置类型成员变量，为了避免两次构造，推荐使用类构造函数初始化列表。但有的时候必须用带有初始化列表的构造函数：
  * > 1.成员类型是**没有默认构造函数的类**。若没有提供显示初始化式，则编译器隐式使用成员类型的默认构造函数，若类没有默认构造函数，则编译器尝试使用默认构造函数将会失败。
  * > 2.**const 成员**或**引用类型**的成员。因为 const 对象或引用类型只能初始化，不能对他们赋值。
- > **初始化数据成员与对数据成员赋值的含义是什么？有什么区别？**
- > 首先把数据成员按类型分类并分情况说明:
  * > 1.**内置数据类型，复合类型（指针，引用）**- 在成员初始化列表和构造函数体内进行，在性能和结果上都是一样的
  * > 2.**用户定义类型（类类型）**- 结果上相同，但是性能上存在很大的差别。因为类类型的数据成员对象在进入函数体前已经构造完成，也就是说在成员初始化列表处进行构造对象的工作，调用构造函数，在进入函数体之后，进行的是对已经构造好的类对象的赋值，又调用个拷贝赋值操作符才能完成（如果并未提供，则使用编译器提供的默认按成员赋值行为）
- > **注意点**：
  * > 初始化列表的成员初始化顺序: C++ 初始化类成员时，是按照声明的顺序初始化的，而不是按照出现在初始化列表中的顺序。

C++ 初始化列表 https://www.cnblogs.com/graphics/archive/2010/07/04/1770900.html

C++初始化列表，知道这些就够了 - 小豆君的干货铺的文章 - 知乎 https://zhuanlan.zhihu.com/p/33004628
- > 在C++中，当创建一个对象时，编译器要保证调用了所有子对象的构造函数，这是C++强制要求的，也是它的一个机制。
- > 因为在Base中没有定义默认构造函数，只定义了一个有整型参数的构造函数，因此编译器并不会再去生成一个默认的构造函数，而BaseChild继承Base时，又没有显式地指定Base的构造函数，所以编译报错。
- > 如果我们不修改Base，那么，我们用什么办法 ***不去调用默认构造函数，而是显式的调用Base带参构造函数*** 呢。答案就是`初始化列表`。
- > C++就为我们提供了这样的语法。即在冒号和这个构造函数定义体的左括号之间可指定基类构造函数，如下：
  ```cpp
  BaseChild():Base(1)
  {
      cout << "create is BaseChild()" << endl;
  }
  ```
  > 现在，再编译程序，轻松通过。
- > 当然，初始化列表还可以对类本身的数据成员进行初始化，如对BaseChild成员m_num进行初始化：
  ```cpp
  BaseChild():Base(1), m_num(0){...}
  ```
  > 中间要以逗号隔开。
  >> 【[:star:][`*`]】 //notes：其实就是 ***1.子类的构造函数显式地调用任意的父类构造函数写过；2.构造函数使用初始化列表写过***。但是两者同时的时候（主要就是冒号后面该怎么写呢？）还真是没写过，所以这里记录一下。

## 第二批

C++创建对象时区分圆括号( )和大括号{ } - emin的文章 - 知乎 https://zhuanlan.zhihu.com/p/268894227

大括号之谜：C++的列表初始化语法解析 https://bbs.huaweicloud.com/blogs/245774 || https://segmentfault.com/a/1190000039362151

C++如何实现用大括号初始化vector https://www.jianshu.com/p/ffbb7d6403b3

C++ Morsels: Initializer List Execution Order https://web.archive.org/web/20171220211003/http://xenon.arcticus.com/c-morsels-initializer-list-execution-order

## 起因：子类如何初始化父类的私有成员变量

c++ 子类构造函数初始化及父类构造初始化 https://blog.csdn.net/sevenjoin/article/details/82222895

C++ 子类构造函数初始化列表与基类关系 https://www.cnblogs.com/impw/p/15678308.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 静态成员变量/静态成员函数

C++ 类的静态成员 https://www.runoob.com/cplusplus/cpp-static-members.html
- > **静态成员变量**
  * > ***静态成员在类的所有对象中是共享的***。如果不存在其他的初始化语句，在创建第一个对象时，所有的静态数据都会被初始化为零。***我们不能把静态成员的初始化放置在类的定义中，但是可以在类的外部通过使用范围解析运算符 `::` 来重新声明静态变量从而对它进行初始化***，如下面的实例所示。
- > **静态成员函数**
  * > 如果把函数成员声明为静态的，就可以把函数与类的任何特定对象独立开来。静态成员函数即使在类对象不存在的情况下也能被调用，静态函数只要使用类名加范围解析运算符 `::` 就可以访问。
  * > 静态成员函数只能访问静态成员数据、其他静态成员函数和类外部的其他函数。
  * > 静态成员函数有一个类范围，他们不能访问类的 `this` 指针。您可以使用静态成员函数来判断类的某些对象是否已被创建。
  * > 静态成员函数与普通成员函数的区别：
    ```console
    静态成员函数没有 this 指针，只能访问静态成员（包括静态成员变量和静态成员函数）。
    普通成员函数有 this 指针，可以访问类中的任意成员；而静态成员函数没有 this 指针。
    ```

C++ 类的static静态成员 https://www.cnblogs.com/wkfvawl/p/10834549.html
- > `sizeof` 运算符不会计算静态成员变量，`sizeof(CMyclass)`等于4。使用静态数据成员可以节省内存，因为它是所有对象所公有的，因此，对多个对象来说，静态数据成员只存储一处，供所有对象共用。静态数据成员是静态存储的，它是静态生存期，必须对它进行初始化。静态成员初始化与一般数据成员初始化不同，类数据成员在类内部声明，但是静态成员必须在类的外面初始化，静态数据成员初始化的格式如下：
  ```console
  <数据类型><类名>::<静态数据成员名>=<值>
  ```
- > 如果一个类中说明了静态数据成员，只有在这个类的第一个对象被创建时被初始化，自第二个对象起均不作初始化。对`A类`中`静态数据成员s`进行初始化：
  ```cpp
  int A::s = 0;
  ```
  > 初始化在类体外进行，而前面不加`static`，以免与一般静态变量或对象相混淆。

C++ 类中的static成员的初始化和特点 https://blog.csdn.net/men_wen/article/details/64443040
- > 这些特殊类型的成员变量主要有：
  ```console
  1. 引用
  2. 常量
  3. 静态变量
  4. 静态整型常量
  5. 静态非整型常量
  ```

C++: 全局变量和static变量初始化问题 https://www.cnblogs.com/dylan-liang/p/14407237.html
- > **1.初始化时机**
  * > 【[:star:][`*`]】 全局变量、文件域中的静态变量、类中的成员静态变量 ***在main函数执行前初始化***；局部变量中的静态变量在第一次调用时初始化。
  * > C和C++的区别：局部静态变量：
    + > 在C语言中是编译期初始化并分配内存，故不能用变量给静态局部变量赋值，只能用常量。
    + > 在C++中是第一次执行时初始化，因为C++引入了对象的概念，对象一般需要构造函数，无法简单的分配内存，故可以用变量赋值，并且在第一次使用时初始化。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 友元（`friend`）

C++ 友元函数 https://www.runoob.com/cplusplus/cpp-friend-functions.html
- > 类的`友元函数`是 ***定义在类外部，但有权访问类的所有私有（`private`）成员和保护（`protected`）成员***。尽管`友元函数`的原型有在类的定义中出现过，***但是`友元函数`并不是`成员函数`***。
- > 友元可以是一个函数，该函数被称为`友元函数`；友元也可以是一个类，该类被称为`友元类`，在这种情况下，整个类及其所有成员都是友元。
- > 如果要声明函数为一个类的友元，***需要在类定义中该函数原型前使用关键字 `friend`***，如下所示：
  ```cpp
  class Box
  {
     double width;
  public:
     double length;
     friend void printWidth( Box box );
     void setWidth( double wid );
  };
  ```
- > 声明类 ClassTwo 的所有成员函数作为类 ClassOne 的友元，需要在类 ClassOne 的定义中放置如下声明：
  ```cpp
  friend class ClassTwo;
  ```
- > 请看下面的程序：
  ```cpp
  #include <iostream>
  using namespace std;

  class Box
  {
     double width;
  public:
     friend void printWidth( Box box );
     void setWidth( double wid );
  };

  // 成员函数定义
  void Box::setWidth( double wid )
  {
      width = wid;
  }

  // 请注意：printWidth() 不是任何类的成员函数
  void printWidth( Box box )
  {
     /* 因为 printWidth() 是 Box 的友元，它可以直接访问该类的任何成员 */
     cout << "Width of box : " << box.width <<endl;
  }

  // 程序的主函数
  int main( )
  {
     Box box;
     // 使用成员函数设置宽度
     box.setWidth(10.0);
     // 使用友元函数输出宽度
     printWidth( box );
     return 0;
  }
  ```
- > 当上面的代码被编译和执行时，它会产生下列结果：
  ```console
  Width of box : 10
  ```

C++类对象共享数据的5种实现方法 https://blog.csdn.net/fanyun_01/article/details/78145431

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

c++ 函数后面加一个冒号的含义 https://www.cnblogs.com/Allen-rg/p/11529949.html
```console
构造函数后加冒号是初始化表达式：
有四种情况下应该使用初始化表达式来初始化成员：
1：初始化const成员
2：初始化引用成员
3：当调用基类的构造函数，而它拥有一组参数时
4：当调用成员类的构造函数，而它拥有一组参数时。
```

c++中冒号（:）和双冒号（::）的用法 https://www.cnblogs.com/kimmychul/p/3951229.html

c++ 在函数后加const的意义 https://blog.csdn.net/qq_32739503/article/details/83341222
```console
c++ 函数前面和后面 使用const 的作用：
  · 前面使用const 表示返回值为const
  · 后面加 const表示函数不可以修改class的成员
```

The real difference between struct and class https://www.fluentcpp.com/2017/06/13/the-real-difference-between-struct-class/
- > The only difference is if you don’t specify the visibility (public, private or protected) of the members, they will be public in the struct and private in the class. And the visibility by default goes just a little further than members: for inheritance if you don’t specify anything then the struct will inherit publicly from its base class:
