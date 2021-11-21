
# 1

C++ 教程 | C11 智能指针 https://aiden-dong.github.io/2020/01/26/cpp%E6%99%BA%E8%83%BD%E6%8C%87%E9%92%88/
- > 对于编译器来说，***智能指针实际上是一个栈对象，并非指针类型***，在栈对象生命期即将结束时，智能指针通过析构函数释放有它管理的堆内存。***所有智能指针都重载了 `operator->` 操作符，直接返回对象的引用，用以操作对象。访问智能指针原来的方法则使用 `.` 操作符***。
- > 访问智能指针包含的裸指针则可以用 `get()` 函数。由于智能指针是一个对象，所以 `if (my_smart_object)` 永远为真，要判断智能指针的裸指针是否为空，需要这样判断：`if (my_smart_object.get())`。
- > 智能指针包含了 `reset()` 方法，如果不传递参数（或者传递 NULL），则智能指针会释放当前管理的内存。如果传递一个对象，则智能指针会释放当前对象，来管理新传入的对象。
- > **`auto_ptr`**
  * > `std::auto_ptr` 属于 STL，当然在 `namespace std` 中，包含头文件 `#include<memory>` 便可以使用。`std::auto_ptr` 能够方便的管理单个堆内存对象。
  * > 所以，**使用 `std::auto_ptr` 时，绝对不能使用“`operator=`”操作符**。作为一个库，不允许用户使用，确没有明确拒绝，多少会觉得有点出乎预料。

# 2

