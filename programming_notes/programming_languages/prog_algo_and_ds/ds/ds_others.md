
# `#` Merge–Find Set / Disjoint-set data structure / union–find data structure

并查集 https://zh.wikipedia.org/wiki/%E5%B9%B6%E6%9F%A5%E9%9B%86 || Disjoint-set data structure https://en.wikipedia.org/wiki/Disjoint-set_data_structure
- > 这是并查集森林的最基础的表示方法，这个方法不会比链表法好，这是因为创建的树可能会严重不平衡；然而，可以用两种办法优化。
  * > 第一种方法，称为“按秩合并”，即总是将更小的树连接至更大的树上。
  * > 第二个优化，称为“路径压缩”，是一种在执行“查找”时扁平化树结构的方法。
  * > 这两种方法的优势互补，同时使用二者的程序每个操作的平均时间仅为`O(\alpha (n))`，`\alpha (n)`是`n=f(x)=A(x,x)`的反函数，其中`A`是急速增加的[阿克曼函数]()。因为`\alpha (n)`是其的反函数，故`\alpha (n)`在`n`十分巨大时还是小于5。因此，平均运行时间是一个极小的常数。 

以前我不懂并查集，直到看了古惑仔... https://leetcode-cn.com/circle/article/IVTJxZ/

并查集详解 ——图文解说,简单易懂(转) https://blog.csdn.net/liujian20150808/article/details/50848646

【[:star:][`*`]】 并查集 https://oi-wiki.org/ds/dsu/

算法学习笔记(1) : 并查集 - Pecco的文章 - 知乎 https://zhuanlan.zhihu.com/p/93647900

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 优先队列

优先队列 https://zh.wikipedia.org/wiki/%E5%84%AA%E5%85%88%E4%BD%87%E5%88%97 || Priority queue https://en.wikipedia.org/wiki/Priority_queue

2.4 Priority Queues https://algs4.cs.princeton.edu/24pq/

std::priority_queue http://www.cplusplus.com/reference/queue/priority_queue/

std::priority_queue https://en.cppreference.com/w/cpp/container/priority_queue

Heaps and Priority Queues https://www.hackerearth.com/practice/notes/heaps-and-priority-queues/

Priority Queue https://www.programiz.com/dsa/priority-queue

What is the Python priority queue? https://www.educative.io/edpresso/what-is-the-python-priority-queue

Data Structure - Priority Queue https://www.tutorialspoint.com/data_structures_algorithms/priority_queue.htm

Priority Queue | Set 1 (Introduction) https://www.geeksforgeeks.org/priority-queue-set-1-introduction/

堆Heap和优先队列(Priority Queue)学习小结 https://blog.csdn.net/roufoo/article/details/80638476
- > Heap是一种数据结构，能保证取max/min是O(1)时间。通常如果查最小值/最大值，我们可以用Heap。如果是查是不是存在(Contain())，就用HashMap。如果又要查最小/大值，又要查是不是存在，就用Heap+HashMap.
- > Max-heap/Min-heap保证父节点都比子节点大/小，但兄弟节点之间没有大小关系。
