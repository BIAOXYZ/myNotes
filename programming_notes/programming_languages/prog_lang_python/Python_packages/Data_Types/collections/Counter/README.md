
# Counter

Counters in Python | Set 1 (Initialization and Updation) https://www.geeksforgeeks.org/counters-in-python-set-1/

Python | Counter Objects | elements() https://www.geeksforgeeks.org/python-counter-objects-elements/

Counter https://pymotw.com/2/collections/counter.html

Python Counter in Collections with Example https://www.guru99.com/python-counter-collections-example.html

详解Python计数的Counter类 - 触摸壹缕阳光的文章 - 知乎 https://zhuanlan.zhihu.com/p/355601478
- > **2.1 Counter 特有的方法**
  * > `Counter` 额外支持字典中没有的三个方法：`elements()`、`most_common([m])` 以及 `subtract([iterable-or-mapping])`。

# 个人实战

## 1

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

# LeetCode相关题目
- `383. 赎金信` https://leetcode-cn.com/problems/ransom-note/  【用到了两个Counter对象直接相减】
