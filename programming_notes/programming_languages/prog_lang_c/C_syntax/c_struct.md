
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

## from stackoverflow

Arrow operator (->) usage in C https://stackoverflow.com/questions/2575048/arrow-operator-usage-in-c

if(null!=variable) why not if(variable!=null) https://stackoverflow.com/questions/4985074/ifnull-variable-why-not-ifvariable-null
> https://www.zhihu.com/question/27336966
