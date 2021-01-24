
>> 注：本文件既包括C++的内存管理，也包括C的。

# 为什么需要动态分配内存

Why, or when, do you need to dynamically allocate memory in C? https://stackoverflow.com/questions/18217525/why-or-when-do-you-need-to-dynamically-allocate-memory-in-c
- https://stackoverflow.com/questions/18217525/why-or-when-do-you-need-to-dynamically-allocate-memory-in-c/18220706#18220706
  * > You need to use dynamic memory when:
    + > You cannot determine the maximum amount of memory to use at compile time;
    + > You want to allocate a very large object;
    + > You want to build data structures (containers) without a fixed upper size;

When should I use malloc in C and when don't I? https://stackoverflow.com/questions/1963780/when-should-i-use-malloc-in-c-and-when-dont-i

What is Dynamic Memory Allocation? https://www.geeksforgeeks.org/what-is-dynamic-memory-allocation/
- > **How computer creates a variable?**
  * > When we think of creating something, we think of creating something from the very scratch, while this isn’t what actually happens when a computer creates a variable ‘X’; to the computer, is more like an allocation, the computer just assigns a memory cell from a lot of pre-existing memory cells to X. It’s like someone named ‘RAJESH’ being allocated to a hotel room from a lot of free or empty pre-existing rooms. This example probably made it very clear as how the computer does the allocation of memory.
  * > Now, what is **Static Memory Allocation**? When we declare variables, we actually are preparing all the variables that will be used, so that ***the compiler knows that*** the variable being used is actually an important part of the program that the user wants and not just a rogue symbol floating around. So, when we declare variables, what the compiler actually does is allocate those variables to their rooms (refer to the hotel analogy earlier). Now, if you see, ***this is being done before the program executes***, you ***can’t allocate variables by this method while the program is executing***.
- > **Dynamic memory allocation** is the process of assigning the memory space ***during the execution time or the run time***.
- > **Reasons and Advantage of allocating memory dynamically:**
  * > 1.When we do not know how much amount of memory would be needed for the program beforehand.
  * > 5.When you want you to use the concept of structures and linked list in programming, dynamic memory allocation is a must.

为什么C链表节点要用malloc函数动态分配大小？ - 知乎 https://www.zhihu.com/question/430245890
- 为什么C链表节点要用malloc函数动态分配大小？ - 邱昊宇的回答 - 知乎 https://www.zhihu.com/question/430245890/answer/1576233061

# `malloc/free` V.S. `new/delete`

细说new与malloc的10点区别 https://www.cnblogs.com/qg-whz/p/5140930.html || https://cloud.tencent.com/developer/article/1155150 || https://blog.csdn.net/linux_ever/article/details/50533149
- > **3.内存分配失败时的返回值**
  * > new内存分配失败时，会抛出bac_alloc异常，它不会返回NULL；malloc分配内存失败时返回NULL。
  * > 在使用C语言时，我们习惯在malloc分配内存后判断分配是否成功：
    ```c
    int *a  = (int *)malloc ( sizeof (int ));
    if(NULL == a)
    {
        ...
    }
    else 
    {
        ...
    }
    ```
  * > 从C语言走入C++阵营的新手可能会把这个习惯带入C++：
    ```cpp
    int * a = new int();
    if(NULL == a)
    {
        ...
    }
    else
    {   
        ...
    }
    ```
  * > 实际上这样做一点意义也没有，因为new根本不会返回NULL，而且程序能够执行到if语句已经说明内存分配成功了，如果失败早就抛异常了。正确的做法应该是使用异常机制：
    ```cpp
    try
    {
        int *a = new int();
    }
    catch (bad_alloc)
    {
        ...
    }
    ```

C语言编程基础-malloc和new https://blog.csdn.net/baidu_35692628/article/details/69817723
- > **`void *free(int *Pointer);`**
  * > 注意：参数是指向内存块的指针，释放的是内存不是指针本身。内存释放后，指针指向未定义的内容垃圾，所以经常做如下处理，防止产生野指针，又被解引用。
    ```cpp
    char *p = (char *)malloc(sizeof(char) * 8);
    memset(p, 0 ,8);
        .
        .
        .
    free(p);
    p = NULL;
    ```
