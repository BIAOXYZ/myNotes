
# 官方

copy — Shallow and deep copy operations https://docs.python.org/3.8/library/copy.html || copy --- 浅层 (shallow) 和深层 (deep) 复制操作 https://docs.python.org/zh-cn/3/library/copy.html

8.17. copy — Shallow and deep copy operations https://docs.python.org/2.7/library/copy.html || 8.17. copy — 浅层 (shallow) 和深层 (deep) 复制操作 https://docs.python.org/zh-cn/2.7/library/copy.html

cpython/Lib/copy.py https://github.com/python/cpython/blob/3.8/Lib/copy.py

# 其他

Python 直接赋值、浅拷贝和深度拷贝解析 https://www.runoob.com/w3cnote/python-understanding-dict-copy-shallow-or-deep.html

Python---copy()、deepcopy()与赋值的区别 https://blog.csdn.net/u011630575/article/details/78604226
- > **python的数据存储方式**
  * > 当在 Python 中 a = something 应该理解为给 something 贴上了一个标签 a。当再赋值给 a 的时候，就好象把 a 这个标签从原来的 something 上拿下来，贴到其他对象上，建立新的 reference。 这就解释了一些 Python 中可能遇到的诡异情况：
