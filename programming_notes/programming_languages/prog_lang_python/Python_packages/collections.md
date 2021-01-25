
# 官方

collections --- 容器数据类型 https://docs.python.org/zh-cn/3.7/library/collections.html || collections — Container datatypes https://docs.python.org/3.7/library/collections.html

8.3. collections — High-performance container datatypes https://docs.python.org/zh-cn/2.7/library/collections.html || 8.3. collections — High-performance container datatypes https://docs.python.org/2.7/library/collections.html

# 其他

12. Collections https://book.pythontips.com/en/latest/collections.html

# deque

How to use a deque in Python https://www.educative.io/edpresso/how-to-use-a-deque-in-python

Deque in Python https://www.geeksforgeeks.org/deque-in-python/

# OrderedDict

Collections.OrderedDict() https://www.hackerrank.com/challenges/py-collections-ordereddict/problem

OrderedDict in Python https://www.geeksforgeeks.org/ordereddict-in-python/
- > An **OrderedDict** is a dictionary subclass that remembers the order that keys were first inserted. The only difference between `dict()` and `OrderedDict()` is that: **OrderedDict** ***preserves the order*** in which the keys are inserted. A regular dict doesn’t track the insertion order, and iterating it gives the values in an arbitrary order. By contrast, the order the items are inserted is remembered by OrderedDict.
- > **Important Points**: 
  * > Key value Change: If the value of a certain key is changed, the position of the key remains unchanged in OrderedDict.
  * > Deletion and Re-Inserting: Deleting and re-inserting the same key will push it to the back as OrderedDict however maintains the order of insertion.
  * >> //notes：说白了就是更新的话不会改变有序字典里key的先后顺序，但是删除再插入的话跟新插入一样，会改变其key的先后顺序。
- > **Other Considerations**:
  * > Ordered dict in Python version 2.7 consumes more memory than normal dict. This is due to the underlying Doubly Linked List implementation for keeping the order. In Python 2.7 Ordered Dict is not dict subclass, it’s a specialized container from collections module.
  * > Starting from Python 3.7, insertion order of Python dictionaries is guaranteed.
  * > Ordered Dict can be used as a stack with the help of `popitem` function. Try implementing LRU cache with Ordered Dict.

OrderedDict 是如何保证 Key 的插入顺序的 https://old-panda.com/2020/02/09/python-ordereddict/

Python OrderedDict https://www.askpython.com/python-modules/python-ordereddict

collections之OrderedDict - 程序员Egon老湿的文章 - 知乎 https://zhuanlan.zhihu.com/p/110407087

# defaultdict

Using the Python defaultdict Type for Handling Missing Keys https://realpython.com/python-defaultdict/

Python中的defaultdict方法 https://segmentfault.com/a/1190000010081065

python中defaultdict用法详解 https://www.jianshu.com/p/bbd258f99fd3
- > defaultdict接受一个工厂函数作为参数，这个factory_function可以是list、set、str等等，作用是当key不存在时，返回的是工厂函数的默认值，比如list对应[ ]，str对应的是空字符串，set对应set( )，int对应0，如下举例：
  ```py
  from collections import defaultdict
  dict1 = defaultdict(int)
  dict2 = defaultdict(set)
  dict3 = defaultdict(str)
  dict4 = defaultdict(list)
  print(dict1[1])
  print(dict2[1])
  print(dict3[1])
  print(dict4[1])
  --------------------------------------------------
  0
  set([])
  
  []
  ```

Python中collections.defaultdict()使用 https://www.jianshu.com/p/26df28b3bfc8
- > 1、以一个例子开始：统计一个列表里各单词重复次数
  ```py
  words = ['hello', 'world', 'nice', 'world']
  counter = dict()
  for kw in words:
      counter[kw] += 1
  ```
  > 这样写肯定会报错的，因为各词的个数都没有初始值，引发KeyError
- > 3、再改进：使用`setdefault()`方法设置默认值
  ```py
  words = ['hello', 'world', 'nice', 'world']
  counter = dict()
  for kw in words:
      counter.setdefault(kw, 0)
      counter[kw] += 1
  ```
  > `setdefault()`，需提供两个参数，第一个参数是键值，第二个参数是默认值，每次调用都有一个返回值，如果字典中不存在该键则返回默认值，如果存在该键则返回该值，利用返回值可再次修改代码。
  ```py
  words = ['hello', 'world', 'nice', 'world']
  counter = dict()
  for kw in words:
      counter[kw] = counter.setdefault(kw, 0) + 1
  ```