【[:star:][`*`]】 C++智能指针 https://www.jianshu.com/p/68fc49d55374
- > 原文链接：http://blog.csdn.net/xiaohu2022/article/details/69230178
- > 内存管理是C++中的一个常见的错误和bug来源。在大部分情形中，这些bug来自动态分配内存和指针的使用：当多次释放动态分配的内存时，可能会导致内存损坏或者致命的运行时错误；当忘记释放动态分配的内存时，会导致内存泄露。所以，我们需要智能指针来帮助我们管理动态分配的内存。其来源于一个事实：***栈比堆要安全的多，因为栈上的变量离开作用域后，会自动销毁并清理。智能指针结合了栈上变量的安全性和堆上变量的灵活性***。
- > **引言**
  * > 考虑下面一个函数：
    ```cpp
    void someFunction()
    {
        Resource* ptr = new Resource; // Resource是一个类或者结构
        // 使用ptr处理
        // ...
        delete ptr;
    }
    ```
    > 代码很简单：申请了一份动态内存，使用之后释放了它。但是我们很容易会在函数结束前释放它。***也许我们记得及时释放动态申请的内存，但是仍然有一些不可抗力导致内存无法得到释放***，比如函数提前终止了。考虑下面的代码：
    ```cpp
    void someFunction()
    {
        Resource* ptr = new Resource; // Resource是一个类或者结构     
        int x;
        std::cout << "Enter an integer: ";
        std::cin >> x;
        if (x == 0)
            return;  // 函数终止，无法释放ptr
        if (x < 0)
            throw;   // 出现异常，函数终止，无法释放ptr
        // 使用ptr处理
        // ...
        delete ptr;
    }
    ```
    > 此时，由于过早的return语句以及异常的抛出，ptr将得不到正确释放，从而出现内存泄露。***归根到底，指针并没有一个内在机制来自动管理与释放***。然后，你可能想到了类：***类内部存储指针，然后在析构函数中销毁该指针。类可以实现资源的自动管理。其好处是，只要类局部变量（分配在栈上）超出其作用域（不论其是如何离开的），其析构函数一定会被执行，那么管理的内存也将一定得到销毁***。基于这样的想法，我们实现了一个简单的智能指针类：
    ```cpp
    template<typename T>
    class Auto_ptr1
    {
    public:
        Auto_ptr1(T* ptr = nullptr):
            m_ptr{ptr}
        {}

        virtual ~Auto_ptr1()
        {
            delete m_ptr;
        }

        T& operator*() { return *m_ptr; }
        T* operator->() { return m_ptr; }
    private:
        T* m_ptr;
    };
    
    class Resource
    {
    public:
        Resource() { cout << "Resource acquired!" << endl; }
        virtual ~Resource() { cout << "Resource destoryed!" << endl; }
    };
    
    int main()
    {
        {
            Auto_ptr1<Resource> res(new Resource);
        }
        cin.ignore(10);
        return 0;
    }
    ```
    > 执行上面的程序，我们可以得到下面的输出：
    ```concole
    Resource acquired
    Resource destroyed
    ```
    > 看来这样的想法完全可以，我们将动态申请的资源交给一个类变量来保存，由于类变量在局部作用域，其离开后将会自动调用析构函数，然后释放内存。同时，***不论其是如何离开作用域的，即使出现异常，析构函数一定会被执行，内存也一定得到释放，因为该类变量是保存在栈上的***。
  * > 但是上面的实现却有致命的隐患，考虑下面的代码：
    ```cpp
    int main()
    {
        {
            Auto_ptr1<Resource> res1(new Resource);
            Auto_ptr1<Resource> res2(res1);
        }
        cin.ignore(10);
        return 0;
    }
    ```
    > 看起来没有问题，但是执行起来，程序会崩溃。***因为用res1初始化res2，调用的是默认复制构造函数，执行的是`浅复制`***。所以，res2与res1内部保存是同一块内存，当销毁变量时，同一块内存将会被多次释放，程序当然会奔溃。同样地，下面的代码依然存在同样的问题：
    ```cpp
    void passByValue(Auto_ptr1<Resource> res)
    {}
    int main()
    {
        {
            Auto_ptr1<Resource> res1(new Resource);
            passByValue(res1);
        }
        
        cin.ignore(10);
        return 0;
    }
    ```
    > 因为res1被浅复制到函数参数res中，函数执行后其内存会被释放，那么在销毁res1时，又会销毁已经释放的内存，程序崩溃。
  * > 所以我们需要修改这个类，最好自己实现复制构造函数，同样地要自己实现赋值运算符重载。假如我们在这两个函数中，将指针所有权从一个对象转移到另外一个对象，那么上面的问题将迎刃而解。修改的智能指针类如下：
    ```cpp
    template<typename T>
    class Auto_ptr2
    {
    public:
        Auto_ptr2(T* ptr = nullptr) :
            m_ptr{ ptr }
        {}

        virtual ~Auto_ptr2()
        {
            delete m_ptr;
        }

        Auto_ptr2(Auto_ptr2& rhs)
        {
            m_ptr = rhs.m_ptr;
            rhs.m_ptr = nullptr;
        }

        Auto_ptr2& operator=(Auto_ptr2& rhs) 
        {
            if (&rhs == this)
                return *this;

            delete m_ptr; 
            m_ptr = rhs.m_ptr; 
            rhs.m_ptr = nullptr; 
            return *this;
        }

        T& operator*() { return *m_ptr; }
        T* operator->() { return m_ptr; }
        bool isNull() const { return m_ptr == nullptr; }
    private:
        T* m_ptr;
    };
    ```
    > 我们使用这个新类测试一下下面的代码：
    ```cpp
    int main()
    {
        Auto_ptr2<Resource> res1(new Resource);
        Auto_ptr2<Resource> res2; // 初始化为nullptr

        cout << "res1 is " << (res1.isNull() ? "null\n" : "not null\n");
        cout << "res2 is " << (res2.isNull() ? "null\n" : "not null\n");

        res2 = res1; // 转移指针所有权

        cout << "Ownership transferred\n";

        cout << "res1 is " << (res1.isNull() ? "null\n" : "not null\n");
        cout << "res2 is " << (res2.isNull() ? "null\n" : "not null\n");

        cin.ignore(10);
        return 0;
    }
    ```
    > 程序输出如下：
    ```cpp
    Resource acquired
    res1 is not null
    res2 is null
    Ownership transferred
    res1 is null
    res2 is not null
    Resource destroyed
    ```
    > 可以看到，由于重载赋值运算符实现的是指针所有权转移，所以上面的代码不会出错。
  * > 如果你仔细审视 `Auto_ptr2`，你会发现其***实际上实现的是移动语义***，对于移动语义来说，其将转移对象所有权，而不是进行赋值。由于在 `C++11` 之前，并没有右值引用，所以没有机制实现移动语义。所以 `C++11` 之前的智能指针是 `std::auto_ptr`，其实现就类似于 `Auto_ptr2类` 。但是其存在很多问题。***首先***，如果函数中存在 `std::auto_ptr` 类型的参数，你使用一个变量进行传值时，资源所有权将会被转移，那么函数结束后资源将被销毁，然后你可能解引用这个变量，但实际上它已经是空指针了，因此程序可能崩溃。***其次***，`std::auto_ptr` 内部调用的是非数组delete，那么对于动态分配的数组，`std::auto_ptr` 无法正常工作，可能会出现内存泄露。***最后***，`std::auto_ptr` 对STL不兼容，因为STL的对象在进行复制时，就是进行复制，而不是移动语义。所以实际上，***`std::auto_ptr` 在 `C++11` 中已经被弃用了，并且在 `C++17` 中被移除标准库***。
  * > 基于 `C++11` 中的`右值引用`与`移动语义`，我们可以解决上面出现的大部分问题：
    ```cpp
    template<typename T>
    class Auto_ptr3
    {
    public:
        Auto_ptr3(T* ptr = nullptr):
            m_ptr{ptr}
        {}

        Auto_ptr3(const Auto_ptr3& rhs) = delete;

        Auto_ptr3(Auto_ptr3&& rhs) :
            m_ptr{ rhs.m_ptr }
        {
            rhs.m_ptr = nullptr;
        }

        Auto_ptr3& operator=(const Auto_ptr3& rhs) = delete;

        Auto_ptr3& operator=(Auto_ptr3&& rhs)
        {
            if (this == &rhs)
            {
                return *this;
            }
            std::swap(m_ptr, rhs.m_ptr);
            return *this;
            
        }

        virtual ~Auto_ptr3()
        {
            delete m_ptr;
        }

        T& operator*() { return *m_ptr; }
        T* operator->() { return m_ptr; }

        bool isNull() const { return m_ptr == nullptr; }
    private:
        T* m_ptr;
    };
    ```
    > 可以看到 `Auto_ptr3` 实现了移动构造函数与移动赋值操作符的重载，进而实现了移动语义，但是同时禁用了复制构造函数与复制赋值运算符，因此这个类的变量仅可以通过仅可以传递右值，但是不能传递左值。但是你可以将右值传递给函数的const左值引用参数。当你传递右值时，那么明显地你已经知道要转移指针所有权了，那么当前变量将不再有效。在 `C++11` 中有类似的实现，那就是 `std::unique_ptr`，当然更智能了。
  * > C++11 `<memory>` 标准库中含有四种智能指针：`std::auto_ptr`（***不要使用！！！***）, `std::unique_ptr`, `std::shared_ptr` 和 `std::weak_ptr`。下面我们逐个介绍后面三个智能指针。
