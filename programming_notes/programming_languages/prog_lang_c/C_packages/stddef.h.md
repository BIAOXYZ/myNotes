
# 官方

`<cstddef> (stddef.h)` http://www.cplusplus.com/reference/cstddef/
- **Types**
  * ptrdiff_t http://www.cplusplus.com/reference/cstddef/ptrdiff_t/
  * size_t http://www.cplusplus.com/reference/cstddef/size_t/
- **Macro constants**
  * NULL http://www.cplusplus.com/reference/cstddef/NULL/

std::ptrdiff_t https://en.cppreference.com/w/cpp/types/ptrdiff_t
```cpp
#include <cstddef>
#include <iostream>
int main()
{
    const std::size_t N = 10;
    int* a = new int[N];
    int* end = a + N;
    for (std::ptrdiff_t i = N; i > 0; --i)
        std::cout << (*(end - i) = i) << ' ';
    delete[] a;
}
//////////////////////////////////////////////////
10 9 8 7 6 5 4 3 2 1
```

# 其他

c++ ptrdiff_t 类型 https://www.cnblogs.com/youxin/p/3281107.html
