
# 官方

ctypes --- Python 的外部函数库 https://docs.python.org/zh-cn/3.7/library/ctypes.html

# 其他

【[:star:][`*`]】 Python inverse function of id(…) built-in function https://stackoverflow.com/questions/24815771/python-inverse-function-of-id-built-in-function
>> //notes：类似Leetcode第[684](https://github.com/BIAOXYZ/variousCodes/tree/master/_CodeTopics/LeetCode/601-800/000684)题这种（最直观的反应是，令多个等价元素共享一个对象作为代表元素）并查集类型的题，有个需求就是类似C++里`std::unique_ptr`。但是python里没有指针，所以只能想到从`id()`入手。但是这个答案还是没解决我的需求，需要回头再自己试试`ctypes`里别的函数看能不能做到**根据python对象的id返回那个对象**。

【~~Pointers in Python: What's the Point? https://realpython.com/pointers-in-python/~~ 已转移】

python ctypes 探究 ---- python 与 c 的交互 https://www.cnblogs.com/night-ride-depart/p/4907613.html

聊聊Python ctypes 模块 - Jerry Jho的文章 - 知乎 https://zhuanlan.zhihu.com/p/20152309
