
# 迭代器

Python | next() method https://www.geeksforgeeks.org/python-next-method/

python黑魔法---迭代器（iterator） https://www.jianshu.com/p/dcf83643deeb

# Lambda表达式

【~~How to Use Python Lambda Functions https://realpython.com/python-lambda/~~ 已转移】

Python lambda (Anonymous Functions) | filter, map, reduce https://www.geeksforgeeks.org/python-lambda-anonymous-functions-filter-map-reduce/

Lambda, filter, reduce and map https://www.python-course.eu/lambda.php
- > Some like it, others hate it and many are afraid of the lambda operator. We are confident that you will like it, when you have finished with this chapter of our tutorial. If not, you can learn all about "[List Comprehensions](https://www.python-course.eu/list_comprehension.php)", Guido van Rossums preferred way to do it, because he doesn't like Lambda, map, filter and reduce either.
- > The general syntax of a lambda function is quite simple: `lambda argument_list: expression`. The argument list consists of a comma separated list of arguments and the expression is an arithmetic expression using these arguments. You can assign the function to a variable to give it a name. The following example of a lambda function returns the sum of its two arguments:
  ```py
  >>> f = lambda x, y : x + y
  >>> f(1,1)
  2
  ```
- > The map() Function

Python学习笔记（十二）：lambda表达式与函数式编程 https://blog.csdn.net/mathboylinlin/article/details/9413551
> python by mathboylinlin的专栏 https://blog.csdn.net/mathboylinlin/article/category/1505225

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# nonlocal关键字

python关键字nonlocal和global的区别 https://www.jianshu.com/p/ab69b83a8d8a

Python nonlocal statement https://stackoverflow.com/questions/1261875/python-nonlocal-statement
- > Compare this, without using `nonlocal`:
  ```py
  x = 0
  def outer():
      x = 1
      def inner():
          x = 2
          print("inner:", x)

      inner()
      print("outer:", x)

  outer()
  print("global:", x)

  # inner: 2
  # outer: 1
  # global: 0
  ```
- > To this, using `nonlocal`, where `inner()`'s `x` is now also `outer()`'s `x`:
  ```py
  x = 0
  def outer():
      x = 1
      def inner():
          nonlocal x
          x = 2
          print("inner:", x)

      inner()
      print("outer:", x)

  outer()
  print("global:", x)

  # inner: 2
  # outer: 2
  # global: 0
  ```
- > If we were to use `global`, it would bind `x` to the properly "global" value:
  ```py
  x = 0
  def outer():
      x = 1
      def inner():
          global x
          x = 2
          print("inner:", x)

      inner()
      print("outer:", x)

  outer()
  print("global:", x)

  # inner: 2
  # outer: 1
  # global: 2
  ```

# `@`装饰器

`7. Decorators` https://book.pythontips.com/en/latest/decorators.html || https://github.com/yasoob/intermediatePython/blob/master/decorators.rst

Python 函数装饰器 https://www.runoob.com/w3cnote/python-func-decorators.html

12步教你理解Python装饰器 https://foofish.net/python-decorator-12.html

python @property的用法及含义全面解析 https://www.jb51.net/article/134148.htm

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
