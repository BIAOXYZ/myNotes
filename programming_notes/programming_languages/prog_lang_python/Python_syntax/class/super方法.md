
# `.super()` 官方

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `.super()` 使用

8.7 调用父类方法 https://python3-cookbook.readthedocs.io/zh_CN/latest/c08/p07_calling_method_on_parent_class.html
- > 为了调用父类(超类)的一个方法，可以使用 `super()` 函数，比如：
  ```py
  class A:
      def spam(self):
          print('A.spam')
  class B(A):
      def spam(self):
          print('B.spam')
          super().spam()  # Call parent spam()
  ```
- > `super()` 函数的一个常见用法是在 `__init__()` 方法中确保父类被正确的初始化了：
  ```py
  class A:
      def __init__(self):
          self.x = 0
  class B(A):
      def __init__(self):
          super().__init__()
          self.y = 1
  ```
- > `super()` 的另外一个常见用法出现在覆盖Python特殊方法的代码中，比如：
  ```py
  class Proxy:
      def __init__(self, obj):
          self._obj = obj
  
      # Delegate attribute lookup to internal obj
      def __getattr__(self, name):
          return getattr(self._obj, name)
  
      # Delegate attribute assignment
      def __setattr__(self, name, value):
          if name.startswith('_'):
              super().__setattr__(name, value) # Call original __setattr__
          else:
              setattr(self._obj, name, value)
  ```
  > 在上面代码中，`__setattr__()` 的实现包含一个名字检查。 如果某个属性名以下划线(`_`)开头，就通过 `super()` 调用原始的 `__setattr__()` ， 否则的话就委派给内部的代理对象 `self._obj` 去处理。这看上去有点意思，因为就算没有显式的指明某个类的父类， `super()` 仍然可以有效的工作。
- > **讨论**：实际上，大家对于在Python中如何正确使用 `super()` 函数普遍知之甚少。 你有时候会看到像下面这样直接调用父类的一个方法：
  ```py
  class Base:
    def __init__(self):
        print('Base.__init__')
  class A(Base):
    def __init__(self):
        Base.__init__(self)
        print('A.__init__')
  ```
- > 尽管对于大部分代码而言这么做没什么问题，但是在更复杂的涉及到多继承的代码中就有可能导致很奇怪的问题发生。 比如，考虑如下的情况：
- > 为了弄清它的原理，我们需要花点时间解释下Python是如何实现继承的。 对于你定义的每一个类，Python会计算出一个所谓的`方法解析顺序(MRO)列表`。 这个MRO列表就是一个简单的所有基类的线性顺序表。例如：
  ```py
  >>> C.__mro__
  (<class '__main__.C'>, <class '__main__.A'>, <class '__main__.B'>,
  <class '__main__.Base'>, <class 'object'>)
  >>>
  ```

Python super() 函数 https://www.runoob.com/python/python-func-super.html
- > Python3.x 和 Python2.x 的一个区别是: Python 3 可以使用直接使用 `super().xxx` 代替 `super(Class, self).xxx` :
- > **Python3.x 实例**：
  ```py
  class A:
       def add(self, x):
           y = x+1
           print(y)
  class B(A):
      def add(self, x):
          super().add(x)
  b = B()
  b.add(2)  # 3
  ```
- > **Python2.x 实例**：
  ```py
  #!/usr/bin/python
  # -*- coding: UTF-8 -*-
     
  class A(object):   # Python2.x 记得继承 object
      def add(self, x):
           y = x+1
           print(y)
  class B(A):
      def add(self, x):
          super(B, self).add(x)
  b = B()
  b.add(2)  # 3
  ```

What is super() in Python? https://www.educative.io/edpresso/what-is-super-in-python


