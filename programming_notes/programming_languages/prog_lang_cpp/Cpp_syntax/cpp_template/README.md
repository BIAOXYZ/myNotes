
# 官方

模板 (C++) https://zh.wikipedia.org/wiki/%E6%A8%A1%E6%9D%BF_(C%2B%2B)

模板 (C++) https://docs.microsoft.com/zh-cn/cpp/cpp/templates-cpp

Templates https://en.cppreference.com/w/cpp/language/templates

Templates https://cplusplus.com/doc/oldtutorial/templates/

# 系统性攻略

# 问题

Why can templates only be implemented in the header file? https://stackoverflow.com/questions/495021/why-can-templates-only-be-implemented-in-the-header-file

C++: 模板函数定义与声明分离； https://www.shuzhiduo.com/A/E35pgjogJv/ || https://www.cnblogs.com/yinwei-space/p/10609049.html

# 其他攻略

【from Programiz】:
- C++ Function Template https://www.programiz.com/cpp-programming/function-template
- C++ Class Templates https://www.programiz.com/cpp-programming/class-templates

C++ 模板详解 https://www.runoob.com/w3cnote/c-templates-detail.html

C++类模板，你看我就够了 https://www.jianshu.com/p/70ca94872418

C++ Template 基础篇（一）：函数模板 https://blog.csdn.net/lezardfu/article/details/56852043

C++ 模板常见特性（函数模板、类模板） - 小林coding的文章 - 知乎 https://zhuanlan.zhihu.com/p/101898043 || https://juejin.cn/post/6844904041328148493

[C++ Template]基础--非类型模板参数 https://blog.csdn.net/u012481976/article/details/84131867
- > **4.3 非类型模板参数的限制**
  * > 非类型模板参数是有限制的。通常而言，它们可以是常整数（包括枚举值）或者指向外部链接对象的指针。浮点数和类对象是不允许作为非类型模板参数的。
    ```cpp
    template<double VAT> //ERROR:浮点数不能作为非类型模板参数
    double process(double v)
    {
    	return v * VAT;
    } 
     
    template<std::string name> //ERROR:类对象不能作为非类型模板参数
    class MyClass 
    {
    	...
    };
    ```
  * > 由于字符串文字是内部链接对象（因为两个具有相同名称但处于不同模块的字符串，是两个完全不同的对象），所以你不能使用它们来作为模板实参：
    ```cpp
    template<char const* name>
    class MyClass 
    {
    };
    MyClass<"hello"> x; //ERROR:不允许使用字符串文字"hello"
    ```
  * > 另外， 你也不能使用全局指针作为模板参数：
    ```cpp
    template <char const* name>
    class MyClass 
    {
    };
    char const* s = "hello";
    MyClass<s> x; //s是一个指向内部链接对象的指针
    ```
    > 然而，你可以这样使用：
    ```cpp
    template <char const* name>
    class MyClass 
    {
    };
    extern char const s[] = "hello";
    MyClass<s> x; //OK
    ```
    > 全局字符串数组s由"hello"初始化，是一个外部连接对象。
    >> TODO：所以这里主要是因为 extern 的原因，而不是数组和指针的差别的原因吧。。。
