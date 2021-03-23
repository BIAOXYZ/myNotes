
# 官方

`header <string>` http://www.cplusplus.com/reference/string/
- **Class instantiations**
  * std::string http://www.cplusplus.com/reference/string/string/
- **Convert from strings**
  * std::stoi http://www.cplusplus.com/reference/string/stoi/
- **Convert to strings**
  * std::to_string http://www.cplusplus.com/reference/string/to_string/

std::string http://www.cplusplus.com/reference/string/string/
- **Capacity:**
  * std::string::size http://www.cplusplus.com/reference/string/string/size/
  * std::string::length http://www.cplusplus.com/reference/string/string/length/
- **String operations:**
  * std::string::c_str http://www.cplusplus.com/reference/string/string/c_str/
  * std::string::data http://www.cplusplus.com/reference/string/string/data/

std::to_string https://en.cppreference.com/w/cpp/string/basic_string/to_string

# `.c_str()`

std::string::c_str http://www.cplusplus.com/reference/string/string/c_str/  --> URL is: http://cpp.sh/6kfx
```cpp
// strings and c-strings
#include <iostream>
#include <cstring>
#include <string>

int main ()
{
  std::string str ("Please split this sentence into tokens");

  char * cstr = new char [str.length()+1];
  std::strcpy (cstr, str.c_str());

  // cstr now contains a c-string copy of str

  char * p = std::strtok (cstr," ");
  while (p!=0)
  {
    std::cout << p << '\n';
    p = std::strtok(NULL," ");
  }

  delete[] cstr;
  return 0;
}
//////////////////////////////////////////////////
/*
Please
split
this
sentence
into
tokens
*/
```

# `.length()` 和 `.size()`
>> 【[:star:][`*`]】 //notes： `.length()` 和 `.size()` 除了名字不一样，其他完全一模一样。

5 Different methods to find length of a string in C++ https://www.geeksforgeeks.org/5-different-methods-find-length-string-c/

# 其他

c++ 中 char 与 string 之间的相互转换问题 https://www.cnblogs.com/devilmaycry812839668/p/6353807.html
