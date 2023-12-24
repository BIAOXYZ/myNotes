
# defaultdict

Using the Python defaultdict Type for Handling Missing Keys https://realpython.com/python-defaultdict/

Python中的defaultdict方法 https://segmentfault.com/a/1190000010081065

python中defaultdict用法详解 https://www.jianshu.com/p/bbd258f99fd3
- > 当我使用普通的字典时，用法一般是 `dict={}`, 添加元素的只需要 `dict[element] = value`，调用的时候也是如此，`dict[element] = xxx`, 但前提是element在字典里，如果不在字典里就会报错，这时 `defaultdict` 就能排上用场了，`defaultdict` 的作用是在于，当字典里的key不存在但被查找时，返回的不是keyError而是一个默认值，这个默认值是什么呢，下面会说
- > `defaultdict` 接受一个 ***工厂函数作*** 为参数，如下来构造：
  ```py
  dict = defaultdict( factory_function )
  ```
- 这个 ***factory_function*** 可以是 `list`、`set`、`str` 等等，作用是当key不存在时，返回的是***工厂函数的默认值***，比如 `list` 对应 `[ ]`，`str`对应的是***空字符串***，`set` 对应 `set( )`，`int` 对应 `0`，如下举例：
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
- > 【[:star:][`*`]】 3、再改进：使用 `setdefault()` 方法设置默认值
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
  > 一种特殊类型的字典本身就保存了默认值 `defaultdict()`，`defaultdict` 类的初始化函数接受一个 ***类型*** 作为参数，当所访问的键不存在的时候，可以实例化一个值作为默认值。
  ```py
  >>> from collections import defaultdict
  >>> dd = defaultdict(list)
  >>> dd
  defaultdict(<type 'list'>, {})
  >>> dd['hh']
  []
  >>> dd
  defaultdict(<type 'list'>, {'hh': []})
  >>> dd['hh'].append('haha')
  >>> dd
  defaultdict(<type 'list'>, {'hh': ['haha']})
  >>> 
  ```
  ```py
  # 这个是个人实战的 Python3 版本的。跟原文里比起来好像只有 `tpye` 和 `class` 的区别。
  >>> from collections import defaultdict
  >>> dd = defaultdict(list)
  >>> dd
  defaultdict(<class 'list'>, {})
  >>> dd['hh']
  []
  >>> dd
  defaultdict(<class 'list'>, {'hh': []})
  >>> dd['hh'].append('haha')
  >>> dd
  defaultdict(<class 'list'>, {'hh': ['haha']})
  >>> 
  ```
  > 该类除了接受类型名称作为初始化函数的参数之外，***还可以使用任何不带参数的可调用函数，到时该函数的返回结果作为默认值***，这样使得默认值的取值更加灵活。
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
- > Defaultdict is a container like [dictionaries](https://www.geeksforgeeks.org/python-dictionary/) present in the module `collections`. Defaultdict is a sub-class of the `dict` class that returns a dictionary-like object. The functionality of both dictionaries and `defualtdict` are ***almost same except for the fact that `defualtdict` never raises a `KeyError`***. It ***provides a default value for the key that does not exists***.
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

# defaultdict问题

How to use a specific data structure as the default_factory for a defaultdict? https://stackoverflow.com/questions/31723719/how-to-use-a-specific-data-structure-as-the-default-factory-for-a-defaultdict
- https://stackoverflow.com/questions/31723719/how-to-use-a-specific-data-structure-as-the-default-factory-for-a-defaultdict/31723862#31723862
  * > You just need to define your default_factory as a function that returns the dictionary you want to default to:
    ```py
    from collections import defaultdict, Counter
    d = defaultdict(lambda: {'counter': Counter(), 'name': ''})
    d['x']['counter']['b'] += 1
    d['x']['counter']['c'] += 1
    print(d)
    ```
  * > If you are not familiar with lambdas, this is the same thing as:
    ```py
    def my_factory():
        aDict = {'counter': Counter(), 'name':''}
        return aDict
    d = defaultdict(my_factory)
    ```

# defaultdict个人实战

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
