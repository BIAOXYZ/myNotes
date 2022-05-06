
# Search Algorithm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# BTS and DTS general

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## wiki等较权威链接

树的遍历 https://zh.wikipedia.org/wiki/%E6%A0%91%E7%9A%84%E9%81%8D%E5%8E%86 || Tree traversal https://en.wikipedia.org/wiki/Tree_traversal
- > 遍历方式的命名，源于其访问节点的顺序。最简单的划分：是深度优先（先访问子节点，再访问父节点，最后是第二个子节点）？还是广度优先（先访问第一个子节点，再访问第二个子节点，最后访问父节点）？ 深度优先可进一步按照根节点相对于左右子节点的访问先后来划分。如果把左节点和右节点的位置固定不动，那么根节点放在左节点的左边，称为前序（pre-order）、根节点放在左节点和右节点的中间，称为中序（in-order）、根节点放在右节点的右边，称为后序（post-order）。对广度优先而言，遍历没有前序中序后序之分：给定一组已排序的子节点，其“广度优先”的遍历只有一种唯一的结果。

图的遍历 https://zh.wikipedia.org/wiki/%E5%9B%BE%E7%9A%84%E9%81%8D%E5%8E%86 || Graph traversal https://en.wikipedia.org/wiki/Graph_traversal

Breadth-first search https://en.wikipedia.org/wiki/Breadth-first_search || 广度优先搜索 https://zh.wikipedia.org/wiki/%E5%B9%BF%E5%BA%A6%E4%BC%98%E5%85%88%E6%90%9C%E7%B4%A2

Depth-first search https://en.wikipedia.org/wiki/Depth-first_search || 深度优先搜索 https://zh.wikipedia.org/wiki/%E6%B7%B1%E5%BA%A6%E4%BC%98%E5%85%88%E6%90%9C%E7%B4%A2

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 其他链接

How to implement a ​breadth-first search in Python https://www.educative.io/edpresso/how-to-implement-a-breadth-first-search-in-python

Breadth first search https://www.programiz.com/dsa/graph-bfs

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# BTS and DTS (Tree)

【[:star:][`*`]】 python 实现二叉树的深度&&广度优先遍历 https://juejin.im/post/5bc932446fb9a05d147855de

用Python实现树的BFS与DFS https://www.jianshu.com/p/d2125448270b

Tree Traversal - inorder, preorder and postorder https://www.programiz.com/dsa/tree-traversal

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Morris遍历 (Tree)

神级遍历——morris - god-jiang的文章 - 知乎 https://zhuanlan.zhihu.com/p/101321696

Morris Traversal方法遍历二叉树（非递归，不用栈，O(1)空间） https://www.cnblogs.com/anniekim/archive/2013/06/15/morristraversal.html || https://www.jianshu.com/p/d2059062efac
- > 通常，实现二叉树的前序（preorder）、中序（inorder）、后序（postorder）遍历有两个常用的方法：一是递归(recursive)，二是使用栈实现的迭代版本(stack+iterative)。这两种方法都是O(n)的空间复杂度（递归本身占用stack空间或者用户自定义的stack），所以不满足要求。（用这两种方法实现的中序遍历实现可以参考这里。）
- > Morris Traversal方法可以做到这两点，与前两种方法的不同在于该方法只需要O(1)空间，而且同样可以在O(n)时间内完成。
- > Morris只提供了中序遍历的方法，在中序遍历的基础上稍加修改可以实现前序，而后续就要再费点心思了。所以先从中序开始介绍。

What is Morris traversal? https://www.educative.io/edpresso/what-is-morris-traversal

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# BTS and DTS (graph)

【[:star:][`*`]】 图的遍历之 深度优先搜索和广度优先搜索 https://www.cnblogs.com/skywang12345/p/3711483.html
- > 这里分别给出"邻接矩阵无向图"、"邻接表无向图"、"邻接矩阵有向图"、"邻接表有向图"的C/C++/Java搜索算法源码。这里就不再对源码进行说明，please RTFSC；参考源码中的注释进行了解。
  * > `1. C语言源码` -- `1.1 邻接矩阵实现的无向图(matrixudg.c)` https://github.com/wangkuiwu/datastructs_and_algorithm/blob/master/source/graph/iterator/udg/c/matrix_udg.c || http://wangkuiwu.github.io/2013/04/06/basic-matrix-udg-c/

图的深度优先遍历和广度优先遍历 https://www.jianshu.com/p/2c2cdcb9de9d

DFS（图论） https://oi-wiki.org/graph/dfs/

BFS（图论） https://oi-wiki.org/graph/bfs/

Python图的BFS与DFS https://blog.csdn.net/qq_37738656/article/details/83027943

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 二分查找(折半查找) 

二分查找算法 https://zh.wikipedia.org/wiki/%E4%BA%8C%E5%88%86%E6%90%9C%E5%B0%8B%E6%BC%94%E7%AE%97%E6%B3%95 || Binary search algorithm https://en.wikipedia.org/wiki/Binary_search_algorithm

二分 https://oi-wiki.org/basic/binary/

二分查找有几种写法？它们的区别是什么？ - 知乎 https://www.zhihu.com/question/36132386
- 二分查找有几种写法？它们的区别是什么？ - Jason Li的回答 - 知乎 https://www.zhihu.com/question/36132386/answer/530313852

二分查找法的实现和应用汇总 https://www.cnblogs.com/ider/archive/2012/04/01/binary_search.html

`704. 二分查找` https://leetcode-cn.com/problems/binary-search/
- https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/000704/README.md

程序员，你应该知道的二分查找算法 https://juejin.im/post/5d510f76f265da039a287a30

Finding a value in a sorted sequence https://www.topcoder.com/community/competitive-programming/tutorials/binary-search

Binary Search https://www.programiz.com/dsa/binary-search

What is a binary search? https://www.educative.io/edpresso/what-is-a-binary-search

Data Structure and Algorithms -- Binary Search https://www.tutorialspoint.com/data_structures_algorithms/binary_search_algorithm.htm
