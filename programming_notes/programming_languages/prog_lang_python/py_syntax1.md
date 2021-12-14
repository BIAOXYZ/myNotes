
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

## 像C/C++一样只是 `int a;`，但不给 `a` 赋初始值
>> //notes：没想到的时候觉得不知道怎么办（因为python里直接写个变量名不行），但是一旦看到了就立刻明白了。。。其实就是 `a = None` 即可。

Is it possible only to declare a variable without assigning any value in Python? https://stackoverflow.com/questions/664294/is-it-possible-only-to-declare-a-variable-without-assigning-any-value-in-python
- https://stackoverflow.com/questions/664294/is-it-possible-only-to-declare-a-variable-without-assigning-any-value-in-python/664297#664297
  * > Why not just do this:
    ```py
    var = None
    ```
  * > Python is dynamic, so you don't need to declare things; they exist automatically in the first scope where they're assigned. So, all you need is a regular old assignment statement as above.
  * > This is nice, because you'll never end up with an uninitialized variable. But be careful -- this doesn't mean that you won't end up with incorrectly initialized variables. If you init something to None, make sure that's what you really want, and assign something more meaningful if you can.
