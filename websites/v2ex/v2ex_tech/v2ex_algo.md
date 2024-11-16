
面试题：如何 O(n) 的复杂度内筛选 60 亿人的身高 https://www.v2ex.com/t/943925

Facebook 面试题：最长公共子序列 https://www.v2ex.com/t/723642

Facebook 面试题：和大于 S 的最小子数组 https://www.v2ex.com/t/721633

各位都是怎么学会 Hash Table 的 https://www.v2ex.com/t/721188
- > https://www.nosuchfield.com/2016/07/29/the-python-implementationp-of-HashTable/ 看我以前写的文章
  * > 一步一步写算法（之hash表） https://blog.csdn.net/feixiaoxing/article/details/6885657
- > 可以看这个 https://algs4.cs.princeton.edu/34hash/

估计面试没通过，唉 https://www.v2ex.com/t/719057

谷歌面试题：二叉查找树迭代器（hard 题，面试中有变形） https://www.v2ex.com/t/702892

【这是个反面教材。。。】 分享一行 Python 代码 `reduce(add, zip(nums[:n], nums[n:]))` - 来自解决 Leetcode #1470. Shuffle the Array 一题 https://www.v2ex.com/t/693010

我想问一道 LeetCode 变形题：（70）爬楼梯（变形） https://www.v2ex.com/t/680924

[第 7 期] 盘点那些面试中会被问到的链表算法题 https://www.v2ex.com/t/659761

[第 5 期] 算法精选-你应该知道的 KMP 算法 https://www.v2ex.com/t/652852

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

leetcode(力扣)Plus 会员咨询 https://www.v2ex.com/t/775946
- > 如果想看看企业题库的话，codetop 也可以的
  >> 定了！CodeTop题库重磅推出 - 一个搬砖的胖子的文章 - 知乎 https://zhuanlan.zhihu.com/p/267988008
  >>> https://codetop.cc || https://github.com/afatcoder/LeetcodeTop

独立开发了一个算法学习的平台, RobinAlgo, 欢迎大家使用 https://www.v2ex.com/t/726320
```console
https://github.com/clwater/LeetCodeAllAnimation
https://robinalgo.com/
```

总结了两年的 LeetCode 前 300 题非常详细通俗的题解 https://www.v2ex.com/t/680958
> https://leetcode.wang/ || https://zhuanlan.zhihu.com/leetcode1024

不知不觉搞了 200 道了 https://www.v2ex.com/t/657505
> https://github.com/LeoSirius/leetcode_solutions 且除了 sql 之外都有单元测试，主要是 cpp，部分有 py 。部分有多种思路

算法竞赛学习材料整理 repo https://www.v2ex.com/t/640843
```console
假期开了个 Github repo，收集来自互联网上公开分享的算法竞赛学习课件
https://github.com/hzwer/shareOI
```

C 语言刷 150 道 LeetCode 经验谈 https://www.v2ex.com/t/405467
- > C 是没有 STL 的，只能自己造轮子。链表怎么写，hashmap 怎么写，我借鉴的是内核的 list.h，写法已经形成自己一套模式，看上去还算简洁，不像参考答案写得那样 hack，混乱不堪。关键是能解决问题，特别一些复杂的逻辑，运气好还能爆机。可见对于 C 来说，也不要从 0 开始写代码，要学会站在巨人的肩膀上。
- > 用 C 刷 LeetCode 有个坑就是动态数组，个人经验是，尽量不要用 realloc 调用，会出现 runtime error，这应该算 LeetCode 平台的 bug。之前我被困扰了好久，后来终于想出了用手写 realloc 的办法，方法是，用两倍内存扩容，手动拷贝元素，释放原指针，赋值新指针。步骤很繁琐，但再也没出问题。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 算法与数据结构（非技术部分）

现在程序员是不是没必要刷 leetcode 了 https://www.v2ex.com/t/1090040
- > 在 AI 出现前，也没多少工作要直接写算法，但 leetcode 算法训练的思维是长期有价值的。推荐刷 leetcode 的同时，有空也刷下 LabEx https://labex.io 的 Linux ，DevOps ，Cybersecurity 的 Hands-on Labs ，会锻炼不同的思维 :-)

最近负责 Java 面试，吐槽下 https://www.v2ex.com/t/861954
```console
出了个编程题作为第一题，题目很简单就是一个列表找最大值：
    var list = List.of(5, 23, 6, 112, 44, 33, 31);
    // 找出 list 中的最大值并输出
但是没想到这么多人卡在这题上了😓，讲道理这题如果在 leecode 上应该是 very easy 的难度吧，各位 v 友们觉得呢，是题目太难了还是面试的人太水了？
```
- > 现在有很多这种，说起框架八股文一套一套的，面经背的滚瓜烂熟。让他们写个第一门编程课的课后题都写不出来。就不用说什么遍历二叉树链表这种稍微涉及点数据结构的，就连递归算个斐波那契都不一定写得出来，甚至一个最简单的双层循环打印菱形的题都能卡出去一大半人。你都不知道这些精通大数据高并发深入了解 JVM 的人才到底写没写过代码。
- > System.out.println(112)

机会只留给有准备的人，面试不刷题真不行 https://www.v2ex.com/t/772337

北京这边有没有不面算法的公司？ https://www.v2ex.com/t/762386
- > 外包公司应该都不面算法的吧，不然外包公司就没人了
  >> 大侠使不得😂，之前在外包公司招人的时候，一个冒泡面死了一半 JAVA 面试者  【--> 不禁又想起了脉脉上那段经典黑：“对某公司程序员来说，二分查找都是hard。”】

面试笔试做不出长整数加法的是不是 coding 能力就基本当没有了？ https://www.v2ex.com/t/699860

做一道算法题需要花多长时间？ https://www.v2ex.com/t/693252

这个老哥（其实才 18）直播，连续 12 小时解决 150 个算法问题 https://www.v2ex.com/t/685884
- > 翻译一个有趣评论：<br> William : 12 小时解决 150 道算法题 <br> 我 : 150 个小时解决 12 道算法题
- > The only thing i could do for 12 hours straight is sleep. <br> 卧槽我也是，欸呀欸呀哈哈哈哈哈哈。。。
- > The only thing i could do for 12 hours straight is sleep. <br> 唉。人到中年，想睡这么长时间也不容易了。很容易醒。
- > 我 30 岁之后，连续睡 12 个小时也做不到。
- > 我不到 30 也睡不到，24h 能睡 12h 的都是神人（#捂脸）

关于练习 leetcode 和算法是否对日常工作有用的问题（续） https://www.v2ex.com/t/679860
