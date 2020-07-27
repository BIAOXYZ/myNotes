
# 官方

functools --- 高阶函数和可调用对象上的操作 https://docs.python.org/zh-cn/3/library/functools.html || functools — Higher-order functions and operations on callable objects https://docs.python.org/3/library/functools.html

# 其他

## `lru_cache()`

`329. 矩阵中的最长递增路径` -- `方法一：记忆化深度优先搜索` https://leetcode-cn.com/problems/longest-increasing-path-in-a-matrix/solution/ju-zhen-zhong-de-zui-chang-di-zeng-lu-jing-by-le-2/

Every Python Programmer Should Know LRU_cache From the Standard Library https://medium.com/better-programming/every-python-programmer-should-know-lru-cache-from-the-standard-library-8e6c20c6bc49
  
How does Lru_cache (from functools) Work? https://stackoverflow.com/questions/49883177/how-does-lru-cache-from-functools-work
  
Python 缓存机制与 functools.lru_cache http://kuanghy.github.io/2016/04/20/python-cache
```py3
from functools import lru_cache

@lru_cache(None)
def add(x, y):
    print("calculating: %s + %s" % (x, y))
    return x + y

print(add(1, 2))
print(add(1, 2))
print(add(2, 3))
--------------------------------------------------
calculating: 1 + 2
3
3
calculating: 2 + 3
5
```
- > 从结果可以看出，当第二次调用 add(1, 2) 时，并没有真正执行函数体，而是直接返回缓存的结果。
- > 如果要在 Python 2 中使用 lru_cahce 需要安装第三方模块 `functools32`。还有一个用 C 语言实现的，更快的，同时兼容 Python2 和 Python3 的第三方模块 `fastcache` 能够实现同样的功能，且其能支持 TTL。
- > 此外，还有一些其他的缓存模块，如 `cachelib`, `cacheout` 等等，实际使用需要时可以按需求去选择合适的缓存实现。
  
【[:star:][`*`]】 functools.lru_cache装饰器详解 https://blog.csdn.net/u012745215/article/details/78506022

Python Functools – lru_cache() https://www.geeksforgeeks.org/python-functools-lru_cache/
