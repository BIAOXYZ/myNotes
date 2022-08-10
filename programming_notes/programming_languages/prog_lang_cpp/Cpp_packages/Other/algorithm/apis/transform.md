
# 官方

std::transform https://cplusplus.com/reference/algorithm/transform/

std::transform https://en.cppreference.com/w/cpp/algorithm/transform

# 其他

Convert vector of strings to vector of integers in C++ https://www.techiedelight.com/convert-vector-of-strings-to-vector-of-integers-in-cpp/
- 个人实战部分：
  ```cpp
  #include <iostream>
  #include <vector>
  #include <algorithm>
  int main()
  {
      std::vector<std::string> strings = {"1", "2", "3", "4"};
      std::vector<int> ints;
      std::transform(strings.begin(), strings.end(), std::back_inserter(ints),
          [&](std::string s) {
              return stoi(s);
          });
      for (auto &i: ints) {
          std::cout << i << ' ';
      }
      return 0;
  }
  ```
  ```console
  1 2 3 4 
  ```

C++ std transform https://linuxhint.com/std-transform-function-cpp/
