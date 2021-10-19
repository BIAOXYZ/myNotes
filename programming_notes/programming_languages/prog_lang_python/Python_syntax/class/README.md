
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

【[:star:][`*`]】 python的类变量和成员变量 https://blog.csdn.net/lc_910927/article/details/38757363
- 个人实战代码片段1:
  * `val1` -- `类变量`
  * `val2` -- 在 `__init__()` 函数里的 `(类)成员变量`
  * `val4`，`val5` -- 不在 `__init__()` 函数里的 `(类)成员变量`
  * `val3` -- `(类内)局部变量`
```py
class TestClass(object):
    val1 = 100
    
    def __init__(self):
        self.val2 = 200
    
    def fcn(self,val = 400):
        val3 = 300
        self.val4 = val
        self.val5 = 500 

inst = TestClass()

print TestClass.val1
print inst.val1
print inst.val2
print inst.val3
print inst.val4    
print inst.val5
##################################################
100
100
200
Traceback (most recent call last):
  File "main.py", line 19, in <module>
    print inst.val3
AttributeError: 'TestClass' object has no attribute 'val3'
```
- 个人实战代码片段2:
  * 【[:star:][`*`]】 //notes：`val3` 是个（类内的）`局部变量`，它就不可能被类外访问到。但是 `val4` 和 `val5` 同样是`类成员变量`，它俩和 `val2` 的唯一不同就是：人家 `val2` 是 `__init__` 管的，只要有类实例就能直接用；但是**它俩必须所在的函数被调用了才能用**。
```py
class TestClass(object):
    val1 = 100
    
    def __init__(self):
        self.val2 = 200
    
    def fcn(self,val = 400):
        val3 = 300
        self.val4 = val
        self.val5 = 500 

inst = TestClass()

print TestClass.val1
print inst.val1
print inst.val2

inst.fcn(10000)

#print inst.val3
print inst.val4    
print inst.val5
##################################################
100
100
200
10000
500
```
- 个人实战代码片段3:
  * 如果要修改`类变量`的值，一定要用 `类名.类变量名` 的形式去改，而不要用 `类实例.类变量名` 的形式去修改。后者只是改了自己的副本里的`类变量`的值，无法同步到其他类实例上。
  * 原文里是这么说的：
    + > `可以发现：python的类变量和C++的静态变量不同，区别在于python的对象使用类变量时，会进行一次内存拷贝。python中，类本身拥有自己的类变量（保存在内存），当对象第一次调用类变量时，会将当前类变量拷贝一份给这个对象，当前类变量的值是多少，这个对象拷贝得到的类变量的值就是多少；而且，通过对象来修改类变量，并不会影响其他对象的类变量的值，因为大家都有各自的副本，更不会影响类本身所拥有的那个类变量的值；只有类自己才能改变类本身拥有的类变量的值。`
    + > `有一点值得注意：对象的类变量是什么时候初始化的（从类的类变量拷贝过来）？通过上例中inst2.val1的打印结果是2000可以发现，对象的类变量并不是构造对象的时候初始化的，而是在第一次通过对象调用该类变量的时候从类变量当前的值拷贝过来的。此后便互不影响。`
```py
class TestClass(object):
    val1 = 100
    
    def __init__(self):
        self.val2 = 200
    
    def fcn(self,val = 400):
        val3 = 300
        self.val4 = val
        self.val5 = 500 
 
inst1 = TestClass()
inst2 = TestClass()

print TestClass.val1 # 100
print inst1.val1     # 100

inst1.val1 = 1000    
print inst1.val1     # 1000
print TestClass.val1 # 100

TestClass.val1 = 2000 
print inst1.val1     # 1000
print TestClass.val1 # 2000
print inst2.val1     # 2000     

inst3 = TestClass()  
print inst3.val1     # 2000
##################################################
100
100
1000
100
1000
2000
2000
2000
```

【[:star:][`*`]】 Python类变量、实例（成员）变量和局部变量 https://blog.csdn.net/Strive_0902/article/details/105325065

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
  * > 对于静态方法，Python 并不需要传递类或者实例，因此，既可以使用类也可以使用实例来调用静态方法。
- > **实例方法，类方法与静态方法的区别**
  * > 对于实例方法，调用时会把 `实例ik` 作为第一个参数传递给 `self` 参数。因此，调用 `ik.foo(1)` 时输出了 `实例ik` 的地址。
  * > 对于类方法，调用时会把 `类Kls` 作为第一个参数传递给 `cls` 参数。因此，调用 `ik.class_foo(1)` 时输出了 `Kls` 类型信息。前面提到，可以通过类也可以通过实例来调用类方法，在上述代码中，我们再一次进行了验证。
  * > 对于静态方法，调用时并不需要传递类或者实例。其实，静态方法很像我们在类外定义的函数，只不过静态方法可以通过类或者实例来调用而已。
  * > 概括来说，是否与类或者实例进行绑定，这就是实例方法，类方法，静态方法的区别。

【[:star:][`*`]】 python的普通方法、类方法和静态方法 https://blog.csdn.net/zjuPeco/article/details/78006661

【[:star:][`*`]】 正确理解Python中的 @staticmethod@classmethod方法 - 刘志军的文章 - 知乎 https://zhuanlan.zhihu.com/p/28010894

Python: classmethod类函数 & staticmethod静态函数 区别 http://blog.csdn.net/bytxl/article/details/46928837

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

Python父类方法重写（入门必读） http://c.biancheng.net/view/2289.html
