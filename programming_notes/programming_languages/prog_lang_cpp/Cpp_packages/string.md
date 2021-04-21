
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
  * std::string::find_last_of https://www.cplusplus.com/reference/string/string/find_last_of/
  * std::string::substr http://www.cplusplus.com/reference/string/string/substr/

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

# `.substr()`

c++截取部分字符串(类似python的切片) https://blog.csdn.net/qq_35975447/article/details/90515218

C++字符串分割方法总结 https://www.jianshu.com/p/5876a9f49413

# 其他

c++ 中 char 与 string 之间的相互转换问题 https://www.cnblogs.com/devilmaycry812839668/p/6353807.html

How to copy std::string into std::vector<char>? [duplicate] https://stackoverflow.com/questions/8263926/how-to-copy-stdstring-into-stdvectorchar
- https://stackoverflow.com/questions/8263926/how-to-copy-stdstring-into-stdvectorchar/8263939#8263939
  * 个人实战：
    ```cpp
    #include <iostream>
    #include <string>
    #include <vector>
    
    int main(void) {
        std::string str = "hello";
        std::vector<char> data;
        std::copy(str.begin(), str.end(), std::back_inserter(data));
        for (auto ch : data) 
            std::cout << ch << std::endl;
    }
    //////////////////////////////////////////////////
    h
    e
    l
    l
    o
    ```

实战c++中的string系列--std:vector<char> 和std:string相互转换(vector to stringstream) https://blog.csdn.net/wangshubo1989/article/details/50274289
- > 
  ```cpp
  //方法四
  string ch = "what a fucking day!";
  vector <char> ta;
  ta.resize(ch.size());
  ta.assign(ch.begin(),ch.end());
  ```
  >> //notes：其实`resize()`可以不用。

# `.find_last_of()`

https://www.cplusplus.com/reference/string/string/find_last_of/
```cpp
// string::find_last_of
#include <iostream>       // std::cout
#include <string>         // std::string
#include <cstddef>         // std::size_t

void SplitFilename (const std::string& str)
{
  std::cout << "Splitting: " << str << '\n';
  std::size_t found = str.find_last_of("/\\");
  std::cout << " path: " << str.substr(0,found) << '\n';
  std::cout << " file: " << str.substr(found+1) << '\n';
}

int main ()
{
  std::string str1 ("/usr/bin/man");
  std::string str2 ("c:\\windows\\winhelp.exe");

  SplitFilename (str1);
  SplitFilename (str2);

  return 0;
}
//////////////////////////////////////////////////
Splitting: /usr/bin/man
 path: /usr/bin
 file: man
Splitting: c:\windows\winhelp.exe
 path: c:\windows
 file: winhelp.exe
```

# 非方法

## `std::stoi()`、`std::atoi()`、`std::to_string()`

C++ string to int Conversion https://www.programiz.com/cpp-programming/string-int-conversion