- > **`std::unique_ptr`**
  * > `std::unique_ptr` 是 `std::auto_ptr` 的替代品，其用于不能被多个实例共享的内存管理。这就是说，仅有一个实例拥有内存所有权。它的使用很简单：
    ```cpp
    class Fraction
    {
    private:
        int m_numerator = 0;
        int m_denominator = 1;
     
    public:
        Fraction(int numerator = 0, int denominator = 1) :
            m_numerator(numerator), m_denominator(denominator)
        {
        }
     
        friend std::ostream& operator<<(std::ostream& out, const Fraction &f1)
        {
            out << f1.m_numerator << "/" << f1.m_denominator;
            return out;
        }
    };

    int main()
    {
        
        std::unique_ptr<Fraction> f1{ new Fraction{ 3, 5 } };
        cout << *f1 << endl; // output: 3/5

        std::unique_ptr<Fraction> f2; // 初始化为nullptr

        // f2 = f1 // 非法，不允许左值赋值
        f2 = std::move(f1);  // 此时f1转移到f2，f1变为nullptr

        // C++14 可以使用 make_unique函数
        auto f3 = std::make_unique<Fraction>(2, 7);
        cout << *f3 << endl;  // output: 2/7

        // 处理数组，但是尽量不用这样做，因为你可以用std::array或者std::vector
        auto f4 = std::make_unique<Fraction[]>(4);
        std::cout << f4[0] << endl; // output: 0/1
        
        cin.ignore(10);
        return 0;
    }
    ```
    > 如果编译器支持，尽量使用 `make_unique` 函数创建 `unique_ptr` 实例，如果不支持，你可以实现简化的版本：
    ```cpp
    // 注意：无法处理数组
    template<typename T, typename ... Ts>
    std::unique_ptr<T> make_unique(Ts ... args)
    {
        return std::unique_ptr<T> {new T{ std::forward<Ts>(args) ... }};
    }
    ```
    > 可以看到，`std::unique_ptr` 对象可以作为函数返回值使用，***因为函数返回值是个右值***，复制给其他变量时，通过移动语义来实现。当然，你可以将 `std::unique_ptr` 对象传递给函数，看下面的例子：
    ```cpp
    class Resource
    {
    public:
        Resource() { cout << "Resource acquired!" << endl; }
        virtual ~Resource() { cout << "Resource destoryed!" << endl; }

        friend std::ostream& operator<<(std::ostream& out, const Resource &res)
        {
            out << "I am a resource" << endl;
            return out;
        }
    };

    void useResource(const std::unique_ptr<Resource>& res)
    {
        if (res)
        {
            cout << *res;
        }
    }

    int main()
    {
        
        {
            auto ptr = std::make_unique<Resource>();
            useResource(ptr);
            cout << "Ending" << endl;
        }
        // output
        // Resource acquired
        // I am a resource
        // Ending
        // Resource destroyed
        cin.ignore(10);
        return 0;
    }
    ```
    > 可以看到 `std::unique_ptr` 对象可以传值给左值常量引用参数，因为这并不会改变内存所有权。也可以右值传值，实现移动语义：
    ```cpp
    void takeOwnerShip(std::unique_ptr<Resource>&& res) // 也可以用 std::unique_ptr<Resource> res
    {
        if (res)
        {
            cout << *res;
        }
    }

    int main()
    {
        
        {
            auto ptr = std::make_unique<Resource>();
            // takeOwnerShip(ptr); // 非法
            takeOwnerShip(std::move(ptr)); // 必须传递右值
            cout << "Ending" << endl;
        }
        // output
        // Resource acquired
        // I am a resource
        // Resource destroyed
        // Ending
        cin.ignore(10);
        return 0;
    }
    ```
    > 可以看到，`std::unique_ptr` 对象可以方便地管理动态内存。***但是前提是该对象是建立在栈上的，千万不要使用动态分配的类对象***，那么将在堆上，其行为与普通指针变得一样。
  * > 使用 `std::unique_ptr` 可能犯的两个错误是：
    ```cpp
    // 千万不要用同一个资源来初始化多个std::unique_ptr对象
    Resource *res = new Resource;
    std::unique_ptr<Resource> res1(res);
    std::unique_ptr<Resource> res2(res);

    // 不要混用普通指针与智能指针
    Resource *res = new Resource;
    std::unique_ptr<Resource> res1(res);
    delete res;
    ```
    > `std::unique_ptr` 默认使用 `new` 和 `delete` 运算符来分配和释放内存，可以修改这个行为，下面的代码使用 `malloc()` 和 `free()` 函数管理资源：
    ```cpp
    // 大部分时候没有理由这样做
    auto deleter = [](int* p) { free(p); };
    int* p = (int*)malloc(sizeof(int));
    *p = 2;
    std::unique_ptr<int, decltype(deleter)> mySmartPtr{ p, deleter };
    cout << *mySmartPtr << endl; // output: 2
    ```
    > `std::unique_ptr` 还有几个常用的方法：
    ```console
    release()：返回该对象所管理的指针，同时释放其所有权；
    reset()：析构其管理的内存，同时也可以传递进来一个新的指针对象；
    swap()：交换所管理的对象；
    get()：返回对象所管理的指针；
    get_deleter()：返回析构其管理指针的调用函数。
    ```
    > 使用上面的方法还是要小心，如不要将其它对象所管理的指针传给另外一个对象的 `reset()` 方法，这会造成一块内存释放多次。更多详情可以参考[这里](https://en.cppreference.com/w/cpp/memory/unique_ptr)。
- > **`std::shared_ptr`**
  * > 其实 `std::shared_ptr` 与 `std::unique_ptr` 类似。要创建 `std::shared_ptr` 对象，可以使用 `make_shared()` 函数（***`C++11` 是支持的，貌似制定这个标准的人忘了 `make_unique()`，所以在 `C++14` 追加了***）。`std::shared_ptr` 与 `std::unique_ptr` 的主要区别在于***前者是使用引用计数的智能指针***。引用计数的智能指针可以跟踪引用同一个真实指针对象的智能指针实例的数目。这意味着，可以有多个 `std::shared_ptr` 实例可以指向同一块动态分配的内存，当最后一个引用对象离开其作用域时，才会释放这块内存。还有一个区别是 ***`std::shared_ptr` 不能用于管理C语言风格的动态数组***，这点要注意。下面看例子：
    ```cpp
    int main()
    {
        auto ptr1 = std::make_shared<Resource>();
        cout << ptr1.use_count() << endl;  // output: 1
        {
            auto ptr2 = ptr1;  // 通过复制构造函数使两个对象管理同一块内存
            std::shared_ptr<Resource> ptr3;   // 初始化为空
            ptr3 = ptr1;   // 通过赋值，共享内存
            cout << ptr1.use_count() << endl;  // output: 3
            cout << ptr2.use_count() << endl;  // output: 3
            cout << ptr3.use_count() << endl;  // output: 3
        }
        // 此时ptr2与ptr3对象析构了
        cout << ptr1.use_count() << endl;  // output: 1
        
        cin.ignore(10);
        return 0;
    }
    ```
    > 可以看到，通过复制构造函数或者赋值来共享内存，知道这一点很重要，看下面的例子：
    ```cpp
    int main()
    {
        Resource* res = new Resource;
        std::shared_ptr<Resource> ptr1{ res };
        cout << ptr1.use_count() << endl;  // output: 1
        {
            
            std::shared_ptr<Resource> ptr2{ res };   // 用同一块内存初始化
            
            cout << ptr1.use_count() << endl;  // output: 1
            cout << ptr2.use_count() << endl;  // output: 1
            
        }
        // 此时ptr2ptr3对象析构了, output：Resource destroyed
        cout << ptr1.use_count() << endl;  // output: 1
        
        cin.ignore(10);
        return 0;
    }
    ```
    > 很奇怪，***ptr1与ptr2虽然是用同一块内存初始化，但是这个共享却并不被两个对象所知道***。这是由于***两个对象是独立初始化的，它们互相之间没有通信***。当然上面的程序会最终崩溃，因为同一块内存会被析构两次。所以，还是使用复制构造函数还有赋值运算来使不同对象管理同一块内存。如果深挖的话，`std::shared_ptr` 与 `std::unique_ptr` 内部实现机理有区别，前者内部使用两个指针，一个指针用于管理实际的指针，另外一个指针指向一个”控制块“，其中记录了哪些对象共同管理同一个指针。这是在初始化完成的，所以如果单独初始化两个对象，尽管管理的是同一块内存，它们各自的”控制块“没有互相记录的。所以，上面的问题就出现了。但是如果是使用复制构造函数还有赋值运算时，“控制块”会同步更新的，这样就达到了引用计数的目的。使用 `std::make_shared` 就不会出现上面的问题，所以要推荐使用。
    > 
    > `std::shared_ptr` 还有其他方法，更多的信息在[这里](https://en.cppreference.com/w/cpp/memory/shared_ptr)。
- > **`std::weak_ptr`**
  * > `std::shared_ptr` 可以实现多个对象共享同一块内存，当最后一个对象离开其作用域时，这块内存被释放。但是仍然有可能出现内存无法被释放的情况，***联想一下“死锁”现象***，对于 `std::shared_ptr` 会出现类似的“循环引用”现象：
    ```cpp
    class Person
    {
    public:
        Person(const string& name):
            m_name{name}
        {
            cout << m_name << " created" << endl;
        }

        virtual ~Person()
        {
            cout << m_name << " destoryed" << endl;
        }

        friend bool partnerUp(std::shared_ptr<Person>& p1, std::shared_ptr<Person>& p2)
        {
            if (!p1 || !p2)
            {
                return false;
            }

            p1->m_partner = p2;
            p2->m_partner = p1;

            cout << p1->m_name << " is now partenered with " << p2->m_name << endl;
            return true;
        }

    private:
        string m_name;
        std::shared_ptr<Person> m_partner;
    };

    int main()
    {
        {
            auto p1 = std::make_shared<Person>("Lucy");
            auto p2 = std::make_shared<Person>("Ricky");
            partnerUp(p1, p2);  // 互相设为伙伴
        }
        
        cin.ignore(10);
        return 0;
    }
    ```
    > 整个程序很简单，创建两个Person动态对象，交由智能指针管理，并且通过 partnerUp() 函数互相引用为自己的伙伴。但是执行的结果却却有问题：
    ```console
    Lucy created
    Ricky created
    Lucy is now partnered with Ricky
    ```
    > 对象没有被析构！出现内存泄露！仔细想想 `std::shared_ptr` 对象是什么时候才能被析构，就是引用计数变为0时，但是当你想析构p1时，p2内部却引用了p1，无法析构；反过来也无法析构。互相引用造成了“死锁”，最终内存泄露！这样的情形也会出现在“自锁”中：
    ```cpp
    int main()
    {
        {
            auto p1 = std::make_shared<Person>("Lucy");
            partnerUp(p1, p1);  // 自己作为自己的伙伴
        }
        
        cin.ignore(10);
        return 0;
    }
    ```
  * > 这时候 `std::weak_ptr` 应运而生。`std::weak_ptr` 可以包含由 `std::shared_ptr` 所管理的内存的引用。但是它仅仅是旁观者，并不是所有者。那就是 `std::weak_ptr` 不拥有这块内存，当然不会计数，也不会阻止 `std::shared_ptr` 释放其内存。但是它可以通过 `lock()` 方法返回一个 `std::shared_ptr` 对象，从而访问这块内存。这样我们可以用 `std::weak_ptr` 来解决上面的“循环引用”问题：
    ```cpp
    class Person
    {
    public:
        Person(const string& name):
            m_name{name}
        {
            cout << m_name << " created" << endl;
        }

        virtual ~Person()
        {
            cout << m_name << " destoryed" << endl;
        }

        friend bool partnerUp(std::shared_ptr<Person>& p1, std::shared_ptr<Person>& p2)
        {
            if (!p1 || !p2)
            {
                return false;
            }

            p1->m_partner = p2;  // weak_ptr重载的赋值运算符中可以接收shared_ptr对象
            p2->m_partner = p1;

            cout << p1->m_name << " is now partenered with " << p2->m_name << endl;
            return true;
        }

    private:
        string m_name;
        std::weak_ptr<Person> m_partner;
    };

    int main()
    {
        {
            auto p1 = std::make_shared<Person>("Lucy");
            auto p2 = std::make_shared<Person>("Ricky");
            partnerUp(p1, p2);  // 互相设为伙伴
        }
        
        cin.ignore(10);
        return 0;
    }
    ```
    > 程序正常输出（注意创建与析构的顺序是反的？在栈上！）：
    ```console
    Lucy created
    Ricky created
    Lucy is now partnered with Ricky
    Ricky destroyed
    Lucy destroyed
    ```
     > 有关 `std::weak_ptr` 更多的信息在[这里](http://en.cppreference.com/w/cpp/memory/weak_ptr)。
- > 最后说点感想：还是要深刻理解智能指针的内部机理，才能用好它，否则你可能会遇到与普通指针一样的问题。
- > **References**
  ```console
  [1] cpp leraning online（特别感谢这个教程，本文大部分信息可以在这里看到）.
    - http://www.learncpp.com/
  [2] Marc Gregoire. Professional C++, Third Edition, 2016.
  [3] cppreference Dynamic memory management
    - http://en.cppreference.com/w/cpp/memory
  [4] Lvor Horton. Using the C++ Standard Template Libraries, 2016.
  [5] 欧长坤(欧龙崎), 高速上手 C++ 11/14.
    - https://changkun.gitbooks.io/cpp1x-tutorial/content/
  ```
