
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

Python super() 函数 https://www.runoob.com/python/python-func-super.html
