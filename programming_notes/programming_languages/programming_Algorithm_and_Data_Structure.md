
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

数据结构和算法必知必会的50个代码实现 https://github.com/wangzheng0822/algo


:star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star:

# Algorithm

- 最短路径—Dijkstra算法和Floyd算法 https://www.cnblogs.com/biyeymyhjob/archive/2012/07/31/2615833.html
- 数据结构与算法（14）：最短路算法 https://plushunter.github.io/2017/07/28/%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84%E4%B8%8E%E7%AE%97%E6%B3%95%EF%BC%8814%EF%BC%89%EF%BC%9A%E6%9C%80%E7%9F%AD%E8%B7%AF%E7%AE%97%E6%B3%95/

***--------------------------------------------------分割线--------------------------------------------------***

## Sort Algorithm

- 找工作知识储备(3)---从头说12种排序算法：原理、图解、动画视频演示、代码以及笔试面试题目中的应用 https://blog.csdn.net/han_xiaoyang/article/details/12163251
- 十种排序算法 https://blog.csdn.net/coolwriter/article/details/78732728
- 九大排序算法再总结 https://blog.csdn.net/xiazdong/article/details/8462393

### [Merge sort](https://en.wikipedia.org/wiki/Merge_sort)


***--------------------------------------------------分割线--------------------------------------------------***

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

:star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star::star:


# Data Structure

## [Linked list](https://en.wikipedia.org/wiki/Linked_list)

Python数据结构——链表的实现 http://python.jobbole.com/83953/

***--------------------------------------------------分割线--------------------------------------------------***

## Tree

### [Trie (Tree)](https://en.wikipedia.org/wiki/Trie)

- 看图轻松理解数据结构与算法系列(Trie树) https://juejin.im/post/5ba198ba5188255c7c6555c9
- Trie树（Prefix Tree）介绍 https://blog.csdn.net/lisonglisonglisong/article/details/45584721

#### Patricia trie/tree = [Radix tree](https://en.wikipedia.org/wiki/Radix_tree)

### Min-Max Tree

【Gym - 100796C 】Minimax Tree https://www.cnblogs.com/flipped/p/7113756.html

