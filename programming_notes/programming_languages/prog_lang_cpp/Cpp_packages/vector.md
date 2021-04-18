
# 官方

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

# 其他

Vector in C++ STL https://www.geeksforgeeks.org/vector-in-cpp-stl/

What are Vectors in C++ ? All You Need to Know https://www.edureka.co/blog/vectors-in-cpp/
- > Vectors in C++ are sequence containers representing arrays that can change in size. They use contiguous storage locations for their elements, which means that their elements can also be accessed using offsets on regular pointers to its elements, and just as efficiently as in arrays.
- > Vectors in C++ are the dynamic arrays that are used to store data. Unlike arrays, which are used to store sequential data and are static in nature, Vectors provide more flexibility to the program. Vectors can resize itself automatically when an element is inserted or deleted depending on the need of the task to be executed. It is not the same in an array where only a given number of values can be stored under a single variable name.

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

## 对 vector 做一些操作可能会使得当前迭代器失效 
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
