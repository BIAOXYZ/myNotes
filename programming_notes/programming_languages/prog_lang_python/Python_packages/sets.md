
# 官方

8.7. sets — Unordered collections of unique elements https://docs.python.org/2/library/sets.html
- > Deprecated since version 2.6: The built-in `set`/`frozenset` types replace this module.

>> //notes：由于`sets模块`已经作废，并由build-in类型`set`和`frozenset`取代，所以下面的攻略基本都是为新的build-in类型的set的。

# 其他

Sets in Python https://realpython.com/python-sets/

Sets in Python https://www.geeksforgeeks.org/sets-in-python/

【[:star:][`*`]】 Python Sets https://www.programiz.com/python-programming/set
- > **Removing elements from a set**
  * > A particular item can be removed from a set using the methods `discard()` and `remove()`.
  * > The only difference between the two is that the `discard()` function leaves a set unchanged if the element is not present in the set. On the other hand, the `remove()` function will raise an error in such a condition (if element is not present in the set).
  * > Similarly, we can remove and return an item using the `pop()` method.
  * > Since set is an unordered data type, there is no way of determining which item will be popped. It is completely arbitrary.
- > **Python Frozenset**
  * > Frozenset is a new class that has the characteristics of a set, but its elements cannot be changed once assigned. ***While tuples are immutable lists, frozensets are immutable sets**.
  * > Sets being mutable are unhashable, so they can't be used as dictionary keys. On the other hand, ***frozensets are hashable and can be used as keys to a dictionary***.
  * > Frozensets can be created using the [`frozenset()`](https://www.programiz.com/python-programming/methods/built-in/frozenset) function.

Python3 集合 https://www.runoob.com/python3/python3-set.html
