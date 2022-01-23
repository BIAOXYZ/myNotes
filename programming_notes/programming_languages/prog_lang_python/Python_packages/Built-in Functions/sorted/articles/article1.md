
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
