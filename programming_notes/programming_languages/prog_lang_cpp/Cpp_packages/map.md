
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
