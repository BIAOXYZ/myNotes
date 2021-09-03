
# 官方

# 其他

Python map() 函数 https://www.runoob.com/python/python-func-map.html
- > map() 函数语法：`map(function, iterable, ...)`
- > map() 会根据提供的函数对指定序列做映射。Python 2.x 返回列表。Python 3.x 返回迭代器。
```py
# 个人实战
 
>>> def square(x):
...     return x ** 2
... 
>>> map(square, [1,2,3,4,5])
<map object at 0x7ff0b5ca5550>
>>> 
>>> map(lambda x: x ** 2, [1, 2, 3, 4, 5])
<map object at 0x7ff0b5ca58e0>
>>> 
>>> map(lambda x, y: x + y, [1, 3, 5, 7, 9], [2, 4, 6, 8, 10])
<map object at 0x7ff0b5ca5940>
>>> 
>>> list(map(square, [1,2,3,4,5]))
[1, 4, 9, 16, 25]
>>> 
>>> list(map(lambda x: x ** 2, [1, 2, 3, 4, 5]))
[1, 4, 9, 16, 25]
>>> 
>>> list(map(lambda x, y: x + y, [1, 3, 5, 7, 9], [2, 4, 6, 8, 10]))
[3, 7, 11, 15, 19]
```