- > 如果在函数里定义了一个指针变量，然后在这个函数里申请了一块内存让指针指向它。实际上，这个指针的地址是在栈上，但是它所指向的内容却是在堆上面的。 <br> 注意：函数所在的**栈**被销毁**指针**也跟着销毁，但申请的**内存**并没有一样跟着销毁！因为申请的内存在堆上，而函数所在的栈被销毁跟堆完全没有关系。所以一定记得释放free！
- > ~~由于系统资源有限，用new申请内存空间，并一定任何时候都能申请到足够的内存空间。一般申请完后应加一个条件进行判断：~~  -->  ***这段应该是写错了，首先和原文后面的内容就矛盾，其次和其他文章的结论也矛盾。用new申请内存时，用NULL判断是没用的，应该是用异常机制***。
  ```cpp
  if (p3 != NULL)
  {
      ... //程序代码
  }
  else
  {
      ... //抛出异常，内存空间申请失败
  }
  ```
- > new对应的三种释放内存方式
  ```cpp
  void FreeMem()
  {
      int  i;
      int *p0=&i;
      int  * p1=new int;
      int  *p2=new int(100);  //*p2初始化为100
      int  *p3=new int[1000]  //申请1000个int类型空间
  
    // 使用以上指针后，最后要予以释放内存空间
  
      delete p0;              //错误！p0指针不是用new动态申请的
  
    //下面三个是正确的写法
      delete p1;
      delete p2;
      delete []p3;            //不能用delete p3,申请用了[]，释放时要用delete[]
  }
  ```
- > **4.malloc()和new的区别**
```
(1) C++中可以使用new操作符也可以使用malloc函数，而C中只能使用malloc函数。
(2) new操作符从自由存储区（free store）上为对象动态分配内存空间，而malloc函数从堆上动态分配内存。
    自由存储区不仅可以是堆，还可以是静态存储区，取决于operator new在哪里为对象分配内存
(3) malloc内存分配成功则是返回void *，需要通过强制类型转换将void*指针转换成我们需要的类型；
    new操作符内存分配成功时，返回的是对象类型的指针，类型严格与对象匹配，无须进行类型转换。
    故new是符合类型安全性的操作符
(4) （普通）new内存分配失败时，会抛出bac_alloc异常，它不会返回NULL；malloc分配内存失败时返回NULL。
    malloc分配内存后判断分配是否成功
    new使用异常机制判断内存是否分配成功
(5) malloc需显式地指出所需内存大小；new操作符申请内存分配时无须指定内存块的大小，编译器会根据类型信息自行计算。
(6) new/delete会调用对象的构造/析构函数以完成对象的构造/析构；而malloc则不会。
    故标准库中凡是需要构造/析构的类型通通不合适用malloc/free来处理
(7) malloc和new是否可以相互调用
    malloc的实现不可以去调用new，而operator new /operator delete的实现可以基于malloc
(8) malloc和new是否可以被重载
    malloc/free不允许重载；opeartor new /operator delete可以被重载，标准库定义了operator new函数和operator delete函数的8个重载版本
(9) 能否直观的重分配内存
    使用malloc过程中发现内存不足，可用realloc函数进行内存扩充或重分配；new没有这样直观的配套设施来扩充内存。

    malloc使用realloc重分配内存：
    realloc先判断当前的指针所指内存是否有足够的连续空间，如果有，原地扩大可分配的内存地址，并且返回原来的地址指针；
    如果空间不够，先按照新指定的大小分配空间，将原有数据从头到尾拷贝到新分配的内存区域，而后释放原来的内存区域。
```

C++ 动态内存 https://www.runoob.com/cplusplus/cpp-dynamic-memory.html
- > C++ 程序中的内存分为两个部分：
  * > **栈**：在函数内部声明的所有变量都将占用栈内存。
  * > **堆**：这是程序中未使用的内存，在程序运行时可用于动态分配内存。
- > 很多时候，您无法提前预知需要多少内存来存储某个定义变量中的特定信息，所需内存的大小需要在运行时才能确定。

