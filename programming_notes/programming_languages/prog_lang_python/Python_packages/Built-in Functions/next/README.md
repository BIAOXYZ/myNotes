
# 官方

# 其他

Python next() https://www.programiz.com/python-programming/methods/built-in/next
- > **`next()` Syntax**
  * > The syntax of `next()` is:
    ```py
    next(iterator, default)
    ```

# LeetCode
- `997. 找到小镇的法官` https://leetcode-cn.com/submissions/detail/249806696/
  * > 这题用到了 `next(iterator, -1)`，如果迭代器为空，就返回-1；否则返回第一个元素。举例如下：
    ```py
    >>> l = []
    >>> next(l, -1)
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: 'list' object is not an iterator
    >>> 
    >>> next(iter(l), -1)
    -1
    >>> 
    >>> ll = [1,2,3]
    >>> next(iter(ll), -1)
    1
    >>> 
    ```
