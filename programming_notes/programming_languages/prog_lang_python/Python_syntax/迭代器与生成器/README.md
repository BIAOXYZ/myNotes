
# yield

【[:ok:][:star:][`*`]】 python中yield的用法详解——最简单，最清晰的解释 https://blog.csdn.net/mieleizhi0522/article/details/82142856
- > 首先我要吐槽一下，看程序的过程中遇见了 `yield` 这个关键字，然后百度的时候，发现没有一个能简单的让我懂的，讲起来真TM的都是头头是道，什么参数，什么传递的，还口口声声说自己的教程是最简单的，最浅显易懂的，我就想问没有有考虑过读者的感受。
- > 首先，如果你还没有对 `yield` 有个初步分认识，***<ins>那么你先把 `yield` 看做“`return`”</ins>***，这个是直观的，它首先是个 `return`，普通的 `return` 是什么意思，就是在程序中返回某个值，返回之后程序就不再往下运行了。***看做 `return` 之后再把它看做一个是生成器（generator）的一部分***（带 `yield` 的函数才是真正的迭代器），好了，如果你对这些不明白的话，那先把 `yield` 看做 `return`, 然后直接看下面的程序，你就会明白 `yield` 的全部意思了：
  ```py
  def foo():
      print("starting...")
      while True:
          res = yield 4
          print("res:",res)
  g = foo()
  print(next(g))
  print("*"*20)
  print(next(g))
  ```
- > 就这么简单的几行代码就让你明白什么是 `yield`，代码的输出这个：
  ```console
  starting...
  4
  ********************
  res: None
  4
  ```
- > **我直接解释代码运行顺序，相当于代码单步调试**：
  * > 1.程序开始执行以后，因为foo函数中有 `yield` 关键字，***<ins>所以foo函数并不会真的执行，而是先得到一个生成器g(相当于一个对象)</ins>***。
  * > 2.***直到调用 `next` 方法，foo函数正式开始执行***，先执行foo函数中的print方法，然后进入while循环。
  * > 3.程序遇到 `yield` 关键字，然后把 `yield`想想成 `return`, `return`了一个 `4` 之后，程序停止，**<ins>并没有执行赋值给res操作</ins>**，此时 `next(g)` 语句执行完成，***所以输出的前两行（<ins>第一个是while上面的print的结果,第二个是return出的结果</ins>）是执行 `print(next(g))` 的结果***。
  * > 4.程序执行 `print("*"*20)`，输出20个`*`。
  * > 5.又开始执行下面的 `print(next(g))`, 这个时候和上面那个差不多，不过不同的是，**这个时候是从刚才那个 `next` 程序停止的地方开始执行的，也就是要执行res的赋值操作**，这时候要注意，***这个时候赋值操作的右边是没有值的（<ins>因为刚才那个是 `return` 出去了，并没有给赋值操作的左边传参数</ins>）***，所以这个时候res赋值是 `None`, 所以接着下面的输出就是 `res: None`。
  * > 6.程序会继续在while里执行，又一次碰到 `yield`, 这个时候同样 `return` 出 `4`，然后程序停止，print函数输出的 `4` 就是这次 `return` 出的 `4`。
- > **到这里你可能就明白 `yield` 和 `return` 的关系和区别了，带 `yield` 的函数是一个生成器，而不是一个函数了，这个生成器有一个函数就是 `next` 函数，`next` 就相当于“下一步”生成哪个数，<ins>这一次的 `next` 开始的地方是接着上一次的 `next` 停止的地方执行的，所以调用 `next` 的时候，生成器并不会从foo函数的开始执行，只是接着上一步停止的地方开始</ins>，然后遇到 `yield` 后，`return` 出要生成的数，此步就结束**。
- > 再看一个这个生成器的 `send` 函数的例子，这个例子就把上面那个例子的最后一行换掉了，输出结果：
  ```py
  def foo():
      print("starting...")
      while True:
          res = yield 4
          print("res:",res)
  g = foo()
  print(next(g))
  print("*"*20)
  print(g.send(7))
  ```
  ```console
  starting...
  4
  ********************
  res: 7
  4
  ```
