
# Counter

Counters in Python | Set 1 (Initialization and Updation) https://www.geeksforgeeks.org/counters-in-python-set-1/

Python | Counter Objects | elements() https://www.geeksforgeeks.org/python-counter-objects-elements/

Counter https://pymotw.com/2/collections/counter.html

Python Counter in Collections with Example https://www.guru99.com/python-counter-collections-example.html

详解Python计数的Counter类 - 触摸壹缕阳光的文章 - 知乎 https://zhuanlan.zhihu.com/p/355601478
- > **2.1 Counter 特有的方法**
  * > `Counter` 额外支持字典中没有的三个方法：`elements()`、`most_common([m])` 以及 `subtract([iterable-or-mapping])`。

# 个人实战

## 1. Counter加减

```py
>>> from collections import Counter
>>> x = 'aabc'
>>> y = 'aaab'
>>> xx = Counter(x)
>>> yy = Counter(y)
>>> xx
Counter({'a': 2, 'b': 1, 'c': 1})
>>> yy
Counter({'a': 3, 'b': 1})
>>>
>>> xx - yy
Counter({'c': 1})
>>>
>>> yy - xx
Counter({'a': 1})
>>>
>>> xx.subtract(yy)
>>> xx
Counter({'c': 1, 'b': 0, 'a': -1})
>>>
```

```py
# 如何能不改变原来计数器的情况下（用 substract 会改变原来计数器），减出来负数，并且同时省略或者不省略0。

from collections import Counter
x = 'aabc'
y = 'aaabd'
xx = Counter(x)
yy = Counter(y)
print(xx, yy)

print("The joint key set is: ", xx.keys() | yy.keys())

res = {k:xx[k]-yy[k] for k in xx.keys() | yy.keys()}
print(res, Counter(res))

res2 = {k:xx[k]-yy[k] for k in xx.keys() | yy.keys() if xx[k] != yy[k]}
print(res2, Counter(res2))
##################################################
Counter({'a': 2, 'b': 1, 'c': 1}) Counter({'a': 3, 'b': 1, 'd': 1})
The joint key set is:  {'b', 'a', 'd', 'c'}
{'b': 0, 'a': -1, 'd': -1, 'c': 1} Counter({'c': 1, 'b': 0, 'a': -1, 'd': -1})
{'a': -1, 'd': -1, 'c': 1} Counter({'c': 1, 'a': -1, 'd': -1})
```

## 2. Counter里没有的 key 也可以直接用，值是 0

```py
>>> from collections import Counter as cc
>>> l = [2,4,6,12]
>>> ctr = cc(l)
>>> ctr
Counter({2: 1, 4: 1, 6: 1, 12: 1})
>>> 
>>> ctr[2]
1
>>> ctr[8]
0
>>> 
```

# LeetCode相关题目
- `383. 赎金信` https://leetcode-cn.com/problems/ransom-note/  【用到了两个Counter对象直接相减】
- `954. 二倍数对数组` https://leetcode-cn.com/problems/array-of-doubled-pairs/  【即使没有显式指定 ctr 里的 key，也可以直接用 `ctr[key]`，其值为 0】
- `676. 实现一个魔法字典` https://leetcode.cn/problems/implement-magic-dictionary/
