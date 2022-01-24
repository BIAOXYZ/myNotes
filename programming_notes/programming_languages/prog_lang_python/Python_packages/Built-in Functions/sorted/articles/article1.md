
# 1

Python应用——自定义排序全套方案 - 承志的文章 - 知乎 https://zhuanlan.zhihu.com/p/108949863
```py
# 个人实战1
from functools import cmp_to_key

def cmp(kid1, kid2):
    if kid1.score == kid2.score:
        return kid1.age < kid2.age
    else:
        return kid1.score > kid2.score

class Kid:
    def __init__(self, name, score, age):
        self.name = name
        self.score = score
        self.age = age
    def __repr__(self):
        return 'Kid, name: {}, score: {}, age:{}'.format(self.name, self.score, self.age)

kids = [Kid('xiaoming', 99, 12), Kid('xiaohong', 75, 13), Kid('xiaowang', 88, 15)]
res = sorted(kids, key=cmp_to_key(cmp))
print(res)
##################################################
[Kid, name: xiaoming, score: 99, age:12, Kid, name: xiaohong, score: 75, age:13, Kid, name: xiaowang, score: 88, age:15]
```

# 2

How to sort a list of lists using a custom compare function in Python https://www.kite.com/python/answers/how-to-sort-a-list-of-lists-using-a-custom-compare-function-in-python
```py
# 个人实战（因为文章里的列表数据不太好）
# 这个例子主要是想和上面的那篇对比下：因为有的时候自定义的比较函数就一个参数，有的时候又是两个参数。
lst = [[1, 3], [4, 20], [4, 10], [5, 3]]
print(sorted(lst))

print(sorted(lst, key= lambda x: x[0] + x[1]))

def sorting_func(lst):
    return lst[0] + lst[1]
print(sorted(lst, key = sorting_func))
##################################################
[[1, 3], [4, 10], [4, 20], [5, 3]]
[[1, 3], [5, 3], [4, 10], [4, 20]]
[[1, 3], [5, 3], [4, 10], [4, 20]]
```
