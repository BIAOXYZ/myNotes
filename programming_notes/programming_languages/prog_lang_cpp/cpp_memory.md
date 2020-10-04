
细说new与malloc的10点区别 https://www.cnblogs.com/qg-whz/p/5140930.html || https://cloud.tencent.com/developer/article/1155150

C语言编程基础-malloc和new https://blog.csdn.net/baidu_35692628/article/details/69817723
- > 如果在函数里定义了一个指针变量，然后在这个函数里申请了一块内存让指针指向它。实际上，这个指针的地址是在栈上，但是它所指向的内容却是在堆上面的。 <br> 注意：函数所在的**栈**被销毁**指针**也跟着销毁，但申请的**内存**并没有一样跟着销毁！因为申请的内存在堆上，而函数所在的栈被销毁跟堆完全没有关系。所以一定记得释放free！

C/C++中的malloc、calloc和realloc https://segmentfault.com/a/1190000017816285?utm_source=sf-related

C语言内存泄露很严重，如何应对？ https://juejin.im/post/6867355456839843847
