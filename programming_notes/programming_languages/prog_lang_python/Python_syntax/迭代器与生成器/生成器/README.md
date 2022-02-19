
# 生成器

Python生成器详解 http://c.biancheng.net/view/2393.html
- > 前面章节中，已经详细介绍了什么是迭代器。***生成器本质上也是迭代器，不过它比较特殊***。
- > 以 `list` 容器为例，在使用该容器迭代一组数据时，必须事先将所有数据存储到容器中，才能开始迭代；而生成器却不同，它可以实现在迭代的同时生成元素。
- > 不仅如此，生成器的创建方式也比迭代器简单很多，大体分为以下 2 步：
  * > 1.定义一个以 `yield` 关键字标识返回值的函数；
  * > 2.调用刚刚创建的函数，即可创建一个生成器。
  ```py
  def intNum():
      print("开始执行")
      for i in range(5):
          yield i
          print("继续执行")
  num = intNum()
  ```
- > 和 `return` 相比，`yield` 除了可以返回相应的值，还有一个更重要的功能，***即每当程序执行完该语句时，程序就会暂停执行***。不仅如此，即便调用生成器函数，Python 解释器也不会执行函数中的代码，它只会返回一个生成器（对象）。
- > 要想使生成器函数得以执行，或者想使执行完 `yield` 语句立即暂停的程序得以继续执行，有以下 2 种方式：
  * > 通过生成器（上面程序中的 num）调用 `next()` 内置函数或者 `__next__()` 方法；
  * > 通过 `for` 循环遍历生成器。
- > 例如，在上面程序的基础上，添加如下语句：
  ```py
  #调用 next() 内置函数
  print(next(num))
  #调用 __next__() 方法
  print(num.__next__())
  #通过for循环遍历生成器
  for i in num:
      print(i)
  ```
  > 程序执行结果为：
  ```console
  开始执行
  0
  继续执行
  1
  继续执行
  2
  继续执行
  3
  继续执行
  4
  继续执行
  ```
- > 这里有必要给读者分析一个程序的执行流程：
  * > 1) 首先，在创建有 num 生成器的前提下，通过其调用 `next()` 内置函数，会使 Python 解释器开始执行 intNum() 生成器函数中的代码，因此会输出“开始执行”，程序会一直执行到 `yield i`，而此时的 i==0，因此 Python 解释器输出“0”。由于受到 `yield` 的影响，程序会在此处暂停。
  * > 2) 然后，我们使用 num 生成器调用 `__next__()` 方法，该方法的作用和 `next()` 函数完全相同（事实上，`next()` 函数的底层执行的也是 `__next__()` 方法），它会是程序继续执行，即输出“继续执行”，程序又会执行到 `yield i`，此时 i==1，因此输出“1”，然后程序暂停。
  * > 3) 最后，我们使用 `for` 循环遍历 num 生成器，之所以能这么做，是因为 `for` 循环底层会不断地调用 `next()` 函数，使暂停的程序继续执行，因此会输出后续的结果。
  * > 注意，在 Python 2.x 版本中不能使用 `__next__()` 方法，可以使用 `next()` 内置函数，另外生成器还有 `next()` 方法（即以 `num.next()` 的方式调用）。
