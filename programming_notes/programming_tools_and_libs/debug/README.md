
Linux下怎样判断一个binary是否可以debug https://blog.csdn.net/yasi_xi/article/details/45824149
- > 用下面的命令即可，如果可以debug，则会显示debug相关的一些信息，否则没有相关信息。
  * > `objdump --syms your-binary | grep debug`  或  `objdump -t your-binary | grep debug`
- > 示例：
  * > 检查一个可以debug的binary：
    ```sh
    [root@ampcommons02 test]# objdump -t t-debug | grep debug
    t-debug:     file format elf64-x86-64
    0000000000000000 l    d  .debug_aranges 0000000000000000              .debug_aranges
    0000000000000000 l    d  .debug_pubnames        0000000000000000              .debug_pubnames
    0000000000000000 l    d  .debug_info    0000000000000000              .debug_info
    0000000000000000 l    d  .debug_abbrev  0000000000000000              .debug_abbrev
    0000000000000000 l    d  .debug_line    0000000000000000              .debug_line
    0000000000000000 l    d  .debug_str     0000000000000000              .debug_str
    0000000000000000 l    d  .debug_pubtypes        0000000000000000              .debug_pubtypes
    0000000000000000 l    d  .debug_ranges  0000000000000000              .debug_ranges
    ```
  * > 检查一个不能debug的binary：
    ```sh
    [root@ampcommons02 test]# objdump -t t-release | grep debug
    ```

linux上如何分辨一个二进制可执行文件是debug还是release的 https://blog.csdn.net/kingofmyheart/article/details/116862624
- > 假设，我们可执行文件是a.out：
  * > `readelf -S a.out | grep debug`
- > 如果，该文件是debug的，则会打印出类似这样的信息：
  ```console
    [29] .debug_aranges    PROGBITS         0000000000000000  00003042
    [30] .debug_info       PROGBITS         0000000000000000  000030d2
    [31] .debug_abbrev     PROGBITS         0000000000000000  00005f41
    [32] .debug_line       PROGBITS         0000000000000000  00006635
    [33] .debug_str        PROGBITS         0000000000000000  00006b22
    [34] .debug_ranges     PROGBITS         0000000000000000  00008659
  ```
- > 如果，该文件是release的，一般将不会打印出任何信息。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 方便debug的宏

## 个人总结 C 语言版
>> //notes：写成函数的形式是不行的，因为打印的永远是函数所在文件名、函数名和固定的行号。

1.一行的版本：
```c
printf("[[c-lang | in source file:\"%s\" | function:\"%s()\" | line:%d]]\n", __FILE__, __FUNCTION__, __LINE__);
```
```c
#include<stdio.h>
int main() {
    printf("[[c-lang | in source file:\"%s\" | function:\"%s()\" | line:%d]]\n", __FILE__, __FUNCTION__, __LINE__);
    printf("[[c-lang | in source file:\"%s\" | function:\"%s()\" | line:%d]]\n", __FILE__, __FUNCTION__, __LINE__);
    printf("[[c-lang | in source file:\"%s\" | function:\"%s()\" | line:%d]]\n", __FILE__, __FUNCTION__, __LINE__);
}
```
```sh
$ gcc test.cpp -o test
$ ./test 
[[c-lang | in source file:"test.cpp" | function:"main()" | line:3]]
[[c-lang | in source file:"test.cpp" | function:"main()" | line:4]]
[[c-lang | in source file:"test.cpp" | function:"main()" | line:5]]
```