C 语言动态数组 https://www.runoob.com/w3cnote/c-dynamic-array.html
- > 在实际的编程中，往往会发生这种情况，即所需的内存空间取决于实际输入的数据，而无法预先确定。对于这种问题，用静态数组的办法很难解决。为了解决上述问题，C语言提供了一些内存管理函数，这些内存管理函数结合指针可以按需要动态地分配内存空间，来构建动态数组，也可把不再使用的空间回收待用，为有效地利用内存资源提供了手段。
- > 动态数组，是相对于静态数组而言。静态数组的长度是预先定义好的，在整个程序中，一旦给定大小后就无法改变。而动态数组则不然，它可以随程序需要而重新指定大小。动态数组的内存空间是从堆（heap）上分配（即动态分配）的。是通过执行代码而为其分配存储空间。当程序执行到这些语句时，才为其分配。程序员自己负责释放内存。
- > **为什么要使用动态数组？**
  * > 在实际的编程中，往往会发生这种情况，即所需的内存空间取决于实际输入的数据，而无法预先确定。对于这种问题，用静态数组的办法很难解决。为了解决上述问题，C语言提供了一些内存管理函数，这些内存管理函数结合指针可以按需要动态地分配内存空间，来构建动态数组，也可把不再使用的空间回收待用，为有效地利用内存资源提供了手段。

C/C++中的malloc、calloc和realloc https://segmentfault.com/a/1190000017816285?utm_source=sf-related
- > `void*`表示未确定类型的指针，更明确的说是指申请内存空间时还不知道用户是用这段空间来存储什么类型的数据（比如是char还是int或者...）。从函数声明上可以看出。`malloc`和`new`至少有两个不同:`new`返回指定类型的指针，并且可以自动计算所需要大小。
- > `malloc`函数返回的是`void *`类型。对于C++，如果你写成：`p = malloc (sizeof(int));`则程序无法通过编译，报错：“不能将`void*`赋值给`int *`类型变量”。所以必须通过`(int *)`来将强制转换。而对于C，没有这个要求，但为了使C程序更方便的移植到C++中来，建议养成强制转换的习惯。
- > `calloc`在动态分配完内存后，自动初始化该内存空间为零，而`malloc`不初始化，里边数据是随机的垃圾数据。
- > 使用语法：`指针名 = (数据类型*)realloc(要改变内存大小的指针名，新的大小)。` //新的大小一定要大于原来的大小不然的话会导致数据丢失！

C语言内存泄露很严重，如何应对？ https://juejin.im/post/6867355456839843847
- > 内存泄漏问题只有在使用堆内存的时候才会出现，栈内存不存在内存泄漏问题，因为栈内存会自动分配和释放。C代码中堆内存的申请函数是malloc，常见的内存申请代码如下：

# 堆和栈

为什么c++中要分为heap（堆）和stack（栈）? - 知乎 https://www.zhihu.com/question/281940376
- 为什么c++中要分为heap（堆）和stack（栈）? - 朱元的回答 - 知乎 https://www.zhihu.com/question/281940376/answer/425123578
  * > 栈让你分配和释放简单化，但是他有一个重大缺点：释放的次序是固定的，必须是分配次序的反序。
  * > 假设栈上对象分配次序是ABCDEF。 可能在某些情况时，我释放F的时候，A可以释放了但其他对象都不能释放；某些情况时我释放F的时候，B可以释放了但其他对象都不能释放.... 对不起 这些栈上对象都不能提前释放：ABCD必须等待F和E释放了之后才能释放。。
  * > 换而言之，栈的分配和释放非常迅速（一个函数内栈的分配和回收 各自只需要一条指令），但是释放非常不灵活，极易造成浪费。越是复杂的程序，函数调用栈越深的情况，你将越会频繁的遇到这种函数A call 函数B，B知道A的某个局部变量可以提前回收内存了但是却无能为力除非B返回的场景。
  * > 所以，操作系统api都会限制栈的最大大小来让你浪费有个上限度，并且提供了“堆”。事实上，在栈出来之前，所有的内存都是堆，所有的内存都是供程序员自由的分配和释放。然而堆的管理显然复杂的多，因为栈的已分配和未分配内存各自是连续的一块，堆却是很多块已分配和未分配的内存混杂在一起，需要程序员去在这些内存块里标记他们的长度，分配时选择或者分割一个合适的块，回收时合理的进行合并。所以高级语言出来把栈和堆分开之后，第一件事就是得封装堆，glibc就是干这事。
  * > 事实上，即使在堆上面，现代化的高级语言也会有一些桎梏让你并不能随意的，随时随地的释放你认为可以释放的内存，很多语法概念中都蕴含了“栈”的概念。
  * > 例如，一个C++的对象X，他有数据成员a和b, 现在我知道我不再使用X.a了，但是我还会使用X.b，有没有办法去“浅释放”X.a所占的sizeof(X.a)的内存呢？抱歉不行，你只能先释放X，在释放X的过程中去释放X.a和X.b（不能只释放一个）。而且这和X在堆还是在栈上分配没有任何关系。
  * > 换而言之，面向对象语言中的“对象”，从他的成员的构建过程中蕴含了“栈的概念”，所以他的释放依然受制于栈的先入后出的规则影响。类似于默认生成的析构函数总是先调用对象的析构函数再去遍历调用成员的析构函数一样，只是可以把这个栈看成分叉栈，或者树的先序遍历。