- > 先大致说一下 `send` 函数的概念：此时你应该注意到上面那个的紫色的字，还有上面那个res的值为什么是 `None`，这个变成了 `7`，到底为什么？这是因为，`send` 是发送一个参数给res的，因为上面讲到，`return` 的时候，并没有把 `4` 赋值给res，下次执行的时候只好继续执行赋值操作，只好赋值为 `None` 了，而如果用 `send` 的话，开始执行的时候，先接着上一次（`return 4`之后）执行，先把 `7` 赋值给了res,然后执行 `next` 的作用，遇见下一回的 `yield`，`return` 出结果后结束。
  * > 5.程序执行 `g.send(7)`，程序会从 `yield` 关键字那一行继续向下运行，`send` 会把 `7` 这个值赋值给res变量
  * > 6.由于 `send` 方法中包含 `next()` 方法，所以程序会继续向下运行执行print方法，然后再次进入while循环
  * > 7.程序执行再次遇到 `yield` 关键字，`yield` 会返回后面的值后，程序再次暂停，直到再次调用 `next` 方法或 `send` 方法。
- > 这就结束了，说一下，为什么用这个生成器，是因为如果用List的话，会占用更大的空间，比如说取 `0,1,2,3,4,5,6............1000` 你可能会这样：
  ```py
  for n in range(1000):
      a=n
  ```
- > 这个时候 `range(1000)` 就默认生成一个含有1000个数的 `list` 了，所以很占内存。这个时候你可以用刚才的 `yield` 组合成生成器进行实现，也可以用 `xrange(1000)` 这个生成器实现 `yield` 组合：
  ```py
  def foo(num):
      print("starting...")
      while num<10:
          num=num+1
          yield num
  for n in foo(0):
      print(n)
  ```
  ```console
  starting...
  1
  2
  3
  4
  5
  6
  7
  8
  9
  10
  ```
- > 其中要注意的是python3时已经没有 `xrange()` 了，在python3中，`range()` 就是 `xrange()` 了，你可以在python3中查看 `range()` 的类型，它已经是个 `<class 'range'>` 了，而不是一个 `list` 了，毕竟这个是需要优化的。 

Python yield 使用浅析 https://www.runoob.com/w3cnote/python-yield-used-analysis.html
- > **清单 5. 使用 `yield` 的第四版**
  * > 简单地讲，yield 的作用就是把一个函数变成一个 generator，带有 yield 的函数不再是一个普通函数，Python 解释器会将其视为一个 generator，调用 fab(5) 不会执行 fab 函数，而是返回一个 iterable 对象！在 for 循环执行时，每次循环都会执行 fab 函数内部的代码，执行到 yield b 时，fab 函数就返回一个迭代值，下次迭代时，代码从 yield b 的下一条语句继续执行，而函数的本地变量看起来和上次中断执行前是完全一样的，于是函数继续执行，直到再次遇到 yield。也可以手动调用 fab(5) 的 next() 方法（因为 fab(5) 是一个 generator 对象，该对象具有 next() 方法），这样我们就可以更清楚地看到 fab 的执行流程：
- > **我们可以得出以下结论**：
  * > 一个带有 yield 的函数就是一个 generator，它和普通函数不同，生成一个 generator 看起来像函数调用，但不会执行任何函数代码，直到对其调用 next()（在 for 循环中会自动调用 next()）才开始执行。虽然执行流程仍按函数的流程执行，但每执行到一个 yield 语句就会中断，并返回一个迭代值，下次执行时从 yield 的下一个语句继续执行。看起来就好像一个函数在正常执行的过程中被 yield 中断了数次，每次中断都会通过 yield 返回当前的迭代值。
  * > yield 的好处是显而易见的，把一个函数改写为一个 generator 就获得了迭代能力，比起用类的实例保存状态来计算下一个 next() 的值，不仅代码简洁，而且执行流程异常清晰。
  * > 如何判断一个函数是否是一个特殊的 generator 函数？可以利用 `isgeneratorfunction` 判断：
- > **另一个例子**
  * > 另一个 yield 的例子来源于文件读取。如果直接对文件对象调用 read() 方法，会导致不可预测的内存占用。好的方法是利用固定长度的缓冲区来不断读取文件内容。通过 yield，我们不再需要编写读文件的迭代类，就可以轻松实现文件读取：

What does the “yield” keyword do? https://stackoverflow.com/questions/231767/what-does-the-yield-keyword-do

Python中yield和yield from的用法 https://www.cnblogs.com/cnkai/p/7514828.html

Python | yield Keyword https://www.geeksforgeeks.org/python-yield-keyword/

## 迭代器减少内存占用

python3使用迭代生成器yield减少内存占用 https://cloud.tencent.com/developer/article/1827465

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