- > 除此之外，还可以使用 `list()` 函数和 `tuple()` 函数，直接将生成器能生成的所有值存储成列表或者元组的形式。例如：
  ```py
  num = intNum()
  print(list(num))
  num = intNum()
  print(tuple(num))
  ```
  > 程序执行结果为：
  ```console
  开始执行
  继续执行
  继续执行
  继续执行
  继续执行
  继续执行
  [0, 1, 2, 3, 4]
  开始执行
  继续执行
  继续执行
  继续执行
  继续执行
  继续执行
  (0, 1, 2, 3, 4)
  ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `.send()`

What's the purpose of "send" function on Python generators? https://stackoverflow.com/questions/19302530/whats-the-purpose-of-send-function-on-python-generators
- https://stackoverflow.com/questions/19302530/whats-the-purpose-of-send-function-on-python-generators/19302694#19302694
  * > It's used to send values into a generator that just yielded. Here is an artificial (non-useful) explanatory example:
    ```py
    >>> def double_inputs():
    ...     while True:
    ...         x = yield
    ...         yield x * 2
    ...
    >>> gen = double_inputs()
    >>> next(gen)       # run up to the first yield
    >>> gen.send(10)    # goes into 'x' variable
    20
    >>> next(gen)       # run up to the next yield
    >>> gen.send(6)     # goes into 'x' again
    12
    >>> next(gen)       # run up to the next yield
    >>> gen.send(94.3)  # goes into 'x' again
    188.5999999999999
    ```
    You can't do this just with `yield`.

Python生成器（send，close，throw）方法详解 http://c.biancheng.net/view/7090.html
- > 我们知道，通过调用 `next()` 或者 `__next__()` 方法，可以实现从外界控制生成器的执行。除此之外，***通过 `send()` 方法，还可以向生成器中传值***。
- > 值得一提的是，`send()` 方法可带一个参数，也可以不带任何参数（用 `None` 表示）。其中，当使用不带参数的 `send()` 方法时，它和 `next()` 函数的功能完全相同。例如：
  ```py
  def intNum():
      print("开始执行")
      for i in range(5):
          yield i
          print("继续执行")
  num = intNum()
  print(num.send(None))
  print(num.send(None))
  ```
  > 程序执行结果为：
  ```console
  开始执行
  0
  继续执行
  1
  ```
  > 注意，虽然 `send(None)` 的功能是 `next()` 完全相同，但更推荐使用 `next()`，不推荐使用 `send(None)`。
- > 这里重点讲解一些带参数的 `send(value)` 的用法，其具备 `next()` 函数的部分功能，即将暂停在 `yield` 语句出的程序继续执行，但与此同时，该函数还会将 `value 值`作为 `yield` 语句返回值赋值给接收者。
  >
  > 注意，带参数的 `send(value)` 无法启动执行生成器函数。也就是说，程序中第一次使用生成器调用 `next()` 或者 `send()` 函数时，不能使用带参数的 `send()` 函数。
  ```py
  def foo():
      bar_a = yield "hello"
      bar_b = yield bar_a
      yield bar_b
  f = foo()
  print(f.send(None))
  print(f.send("C语言中文网"))
  print(f.send("http://c.biancheng.net"))
  ```
- > 分析一下此程序的执行流程：
  * > 1) 首先，构建生成器函数，并利用器创建生成器（对象）`f` 。
  * > 2) 使用生成器 `f` 调用无参的 `send()` 函数，其功能和 `next()` 函数完全相同，因此开始执行生成器函数，即执行到第一个 `yield "hello"` 语句，该语句会返回 `"hello"` 字符串，然后程序停止到此处（注意，***此时还未执行对 `bar_a` 的赋值操作***）。
  * > 3) 下面开始使用生成器 `f` 调用有参的 `send()` 函数，首先它会将暂停的程序开启，同时还会将其参数`“C语言中文网”`赋值给当前 `yield` 语句的接收者，也就是 `bar_a` 变量。程序一直执行完 `yield bar_a` 再次暂停，因此会输出`“C语言中文网”`。
  * > 4) 最后依旧是调用有参的 `send()` 函数，同样它会启动暂停的程序，同时将参数`“http://c.biancheng.net”`传给 `bar_b`，然后执行完 `yield bar_b` 后（输出 `http://c.biancheng.net`），程序执行再次暂停。
  > 因此，该程序的执行结果为：
  ```console
  hello
  C语言中文网
  http://c.biancheng.net
  ```
- > **Python生成器 `close()` 方法**
- > **Python生成器 `throw()` 方法**

Python生成器及send用法讲解 https://www.cnblogs.com/nymrli/p/9416949.html

python 生成器 send()方法简介 https://www.jianshu.com/p/6c33bd958f3d

Python生成器next方法和send方法区别 https://segmentfault.com/a/1190000016880292

Python生成器中的send()与next()方法解析 https://blog.csdn.net/qq_39521554/article/details/79864889

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
