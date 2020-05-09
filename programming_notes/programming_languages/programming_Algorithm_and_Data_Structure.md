
# General

郭威gowill -- 数据结构和算法 https://blog.csdn.net/guoweimelon/article/category/6136821
- 经典排序算法（1）——冒泡排序算法详解 https://blog.csdn.net/guoweimelon/article/details/50902597
- 经典排序算法（12）——总结 https://blog.csdn.net/guoweimelon/article/details/50904276
- 

eudiwffe -- 数据结构与算法 https://www.cnblogs.com/eudiwffe/category/927819.html
- [算法]——归并排序（Merge Sort） https://www.cnblogs.com/eudiwffe/p/6254394.html
> "归并排序（Merge Sort）与快速排序思想类似：将待排序数据分成两部分，继续将两个子部分进行递归的归并排序；然后将已经有序的两个子部分进行合并，最终完成排序。其时间复杂度与快速排序均为O(nlogn)，但是归并排序除了递归调用间接使用了辅助空间栈，还需要额外的O(n)空间进行临时存储。从此角度归并排序略逊于快速排序，但是归并排序是一种稳定的排序算法，快速排序则不然。
> 
> 所谓稳定排序，表示对于具有相同值的多个元素，其间的先后顺序保持不变。对于基本数据类型而言，一个排序算法是否稳定，影响很小，但是对于结构体数组，稳定排序就十分重要。"
- 

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# from github

数据结构和算法必知必会的50个代码实现 https://github.com/wangzheng0822/algo

Some exercises and problems in Introduction to Algorithms 3rd edition. https://github.com/CyberZHG/CLRS

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# from zhihu

程序员必须掌握哪些算法？ - 知乎 https://www.zhihu.com/question/23148377
- 程序员必须掌握哪些算法？ - 程序员吴师兄呀的回答 - 知乎 https://www.zhihu.com/question/23148377/answer/907915556

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Algorithm

- 最短路径—Dijkstra算法和Floyd算法 https://www.cnblogs.com/biyeymyhjob/archive/2012/07/31/2615833.html
- 数据结构与算法（14）：最短路算法 https://plushunter.github.io/2017/07/28/%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84%E4%B8%8E%E7%AE%97%E6%B3%95%EF%BC%8814%EF%BC%89%EF%BC%9A%E6%9C%80%E7%9F%AD%E8%B7%AF%E7%AE%97%E6%B3%95/

***--------------------------------------------------分割线--------------------------------------------------***

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Sort Algorithm

- 找工作知识储备(3)---从头说12种排序算法：原理、图解、动画视频演示、代码以及笔试面试题目中的应用 https://blog.csdn.net/han_xiaoyang/article/details/12163251
- 十种排序算法 https://blog.csdn.net/coolwriter/article/details/78732728
- 九大排序算法再总结 https://blog.csdn.net/xiazdong/article/details/8462393

### [Merge sort](https://en.wikipedia.org/wiki/Merge_sort)

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Hash related algorithms

Balls into bins https://en.wikipedia.org/wiki/Balls_into_bins
> CCS 2017一篇做PSI论文（Practical Multi-party Private Set Intersection from Symmetric-Key Techniques）提到过这个。利用wiki中提到的，每次随机抽2个（或多个），然后选择其中最少的那个bin把ball放进去，可以大大减少load。也就是让hash table少碰撞。

### [Cuckoo hashing](https://en.wikipedia.org/wiki/Cuckoo_hashing)

- DPDK中的cuckoo hash算法 https://www.jianshu.com/p/b09b26c9052a
- 随机算法 (Fall 2011)/Cuckoo hashing http://tcs.nju.edu.cn/wiki/index.php/%E9%9A%8F%E6%9C%BA%E7%AE%97%E6%B3%95_(Fall_2011)/Cuckoo_hashing
- Cuckoo hash算法分析——其根本思想和bloom filter一致 增加hash函数来解决碰撞 节省了空间但代价是查找次数增加 https://yq.aliyun.com/articles/398211
- Cuckoo Hashing的应用及性能优化 https://yq.aliyun.com/articles/563053

### [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter)

