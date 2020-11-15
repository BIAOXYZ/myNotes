
# 官方

`2. Built-in Functions` https://docs.python.org/2.7/library/functions.html

Built-in Functions https://docs.python.org/3.8/library/functions.html

## `sorted()`

排序指南 https://docs.python.org/zh-cn/3/howto/sorting.html || Sorting HOW TO https://docs.python.org/3/howto/sorting.html
- > 简单的升序排序非常简单：只需调用 sorted() 函数即可。它会返回一个新的已排序列表。
- > 你也可以使用 list.sort() 方法，它会直接修改原列表（并返回 None 以避免混淆），通常来说它不如 sorted() 方便 ——— 但如果你不需要原列表，它会更有效率。
- > 另外一个区别是， list.sort() 方法只是为列表定义的，而 sorted() 函数可以接受任何可迭代对象。
- > list.sort() 和 sorted() 都有一个 key 形参用来指定在进行比较前要在每个列表元素上调用的函数（或其他可调用对象）。
- > 例如，下面是一个不区分大小写的字符串比较：
  ```py
  >>> sorted("This is a test string from Andrew".split(), key=str.lower)
  ['a', 'Andrew', 'from', 'is', 'string', 'test', 'This']
  ```
- > key 形参的值应该是个函数（或其他可调用对象），它接受一个参数并返回一个用于排序的键。 这种机制速度很快，因为对于每个输入记录只会调用一次键函数。
- > 一种常见的模式是使用对象的一些索引作为键对复杂对象进行排序。例如：
  ```py
  >>> student_tuples = [
  ...     ('john', 'A', 15),
  ...     ('jane', 'B', 12),
  ...     ('dave', 'B', 10),
  ... ]
  >>> sorted(student_tuples, key=lambda student: student[2])   # sort by age
  [('dave', 'B', 10), ('jane', 'B', 12), ('john', 'A', 15)]
  ```
- > 同样的技术也适用于具有命名属性的对象。例如：

# 其他

## `sorted()`

## `zip()`

Using the Python zip() Function for Parallel Iteration https://realpython.com/python-zip-function/

Python zip() https://www.programiz.com/python-programming/methods/built-in/zip

zip() in Python https://www.geeksforgeeks.org/zip-in-python/
