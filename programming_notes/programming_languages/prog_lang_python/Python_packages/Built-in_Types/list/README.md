
# List

序列类型 --- list, tuple, range https://docs.python.org/zh-cn/3.8/library/stdtypes.html#sequence-types-list-tuple-range
- 列表 https://docs.python.org/zh-cn/3.8/library/stdtypes.html#list

Python将二维数组/多维数组转换为一维 https://blog.csdn.net/qq_36853469/article/details/106928360

Python List Methods https://www.programiz.com/python-programming/methods/list

How to check if a list is empty in Python? https://flexiple.com/check-if-list-is-empty-python/
- > **Solution 1: Using `PEP 8` recommended method:**
  * > Solution 1 & 2 make use of a method called **Truth Value Testing**. What this essentially means is that we check if the list is empty using its boolean value. This is possible because, in Python empty sequences, positional arguments containing 0, 0.0 or with length 0, are all considered to be false. You can read more about this [here](https://docs.python.org/3/library/stdtypes.html#truth-value-testing).
  * > Because of this method, we can check if a list is empty in Python. And below is the most Pythonic way of checking the same.
    ```py
    l1 = ["Hire", "the", "top", "1%", "freelancers"]
    l2 = []
    if l2:
        print("list is not empty")
    else:
        print("list is empty")
    #Output: "list is empty"
    ```
    >> //notes：主要是记下这个原来是 `PEP 8` 里推荐的。

## 

【from LeetCode】：
- `LC414. 第三大的数` https://github.com/BIAOXYZ/variousCodes/tree/master/_CodeTopics/LeetCode/401-600/000414
  * Python列表去重的几种方法 https://blog.csdn.net/Jerry_1126/article/details/79843751
