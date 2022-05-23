
# Sort Algorithm

- 找工作知识储备(3)---从头说12种排序算法：原理、图解、动画视频演示、代码以及笔试面试题目中的应用 https://blog.csdn.net/han_xiaoyang/article/details/12163251
- 十种排序算法 https://blog.csdn.net/coolwriter/article/details/78732728
- 九大排序算法再总结 https://blog.csdn.net/xiazdong/article/details/8462393

动画详解常用排序算法（1） https://mp.weixin.qq.com/s/XxmnKGLfstgbWjoj-eWddg

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# [Merge sort](https://en.wikipedia.org/wiki/Merge_sort)

归并排序 https://zh.wikipedia.org/wiki/%E5%BD%92%E5%B9%B6%E6%8E%92%E5%BA%8F || Merge sort https://en.wikipedia.org/wiki/Merge_sort
- > 归并排序（英语：Merge sort，或mergesort），是创建在归并操作上的一种有效的排序算法，效率为O(nlog n)}（大O符号）。1945年由约翰·冯·诺伊曼首次提出。该算法是采用分治法（Divide and Conquer）的一个非常典型的应用，且各层分治递归可以同时进行。
- > Python3
  ```py3
  def mergeSort(nums):
      if len(nums) < 2:
          return nums
      mid = len(nums) // 2
      left = mergeSort(nums[:mid])
      right = mergeSort(nums[mid:])
      result = []
      while left and right:
          if left[0] <= right[0]:
              result.append(left.pop(0))
          else:
              result.append(right.pop(0))
      if left:
          result += left
      if right:
          result += right
      return result

  if __name__ == "__main__":
      nums = [1, 4, 2, 3.6, -1, 0, 25, -34, 8, 9, 1, 0]
      print("original:", nums)
      print("Sorted:", mergeSort(nums))
  --------------------------------------------------
  original: [1, 4, 2, 3.6, -1, 0, 25, -34, 8, 9, 1, 0]
  Sorted: [-34, -1, 0, 0, 1, 1, 2, 3.6, 4, 8, 9, 25]
  ```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

多路归并排序的时候，为什么要采用败者树？ - 知乎 https://www.zhihu.com/question/35144290

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 堆排序

堆排序 https://zh.wikipedia.org/wiki/%E5%A0%86%E6%8E%92%E5%BA%8F
- > **Python**
  ```py
  #!/usr/bin/env python
  #-*-coding:utf-8-*-

  def heap_sort(lst):
      def sift_down(start, end):
          """最大堆调整"""
          root = start
          while True:
              child = 2 * root + 1
              if child > end:
                  break
              if child + 1 <= end and lst[child] < lst[child + 1]:
                  child += 1
              if lst[root] < lst[child]:
                  lst[root], lst[child] = lst[child], lst[root]
                  root = child
              else:
                  break

      # 创建最大堆
      for start in xrange((len(lst) - 2) // 2, -1, -1):
          sift_down(start, len(lst) - 1)

      # 堆排序
      for end in xrange(len(lst) - 1, 0, -1):
          lst[0], lst[end] = lst[end], lst[0]
          sift_down(0, end - 1)
      return lst

  if __name__ == "__main__":
      l = [9, 2, 1, 7, 6, 8, 5, 3, 4]
      print l
      heap_sort(l)
      print l
  --------------------------------------------------
  [9, 2, 1, 7, 6, 8, 5, 3, 4]
  [1, 2, 3, 4, 5, 6, 7, 8, 9]
  ```

堆排序 https://oi-wiki.org/basic/heap-sort/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 桶排序

桶排序 https://zh.wikipedia.org/wiki/%E6%A1%B6%E6%8E%92%E5%BA%8F

桶排序 https://oi-wiki.org/basic/bucket-sort/

python实现·十大排序算法之桶排序(Bucket Sort) https://segmentfault.com/a/1190000022767400

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他排序算法

排序算法--睡眠排序、面条排序、猴子排序 (非常严肃) https://www.jianshu.com/p/4f526ea40df4
>> //notes：以下为自己实现的python版本。。。
```py
# 猴子排序
import random

lis = [1,2,5,4,3]
ordered = list(range(1,6))

res = 0
while lis != ordered:
    random.shuffle(lis)
    res += 1
print(lis, ordered, res)
```
```
[1, 2, 3, 4, 5] [1, 2, 3, 4, 5] 173
```
