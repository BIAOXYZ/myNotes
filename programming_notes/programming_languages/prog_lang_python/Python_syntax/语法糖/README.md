
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

# 单行的三重（甚至是多重）if表达式

翻译 python：能否把 if-elif-else写成一行的形式？ https://blog.csdn.net/htuhxf/article/details/79954828
```py
>>> i=100
>>> a = 1 if i<100 else 2 if i>100 else 0
>>> a
0
>>> i=101
>>> a = 1 if i<100 else 2 if i>100 else 0
>>> a
2
>>> i=99
>>> a = 1 if i<100 else 2 if i>100 else 0
>>> a
1
```

Python如何一行写完if elif else列表推导式 https://www.jianshu.com/p/654c49562619
- > Python中的if elif else结构通常如下：
  ```py
  if cond1:
      a=1
  elif cond2:
      a=2
  else:
      a=3
  ```
- > 在特殊情况下，我们可能希望把这个条件语句写成一行，如（列表推导式中）。结论就是，将上述结构改为：
  ```console
  非列表：    结果甲 if 条件甲 else 结果乙 if 条件乙 else 结果丙
  列表推导式：    [结果甲 if 条件甲 else 结果乙 if 条件乙 else 结果丙 for xx in list]
  列表推导式筛选包含某个值的数据：    [结果甲 for xx in list if 条件甲]
  ```

LeetCode相关题目：
- `521. 最长特殊序列 Ⅰ` https://leetcode-cn.com/problems/longest-uncommon-subsequence-i/
  * https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/401-600/000521/README.md#%E8%AF%AD%E6%B3%95%E7%82%B9%E5%8D%95%E8%A1%8C%E7%9A%84%E4%B8%89%E9%87%8D%E7%94%9A%E8%87%B3%E6%98%AF%E5%A4%9A%E9%87%8Dif%E8%A1%A8%E8%BE%BE%E5%BC%8F
