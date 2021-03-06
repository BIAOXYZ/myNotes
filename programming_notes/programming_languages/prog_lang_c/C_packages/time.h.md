
# 官方

`header <ctime> (time.h)` https://www.cplusplus.com/reference/ctime/
- **Functions**
  * difftime https://www.cplusplus.com/reference/ctime/difftime/
  * mktime https://www.cplusplus.com/reference/ctime/mktime/
  * time https://www.cplusplus.com/reference/ctime/time/
- **Conversion**
  * localtime https://www.cplusplus.com/reference/ctime/localtime/
- **types**
  * struct tm https://www.cplusplus.com/reference/ctime/tm/

time https://en.cppreference.com/w/c/chrono/time

std::time https://en.cppreference.com/w/cpp/chrono/c/time || https://zh.cppreference.com/w/cpp/chrono/c/time

# wiki

time.h https://zh.wikipedia.org/wiki/Time.h

C Programming/time.h https://en.wikibooks.org/wiki/C_Programming/time.h

# 其他

time.h header file in C with Examples https://www.geeksforgeeks.org/time-h-header-file-in-c-with-examples/

C++ 日期 & 时间 https://www.runoob.com/cplusplus/cpp-date-time.html
```cpp
#include <iostream>
#include <ctime>
using namespace std;
int main( )
{
   time_t now = time(0);
   char* dt = ctime(&now);
   cout << "local date and time is：" << dt << endl;
 
   tm *gmtm = gmtime(&now);
   dt = asctime(gmtm);
   cout << "UTC date and time is："<< dt << endl;
}
//////////////////////////////////////////////////
local date and time is：Thu Jun 10 07:17:47 2021

UTC date and time is：Thu Jun 10 07:17:47 2021
```
