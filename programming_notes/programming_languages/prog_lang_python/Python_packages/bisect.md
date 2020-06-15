
一个有趣的python排序模块：bisect https://www.cnblogs.com/skydesign/archive/2011/09/02/2163592.html
- > 接着看 bisect_left 和 bisect_right 函数，该函数用入处理将会插入重复数值的情况，返回将会插入的位置：

When are bisect_left and bisect_right not equal? https://stackoverflow.com/questions/20297249/when-are-bisect-left-and-bisect-right-not-equal
- > When the target to locate is in the list, bisect_left, bisect_right return different result. For example:
  ```py
  >>> import bisect
  >>> bisect.bisect_left([1,2,3], 2)
  1
  >>> bisect.bisect_right([1,2,3], 2)
  2
  ```
  