- Bloom Filters by Example https://llimllib.github.io/bloomfilter-tutorial/zh_CN/
> A Bloom Filter Tutorial https://github.com/llimllib/bloomfilter-tutorial
- 深夜学算法之Bloom Filter：概率游戏 https://www.jianshu.com/p/8193d7dc8348
- 布隆过滤器(Bloom Filter)详解 https://www.cnblogs.com/liyulong1982/p/6013002.html
- 那些优雅的数据结构(1) : BloomFilter——大规模数据处理利器 http://www.cnblogs.com/heaad/archive/2011/01/02/1924195.html

## 待分类algorithms

Golang LRU cache https://github.com/hashicorp/golang-lru

七分钟理解什么是 KMP 算法 - 程序员吴师兄的文章 - 知乎 https://zhuanlan.zhihu.com/p/76348091

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Data Structure

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## [Linked list](https://en.wikipedia.org/wiki/Linked_list)

Python数据结构——链表的实现 http://python.jobbole.com/83953/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## [heap](https://en.wikipedia.org/wiki/Heap_(data_structure))

Heap Data Structure https://www.geeksforgeeks.org/heap-data-structure/

`【堆概念】`：
- 纸上谈兵: 堆 (heap) https://www.cnblogs.com/vamei/archive/2013/03/20/2966612.html 【[`*`][:star:]】

`【堆操作】`：
- 最小堆 构建、插入、删除的过程图解 https://blog.csdn.net/hrn1216/article/details/51465270
- 看动画轻松理解「 堆 」 https://juejin.im/post/5c1ae6545188256a272a9cee
- 最大堆（创建、删除、插入和堆排序） https://www.jianshu.com/p/21bef3fc3030

### 斐波那契堆(Fibonacci heap)

斐波那契堆 https://zh.wikipedia.org/wiki/%E6%96%90%E6%B3%A2%E9%82%A3%E5%A5%91%E5%A0%86 || Fibonacci heap https://en.wikipedia.org/wiki/Fibonacci_heap

斐波那契堆(一)之 图文解析 和 C语言的实现 https://www.cnblogs.com/skywang12345/p/3659060.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `##` [Tree](https://en.wikipedia.org/wiki/Tree_(data_structure))
***// 决定按字母顺序排列各种树，因为实在太多了。有些看起来不是按字母顺序排的，是因为它是某种树的子类型。***

Robert Tarjan https://amturing.acm.org/award_winners/tarjan_1092048.cfm || https://en.wikipedia.org/wiki/Robert_Tarjan
- > An early and well-known example of this work is Tarjan's analysis of the “union-find” data structure. The union-find problem is to maintain a collection of disjoint sets so as to efficiently perform two operations: union, which joins two sets into a single set, and find, which returns the set containing a specified element. Representing each set as a tree, two simple methods were used to give improved performance: union by weight and path compression, but their impact was not completely understood.
- Self-balancing binary search tree https://en.wikipedia.org/wiki/Self-balancing_binary_search_tree || 平衡树 https://zh.wikipedia.org/wiki/%E5%B9%B3%E8%A1%A1%E6%A0%91
- Splay tree https://en.wikipedia.org/wiki/Splay_tree || 伸展树 https://zh.wikipedia.org/wiki/%E4%BC%B8%E5%B1%95%E6%A0%91
- 【还有这个，但是不是树】 Fibonacci heap https://en.wikipedia.org/wiki/Fibonacci_heap

树 (数据结构) https://zh.wikipedia.org/zh-cn/%E6%A0%91_(%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84)

### `###` 二叉树 / Binary tree

二叉树 https://zh.wikipedia.org/wiki/%E4%BA%8C%E5%8F%89%E6%A0%91 || Binary tree https://en.wikipedia.org/wiki/Binary_tree

#### 关于`完全二叉树`和`满二叉树`（以及`完美二叉树`）的定义区别和混淆

>> notes：中文圈就是上面三种说法；英文圈是 full binary tree、complete binary tree、perfect binary tree（全都没有维基百科的单独词条）。
>>> notes2：其实树这个概念下的各种类型的树造成的混淆本来就非常多，能准确知道意思就行，不用太纠结统一的名称。

