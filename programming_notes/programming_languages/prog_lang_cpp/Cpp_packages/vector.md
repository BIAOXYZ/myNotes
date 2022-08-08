
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
- **Element access**:
  * std::vector::data https://www.cplusplus.com/reference/vector/vector/data/
- **Modifiers**:
  * std::vector::assign http://www.cplusplus.com/reference/vector/vector/assign/
    + > Assigns new contents to the vector, replacing its current contents, and modifying its size accordingly.
  * std::vector::push_back http://www.cplusplus.com/reference/vector/vector/push_back/
  * std::vector::pop_back https://www.cplusplus.com/reference/vector/vector/pop_back/
  * std::vector::insert https://www.cplusplus.com/reference/vector/vector/insert/
  * std::vector::erase https://www.cplusplus.com/reference/vector/vector/erase/
  * std::vector::emplace_back http://www.cplusplus.com/reference/vector/vector/emplace_back/

## cppreference

std::vector<T,Allocator>::emplace_back https://en.cppreference.com/w/cpp/container/vector/emplace_back

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 注意点

## vector没有 `.find()` 方法
>> //notes：起因是今天刷题时候碰到一个要用 `unordered_set` 的题目，然后发现 `unordered_set` 都有自带的 `.find()` 和 `.count()` 方法，然而 `vector` 却没有。。。只能用 `<algorithm>` 库里公共的。

c++判断vector中是否存在特定元素的方法 https://blog.csdn.net/guotianqing/article/details/105832070
- > 1. `std::count`
- > 2. `std::find`
  * > find会在查找到指定值后立即返回，所以它一般比count更快（因为count总是要遍历整个容器）。
  * > 上述代码只需要更改条件判断语句：
    ```cpp
    if (std::find(v.begin(), v.end(), key) != v.end())
    ```
- > 3. `std::find_if`
- > 4. `std::any_of` (C++11)
- > 5. `std::binary_search`

C++的vector居然没有find成员函数啊， 那就用泛型find吧 https://blog.csdn.net/stpeace/article/details/51112249

why there is no find for vector in C++ https://stackoverflow.com/questions/2994073/why-there-is-no-find-for-vector-in-c
- > There is the `std::find()` algorithm, which performs a linear search over an iterator range, e.g.,
  ```cpp
  std::vector<int> v;
  // Finds the first element in the vector that has the value 42:
  // If there is no such value, it == v.end()
  std::vector<int>::const_iterator it = std::find(v.begin(), v.end(), 42);
  ```
  > If your vector is sorted, you can use `std::binary_search()` to test whether a value is present in the vector, and `std::equal_range()` to get begin and end iterators to the range of elements in the vector that have that value.

## 其他

C++：如何高效的使用std::vector？ https://blog.csdn.net/netyeaxi/article/details/83277810

C++：关于std::vector两个方法operator[]和at使用上的区别 https://blog.csdn.net/netyeaxi/article/details/82765703

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `.assign()`

What's difference between those two std::vector's assign methods? https://stackoverflow.com/questions/18492750/whats-difference-between-those-two-stdvectors-assign-methods

C++中vector容器 assign()用法 https://blog.csdn.net/liyuan_669/article/details/22104421

# `.data()`

STL vector中的data方法(21) https://blog.csdn.net/qq844352155/article/details/38610645
- > 原文地址:http://www.cplusplus.com/reference/vector/vector/data/
- > 返回一个直接指向内存中存储vector元素位置的指针。
```cpp
#include <iostream>
#include <vector>
using namespace std;
int main()
{
	vector<int> vi={1,20,30};
	cout<<"vi.capacity="<<vi.capacity()<<endl;
	cout<<"vi.data()="<<vi.data()<<endl;
	auto *p=vi.data();
	cout<<"p="<<p<<endl;
	cout<<"*p="<<*p<<endl;
	cout<<"*(p+2)="<<*(p+2)<<endl;
	cout<<"*(p+10)="<<*(p+10)<<endl;	
	cout<<"vi.capacity="<<vi.capacity()<<endl;
}
//////////////////////////////////////////////////
vi.capacity=3
vi.data()=0x3ea8120
p=0x3ea8120
*p=1
*(p+2)=30
*(p+10)=0
vi.capacity=3
```

vector data() function in C++ STL https://www.geeksforgeeks.org/vector-data-function-in-c-stl/

# `.emplace_back()`

c++11 之emplace_back 与 push_back的区别 https://ppipp.blog.csdn.net/article/details/84764104
- > c++开发中我们会经常用到插入操作对stl的各种容器进行操作，比如vector,map,set等。在引入右值引用，转移构造函数，转移复制运算符之前，通常使用push_back()向容器中加入一个右值元素(临时对象)时，首先会调用构造函数构造这个临时对象，然后需要调用拷贝构造函数将这个临时对象放入容器中。原来的临时变量释放。这样造成的问题就是临时变量申请资源的浪费。 
- > 引入了右值引用，转移构造函数后，push_back()右值时就会调用构造函数和转移构造函数,如果可以在插入的时候直接构造，就只需要构造一次即可。这就是c++11 新加的emplace_back。

