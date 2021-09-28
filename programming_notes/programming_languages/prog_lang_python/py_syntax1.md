
# 迭代器

Python | next() method https://www.geeksforgeeks.org/python-next-method/

python黑魔法---迭代器（iterator） https://www.jianshu.com/p/dcf83643deeb

如何更好地理解Python迭代器和生成器？ - 知乎 https://www.zhihu.com/question/20829330
- 如何更好地理解Python迭代器和生成器？ - 赖明星的回答 - 知乎 https://www.zhihu.com/question/20829330/answer/133606850
  * > 因此，生成器的唯一注意事项就是：**生成器只能遍历一次**。
- 如何更好地理解Python迭代器和生成器？ - 刘志军的回答 - 知乎 https://www.zhihu.com/question/20829330/answer/213544776
- 如何更好地理解Python迭代器和生成器？ - Stranger的回答 - 知乎 https://www.zhihu.com/question/20829330/answer/329771447
  * > from: [Iterables vs. Iterators vs. Generators](https://nvie.com/posts/iterators-vs-generators/)
    + > ![](https://pic4.zhimg.com/80/v2-95b4076d30e55da078045cdade28cea3_1440w.jpg)

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# yield

What does the “yield” keyword do? https://stackoverflow.com/questions/231767/what-does-the-yield-keyword-do

Python中yield和yield from的用法 https://www.cnblogs.com/cnkai/p/7514828.html

Python | yield Keyword https://www.geeksforgeeks.org/python-yield-keyword/

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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

## 函数参数中 `*` 和 `**`

Python函数中`*`和`**`的内涵究竟是什么呢？ - 知乎 https://www.zhihu.com/question/265519629
- `Python函数中*和**的内涵究竟是什么呢？` - 按部就班的回答 - 知乎 https://www.zhihu.com/question/265519629/answer/295435756
- `Python函数中*和**的内涵究竟是什么呢？` - 留德华叫兽的回答 - 知乎 https://www.zhihu.com/question/265519629/answer/509771174

`Python 函数参数前面一个星号（*）和两个星号（**）的区别` https://www.runoob.com/w3cnote/python-one-and-two-star.html

Python `*args` and `**kwargs` https://www.programiz.com/python-programming/args-and-kwargs

`*args` and `**kwargs` in Python https://www.geeksforgeeks.org/args-kwargs-python/

`1. *args and **kwargs` https://book.pythontips.com/en/latest/args_and_kwargs.html

## `setup.py` 相关

`4. 构建C/C++扩展` https://docs.python.org/zh-cn/3/extending/building.html

花了两天，终于把 Python 的 setup.py 给整明白了 - 王炳明的文章 - 知乎 https://zhuanlan.zhihu.com/p/276461821
