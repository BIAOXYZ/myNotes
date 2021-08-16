
# 文章1

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
  * > **2.2 引用传参**
    + > C++11 支持使用 `std::ref` 向线程按照引用方式传递参数, 如下范例：
      ```cpp
      #include <iostream>
      #include <thread>
      #include <string>

      void func(int& i, std::string& s) {
          ++i;
          s = "update value";
      }

      int main() {
          int i = 0;
          std::string s("old value");
          std::thread t(func, std::ref(i), std::ref(s));
          t.join();

          std::cout << "i=" << i << "\n"
              << "s=" << s << std::endl;
          return 0;
      }
      ```
    + > 程序输出结果为：
      ```console
      i=1
      s=update value
      ```
- > **3 线程所有权管理**
  * > `std::thread`都是可移动，但不可拷贝，如下面示例：
    ```cpp
    #include <iostream>
    #include <thread>
    
    void f(int i) {
        std::cout << "Func, i=" << i << "\n";
    }
    
    std::thread gen_a_thread() {
        std::thread t(f, 2);
        return t;
    }
    
    int main() {
        std::thread t1(f, 1);
    
        //std::thread t2 = t1;  this is not allowed
    
        // transfer ownership, call move constructor
        std::thread t2 = std::move(t1);
        t2.join();
    
        // transfer ownership, call move constructor
        std::thread t3 = gen_a_thread();
        t3.join();
    }
    ```
  * > 输出为：
    ```console
    Func, i=1
    Func, i=2
    ```
  * > 对于需要`join`的线程，为了确保`join`一定会被调用，可以创建下面的thread_scope类，如下：
    ```cpp
    #include <iostream>
    #include <thread>
    #include <exception>
    
    void f(int i) {
        std::cout << "Func, i=" << i << "\n";
    }
    
    class ThreadScope {
    public:
        explicit ThreadScope(std::thread t): _t(std::move(t)) {
            if (!_t.joinable()) {
                throw std::logic_error("no thread");
            }
        }
    
        ~ThreadScope() {
            _t.join();
        }
    
        //disallow copy and assign
        ThreadScope(const ThreadScope& t) = delete;
        ThreadScope& operator=(const ThreadScope& t) = delete;
    
    private:
        std::thread _t;
    };
    
    int main() {
        ThreadScope ts(std::thread(f, 1));
    }
    ```
    >> //notes：（自己试了下）输出如下：
      ```console
      Func, i=1
      ```
  * > 可以将std::thread放入std::vector中，批量创建线程并且等待它们结束，示例如下：
    ```cpp
    #include <iostream>
    #include <thread>
    #include <vector>
    #include <sstream>
    #include <algorithm>

    void worker(int i) {
        std::stringstream ss;
        ss << "worker_";
        ss << i;
        ss << "\n";
        std::cout << ss.str();
    }

    int main() {
        const size_t WORKER_NUM = 20;
        std::vector<std::thread> threads;
        for (auto i = 0; i < WORKER_NUM; ++i) {
            threads.emplace_back(std::thread(worker, i));
        }

        std::for_each(threads.begin(), threads.end(), std::mem_fn(&std::thread::join));
    }
    ```
    >> //notes：（自己试了下）输出就是一堆`worker_i`，由于OS调用顺序不可控，每次运行不一样，这里随便贴一次运行的结果。
      ```console
      worker_3
      worker_2
      worker_5
      worker_6
      worker_1
      worker_0
      worker_7
      worker_4
      worker_8
      worker_9
      worker_10
      worker_11
      worker_13
      worker_12
      worker_14
      worker_15
      worker_17
      worker_16
      worker_19
      worker_18
      ```
- > **4 线程标志**
  * > 线程标识类型是`std::thread::id`，可以通过两种方式进行检索。第一种，可以通过调用`std::thread`对象的成员函数`get_id()`来直接获取。如果`std::thread`对象没有与任何执行线程相关联，`get_id()`将返回`std::thread::type`默认构造值，这个值表示“没有线程”。第二种，当前线程中调用`std::this_thread::get_id()`。示例代码如下：
    ```cpp
    #include <iostream>
    #include <thread>
    #include <vector>
    #include <sstream>
    #include <algorithm>
    
    void worker(int i) {
        std::stringstream ss;
        ss << std::this_thread::get_id() << "\n";
        std::cout << ss.str();
    }
    
    int main() {
        const size_t WORKER_NUM = 5;
        std::vector<std::thread> threads;
        for (auto i = 0; i < WORKER_NUM; ++i) {
            threads.emplace_back(std::thread(worker, i));
        }
        std::for_each(threads.begin(), threads.end(), std::mem_fn(&std::thread::join));
    }
    ```
  * > 输出如下：
    ```console
    139865582319360
    139865571829504
    139865561339648
    139865540359936
    139865550849792
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 个人实战（文章1）

## 关于 2.2 引用传参部分自己的实验

```cpp
// func第一个vector参数如果是传值的方式，下面的代码没问题。

