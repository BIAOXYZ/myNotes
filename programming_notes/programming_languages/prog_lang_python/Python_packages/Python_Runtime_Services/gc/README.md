
# 官方

gc --- 垃圾回收器接口 https://docs.python.org/zh-cn/3.8/library/gc.html

# 其他

有没有大神能解释一下为什么 Python 循环中无法释放内存 https://www.v2ex.com/t/824267
- > 先 `del` 再 `gc.collect()` 内存就会回收的，内鬼可能是别的对象
- > `del x` 之后用 `gc.is_finalized(x)` 看下是不是 `True`

Python 垃圾回收总结 https://juejin.cn/post/7022474622901682213

Python垃圾回收机制！非常实用 - IT界老黑的文章 - 知乎 https://zhuanlan.zhihu.com/p/83251959

Python进阶：浅析「垃圾回收机制」(上篇) https://hackpython.com/blog/2019/07/05/Python%E8%BF%9B%E9%98%B6%EF%BC%9A%E6%B5%85%E6%9E%90%E3%80%8C%E5%9E%83%E5%9C%BE%E5%9B%9E%E6%94%B6%E6%9C%BA%E5%88%B6%E3%80%8D-%E4%B8%8A%E7%AF%87/

Python进阶：浅析「垃圾回收机制」(下篇) https://hackpython.com/blog/2019/07/18/Python%E8%BF%9B%E9%98%B6%EF%BC%9A%E6%B5%85%E6%9E%90%E3%80%8C%E5%9E%83%E5%9C%BE%E5%9B%9E%E6%94%B6%E6%9C%BA%E5%88%B6%E3%80%8D-%E4%B8%8B%E7%AF%87/
