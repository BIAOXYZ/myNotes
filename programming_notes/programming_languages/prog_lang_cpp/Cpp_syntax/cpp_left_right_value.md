
# 左值和右值

How to determine programmatically if an expression is rvalue or lvalue in C++? https://stackoverflow.com/questions/36296425/how-to-determine-programmatically-if-an-expression-is-rvalue-or-lvalue-in-c
- https://stackoverflow.com/questions/36296425/how-to-determine-programmatically-if-an-expression-is-rvalue-or-lvalue-in-c/36296823#36296823
  * > Most of the work is already done for you by the stdlib, you just need a function wrapper:
    ```cpp
    template <typename T>
    constexpr bool is_lvalue(T&&) {
      return std::is_lvalue_reference<T>{};
    }
    ```
  * > in the case you pass a `std::string` lvalue then `T` will deduce to `std::string&` or `const std::string&`, for rvalues it will deduce to `std::string`
  * > Note that [Yakk's answer](https://stackoverflow.com/questions/36296425/how-to-determine-programmatically-if-an-expression-is-rvalue-or-lvalue-in-c/36312021#36312021) will return a different type, which allows for more flexibility and you should read that answer and probably use it instead.

【[:star:][`*`]】 基础篇：lvalue，rvalue和move - Fei Ding的文章 - 知乎 https://zhuanlan.zhihu.com/p/138210501
- > **理解左值和右值**
  * > **左值(lvalue, left value)**，顾名思义就是赋值符号左边的值。准确来说， 左值是表达式（不一定是赋值表达式）后依然存在的持久对象。
  * > **右值(rvalue, right value)**，右边的值，是指表达式结束后就不再存在的临时对象。
  * > 对于以上的语句，lvalue是我们要赋值的对象。它是一个变量，存在于内存中，它的值可以被改变，**可以被取地址**。任何可以通过它的名字，指针或者引用来接触的变量都是lvalue，例如定义的某个变量和函数的参数， 对一个表达式取地址。
  * > rvalue则是一个临时变量，不存在于内存中，存在于CPU的寄存器或者指令的立即数中(immediate number)，因此我们不能改变它的值，**不能取地址**。它们通常是一个直接的数值，运算符返回的数值，或是函数的返回值，或者通过隐式类型转换得到的对象，大部分字面值(e.g., 10 and 5.3)也是rvalues。
    >> 【//notes：***能不能被取地址*** 是左右值的最大不同点——至于这里说的右值不在内存中，查了别的资料好像并不一定】
  * > **纯右值(prvalue, pure rvalue)**，纯粹的右值，没有标识符、不可以取地址的表达式， 要么是纯粹的字面量，例如 `10`, `true`； 要么是求值结果相当于字面量或匿名临时对象，例如 `1+2`。非引用返回的临时变量、运算表达式产生的临时变量、 原始字面量、Lambda 表达式都属于纯右值。
  * > **将亡值(xvalue, expiring value)**，是 C++11 为了引入右值引用而提出的概念（因此在传统 C++中， 纯右值和右值是同一个概念），也就是即将被销毁、却能够被移动的值。
  * > xvalue可能稍有些难以理解，我们来看这样的代码：
    ```cpp
    std::vector<int> foo() {
        std::vector<int> temp = {1, 2, 3, 4};
        return temp;
    }
    std::vector<int> v = foo();
    ```
  * > 就传统的理解而言，函数 `foo` 的返回值 `temp` 在内部创建然后被赋值给 `v`， 然而 `v` 获得这个对象时，会将整个 `temp` 拷贝一份，然后把 `temp` 销毁，如果这个 `temp` 非常大， 这将造成大量额外的开销（这也就是传统 C++ 一直被诟病的问题）。在最后一行中，`v` 是左值、 `foo()` 返回的值就是右值（也是纯右值）。但是，`v` 可以被别的变量捕获到， 而 `foo()` 产生的那个返回值作为一个临时值，一旦被 `v` 复制后，将立即被销毁，无法获取、也不能修改。 而将亡值就定义了这样一种行为：临时的值能够被识别、同时又能够被移动。
  * > 在 C++11 之后，编译器为我们做了一些工作，此处的左值temp会被进行此隐式右值转换， 等价于 `static_cast<std::vector<int> &&>(temp)`，进而此处的 `v` 会将 `foo` 局部返回的值进行 `move`。也就是后面我们将会提到的 `move` 语义。
- > **左值引用和右值引用**
  * > 在明确了左值和右值的关系之后，**对于左值的引用就是左值引用，而对于右值的引用就是右值引用**。如果一个表达式的类型是一个 lvalue reference (例如, `T&` 或 `const T&`, 等.)，那这个表达式就是一个lvalue。其它情况，这个表达式就是一个rvalue。
  * > C++11之前的引用，我们指的是左值引用(`T&`)，即:
    ```cpp
    int a = 3;
    int& ar = a;  //正确的引用
    int& aar = 3; //错误，我们需要让引用指向一个左值
    ```
  * > C++11引入了右值引用的概念，使我们可以取一个右值的引用(`T&&`):
    ```cpp
    int&& a = 3;  //正确
    int&& b = MyInt();  //正确
    ```
  * > C++11 提供了 `std::move` 这个方法将左值参数无条件的转换为右值， 有了它我们就能够方便的获得一个右值临时对象，对对象类型右值引用的转换。
    ```cpp
    int main()
    {
        static_cast<int&&>(7); // The expression static_cast<int&&>(7) belongs
                            // to the xvalue category, because it is a cast
                            // to an rvalue reference to object type.
        std::move(7); // std::move(7) is equivalent to static_cast<int&&>(7).
        return 0;
    }
    ```
  * > 需要拿到一个将亡值，就需要用到右值引用的申明：`T &&`，其中T是类型。 右值引用的声明让这个临时值的生命周期得以延长、只要变量还活着，那么将亡值将继续存活。更多细节可参考：
    >> 现代C++之万能引用、完美转发、引用折叠 - Francis的文章 - 知乎 https://zhuanlan.zhihu.com/p/99524127
- > **move语义**
  * > 传统的 C++ 没有区分『移动』和『拷贝』的概念，造成了大量的数据拷贝，浪费时间和空间。 右值引用的出现恰好就解决了这两个概念的混淆问题，为了结合左值引用来轻易完成move语义的实现。什么是move语义，为什么需要move语义，我们来举一个std::vector的栗子。我们在执行v2=v1时，需要先完成一次函数调用，即调用拷贝赋值运算符，然后执行内存分配，最后循环逐个元素。
  * > 如果v1和v2我们都需要的话，生成两份拷贝自然是没有问题的，但多数情况下我们只希望使用v2，那么我们就只希望生成一份拷贝，减少不必要又麻烦的拷贝过程：设想如果它包含10000个元素，要增加多大的开销？例如下面的swap函数:
    ```cpp
    template <class T> swap(T& a, T& b){
      T tmp(a);  //现有两份a的拷贝，tmp和a
      a = b;     //现有两份b的拷贝，a和b
      b = tmp;   //现有两份tmp的拷贝，b和tmp
    }
    ```
    ```cpp
    //试试更好的方法，不会生成额外的拷贝
    template <class T> swap(T& a, T& b){
      T tmp(std::move(a)); //只有一份拷贝，tmp
      a = std::move(b);    //只有一份拷贝，a
      b = std::move(tmp);  //只有一份拷贝，b
    }
    ```
  * > move函数所做的只是拿到一个左值或右值参数，然后都将其**返回为右值**同时不触发任何拷贝函数。它的作用就是<ins>相当于把参数的值**剪切**到目标对象的值，move可以说是一种具有破坏性的读操作<ins>。
    ```cpp
    std::string str = "Hello";
    std::vector<std::string> v;

    v.push_back(str);
    std::cout<<"After copy, str is \""<<str<<\"\n;
    //输出结果为 After copy, str is "Hello"

    v.push_back(std::move(str));
    std::cout<<"After move, str is \""<<str<<\"\n;
    //输出结果为 After move, str is ""
    ```
  * > 放在v2=v1里，我们能让参数v1的体积为0，只生成v2，避免生成额外拷贝。要实现这样移值的move语义，右值引用的好处就来了，它使我们能轻松快速地完成这个功能:
    ```cpp
    template <class T>
    typename remove_reference<T>::type&&  //去掉引用，再变为右值引用作为返回值类型
    move(T&& a){
      return a;  //通过引用直接把右值传给目标
    }
    ```
  * > C++11也引入了使用move语义来实现的**移动构造函数**的概念。相比C++98的拷贝构造函数，其区别就相当于剪切粘贴和复制粘贴，就像上面的例子一样。
    ```cpp
    void someFunc(Widget w);
    Widget wid;
    someFunc(wid);  //w是由wid拷贝构造
    someFunc(std::move(wid));  //w是由wid移动构造
    ```
  * > 比如：
    ```cpp
    #include <iostream>
    class A {
    public:
        int *pointer;
        A():pointer(new int(1)) { 
            std::cout << "构造" << pointer << std::endl; 
        }
        A(A& a):pointer(new int(*a.pointer)) { 
            std::cout << "拷贝" << pointer << std::endl; 
        } // 无意义的对象拷贝
        A(A&& a):pointer(a.pointer) { 
            a.pointer = nullptr;
            std::cout << "移动" << pointer << std::endl; 
        }
        ~A(){ 
            std::cout << "析构" << pointer << std::endl; 
            delete pointer; 
        }
    };
    // 防止编译器优化
    A return_rvalue(bool test) {
        A a,b;
        if(test) return a; // 等价于 static_cast<A&&>(a);
        else return b;     // 等价于 static_cast<A&&>(b);
    }
    int main() {
        A obj = return_rvalue(false);
        std::cout << "obj:" << std::endl;
        std::cout << obj.pointer << std::endl;
        std::cout << *obj.pointer << std::endl;
        return 0;
    }
    ```
  * > 在上面的代码中：
    + > 1.首先会在 `return_rvalue` 内部构造两个 `A` 对象，于是获得两个构造函数的输出；
    + > 2.函数返回后，产生一个将亡值，被 `A` 的移动构造（`A(A&&)`）引用，从而延长生命周期，并将这个右值中的指针拿到，保存到了 `obj` 中，而将亡值的指针被设置为 `nullptr`，防止了这块内存区域被销毁。
  * > 最后我们再来看一个比较容易混淆的左值和右值问题，下面的rhs是左值还是右值？
    ```cpp
    class Widget{
      public:
        Widget(Widget&& rhs);
      ......
    };
    ```
  * > 答案是左值！区别左值和右值的最根本标准就是，能否取到地址，上面我们显然可以对其进行取址操作，因此它是一个左值。其次，即使这个参数标明的类型是 `T&&`，它其实是**通用引用**(universal reference)而不一定是右值引用。标为 `T&&` 类型的变量***既可以是右值引用，即只能引用右值，也可以是通用引用，既可以引用左值，也可以引用右值***。
- > **通用引用**

Difference between r value and l value [duplicate] https://stackoverflow.com/questions/58253921/difference-between-r-value-and-l-value
- https://stackoverflow.com/questions/58253921/difference-between-r-value-and-l-value/58253944#58253944
  * > `l-value` refers to memory location which identifies an object. `l-value` may appear as either left hand or right hand side of an assignment `operator(=)`. `l-value` often represents as identifier.
