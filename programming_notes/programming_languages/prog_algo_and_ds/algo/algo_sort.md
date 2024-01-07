
# Sort Algorithm

- 找工作知识储备(3)---从头说12种排序算法：原理、图解、动画视频演示、代码以及笔试面试题目中的应用 https://blog.csdn.net/han_xiaoyang/article/details/12163251
- 十种排序算法 https://blog.csdn.net/coolwriter/article/details/78732728
- 九大排序算法再总结 https://blog.csdn.net/xiazdong/article/details/8462393

动画详解常用排序算法（1） https://mp.weixin.qq.com/s/XxmnKGLfstgbWjoj-eWddg

十大排序从入门到入赘 -- 从今天起，与「排序」一刀两断 https://leetcode.cn/circle/discuss/eBo9UB/

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

# 计数排序

https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/601-800/000791/README.md

## LeetCode相关题目：
- `791. 自定义字符串排序` https://leetcode.cn/problems/custom-sort-string/

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

## 睡眠排序
>> //notes：其实还有一些缺点下面这些文章里没有提到：
- 1.一个系统的进程总数和一个进程的线程总数是有上限的。即使你修改上限值，每个进程/线程总要占用诸如内存之类的系统资源，因此总数还是有限的（参见这篇《[linux下进程的进程最大数、最大线程数、进程打开的文件数和ulimit命令修改硬件资源限制](https://blog.csdn.net/gatieme/article/details/51058797)》）。所以睡眠排序能支持的排序总数目非常小。
- 2.如果是在分布式环境下，就会有时钟问题（怎么能保证“同时”启动）、状态同步问题（线程/进程 A 明明比 B 先结束，等通知到达后，B 认为自己比 A 先结束）。

奇葩的不可行排序：睡眠排序、面条排序、猴子排序（c++版） https://blog.csdn.net/weixin_40539125/article/details/93379360
- > **睡眠排序（Sleep Sort）**
  * > 注释：
    ```console
    [1] 当线程不太多的时候，基本可以认为它们是同时启动的。
    [2] 主线程睡眠足够长时间，等所有Sleeper线程都执行完毕。可以把时间设成比最大输入稍大。
    ```
  * > 不可行原因：
    ```console
    比如输入数据很相近时会有误差
    输入数据很多时，这些线程不能看作是同时启动等等
    输入数据太大时，运行时间太长
    ```
- > **量子猴排(Quantum Bogo Sort)**
  * > 不过好在量子物理的发展，给了我们用这个方法解决问题的一线生机。所谓量子猴排就是洗牌的时候，使用量子化随机排列（quantumly randomized）。这样的话，我们在观测这组数之前，这组数的状态是叠加的。
  * > 通过这种量子化随机排列，我们划分出来了O(n)个平行宇宙。接下来，在某个宇宙00729中，观测一下这组数，发现运气不好，没有排序好，那么我们就销毁掉这个宇宙。然后再看看其他宇宙的运气怎么样。终于，在一个宇宙04008中，发现刚好是排好序的数组。那么我们就保留宇宙04008。最后，没有被销毁的宇宙中，数组都是恰好一次被排好序的。算法结束。
  * > 我们来分析一下量子猴排的时间复杂度，嗯，O(n)，看是不是快了很多。
  * > 参考文章：[代码改进-知乎罗必成](https://www.zhihu.com/question/31387715)

睡眠排序算法 https://www.debugger.wiki/article/html/1558584001392845
- > 存在缺点：
  ```console
  ①若睡眠时间之间相差很小时，容易出现误差，为了减小误差，一般需要放大睡眠倍数；
  ②因为睡眠时间和数据大小有直接关系，因此数据不能太大 ，若数据很大时，睡眠时间要很久，程序运行很长；
  ③睡眠时间不能为负数，如果排序数据中存在负数，需要按照一定的规律把对应的睡眠时间转换成正数，比如说在设置睡眠时间时，把每一项都加上一个正数（该正数的绝对值要比最小负数的绝对值要打）。
  ```

## 双调排序(Bitonic sort)

Batcher归并网络 https://zh.wikipedia.org/zh-cn/Batcher%E5%BD%92%E5%B9%B6%E7%BD%91%E7%BB%9C

双调排序 https://www.yiibai.com/data_structure/bitonic-sort.html

排序算法（五）-双调排序 https://www.sakuratears.top/blog/%E6%8E%92%E5%BA%8F%E7%AE%97%E6%B3%95%EF%BC%88%E4%BA%94%EF%BC%89-%E5%8F%8C%E8%B0%83%E6%8E%92%E5%BA%8F.html

双调排序的并行实现 https://hellolzc.github.io/2018/04/bitonic-sort-without-padding/

segmentedBitonicSort https://github.com/imtypist/segmentedBitonicSort

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 多维数组排序

How to sort 2-D array by multiple columns? https://groups.google.com/g/comp.lang.fortran/c/jSoWLNMib8Y
- https://groups.google.com/g/comp.lang.fortran/c/jSoWLNMib8Y/m/woiLq20qAgAJ 
  * > A quick-and-dirty approach that could work, depending on the ranges of the columns, is to create a column that gives much more weight to columns that should be sorted first, for example `1e6*column_1 + 1e3*column2 + column3`, and sort by it. It would be more careful to compute ranks of each columns and create a weighted rank.
  * > The best approach is to create subsets based on column 1, then create sub-subsets based on column 2, and to sort the sub-subsets baesd on column 3. It is not conceptually hard but requires bookkeeping. I wonder if a recursive subroutine could be used.
- > https://groups.google.com/g/comp.lang.fortran/c/jSoWLNMib8Y/m/476Zhd0yAgAJ
  * > One way is to use a stable sort algorithm. A stable sort does not change the order of items with the same value. You then sort the whole file in the least significant field, then the next, and finally the most significant.
    >> 【[:star:][`*`]】 //notes：这里就是`基数排序`的思想了。
  * > However, the faster sort algorithms, such as Quicksort, are not stable. C's qsort(), which may or may not actually use quicksort, is not meant to imply a stable sort.
  * > The Java sort routines are documented as stable, and commonly use a merge sort algorithm that is stable, and also fast. (It is O(n log n), though maybe not as fast as Quicksort.)
  * > The other way is to use a sort routine where you supply the comparison function, and have the function compare elements as appropriate. Returning a value to indicate greater, equal, or lesser based first on the most significant, and then if equal, lesser significant members.

Most efficient way to sort a 2d array with sorted rows into 1d sorted array https://stackoverflow.com/questions/23241800/most-efficient-way-to-sort-a-2d-array-with-sorted-rows-into-1d-sorted-array
- 【[:star:][`*`]】 https://stackoverflow.com/questions/23241800/most-efficient-way-to-sort-a-2d-array-with-sorted-rows-into-1d-sorted-array/23241891#23241891 【//notes：这个回答里提到主要还是用`归并排序`。】

Sorting Algorithms in Python https://realpython.com/sorting-algorithms-python/
- > **The Timsort Algorithm in Python**
  * > The **Timsort** algorithm is considered a **hybrid** sorting algorithm because ***it employs a best-of-both-worlds <ins>combination of `insertion sort` and `merge sort`</ins>***. Timsort is near and dear to the Python community because it was created by Tim Peters in 2002 to be used as the [standard sorting algorithm of the Python language](https://en.wikipedia.org/wiki/Timsort).
    >> 【[:star:][`*`]】 //notes：所以 Python 是自己实现了一个混合了`插入排序`和`归并排序`的算法。
  * > The main characteristic of Timsort is that it takes advantage of already-sorted elements that exist in most real-world datasets. These are called **natural runs**. The algorithm then iterates over the list, collecting the elements into runs and merging them into a single sorted list.

About Python's built in sort() method https://stackoverflow.com/questions/1517347/about-pythons-built-in-sort-method
- https://stackoverflow.com/questions/1517347/about-pythons-built-in-sort-method/1517363#1517363
  * > Sure! The code's [here](https://github.com/python/cpython/blob/master/Objects/listobject.c), starting with function `islt` and proceeding for QUITE a while;-). As Chris's comment suggests, it's C code. You'll also want to read [this](https://github.com/python/cpython/blob/master/Objects/listsort.txt) text file for a textual explanation, results, etc etc.
    >> 【[:star:][`*`]】 //notes：看了下 CPython 里的排序实现，光那个[说明文件](https://github.com/python/cpython/blob/main/Objects/listsort.txt)都 800 多行。。。直接不看了- -

Sorting a multidimensional array using merge sort? https://stackoverflow.com/questions/67786912/sorting-a-multidimensional-array-using-merge-sort