emplace_back() 和 push_back 的区别 https://blog.csdn.net/xiaolewennofollow/article/details/52559364

C++：使用std::vector.emplace_back后为什么还是会调用对象的拷贝构造函数？ https://blog.csdn.net/netyeaxi/article/details/83242362

## 能否完全取代 push_back

C++emplace_back能完全代替push_back吗？ - 知乎 https://www.zhihu.com/question/387522517
- C++emplace_back能完全代替push_back吗？ - 知乎 https://www.zhihu.com/question/387522517/answer/1152172397
  * > 不过这些属于特殊情况，大部分情况下用emplace替代insert是没问题的。

c++中有什么 push和insert可以但emplace做不到的操作么？ - 知乎 https://www.zhihu.com/question/347743586

Are there any cases where it is incorrect to replace push_back with emplace_back? https://stackoverflow.com/questions/22080290/are-there-any-cases-where-it-is-incorrect-to-replace-push-back-with-emplace-back

Should I replace all calls to push_back with emplace_back? https://stackoverflow.com/questions/22468837/should-i-replace-all-calls-to-push-back-with-emplace-back

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

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

vector的几种初始化及赋值方式 https://blog.csdn.net/yjunyu/article/details/77728410

vector 的六种 创建和初始化方法 https://blog.csdn.net/veghlreywg/article/details/80400382

