
# general

unsigned int 和 int https://www.cnblogs.com/dushikang/p/8668191.html

C语言命令行参数详解 https://blog.csdn.net/theLostLamb/article/details/79304203
- > C语言的main函数通常含有参数argc和argv，写法通常如下：
  ```c
  int main(int argc,char *argv[])
  int main(int argc,char **argv)
  ```

# `const`

C语言const：禁止修改变量的值 http://c.biancheng.net/cpp/html/3258.html
- > 当一个指针变量 str1 被 `const` 限制时，并且类似 `const char *str1` 这种形式，说明指针指向的数据不能被修改；如果将 str1 赋值给另外一个未被 `const` 修饰的指针变量 str2，就有可能发生危险。因为通过 str1 不能修改数据，而赋值后通过 str2 能够修改数据了，意义发生了转变，所以编译器不提倡这种行为，会给出错误或警告。
- > 也就是说，`const char *` 和 `char *` 是不同的类型，不能将 `const char *` 类型的数据赋值给 `char *` 类型的变量。但反过来是可以的，编译器允许将 `char *` 类型的数据赋值给 `const char *` 类型的变量。
- > 这种限制很容易理解，`char *` 指向的数据有读取和写入权限，而 `const char *` 指向的数据只有读取权限，降低数据的权限不会带来任何问题，但提升数据的权限就有可能发生危险。
