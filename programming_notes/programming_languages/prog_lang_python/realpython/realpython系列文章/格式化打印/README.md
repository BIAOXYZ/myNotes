
Python 3's f-Strings: An Improved String Formatting Syntax (Guide) https://realpython.com/python-f-strings/

# 其他

神奇的 f-strings - 小明的文章 - 知乎 https://zhuanlan.zhihu.com/p/62774871

# `%r` 与 `%s`

When to use %r instead of %s in Python? [duplicate] https://stackoverflow.com/questions/6005159/when-to-use-r-instead-of-s-in-python
- https://stackoverflow.com/questions/6005159/when-to-use-r-instead-of-s-in-python/6005180#6005180
  * > The `%s` specifier converts the object using `str()`, and `%r` converts it using `repr()`.
  * > For some objects such as integers, they yield the same result, but `repr()` is special in that (for types where this is possible) it conventionally returns a result that is valid Python syntax, which could be used to unambiguously recreate the object it represents. Here's an example, using a date:
    ```py
    >>> import datetime
    >>> d = datetime.date.today()
    >>> str(d)
    '2011-05-14'
    >>> repr(d)
    'datetime.date(2011, 5, 14)'
    ```
  * > Types for which `repr()` doesn't produce Python syntax include those that point to external resources such as a `file`, which you can't guarantee to recreate in a different context.

What is the meaning of %r? https://stackoverflow.com/questions/2354329/what-is-the-meaning-of-r
- https://stackoverflow.com/questions/2354329/what-is-the-meaning-of-r/2354652#2354652
  * > In Python, there are two builtin functions for turning an object into a string: `str` vs. `repr`. `str` is supposed to be a friendly, human readable string. `repr` is supposed to include detailed information about an object's contents (sometimes, they'll return the same thing, such as for integers). By convention, if there's a Python expression that will eval to another object that's ==, `repr` will return such an expression e.g.
    ```py
    >>> print repr('hi')
    'hi'  # notice the quotes here as opposed to...
    >>> print str('hi')
    hi
    ```
  * > If returning an expression doesn't make sense for an object, `repr` should return a string that's surrounded by `<` and `>` symbols e.g. `<blah>`.

python什么情况下用 %r，什么情况下用 %s？ https://segmentfault.com/q/1010000000163896
