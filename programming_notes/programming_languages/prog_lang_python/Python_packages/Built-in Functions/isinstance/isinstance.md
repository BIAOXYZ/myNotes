
# 官方

https://docs.python.org/zh-cn/3/library/functions.html#isinstance

# 其他

## `isinstance()` v.s. `type()`

What's the canonical way to check for type in Python? https://stackoverflow.com/questions/152580/whats-the-canonical-way-to-check-for-type-in-python
- https://stackoverflow.com/questions/152580/whats-the-canonical-way-to-check-for-type-in-python/152596#152596
  * > Use `isinstance` to check if `o` is an instance of `str` or any subclass of `str`:
    ```py
    if isinstance(o, str):
    ```
  * > To check if the type of `o` is exactly `str`, excluding subclasses of `str`:
    ```py
    if type(o) is str:
    ```

【[:star:][`*`]】 What is better: type() vs isinstance() https://blog.devgenius.io/what-is-better-type-vs-isinstance-3b948d1b81b5
- > **1. Introduction**
  * > To verify the type of a variable, you can use either `type()` or `isinstance()` built-in function. Let’s see them in action:
    ```py
    >>> variable = "hello"
    >>> type(variable) is str
    True
    >>> isinstance(variable, str)
    True
    ```
  * > Let’s compare the performance of the two approaches:
    ```py
    $ python -m timeit -s "variable = 'hello'" "type(variable) is int"
    2000000 loops, best of 5: 101 nsec per loop
    $ python -m timeit -s "variable = 'hello'" "isinstance(variable, str)"
    5000000 loops, best of 5: 73.1 nsec per loop
    ```
  * > `type()` is around `40%` slower (`102/72.8 ~ 1.40`).
  * > We could use `type(variable) == str` instead. That would work, ***but that’s a poor idea***:
    + > ***`==` should be used when you want to check the value of a variable***. We would use that to see if the value of the variable equals “hello”. But when we want to verify if the variable is a string, `is` operator is more appropriate.
    + > `==` is slower:
      ```py
      $ python -m timeit -s "variable = 'hello'" "type(variable) == str"
      2000000 loops, best of 5: 114 nsec per loop
      ```
- > **2. Difference between `isinstance()` and `type()`**
  * > Speed is not the only difference between these two functions. There is in fact an important distinction between their functioning:
    + > `type()` only returns the type of an object. This can be used to determine if a variable is of a type `str`.
    + > `isinstance()` checks if a given object (***first parameter***) is:
      - an instance of a class specified as a ***second parameter***. For example, is variable an instance of the `str` class?
      - or an instance of a subclass of a class specified as a second parameter. In other words, is variable an instance of a subclass of `str`?
  * > What does this mean practically? Let’s say we want to have a custom class that functions as a `list` but has some extra methods. This would allow us to sub-classify the `list` type and add custom features inside:
    ```py
    class MyAwesomeList(list):
        # Some functions
    ```
  * > But now the `type()` and `isinstance()` return different results by comparing this new class with a list!
    ```py
    >>> my_list = MyAwesomeList()
    >>> type(my_list) is list
    False
    >>> isinstance(my_list, list)
    True
    ```
  * > We get different results because `isinstance()` checks if my_list is an instance of `list` (it's not) or a sub-class of `list` (it is, because `MyAwesomeList` is a sub-class of `list`). If you forget the difference, it may lead to a couple of subtle bugs in your code.
- > **3. Conclusions**
  * > `isinstance()` is generally the preferred method of comparing types. It's not only faster but also considers inheritance, which is often the desired behavior. In Python, you usually want to verify if a given object behaves like a string or a list, not necessarily if it's exactly a string. So instead of verifying for string and all its custom sub-classes, you can just use `isinstance()`.
  * > On the other hand, when you want to explicitly verify that a given variable is of a specific type (rather than its sub-class) — use `type()`. And when you use it, use it this way: `type(var) is <some_type>` not like this: `type(var) == <some_type>`.
