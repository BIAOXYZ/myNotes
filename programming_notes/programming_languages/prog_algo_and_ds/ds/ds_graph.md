
# 图

Tarjan算法 https://zh.wikipedia.org/wiki/Tarjan%E7%AE%97%E6%B3%95 || Tarjan's strongly connected components algorithm https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm

克鲁斯克尔算法 https://zh.wikipedia.org/wiki/%E5%85%8B%E9%B2%81%E6%96%AF%E5%85%8B%E5%B0%94%E6%BC%94%E7%AE%97%E6%B3%95 || Kruskal's algorithm https://en.wikipedia.org/wiki/Kruskal%27s_algorithm

最小生成树-Prim算法和Kruskal算法 https://www.cnblogs.com/biyeymyhjob/archive/2012/07/30/2615542.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 最短路径

- 最短路径—Dijkstra算法和Floyd算法 https://www.cnblogs.com/biyeymyhjob/archive/2012/07/31/2615833.html
- 数据结构与算法（14）：最短路算法 https://plushunter.github.io/2017/07/28/%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84%E4%B8%8E%E7%AE%97%E6%B3%95%EF%BC%8814%EF%BC%89%EF%BC%9A%E6%9C%80%E7%9F%AD%E8%B7%AF%E7%AE%97%E6%B3%95/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Tarjan算法

60 分钟搞定图论中的 Tarjan 算法（一） - 力扣（LeetCode）的文章 - 知乎 https://zhuanlan.zhihu.com/p/101923309

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 图的表示法

算法与数据结构（2）——图的表示法与常用的转化算法 https://www.cnblogs.com/liushang0419/archive/2011/05/06/2039386.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 邻接表和邻接矩阵

邻接表 https://zh.wikipedia.org/wiki/%E9%82%BB%E6%8E%A5%E8%A1%A8 || Adjacency list https://en.wikipedia.org/wiki/Adjacency_list
- > 可用于替代邻接表的主要有邻接矩阵。用稀疏邻接矩阵表示邻接表时，将占用更少的空间。这是因为它能避免为不存在的边分配任何空间。在一台32位计算机上，如果使用原始的数组结构实现邻接表，那么对于一个无向图来说，它大约需要占用 `8e` 字节的存储空间，其中e表示边的个数。每条边都将会在两个邻接表中重复出现，并分别占用4字节空间。
- > 相反地，由于邻接矩阵中的每个元素仅占用一位（bit），故可以以非常紧密的方式来存储，仅占用 `n^{2}/8` 个字节，其中n代表顶点个数。除了节省空间外，这种紧密存储也发扬了locality of reference。

邻接矩阵 https://zh.wikipedia.org/wiki/%E9%82%BB%E6%8E%A5%E7%9F%A9%E9%98%B5 || Adjacency matrix https://en.wikipedia.org/wiki/Adjacency_matrix

数据结构与算法 -图的存储与遍历(邻接表与邻接矩阵) https://juejin.im/post/5eab9260f265da7be769db1e

Graph and its representations https://www.geeksforgeeks.org/graph-and-its-representations/

Is there any other Data structure to represent Graph other than Adjacency List or Adjacency Matrix? https://stackoverflow.com/questions/49612663/is-there-any-other-data-structure-to-represent-graph-other-than-adjacency-list-o
- > There are alternatives to the adjacency list or the adjacency matrix, such as **edge list**, **adjacency map** or **forward star** to name a few.

## 邻接表

`785. 判断二分图` https://leetcode-cn.com/problems/is-graph-bipartite/

`1. 邻接表无向图的介绍` https://alleniverson.gitbooks.io/data-structure-and-algorithms/9.%E5%9B%BE%E8%AE%BA/%E9%82%BB%E6%8E%A5%E8%A1%A8%E6%97%A0%E5%90%91%E5%9B%BE.html

Adjacency List https://www.programiz.com/dsa/graph-adjacency-list
