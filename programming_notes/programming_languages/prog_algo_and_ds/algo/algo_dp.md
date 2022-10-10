
# DP (Dynamic Programming)

动态规划 https://zh.wikipedia.org/wiki/%E5%8A%A8%E6%80%81%E8%A7%84%E5%88%92 || Dynamic programming https://en.wikipedia.org/wiki/Dynamic_programming
- > 适用情况
  * > 1.最优子结构性质。如果问题的最优解所包含的子问题的解也是最优的，我们就称该问题具有最优子结构性质（即满足最优化原理）。最优子结构性质为动态规划算法解决问题提供了重要线索。
  * > 2.无后效性。即子问题的解一旦确定，就不再改变，不受在这之后、包含它的更大的问题的求解决策影响。
  * > 3.子问题重叠性质。子问题重叠性质是指在用递归算法自顶向下对问题进行求解时，每次产生的子问题并不总是新问题，有些子问题会被重复计算多次。动态规划算法正是利用了这种子问题的重叠性质，对每一个子问题只计算一次，然后将其计算结果保存在一个表格中，当再次需要计算已经计算过的子问题时，只是在表格中简单地查看一下结果，从而获得较高的效率，降低了时间复杂度。
- > 使用动态规划的算法
  * > 最长公共子序列 https://zh.wikipedia.org/wiki/%E6%9C%80%E9%95%BF%E5%85%AC%E5%85%B1%E5%AD%90%E5%BA%8F%E5%88%97 || Longest common subsequence problem https://en.wikipedia.org/wiki/Longest_common_subsequence_problem
  * > Floyd-Warshall算法 https://zh.wikipedia.org/wiki/Floyd-Warshall%E7%AE%97%E6%B3%95 || Floyd–Warshall algorithm https://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm
  * > 维特比算法 https://zh.wikipedia.org/wiki/%E7%BB%B4%E7%89%B9%E6%AF%94%E7%AE%97%E6%B3%95 || Viterbi algorithm https://en.wikipedia.org/wiki/Viterbi_algorithm

动态规划 https://oi-wiki.org/dp/
- 状压 DP https://oi-wiki.org/dp/state/

看动画轻松理解「递归」与「动态规划」 https://juejin.im/post/5c2308abf265da615304ce41 || 看动画轻松理解「递归」与「动态规划」 - 程序员吴师兄的文章 - 知乎 https://zhuanlan.zhihu.com/p/53415718

什么是动态规划（Dynamic Programming）？动态规划的意义是什么？ - 知乎 https://www.zhihu.com/question/23995189
- 什么是动态规划（Dynamic Programming）？动态规划的意义是什么？ - 阮行止的回答 - 知乎 https://www.zhihu.com/question/23995189/answer/613096905

