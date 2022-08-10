
# 打印二维vector时的 Segmentation fault
>> 【[:star:][`*`]】 //notes：如果内层vector（也就是“列”）下标超了，表现行为依赖具体的编译器；如果外层vector（也就是“行”）下标超了，就会出现Segmentation fault。例子如下：
```cpp
#include <iostream>
#include <vector>
using namespace std;
vector<vector<int>> func1() {
    vector<vector<int>> vec = {{1,2,3,4},{5,6,7,8}};
    return vec;
}
int main() {
    vector<vector<int>> v;
    v = func1();
    cout << "**********Start**********" << endl;
    cout << "**********1.normal print**********" << endl;
    for (int i = 0; i < 2; ++i) {
        for (int j = 0; j < 4; ++j) {
            cout << v[i][j] << " ";
        } 
        cout << endl;
    }
    cout << "**********2.print more index of inner vector**********" << endl;
    for (int i = 0; i < 2; ++i) {
        for (int j = 0; j < 6; ++j) {
            cout << v[i][j] << " ";
        } 
        cout << endl;
    }
    cout << "**********3.print more index of outter vector (will segmentation fault)**********" << endl;
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 4; ++j) {
            cout << v[i][j] << " ";
        } 
        cout << endl;
    }
    cout << "**********End**********" << endl;
    return 0;
}
```
```console
**********Start**********
**********1.normal print**********
1 2 3 4 
5 6 7 8 
**********2.print more index of inner vector**********
1 2 3 4 0 0 
5 6 7 8 0 0 
**********3.print more index of outter vector (will segmentation fault)**********
1 2 3 4 
5 6 7 8 
Segmentation fault
```

# `error: invalid initialization of non-const reference`
>> //notes：起因是之前一个函数可以正常用，但是后来发现会报错。查了下报错信息，又对比了对的用法和错的用法的区别，知道为啥了。
```cpp
// 原函数 stackoverflow 的地址（https://stackoverflow.com/questions/26094379/typecasting-eigenvectorxd-to-stdvector）
std::vector<double> eigen_vec_to_std_vec(Eigen::VectorXd& v1) {
    std::vector<double> v2(v1.size());
    Eigen::VectorXd::Map(&v2[0], v1.size()) = v1;
    return v2;
}

// 对的用法：
Eigen::VectorXd feature_values_eigen = curr_data.col(index);
std::vector<double> feature_values = eigen_vec_to_std_vec(feature_values_eigen);

// 错的用法：
std::vector<double> label = eigen_vec_to_std_vec(this->data.leftCols(1));

// 错的用法改对后：
Eigen::VectorXd label_eigen = this->data.leftCols(1);
std::vector<double> label = eigen_vec_to_std_vec(label_eigen);


// --> 其实很明显了，再加上对比下面的例子，简单点说就是：既然你传了个引用进去，编译器就认为“你就是要改你传进去的参数”（编译器你很闲嘛？？？）
//     但是错误的用法里其实是传了个表达式（更准确说是右值）进去，这表达式（右值）又是不能修改的，于是编译器就报错了。
//     懂了道理后，另一种改法也很简单：函数参数不要传引用类型，就能直接“一行的那种方式”用了。比如下面的就可以编过了。
std::vector<double> eigen_vec_to_std_vec(Eigen::VectorXd v1) {
    std::vector<double> v2(v1.size());
    Eigen::VectorXd::Map(&v2[0], v1.size()) = v1;
    return v2;
}
std::vector<double> label = eigen_vec_to_std_vec(this->data.leftCols(1));
```

error: invalid initialization of non-const reference of type ‘int&’ from an rvalue of type ‘int’ https://stackoverflow.com/questions/8293426/error-invalid-initialization-of-non-const-reference-of-type-int-from-an-rval

临时变量不能作为非const引用 https://blog.csdn.net/itworld123/article/details/90488575
```cpp
int func(a)
{
    return a;
}
 
int main()
{
    int r = func(3 + 5);
    return 0;
}
```
- > 上述代码报错，**非常量引用的初始值必须为左值**。主要原因如下：
- > c++编译器的一个关于语义的限制。如果一个参数是以非const引用传入，c++编译器就有理由认为程序员会在函数中修改这个值，并且这个被修改的引用在函数返回后要发挥作用。但如果你把一个临时变量当作非const引用参数传进来，由于临时变量的特殊性，程序员并不能操作临时变量，而且临时变量随时可能被释放掉，所以，一般说来，修改一个临时变量是毫无意义的，据此，c++编译器加入了临时变量不能作为非const引用的这个语义限制，意在限制这个非常规用法的潜在错误。

这段程序怎么解读？ - 知乎 https://www.zhihu.com/question/20759966

# `basic_string::_M_construct null not valid`
>> //notes：报这个错的最常见原因是 `std::string` 初始化时用了 `0`，此时 `0` 会被编译器隐式地转化成一个 `const char *` 的指针。然而，对于 `std::string` 的构造函数，接受一个空的 `char *` 指针将产生**undefined behavior**。解决方法也很简单，用 `""` 初始化即可。

```cpp
#include <iostream>
#include <string>
using namespace std;

int main()
{
    string s1 = "abc";
    cout << "s1 is: " << s1 << endl;

    string s2 = "";
    cout << "s2 is: " << s2 << endl;
    
    string s3 = 0;
    cout << "s3 is: " << s3 << endl;

    return 0;
}
//////////////////////////////////////////////////
$ g++ -o main *.cpp
$ ./main
s1 is: abc
s2 is: 
terminate called after throwing an instance of 'std::logic_error'
  what():  basic_string::_M_construct null not valid
```

How to fix 'std::logic_error' what(): basic_string::_M_construct null not valid error? https://stackoverflow.com/questions/54429231/how-to-fix-stdlogic-error-what-basic-string-m-construct-null-not-valid
- https://stackoverflow.com/questions/54429231/how-to-fix-stdlogic-error-what-basic-string-m-construct-null-not-valid/54431896#54431896
  * > The problem is the two `return 0;` statements in your function. The function returns a `std::string`, which has no constructors that accept an `int` as input. But, it does have a constructor that accepts a `const char *` pointer, which `0` is implicitly convertible to. However, constructing a `std::string` with a ***null `char *`*** pointer is **undefined behavior**, and your implementation has chosen to throw a `std::logic_error` exception that you are not catching in your code.

c++的string类的模拟实现 以及basic_string::_M_construct null not valid错误的原因 https://blog.csdn.net/qq_44804546/article/details/92846512
