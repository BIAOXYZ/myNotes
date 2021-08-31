
# 官方

functools --- 高阶函数和可调用对象上的操作 https://docs.python.org/zh-cn/3/library/functools.html || functools — Higher-order functions and operations on callable objects https://docs.python.org/3/library/functools.html
- > `@functools.cache(user_function)`
  * > Simple lightweight unbounded function cache. Sometimes called “memoize”. <br> Returns the same as `lru_cache(maxsize=None)`, creating a thin wrapper around a dictionary lookup for the function arguments. Because it never needs to evict old values, this is smaller and faster than `lru_cache()` with a size limit.
  * > 简单轻量级未绑定函数缓存。有时称为 "memoize"。 <br> 返回值与 `lru_cache(maxsize=None)` 相同，创建一个查找函数参数的字典的简单包装器。因为它不需要移出旧值，所以比带有大小限制的 `lru_cache()` 更小更快。
- > `@functools.lru_cache(user_function)` <br> `@functools.lru_cache(maxsize=128, typed=False)`
  * > 一个为函数提供缓存功能的装饰器，缓存 `maxsize` 组传入参数，在下次以相同参数调用时直接返回上一次的结果。用以节约高开销或I/O函数的调用时间。 <br> 由于使用了字典存储缓存，所以该函数的固定参数和关键字参数必须是可哈希的。 <br> 不同模式的参数可能被视为不同从而产生多个缓存项，例如, `f(a=1, b=2)` 和 `f(b=2, a=1)` 因其参数顺序不同，可能会被缓存两次。 <br> 如果指定了 `user_function`，它必须是一个可调用对象。 这允许 `lru_cache` 装饰器被直接应用于一个用户自定义函数，让 `maxsize` 保持其默认值 `128`:
    ```py
    @lru_cache
    def count_vowels(sentence):
        sentence = sentence.casefold()
        return sum(sentence.count(vowel) for vowel in 'aeiou')
    ```
  * > 如果 `maxsize` 设为 `None`，LRU 特性将被禁用且缓存可无限增长。
  * > 如果 `typed` 设置为 `true`，不同类型的函数参数将被分别缓存。例如， `f(3)` 和 `f(3.0)` 将被视为不同而分别缓存。
  * > 被包装的函数配有一个 `cache_parameters()` 函数，该函数返回一个新的 dict 用来显示 maxsize 和 typed 的值。 这只是出于显示信息的目的。 改变值没有任何效果。
  * > 为了衡量缓存的有效性以便调整 `maxsize` 形参，被装饰的函数带有一个 `cache_info()` 函数。当调用 `cache_info()` 函数时，返回一个具名元组，包含命中次数 hits，未命中次数 misses ，最大缓存数量 maxsize 和 当前缓存大小 currsize。在多线程环境中，命中数与未命中数是不完全准确的。
  * > 该装饰器也提供了一个用于清理/使缓存失效的函数 `cache_clear()`。

# 其他

## `lru_cache()`

### LeetCode中用到这个的（至少目前全是HARD。。。）：
- `312. 戳气球` https://leetcode-cn.com/problems/burst-balloons/solution/chuo-qi-qiu-by-leetcode-solution/
- `329. 矩阵中的最长递增路径` -- `方法一：记忆化深度优先搜索` https://leetcode-cn.com/problems/longest-increasing-path-in-a-matrix/solution/ju-zhen-zhong-de-zui-chang-di-zeng-lu-jing-by-le-2/
- `140. 单词拆分 II` https://leetcode-cn.com/problems/word-break-ii/solution/dan-ci-chai-fen-ii-by-leetcode-solution/

Caching in Python Using the LRU Cache Strategy https://realpython.com/lru-cache-python/

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

## `cache`

### LeetCode中用到这个的
- `131. 分割回文串` https://leetcode-cn.com/problems/palindrome-partitioning/

## `partial()`

彻底明白 Python partial() - Demon的文章 - 知乎 https://zhuanlan.zhihu.com/p/47124891

## `cmp_to_key()`

排序指南 https://docs.python.org/zh-cn/3/howto/sorting.html || Sorting HOW TO https://docs.python.org/3/howto/sorting.html
- > In Python 3.2, the [functools.cmp_to_key()]() function was added to the [functools]() module in the standard library.
