
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

# 其他

unordered_map in C++ STL https://www.geeksforgeeks.org/unordered_map-in-cpp-stl/

C++ STL unordered_map用法 https://www.cnblogs.com/downey-blog/p/10471875.html