为什么说“满二叉树也是完全二叉树”？ - 知乎 https://www.zhihu.com/question/19809666

### `###` 二叉搜索树 / Binary Search Tree (BST)

二叉搜索树 https://zh.wikipedia.org/wiki/%E4%BA%8C%E5%85%83%E6%90%9C%E5%B0%8B%E6%A8%B9 || Binary search tree https://en.wikipedia.org/wiki/Binary_search_tree
- > 二叉查找树（英語：Binary Search Tree），也称为二叉搜索树、有序二叉树（ordered binary tree）或排序二元樹（sorted binary tree），是指一棵空树或者具有下列性质的二叉树：
  ```console
  若任意节点的左子树不空，则左子树上所有节点的值均小于它的根节点的值；
  若任意节点的右子树不空，则右子树上所有节点的值均大于或等于它的根节点的值；
  任意节点的左、右子树也分别为二叉查找树；
  ```
- > 虽然二叉查找树的最坏效率是O(n)，但它支持动态查询，且有很多改进版的二叉查找树可以使树高为O(log n)，从而将最坏效率降至O(log n)，如AVL树、红黑树等。
- > 一般的二叉查找树的查询复杂度取决于目标结点到树根的距离（即深度），因此当结点的深度普遍较大时，查询的均摊复杂度会上升。为了实现更高效的查询，产生了平衡树。在这里，平衡指所有叶子的深度趋于平衡，更广义的是指在树上所有可能查找的均摊复杂度偏低。请参见主条目[平衡树](https://zh.wikipedia.org/wiki/%E5%B9%B3%E8%A1%A1%E6%A0%91)。

>> 【[:star:][`*`]】 notes：所以其实**平衡树**（或者更准确说“**自平衡二叉查找树**”）的引入其实就是因为普通的**二叉查找树**随着插入和删除，有可能造成两边高度差距太大（极端情况下甚至退化成类似线性链表），使得查找效率下降。而平衡树每次插入或删除时会自己调节树高，不会出现查找效率下降的问题。

### `###` 平衡树

平衡树 https://zh.wikipedia.org/wiki/%E5%B9%B3%E8%A1%A1%E6%A0%91 || Self-balancing binary search tree https://en.wikipedia.org/wiki/Self-balancing_binary_search_tree

【即使是作者又改了一版，还是有些错，比如右旋那里。但总体这个文章还算可以了。】 什么是平衡二叉树（AVL） - 程序员吴师兄的文章 - 知乎 https://zhuanlan.zhihu.com/p/56066942 || 什么是平衡二叉树（AVL） https://mp.weixin.qq.com/s/zav3hOoj6eszlOM7YfgYeA || 详解什么是平衡二叉树（AVL）（修订补充版） https://mp.weixin.qq.com/s/AweeCscNoLM2kKRA6Q_U8A
- > 在计算机科学中，AVL树是最早被发明的自平衡二叉查找树。在AVL树中，任一节点对应的两棵子树的最大高度差为1，因此它也被称为高度平衡树。查找、插入和删除在平均和最坏情况下的时间复杂度都是O(log n)。增加和删除元素的操作则可能需要借由一次或多次树旋转，以实现树的重新平衡。AVL 树得名于它的发明者 G. M. Adelson-Velsky 和 Evgenii Landis，他们在1962年的论文《An algorithm for the organization of information》中公开了这一数据结构。
- > 1 为什么要有平衡二叉树
  >
  > 二叉搜索树一定程度上可以提高搜索效率，但是当原序列有序时，例如序列 A = {1，2，3，4，5，6}，构造二叉搜索树如图 1.1。依据此序列构造的二叉搜索树为右斜树，同时二叉树退化成单链表，搜索效率降低为 O(n)。
- > 3 平衡因子
  > 
  > 定义：某节点的左子树与右子树的高度(深度)差即为该节点的平衡因子（BF,Balance Factor），平衡二叉树中不存在平衡因子大于 1 的节点。在一棵平衡二叉树中，节点的平衡因子只能取 0 、1 或者 -1 ，分别对应着左右子树等高，左子树比较高，右子树比较高。
- > **最小失衡子树**：在新插入的结点向上查找，以第一个平衡因子的绝对值超过 1 的结点为根的子树称为最小不平衡子树。也就是说，一棵失衡的树，是有可能有多棵子树同时失衡的。而这个时候，我们只要调整最小的不平衡子树，就能够将不平衡的树调整为平衡的树。
  > 
  > **平衡二叉树的失衡调整主要是通过旋转最小失衡子树来实现的**。根据旋转的方向有两种处理方式，左旋 与 右旋。
  > 旋转的目的就是减少高度，通过降低整棵树的高度来平衡。***哪边的树高，就把那边的树向上旋转***。
- > 5.1 左旋  
  >
  > 以图 5.1.1 为例，加入新节点 99 后， 节点 66 的左子树高度为 1，右子树高度为 3，此时平衡因子为 -2。为保证树的平衡，此时需要对节点 66 做出旋转，因为右子树高度高于左子树，对节点进行左旋操作，流程如下： <br> （1）节点的右孩子替代此节点位置 （2）右孩子的左子树变为该节点的右子树 （3）节点本身变为右孩子的左子树
  
### `###` Merge–Find Set / Disjoint-set data structure / union–find data structure

并查集 https://zh.wikipedia.org/wiki/%E5%B9%B6%E6%9F%A5%E9%9B%86 || Disjoint-set data structure https://en.wikipedia.org/wiki/Disjoint-set_data_structure

以前我不懂并查集，直到看了古惑仔... https://leetcode-cn.com/circle/article/IVTJxZ/

并查集详解 ——图文解说,简单易懂(转) https://blog.csdn.net/liujian20150808/article/details/50848646

### `###` Min-Max Tree

【Gym - 100796C 】Minimax Tree https://www.cnblogs.com/flipped/p/7113756.html

### `###` Red–black tree

红黑树 https://zh.wikipedia.org/wiki/%E7%BA%A2%E9%BB%91%E6%A0%91 || Red–black tree https://en.wikipedia.org/wiki/Red%E2%80%93black_tree

我画了 20 张图，给女朋友讲清楚红黑树 - 程序员吴师兄的文章 - 知乎 https://zhuanlan.zhihu.com/p/95892351

### `###` [Trie (Tree)](https://en.wikipedia.org/wiki/Trie) = Prefix Tree (前缀树)

- 看图轻松理解数据结构与算法系列(Trie树) https://juejin.im/post/5ba198ba5188255c7c6555c9
- Trie树（Prefix Tree）介绍 https://blog.csdn.net/lisonglisonglisong/article/details/45584721

#### Patricia trie/tree = Radix tree (基数树)

Radix tree https://en.wikipedia.org/wiki/Radix_tree || 基数树 https://zh.wikipedia.org/wiki/%E5%9F%BA%E6%95%B0%E6%A0%91
- > In computer science, a radix tree (also radix trie or compact prefix tree) is a data structure that represents a space-optimized trie (prefix tree) in which each node that is the only child is merged with its parent. The result is that the number of children of every internal node is at most the radix r of the radix tree, where r is a positive integer and a power x of 2, having x ≥ 1. Unlike regular trees, edges can be labeled with sequences of elements as well as single elements. This makes radix trees much more efficient for small sets (especially if the strings are long) and for sets of strings that share long prefixes.
- > 在计算机科学中，基数树（也叫基数特里树或压缩前缀树）是一种数据结构，是一种更节省空间的Trie（前缀树），其中作为唯一子节点的每个节点都与其父节点合并，边既可以表示为元素序列又可以表示为单个元素。 因此每个内部节点的子节点数最多为基数树的基数r ，其中r为正整数，x为2的幂，x≥1，这使得基数树更适用于对于较小的集合（尤其是字符串很长的情况下）和有很长相同前缀的字符串集合。 

#### Merkle Patricia Tree

Merkle Patricia Tree (MPT) 树详解 https://www.cnblogs.com/fengzhiwu/p/5584809.html

MPT（Merkle Patricia Trie） https://www.jianshu.com/p/e67452930dcc
