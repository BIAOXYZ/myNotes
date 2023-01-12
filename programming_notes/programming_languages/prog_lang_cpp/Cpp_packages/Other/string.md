
# 官方

## cplusplus

`header <string>` http://www.cplusplus.com/reference/string/
- **Class instantiations**
  * std::string http://www.cplusplus.com/reference/string/string/
- **Convert from strings**
  * std::stoi http://www.cplusplus.com/reference/string/stoi/
  * std::stod http://www.cplusplus.com/reference/string/stod/
- **Convert to strings**
  * std::to_string http://www.cplusplus.com/reference/string/to_string/

std::string http://www.cplusplus.com/reference/string/string/
- **Member functions**
  * `(constructor)` `std::string::string` https://www.cplusplus.com/reference/string/string/string/
  * `(destructor)` `std::string::~string` https://www.cplusplus.com/reference/string/string/~string/
  * `operator=` `std::string::operator=` https://www.cplusplus.com/reference/string/string/operator=/
- **Capacity:**
  * std::string::size http://www.cplusplus.com/reference/string/string/size/
  * std::string::length http://www.cplusplus.com/reference/string/string/length/
- **Element access:**
  * std::string::back https://www.cplusplus.com/reference/string/string/back/  【`vector` 也是类似的】
  * std::string::front https://www.cplusplus.com/reference/string/string/front/  【`vector` 也是类似的】
- **String operations:**
  * std::string::c_str http://www.cplusplus.com/reference/string/string/c_str/
  * std::string::data http://www.cplusplus.com/reference/string/string/data/
  * std::string::find https://www.cplusplus.com/reference/string/string/find/
  * std::string::find_last_of https://www.cplusplus.com/reference/string/string/find_last_of/
  * std::string::substr http://www.cplusplus.com/reference/string/string/substr/
- **Member constants**
  * std::string::npos https://www.cplusplus.com/reference/string/string/npos/
    + `static const size_t npos = -1;`

## cppreference

Strings library https://en.cppreference.com/w/cpp/string
- std::basic_string https://en.cppreference.com/w/cpp/string/basic_string

std::to_string https://en.cppreference.com/w/cpp/string/basic_string/to_string

std::basic_string<CharT,Traits,Allocator>::npos https://en.cppreference.com/w/cpp/string/basic_string/npos

# 偶然发现的一个网站，可以各种数据类型转换提供示例代码

【[:website:][:star:][`*`]】 ConvertDataTypes.com https://www.convertdatatypes.com/
- https://www.convertdatatypes.com/Convert-char-Array-to-uint-in-C.html

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
- > 头文件：
  ```cpp
  #include <string> //注意没有.h  string.h是C的标准字符串函数数，c++中一般起名为ctring.  而string头文件是C++的字符串头文件。
  ```
- > 函数原型： 
  ```cpp
  string substr(int pos = 0,int n ) const;
  ```
- > 参数说明:
  * > 参数1：pos是必填参数
  * > 参数2：n是可参数，***表示取多少个字符，不填表示截取到末尾***
  * > 该函数功能为：返回从pos开始的n个字符组成的字符串，原字符串不被改变

C++字符串分割方法总结 https://www.jianshu.com/p/5876a9f49413

在 C++ 中分割字符串 https://liam.page/2017/08/03/split-a-string-in-Cpp/

**LeetCode相关题目**：
- `2042. 检查句子中的数字是否递增` https://leetcode.cn/problems/check-if-numbers-are-ascending-in-a-sentence/

# 字符串拼接

C/C++ 语言中如何优雅地拼接多段字符串？ - 知乎 https://www.zhihu.com/question/324816304

c++拼接字符串效率比较（+=、append、stringstream、sprintf） https://www.cnblogs.com/james6176/p/3222671.html

C++中4种方式把字符串和数字连接起来 - 阿贵的文章 - 知乎 https://zhuanlan.zhihu.com/p/54074787 || https://blog.csdn.net/PROGRAM_anywhere/article/details/63720261

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

