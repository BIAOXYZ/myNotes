
Python 有哪些好玩的语法糖？ - 知乎 https://www.zhihu.com/question/57470958
- Python 有哪些好玩的语法糖？ - 路人甲的回答 - 知乎 https://www.zhihu.com/question/57470958/answer/153632413
  * > for/while 循环与 else 语句块搭配，当循环（for/while循环语句冒号后面的语句块）正常结束的时候才会执行一遍else语句块；如果是非正常结束的（例如break语句跳出，出现异常等情况），则不会执行else语句块。
    ```py
    for i in [1,1,2]:
        if i == 0:
            break
    else: print("i was never 0")
    ```
    ```console
    i was never 0
    ```
  * > 第三条的具体执行逻辑可以看一下这里（图片来自：[Python中else语句块（和if、while、for、try搭配使用） - 目标120 - 博客园](http://www.cnblogs.com/zyq-blog/p/5590816.html)） <br> ![](https://pic1.zhimg.com/80/v2-4c35e17e33de2b96a2bc098572a1985d_1440w.jpg?source=1940ef5c)

# `return self`

Purpose of return self python https://stackoverflow.com/questions/43380042/purpose-of-return-self-python/43380360
- https://stackoverflow.com/questions/43380042/purpose-of-return-self-python/43380360#43380360
  * > Returning `self` from a method simply means that your method returns a reference to the instance object on which it was called. This can sometimes be seen in use with object oriented APIs that are designed as a [fluent interface](https://en.wikipedia.org/wiki/Fluent_interface) that encourages [method cascading](https://en.wikipedia.org/wiki/Method_cascading). So, for example,
    ```py
    >>> class Counter(object):
    ...     def __init__(self, start=1):
    ...         self.val = start
    ...     def increment(self):
    ...         self.val += 1
    ...         return self
    ...     def decrement(self):
    ...         self.val -= 1
    ...         return self
    ...
    >>> c = Counter()
    ```
  * > Now we can use method cascading:
    ```py
    >>> c.increment().increment().decrement()
    <__main__.Counter object at 0x1020c1390>
    ```
  * > Notice, the last call to `decrement()` returned `<__main__.Counter object at 0x1020c1390>`, which is `self`. Now:
    ```py
    >>> c.val
    2
    >>>
    ```
  * > Notice, you cannot do this if you did not return `self`:
    ```py
    >>> class Counter(object):
    ...     def __init__(self, start=1):
    ...         self.val = start
    ...     def increment(self):
    ...         self.val += 1
    ...         # implicitely return `None`
    ...     def decrement(self):
    ...         self.val -= 1
    ...         # implicitely return `None`
    ...
    >>> c = Counter()
    >>> c.increment().increment()
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    AttributeError: 'NoneType' object has no attribute 'increment'
    >>> c
    <__main__.Counter object at 0x1020c15f8>
    >>> c.val
    2
    >>>
    ```
  * > Notice, not everyone is a fan of "method cascading" design. Python built-ins do not tend do this, so, `list` for example:
    ```py
    >>> x = list()
    >>> x.append(1).append(2)
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    AttributeError: 'NoneType' object has no attribute 'append'
    >>>
    ```

Python的return self和return一个新的对象区别 https://www.cnblogs.com/HongjianChen/p/9609333.html

Python中return self的用法 https://www.jianshu.com/p/2291f7e36f6a || https://blog.csdn.net/jclian91/article/details/81238782
