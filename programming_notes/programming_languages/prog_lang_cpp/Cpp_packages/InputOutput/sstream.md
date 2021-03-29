
# 官方

`header <sstream>` https://www.cplusplus.com/reference/sstream/
- **Classes**
  * std::istringstream https://www.cplusplus.com/reference/sstream/istringstream/
  * std::ostringstream https://www.cplusplus.com/reference/sstream/ostringstream/
  * std::stringstream https://www.cplusplus.com/reference/sstream/stringstream/

std::istringstream https://www.cplusplus.com/reference/sstream/istringstream/
- **Public member functions inherited from `istream`**
  * std::istream::getline https://www.cplusplus.com/reference/istream/istream/getline/

std::stringstream https://www.cplusplus.com/reference/sstream/stringstream/
- **Public member functions inherited from `istream`**
  * std::istream::getline https://www.cplusplus.com/reference/istream/istream/getline/

# 其他

What exactly does stringstream do? https://stackoverflow.com/questions/20594520/what-exactly-does-stringstream-do

23.4 — Stream classes for strings https://www.learncpp.com/cpp-tutorial/stream-classes-for-strings/

stringstream in C++ and its applications https://www.geeksforgeeks.org/stringstream-c-applications/

Stringstream in C++ programming https://www.tutorialspoint.com/stringstream-in-cplusplus-programming

Size of stringstream [duplicate] https://stackoverflow.com/questions/4432793/size-of-stringstream
- https://stackoverflow.com/questions/4432793/size-of-stringstream/4432865#4432865
  * > This is for the write pointer, but the result is the same for read pointer on Visual C++ v10.
    ```cpp
    std::stringstream oss("String");
    oss.seekp(0, ios::end);
    stringstream::pos_type offset = oss.tellp();
    ```
  * 个人实战：
    ```cpp
    #include <iostream>
    #include <sstream>
    
    int main(void) {
        std::stringstream oss("String");
        oss.seekp(0, std::ios::end);
        std::stringstream::pos_type offset = oss.tellp();
        std::cout << offset << std::endl;
    }
    //////////////////////////////////////////////////
    6
    ```
