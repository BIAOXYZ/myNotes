
# 官方

https://docs.python.org/3/library/functions.html#sum

# 其他

老法新用：Python 中的 sum https://blog.zengrong.net/post/sum-in-python/
- > 今天写分析系统的时候看到一段关于 sum 的用法，有点意思：
  ```py
  fruits = ['Apples', 'Pears', 'Nectarines', 'Plums', 'Grapes', 'Strawberries']
  data = {'fruits' : fruits,
          '2015'   : [2, 1, 4, 3, 2, 4],
          '2016'   : [5, 3, 3, 2, 4, 6],
          '2017'   : [3, 2, 4, 4, 5, 3]}
  counts = sum(zip(data['2015'], data['2016'], data['2017']), ())
  ```
  > 这段代码来自于：[bar_nested_colormapped.py](https://docs.bokeh.org/en/latest/docs/gallery/bar_nested_colormapped.html)，有兴趣的同学可以去看看完整代码。
- > 我对 `sum(zip(data['2015'], data['2016'], data['2017']), ())` 这段代码产生了好奇，我自己是从来没有这么用过，一下没看出来这段代码产生的结果是啥。跑一下程序，发现 `counts` 的值为：
  ```py
  In [29]: sum(zip(data['2015'], data['2016'], data['2017']), ())
  Out[29]: (2, 5, 3, 1, 3, 2, 4, 3, 4, 3, 2, 4, 2, 4, 5, 4, 6, 3)
  ```
  > 好吧，这段代码的作用就是把一堆 `tuple` 拼接起来。根据 `sum` 的[官方文档](https://docs.python.org/3/library/functions.html?highlight=sum#sum)，我们知道，`sum` 的作用是对一个 `iterable` 进行求和操作。求和怎么就变成拼接了呢？拆开来一步步看。
- > `zip` 将 3 个等长的 `list` 分成 6 个元组，每组 3 个元素。
  ```py
  In [58]: print(*zip(data['2015'], data['2016'], data['2017']))
  (2, 5, 3) (1, 3, 2) (4, 3, 4) (3, 2, 4) (2, 4, 5) (4, 6, 3)
  ```
  > 这里 `sum` 的含义误导我了，因为这些元组中的元素正好都是数字，让我一直思考它们为啥不加起来反而拼起来了。
- > 因为正常情况下，`sum` 是这么用的：
  ```py
  In [59]: sum((1,2,3))
  Out[59]: 6
  ```
- > 但当我去掉 `sum` 的第二个参数——一个空元组的时候，代码会报错：
  ```py
  In [60]: sum(zip(data['2015'], data['2016'], data['2017']))
  ---------------------------------------------------------------------------
  TypeError                                 Traceback (most recent call last)
  <ipython-input-60-aaab535addac> in <module>
  ----> 1 sum(zip(data['2015'], data['2016'], data['2017']))
  
  TypeError: unsupported operand type(s) for +: 'int' and 'tuple'
  ```
  > 看到这个报错，我才明白过来，这里「求和」的含义是广义的，它不仅仅针对数字，也针对所有实现了求和运算符 `+` 的情况。 <br> `sum` 的第二个参数必须和 `iterable` 中的元素类型相同，且只要实现了求和运算符 `+` 就可以被 `sum` 使用。
- > 我们可以将 `sum` 用在数字上：
  ```py
  In [62]: sum((1,2,3), 4)
  Out[62]: 10
  ```
  > 也可以用在元组中，因为元组也实现了求和运算符：
  ```py
  In [74]: sum(((2,3), (4, 5)), (0,1))
  Out[74]: (0, 1, 2, 3, 4, 5)
  ```
  > 用在 `datetime` 对象中也是可以的：
  ```py
  from datetime import date, timedelta
  In [86]: sum((date.today(),timedelta(days=30)), timedelta(days=2))
  Out[86]: datetime.date(2021, 8, 5)
  ```
- > 但有趣的是，Python 不希望我们把它用在字符串上，尽管字符串也是 `iterable`。这应该是出于性能考虑：
  ```py
  In [76]: sum('love U', 'I ')
  ---------------------------------------------------------------------------
  TypeError                                 Traceback (most recent call last)
  <ipython-input-76-c45d4933da5d> in <module>
  ----> 1 sum('love U', 'I ')
  
  TypeError: sum() can't sum strings [use ''.join(seq) instead]
  ```
  > Python 官方文档也提到，如果要连接 `iterable`，建议使用 `itertools.chain()`：
  >> `To concatenate a series of iterables, consider using itertools.chain().`
- > 所以我也试了试（由于返回的是生成器，我用 `tuple` 将其转换为元组方便查看）：
  ```py
  import itertools
  In [79]: tuple(itertools.chain(*zip(data['2015'], data['2016'], data['2017'])))
  Out[79]: (2, 5, 3, 1, 3, 2, 4, 3, 4, 3, 2, 4, 2, 4, 5, 4, 6, 3)
  ```
- > 新写法能提升性能。你甚至啥也不用干。这就叫躺赢。