c++中堆、栈内存分配 https://www.cnblogs.com/yyxt/p/4268304.html

C++内存分区以及堆内存和栈内存 https://developer.aliyun.com/article/9149

# memset()

memset http://www.cplusplus.com/reference/cstring/memset/
>> http://cpp.sh/9cp
```cpp
/* memset example */
#include <stdio.h>
#include <string.h>

int main ()
{
  char str[] = "almost every programmer should know memset!";
  memset (str,'-',6);
  puts (str);
  return 0;
}
----------------------------------------------------------------------------------------------------
------ every programmer should know memset!
```

memset() in C with examples https://www.geeksforgeeks.org/memset-c-example/
```c
memset() is used to fill a block of memory with a particular value.
The syntax of memset() function is as follows :

// ptr ==> Starting address of memory to be filled
// x   ==> Value to be filled
// n   ==> Number of bytes to be filled starting 
//         from ptr to be filled
void *memset(void *ptr, int x, size_t n);

Note that ptr is a void pointer, so that we can pass any type of pointer to this function.
```

# 字节对齐

Memory allocation strategy for struct and union in C programming language https://www.beansmile.com/blog/posts/memory-allocation-strategy-for-struct-and-union
- > Different data type may takes different memory spaces. We also measure the memory costs by **byte** instead of **bit** in machine underlayer. 1 byte usually equals to 8 bits and 1 byte also represented by **char** data type in C programming language. You can use this simple program to valid it.
  ```c
  #include <stdio.h>
  
  char * unit(size) {
    return size > 1 ? "bytes" : "byte";
  }
  
  int main() {
    unsigned long c_size = sizeof(char);
    unsigned long i_size = sizeof(int);
    unsigned long l_size = sizeof(long);
    unsigned long f_size = sizeof(float);
    unsigned long d_size = sizeof(double);
  
    printf("Char data type takes %ld %s\n", c_size, unit(c_size));
    printf("Int data type takes %ld %s\n", i_size, unit(i_size));
    printf("Long data type takes %ld %s\n", l_size, unit(l_size));
    printf("Float data type takes %ld %s\n", f_size, unit(f_size));
    printf("Double data type takes %ld %s\n", d_size, unit(d_size));
  }
  //////////////////////////////////////////////////
  /*
  Char data type takes 1 byte
  Int data type takes 4 bytes
  Long data type takes 8 bytes
  Float data type takes 4 bytes
  Double data type takes 8 bytes
  */
  ```

面试常考，项目易错，长文详解C/C++中的字节对齐 https://mp.weixin.qq.com/s/-sAIWxXy0j0C57B1iWi4zQ

浅谈C++内存管理 - 吉良吉影的文章 - 知乎 https://zhuanlan.zhihu.com/p/51855842

C++ 内存对齐 https://mp.weixin.qq.com/s/evaQkvhGm0c-DIFVnYJghw || http://www.cnblogs.com/TenosDoIt/p/3590491.html
