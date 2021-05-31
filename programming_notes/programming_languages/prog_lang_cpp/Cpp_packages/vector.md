
# 官方

## cplusplus

`header <vector>` http://www.cplusplus.com/reference/vector/

std::vector http://www.cplusplus.com/reference/vector/vector/
- **Iterators**:
  * std::vector::begin http://www.cplusplus.com/reference/vector/vector/begin/
    + > Return value
      - > ***An iterator pointing to the new location of the element that followed the last element erased by the function call***. This is the container end if the operation erased the last element in the sequence.
- **Capacity**:
  * std::vector::resize http://www.cplusplus.com/reference/vector/vector/resize/
- **Modifiers**:
  * std::vector::push_back http://www.cplusplus.com/reference/vector/vector/push_back/
  * std::vector::emplace_back http://www.cplusplus.com/reference/vector/vector/emplace_back/

## cppreference

std::vector<T,Allocator>::emplace_back https://en.cppreference.com/w/cpp/container/vector/emplace_back

# `.emplace_back()`

c++11 之emplace_back 与 push_back的区别 https://ppipp.blog.csdn.net/article/details/84764104

# 其他

Vector in C++ STL https://www.geeksforgeeks.org/vector-in-cpp-stl/

What are Vectors in C++ ? All You Need to Know https://www.edureka.co/blog/vectors-in-cpp/
- > Vectors in C++ are sequence containers representing arrays that can change in size. They use contiguous storage locations for their elements, which means that their elements can also be accessed using offsets on regular pointers to its elements, and just as efficiently as in arrays.
- > Vectors in C++ are the dynamic arrays that are used to store data. Unlike arrays, which are used to store sequential data and are static in nature, Vectors provide more flexibility to the program. Vectors can resize itself automatically when an element is inserted or deleted depending on the need of the task to be executed. It is not the same in an array where only a given number of values can be stored under a single variable name.

# vector初始化

C++-二维vector初始化大小方法-备忘 https://www.cnblogs.com/ZERO-/p/9736482.html
- > 1.直接用初始化方法。名字为vec，大小为n*m，初始值为0的二维vector。
  ```cpp
  vector<vector<int> > vec(n, vector<int>(m, 0));
  ```
- > 2.用resize()来控制大小
  ```cpp
  vector<vector<int> > vec;
      vec.resize(n);//n行
      for (int i = 0; i < n; ++i){
          vec[i].resize(m);//每行为m列
      }
  ```

C++ vector的初始化 https://blog.csdn.net/qq_40147449/article/details/87892312

vector 的六种 创建和初始化方法 https://blog.csdn.net/veghlreywg/article/details/80400382

# vector元素访问

C++获得vector最后一个元素 https://blog.csdn.net/mitu405687908/article/details/51148107
```cpp
std::vector<int> intVector;
intVector[intVector.size() - 1]; // 方式1
intVector.back();                // 方式2
```

容器篇：取vector最后一个元素的方法 https://blog.csdn.net/Angry_chicken_wings/article/details/5799639
```cpp
方法一：
vector<T>::iterator pt = vectorT.end()-1;
T lastT = *pt;

方法二：
vectorT.back();

方法三：
*vectorT.rbegin();
```

# 对 vector 做一些操作可能会使得当前迭代器失效 
>> //notes：起因是在用C++做leetcode第27题时，想用类似python的倒序遍历删除，发现不行。

c++中vector的遍历及元素删除 https://blog.csdn.net/dds_dev_group/article/details/6951441
```cpp
#include <vector>
#include <iostream>
using namespace std;
int main()
{
    vector<int> test_vec;
    for (int i = 0; i < 5; i++)
    {
        test_vec.push_back(i);
    }
    for(vector<int>::iterator it = test_vec.begin(); it != test_vec.end(); )
    {
        cout<<*(it)<<endl;
        it = test_vec.erase(it);
    }
    cout << "after delete, the length is: " << test_vec.size() << endl;
    return 0;
}
//////////////////////////////////////////////////
0
1
2
3
4
after delete, the length is: 0
```
```cpp
#include <vector>
#include <iostream>
using namespace std;
int main()
{
    vector<int> test_vec;
    for (int i = 0; i < 5; i++)
    {
        test_vec.push_back(i);
    }
    for(vector<int>::iterator it  = test_vec.begin(); it != test_vec.end(); ++it)
    {
        cout<<*(it)<<endl;
        test_vec.erase(it);
    }
    cout << "after delete, the length is: " << test_vec.size() << endl;
    return 0;
//////////////////////////////////////////////////
0
2
4
4
exited, segmentation fault
```

面试题：vector迭代器什么时候会失效？ https://blog.csdn.net/weixin_49199646/article/details/109264858

C++ Primer：vector插入元素时迭代器失效问题 https://www.jianshu.com/p/6f08b1d4271a
- > 5. 总结
  * > 1. 当 `size() == capacity()`，插入元素时vector会被重新分配内存，指向元素的迭代器都会失效。
  * > 2. 当 `size() < capacity()`，插入元素时vector不会被重新分配内存。此时，若迭代器指向插入位置之前的元素，它仍有效；若迭代器指向插入位置之后的元素，它将会失效。

# vector切片

Slicing a vector in C++ https://stackoverflow.com/questions/50549611/slicing-a-vector-in-c/50549636

# vector整个打印

【[:star:][`*`]】 How do I print out the contents of a vector? https://stackoverflow.com/questions/10750057/how-do-i-print-out-the-contents-of-a-vector
- https://stackoverflow.com/questions/10750057/how-do-i-print-out-the-contents-of-a-vector/10758845#10758845
  ```cpp
  #include <iterator> // needed for std::ostram_iterator
  
  template <typename T>
  std::ostream& operator<< (std::ostream& out, const std::vector<T>& v) {
    if ( !v.empty() ) {
      out << '[';
      std::copy (v.begin(), v.end(), std::ostream_iterator<T>(out, ", "));
      out << "\b\b]";
    }
    return out;
  }
  ```

C++ Vector : Print all elements – (6 Ways) https://thispointer.com/cpp-vector-print-all-elements/

# vector作为参数

C++：vector小指南（附带一些新手错误） - Feng的文章 - 知乎 https://zhuanlan.zhihu.com/p/336492399

C++（笔记）容器(vector)作为函数参数如何传参 https://blog.csdn.net/w_linux/article/details/72417896

vector作为参数的三种传参方式 https://www.cnblogs.com/xiaoxi666/p/6843211.html