2.总结成宏（函数不行貌似）的版本
```c
#define DEBUG_PRINT printf("[[c-lang | in source file:\"%s\" | function:\"%s()\" | line:%d]] %s\n", __FILE__, __func__, __LINE__)
// or 顺带打印变量的版本
#define DEBUG_PRINT(msg) printf("[[c-lang | in source file:\"%s\" | function:\"%s()\" | line:%d]] %s\n", __FILE__, __func__, __LINE__, msg)
// or 打印变量的版本2，比上面那个好用
#define DEBUG_PRINT(var) \
fprintf(stdout, "[[c-lang | in source file:\"%s\" | function:\"%s()\" | line:%d]] %s = %s\n", \
        __FILE__, __func__, __LINE__, #var, var)
// or 打印变量的版本3，不但支持更多类型，而已有颜色（就是太长了，而且似乎会额外引入一些告警）
#define DEBUG_PRINT(var) \
    do { \
        fprintf(stdout, \
            "[[c-lang | file:'\033[96m%s\033[0m' " \
            "| func:'\033[94m%s()\033[0m' " \
            "| lno:\033[93m%d\033[0m]] %s = ", \
            __FILE__, __func__, __LINE__, #var); \
        if (__builtin_types_compatible_p(typeof(var), int)) { \
            fprintf(stdout, "%d\n", (var)); \
        } else if (__builtin_types_compatible_p(typeof(var), float)) { \
            fprintf(stdout, "%f\n", (var)); \
        } else if (__builtin_types_compatible_p(typeof(var), double)) { \
            fprintf(stdout, "%lf\n", (var)); \
        } else if (__builtin_types_compatible_p(typeof(var), long)) { \
            fprintf(stdout, "%ld\n", (var)); \
        } else if (__builtin_types_compatible_p(typeof(var), short)) { \
            fprintf(stdout, "%hd\n", (var)); \
        } else if (__builtin_types_compatible_p(typeof(var), char)) { \
            fprintf(stdout, "%c\n", (var)); \
        } else if (__builtin_types_compatible_p(typeof(var), const char *) || \
                   __builtin_types_compatible_p(typeof(var), char *)) { \
            fprintf(stdout, "%s\n", (var)); \
        } else if (__builtin_types_compatible_p(typeof(var), void *)) { \
            fprintf(stdout, "%p\n", (var)); \
        } else { \
            fprintf(stdout, "[unsupported type]\n"); \
        } \
    } while (0)
```
```c
#include <stdio.h>
#define DEBUG_PRINT(msg) \
    printf("[[c-lang | in source file:\"%s\" | function:\"%s()\" | line:%d]] %s\n", \
        __FILE__, __func__, __LINE__, msg)
int main() {
    char *str = "hello world";
    DEBUG_PRINT(str);
    DEBUG_PRINT(str);
    DEBUG_PRINT(str);
    return 0;
}
```
```sh
$ gcc test.cpp -o test
$ ./test 
[[c-lang | in source file:"test.cpp" | function:"main()" | line:7]] hello world
[[c-lang | in source file:"test.cpp" | function:"main()" | line:8]] hello world
[[c-lang | in source file:"test.cpp" | function:"main()" | line:9]] hello world
```

### 参考

C++ 中 `__FILE__`, `__LINE__`, `__FUNCTION__` 含义 https://blog.csdn.net/weixin_39681471/article/details/109612681
```cpp
__LINE__  // 是内置宏，代表该行代码的所在行号
__FUNCTION__　// 是内置宏，代表代码所在的函数
__FILE__ // 是内置宏，代表代码所在的文件
```
测试：
```cpp
#include <iostream>
using namespace std;
void func()
{
    printf("source file \"%s\", line %d, in function %s" ,__FILE__, __LINE__, __FUNCTION__);
}
int main()
{
    func();
    return 0;
}
```
输出：
```console
source file "/home/vscode/log/main.cpp", line 10, in function func
```

`__FILE__`, `__LINE__`, and `__FUNCTION__` usage in C++ https://stackoverflow.com/questions/597078/file-line-and-function-usage-in-c

