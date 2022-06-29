
# Python列表推导式在二维数组情形下的易错点/诡异行为

https://www.nowcoder.com/test/question/done?tid=51055197&qid=2225429
- > 执行以下程序，输出结果为（）
  ```py
  a = [['1','2'] for i in range(2)]
  b = [['1','2']]*2
  a[0][1] = '3'
  b[0][0] = '4'
  print(a,b) 
  ```
  ```console
  [['1', '3'], ['1', '2']] [['4', '2'], ['4', '2']]
  ```
  >> //notes：记得之前在 LeetCode （双）周赛碰到过一道题，当时发现原来二维的情形下两种初始化方法后面改变值的影响不一样。。。在上面代码的基础上 `print` 一下 `id` 的相等关系就能验证了：
  ```py
  print(id(a[0]) == id(a[1]))  # False
  print(id(b[0]) == id(b[1]))  # True
  ```
  >> //notes：虽然能通过 `id` 看出来进一步的现象了，但是还不知道原因，记个 ~~`TODO`~~ 吧。

原因参见下面几个帖子：
- Python创建二维数组(关于list的一个小坑)  https://www.cnblogs.com/PyLearn/p/7795552.html
- 2D list has weird behavor when trying to modify a single value [duplicate] https://stackoverflow.com/questions/2739552/2d-list-has-weird-behavor-when-trying-to-modify-a-single-value
- List of lists changes reflected across sublists unexpectedly https://stackoverflow.com/questions/240178/list-of-lists-changes-reflected-across-sublists-unexpectedly
  * > https://stackoverflow.com/questions/240178/list-of-lists-changes-reflected-across-sublists-unexpectedly/240205#240205
>> //notes：但是对于1维的情形，实际上最后一个链接的回答里有些争论，但是也没时间细看了，下面只是把各种可能自己试一下。

```py
>>> x = [1] * 3
>>> x
[1, 1, 1]
>>> x[0] = 2
>>> x
[2, 1, 1]

>>> x = [1] * 3
>>> y = [x] * 4
>>> y
[[1, 1, 1], [1, 1, 1], [1, 1, 1], [1, 1, 1]]
>>> y[0][0] = 2
>>> y
[[2, 1, 1], [2, 1, 1], [2, 1, 1], [2, 1, 1]]

>>> y = [[1] * 3] * 4
>>> y
[[1, 1, 1], [1, 1, 1], [1, 1, 1], [1, 1, 1]]
>>> y[0][0] = 2
>>> y
[[2, 1, 1], [2, 1, 1], [2, 1, 1], [2, 1, 1]]

# 核心点就是用 * 就意味着浅拷贝；用 for _ in range() 是深拷贝。
# 所以以后周赛里为了速度，可以内层用 * 号的形式，外层用 for _ in range() 的形式。

>>> y = [[1] * 3 for _ in range(4)]
>>> y
[[1, 1, 1], [1, 1, 1], [1, 1, 1], [1, 1, 1]]
>>> y[0][0] = 2
>>> y
[[2, 1, 1], [1, 1, 1], [1, 1, 1], [1, 1, 1]]

>>> y = [[1 for _ in range(3)] for _ in range(4)]
>>> y
[[1, 1, 1], [1, 1, 1], [1, 1, 1], [1, 1, 1]]
>>> y[0][0] = 2
>>> y
[[2, 1, 1], [1, 1, 1], [1, 1, 1], [1, 1, 1]]
```
