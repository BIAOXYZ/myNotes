
# 文章

C++：如何正确的定义一个接口类 https://blog.csdn.net/netyeaxi/article/details/80724557
C++：如何正确的使用接口类 https://blog.csdn.net/netyeaxi/article/details/80887646

# 问题

## `undefined reference to 'vtable for xxx'`
>> 【[:star:][`*`]】 //notes：在实现抽象接口类的时候碰到这个问题，其核心是即使用 `virtual` 关键字修饰了抽象类的方法，也不能只有声明，而是要实现一下，也就是一定要有大括号括起来的函数体。至于函数体里的内容，一个 `return 0;` 就可以，甚至留空都可以。具体参考下面几个回答就知道了。

C++ Undefined Reference to vtable and inheritance https://stackoverflow.com/questions/9406580/c-undefined-reference-to-vtable-and-inheritance
- https://stackoverflow.com/questions/9406580/c-undefined-reference-to-vtable-and-inheritance/9406606#9406606
  * > You need to provide definitions for all virtual functions in `class A`. Only ***pure virtual functions*** are allowed to have no definitions.
  * > i.e: In `class A` both the methods:
    ```cpp
    virtual ~A();
    virtual void doWork();
    ```
  * > should be defined(should have a body)
    ```cpp
    void A::doWork()
    {
    }
    A::~A()
    {
    }
    ```
  * > **Caveat**: If you want your `class A` to act as an interface (a.k.a [Abstract class](https://en.wikibooks.org/wiki/C%2B%2B_Programming/Classes/Abstract_Classes) in C++) then you should make the method pure virtual.
    ```cpp
    virtual void doWork() = 0;
    ```
  * > **Good Read**:
    + > What does it mean that the “virtual table” is an unresolved external? https://isocpp.org/wiki/faq/strange-inheritance#link-errs-missing-vtable
    + > When building C++, the linker says my constructors, destructors or virtual tables are undefined, but I defined them http://gcc.gnu.org/faq.html#vtables

undefined reference to vtable with all virtual functions implemented https://stackoverflow.com/questions/27163339/undefined-reference-to-vtable-with-all-virtual-functions-implemented

Virtual functions (undefined reference for vtable ) https://cplusplus.com/forum/general/74973/
