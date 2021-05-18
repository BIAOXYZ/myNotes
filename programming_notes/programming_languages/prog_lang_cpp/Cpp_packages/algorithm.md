
# 官方

Standard Template Library: Algorithms http://www.cplusplus.com/reference/algorithm/
- **Non-modifying sequence operations:**
  * std::for_each https://www.cplusplus.com/reference/algorithm/for_each/
- **Modifying sequence operations:**
  * std::copy https://www.cplusplus.com/reference/algorithm/copy/
- **Sorting**:
  * std::sort http://www.cplusplus.com/reference/algorithm/sort/
- **Min/max**:
  * std::max http://www.cplusplus.com/reference/algorithm/max/
  * std::max_element http://www.cplusplus.com/reference/algorithm/max_element/
  * std::min_element http://www.cplusplus.com/reference/algorithm/min_element/

Algorithms library https://en.cppreference.com/w/cpp/algorithm
- Sorting operations
  * std::sort https://en.cppreference.com/w/cpp/algorithm/sort
- Minimum/maximum operations
  * std::min_element https://en.cppreference.com/w/cpp/algorithm/min_element

# `std::min_element` && `std::max_element`

C++ STL min_element 使用说明 https://www.jianshu.com/p/959ac770fb17
- 个人实战：
  ```cpp
  #include <iostream>
  #include <vector>
  #include <algorithm>
  
  int main(int argc, char **argv) 
  {  
      std::vector<int> v{3, 1, 4, 1, 5, 9};
      std::vector<int>::iterator minElement = std::min_element(v.begin(), v.end());
      std::cout << "min element: " << *(minElement) << std::endl;
      std::cout << "min element at: " << std::distance(v.begin(), minElement) << std::endl;
      return 0;
  }
  //////////////////////////////////////////////////
   clang++-7 -pthread -std=c++17 -o main main.cpp
   ./main
  min element: 1
  min element at: 1
  ```

C++ STL 算法——最大值max_element，最小值min_element，求和accumulate https://blog.csdn.net/qq_43827595/article/details/106019641
- > `min_element` 和 `max_element` 头文件是 `algorithm`，返回值是一个迭代器
- > `accumulate` 头文件是 `numeric`，第三个参数是初始值，返回值是一个数
- 个人实战：
  ```cpp
  #include <algorithm>
  #include <iostream>
  #include <vector>
  #include <numeric> 
  using namespace std;
  
  int main() {
      int a[] = {1, 2, 3, 4, 5};
      vector<int> v({1, 2, 3, 4, 5});
  
      // 普通数组
      int minValue = *min_element(a, a + 5); 
      int maxValue = *max_element(a, a + 5); 
      int sumValue = accumulate(a, a + 5, 0);
     
      // Vector数组
      int minValue2 = *min_element(v.begin(), v.end());
      int maxValue2 = *max_element(v.begin(), v.end());
      int sumValue2 = accumulate(v.begin(), v.end(), 0);
  
      cout << minValue << endl;
      cout << maxValue << endl;
      cout << sumValue << endl << endl;
  
      cout << minValue2 << endl;
      cout << maxValue2 << endl;
      cout << sumValue2 << endl << endl;
      return 0;
  }
  //////////////////////////////////////////////////
   clang++-7 -pthread -std=c++17 -o main main.cpp
   ./main
  1
  5
  15
  
  1
  5
  15
  
  ```

# 其他

## sort相关

sort (C++) https://en.wikipedia.org/wiki/Sort_(C%2B%2B)

C++ sort排序函数用法 https://blog.csdn.net/w_linux/article/details/76222112

std::sort() in C++ STL https://www.geeksforgeeks.org/sort-c-stl/

What is the std::sort() function in C++? https://www.educative.io/edpresso/what-is-the-stdsort-function-in-cpp

How To Implement Sort function In C++? https://www.edureka.co/blog/sort-function-in-cpp/

## min、max相关

C++数组或vector求最大值最小值 https://www.cnblogs.com/Tang-tangt/p/9352093.html
