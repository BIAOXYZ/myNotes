
Python优雅的合并两个Dict https://segmentfault.com/a/1190000010567015

Python Dictionary fromkeys() https://www.programiz.com/python-programming/methods/dictionary/fromkeys

# 获取某个value对应的key

```py
# 根据字典中的val获取相应的key -- 周赛191
def getKey(dic, val):
    return [k for k, v in dic.items() if v == val]
```

## 获取字典中最大值对应的key

```py
dic = {'a':1,'b':2,"c":3,"d":4}
ans1 = max(dic, key = lambda x : dic[x])
print("ans1 =", ans1)
ans2 = max(dic, key = dic.get)
print("ans2 =", ans2)
ans3 = max(zip(dic.values(), dic.keys()))
print("ans3 =", ans3)
##################################################
ans1 = d
ans2 = d
ans3 = (4, 'd')
```

# 问题

## python字典是否线程安全？

Thread Safety in Python's dictionary https://stackoverflow.com/questions/6953351/thread-safety-in-pythons-dictionary

Python 中那些数据类型是基于线程安全的？ https://www.v2ex.com/t/441411
- > 线程安全的是因为针对某一数据结构的所有操作都是线程安全的。所以 `list dict str int` 都不是线程安全的。但是有些数据结构的某些操作确实是安全的，比如 `list.pop()`
- > 线程 AB 同时操作 list
  ```py
  list 的[0]初始值为 0

  线程 A 操作 100 次
  list[0]+=1
  线程 B 操作 100 次
  list[0]+=1
  ```
  > so …… GG
- > 是不是安全的只要的用 dis 模块看一下字节码就明白了。字节码的每一行就是一个原子操作，多线程切换就是原子操作为单位的，只要一个操作需两行字节码的就不是线程安全的。
  >> //notes：这个回答有点绝对，应该不是只要涉及两行字节码就不是线程安全的，而是还要看字节码是什么指令，参考下面篇：[通俗易懂：说说 Python 里的线程安全、原子操作](https://segmentfault.com/a/1190000022644337)
- > 1、list 自己是线程安全的，所以 `list.pop()`，`list.append()`，`len(list)` 等都是线程安全的； <br> 2、list 里面的数据不一定是线程安全的，比如 `list[0] += 1` 就不是线程安全的，这是因为 `v += 1` 本身就不是原子的，这和 `list` 无关，反之如果 `v += 1` 是原子的，那么 `list[0] += 1` 也是线程安全的；
  >> `dict` 也是一样的，`dict` 的 `pop`，`add` 等操作都是线程安全的，这和 go 里面的 `map` 不一样
