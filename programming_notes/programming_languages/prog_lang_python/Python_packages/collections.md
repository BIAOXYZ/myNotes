
# 官方

collections --- 容器数据类型 https://docs.python.org/zh-cn/3.7/library/collections.html || collections — Container datatypes https://docs.python.org/3.7/library/collections.html

8.3. collections — High-performance container datatypes https://docs.python.org/zh-cn/2.7/library/collections.html || 8.3. collections — High-performance container datatypes https://docs.python.org/2.7/library/collections.html

# 其他

12. Collections https://book.pythontips.com/en/latest/collections.html

# deque

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

Python中collections.defaultdict()使用 https://www.jianshu.com/p/26df28b3bfc8

Defaultdict in Python https://www.geeksforgeeks.org/defaultdict-in-python/

DefaultDict Tutorial https://www.hackerrank.com/challenges/defaultdict-tutorial/problem

How does collections.defaultdict work? https://stackoverflow.com/questions/5900578/how-does-collections-defaultdict-work

Python Defaultdict – Int and List as a Default Factory https://data-flair.training/blogs/python-defaultdict/
