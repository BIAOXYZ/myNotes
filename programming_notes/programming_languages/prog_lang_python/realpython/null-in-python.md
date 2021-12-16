
Null in Python: Understanding Python's NoneType Object https://realpython.com/null-in-python/
- > If you have experience with other programming languages, like C or Java, then you’ve probably heard of the concept of `null`. Many languages use this to ***represent a pointer that doesn’t point to anything***, to ***denote when a variable is empty***, or to ***mark default parameters that you haven’t yet supplied***. `null` is often defined to be `0` in those languages, but `null` in Python is different.
- > Python uses the keyword `None` to define `null` objects and variables. While `None` does serve some of the same purposes as `null` in other languages, it’s another beast entirely. As the `null` in Python, `None` is not defined to be `0` or any other value. In Python, ***`None` is an object and a first-class citizen***!
- > **Understanding Null in Python**
  * > `None` is ***the value a function returns when there is no return statement*** in the function:
    ```py
    >>> def has_no_return():
    ...     pass
    >>> has_no_return()
    >>> print(has_no_return())
    None    
    ```
    > When you call `has_no_return()`, there’s no output for you to see. When you print a call to it, however, you’ll see the hidden `None` it returns.
  * > In fact, `None` so frequently appears as a return value that the Python [REPL](https://realpython.com/interacting-with-python/) won’t print `None` unless you explicitly tell it to:
    ```py
    >>> None
    >>> print(None)
    None
    ```
    > `None` by itself has no output, but printing it displays `None` to the console.
  * > Interestingly, [`print()`](https://realpython.com/python-print/) itself has no return value. ***If you try to print a call to `print()`, then you’ll get `None`***:
    ```py
    >>> print(print("Hello, World!"))
    Hello, World!
    None
    ```
    > It may look strange, but `print(print("..."))` shows you the `None` that the inner `print()` returns.
  * > `None` also often used as a signal for **missing or default parameters**. For instance, `None` appears twice in the docs for [list.sort](https://docs.python.org/3/library/stdtypes.html#list.sort):
    ```py
    >>> help(list.sort)
    Help on method_descriptor:

    sort(...)
        L.sort(key=None, reverse=False) -> None -- stable sort *IN PLACE*
    ```
    > Here, `None` is the default value for the key parameter as well as the [type hint]() for the return value. The exact output of `help` can vary from platform to platform. You may get different output when you run this command in your interpreter, but it will be similar.
- > **Using Python’s Null Object `None`**
  * > Often, you’ll use `None` as part of a comparison. One example is when you need to check and see if some result or parameter is `None`. Take the result you get from [re.match](). Did your [regular expression](https://realpython.com/regex-python/) match a given string? You’ll see one of two results:
    1. **Return a `Match` object**: Your regular expression found a match.
    2. **Return a `None` object**: Your regular expression did not find a match.
    > In the code block below, you’re testing if the pattern "Goodbye" matches a [string]():
    ```py
    >>> import re
    >>> match = re.match(r"Goodbye", "Hello, World!")
    >>> if match is None:
    ...     print("It doesn't match.")
    It doesn't match.
    ```
    > Here, you use `is None` to test if the pattern matches the string "Hello, World!". This code block demonstrates ***an important rule to keep in mind when you’re checking for `None`***:
    1. **Do** use the ***`identity operators`*** `is` and `is not`.
    2. **Do not** use the ***`equality operators`*** `==` and `!=`.
    >> 【[:star:][`*`]】 //notes：这个可以死记住：***当要和 `None` 进行比较时，永远用 `is` 或 `is not` 而不是 `==` 或 `!=`***。原因不详细展开了，这篇文章后续的内容，以及下一篇文章里都有解释。
  * > The ***`equality operators`*** can be fooled when you’re comparing user-defined objects that **override** them:
    ```py
    >>> class BrokenComparison:
    ...     def __eq__(self, other):
    ...         return True
    >>> b = BrokenComparison()
    >>> b == None  # Equality operator
    True
    >>> b is None  # Identity operator
    False
    ```
    > Here, the ***equality operator*** `==` returns the wrong answer. The [***identity operator*** `is`](https://realpython.com/python-is-identity-vs-equality/), on the other hand, can’t be fooled ***because you can’t override it***.
  * > `None` is [**falsy**](), ***which means `not None` is `True`***. If all you want to know is whether a result is falsy, then a test like the following is sufficient:
    ```py
    >>> some_result = None
    >>> if some_result:
    ...     print("Got a result!")
    ... else:
    ...     print("No result.")
    ...
    No result.
    ```
    > The output ***doesn’t show you that `some_result` is exactly `None`, only that it’s falsy***. If you must know whether or not you have a `None` object, then use `is` and `is not`.
  * > The following objects are all falsy as well:
      + Empty lists
      + Empty dictionaries
      + Empty sets
      + Empty strings
      + 0
      + False
    > For more on comparisons, truthy values, and falsy values, you can read about how to use the [Python or operator](https://realpython.com/python-or-operator/), how to use the [Python and operator](https://realpython.com/python-and-operator/), and how to use the [Python not operator](https://realpython.com/python-not-operator/).
- > **Declaring Null Variables in Python**
  * > In some languages, variables come to life from a **declaration**. They don’t have to have an initial value assigned to them. In those languages, the initial default value for some types of variables might be `null`. In Python, however, variables come to life from **assignment statements**. Take a look at the following code block:
    ```py
    >>> print(bar)
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    NameError: name 'bar' is not defined
    >>> bar = None
    >>> print(bar)
    None
    ```
    > Here, you can see that a variable with the value `None` is different from an undefined variable. All variables in Python come into existence by assignment. A variable will only start life as `null` in Python if you assign `None` to it.
- > **Using `None` as a Default Parameter**

# 其他文章

【[:ok:][:star:][`*`]】 python 中None，is和==的深入探讨 https://www.jianshu.com/p/627232777efd
- > 注：运行环境：python3.6.6，win10，64位
- > **1. `None`**
  * > `None` 是python中的一个特殊的常量，***表示一个空的对象***，空值是python中的一个特殊值。***数据为空并不代表是空对象***，例如 `[]`, `''` 等都不是 `None`。 `None` 和任何对象比较返回值都是 `False`，除了自己。
    ```py
    >>> L=[]
    >>> L is None
    False
    >>> L=''
    >>> L is None
    False
    ```
  * > `None` 有自己的数据类型 `NontType`，你可以将 `None` 赋值给任意对象，***但是不能创建一个 `NoneType` 对象***。
    ```py
    >>> type(None)
    <class 'NoneType'>
    >>> n=NoneType()
    Traceback (most recent call last):
      File "<input>", line 1, in <module>
    NameError: name 'NoneType' is not defined
    ```
- > **2. `False`**
  * > 需要注意一点：
    ```py
    >>> a=False
    >>> not a
    True
    ```
  * > ***<ins>python中数据为空的对象在判断时的结果都为 `False`</ins>***，其中 `None`，`False`，`0`，`[]`，`""`，`{}`，`()` 都相当于 `False`，即 `not None == not False == not '' == not 0 == not [] == not {} == not ()`。
- > **3. `is` 和 `==`**
  * > `is` 表示的是对象标识符，用来检查对象的标识符是否一致，即两个对象在内存中的地址是否一致。在使用 `a is b` 的时候，相当于 `id(a)==id(b)`。
  * > `==` 表示两个对象是否相等，相当于调用 `__eq__()` 方法，即 `'a==b'` ==> `a.__eq__(b)`。
- > **4. Python里和 `None` 比较时，为什么是 `is None` 而不是 `== None`**
  * > 因为 ***`None` 在Python里是个`单例对象`***，一个变量如果是 `None`，它一定和 `None` 指向同一个内存地址。
    ```py
    >>> a=None
    >>> b=None
    >>> id(a)==id(b)
    True
    ```
  * > `is None` 是判断两个对象在内存中的地址是否一致，`== None` 背后调用的是 **eq**，而 **eq** 可以被重载，下面是一个 `is not None` 但 `== None` 的例子：
    ```py
    >>> class test():
    ...     def __eq__(self,other):
    ...         return True
    ... 
    >>> t=test()
    >>> t is None
    False
    >>> t == None
    True
    ```
- > **5. 参考资料**
  * > https://blog.csdn.net/Primeprime/article/details/77186109
  * > https://www.jianshu.com/p/1cc3282bfe29

深入理解Python中的None - 小包总的文章 - 知乎 https://zhuanlan.zhihu.com/p/65193194
