
Null in Python: Understanding Python's NoneType Object https://realpython.com/null-in-python/
- > If you have experience with other programming languages, like C or Java, then you’ve probably heard of the concept of `null`. Many languages use this to ***represent a pointer that doesn’t point to anything***, to ***denote when a variable is empty***, or to ***mark default parameters that you haven’t yet supplied***. `null` is often defined to be `0` in those languages, but `null` in Python is different.
- > Python uses the keyword `None` to define `null` objects and variables. While `None` does serve some of the same purposes as `null` in other languages, it’s another beast entirely. As the `null` in Python, `None is` not defined to be `0` or any other value. In Python, ***`None` is an object and a first-class citizen***!
- > **Understanding Null in Python**
  * > `None` is the value a function returns when there is no return statement in the function:
    ```py
    >>> def has_no_return():
    ...     pass
    >>> has_no_return()
    >>> print(has_no_return())
    None    
    ```
    > When you call `has_no_return()`, there’s no output for you to see. When you print a call to it, however, you’ll see the hidden None it returns.
  * > In fact, None so frequently appears as a return value that the Python REPL won’t print None unless you explicitly tell it to:
    ```py
    >>> None
    >>> print(None)
    None
    ```
    > None by itself has no output, but printing it displays None to the console.
  * > Interestingly, `print()` itself has no return value. If you try to print a call to `print()`, then you’ll get `None`:
    ```py
    >>> print(print("Hello, World!"))
    Hello, World!
    None
    ```
    > It may look strange, but `print(print("..."))` shows you the None that the inner `print()` returns.
  * > None also often used as a signal for missing or default parameters. For instance, None appears twice in the docs for [list.sort](https://docs.python.org/3/library/stdtypes.html#list.sort):
    ```py
    >>> help(list.sort)
    Help on method_descriptor:

    sort(...)
        L.sort(key=None, reverse=False) -> None -- stable sort *IN PLACE*
    ```
    > Here, `None` is the default value for the key parameter as well as the type hint for the return value. The exact output of `help` can vary from platform to platform. You may get different output when you run this command in your interpreter, but it will be similar.
- > **Using Python’s Null Object `None`**
  * > Often, you’ll use `None` as part of a comparison. One example is when you need to check and see if some result or parameter is `None`. Take the result you get from [re.match](). Did your regular expression match a given string? You’ll see one of two results:
    1. Return a **Match object**: Your regular expression found a match.
    2. Return a **None object**: Your regular expression did not find a match.
    > In the code block below, you’re testing if the pattern "Goodbye" matches a string:
    ```py
    >>> import re
    >>> match = re.match(r"Goodbye", "Hello, World!")
    >>> if match is None:
    ...     print("It doesn't match.")
    It doesn't match.
    ```
    > Here, you use `is None` to test if the pattern matches the string "Hello, World!". This code block demonstrates an important rule to keep in mind when you’re checking for None:
    1. **Do** use the ***identity operators*** `is` and `is not`.
    2. **Do not** use the ***equality operators*** `==` and `!=`.
  * > The ***equality operators*** can be fooled when you’re comparing user-defined objects that override them:
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
    > Here, the ***equality operator*** `==` returns the wrong answer. The ***identity operator*** is, on the other hand, can’t be fooled because you can’t override it.
  * > None is **falsy**, which means `not None` is `True`. If all you want to know is whether a result is falsy, then a test like the following is sufficient:
    ```py
    >>> some_result = None
    >>> if some_result:
    ...     print("Got a result!")
    ... else:
    ...     print("No result.")
    ...
    No result.
    ```
    > The output doesn’t show you that `some_result` is exactly `None`, only that it’s falsy. If you must know whether or not you have a `None` object, then use `is` and `is not`.
  * > The following objects are all falsy as well:
      + Empty lists
      + Empty dictionaries
      + Empty sets
      + Empty strings
      + 0
      + False
    > For more on comparisons, truthy, and falsy values, check out [How to Use the Python `or` Operator](https://realpython.com/python-or-operator/).
    >> How to Use the Python `or` Operator https://realpython.com/python-or-operator/
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
  