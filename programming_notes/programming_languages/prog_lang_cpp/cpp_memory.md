
>> 注：本文件既包括C++的内存管理，也包括C的。

# `malloc/free` V.S. `new/delete`

细说new与malloc的10点区别 https://www.cnblogs.com/qg-whz/p/5140930.html || https://cloud.tencent.com/developer/article/1155150
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

C/C++中的malloc、calloc和realloc https://segmentfault.com/a/1190000017816285?utm_source=sf-related
- > `void*`表示未确定类型的指针，更明确的说是指申请内存空间时还不知道用户是用这段空间来存储什么类型的数据（比如是char还是int或者...）。从函数声明上可以看出。`malloc`和`new`至少有两个不同:`new`返回指定类型的指针，并且可以自动计算所需要大小。
- > `malloc`函数返回的是`void *`类型。对于C++，如果你写成：`p = malloc (sizeof(int));`则程序无法通过编译，报错：“不能将`void*`赋值给`int *`类型变量”。所以必须通过`(int *)`来将强制转换。而对于C，没有这个要求，但为了使C程序更方便的移植到C++中来，建议养成强制转换的习惯。
- > `calloc`在动态分配完内存后，自动初始化该内存空间为零，而`malloc`不初始化，里边数据是随机的垃圾数据。
- > 使用语法：`指针名 = (数据类型*)realloc(要改变内存大小的指针名，新的大小)。` //新的大小一定要大于原来的大小不然的话会导致数据丢失！

C语言内存泄露很严重，如何应对？ https://juejin.im/post/6867355456839843847
- > 内存泄漏问题只有在使用堆内存的时候才会出现，栈内存不存在内存泄漏问题，因为栈内存会自动分配和释放。C代码中堆内存的申请函数是malloc，常见的内存申请代码如下：

# 堆和栈

为什么c++中要分为heap（堆）和stack（栈）? - 知乎 https://www.zhihu.com/question/281940376

c++中堆、栈内存分配 https://www.cnblogs.com/yyxt/p/4268304.html

C++内存分区以及堆内存和栈内存 https://developer.aliyun.com/article/9149