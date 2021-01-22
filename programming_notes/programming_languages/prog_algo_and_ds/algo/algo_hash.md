
# Hash related algorithms

散列函数  https://zh.wikipedia.org/wiki/%E6%95%A3%E5%88%97%E5%87%BD%E6%95%B8 || Hash function https://en.wikipedia.org/wiki/Hash_function
- > A hash function is any function that can be used to map data of arbitrary size to fixed-size values. The values returned by a hash function are called hash values, hash codes, digests, or simply hashes. The values are used to index a fixed-size table called a hash table. Use of a hash function to index a hash table is called hashing or scatter storage addressing.

Balls into bins https://en.wikipedia.org/wiki/Balls_into_bins
> CCS 2017一篇做PSI论文（Practical Multi-party Private Set Intersection from Symmetric-Key Techniques）提到过这个。利用wiki中提到的，每次随机抽2个（或多个），然后选择其中最少的那个bin把ball放进去，可以大大减少load。也就是让hash table少碰撞。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# [Cuckoo hashing](https://en.wikipedia.org/wiki/Cuckoo_hashing)

- DPDK中的cuckoo hash算法 https://www.jianshu.com/p/b09b26c9052a
- 随机算法 (Fall 2011)/Cuckoo hashing http://tcs.nju.edu.cn/wiki/index.php/%E9%9A%8F%E6%9C%BA%E7%AE%97%E6%B3%95_(Fall_2011)/Cuckoo_hashing
- Cuckoo hash算法分析——其根本思想和bloom filter一致 增加hash函数来解决碰撞 节省了空间但代价是查找次数增加 https://yq.aliyun.com/articles/398211
- Cuckoo Hashing的应用及性能优化 https://yq.aliyun.com/articles/563053

Cuckoo hashing https://en.wikipedia.org/wiki/Cuckoo_hashing

(ICALP 2008) History-Independent Cuckoo Hashing https://eprint.iacr.org/2008/358.pdf || https://link.springer.com/chapter/10.1007/978-3-540-70583-3_51

Cuckoo Hashing Visualization http://www.lkozma.net/cuckoo_hashing_visualization/

Cuckoo Hashing – Worst case O(1) Lookup! https://www.geeksforgeeks.org/cuckoo-hashing/

Cuckoo Hashing的应用及性能优化 https://developer.aliyun.com/article/563053

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter)

***早期***：
- 深夜学算法之Bloom Filter：概率游戏 https://www.jianshu.com/p/8193d7dc8348
- 布隆过滤器(Bloom Filter)详解 https://www.cnblogs.com/liyulong1982/p/6013002.html
- 那些优雅的数据结构(1) : BloomFilter——大规模数据处理利器 http://www.cnblogs.com/heaad/archive/2011/01/02/1924195.html

Bloom Filters by Example https://llimllib.github.io/bloomfilter-tutorial/zh_CN/
- > A Bloom Filter Tutorial https://github.com/llimllib/bloomfilter-tutorial
  * > https://github.com/jaybaird/python-bloomfilter

https://github.com/yaluge/bucket-bloom-filter
- > 一个在线参数计算器： https://hur.st/bloomfilter/

Bloom filter https://en.wikipedia.org/wiki/Bloom_filter

Bloom Filters – Introduction and Implementation https://www.geeksforgeeks.org/bloom-filters-introduction-and-python-implementation/

如何判断一个元素在亿级数据中是否存在?——布隆过滤器 https://www.jianshu.com/p/b7673fe996ac || https://cloud.tencent.com/developer/article/1499751

布隆过滤器(BloomFilter)原理 实现和性能测试 https://yq.aliyun.com/articles/743706

Bloom filter inverse? possible? https://stackoverflow.com/questions/40408881/bloom-filter-inverse-possible

Is there any probabilistic data structure that gives false negatives but not false positives? https://stackoverflow.com/questions/13263220/is-there-any-probabilistic-data-structure-that-gives-false-negatives-but-not-fal

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 哈希表

散列表 https://zh.wikipedia.org/wiki/%E5%93%88%E5%B8%8C%E8%A1%A8 || Hash table https://en.wikipedia.org/wiki/Hash_table
- > Not to be confused with [Hash list](https://en.wikipedia.org/wiki/Hash_list) or [Hash tree](https://en.wikipedia.org/wiki/Hash_tree).
  * https://en.wikipedia.org/wiki/Hash_list
  * https://en.wikipedia.org/wiki/Hash_tree
- > In computing, a hash table (hash map) is a data structure that implements an [associative array](https://en.wikipedia.org/wiki/Associative_array) abstract data type, a structure that can map keys to values. A hash table uses a [hash function](https://en.wikipedia.org/wiki/Hash_function) to compute an index, also called a hash code, into an array of buckets or slots, from which the desired value can be found. During lookup, the key is hashed and the resulting hash indicates where the corresponding value is stored.
