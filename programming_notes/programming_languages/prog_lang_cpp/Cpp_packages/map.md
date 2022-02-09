
# 官方

std::map https://www.cplusplus.com/reference/map/map/

# wiki

关联性容器 https://zh.wikipedia.org/wiki/%E5%85%B3%E8%81%94%E6%80%A7%E5%AE%B9%E5%99%A8 || Associative containers https://en.wikipedia.org/wiki/Associative_containers
- > 关联容器是指C++标准模板库中的一套类模板，实现了有序关联数组。可用于存放任意数据类型的元素。C++标准中定义的关联容器有：`set`,` map`, `multiset`, `multimap`。
- > 关联容器类似于C++中的[无序关联容器]()。差别为：
  * > 关联容器是[红黑树](https://zh.wikipedia.org/wiki/%E7%BA%A2%E9%BB%91%E6%A0%91)实现，无序关联容器是[哈希表](https://zh.wikipedia.org/wiki/%E5%93%88%E5%B8%8C%E8%A1%A8)实现。
  * > 关联容器保证按键值有序遍历，因此可以做范围查找，而无序关联容器不可以。关联支持一些导航类的操作，如求出给定键最邻近的键，最大键、最小键操作。
  * > 关联容器的迭代器不会失效，除非所指元素被删除。无序关联容器的 iterator 在修改元素时可能会失效。所以对关联容器的遍历与修改在一定程度上可并行。
  * > 哈希表查找时候要算hash，这个最坏时间复杂度是`O(key的长度)`；基于比较的有序关联容器通常只使用头几个字符进行比较。

# 其他

## map V.S. unordered_map

map vs unordered_map in C++ https://www.geeksforgeeks.org/map-vs-unordered_map-c/
- > Difference: 
- > Use `std::map` when 
  ```console
  · You need ordered data.
  · You would have to print/access the data (in sorted order).
  · You need predecessor/successor of elements.
  · See advantages of BST over Hash Table for more cases.
  ```
- > Use `std::unordered_map` when 
  ```console
  · You need to keep count of some data (Example – strings) and no ordering is required.
  · You need single element access i.e. no traversal.
  ```

C++基础-map与unordered_map - 罗晓的文章 - 知乎 https://zhuanlan.zhihu.com/p/48066839

c++ map与unordered_map区别及使用 https://blog.csdn.net/qq_21997625/article/details/84672775
```cpp
#include <iostream>  
#include <unordered_map>  
#include <map>
#include <string>  
using namespace std;  
int main()  
{  
    //注意：C++11才开始支持括号初始化
    unordered_map<int, string> myMap={{ 5, "张大" },{ 6, "李五" }};  //使用{}赋值
    myMap[2] = "李四";  //使用[ ]进行单个插入，若已存在键值2，则赋值修改，若无则插入。
    myMap.insert(pair<int, string>(3, "陈二"));  //使用insert和pair插入
    
    //遍历输出+迭代器的使用
    auto iter = myMap.begin();  //auto自动识别为迭代器类型unordered_map<int,string>::iterator
    while (iter!= myMap.end())
    {  
        cout << iter->first << "," << iter->second << endl;  
        ++iter;  
    }  

    //查找元素并输出+迭代器的使用
    auto iterator = myMap.find(2);  //find()返回一个指向2的迭代器
    if (iterator != myMap.end())
      cout << endl<< iterator->first << "," << iterator->second << endl;  
    system("pause");  
    return 0;  
}
//////////////////////////////////////////////////
3,陈二
2,李四
6,李五
5,张大

2,李四
```
```cpp
#include <iostream>  
#include <unordered_map>  
#include <map>
#include <string>  
using namespace std;  
int main()  
{  
    //注意：C++11才开始支持括号初始化
    map<int, string> myMap={{ 5, "张大" },{ 6, "李五" }};  //使用{}赋值
    myMap[2] = "李四";  //使用[ ]进行单个插入，若已存在键值2，则赋值修改，若无则插入。
    myMap.insert(pair<int, string>(3, "陈二"));  //使用insert和pair插入
    
    //遍历输出+迭代器的使用
    auto iter = myMap.begin();  //auto自动识别为迭代器类型unordered_map<int,string>::iterator
    while (iter!= myMap.end())
    {  
        cout << iter->first << "," << iter->second << endl;  
        ++iter;  
    }  

    //查找元素并输出+迭代器的使用
    auto iterator = myMap.find(2);  //find()返回一个指向2的迭代器
    if (iterator != myMap.end())
      cout << endl<< iterator->first << "," << iterator->second << endl;  
    system("pause");  
    return 0;  
}
//////////////////////////////////////////////////
2,李四
3,陈二
5,张大
6,李五

2,李四
```

【[:star:][`*`]】 unordered_map vs map in C++ — Complexity Analysis https://codeforces.com/blog/entry/50626
- > Today one of my myths was broken. <br> I used to believe that `unordered_map` is better in time-complexity than `map` in C++. But today while I was doing a problem([Molly's Chemicals](https://codeforces.com/contest/776/problem/C)), I got time-limit exceeded. After a lot of guess-work(because I thought my solution was correct), I tried using a `map` instead of an `unordered_map` and as a surprise I got it accepted. ***Then I realised that though the amortised time-complexity of using an `unordered_map` is `O(1)` while that of a `map` is `O(log n)`, there are cases in which due to a lot of collisions `unordered_map` can have a big constant multiplier which will increase its actual complexity to greater than that of a `map`***. (Any corrections are welcomed...)
- > Can someone enlighten me more by clearing the doubt that where should `unordered_map` be used and where not? What are the cases in which a `map` would perform better than an `unordered_map`?
- > Here are the tle and aced solution links if someone wants to verify:
  * > [TLE Solution](https://codeforces.com/contest/776/submission/24950521) (TLE after 2500 ms)
  * > [Accepted Solution](https://codeforces.com/contest/776/submission/24950552) (Accepted in 499 ms)
- 回复里的：
  * **krismaz**:
    + > Firstly, ***`unordered_map` with default settings has a pretty large constant***. It can be decreased a lot by calling **`reserve`** and **`max_load_factor`** methods as explained at the end of this [blog](https://codeforces.com/blog/entry/21853). I think without this `unordered_map` is slightly faster than `map`, with this it should be much faster — assuming random input.
    + > Secondly, in this problem test were used that make the c++ `unordered_map` implementation really slow. This is possible because the hash function for `int/long long` in C++ is identity (and then taking this modulo the number of buckets), so one can force every key in the hashmap to have the same hash, and then a single lookup becomes `O(n)`.
    + > To fix the second you can paste your own hash implementation like this: [24950229](https://codeforces.com/contest/776/submission/24950229) (unfortunately didn't do this during the contest, got TLE just like you). This submission also xor's the hashmap key with a randomly drawn number so someone couldn't reverse-engineer your hash somehow and hack it.
  * **dreameeer**:
    + > Should we use these two lines always? Or need to change depending on any constraint or input size?
      ```cpp
      reserve(4096); // always 4096 ?? 
      max_load_factor(0.25); always 0.25 ??
      ```
      * **krismaz**:
        + > The first line means that you're reserving space upfront for `4096` elements — this would be a waste of time if your hashmap ends up being smaller than that. When my hashmap was expected to be much larger, I was still using `4096`, although I never really thought about it deeply.
        + > The `max_load_factor` of `f` roughly says that the maps could take `1/f` times more memory, but should be faster. Hence, this should be only used if memory is not a problem, and `0.25` is a sensible default value. I sometimes use lower values like `0.1` when I'm really optimizing for time, but it seems decreasing f further gives diminishing returns.
  * **gorbunov**:
    + > unordered_map's amortized time complexity bound is not specified. Only average time complexity is said to be constant for search, insertion and removal. [Source](http://en.cppreference.com/w/cpp/container/unordered_map).
    + > Note: if amortized bound would also be constant, the solution utilizing unordered_map would have passed.
