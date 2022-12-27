
# 官方

`header <iterator>` https://www.cplusplus.com/reference/iterator/
- > **Functions**
  * `std::back_inserter` https://cplusplus.com/reference/iterator/back_inserter/

# 其他

C++ STL back_inserter 函数说明 https://www.jianshu.com/p/6862a79eba0a
- > **说明**
  * > `back_inserter` 用于在末尾插入元素。实现方法是构造一个迭代器，这个迭代器可以在容器末尾添加元素。这个迭代器是以安插（insert）方式而非覆写（overwrite）方式运作的。可以使用 `back_inserter` 的容器是有 `push_back` 成员函数的容器，比如 `vector, deque and list` 等
