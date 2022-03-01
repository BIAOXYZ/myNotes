
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