- > 4、接着改进
  >
  > 一种特殊类型的字典本身就保存了默认值`defaultdict`，`defaultdict`类的初始化函数接受一个类型作为参数，当所访问的键不存在的时候，可以实例化一个值作为默认值。
  >
  > 该类除了接受类型名称作为初始化函数的参数之外，还可以使用任何不带参数的可调用函数，到时该函数的返回结果作为默认值，这样使得默认值的取值更加灵活。
  ```py
  >>> from collections import defaultdict
  >>> def zero():
  ...     return 0
  ...
  >>> dd = defaultdict(zero)
  >>> dd
  defaultdict(<function zero at 0xb7ed2684>, {})
  >>> dd['foo']
  0
  >>> dd
  defaultdict(<function zero at 0xb7ed2684>, {'foo': 0})
  ```
  > 最终代码：
  ```py
  from collections import defaultdict
  words = ['hello', 'world', 'nice', 'world']
  #使用lambda来定义简单的函数
  counter = defaultdict(lambda: 0) 
  for kw in words:
      counter[kw] += 1
  ```

Defaultdict in Python https://www.geeksforgeeks.org/defaultdict-in-python/
- > In Dictionary, the key must be unique and immutable. ***This means that a Python `Tuple` can be a key whereas a Python `List` can not***.
- > Sometimes, when the KeyError is raised, it might become a problem. To overcome this Python introduces another dictionary like container known as Defaultdict which is present inside the collections module. Note: For more information, refer to [Python Dictionary](https://www.geeksforgeeks.org/python-dictionary/).
- > **DefaultDict**
- > Defaultdict is a container like [dictionaries](https://www.geeksforgeeks.org/python-dictionary/) present in the module `collections`. Defaultdict is a sub-class of the `dict` class that returns a dictionary-like object. The functionality of both dictionaries and `defualtdict` are almost same except for the fact that `defualtdict` never raises a `KeyError`. It provides a default value for the key that does not exists.
  ```py
  from collections import defaultdict
  
  def def_value():
      return "Not Present"
  
  d = defaultdict(def_value)
  d["a"] = 1
  d["b"] = 2
  print(d["a"])
  print(d["b"])
  print(d["c"])
  --------------------------------------------------
  1
  2
  Not Present
  ```
- > **Inner Working of defaultdict**
  ```py
  from collections import defaultdict
  d = defaultdict(lambda: "Not Present")
  d["a"] = 1
  d["b"] = 2
  print(d["a"]) 
  print(d["b"])
  print(d["c"])
  --------------------------------------------------
  1
  2
  Not Present
  ```
- > **Using List as default_factory**
  ```py
  from collections import defaultdict
  
  d = defaultdict(list)
  
  for i in range(5):
      d[i].append(i)
  print("Dictionary with values as list:")
  print(d)
  --------------------------------------------------
  Dictionary with values as list:
  defaultdict(<type 'list'>, {0: [0], 1: [1], 2: [2], 3: [3], 4: [4]})
  ```
- > **Using int as default_factory**
  ```py
  from collections import defaultdict
  
  d = defaultdict(int)
  
  L = [1, 2, 3, 4, 2, 4, 1, 2]
  for i in L:
      d[i] += 1
  print(d)
  --------------------------------------------------
  defaultdict(<type 'int'>, {1: 2, 2: 3, 3: 1, 4: 2})
  ```

DefaultDict Tutorial https://www.hackerrank.com/challenges/defaultdict-tutorial/problem

How does collections.defaultdict work? https://stackoverflow.com/questions/5900578/how-does-collections-defaultdict-work

Python Defaultdict – Int and List as a Default Factory https://data-flair.training/blogs/python-defaultdict/

## defaultdict个人实战

```py
from collections import defaultdict

defaultDic = defaultdict(list)
print defaultDic

ddic = defaultdict()
print ddic
--------------------------------------------------
defaultdict(<type 'list'>, {})
defaultdict(None, {})
```

# Counter

Counters in Python | Set 1 (Initialization and Updation) https://www.geeksforgeeks.org/counters-in-python-set-1/

Python | Counter Objects | elements() https://www.geeksforgeeks.org/python-counter-objects-elements/

Counter https://pymotw.com/2/collections/counter.html

Python Counter in Collections with Example https://www.guru99.com/python-counter-collections-example.html