`__FILE__`, `__LINE__`, `FUNCTION__` 实现代码跟踪调试（linux下c语言编程 ）(转自IT博客） https://www.cnblogs.com/nufangrensheng/archive/2012/11/16/2774046.html

`__func__`, `__FUNCTION__`, `__PRETTY_FUNCTION__` https://www.jianshu.com/p/7cd2b1c8542a
- > `__func__` 是C99标准的一部分
- > `__FUNCTION__` 跟 `__func__` 效果一样，只是为了兼容旧版的GCC
- > `__PRETTY_FUNCTION__` 在 c++ 中，`__PRETTY_FUNCTION__` 既包含函数的签名，也包含函数的名称。
- > 结论：尽量使用 `__PRETTY_FUNCTION__` 可以打印完整的方法签名，无论是调试还是记录log都很有用

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 个人总结 C++ 语言版

```cpp
std::cout << "[[cpp-lang | in source file:\"" << __FILE__ << "\" | function:\"" << __FUNCTION__ << "()\" | line:" << __LINE__ << "]] " << std::endl;
```
```cpp
std::cout << "[[cpp-lang | in source file:\"" << __FILE__ << "\" | function:\"" << __FUNCTION__ << "()\" | line:" << __LINE__ << "]] " << var << std::endl;
```
```cpp
std::cout<<"[[cpp-lang | in source file:\""<<__FILE__<<"\" | function:\""<<__FUNCTION__<<"()\" | line:"<<__LINE__<<"]] "<<" cpp-value of [v]: "<<v<<std::endl;
```
```cpp
#include <iostream>
int main() {
    std::cout << "[[cpp-lang | in source file:\"" << __FILE__ << "\" | function:\"" << __FUNCTION__ << "()\" | line:" << __LINE__ << "]] " << std::endl;
    std::cout << "[[cpp-lang | in source file:\"" << __FILE__ << "\" | function:\"" << __FUNCTION__ << "()\" | line:" << __LINE__ << "]] " << std::endl;
    std::cout << "[[cpp-lang | in source file:\"" << __FILE__ << "\" | function:\"" << __FUNCTION__ << "()\" | line:" << __LINE__ << "]] " << std::endl;
    return 0;
}
```
```sh
$ g++ test.cpp -o test
$ ./test 
[[cpp-lang | in source file:"test.cpp" | function:"main()" | line:3]] 
[[cpp-lang | in source file:"test.cpp" | function:"main()" | line:4]] 
[[cpp-lang | in source file:"test.cpp" | function:"main()" | line:5]]
```


:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 个人总结 Python 语言版

最常用版：
```py
import sys;print(f"[[py-lang | file:\"{__file__}\" | func:\"{sys._getframe().f_code.co_name}()\" | line:{sys._getframe().f_lineno}]]")
```

>> //notes：这个（一行的版本）貌似就不错，只需要用到 `sys`，不需要用到 `inspect`。
```py
print("[[py-lang | in source file:\"{}\" | function:\"{}()\" | line:{}]]".format(__file__, sys._getframe().f_code.co_name, sys._getframe().f_lineno))
```
```py
import inspect
import sys
def debug_print(msg=''):
    cur_frame = inspect.currentframe()
    if cur_frame is not None:
        frame_info = inspect.getframeinfo(cur_frame.f_back)
        print("[[py-lang | in source file:\"{}\" | function:\"{}\" | line:{}]] {}".format(frame_info.filename, inspect.stack()[1][3], frame_info.lineno, msg))
    else:
        print("[[py-lang | ERROR: Failed to get current frame]]")

def foo():
    print('*'*50)
    print("[[py-lang | in source file:\"{}\" | function:\"{}()\" | line:{}]]".format(__file__, sys._getframe().f_code.co_name, sys._getframe().f_lineno))
    debug_print("this is a debug message")
    print('*'*50)

if __name__ == '__main__':
    foo()
    foo()
    print("[[py-lang | in source file:\"{}\" | function:\"{}()\" | line:{}]]".format(__file__, sys._getframe().f_code.co_name, sys._getframe().f_lineno))
    print("[[py-lang | in source file:\"{}\" | function:\"{}()\" | line:{}]]".format(__file__, sys._getframe().f_code.co_name, sys._getframe().f_lineno))
    debug_print(12345)
    debug_print(67890)
```
```sh
$ python3 general_test.py 
**************************************************
[[py-lang | in source file:"general_test.py" | function:"foo()" | line:13]]
[[py-lang | in source file:"general_test.py" | function:"foo" | line:14]] this is a debug message
**************************************************
**************************************************
[[py-lang | in source file:"general_test.py" | function:"foo()" | line:13]]
[[py-lang | in source file:"general_test.py" | function:"foo" | line:14]] this is a debug message
**************************************************
[[py-lang | in source file:"general_test.py" | function:"<module>()" | line:20]]
[[py-lang | in source file:"general_test.py" | function:"<module>()" | line:21]]
[[py-lang | in source file:"general_test.py" | function:"<module>" | line:22]] 12345
[[py-lang | in source file:"general_test.py" | function:"<module>" | line:23]] 67890
```

Print current call stack from a method in code https://stackoverflow.com/questions/1156023/print-current-call-stack-from-a-method-in-code
- https://stackoverflow.com/questions/1156023/print-current-call-stack-from-a-method-in-code/56897183#56897183
  ```py
  import inspect;print(*['{:40}| {}:{}\n'.format(x.function, x.filename, x.lineno) for x in inspect.stack()])
  ```
