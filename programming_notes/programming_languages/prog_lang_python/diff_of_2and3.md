
# general

Python 2 和 Python 3 有哪些主要区别？ - 知乎 https://www.zhihu.com/question/19698598

Python2.x与3​​.x版本区别 http://www.runoob.com/python/python-2x-3x.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# "/" 运算符

- python中的float除法和整除法 https://www.jianshu.com/p/9034aafb50aa
- 除法运算符/在Python2和Python3中的区别 https://www.pythontab.com/html/2017/pythonjichu_1227/1211.html

简单总结下就是：2.x里`int/int=int (7/10=0)`，但是3.X里`int/int=float (7/10=0.7)`。若想在3.x达到一样的效果，应该用两个/，即`int//int=int`。这个是有血泪教训的，参见LeetCode 002的代码：[000002_Add_Two_Numbers_algo1.py](https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/000002_Add_Two_Numbers/000002_Add_Two_Numbers_algo1.py)

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `print`

print从语句改成函数(Python3.0) https://www.jianshu.com/p/f9d2ebb4ba64

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

- 每个 Python 文件头部都增加如下代码（尽量保证此 import 位于任何其他 import 之前）：
```py
# coding: utf-8
from __future__ import absolute_import, division, print_function, unicode_literals
```
- Python2 与 Python3 不兼容的代码，尽量使用 `six` 模块做兼容。比如 Python2 和 Python3 下 `range` 函数行为不一致，统一使用 `six.moves.range` 可以保证兼容性。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# six

Six: Python 2 and 3 Compatibility Library https://six.readthedocs.io/
- Supported renames:
