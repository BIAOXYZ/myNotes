
# 官方

# 其他

排序指南 https://docs.python.org/zh-cn/3/howto/sorting.html || Sorting HOW TO https://docs.python.org/3/howto/sorting.html
- > **基本排序**
  * > 简单的升序排序非常简单：只需调用 sorted() 函数即可。它会返回一个新的已排序列表。
  * > 你也可以使用 list.sort() 方法，它会直接修改原列表（并返回 None 以避免混淆），通常来说它不如 sorted() 方便 ——— 但如果你不需要原列表，它会更有效率。
  * > 另外一个区别是， list.sort() 方法只是为列表定义的，而 sorted() 函数可以接受任何可迭代对象。
- > **关键函数**
  * > list.sort() 和 sorted() 都有一个 key 形参用来指定在进行比较前要在每个列表元素上调用的函数（或其他可调用对象）。
  * > 例如，下面是一个不区分大小写的字符串比较：
    ```py
    >>> sorted("This is a test string from Andrew".split(), key=str.lower)
    ['a', 'Andrew', 'from', 'is', 'string', 'test', 'This']
    ```
  * > key 形参的值应该是个函数（或其他可调用对象），它接受一个参数并返回一个用于排序的键。 这种机制速度很快，因为对于每个输入记录只会调用一次键函数。
  * > 一种常见的模式是使用对象的一些索引作为键对复杂对象进行排序。例如：
    ```py
    >>> student_tuples = [
    ...     ('john', 'A', 15),
    ...     ('jane', 'B', 12),
    ...     ('dave', 'B', 10),
    ... ]
    >>> sorted(student_tuples, key=lambda student: student[2])   # sort by age
    [('dave', 'B', 10), ('jane', 'B', 12), ('john', 'A', 15)]
    ```
  * > 同样的技术也适用于具有命名属性的对象。例如：
- > **使用 cmp 参数的旧方法**
  * > 本 HOWTO 中给出的许多结构都假定为 Python 2.4 或更高版本。在此之前，没有内置 sorted() ， list.sort() 也没有关键字参数。相反，所有 Py2.x 版本都支持 cmp 参数来处理用户指定的比较函数。
  * > 在 Py3.0 中， cmp 参数被完全删除（作为简化和统一语言努力的一部分，消除了丰富的比较与 __cmp__() 魔术方法之间的冲突）。

python按照多个条件排序 https://blog.csdn.net/y12345678904/article/details/77507552
```py
# 对tuple进行排序，先按照第一个元素升序，如果第一个元素相同，再按照第二个元素降序排列。
L = [(12, 12), (34, 13), (32, 15), (12, 24), (32, 64), (32, 11)]
L.sort(key=lambda x: (x[0], -x[1]))
print(L)

# 结果：
[(12, 24), (12, 12), (32, 64), (32, 15), (32, 11), (34, 13)]
```

Python应用——自定义排序全套方案 - 承志的文章 - 知乎 https://zhuanlan.zhihu.com/p/108949863
