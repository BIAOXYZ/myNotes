
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

for_each loop in C++ https://www.geeksforgeeks.org/for_each-loop-c/

C++ for 循环的5种用法 https://www.cnblogs.com/music-liang/p/13204979.html

std::for_each() in C++ https://thecodingbot.com/stdfor_each-in-c/

# `for_each()` 的返回值

Why does std::for_each(from, to, function) return function? https://stackoverflow.com/questions/2048967/why-does-stdfor-eachfrom-to-function-return-function
- https://stackoverflow.com/questions/2048967/why-does-stdfor-eachfrom-to-function-return-function/2049011#2049011
  * > It's to allow you to accrue state in your function and then return it to your calling code. For instance, your function (as a functor class) could have a member int for counting the number of times it had been called.
  * > Here is a page with some examples : https://web.archive.org/web/20171127171924/http://xenon.arcticus.com/c-morsels-std-for-each-functors-member-variables

for_each not returning (boolean) value https://stackoverflow.com/questions/49029690/for-each-not-returning-boolean-value

# `for_each()` 提前终止

How to Make for_each Stop When a Condition Is True https://www.fluentcpp.com/2020/02/18/how-to-make-for_each-stop-when-a-condition-is-true/
