
# 官方

Standard Template Library: Algorithms http://www.cplusplus.com/reference/algorithm/
- **Non-modifying sequence operations:**
  * std::for_each https://www.cplusplus.com/reference/algorithm/for_each/
  * std::find https://www.cplusplus.com/reference/algorithm/find/
  * std::count https://www.cplusplus.com/reference/algorithm/count/
- **Modifying sequence operations:**
  * std::copy https://www.cplusplus.com/reference/algorithm/copy/
  * std::unique https://www.cplusplus.com/reference/algorithm/unique/
  * std::random_shuffle https://www.cplusplus.com/reference/algorithm/random_shuffle/
  * std::shuffle https://www.cplusplus.com/reference/algorithm/shuffle/
- **Sorting**:
  * std::sort http://www.cplusplus.com/reference/algorithm/sort/
- **Binary search**
  * std::lower_bound https://www.cplusplus.com/reference/algorithm/lower_bound/
  * std::upper_bound https://www.cplusplus.com/reference/algorithm/upper_bound/
- **Min/max**:
  * std::max http://www.cplusplus.com/reference/algorithm/max/
  * std::minmax https://www.cplusplus.com/reference/algorithm/minmax/
  * std::min_element http://www.cplusplus.com/reference/algorithm/min_element/
  * std::max_element http://www.cplusplus.com/reference/algorithm/max_element/
  * std::minmax_element https://www.cplusplus.com/reference/algorithm/minmax_element/

Algorithms library https://en.cppreference.com/w/cpp/algorithm
- **Non-modifying sequence operations**
  * std::for_each https://en.cppreference.com/w/cpp/algorithm/for_each
  * std::count, std::count_if https://en.cppreference.com/w/cpp/algorithm/count
  * std::find, std::find_if, std::find_if_not https://en.cppreference.com/w/cpp/algorithm/find
- **Modifying sequence operations**
  * std::random_shuffle, std::shuffle https://en.cppreference.com/w/cpp/algorithm/random_shuffle
- **Sorting operations**
  * std::sort https://en.cppreference.com/w/cpp/algorithm/sort
- **Binary search operations (on sorted ranges)**
  * std::lower_bound https://en.cppreference.com/w/cpp/algorithm/lower_bound
  * std::upper_bound https://en.cppreference.com/w/cpp/algorithm/upper_bound
- **Minimum/maximum operations**
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

## 求最大值（最小值）的一个小技巧
>> 【[:star:][`*`]】 //notes：多个元素求最大值/最小值的另一种写法：`min({elem1, elem2, elem3, elem4})`，即：只需要多加一层大括号，完美解决 `min()` 和 `*min_element()` 的小缺点。 

**LeeCode相关题目**：
- `1189. “气球” 的最大数量` https://leetcode-cn.com/submissions/detail/267621855/ || https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/1001-1200/001189/tran/001189.cpp

# `std::shuffle` 和 `std::random_shuffle`

random_shuffle 和 shuffle的区别 https://www.jianshu.com/p/9613c764447f
- > 推荐使用 `std::shuffle`。
- > `std::shuffle` 是从 `C++11` 之后才开始出现，必须与随机数生成器一起使用。 <br> `std::random_shuffle` 在 `C++11` 之前就已经存在，可以不指定随机数生成器而使用默认的随机数生成器。
- > 需要注意的是，`std::random_shuffle` 在 `C++14` 中弃用，`C++17` 中移除。所以推荐使用 `std::shuffle`。
- > `std::random_shuffle` 被废除的原因是 `std::random_shuffle` 的随机数产生器使用了 `std::rand()`。 <br> 而 `std::rand()` 使用了 ***一个全局静态变量*** 保存其状态，这样使得 `std::rand()` 无法同时产生两个独立互不干扰的随机数流。
- > 所以 `std::random_shuffle` 由于使用了 `std::rand()`，产生的随机数质量不如 `std::shuffle` 使用的均匀分布的随机数产生器URNG(Uniform Random Number Generator)产生的随机数

# ~~`std::sort()`~~
>> //notes：[已转移](apis/sort.md)

# 其他

## min、max相关

C++数组或vector求最大值最小值 https://www.cnblogs.com/Tang-tangt/p/9352093.html