如何理解动态规划？ - 知乎 https://www.zhihu.com/question/39948290
- 如何理解动态规划？ - 牛岱的回答 - 知乎 https://www.zhihu.com/question/39948290/answer/612439961
  * > 举个例子，有n个阶梯，一个人每一步只能跨一个台阶或是两个台阶，问这个人一共有多少种走法？ 首先要对这个问题进行抽象，n个阶梯，每个阶梯都代表一个"位置"， 就像是图论中的一个"点"，然后这些n个不同位置之间会有一些桥梁把它们连起来。这个图，就是该问题的抽象表达形式，那么这个问题就转化成了从 Node 0 到 Node 10 有几种不同的路可以走？ <br> ![](https://pic3.zhimg.com/80/v2-9191c5c55acfdebd6adeae22b6d7c00f_1440w.jpg)
- 如何理解动态规划？ - 力扣（LeetCode）的回答 - 知乎 https://www.zhihu.com/question/39948290/answer/1309260344
  * > **二、动态规划概述** <br> 动态规划解题思路 <br> 动态规划主要分为两个核心部分，一是确定「DP 状态」，二是确定「DP 转移方程」。
  * > DP 状态
    ```
    「DP 状态」的确定主要有两大原则：

    最优子结构
    无后效性
    ```
  * > 什么是「最优子结构」？将原有问题化分为一个个子问题，即为子结构。而对于每一个子问题，其最优值均由「更小规模的子问题的最优值」推导而来，即为最优子结构。
  * > 而对于「无后效性」，顾名思义，就是我们只关心子问题的最优值，不关心子问题的最优值是怎么得到的。
  * > 有了「DP 状态」之后，我们只需要用「分类讨论」的思想来枚举所有小状态向大状态转移的可能性即可推出「DP 转移方程」。
  * > **动态规划问题类别** <br> 讲述完 DP 问题的解题思路后，我们来大致列举一下 DP 问题的类别。 <br> DP 问题主要分为两大类，第一大类是 DP 类型，第二大类是 DP 优化方法。 <br> 其中在 DP 类型部分，面试中最常考察的就是「线性 DP」，而在优化方法部分，最常见的是「RMQ 优化」，即使用线段树或其它数据结构查询区间最小值，来优化 DP 的转移过程。
  * >
    ```
    最后我们来总结一下 DP 问题的解题思路：

    ●确定「DP 状态」
      •符合「最优子结构」原则：DP 状态最优值由更小规模的 DP 状态最优值推出
      •符合「无后效性」原则：状态的得到方式，不会影响后续其它 DP 状态取值
    ●确定「DP 转移方程」
      •分类讨论，细心枚举
    ```

动态规划套路详解 https://juejin.im/post/5d556b7ef265da03aa2568d5

LeetCode力扣 #动态规划 https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzI4Mzc5NDk4MA==&action=getalbum&album_id=1468452612273422336&scene=173
- 算法萌新如何学好动态规划（1） https://mp.weixin.qq.com/s/rhyUb7d8IL8UW1IosoE34g
- 算法萌新如何学好动态规划（2） https://mp.weixin.qq.com/s/jav9--Sqf9jOs8BSXNcUyw
- 算法萌新如何学好动态规划（3） https://mp.weixin.qq.com/s/2tD3h4NtFiIuujhoJYVoKQ

力扣上的 DP 问题分类汇总 https://leetcode-cn.com/circle/article/NfHhXD/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

动态规划之空间优化与总结回顾 https://www.cxyxiaowu.com/7848.html
- > 其实滚动数组的思想不难理解，就是只保存需要用到的子问题的答案（状态），覆盖那些不需要用到的子问题的答案，状态在同一块空间中不断翻滚迭代向前。
- > 当然，有些动态规划的实现方式就不太容易使用这类优化，比如 记忆化搜索，还有些动态规划题型，比如 区间类动态规划，状态的更新不是逐行逐列的，使用滚动数组来优化也不是特别容易，因此使用滚动数组优化的时候还是需要结合实际情况考虑。
- > 滚动数组一般来说都可以将状态数组的空间降低一维，比如三维变二维、二维变一维、一维变常数，当然有些具体题型的空间优化也可以做到这个，比如背包类型的动态规划问题中，我们通过改变遍历的顺序，直接就可以做到空间降维，但其实这是这类动态规划问题特有的优化，不属于滚动数组的范畴。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 记忆化搜索

记忆化搜索 https://oi-wiki.org/dp/memo/

记忆化搜索与动态规划等价吗？ - 知乎 https://www.zhihu.com/question/60730045
- 记忆化搜索与动态规划等价吗？ - 樱花记忆的回答 - 知乎 https://www.zhihu.com/question/60730045/answer/462829337

`140. 单词拆分 II` https://leetcode-cn.com/problems/word-break-ii/solution/dan-ci-chai-fen-ii-by-leetcode-solution/
- > 第 139 题可以使用动态规划的方法判断是否可以拆分，因此这道题也可以使用动态规划的思想。但是这道题如果使用***自底向上的动态规划的方法***进行拆分，则无法事先判断拆分的可行性，在不能拆分的情况下会超时。
- > 为了避免动态规划的方法超时，需要首先使用第 139 题的代码进行判断，在可以拆分的情况下再使用动态规划的方法进行拆分。相比之下，***自顶向下的记忆化搜索***可以在搜索过程中将不可以拆分的情况进行剪枝，因此记忆化搜索是更优的做法。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 背包问题

代码随想录：
- 咱就把01背包问题讲个通透！ https://leetcode-cn.com/circle/article/lUki6J/
- 动态规划：关于完全背包，你该了解这些！ https://leetcode-cn.com/circle/article/k7RRg3/

分享｜深度讲解背包问题：面试中每五道动态规划就有一道是背包模型 ... https://leetcode-cn.com/circle/discuss/GWpXCM/view/1jhUgI/

动态规划之背包问题系列 - SMON的文章 - 知乎 https://zhuanlan.zhihu.com/p/93857890

图解 | 你管这叫动态规划 https://www.ithome.com/0/645/532.htm || https://mp.weixin.qq.com/s/MgNGAWfKp9O0j4lwsx4qLA
- > **3**
  * > 有一个背包，可以装载重量为 5kg 的物品。有 4 个物品，他们的重量和价值如下。![](https://img.ithome.com/newsuploadfiles/2022/10/6891cacd-3099-4aca-8654-4577be39df16.jpg)
  * > 那么请问，在不得超过背包的承重的情况下，将哪些物品放入背包，可以使得总价值最大？
  * > 假如我们用 **F(W,i)** 表示用载重为 W 的背包，装前 i 件物品的最大价值。 <br> 那本题其实就是用载重为 5kg 的背包，装前 4 件物品的最大价值。其实就是求解 **F(5,4)**。

## 也可参考leetcode对应题目的笔记：
- `背包问题` https://www.luogu.com.cn/training/5197
  * `洛谷日报 #61 背包问题` https://www.luogu.com.cn/blog/RPdreamer/bei-bao-wen-ti
- `LC416 分割等和子集` https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/401-600/000416/README.md
  * https://leetcode-cn.com/problems/partition-equal-subset-sum/solution/fen-ge-deng-he-zi-ji-by-leetcode-solution/
