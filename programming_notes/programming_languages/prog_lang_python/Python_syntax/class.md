
# 函数和类的嵌套

## nested function

python中def中def是如何实现的？ - 知乎 https://www.zhihu.com/question/265664528

Python 嵌套函数和闭包 https://www.cnblogs.com/love9527/p/9022316.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## nested/inner class

Inner Classes in Python https://www.datacamp.com/community/tutorials/inner-classes-python

Python – Access Parent Class Attribute https://www.geeksforgeeks.org/python-access-parent-class-attribute/

How to access outer class from an inner class? https://stackoverflow.com/questions/2024566/how-to-access-outer-class-from-an-inner-class

python class嵌套怎么访问父类 https://segmentfault.com/q/1010000009317669

Inheritance in Python Inner Class https://www.geeksforgeeks.org/inheritance-in-python-inner-class/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 类成员变量与类变量

Python类变量与成员变量 https://blog.csdn.net/u013940664/article/details/53731234

python中类变量与成员变量的使用注意点总结 https://www.jb51.net/article/112525.htm

Python-类变量，成员变量，静态变量，类方法，静态方法，实例方法，普通函数 https://www.cnblogs.com/20150705-yilushangyouni-Jacksu/p/6238187.html

Python类的成员 https://www.cnblogs.com/wangyueping/archive/2019/06/30/11108437.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 类的三种方法

【[:star:][`*`]】 Python 实例方法、类方法和静态方法 https://blog.csdn.net/lihao21/article/details/79762681
- > **实例方法**
  * > 上述例子中，`printd` 为一个实例方法。实例方法第一个参数为 `self`，当使用 `ik1.printd()` 调用实例方法时，实例 `ik1` 会传递给 `self` 参数，这样 `self` 参数就可以引用当前正在调用实例方法的实例。利用实例方法的这个特性，上述代码正确输出了两个实例的成员数据。
- > **类方法**
  * > Python 的类方法采用装饰器 `@classmethod` 来定义，我们直接看例子。
  * > 在上述例子中，我们需要统计 `类Kls` 实例的个数，因此定义了一个 `类变量num_inst` 来存放实例个数。通过装饰器 `@classmethod` 的使用，方法 `get_no_of_instance` 被定义成一个类方法。在调用类方法时，Python 会将类（`class Kls`）传递给 `cls`，这样在 `get_no_of_instance` 内部就可以引用 `类变量num_inst`。
  * > 由于在调用类方法时，只需要将类型本身传递给类方法，因此，既可以通过类也可以通过实例来调用类方法。
- > **静态方法**
  * > 在开发中，我们常常需要定义一些方法，***<ins>这些方法跟类有关，但在实现时并不需要引用类或者实例</ins>***，例如，设置环境变量，修改另一个类的变量，等。这个时候，我们可以使用静态方法。Python 使用装饰器 `@staticmethod` 来定义一个静态方法。

【[:star:][`*`]】 python的普通方法、类方法和静态方法 https://blog.csdn.net/zjuPeco/article/details/78006661

【[:star:][`*`]】 正确理解Python中的 @staticmethod@classmethod方法 - 刘志军的文章 - 知乎 https://zhuanlan.zhihu.com/p/28010894

Python: classmethod类函数 & staticmethod静态函数 区别 http://blog.csdn.net/bytxl/article/details/46928837

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
