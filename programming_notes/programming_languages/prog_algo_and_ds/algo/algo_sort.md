
# Sort Algorithm

- 找工作知识储备(3)---从头说12种排序算法：原理、图解、动画视频演示、代码以及笔试面试题目中的应用 https://blog.csdn.net/han_xiaoyang/article/details/12163251
- 十种排序算法 https://blog.csdn.net/coolwriter/article/details/78732728
- 九大排序算法再总结 https://blog.csdn.net/xiazdong/article/details/8462393

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# [Merge sort](https://en.wikipedia.org/wiki/Merge_sort)

归并排序 https://zh.wikipedia.org/wiki/%E5%BD%92%E5%B9%B6%E6%8E%92%E5%BA%8F || Merge sort https://en.wikipedia.org/wiki/Merge_sort
- > 归并排序（英语：Merge sort，或mergesort），是创建在归并操作上的一种有效的排序算法，效率为O(nlog n)}（大O符号）。1945年由约翰·冯·诺伊曼首次提出。该算法是采用分治法（Divide and Conquer）的一个非常典型的应用，且各层分治递归可以同时进行。
- > Python3
  ```py
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
  ```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
