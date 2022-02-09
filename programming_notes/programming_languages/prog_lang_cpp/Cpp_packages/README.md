
# 接口变更

## 最大公约数函数 C++14 和 C++17

std::gcd https://en.cppreference.com/w/cpp/numeric/gcd

std::gcd | C++ inbuilt function for finding GCD https://www.geeksforgeeks.org/stdgcd-c-inbuilt-function-finding-gcd/
- > C++ has the built-in function for calculating GCD. This function is present in header file. 
  * > Syntax for C++14 :
    ```cpp
     Library: 'algorithm'
     __gcd(m, n) 
    Parameter :  m, n
    Return Value :  0 if both m and n are zero, 
    else gcd of m and n.
    ```
  * > Syntax for C++17 :
    ```cpp
    Library: 'numeric'
    gcd(m, n)
    Parameter :  m, n
    Return Value :  0 if both m and n are zero,
    else gcd of m and n.
    ```

Inbuilt __gcd(A,B) function in C++ https://stackoverflow.com/questions/30898575/inbuilt-gcda-b-function-in-c

LeetCode相关题目：
- `1447. 最简分数`
