
# `#` [Tree](https://en.wikipedia.org/wiki/Tree_(data_structure))
***// 决定按字母顺序排列各种树，因为实在太多了。有些看起来不是按字母顺序排的，是因为它是某种树的子类型。***

Robert Tarjan https://amturing.acm.org/award_winners/tarjan_1092048.cfm || https://en.wikipedia.org/wiki/Robert_Tarjan
- > An early and well-known example of this work is Tarjan's analysis of the “union-find” data structure. The union-find problem is to maintain a collection of disjoint sets so as to efficiently perform two operations: union, which joins two sets into a single set, and find, which returns the set containing a specified element. Representing each set as a tree, two simple methods were used to give improved performance: union by weight and path compression, but their impact was not completely understood.
- Self-balancing binary search tree https://en.wikipedia.org/wiki/Self-balancing_binary_search_tree || 平衡树 https://zh.wikipedia.org/wiki/%E5%B9%B3%E8%A1%A1%E6%A0%91
- Splay tree https://en.wikipedia.org/wiki/Splay_tree || 伸展树 https://zh.wikipedia.org/wiki/%E4%BC%B8%E5%B1%95%E6%A0%91
- 【还有这个，但是不是树】 Fibonacci heap https://en.wikipedia.org/wiki/Fibonacci_heap

树 (数据结构) https://zh.wikipedia.org/zh-cn/%E6%A0%91_(%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84)

平衡二叉树、B树、B+树、B`*`树 理解其中一种你就都明白了 - 勤劳的小手的文章 - 知乎 https://zhuanlan.zhihu.com/p/27700617

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

# `#` 二叉树 / Binary tree

二叉树 https://zh.wikipedia.org/wiki/%E4%BA%8C%E5%8F%89%E6%A0%91 || Binary tree https://en.wikipedia.org/wiki/Binary_tree

## `##` 关于`完全二叉树`和`满二叉树`（以及`完美二叉树`）的定义区别和混淆

>> notes：中文圈就是上面三种说法；英文圈是 full binary tree、complete binary tree、perfect binary tree（全都没有维基百科的单独词条）。
>>> notes2：其实树这个概念下的各种类型的树造成的混淆本来就非常多，能准确知道意思就行，不用太纠结统一的名称。

为什么说“满二叉树也是完全二叉树”？ - 知乎 https://www.zhihu.com/question/19809666

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `##` 二叉搜索树 / Binary Search Tree (BST)

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

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `##` 平衡树

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

平衡二叉树,AVL树之图解篇 https://www.cnblogs.com/suimeng/p/4560056.html
- > 平衡因子：左子树的高度减去右子树的高度。由平衡二叉树的定义可知，平衡因子的取值只可能为0,1,-1.分别对应着左右子树等高，左子树比较高，右子树比较高。
- > 最小失衡子树：在新插入的结点向上查找，以第一个平衡因子的绝对值超过1的结点为根的子树称为最小不平衡子树。也就是说，一棵失衡的树，是有可能有多棵子树同时失衡的，如下。而这个时候，我们只要调整最小的不平衡子树，就能够将不平衡的树调整为平衡的树。

【from LeetCode】：
- `LC230. 二叉搜索树中第K小的元素` https://leetcode-cn.com/problems/kth-smallest-element-in-a-bst/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

### `###` Min-Max Tree

【Gym - 100796C 】Minimax Tree https://www.cnblogs.com/flipped/p/7113756.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

### `###` Red–black tree

红黑树 https://zh.wikipedia.org/wiki/%E7%BA%A2%E9%BB%91%E6%A0%91 || Red–black tree https://en.wikipedia.org/wiki/Red%E2%80%93black_tree

我画了 20 张图，给女朋友讲清楚红黑树 - 程序员吴师兄的文章 - 知乎 https://zhuanlan.zhihu.com/p/95892351

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

### `###` [Trie (Tree)](https://en.wikipedia.org/wiki/Trie) = Prefix Tree (前缀树) = 字典树

Trie https://zh.wikipedia.org/wiki/Trie || Trie https://en.wikipedia.org/wiki/Trie
- > Trie这个术语来自于retrieval。根据词源学，trie的发明者Edward Fredkin把它读作/ˈtriː/ "tree"。但是，其他作者把它读作/ˈtraɪ/ "try"。

字典树 (Trie) https://oi-wiki.org/string/trie/

【动画】看动画轻松理解「Trie树」 https://juejin.im/post/6844903750490914829

【from LeetCode】：
- `208. 实现 Trie (前缀树)` https://leetcode-cn.com/problems/implement-trie-prefix-tree/
- `211. 添加与搜索单词 - 数据结构设计` https://leetcode-cn.com/problems/design-add-and-search-words-data-structure/

pygtrie https://github.com/google/pygtrie || https://pypi.org/project/pygtrie/

Trie | (Insert and Search) https://www.geeksforgeeks.org/trie-insert-and-search/

python 实现 trie(字典) 树 https://blog.csdn.net/ANNILingMo/article/details/80879910

Python实现简单字典树（Trie） https://www.jianshu.com/p/9dae246f6ff6

#### Patricia trie/tree = Radix tree (基数树)

Radix tree https://en.wikipedia.org/wiki/Radix_tree || 基数树 https://zh.wikipedia.org/wiki/%E5%9F%BA%E6%95%B0%E6%A0%91
- > In computer science, a radix tree (also **radix trie** or **compact prefix tree**) is a data structure that represents a space-optimized [trie]() (prefix tree) in which each node that is the only child is merged with its parent. The result is that the number of children of every internal node is at most the radix r of the radix tree, where r is a positive integer and a power x of 2, having x ≥ 1. Unlike regular trees, edges can be labeled with sequences of elements as well as single elements. This makes radix trees much more efficient for small sets (especially if the strings are long) and for sets of strings that share long prefixes.
- > 在计算机科学中，基数树（也叫**基数特里树**或**压缩前缀树**）是一种数据结构，是一种更节省空间的Trie（前缀树），其中作为唯一子节点的每个节点都与其父节点合并，边既可以表示为元素序列又可以表示为单个元素。 因此每个内部节点的子节点数最多为基数树的基数r ，其中r为正整数，x为2的幂，x≥1，这使得基数树更适用于对于较小的集合（尤其是字符串很长的情况下）和有很长相同前缀的字符串集合。 

#### Merkle Patricia Tree

Merkle Patricia Tree (MPT) 树详解 https://www.cnblogs.com/fengzhiwu/p/5584809.html

MPT（Merkle Patricia Trie） https://www.jianshu.com/p/e67452930dcc

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
