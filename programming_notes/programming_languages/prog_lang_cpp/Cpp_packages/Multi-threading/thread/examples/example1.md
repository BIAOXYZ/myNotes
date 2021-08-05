
C++11 线程管理 https://www.jianshu.com/p/409e6ceb5315
- > **1 线程启动**
  * > `std::thread` 构造函数接受可调用对象启动线程，如下所示：
    ```cpp
    #include <iostream>
    #include <thread>
    #include <string>
    #include <functional>

    void f(int i) {
        std::cout << "Func, i=" << i << "\n";
    }

    struct Foo {
        void operator()(int i) {
            std::cout << "Class Function Call Object, i=" << i << "\n";
        }
    };

    struct Foo2 {
        void func(int i) {
            std::cout << "Class Method, i=" << i << "\n";
        }
    };

    int main() {
        // by normal function
        std::thread t1(f, 1);
        t1.join();

        // by class operator()
        Foo foo;
        std::thread t2(foo, 2);
        t2.join();

        //by lamda
        int i = 3;
        std::thread t3([i]() {
            std::cout << "Lamda, i=" << i << "\n";
        });
        t3.join();

        // by member function
        Foo2 foo2;
        auto f3 = std::mem_fn(&Foo2::func);
        std::thread t4(f3, foo2, 4);
        t4.join();

        // by bind
        auto f1 = std::bind(f, std::placeholders::_1);
        std::thread t5(f1, 5);
        t5.join();

        // by std::function
        std::function<void(int)> f2 = f;
        std::thread t6(f2, 6);
        t6.join();
    }
    ```
  * > 假设文件名为 `thread.cpp`, 则编译命令为：`g++ -std=c++11 -lpthread thread.cpp -o test_thread`
  * > 执行 `./test_thread` 后程序输出为
    ```console
    Func, i=1
    Class Function Call Object, i=2
    Lamda, i=3
    Class Method, i=4
    Func, i=5
    Func, i=6
    ```
- > **2 参数传递**
  * > **2.1 基本范例**

C++多线程获取返回值方法详解 https://www.jb51.net/article/189512.htm || http://www.cppcns.com/ruanjian/c/323440.html || http://blog.itpub.net/69955379/viewspace-2702825/
