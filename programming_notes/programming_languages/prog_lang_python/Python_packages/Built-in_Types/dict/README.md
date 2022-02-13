
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
