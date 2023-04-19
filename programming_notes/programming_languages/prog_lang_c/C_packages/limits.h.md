
# 官方

`header <climits> (limits.h)` https://www.cplusplus.com/reference/climits/
- **Macro constants**
  * INT_MIN
  * INT_MAX

C Programming/limits.h https://en.wikibooks.org/wiki/C_Programming/limits.h

# 其他

`C 标准库 - <limits.h>` https://www.runoob.com/cprogramming/c-standard-library-limits-h.html

C/C++ 中 int float double 最大值，最小值 https://blog.csdn.net/sinat_31275315/article/details/90477866
```cpp
#include <iostream>
#include <float.h>
#include <limits.h>
using namespace std;
int main()
{
	cout << "int 类型能存储的最大值和最小值" << endl;
	cout << "INT_MAX = " << INT_MAX << endl;
	cout << "INT_MIN = " << INT_MIN << endl;
	cout << "long 类型能存储的最大值和最小值" << endl;
	cout << "LONG_MAX = " << LONG_MAX << endl;
	cout << "LONG_MIN = " << LONG_MIN << endl;
	cout << "long long 类型能存储的最大值和最小值" << endl;
	cout << "LONG_LONG_MAX = " << LONG_LONG_MAX << endl;
	cout << "LONG_LONG_MIN = " << LONG_LONG_MIN << endl;
	cout << "float 类型能存储的最大值和最小值" << endl;
	cout << "FLT_MAX = " << FLT_MAX << endl;
	cout << "FLT_MIN = " << FLT_MIN << endl;
	cout << "double 类型能存储的最大值和最小值" << endl;
	cout << "DBL_MAX = " << DBL_MAX << endl;
	cout << "DBL_MIN = " << DBL_MIN << endl;
	return 0;
}
```
```console
LONG_LONG_MIN = -9223372036854775808
float 类型能存储的��大值和最小值
FLT_MAX = 3.40282e+38
FLT_MIN = 1.17549e-38
double 类型能存储的最大值和最小值
DBL_MAX = 1.79769e+308
DBL_MIN = 2.22507e-308
```
