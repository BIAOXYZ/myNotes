
# 官方

gc --- 垃圾回收器接口 https://docs.python.org/zh-cn/3.8/library/gc.html

# 其他

有没有大神能解释一下为什么 Python 循环中无法释放内存 https://www.v2ex.com/t/824267
- > 先 `del` 再 `gc.collect()` 内存就会回收的，内鬼可能是别的对象
- > `del x` 之后用 `gc.is_finalized(x)` 看下是不是 `True`
