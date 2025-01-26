
# C结构体

## struct和typedef struct

struct和typedef struct彻底明白了 http://www.cnblogs.com/qyaizs/articles/2039101.html
```console
　　2.

　　　　typedef struct tagMyStruct
　　　　{
　　　　　int iNum;
　　　　　long lLength;
　　　　} MyStruct;

　　　　在C中，这个申明后申请结构变量的方法有两种：

　　　　（1）struct tagMyStruct 变量名

　　　　（2）MyStruct 变量名

　　　　在c++中可以有

　　　　（1）struct tagMyStruct 变量名

　　　　（2）MyStruct 变量名

　　　　（3）tagMyStruct 变量名
```

typedef struct和struct定义结构体的区别 https://www.cnblogs.com/sparon/archive/2010/12/06/1897835.html

https://stackoverflow.com/questions/612328/difference-between-struct-and-typedef-struct-in-c
```
注意最高票答案里的tag namespace 和 identifier namespace。说明C语言其实底层（对编程者透明）也是有名字空间的。
```

为什么 Linux 内核中不经常使用 typedef？ - pansz的回答 - 知乎 https://www.zhihu.com/question/20928231/answer/16632332

## from wiki

结构体 (C语言) https://zh.wikipedia.org/wiki/%E7%BB%93%E6%9E%84%E4%BD%93_(C%E8%AF%AD%E8%A8%80)
- > 结构体的定义如下所示，`struct`为结构体关键字，`tag`为结构体的标志，`member-list`为结构体成员列表，其必须列出其所有成员；`variable-list`为此结构体声明的变量。
  ```c
  struct tag { member-list } variable-list ; 
  ```
- > 在一般情况下，`tag、member-list、variable-list`这3部分至少要出现2个。以下为示例：
  ```c
  //此声明声明了拥有3个成员的结构体，分别为整型的a，字符型的b和双精度的c
  //同时又声明了结构体变量s1
  //这个结构体并没有标明其标签
  struct 
  {
      int a;
      char b;
      double c;
  } s1;

  //此声明声明了拥有3个成员的结构体，分别为整型的a，字符型的b和双精度的c
  //结构体的标签被命名为SIMPLE,没有声明变量
  struct SIMPLE
  {
      int a;
      char b;
      double c;
  };
  //用SIMPLE标签的结构体，另外声明了变量t1、t2、t3
  struct SIMPLE t1, t2[20], *t3;

  //也可以用typedef创建新类型
  typedef struct
  {
      int a;
      char b;
      double c; 
  } Simple2;
  //现在可以用Simple2作为类型声明新的结构体变量
  Simple2 u1, u2[20], *u3;
  ```
  > 在上面的声明中，第一个和第二声明被编译器当作两个完全不同的类型，即使他们的成员列表是一样的，如果令`t3=&s1`，则是非法的。

typedef https://zh.wikipedia.org/wiki/Typedef
- > **与数组一起使用**
  ```c
  typedef char arrType[6];    // type name: arrType
                              // new type: char[6]

  arrType arr={1,2,3,4,5,6};  // same as: char arr[6]={1,2,3,4,5,6}

  arrType *pArr;              // same as: char (*pArr)[6];
  ```
  > 在这里，`arrType`是`char[6]`的别称。而`arrType *pArr;`则表示pArr是一个指向存储`char[6]`类型存储器的指针。

## from stackoverflow

Arrow operator (->) usage in C https://stackoverflow.com/questions/2575048/arrow-operator-usage-in-c

if(null!=variable) why not if(variable!=null) https://stackoverflow.com/questions/4985074/ifnull-variable-why-not-ifvariable-null
> https://www.zhihu.com/question/27336966
