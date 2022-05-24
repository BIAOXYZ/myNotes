
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