How can I convert a std::string to int? https://stackoverflow.com/questions/7663709/how-can-i-convert-a-stdstring-to-int

C++ double 转string方法 精度保持到小数点15位 https://blog.csdn.net/y396397735/article/details/92825667
- > 注意：经测试设置精度到20位实际准确只有15位，后面的数据就不可靠了。
- 个人文章实战：
```cpp
#include <iostream>
#include <sstream>
#include <iomanip>
int main(int argc, char *argv[])
{
    double d = 3.1415926535897932384;
    std::string str = std::to_string(d);
    std::cout << str << std::endl; // 3.141593
    std::stringstream ss;
    ss << std::setprecision(15) << d;
    str = ss.str(); 
    std::cout << str << std::endl; //3.14159265358979
    return 0;
}
```
```console
3.141593
3.14159265358979
```

C++字符串转换（stoi；stol；stoul；stoll；stoull；stof；stod；stold） https://blog.csdn.net/baidu_34884208/article/details/88342844

## `char` 和 `int` 互转

C++ Program For char to int Conversion https://www.geeksforgeeks.org/cpp-program-for-char-to-int-conversion/
- > If a numeric character needs to be typecasted into the integer value then either we can subtract `48` or `'0'` and then typecast the numeric character into int.
  ```cpp
  #include <iostream>
  using namespace std;
  int main()
  {
      char ch = '5';

      // Subtracting 48 will produce desired results
      cout << int(ch) - 48 << "\n";

      // Also subtracting '0' will result in same output
      cout << int(ch - '0');
      return 0;
  }
  ```

LeetCode题目：
- `1796. 字符串中第二大的数字` https://leetcode.cn/problems/second-largest-digit-in-a-string/  

# 问题

Empty character constant in c++ https://stackoverflow.com/questions/31193454/empty-character-constant-in-c
>> //notes：得到了一个教训，string初始化时要么就直接不赋值 `string s;`，要么就双引号形式 `string s = "";`，用这种单引号形式就会有这个问题 `string s = '';`。但是那两种合法的初始化方式貌似也有区别：
>>> C++ string初始化为空的问题 默认初始化和双引号初始化 https://blog.csdn.net/yuanliang861/article/details/82893539

# 其他

## `std::string` 在 C++11 中取消 copy-on-write

写入时复制 https://zh.wikipedia.org/wiki/%E5%AF%AB%E5%85%A5%E6%99%82%E8%A4%87%E8%A3%BD
- > **写入时复制**（英语：Copy-on-write，简称COW）是一种计算机程序设计领域的优化策略。其核心思想是，如果有多个调用者（callers）同时请求相同资源（如内存或磁盘上的数据存储），他们会共同获取相同的指针指向相同的资源，直到某个调用者试图修改资源的内容时，系统才会真正复制一份专用副本（private copy）给该调用者，而其他调用者所见到的最初的资源仍然保持不变。这过程对其他的调用者都是透明的。此作法主要的优点是如果调用者没有修改该资源，就不会有副本（private copy）被创建，因此多个调用者只是读取操作时可以共享同一份资源。
- > **数据存储中的写时复制**
  * > Linux等的文件管理系统使用了写时复制策略。 <br> 数据库服务器也一般采用了写时复制策略，为用户提供一份snapshot。
- > **软件应用中的写时复制**
  * > C++标准程序库中的`std::string`类，在C++98/C++03标准中是允许写时复制策略。但在C++11标准中为了提高并行性取消了这一策略。GCC从版本5开始，`std::string`不再采用COW策略。

vs下string为什么不用Copy-On-Write技术? - 知乎 https://www.zhihu.com/question/68710854
- vs下string为什么不用Copy-On-Write技术? - 知乎用户的回答 - 知乎 https://www.zhihu.com/question/68710854/answer/363184762

std::string的Copy-on-Write：不如想象中美好 https://www.cnblogs.com/promise6522/archive/2012/03/22/2412686.html
