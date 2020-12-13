
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
