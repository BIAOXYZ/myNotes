
# C general 

Getting Started with C or C++ https://www.cprogramming.com/begin.html

C 资源大全中文版，包括了：构建系统、编译器、数据库、加密、初中高的教程/指南、书籍、库等。 https://github.com/jobbole/awesome-c-cn

📚 C/C++面试基础知识总结 https://github.com/huihut/interview
> https://www.yuque.com/huihut/interview/readme

***--------------------------------------------------分割线--------------------------------------------------***

<<C语言函数调用栈(一)>>
http://www.cnblogs.com/clover-toeic/p/3755401.html

<<循环结构中break、continue、return和exit的区别>>
http://blog.csdn.net/hunanchenxingyu/article/details/8101795

<<"undefined reference to" 问题解决方法>>
http://blog.csdn.net/aiwoziji13/article/details/7330333

<<一个简单的通用Makefile实现>>
http://www.cnblogs.com/fanzhidongyzby/p/3141041.html

C语言变量作用域
http://blog.csdn.net/r91987/article/details/6887731

C语言运算符优先级（超详细）
http://blog.csdn.net/yuliying/article/details/72898132

# C语法知识

## C内联函数
C语言的inline关键字 - CSDN博客
https://blog.csdn.net/lidh04/article/details/3795802

内联函数 —— C 中关键字 inline 用法解析 - CSDN博客
https://blog.csdn.net/zqixiao_09/article/details/50877383

## C字符串操作函数
https://www.cnblogs.com/lidabo/p/5225868.html

### strtok

<<strtok、strtok_s、strtok_r 字符串切割函数>>
https://www.cnblogs.com/zfyouxi/p/4498759.html
> <<怎么用c语言判断一个字符串里是否由某个字符呢？>> http://bbs.bccn.net/thread-473106-1-1.html

关于函数strtok和strtok_r的使用要点和实现原理（二）
http://blog.csdn.net/liuintermilan/article/details/6283705

### strdup

https://stackoverflow.com/questions/252782/strdup-what-does-it-do-in-c


## C内存管理

C语言malloc和free【转载】
http://blog.csdn.net/r91987/article/details/6337032

c语言 malloc函数详解，学习使我快乐... - 午夜逛街的黛玛的文章 - 知乎 https://zhuanlan.zhihu.com/p/95244902

C 库函数 - malloc() https://www.runoob.com/cprogramming/c-function-malloc.html
```c
// https://paiza.io/en/projects/new?language=c
----------------------------------------------------------------------------------------------------
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
 
int main()
{
   char *str;
 
   /* 最初的内存分配 */
   str = (char *) malloc(15);
   strcpy(str, "runoob");
   printf("String = %s,  Address = %u\n", str, str);
 
   /* 重新分配内存 */
   str = (char *) realloc(str, 25);
   strcat(str, ".com");
   printf("String = %s,  Address = %u\n", str, str);
 
   free(str);
 
   return(0);
}
----------------------------------------------------------------------------------------------------
// 运行结果：
String = runoob,  Address = 18444896
String = runoob.com,  Address = 18449040
```

## C长跳转

C语言的异常机制 setjump longjump函数
http://blog.csdn.net/wanglang3081/article/details/18664919

C语言中的异常处理机制
http://blog.csdn.net/tian_dao_chou_qin/article/details/6386621

linux C 长跳转setjmp/longjump以及sigsetjump/siglongjump
http://www.cppblog.com/cxf20090520biancheng/archive/2012/05/14/174833.html


## C报错信息解决

### crosses initialization of ...

- http://blog.csdn.net/zzwdkxx/article/details/27561393
- https://stackoverflow.com/questions/12992108/crosses-initialization-of-variable-only-when-initialization-combined-with-decl

# C其他

C技巧：结构体参数转成不定参数 https://blog.csdn.net/haoel/article/details/6212499

# C高级技巧

C 语言有什么奇技淫巧？ - 知乎 https://www.zhihu.com/question/27417946
- C 语言有什么奇技淫巧？ - 九夏的回答 - 知乎 https://www.zhihu.com/question/27417946/answer/36651800
- C 语言有什么奇技淫巧？ - 韦易笑的回答 - 知乎 https://www.zhihu.com/question/27417946/answer/1253126563

动态修改 C 语言函数的实现 https://draveness.me/fishhook
