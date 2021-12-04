
# 官方

8.5. bisect — Array bisection algorithm https://docs.python.org/2.7/library/bisect.html

bisect --- 数组二分查找算法 https://docs.python.org/zh-cn/3.8/library/bisect.html
- > `bisect.insort_left(a, x, lo=0, hi=len(a))`
  * > 将 x 插入到一个有序序列 a 里，并维持其有序。如果 a 有序的话，这相当于 `a.insert(bisect.bisect_left(a, x, lo, hi), x)`。要注意***搜索是 O(log n) 的，插入却是 O(n) 的***。

`def bisect_left(a, x, lo=0, hi=None):` https://github.com/python/cpython/blob/2.7/Lib/bisect.py#L67
```py
def bisect_left(a, x, lo=0, hi=None):
    """Return the index where to insert item x in list a, assuming a is sorted.

    The return value i is such that all e in a[:i] have e < x, and all e in
    a[i:] have e >= x.  So if x already appears in the list, a.insert(x) will
    insert just before the leftmost x already there.

    Optional args lo (default 0) and hi (default len(a)) bound the
    slice of a to be searched.
    """

    if lo < 0:
        raise ValueError('lo must be non-negative')
    if hi is None:
        hi = len(a)
    while lo < hi:
        mid = (lo+hi)//2
        if a[mid] < x: lo = mid+1
        else: hi = mid
    return lo
```

bisect.py https://github.com/python/cpython/blob/3.9/Lib/bisect.py

>> //notes：另外，不管是Python2还是Python3的源码里，都有下面两句，只是位置不一样而已。所以（不带方向的）`bisect`其实就是`bisect_right`的一个别名，对于`insort`和`insort_right`也是一样的。
```py
bisect = bisect_right
insort = insort_right
```

# 其他

How to Do a Binary Search in Python https://realpython.com/binary-search-python/

一个有趣的python排序模块：bisect https://www.cnblogs.com/skydesign/archive/2011/09/02/2163592.html
- > 接着看 bisect_left 和 bisect_right 函数，该函数用入处理将会插入重复数值的情况，返回***将会插入的位置***：![](https://pic002.cnblogs.com/images/2011/225228/2011090220185965.jpg)
  >> //notes：所以这一类函数的核心点是返回目标元素应该插入到数组的位置下标，而不完全等于在原数组中查找某个值。

Bisect Algorithm Functions in Python https://www.geeksforgeeks.org/bisect-algorithm-functions-in-python/
```py
#// 注：帖子原来的代码有一点点小语法错误（不会影响到本篇讲的bisect的实质内容），这是修改过后保证能运行的。

# importing "bisect" for bisection operations 
import bisect 
  
# initializing list 
li = [1, 3, 4, 4, 4, 6, 7] 
  
# using bisect() to find index to insert new element 
# returns 5 ( right most possible index ) 
print ("The rightmost index to insert, so list remains sorted is  : ") 
print (bisect.bisect(li, 4)) 
  
# using bisect_left() to find index to insert new element 
# returns 2 ( left most possible index ) 
print ("The leftmost index to insert, so list remains sorted is  : ") 
print (bisect.bisect_left(li, 4)) 
  
# using bisect_right() to find index to insert new element 
# returns 4 ( right most possible index ) 
print ("The rightmost index to insert, so list remains sorted is  : ") 
print (bisect.bisect_right(li, 4, 0, 4)) 
----------------------------------------------------------------------------------------------------
The rightmost index to insert, so list remains sorted is  : 
5
The leftmost index to insert, so list remains sorted is  : 
2
The rightmost index to insert, so list remains sorted is  : 
4
```

When are bisect_left and bisect_right not equal? https://stackoverflow.com/questions/20297249/when-are-bisect-left-and-bisect-right-not-equal
- > When the target to locate is in the list, bisect_left, bisect_right return different result. For example:
  ```py
  >>> import bisect
  >>> bisect.bisect_left([1,2,3], 2)
  1
  >>> bisect.bisect_right([1,2,3], 2)
  2
  ```
  
Python实现二分查找与bisect模块详解 https://www.jb51.net/article/102899.htm
- > 
  ```py
  我们分别用递归和循环来实现二分查找：

  def binary_search_recursion(lst, value, low, high): 
   if high < low: 
   return None
   mid = (low + high) / 2
   if lst[mid] > value: 
   return binary_search_recursion(lst, value, low, mid-1) 
   elif lst[mid] < value: 
   return binary_search_recursion(lst, value, mid+1, high) 
   else: 
   return mid 

  def binary_search_loop(lst,value): 
   low, high = 0, len(lst)-1
   while low <= high: 
   mid = (low + high) / 2
   if lst[mid] < value: 
   low = mid + 1
   elif lst[mid] > value: 
   high = mid - 1
   else:
   return mid 
   return None
  ```
