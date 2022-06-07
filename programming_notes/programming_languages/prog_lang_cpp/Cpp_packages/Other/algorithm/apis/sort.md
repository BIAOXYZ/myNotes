
# `std::sort()`

## 自定义排序函数

std::sort http://www.cplusplus.com/reference/algorithm/sort/
- > **Parameters**
  * > comp
    + > Binary function that accepts two elements in the range as arguments, and returns a value convertible to bool. ***The value returned <ins>indicates whether the element passed as first argument is considered to go before the second</ins>*** in the specific strict weak ordering it defines.
      >> 【[:star:][`*`]】 //notes：所以其实官方已经说明了：`comp` 函数的返回值是一个 bool 值，表示两个元素的排序关系。***如果为真，表示第一个入参应该在第二个入参前面***。

如何自定义sort函数中的比较函数 https://blog.csdn.net/qq_31217423/article/details/76375336
```console
总结起来就是：
sort函数根据comp函数的返回值，对comp函数的两个参数排序。
如果comp返回true，排序为“参数1”“参数2”，否则排序为“参数2”“参数1”。
想要升序排列，则return parameter1<parameter2
想要降序排列，则return parameter1>parameter2
```

C++ Sort Array by 2nd Value https://stackoverflow.com/questions/69038256/c-sort-array-by-2nd-value
- https://stackoverflow.com/questions/69038256/c-sort-array-by-2nd-value/69038461#69038461
  ```cpp
  // 自己整理了回答里的代码：
  #include <iostream>
  #include <vector>
  #include <algorithm>
  int main()
  {
      std::vector<std::vector<int>> someVector {
          {4, 20},{1, 4},{7, 15},{8, 8},{8, 1}
      };
      std::sort(someVector.begin(), someVector.end(), 
          [](auto const &a, auto const &b) { return a[1] < b[1]; });
      for (auto const &row : someVector)
          std::cout << row[0] << "\t" << row[1] << "\n";
  }
  ```
  ```console
  8	1
  1	4
  8	8
  7	15
  4	20
  ```

## 其他帖子

sort (C++) https://en.wikipedia.org/wiki/Sort_(C%2B%2B)

C++ sort排序函数用法 https://blog.csdn.net/w_linux/article/details/76222112

std::sort() in C++ STL https://www.geeksforgeeks.org/sort-c-stl/

What is the std::sort() function in C++? https://www.educative.io/edpresso/what-is-the-stdsort-function-in-cpp

How To Implement Sort function In C++? https://www.edureka.co/blog/sort-function-in-cpp/
