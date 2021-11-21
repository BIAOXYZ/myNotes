
C++ 教程 | C11 智能指针 https://aiden-dong.github.io/2020/01/26/cpp%E6%99%BA%E8%83%BD%E6%8C%87%E9%92%88/
- > 对于编译器来说，***智能指针实际上是一个栈对象，并非指针类型***，在栈对象生命期即将结束时，智能指针通过析构函数释放有它管理的堆内存。***所有智能指针都重载了 `operator->` 操作符，直接返回对象的引用，用以操作对象。访问智能指针原来的方法则使用 `.` 操作符***。
- > 访问智能指针包含的裸指针则可以用 `get()` 函数。由于智能指针是一个对象，所以 `if (my_smart_object)` 永远为真，要判断智能指针的裸指针是否为空，需要这样判断：`if (my_smart_object.get())`。
- > 智能指针包含了 `reset()` 方法，如果不传递参数（或者传递 NULL），则智能指针会释放当前管理的内存。如果传递一个对象，则智能指针会释放当前对象，来管理新传入的对象。
- > **`auto_ptr`**
  * > `std::auto_ptr` 属于 STL，当然在 `namespace std` 中，包含头文件 `#include<memory>` 便可以使用。`std::auto_ptr` 能够方便的管理单个堆内存对象。
  * > 所以，**使用 `std::auto_ptr` 时，绝对不能使用“`operator=`”操作符**。作为一个库，不允许用户使用，确没有明确拒绝，多少会觉得有点出乎预料。

C++智能指针 https://www.jianshu.com/p/68fc49d55374
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
    > 代码很简单：申请了一份动态内存，使用之后释放了它。但是我们很容易会在函数结束前释放它。也许我们记得及时释放动态申请的内存，但是仍然有一些不可抗力导致内存无法得到释放，比如函数提前终止了。考虑下面的代码：
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
    > 此时，由于过早的return语句以及异常的抛出，ptr将得不到正确释放，从而出现内存泄露。归根到底，指针并没有一个内在机制来自动管理与释放。然后，你可能想到了类：类内部存储指针，然后在析构函数中销毁该指针。类可以实现资源的自动管理。其好处是，只要类局部变量（分配在栈上）超出其作用域（不论其是如何离开的），其析构函数一定会被执行，那么管理的内存也将一定得到销毁。基于这样的想法，我们实现了一个简单的智能指针类：
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
    > 看来这样的想法完全可以，我们将动态申请的资源交给一个类变量来保存，由于类变量在局部作用域，其离开后将会自动调用析构函数，然后释放内存。同时，不论其是如何离开作用域的，即使出现异常，析构函数一定会被执行，内存也一定得到释放，因为该类变量是保存在栈上的。
- > 但是上面的实现却有致命的隐患，考虑下面的代码：
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
  * > 可以看到，由于重载赋值运算符实现的是指针所有权转移，所以上面的代码不会出错。
  * > 如果你仔细审视 `Auto_ptr2`，你会发现其实际上实现的是移动语义，对于移动语义来说，其将转移对象所有权，而不是进行赋值。由于在 `C++11` 之前，并没有右值引用，所以没有机制实现移动语义。所以 `C++11` 之前的智能指针是 `std::auto_ptr`，其实现就类似于 `Auto_ptr2类` 。但是其存在很多问题。首先如果函数中存在 `std::auto_ptr` 类型的参数，你使用一个变量进行传值时，资源所有权将会被转移，那么函数结束后资源将被销毁，然后你可能解引用这个变量，但实际上它已经是空指针了，因此程序可能崩溃。其次，`std::auto_ptr` 内部调用的是非数组delete，那么对于动态分配的数组，`std::auto_ptr` 无法正常工作，可能会出现内存泄露。最后，`std::auto_ptr` 对STL不兼容，因为STL的对象在进行复制时，就是进行复制，而不是移动语义。所以实际上，***`std::auto_ptr` 在 `C++11` 中已经被弃用了，并且在 `C++17` 中被移除标准库***。
  * > C++11 `<memory>` 标准库中含有四种智能指针：`std::auto_ptr`（不要使用）, `std::unique_ptr`, `std::shared_ptr` 和 `std::weak_ptr`。下面我们逐个介绍后面三个智能指针。
- > **`std::unique_ptr`**
