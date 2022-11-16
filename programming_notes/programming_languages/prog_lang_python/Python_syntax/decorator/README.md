
# `@`装饰器

`7. Decorators` https://book.pythontips.com/en/latest/decorators.html || https://github.com/yasoob/intermediatePython/blob/master/decorators.rst

Python 函数装饰器 https://www.runoob.com/w3cnote/python-func-decorators.html

12步教你理解Python装饰器 https://foofish.net/python-decorator-12.html

python @property的用法及含义全面解析 https://www.jb51.net/article/134148.htm

Python中的注解“@” https://www.jianshu.com/p/7a644520418b
- > Python3.0之后加入新特性Decorators，以`@`为标记修饰function和class。有点类似c++的宏和java的注解。Decorators用以修饰约束function和class，分为带参数和不带参数，影响原有输出，例如类静态函数我们要表达的时候需要函数前面加上修饰 `@staticmethod` 或 `@classmethod`,为什么这样做呢？下面用简单的例子来看一下，具体内容可以查看：[官方解释](https://www.python.org/dev/peps/pep-0318/)
- > **带参数的单次使用**
  ```py
  def attrs(**kwds):
      def decorate(f):
          for k in kwds:
              setattr(f, k, kwds[k])
          return f
      return decorate
  
  @attrs(versionadded="2.2",
         author="Guido van Rossum")
  def mymethod(f):
      print(getattr(mymethod,'versionadded',0))
      print(getattr(mymethod,'author',0))
      print(f)
       
  if __name__ == "__main__"
  mymethod(2) 
  ```
  > 运行结果
  ```console
  2.2
  Guido van Rossum
  2
  ```
  >> //notes：这个例子除了`装饰器`外，还包含了很多要素：`**kwds` 无限制字典类参数；`setattr` 对于对象没有的属性，只要这个object实现了 `__dict__` 方法就可以新添加；`getattr` 的使用。

第九章：元编程 https://python3-cookbook.readthedocs.io/zh_CN/latest/chapters/p09_meta_programming.html

10 Fabulous Python Decorators https://towardsdatascience.com/10-fabulous-python-decorators-ab674a732871

装饰器 https://www.liaoxuefeng.com/wiki/1016959663602400/1017451662295584
- 回复里的：
  * > 装饰器实现计时器
    ```py
    import time
    import functools

    def metric(func):
        @functools.wraps(func)
        def count_time(*args,**kwargs):
           start =  time.time()
           x = func(*args,**kwargs)
           end = time.time()
           print("函数%s运行总用时为：%d"%(func.__name__,end - start))
           return x
        return count_time
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `@property`

Python @property decorator https://www.programiz.com/python-programming/property

Python - @property 方法变属性 https://segmentfault.com/a/1190000017078783  -->  和廖雪峰这篇重合很多，但是也不完全一样，可以结合着看：[《使用@property》](https://www.liaoxuefeng.com/wiki/1016959663602400/1017502538658208)
- > `@property` 是内置的装饰器，与普通装饰器原理是一样的，只不过返回的不是函数，而是类对象.
- > `@property` 负责把一个方法变成属性进行调用，保证对参数进行必要的检查。
- > 属性有三个装饰器：`setter`、`getter`、`deleter`。当属性只有 `getter` 方法，则为只有只读属性。否则为可读写属性。

使用@property https://www.liaoxuefeng.com/wiki/1016959663602400/1017502538658208
- > Python内置的 `@property` 装饰器就是负责把一个方法变成属性调用的：
  ```py
  class Student(object):
  
      @property
      def score(self):
          return self._score
  
      @score.setter
      def score(self, value):
          if not isinstance(value, int):
              raise ValueError('score must be an integer!')
          if value < 0 or value > 100:
              raise ValueError('score must between 0 ~ 100!')
          self._score = value
  ```
  > `@property` 的实现比较复杂，我们先考察如何使用。把一个 `getter` 方法变成属性，只需要加上 `@property` 就可以了，此时，`@property` 本身又创建了另一个装饰器 `@score.setter`，负责把一个 `setter` 方法变成属性赋值，于是，我们就拥有一个可控的属性操作：
  ```py
  >>> s = Student()
  >>> s.score = 60 # OK，实际转化为s.set_score(60)
  >>> s.score # OK，实际转化为s.get_score()
  60
  >>> s.score = 9999
  Traceback (most recent call last):
    ...
  ValueError: score must between 0 ~ 100!
  ```
- > 还可以定义只读属性，只定义 `getter` 方法，不定义 `setter` 方法就是一个只读属性：
- > 要特别注意：属性的方法名不要和实例变量重名。例如，以下的代码是错误的：
  ```py
  class Student(object):
  
      # 方法名称和实例变量均为birth:
      @property
      def birth(self):
          return self.birth
  ```
  > 这是因为调用 `s.birth` 时，首先转换为方法调用，在执行 `return self.birth` 时，又视为访问 `self` 的属性，于是又转换为方法调用，造成无限递归，最终导致栈溢出报错 `RecursionError`。
- > **小结**
  * > `@property` 广泛应用在类的定义中，可以让调用者写出简短的代码，同时保证对参数进行必要的检查，这样，程序运行时就减少了出错的可能性。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `@wraps()`
>> //notes：实际上这个装饰器的完整写法是 `@functools.wraps()`，其属于 `functools` 模块，故参见该模块吧。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `@memoize`

python @memoize vs functools.lru_cache https://stackoverflow.com/questions/46022556/python-memoize-vs-functools-lru-cache
```console
I'm not sure what the advantages and disadvantages of these 2 are. Provided @lru_cache from functools is a standard library tool
and seems to have more control over @memoize, why does @memoize even exist?

Edit: I am referring to memoize from here -> https://wiki.python.org/moin/PythonDecoratorLibrary#Memoize
```
- https://stackoverflow.com/questions/46022556/python-memoize-vs-functools-lru-cache/46022684#46022684
  * > `functools.lru_cache` was added in python 3.2. For those using python 2, and for libraries written to work with it (e.g. all major libs) it cannot be used.
  * > The workaround is to use the `@memoize` recipe from the decorator library.
  * > If you only use python 3, there is basically no reason not to use `lru_cache`.
  * 该回答下面的评论：
    + > `lru_cache` can be used in 2.7 with [functools32](https://pypi.org/project/functools32/) – johanno

PythonDecoratorLibrary https://wiki.python.org/moin/PythonDecoratorLibrary  【`看这个网页是官方的，但是我还是不知道这个装饰器是不是默认就支持的`】
- https://wiki.python.org/moin/PythonDecoratorLibrary#Memoize

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