在C++中，初始化 vector 为1-n https://blog.csdn.net/qq_43657442/article/details/116190200
```cpp
#include <algorithm>     //这是 random_shuffle 的头文件
#include <iostream>
#include <numeric>     //这是 iota 的头文件
#include <vector>
using namespace std;
int main() {
    vector<int> v(10);
    iota(v.begin(), v.end(), -1);
    for (auto i : v) {
        cout << i << ' ';
    }
    cout << '\n';
    std::random_shuffle(v.begin(), v.end());
    cout << "Contents of the list, shuffled: ";
    for (auto i : v) {
        cout << i << ' ';
    }
    cout << '\n';
}
```
```console
-1 0 1 2 3 4 5 6 7 8 
Contents of the list, shuffled: 3 2 6 7 -1 4 1 0 5 8 
```
- > 更多方法请参考StackOverflow上的此问题：[use std::fill to populate vector with increasing numbers](https://stackoverflow.com/questions/17694579/use-stdfill-to-populate-vector-with-increasing-numbers)

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

## 额外的问题：`vec.begin()` 和 `std::begin(vec)` 的区别

Difference between `vector::begin()` and `std::begin()` https://stackoverflow.com/questions/26290316/difference-between-vectorbegin-and-stdbegin
- https://stackoverflow.com/questions/26290316/difference-between-vectorbegin-and-stdbegin/26290337#26290337
  * > `std::begin()` was added in `C++11` to make it easier to write generic code (e.g. in templates). The most obvious reason for it is that plain C-style arrays do not have methods, hence no `.begin()`. So you can use `std::begin()` with C-style arrays, as well as STL-style containers having their own `begin()` and `end()`.
  * > If you're writing code which is not a template, you can ignore `std::begin()`; your fellow programmers would probably find it odd if you suddenly started using it everywhere just because it's new.

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
- > This can easily be done using std::vector's copy constructor:
  ```cpp
  v2 = std::vector<int>(v1.begin() + 1, v1.end());
  ```

# 获取vector的下标

Find the index of an element in vector in C++ https://www.techiedelight.com/find-index-element-vector-cpp/

vector查找数据并返回索引 https://blog.csdn.net/weixin_43956456/article/details/104731517
```cpp
#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
using namespace std;
int main()
{
	vector<int> arr = {3, 4, 9, 100};
	int target = 100;
	vector<int>::iterator result = find(arr.begin(), arr.end(), target);
	int index = distance(arr.begin(), result);
	cout << "target index is: " << index << endl;
	system("pause");
}
//////////////////////////////////////////////////
target index is: 3
```

How to find index of a given element in a Vector in C++ https://www.geeksforgeeks.org/how-to-find-index-of-a-given-element-in-a-vector-in-cpp/

Get index of the matching item from vector c++ https://stackoverflow.com/questions/22388204/get-index-of-the-matching-item-from-vector-c

**LeetCode相关题目**：
- `1380. 矩阵中的幸运数`https://github.com/BIAOXYZ/variousCodes/blob/ba06b3debdce686f385b0bb88678269304bee409/_CodeTopics/LeetCode/1201-1400/001380--weekly180_1/tran/180_1.cpp

# vector去重

vector 去重方法 https://leetcode-cn.com/circle/article/71vyHt/
- > 使用 `set`
  ```cpp
  #include <iostream>
  #include <vector>
  #include <set>
  using namespace std;
  int main()
  {
      vector<int> vec = {1, 2, 3, 1, 1};
      set<int> s(vec.begin(), vec.end());
      vec.assign(s.begin(), s.end());
      for(int x : vec)
          cout << x << ",";
      return 0;
  }
  //////////////////////////////////////////////////
  1,2,3, 
  ```
- > 使用 `unique()`
  ```cpp
  #include <iostream>
  #include <algorithm>
  #include <vector>
  using namespace std;
  int main()
  {
      vector<int> vec = {1, 2, 3, 1, 1};
      sort(vec.begin(), vec.end());
      vec.erase(unique(vec.begin(), vec.end()), vec.end());
      for(int x : vec)
          cout << x << ",";
      return 0;
  }
  //////////////////////////////////////////////////
  1,2,3, 
  ```

# vector求和

C++ - Vector 计算 均值(mean) 和 方差(variance) https://blog.csdn.net/MissXy_/article/details/80702375

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

# vector指定位置插入元素

C++ STL vector插入元素（insert()和emplace()）详解 http://c.biancheng.net/view/6834.html
```cpp
#include <iostream> 
#include <vector> 
#include <array> 
using namespace std;
int main()
{
    std::vector<int> demo{1,2};
    //第一种格式用法
    demo.insert(demo.begin() + 1, 3);//{1,3,2}
    //第二种格式用法
    demo.insert(demo.end(), 2, 5);//{1,3,2,5,5}
    //第三种格式用法
    std::array<int,3>test{ 7,8,9 };
    demo.insert(demo.end(), test.begin(), test.end());//{1,3,2,5,5,7,8,9}
    //第四种格式用法
    demo.insert(demo.end(), { 10,11 });//{1,3,2,5,5,7,8,9,10,11}
    for (int i = 0; i < demo.size(); i++) {
        cout << demo[i] << " ";
    }
    return 0;
}
/////////////////////////////////////////////
运行结果为：
1 3 2 5 5 7 8 9 10 11
```

## 两个vector合并

What is the best way to concatenate two vectors? https://ow.com/questions/3177241/what-is-the-best-way-to-concatenate-two-vectors
- https://stackoverflow.com/questions/3177241/what-is-the-best-way-to-concatenate-two-vectors/3177254#3177254
  * > This is precisely what the member function `std::vector::insert` is for
    ```cpp
    std::vector<int> AB = A;
    AB.insert(AB.end(), B.begin(), B.end());
    ```
- https://stackoverflow.com/questions/3177241/what-is-the-best-way-to-concatenate-two-vectors/3177252#3177252
  * > 
    ```cpp
    AB.reserve( A.size() + B.size() ); // preallocate memory
    AB.insert( AB.end(), A.begin(), A.end() );
    AB.insert( AB.end(), B.begin(), B.end() );
    ```
- https://stackoverflow.com/questions/3177241/what-is-the-best-way-to-concatenate-two-vectors/3178194#3178194
  * > Depends on whether you really need to physically concatenate the two vectors or you want to give the appearance of concatenation of the sake of iteration. The `boost::join` function ( http://www.boost.org/doc/libs/1_43_0/libs/range/doc/html/range/reference/utilities/join.html ) will give you this.
  * > Note `boost::join` does not copy the two vectors into a new container but generates a pair of iterators (range) that cover the span of both containers. There will be some performance overhead but maybe less that copying all the data to a new container first.

C++ extend a vector with another vector https://stackoverflow.com/questions/313432/c-extend-a-vector-with-another-vector
- https://stackoverflow.com/questions/313432/c-extend-a-vector-with-another-vector/313444#313444
  * > From http://www.cplusplus.com/reference/vector/vector/insert/
    ```cpp
    // reserve() is optional - just to improve performance
    v.reserve(v.size() + distance(v_prime.begin(),v_prime.end()));
    v.insert(v.end(),v_prime.begin(),v_prime.end());
    ```

**LeetCode相关题目**：
- `1447. 最简分数` https://leetcode-cn.com/problems/simplified-fractions/
  * https://leetcode-cn.com/submissions/detail/266460472/

# vector倒序排序

How to sort a standard array in descending order - C++ 11 https://stackoverflow.com/questions/58054564/how-to-sort-a-standard-array-in-descending-order-c-11

Sort an array in descending order in C++ https://www.techiedelight.com/sort-array-descending-order-cpp/

LeetCode题目：
- `1996. 游戏中弱角色的数量` https://leetcode-cn.com/problems/the-number-of-weak-characters-in-the-game/
