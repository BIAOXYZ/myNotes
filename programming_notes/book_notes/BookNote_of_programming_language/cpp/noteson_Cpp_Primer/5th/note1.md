
## 1.2　初识输入输出

> 程序员常常在调试时添加打印语句。这类语句应该保证“一直”刷新流。否则，如果程序崩溃，输出可能还留在缓冲区中，从而导致关于程序崩溃位置的错误推断。

【[:star:][`*`]】 个人实战笔记：***可见加了`endl`的第一个打印是执行完那一行就打印到屏幕了，而后面三行打印必须等到`endl`了才一起打印出来，符合书中的描述。***
```cpp
#include <iostream>
using namespace std;
int main() {
    std::cout << "**********1st message will be printed immediately because it has std::endl**********" << std::endl;
    std::cout << "**********2nd message will NOT be printed immediately**********";
    std::cout << "**********3rd message will NOT be printed immediately**********";
    std::cout << "**********This and the other two will be printed!**********";
    std::cout << std::endl;
    return 0;
}
```
```sh
$ g++ -g -o testcout testcout.cpp
$ gdb testcout
(gdb) b main
(gdb) r
Breakpoint 1, main () at testcout.cpp:4
4	    std::cout << "**********1st message will be printed immediately because it has std::endl**********" << std::endl;
(gdb) n
**********1st message will be printed immediately because it has std::endl**********
5	    std::cout << "**********2nd message will NOT be printed immediately**********";
(gdb)
6	    std::cout << "**********3rd message will NOT be printed immediately**********";
(gdb)
7	    std::cout << "**********This and the other two will be printed!**********";
(gdb)
8	    std::cout << std::endl;
(gdb)
**********2nd message will NOT be printed immediately********************3rd message will NOT be printed immediately********************This and the other two will be printed!**********
9	    return 0;
(gdb)
10	}
(gdb)
```

### 1.4.3　读取数量不定的输入数据

> `while` 循环条件的求值就是执行表达式 `std::cin >> value`。此表达式从标准输入读取下一个数，保存在value中。***<ins>输入运算符（参见1.2节，第7页）返回其左侧运算对象</ins>，在本例中是`std：：cin`***。因此，此循环条件实际上检测的是`std：：cin`。
> 
> 当我们使用一个`istream`对象作为条件时，其效果是检测流的状态。如果流是有效的，即流未遇到错误，那么检测成功。***当遇到文件结束符（end-of-file），或遇到一个无效输入时（例如读入的值不是一个整数）***，`istream`对象的状态会变为无效。处于无效状态的`istream`对象会使条件变为假。
> 
> 当从键盘向程序输入数据时，对于如何指出文件结束，不同操作系统有不同的约定。在Windows系统中，输入文件结束符的方法是敲`Ctrl+Z`（按住Ctrl键的同时按Z键），然后按Enter或Return键。在UNIX系统中，包括Mac OS X系统中，文件结束符输入是用`Ctrl+D`。

个人实战：
```cpp
#include <iostream>
int main() {
    int sum = 0, value = 0;
    while (std::cin >> value)
        sum += value;
    std::cout << "Sum is: " << sum << std::endl;
    return 0;
}
```
```sh
$ g++ test.cpp -o test 

# 用 Ctrl + C 相当于把程序强行结束了，不打印结果。
$ ./test 
1
2
^C
$ 

# 用 Ctrl + D（也就是 EOF）正常结束掉 std::cin，打印结果。 
$ ./test 
1
2
3

Sum is: 6
$ 

# 用字母（非数字）正常结束掉 std::cin，打印结果。
$ ./test 
1
2
3
a
Sum is: 6
$ 
```
