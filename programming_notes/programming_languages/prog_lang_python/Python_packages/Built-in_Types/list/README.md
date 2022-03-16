
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
- https://leetcode-cn.com/circle/discuss/9TMMfX/view/9xfeIr/
  * > Problem A - 检查是否每一行每一列都包含全部整数
    >> //notes：里面求矩阵的所有列的时候用到了一个技巧 `zip(*matrix)`（貌似只对Python3适用）。之前只会下面这种：
    ```py
    mtx = [[1,2,3],[4,5,6]]
    rows, cols = len(mtx), len(mtx[0])
    rowList = [[mtx[i][j] for j in range(cols)] for i in range(rows)]
    colList = [[mtx[i][j] for i in range(rows)] for j in range(cols)]
    print(rowList)
    print(colList)
    ##################################################
    [[1, 2, 3], [4, 5, 6]]
    [[1, 4], [2, 5], [3, 6]]
    ```

# `.index()`

Python List index() https://www.programiz.com/python-programming/methods/list/index
- > Syntax of List `index()`
  * > The syntax of the list `index()` method is:
    ```py
    list.index(element, start, end)
    ```
    >> //notes：这里的 `start` 和 `end` 也是 ***左闭右开***。以文中的例子，加一些自己的修改如下：
    ```py
    >>> alphabets = ['a', 'e', 'i', 'o', 'g', 'l', 'i', 'u']
    >>> print(alphabets.index('i', 1))
    2
    >>> print(alphabets.index('i', 2))
    2
    >>> print(alphabets.index('i', 3))
    6
    >>> print(alphabets.index('i', 2, 6))
    2
    >>> print(alphabets.index('i', 3, 6))
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    ValueError: 'i' is not in list
    >>> 
    # 当然，如果区间内包含多个，还是返回最小的那个。
    >>> print(alphabets.index('i', 2, 7))
    2
    ```
