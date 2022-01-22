
# 1

C++ decltype类型推导完全攻略 http://c.biancheng.net/view/7151.html
- > `decltype` 是 C++11 新增的一个关键字，它和 `auto` 的功能一样，都用来在编译时期进行自动类型推导。不了解 `auto` 用法的读者请转到《[C++ auto](http://c.biancheng.net/view/6984.html)》。
- > `decltype` 是“***declare type***”的缩写，译为“声明类型”。
- > `auto` 和 `decltype` 关键字都可以自动推导出变量的类型，但它们的用法是有区别的：
  ```cpp
  auto varname = value;
  decltype(exp) varname = value;
  ```
  > 其中，varname 表示变量名，value 表示赋给变量的值，exp 表示一个表达式。
- > `auto` 根据 `=` 右边的初始值 value 推导出变量的类型，而 `decltype` 根据 exp 表达式推导出变量的类型，***跟 `=` 右边的 value 没有关系***。
- > 另外，`auto` ***要求变量必须初始化，而 `decltype` 不要求***。这很容易理解，`auto` 是根据变量的初始值来推导出变量类型的，如果不初始化，变量的类型也就无法推导了。`decltype` 可以写成下面的形式：
  ```cpp
  decltype(exp) varname;
  ```
- > 原则上讲，exp 就是一个普通的表达式，它可以是任意复杂的形式，***但是我们必须要保证 exp 的结果是有类型的，不能是 `void`***；例如，当 exp 调用一个返回值类型为 `void` 的函数时，exp 的结果也是 `void` 类型，此时就会导致编译错误。C++ `decltype` 用法举例：
  ```cpp
  int a = 0;
  decltype(a) b = 1;  //b 被推导成了 int
  decltype(10.8) x = 5.5;  //x 被推导成了 double
  decltype(x + 100) y;  //y 被推导成了 double
  ```
- > **`decltype` 推导规则**
  * > 上面的例子让我们初步感受了一下 `decltype` 的用法，但你不要认为 `decltype` 就这么简单，它的玩法实际上可以非常复杂。当程序员使用 `decltype(exp)` 获取类型时，编译器将根据以下三条规则得出结果：
    + > 如果 exp 是一个不被括号`( )`包围的表达式，或者是一个类成员访问表达式，或者是一个单独的变量，那么 `decltype(exp)` 的类型就和 exp 一致，这是最普遍最常见的情况。
    + > 如果 exp 是函数调用，那么 `decltype(exp)` 的类型就和函数返回值的类型一致。
    + > 如果 exp 是一个左值，或者被括号`( )`包围，那么 `decltype(exp)` 的类型就是 `exp 的引用`；假设 exp 的类型为 T，那么 `decltype(exp)` 的类型就是 `T&`。
- > 【实例1】exp 是一个普通表达式：
  ```cpp
  #include <string>
  using namespace std;
  
  class Student{
  public:
      static int total;
      string name;
      int age;
      float scores;
  };
  int Student::total = 0;
  
  int  main(){
      int n = 0;
      const int &r = n;
      Student stu;
      decltype(n) a = n;                  //n 为 int 类型，a 被推导为 int 类型
      decltype(r) b = n;                  //r 为 const int& 类型, b 被推导为 const int& 类型
      decltype(Student::total) c = 0;     //total 为类 Student 的一个 int 类型的成员变量，c 被推导为 int 类型
      decltype(stu.name) url = "http://c.biancheng.net/cplus/";   //total 为类 Student 的一个 string 类型的成员变量， url 被推导为 string 类型
      return 0;
  }
  ```
  > 这段代码很简单，按照推导规则 1，对于一般的表达式，decltype 的推导结果就和这个表达式的类型一致。

## 个人（部分修改后）实战文章中代码

```cpp
#include <string>
#include<iostream>
#include<typeinfo>
using namespace std;

class Student{
public:
    static int total;
    string name;
    int age;
    float scores;
};

int Student::total = 0;

int  main(){
    int n = 0;
    const int &r = n;
    Student stu;
    decltype(n) a = n;                  //n 为 int 类型，a 被推导为 int 类型
    decltype(r) b = n;                  //r 为 const int& 类型, b 被推导为 const int& 类型
    decltype(Student::total) c = 0;     //total 为类 Student 的一个 int 类型的成员变量，c 被推导为 int 类型
    decltype(stu.name) url = "http://c.biancheng.net/cplus/";   //total 为类 Student 的一个 string 类型的成员变量， url 被推导为 string 类型
    
    cout << typeid(a).name() << endl;
    cout << typeid(b).name() << endl;
    cout << typeid(c).name() << endl;
    cout << typeid(url).name() << endl;
    return 0;
}
```
```console
# 在 cpp.sh 里的结果是这样的：
i
i
i
Ss
```
```
# 在 paiza.io 里的结果是这样的：
i
i
i
NSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE
```
