
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
