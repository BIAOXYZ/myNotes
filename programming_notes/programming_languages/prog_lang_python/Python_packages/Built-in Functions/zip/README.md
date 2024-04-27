
# 官方

# 其他

Using the Python zip() Function for Parallel Iteration https://realpython.com/python-zip-function/

Python zip() https://www.programiz.com/python-programming/methods/built-in/zip
- > **Example 1: Python `zip()`**
  ```py
  number_list = [1, 2, 3]
  str_list = ['one', 'two', 'three']

  # No iterables are passed
  result = zip()

  # Converting iterator to list
  result_list = list(result)
  print(result_list)

  # Two iterables are passed
  result = zip(number_list, str_list)

  # Converting iterator to set
  result_set = set(result)
  print(result_set)
  ```
  > **Output**
  ```console
  []
  {(2, 'two'), (3, 'three'), (1, 'one')}
  ```
- > The `*` operator can be used in conjunction with `zip()` to unzip the list.
- > **Example 3: Unzipping the Value Using `zip()`**
  ```py
  coordinate = ['x', 'y', 'z']
  value = [3, 4, 5]

  result = zip(coordinate, value)
  result_list = list(result)
  print(result_list)

  c, v =  zip(*result_list)
  print('c =', c)
  print('v =', v)
  ```
  > **Output**
  ```console
  [('x', 3), ('y', 4), ('z', 5)]
  c = ('x', 'y', 'z')
  v = (3, 4, 5)
  ```
  >> 【[:star:][`*`]】 //notes：注意，这里其实就相当于把二维矩阵的列给取出来了，是一个常用的小技巧。leetcode 里经常用到，比如：
  ```py
  # 求矩阵的所有列的时候用到了一个技巧 `zip(*grid)`
  # 此外，解包后里面的元素（也就是矩阵的列）已经是 tuple 类型了，比如：
  grid = [[4,3,2,1],[44,33,22,11],[444,333,222,111]]
  cols_list = list(zip(*grid)) 
  print(cols_list)  # [(4, 44, 444), (3, 33, 333), (2, 22, 222), (1, 11, 111)]
  ```

Python zip() 函数 https://www.runoob.com/python/python-func-zip.html
- > zip 方法在 Python 2 和 Python 3 中的不同：在 Python 3.x 中为了减少内存，zip() 返回的是一个对象。如需展示列表，需手动 list() 转换。如果需要了解 Pyhton3 的应用，可以参考 Python3 zip()。
  >> Python3 zip() 函数 https://www.runoob.com/python3/python3-func-zip.html

Python zip()用法，看这一篇就够了 https://blog.csdn.net/PaulZhn/article/details/104391756
- > 这么描述显然有些抽象，让我们直接观察一下它的运行结果：
  ```py
  >>> a = ['a', 'b', 'c', 'd']
  >>> b = ['1', '2', '3', '4']
  >>> list(zip(a, b))
  [('a', '1'), ('b', '2'), ('c', '3'), ('d', '4')]
  ```
  > 很明显，对于我们的两个 `list`，a和b，`list(zip(a, b))` 生成了一个列表。在这个列表中，每个元素是一个 `tuple`；对于第i个元组，它其中的内容是 `(a[i-1], b[i-1])`。这样的操作，与压缩软件的“压缩”十分接近。如果我们继续在 `zip()` 中加入更多的参数，比如 `zip(a, b, c, d)`，那么在将它转换成 `list` 之后，结果当然就是 `[(a[0], b[0], c[0], d[0]), (a[1], b[1], c[1], d[1]), ..., (a[n-1], b[n-1], c[n-1], d[n-1])]`。
  > 
  > 事实上，在 Python 3 中，为了节省空间，`zip()` 返回的是一个 `tuple` 的迭代器，这也是我们为什么要调用 `list()` 将它强制转换成 `list` 的原因。不过，Python 2中，它直接返回的就是一个列表了。
- > 如果我们传入 `zip()` 中的几个参数不等长，会有什么结果呢？`zip()` 很灵活，如果几个参数不等长，那么它会取最短的那个参数的长度，然后再进行处理。至于那些超出最短长度的成员，就只好被舍弃掉了。
- > 对于 `zip(args)` 这个函数，Python还提供了一种逆操作。例如，我们有
  ```py
  result = zip(a, b)
  ```
  > 那么，只要调用
  ```py
  origin = zip(*result)  #前面加*号，事实上*号也是一个特殊的运算符，叫解包运算符
  ```
  > 就可以得到原来的a和b了。利用这个特性，可以用一种特殊的方法处理一些问题，我们待会说。
- > **同时遍历多个字典**
- > **对多个元素同时进行排序**

# LeetCode题目
- `LC944. 删列造序` https://leetcode.cn/problems/delete-columns-to-make-sorted/ 【用 `zip(*mtx)` 返回矩阵 mtx 的列组成的 `list`，这个是取矩阵列的常用技巧。】
- `LC2352. 相等行列对` https://github.com/BIAOXYZ/variousCodes/blob/72617b47df800eee750a689df639794687af2d19/_CodeTopics/LeetCode/2201-2400/002352/002352.py3
- `LC2639. 查询网格图中每一列的宽度` https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/2601-2800/002639/002639.py3
