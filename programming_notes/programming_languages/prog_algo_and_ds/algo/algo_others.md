
# 待分类algorithms

Golang LRU cache https://github.com/hashicorp/golang-lru

原地算法 https://zh.wikipedia.org/wiki/%E5%8E%9F%E5%9C%B0%E7%AE%97%E6%B3%95 || In-place algorithm https://en.wikipedia.org/wiki/In-place_algorithm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 快速选择

快速选择 https://zh.wikipedia.org/wiki/%E5%BF%AB%E9%80%9F%E9%80%89%E6%8B%A9 || Quickselect https://en.wikipedia.org/wiki/Quickselect
- > 在计算机科学中，快速选择（英语：Quickselect）是一种从无序列表找到第k小元素的选择算法。它从原理上来说与快速排序有关。与快速排序一样都由托尼·霍尔提出的，因而也被称为霍尔选择算法。同样地，它在实际应用是一种高效的算法，具有很好的平均时间复杂度，然而最坏时间复杂度则不理想。快速选择及其变种是实际应用中最常使用的高效选择算法。
- > 快速选择的总体思路与快速排序一致，选择一个元素作为基准来对元素进行分区，将小于和大于基准的元素分在基准左边和右边的两个区域。不同的是，快速选择并不递归访问双边，而是只递归进入一边的元素中继续寻找。这降低了平均时间复杂度，从O(nlogn)至O(n)，不过最坏情况仍然是O(n^2)。
- > 与快速排序一样，快速选择一般是以原地算法的方式实现，除了选出第k小的元素，数据也得到了部分地排序。

`215. 数组中的第K个最大元素` https://leetcode-cn.com/problems/kth-largest-element-in-an-array/

Top K 问题的最优解 - 快速选择算法（Quickselect） - 胖头鱼的文章 - 知乎 https://zhuanlan.zhihu.com/p/64627590

QuickSelect: The Quick Select Algorithm Explained With Code Examples https://www.freecodecamp.org/news/quickselect-algorithm-explained-with-examples/

Quickselect Algorithm https://www.geeksforgeeks.org/quickselect-algorithm/

QuickSelect Algorithm Understanding https://stackoverflow.com/questions/10846482/quickselect-algorithm-understanding

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 记忆化搜索

记忆化搜索 https://oi-wiki.org/dp/memo/

记忆化搜索与动态规划等价吗？ - 知乎 https://www.zhihu.com/question/60730045

`四种解法+详细图解 198. 打家劫舍` https://leetcode-cn.com/problems/house-robber/solution/si-chong-jie-fa-xiang-xi-tu-jie-198-da-jia-jie-she/

`暴力搜索->记忆化搜索->动态规划` https://leetcode-cn.com/problems/integer-break/solution/bao-li-sou-suo-ji-yi-hua-sou-suo-dong-tai-gui-hua-/

`329. 矩阵中的最长递增路径` https://leetcode-cn.com/problems/longest-increasing-path-in-a-matrix/solution/ju-zhen-zhong-de-zui-chang-di-zeng-lu-jing-by-le-2/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 拓扑排序

**Leetcode题目**：
- `207. 课程表` https://leetcode-cn.com/problems/course-schedule/
- `802. 找到最终的安全状态` https://leetcode-cn.com/problems/find-eventual-safe-states/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 数学

原根 https://zh.wikipedia.org/wiki/%E5%8E%9F%E6%A0%B9

原根 https://oi-wiki.org/math/primitive-root/

算法学习笔记(40): 原根 - Pecco的文章 - 知乎 https://zhuanlan.zhihu.com/p/166043237
- > 正整数有原根的充要条件为：它能表示为下列形式之一： $2, 4, p^n, 2p^n$ ，其中 `p` 为奇素数。（证明比较复杂，若感兴趣可参见这篇博客）
  >> 题解 P6091 【【模板】原根】 https://www.luogu.com.cn/blog/codecodeakioi/solution-p6091

「原根」与「阶」 https://www.jianshu.com/p/ba32b080d8af

原根、与原根的应用(更新中) https://www.cnblogs.com/al76/p/9426147.html
