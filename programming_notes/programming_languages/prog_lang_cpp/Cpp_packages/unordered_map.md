
# 官方

std::unordered_map https://www.cplusplus.com/reference/unordered_map/unordered_map/
- **Iterators**
  * std::unordered_map::begin https://www.cplusplus.com/reference/unordered_map/unordered_map/begin/
- **Element access**
  * std::unordered_map::operator[] https://www.cplusplus.com/reference/unordered_map/unordered_map/operator[]/
- **Element lookup**
  * std::unordered_map::find https://www.cplusplus.com/reference/unordered_map/unordered_map/find/

hash_map File Reference https://gcc.gnu.org/onlinedocs/gcc-4.6.4/libstdc++/api/a00912.html

# wiki

Unordered associative containers (C++) https://en.wikipedia.org/wiki/Unordered_associative_containers_(C%2B%2B)
- > In the programming language C++, **unordered associative containers** are a group of class templates in the [C++ Standard Library](https://en.wikipedia.org/wiki/C%2B%2B_Standard_Library) that implement [hash table](https://en.wikipedia.org/wiki/Hash_table) variants. Being templates, they can be used to store arbitrary elements, such as integers or custom classes. The following containers are defined in the current revision of the C++ standard: `unordered_set`, `unordered_map`, `unordered_multiset`, `unordered_multimap`. Each of these containers differ only on constraints placed on their elements.
- > The unordered associative containers are similar to the [associative containers](https://en.wikipedia.org/wiki/Associative_containers) in the C++ Standard Library but have different constraints. ***As their name implies, the elements in the unordered associative containers are not ordered***. This is due to the use of hashing to store objects. The containers can still be iterated through like a regular associative container.

## 主要是想注意下两种访问 unordered_map 的键值对的形式：一种是用迭代器：`local_it->first`，另一种是直接用pair：`x.first`

https://www.cplusplus.com/reference/unordered_map/unordered_map/begin/
```cpp
// unordered_map::begin/end example
#include <iostream>
#include <unordered_map>

int main ()
{
  std::unordered_map<std::string,std::string> mymap;
  mymap = {{"Australia","Canberra"},{"U.S.","Washington"},{"France","Paris"}};

  std::cout << "mymap contains:";
  for ( auto it = mymap.begin(); it != mymap.end(); ++it )
    std::cout << " " << it->first << ":" << it->second;
  std::cout << std::endl;

  std::cout << "mymap's buckets contain:\n";
  for ( unsigned i = 0; i < mymap.bucket_count(); ++i) {
    std::cout << "bucket #" << i << " contains:";
    for ( auto local_it = mymap.begin(i); local_it!= mymap.end(i); ++local_it )
      std::cout << " " << local_it->first << ":" << local_it->second;
    std::cout << std::endl;
  }

  return 0;
}
//////////////////////////////////////////////////
mymap contains: France:Paris Australia:Canberra U.S.:Washington
mymap's buckets contain:
bucket #0 contains:
bucket #1 contains:
bucket #2 contains:
bucket #3 contains:
bucket #4 contains:
bucket #5 contains: France:Paris
bucket #6 contains:
bucket #7 contains: Australia:Canberra
bucket #8 contains: U.S.:Washington
bucket #9 contains:
bucket #10 contains:
```

https://www.cplusplus.com/reference/unordered_map/unordered_map/at/
```cpp
// unordered_map::at
#include <iostream>
#include <string>
#include <unordered_map>

int main ()
{
  std::unordered_map<std::string,int> mymap = {
                { "Mars", 3000},
                { "Saturn", 60000},
                { "Jupiter", 70000 } };

  mymap.at("Mars") = 3396;
  mymap.at("Saturn") += 272;
  mymap.at("Jupiter") = mymap.at("Saturn") + 9638;

  for (auto& x: mymap) {
    std::cout << x.first << ": " << x.second << std::endl;
  }

  return 0;
}
//////////////////////////////////////////////////
Saturn: 60272
Mars: 3396
Jupiter: 69910
```

## unordered_map各种遍历方式

【From LeetCode】：
- `LC1436. 旅行终点站` https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/1401-1600/001436--weekly187_1/README.md
  * https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/1401-1600/001436--weekly187_1/tran/187_1_v.cpp
    + >
      ```cpp
      for (auto [k, v] : dic) {
      
      }
      ```
    + https://en.cppreference.com/w/cpp/container/unordered_map

# unordered_map初始化

C++ STL unordered_map详解 https://blog.csdn.net/wsp_1138886114/article/details/106794899

Initialize a std::map or std::unordered_map in C++ https://www.techiedelight.com/initialize-map-unordered_map-cpp/

# `unordered_map` 类似python dict的 `.keys()` 和 `.values()`

How to retrieve all keys (or values) from a std::map and put them into a vector? https://stackoverflow.com/questions/110157/how-to-retrieve-all-keys-or-values-from-a-stdmap-and-put-them-into-a-vector

Obtaining list of keys and values from unordered_map https://stackoverflow.com/questions/8483985/obtaining-list-of-keys-and-values-from-unordered-map

**LeetCode相关题目**：
- `1996. 游戏中弱角色的数量` https://leetcode-cn.com/problems/the-number-of-weak-characters-in-the-game/
  * https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/1801-2000/001996--weekly257_2/tran/001996_revised.cpp
    ```cpp
    vector<int> keys;
    // 类似Python的 `.keys()`
    for (auto [k, v] : dic) {
        keys.push_back(k);
    }
    ```

# 其他

unordered_map in C++ STL https://www.geeksforgeeks.org/unordered_map-in-cpp-stl/

C++ STL unordered_map用法 https://www.cnblogs.com/downey-blog/p/10471875.html

c++ get values of an unordered_map of vector of unordered_map https://stackoverflow.com/questions/64248957/c-get-values-of-an-unordered-map-of-vector-of-unordered-map
- >
  ```cpp
  std::unordered_map<int,std::string> names{
  {1,"John"},
  {3,"Geoff"},
  {2,"Parekh"},
  };
  
  //Iterating through the map
  for (auto [key,value] : names)
  {
      std::cout << key <<  " : " << value << '\n';
  }
  ```

C++STL : unordered_map详解 - 甘蔗的文章 - 知乎 https://zhuanlan.zhihu.com/p/296360525
