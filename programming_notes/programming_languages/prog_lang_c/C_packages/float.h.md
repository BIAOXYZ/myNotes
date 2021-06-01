
# 官方

`<cfloat> (float.h)` https://www.cplusplus.com/reference/cfloat/
- > When a group of macros exists prefixed by `FLT_`, `DBL_` and `LDBL_`, the one beginning with `FLT_` applies to the `float` type, the one with `DBL_` to `double` and the one with `LDBL_` to `long double`.
- **Macro constants**
  * DBL_MAX

# 其他

What is DBL_MAX in C++? [closed] https://stackoverflow.com/questions/23278930/what-is-dbl-max-in-c
- > As it was said by others `DBL_MAX` defined in header `<cfloat>` in C++ or `<float.h>` in C is the value of maximum representable finite floating-point (double) number
- > In C++ you can get the same value using class `std::numeric_limits` defined in header `<limits>`
  ```cpp
  std::numeric_limits<double>::max()
  ```
- > Here is an example of using the both approaches
  ```cpp
  #include <iostream>
  #include <cfloat>
  #include <limits>
  int main() 
  {
      std::cout << DBL_MAX << std::endl;
      std::cout << std::numeric_limits<double>::max() << std::endl;
      return 0;
  }
  ```
- > At www.ideone.com (on-line C++ compiler) the output is
  ```console
  1.79769e+308
  1.79769e+308
  ```
