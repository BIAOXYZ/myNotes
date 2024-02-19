
使用__slots__ https://www.liaoxuefeng.com/wiki/1016959663602400/1017501655757856

`10. __slots__ Magic` https://book.pythontips.com/en/latest/__slots__magic.html

Python - __slots__属性详解 https://www.jianshu.com/p/9e17a03d08b1
- > **简介**
  * > ***`__slots__`允许我们声明并限定类成员，并拒绝类创建`__dict__`和`__weakref__`属性以节约内存空间***。
  * > 可以看到，在定义了`__slots__`变量后，Student类实例已经不能随意创建不在`__slots__`定义内的属性gender，同时实例中也不再有`__dict__`结构。
- > **继承树**
  * > `__slots__`在继承中有两种表现：
    + > 子类未声明`__slots__`时，不继承父类的`__slots__`，***即此时子类实例可以随意赋值属性***
    + > 子类声明`__slots__`时，继承父类的`__slots__`，***即此时子类的`__slots__`为其自身+父类的`__slots__`***
