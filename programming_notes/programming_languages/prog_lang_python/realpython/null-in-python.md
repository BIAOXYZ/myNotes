
Null in Python: Understanding Python's NoneType Object https://realpython.com/null-in-python/
- > If you have experience with other programming languages, like C or Java, then you’ve probably heard of the concept of `null`. Many languages use this to ***represent a pointer that doesn’t point to anything***, to ***denote when a variable is empty***, or to ***mark default parameters that you haven’t yet supplied***. `null` is often defined to be `0` in those languages, but `null` in Python is different.
- > Python uses the keyword `None` to define `null` objects and variables. While `None` does serve some of the same purposes as `null` in other languages, it’s another beast entirely. As the `null` in Python, `None is` not defined to be `0` or any other value. In Python, ***`None` is an object and a first-class citizen***!
- > **Understanding Null in Python**
  * > None is the value a function returns when there is no return statement in the function:
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
