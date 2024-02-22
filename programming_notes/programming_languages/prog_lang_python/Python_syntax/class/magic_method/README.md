
Python 魔术方法指南 https://pycoders-weekly-chinese.readthedocs.io/en/latest/issue6/a-guide-to-pythons-magic-methods.html

介绍Python的魔术方法 - Magic Method https://segmentfault.com/a/1190000007256392

Python常用魔术方法 - 程序员吾非同的文章 - 知乎 https://zhuanlan.zhihu.com/p/329962624

Using Magic Methods in Python https://towardsdatascience.com/using-magic-methods-in-python-48f31685bc18

Python 的魔术方法 https://old-panda.com/2018/12/16/python-magic-methods/
- > 在[上一篇文章](https://old-panda.com/2018/12/09/my-python-dict/)中实现了一个非常简陋的 MyDict 类，仅仅可以 get 、set ，其他的各种功能都没有，甚至连在 Python shell 中正常的表示都做不到。这篇文章将会继续完善这个字典类，并同时简单介绍用到的 Python 魔术方法。
  >> 不用 Python 自带的 Dict 实现自己的 HashTable https://old-panda.com/2018/12/09/my-python-dict/  -->  [`LC706. 设计哈希映射`](https://leetcode-cn.com/problems/)design-hashmap/

A Guide to Python's Magic Methods https://rszalski.github.io/magicmethods/
- > A PDF version of this guide can be obtained from [my site](http://www.rafekettler.com/magicmethods.pdf) or [Github](https://github.com/RafeKettler/magicmethods/raw/master/magicmethods.pdf). The magic methods guide has a git repository at http://www.github.com/RafeKettler/magicmethods. Any issues can be reported there, along with comments, (or even contributions!).

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `__del__()`

Python面向对象程序设计中对象析构方法的调用时机 https://mp.weixin.qq.com/s/AF7fk5PUg696o_MmbMuZLg
- > 在命令提示符环境、PyCharm或类似环境中，是以独立进程的方式运行程序的，程序运行完的适合进程也就结束了，这时候会释放进程中所有资源，包括自己创建的所有对象，所以析构方法被调用。但在IDLE环境中，IDLE为主线程，自己的程序运行结束后IDLE主线程尚未结束，创建的对象不会自动删除，除非自己显式使用del关键字删除对象。

Python魔法方法漫游指南：构造与析构 https://mp.weixin.qq.com/s/V3i35oL4Ve0Z-7e0RZYNJA

关于使用 Python 析构函数的正确姿势 https://mp.weixin.qq.com/s/2p61386F_TkS6Dh2KOCm2w || https://www.infoq.cn/article/osyi8uidzioy2934uzce
- > **4 解决方案**
  * > 首先，我们可以使用 close() 方法来代替析构函数，但是这类方法并不是绝对安全的，不光是因为它们很容易在编码时忘记去正确调用改方法，而且当程序需要抛出异常时，显式调用 close() 方法就会变得非常麻烦。

I don't understand this python `__del__` behaviour https://stackoverflow.com/questions/6104535/i-dont-understand-this-python-del-behaviour

Why isn't the `__del__` method called？ https://stackoverflow.com/questions/46957542/why-isnt-the-del-method-called
- https://stackoverflow.com/questions/46957542/why-isnt-the-del-method-called/46966357#46966357

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `__getattr__` v.s. `__getattribute__`

Understanding the difference between `__getattr__` and `__getattribute__` https://stackoverflow.com/questions/4295678/understanding-the-difference-between-getattr-and-getattribute

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `__new__()`

python的__new__方法 https://www.jianshu.com/p/08d7956601de

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `__repr__()`

一文让你彻底搞懂Python中`__str__`和`__repr__`? https://segmentfault.com/a/1190000022266368

How To Use the `__str__()` and `__repr__()` Methods in Python https://www.digitalocean.com/community/tutorials/python-str-repr-functions

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `__setattr__()`

使用`__setattr__()`方法魔改python https://blog.csdn.net/znevegiveup1/article/details/115478114

How to use `__setattr__` correctly, avoiding infinite recursion https://stackoverflow.com/questions/17020115/how-to-use-setattr-correctly-avoiding-infinite-recursion

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
