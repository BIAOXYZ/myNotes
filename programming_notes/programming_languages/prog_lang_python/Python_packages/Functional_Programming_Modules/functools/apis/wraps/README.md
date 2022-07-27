
# `@functools.wraps()` 官方

`@functools.wraps(wrapped, assigned=WRAPPER_ASSIGNMENTS, updated=WRAPPER_UPDATES)` https://docs.python.org/zh-cn/3/library/functools.html#functools.wraps
- > 这是一个便捷函数，用于在定义包装器函数时发起调用 [update_wrapper()](https://docs.python.org/zh-cn/3/library/functools.html#functools.update_wrapper) 作为函数装饰器。 它等价于 `partial(update_wrapper, wrapped=wrapped, assigned=assigned, updated=updated)`。例如:
  ```py
  >>> from functools import wraps
  >>> def my_decorator(f):
  ...     @wraps(f)
  ...     def wrapper(*args, **kwds):
  ...         print('Calling decorated function')
  ...         return f(*args, **kwds)
  ...     return wrapper
  ...
  >>> @my_decorator
  ... def example():
  ...     """Docstring"""
  ...     print('Called example function')
  ...
  >>> example()
  Calling decorated function
  Called example function
  >>> example.__name__
  'example'
  >>> example.__doc__
  'Docstring'
  ```
  > 如果不使用这个装饰器工厂函数，则 `example 函数`的名称将变为 `'wrapper'`，并且 `example()` 原本的文档字符串将会丢失。

## 个人实战下官方例子

- 不加 `@wraps` 时，因为已经是一个新函数了，所以 `__name__` 和 `__doc__` 都变了：
```py
from functools import wraps
def my_decorator(f):
    #@wraps(f)
    def wrapper(*args, **kwds):
        print('Calling decorated function')
        return f(*args, **kwds)
    return wrapper

@my_decorator
def example():
    """Docstring"""
    print('Called example function')

example()
print(example.__name__)
print(example.__doc__)
##################################################
Calling decorated function
Called example function
wrapper
None
```
- 加上 `@wraps` 后，可以避免这个问题，打印出的还是原来 `example` 函数的：
```py
from functools import wraps
def my_decorator(f):
    #@wraps(f)
    def wrapper(*args, **kwds):
        print('Calling decorated function')
        return f(*args, **kwds)
    return wrapper

@my_decorator
def example():
    """Docstring"""
    print('Called example function')

example()
print(example.__name__)
print(example.__doc__)
##################################################
Calling decorated function
Called example function
example
Docstring
```
>> //notes：所以个人感觉自己写装饰器的时候一般应该都加上这个。

# `@functools.wraps()` 其他

Python | functools.wraps() function https://www.geeksforgeeks.org/python-functools-wraps-function/

python装饰器的wraps作用 https://blog.csdn.net/hqzxsc2006/article/details/50337865 || https://www.jianshu.com/p/a76f1409c349
- > Python装饰器（`decorator`）在实现的时候，***被装饰后的函数其实已经是另外一个函数了***（***`函数名`等函数属性会发生改变***），为了不影响，Python的 `functools` 包中提供了一个叫 `wraps` 的`decorator` 来消除这样的副作用。写一个 `decorator` 的时候，最好在实现之前加上 `functools` 的 `wraps`，***它能保留原有函数的名称和docstring***。
  >> //notes：直接从官方例子就能完全说明问题了。

简单聊聊Python中的wraps修饰器 https://segmentfault.com/a/1190000009398663
- > 至此，我想大家应该明白 `wraps` 这个修饰器的作用了吧，就是将 **被修饰的函数(wrapped)** 的一些属性值赋值给 **修饰器函数(wrapper)**，最终让属性的显示更符合我们的直觉。

Python functools.wraps 深入理解 - 姜小白的文章 - 知乎 https://zhuanlan.zhihu.com/p/45535784
