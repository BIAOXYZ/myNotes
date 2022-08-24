
# 指针general

C 和 C++ 中的指针 https://liam0205.me/2017/02/05/pointer-in-C-and-Cpp/

《深入理解C指针》笔记 - 第五章 字符串与指针 https://laoshuterry.gitbooks.io/noteofcpointer/content/Chapter05.html

【[:star:][`*`]】 C指针与内存 https://smartkeyerror.com/c-pointers-and-memory
- > **1.指针**
  * > 在 C 函数实现中，所传入的参数均为原有变量的一个拷贝，在函数中对参数进行修改是无法影响到原有变量的值的，若需要对参数进行修改，可向函数传递该变量的内存地址。如此一来，即使对参数（地址）进行了拷贝，也可以通过地址对其进行修改，而变量的地址就保存在指针当中。
    ```c
    void main() {
        int number;
        int *pointer;
    }
    ```
  * > 如上述代码所示，语句 `int number` 声明了一个变量，且其类型为整型。语句 `int *pointer` 同样声明了一个变量，只不过 `*pointer` 的类型为整型而已。`*` 作为一元操作符时表示对间接寻址或者是间接引用，所以变量 `pointer` 是一个指针，其中保存了变量的地址。
  * > 实际上，`int *pointer` 也可以写作为 `int* pointer`，对于编译器而言，这两种方式最终的结果都是一样的: 声明一个指针变量。***但是，`int*` 这一写法会让人产生歧义，认为 `pointer` 是一个 `int*` 类型，然而 C 语言中并无该类型。应当将 `*pointer` 作为一个整体看待，其类型为 `int`***。
    >> 【[:star:][`*`]】 //notes：所以又有了新的视角，可以把 `int *p;` 理解为：***定义了一个变量 `p`，变量 `p` 解引用一次后指向（or 成为）一个整型变量***。那么同理，`int **p;` 表示变量 `p` 解引用两次后指向（or 成为）一个整型变量。
- > **1.2 指针的初始化**
    ```c
    void main() {
        int number = 100;       // ①
        int *pointer;           // ②
        *pointer = number;      // ③
    }
    ```
  * > 上述代码在前两行中声明了两个变量: 整型变量 number 与指向整型的指针 pointer。在第三行中，将 pointer 指向的内存内容更新为 number 的值（100）。在运行时却抛出了 Segmentation fault 错误，这是为什么？
  * > 原因在于 pointer 中保存的值是不确定的，可能是上一个程序中的某一个变量值，也可能恰好是一个地址，我们无法得知变量 pointer 中的内容到底是什么。这种已经声明但为正确初始化的指针通常称之为“野指针”。
  * > 所谓“指针初始化”就是指使得当前指针变量中保存的地址是正确的、合法的，当前进程有权限访问的。因此，对上述代码进行稍加修改即可正确运行：
    ```c
    void main() {
        int number = 100;
        int *pointer;
        pointer = &number;
    }
    ```

# 数组指针 v.s. 指针数组

数组指针和指针数组 https://blog.csdn.net/touch_2011/article/details/6966980

C 语言中指针数组和数组指针、函数指针、指向函数的指针等等该怎么理解？ - 知乎 https://www.zhihu.com/question/59605233
- C 语言中指针数组和数组指针、函数指针、指向函数的指针等等该怎么理解？ - vczh的回答 - 知乎 https://www.zhihu.com/question/59605233/answer/166935479

指针数组和数组指针的详细解答 https://developer.aliyun.com/article/884475

数组指针和指针数组的区别 https://www.cnblogs.com/mq0036/p/3382732.html || C语言指针数组和数组指针 http://c.biancheng.net/cpp/html/476.html

# 函数指针

函数指针及其的运用（上）——何为函数指针 https://www.cnblogs.com/uniqueliu/archive/2011/07/27/2118619.html

# `void*`指针

C 语言中 void* 详解及应用 https://www.cnblogs.com/wuyudong/p/c-void-point.html || https://www.runoob.com/w3cnote/c-void-intro.html 【其实菜鸟笔记里这个转载版本格式更好看点】

C语言指针高级部分: void指针和数据指针 https://blog.csdn.net/qq_29924041/article/details/54882135

# 右左法则

右左法则----复杂指针解析(函数指针与数组指针) https://blog.csdn.net/hyqsong/article/details/52564046

【C语言】右左法则——准确理解所有声明 https://blog.csdn.net/newcong0123/article/details/51883352

右左法则解决复杂声明 http://www.cnblogs.com/bakari/archive/2012/08/28/2659889.html
