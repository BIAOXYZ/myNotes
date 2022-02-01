
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

Python3 序列解包 https://blog.csdn.net/yilovexing/article/details/80576788

Python3 `*` 和 `**` 运算符 https://blog.csdn.net/yilovexing/article/details/80577510

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

## 优先级

python中not、and、or的优先级与详细用法 https://blog.csdn.net/m0_51284422/article/details/109441190

## 位运算操作符

BitwiseOperators https://wiki.python.org/moin/BitwiseOperators
```console
x << y
      Returns x with the bits shifted to the left by y places (and new bits on the right-hand-side are zeros). This is the same as multiplying x by 2**y.
x >> y
      Returns x with the bits shifted to the right by y places. This is the same as //'ing x by 2**y.
x & y
      Does a "bitwise and". Each bit of the output is 1 if the corresponding bit of x AND of y is 1, otherwise it's 0.
x | y
      Does a "bitwise or". Each bit of the output is 0 if the corresponding bit of x AND of y is 0, otherwise it's 1.
~ x
      Returns the complement of x - the number you get by switching each 1 for a 0 and each 0 for a 1. This is the same as -x - 1.
x ^ y
      Does a "bitwise exclusive or". Each bit of the output is the same as the corresponding bit in x if that bit in y is 0, and it's the complement of the bit in x if that bit in y is 1.
```

What does |= (ior) do in Python? https://stackoverflow.com/questions/3929278/what-does-ior-do-in-python

python 中右移、左移运算符的作用 https://blog.csdn.net/Strive_For_Future/article/details/95343808
```py
print("1<<5结果：",1<<5)
print("3*1<<5结果：",3*1<<5)
print("3<<5结果：",3<<5)
```
```console
1<<5结果： 32
3*1<<5结果： 96
3<<5结果： 96
```
- > 所以：左移、右移是指：在二进制中，将1向左、向右移动的位数，返回的是将二进制数转换为十进制数的结果。
- > 公式：`a<<b` 等价于 `a*(1<<b)`，而 `(1<<b)` 的结果是二进制数：`100...00` (***共b个0，表示将1向左移动b位***)，对应的十进制结果是：$2^{b}$。
- > 示例：`3<<5  =  3*2^{5}  =  96`

负数在python中的右移计算 https://www.pynote.net/archives/3761
- > 在python中，整数（int）的理解不同于C语言，我们可以将int理解为一个整数对象，可以无限大。一个整数做右移运算，当移动的位数足够多时，结果就是0；***但是负数不一样，当移动的位数足够多时，最后的结果是-1***。
- > 负数在计算机中的表示方式为补码（two's complement），python在做负数右移时，是对负数的bit位直接进行操作，右移后的最高位（MSB）要用1来占位，然后再将此bit序列按照补码的方式，翻译成一个负数。
  ```console
  下面以4bit系统来说明：
  -5的补码为1011，右移1位得到1101，1101就是-3（3是0011，反码1100，补码1101）；
  -6的补码为1010，右移1位还是得到1101，因此结果还是-3。
  ```
- > 这也就解释了为什么当负数右移足够多位的时候，最后的结果总是-1。因为，当一直右移时，最后得到的一定是1111，然后再继续右移，因为MSB要用1占位，还是1111不变，1111就是-1的补码。（C语言中的右移应该也是这样的，那天找时间做个测试）