#include <iostream>
#include <thread>
#include <vector>
#include <algorithm>
using namespace std;
void func(vector<int> v, size_t start, size_t n, int* maxElem) {
    vector<int>::iterator maxElemIterator = max_element(v.begin() + start, v.begin() + start + n);
    *maxElem = *maxElemIterator;
    std::cout << "input index is from: " << start << " to: " << start + n << "\n";
    std::cout << "max value in this scope is: " << *maxElem << "\n";
}
int main() {
    int* max1 = new int(0);
    int* max2 = new int(0);
    int* max3 = new int(0);
    std::vector<int> v{3, 1, 4, 1, 5, 9, 8, 9, 10, 7, 12, 6};

    std::thread t1(func, v, 0, 4, max1);
    t1.join();
    std::thread t2(func, v, 4, 4, max2);
    t2.join();
    std::thread t3(func, v, 8, 4, max3);
    t3.join();

    std::cout << max(max(*max1, *max2), *max3) << "\n";
    delete max1;
    delete max2;
    delete max3;
    return 0;
}
//////////////////////////////////////////////////
$ g++ -lpthread not_ref_pass_param.cpp -o not_ref_pass_param
$ ./not_ref_pass_param 
input index is from: 0 to: 4
max value in this scope is: 4
input index is from: 4 to: 8
max value in this scope is: 9
input index is from: 8 to: 12
max value in this scope is: 12
12
```

```cpp
// 但是只要稍加修改，func第一个vector参数如果变成传引用的方式，上面的代码就不行了。
// 必须把 main 函数里 thread 里传的参数从 v 变成 std::ref(v)。

#include <iostream>
#include <thread>
#include <vector>
#include <algorithm>
using namespace std;
void func(vector<int>& v, size_t start, size_t n, int* maxElem) {
    vector<int>::iterator maxElemIterator = max_element(v.begin() + start, v.begin() + start + n);
    *maxElem = *maxElemIterator;
    std::cout << "input index is from: " << start << " to: " << start + n << "\n";
    std::cout << "max value in this scope is: " << *maxElem << "\n";
}
int main() {
    int* max1 = new int(0);
    int* max2 = new int(0);
    int* max3 = new int(0);
    std::vector<int> v{3, 1, 4, 1, 5, 9, 8, 9, 10, 7, 12, 6};

    std::thread t1(func, std::ref(v), 0, 4, max1);
    t1.join();
    std::thread t2(func, std::ref(v), 4, 4, max2);
    t2.join();
    std::thread t3(func, std::ref(v), 8, 4, max3);
    t3.join();

    std::cout << max(max(*max1, *max2), *max3) << "\n";
    delete max1;
    delete max2;
    delete max3;
    return 0;
}
//////////////////////////////////////////////////
$ g++ -lpthread ref_pass_param.cpp -o ref_pass_param
$ ./ref_pass_param 
input index is from: 0 to: 4
max value in this scope is: 4
input index is from: 4 to: 8
max value in this scope is: 9
input index is from: 8 to: 12
max value in this scope is: 12
12
```

```cpp
// 1.基本类型（如int）也可以在 func 里用引用方式，相应的 main 里给它传参的地方要用 std::ref。
// 2.传参如果是非引用的，实际传递时用 std::ref 包起来同样没问题。

#include <iostream>
#include <thread>
#include <vector>
#include <algorithm>
using namespace std;
void func(vector<int> v, size_t start, size_t n, int& maxElem) {
    vector<int>::iterator maxElemIterator = max_element(v.begin() + start, v.begin() + start + n);
    maxElem = *maxElemIterator;
    std::cout << "input index is from: " << start << " to: " << start + n << "\n";
    std::cout << "max value in this scope is: " << maxElem << "\n";
}
int main() {
    int max1 = 0;
    int max2 = 0;
    int max3 = 0;
    std::vector<int> v{3, 1, 4, 1, 5, 9, 8, 9, 10, 7, 12, 6};

    std::thread t1(func, std::ref(v), 0, 4, std::ref(max1));
    t1.join();
    std::thread t2(func, std::ref(v), 4, 4, std::ref(max2));
    t2.join();
    std::thread t3(func, std::ref(v), 8, 4, std::ref(max3));
    t3.join();
    
    std::cout << max(max(max1, max2), max3) << "\n";
    return 0;
}
//////////////////////////////////////////////////
$ g++ -lpthread ref_pass_param.cpp -o ref_pass_param
$ ./ref_pass_param 
input index is from: 0 to: 4
max value in this scope is: 4
input index is from: 4 to: 8
max value in this scope is: 9
input index is from: 8 to: 12
max value in this scope is: 12
12
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

C++多线程获取返回值方法详解 https://www.jb51.net/article/189512.htm || http://www.cppcns.com/ruanjian/c/323440.html || http://blog.itpub.net/69955379/viewspace-2702825/
