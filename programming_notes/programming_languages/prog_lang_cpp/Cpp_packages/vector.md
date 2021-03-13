
# 官方

`header <vector>` http://www.cplusplus.com/reference/vector/

std::vector http://www.cplusplus.com/reference/vector/vector/
- **Iterators**:
  * std::vector::begin http://www.cplusplus.com/reference/vector/vector/begin/
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
