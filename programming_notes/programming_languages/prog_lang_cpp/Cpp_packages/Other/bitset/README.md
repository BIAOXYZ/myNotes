
# 官方

std::bitset http://www.cplusplus.com/reference/bitset/bitset/

# 其他

Convert a number to a binary string (and back) in C++ https://peter.bloomfield.online/convert-a-number-to-a-binary-string-and-back-in-cpp/
- > **Number to binary string**
  * > Output directly to the console (or other output stream):
    ```cpp
    std::cout << std::bitset<8>(123);
    ```
  * > Store in a string object:
    ```cpp
    std::string str = std::bitset<8>(123).to_string();
    ```
- > **Binary string to number**
  * > Going back the other way (from a binary string to a number) is just as easy:
    ```cpp
    std::cout << std::bitset<8>("11011011").to_ulong();
    ```
  * > That will output the number 219 directly to the console. Alternatively, you can also store the result in a variable:
    ```cpp
    unsigned long n = std::bitset<8>("11011011").to_ulong();
    ```
- > **Binary literals in `C++14`**
  * > The above assumes your binary string isn't known until runtime, e.g. because it's being entered by a user or read from a file. If you know the binary string at compile time, and you're using C++14 or later, then you don't need to use bitset at all. You can write a binary literal directly in your code like this:
    ```cpp
    int n = 0b10011101;
    ```
  * > This is exactly equivalent to writing the number in decimal like this:
    ```cpp
    int n = 157;
    ```
