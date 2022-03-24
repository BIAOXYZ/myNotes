
# `for_each()`

std::for_each https://en.cppreference.com/w/cpp/algorithm/for_each
- > 1) Applies the given function object f to the result of dereferencing every iterator in the range [first, last), in order.
- > **Example**
  * > The following example uses a [lambda function](https://en.cppreference.com/w/cpp/language/lambda) to increment all of the elements of a vector and then uses an overloaded `operator()` in a functor to compute their sum. Note that to compute the sum, it is recommended to use the dedicated algorithm [`std::accumulate`](std::accumulate).
```cpp
#include <vector>
#include <algorithm>
#include <iostream>
 
struct Sum
{
    void operator()(int n) { sum += n; }
    int sum{0};
};
 
int main()
{
    std::vector<int> nums{3, 4, 2, 8, 15, 267};
 
    auto print = [](const int& n) { std::cout << " " << n; };
 
    std::cout << "before:";
    std::for_each(nums.cbegin(), nums.cend(), print);
    std::cout << '\n';
 
    std::for_each(nums.begin(), nums.end(), [](int &n){ n++; });
 
    // calls Sum::operator() for each number
    Sum s = std::for_each(nums.begin(), nums.end(), Sum());
 
    std::cout << "after: ";
    std::for_each(nums.cbegin(), nums.cend(), print);
    std::cout << '\n';
    std::cout << "sum: " << s.sum << '\n';
}
```
```console
before: 3 4 2 8 15 267
after:  4 5 3 9 16 268
sum: 305
```

std::for_each https://www.cplusplus.com/reference/algorithm/for_each/

C++ for 循环的5种用法 https://www.cnblogs.com/music-liang/p/13204979.html
