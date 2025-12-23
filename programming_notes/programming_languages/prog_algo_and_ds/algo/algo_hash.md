
# Hash related algorithms

散列函数  https://zh.wikipedia.org/wiki/%E6%95%A3%E5%88%97%E5%87%BD%E6%95%B8 || Hash function https://en.wikipedia.org/wiki/Hash_function
- > A hash function is any function that can be used to map data of arbitrary size to fixed-size values. The values returned by a hash function are called hash values, hash codes, digests, or simply hashes. The values are used to index a fixed-size table called a hash table. Use of a hash function to index a hash table is called hashing or scatter storage addressing.

Balls into bins https://en.wikipedia.org/wiki/Balls_into_bins
> CCS 2017一篇做PSI论文（Practical Multi-party Private Set Intersection from Symmetric-Key Techniques）提到过这个。利用wiki中提到的，每次随机抽2个（或多个），然后选择其中最少的那个bin把ball放进去，可以大大减少load。也就是让hash table少碰撞。

Recommended Probabilistic Filter Library? (Bloom/Cuckoo/etc...) https://www.reddit.com/r/golang/comments/9i22k1/recommended_probabilistic_filter_library/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# [Cuckoo hashing](https://en.wikipedia.org/wiki/Cuckoo_hashing)

- DPDK中的cuckoo hash算法 https://www.jianshu.com/p/b09b26c9052a
- 随机算法 (Fall 2011)/Cuckoo hashing http://tcs.nju.edu.cn/wiki/index.php/%E9%9A%8F%E6%9C%BA%E7%AE%97%E6%B3%95_(Fall_2011)/Cuckoo_hashing
- Cuckoo hash算法分析——其根本思想和bloom filter一致 增加hash函数来解决碰撞 节省了空间但代价是查找次数增加 https://yq.aliyun.com/articles/398211
- Cuckoo Hashing的应用及性能优化 https://yq.aliyun.com/articles/563053

Cuckoo hashing https://en.wikipedia.org/wiki/Cuckoo_hashing

(ICALP 2008) History-Independent Cuckoo Hashing https://eprint.iacr.org/2008/358.pdf || https://link.springer.com/chapter/10.1007/978-3-540-70583-3_51

【[ :star: ][`*`]】 Cuckoo Hashing Visualization http://www.lkozma.net/cuckoo_hashing_visualization/

Cuckoo Hashing – Worst case O(1) Lookup! https://www.geeksforgeeks.org/cuckoo-hashing/

Cuckoo Hashing的应用及性能优化 https://developer.aliyun.com/article/563053

Bloom filter or cuckoo hashing? https://stackoverflow.com/questions/867099/bloom-filter-or-cuckoo-hashing

布谷鸟哈希（Cuckoo hash） - 双榆树周主任的文章 - 知乎 https://zhuanlan.zhihu.com/p/594818514
- > 布谷鸟哈希在查找时如何向量化？
  * > 每个鸟蛋有两个可能的巢穴，要么在h1(x)，要么在h2(x)，或者都不在，***但引入分支的话会让代码不能向量化执行***，工程上可以采用mask的技巧消除分支

Cuckoo Hash https://www.cnblogs.com/pam-sh/p/16047585.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter)

***早期***：
- 深夜学算法之Bloom Filter：概率游戏 https://www.jianshu.com/p/8193d7dc8348
- 布隆过滤器(Bloom Filter)详解 https://www.cnblogs.com/liyulong1982/p/6013002.html
- 那些优雅的数据结构(1) : BloomFilter——大规模数据处理利器 http://www.cnblogs.com/heaad/archive/2011/01/02/1924195.html

Bloom Filters by Example https://llimllib.github.io/bloomfilter-tutorial/zh_CN/ || A Bloom Filter Tutorial https://github.com/llimllib/bloomfilter-tutorial
- > https://github.com/jaybaird/python-bloomfilter

https://github.com/yaluge/bucket-bloom-filter
- > 一个在线参数计算器： https://hur.st/bloomfilter/

Bloom filter https://en.wikipedia.org/wiki/Bloom_filter || 布隆过滤器 https://zh.wikipedia.org/wiki/%E5%B8%83%E9%9A%86%E8%BF%87%E6%BB%A4%E5%99%A8
- > Elements can be added to the set, but not removed (though this can be addressed with the counting Bloom filter variant);
- > More generally, fewer than 10 bits per element are required for a 1% false positive probability, independent of the size or number of elements in the set.
- > If all are 1, then either the element is in the set, or the bits have by chance been set to 1 during the insertion of other elements, resulting in a false positive. In a simple Bloom filter, there is no way to distinguish between the two cases, but more advanced techniques can address this problem.
- > Specifically, Dillinger & Manolios (2004b) show the effectiveness of deriving the k indices using enhanced double hashing or triple hashing, variants of [double hashing]() that are effectively simple random number generators seeded with the two or three hash values.
  >> Double hashing https://en.wikipedia.org/wiki/Double_hashing
- > Removing an element from this simple Bloom filter is impossible because there is no way to tell which of the k bits it maps to should be cleared. Although setting any one of those k bits to zero suffices to remove the element, it would also remove any other elements that happen to map onto that bit. Since the simple algorithm provides no way to determine whether any other elements have been added that affect the bits for the element to be removed, ***clearing any of the bits would introduce the possibility of false negatives***.
  >
  > One-time removal of an element from a Bloom filter can be simulated by having a second Bloom filter that contains items that have been removed. However, false positives in the second filter become false negatives in the composite filter, which may be undesirable. In this approach re-adding a previously removed item is not possible, as one would have to remove it from the "removed" filter.
- > It is often the case that all the keys are available but are expensive to enumerate (for example, requiring many disk reads). When the false positive rate gets too high, the filter can be regenerated; this should be a relatively rare event.
- > A Bloom filter with a `1%` error and an optimal value of `k`, in contrast, requires only about `9.6` bits per element, regardless of the size of the elements. This advantage comes partly from its compactness, inherited from arrays, and partly from its probabilistic nature. The 1% false-positive rate can be `reduced by a factor of ten` by adding only about `4.8` bits per element.
- > This means that for a given false positive probability `ε`, the length of a Bloom filter `m` is proportionate to the number of elements being filtered `n` and the required number of hash functions `k` only depends on the target false positive probability `ε`.
- > 另外，一般情况下不能从布隆过滤器中删除元素。我们很容易想到把位数组变成整数数组，每插入一个元素相应的计数器加1, 这样删除元素时将计数器减掉就可以了。然而要保证安全地删除元素并非如此简单。***首先我们必须保证删除的元素的确在布隆过滤器里面***。这一点单凭这个过滤器是无法保证的。另外计数器回绕也会造成问题。

Bloom Filters – Introduction and Implementation https://www.geeksforgeeks.org/bloom-filters-introduction-and-python-implementation/

如何判断一个元素在亿级数据中是否存在?——布隆过滤器 https://www.jianshu.com/p/b7673fe996ac || https://cloud.tencent.com/developer/article/1499751

布隆过滤器(BloomFilter)原理 实现和性能测试 https://yq.aliyun.com/articles/743706

Bloom filter inverse? possible? https://stackoverflow.com/questions/40408881/bloom-filter-inverse-possible

Is there any probabilistic data structure that gives false negatives but not false positives? https://stackoverflow.com/questions/13263220/is-there-any-probabilistic-data-structure-that-gives-false-negatives-but-not-fal

Spark之BloomFilter有趣的bitwise运算 - 翟士丹的文章 - 知乎 https://zhuanlan.zhihu.com/p/51147258

Bloom filter variant https://cs.stackexchange.com/questions/24217/bloom-filter-variant

深入浅出BloomFilter原理 - 刘训灼的文章 - 知乎 https://zhuanlan.zhihu.com/p/140545941

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 哈希表

散列表 https://zh.wikipedia.org/wiki/%E5%93%88%E5%B8%8C%E8%A1%A8 || Hash table https://en.wikipedia.org/wiki/Hash_table
- > Not to be confused with [Hash list](https://en.wikipedia.org/wiki/Hash_list) or [Hash tree](https://en.wikipedia.org/wiki/Hash_tree).
  * https://en.wikipedia.org/wiki/Hash_list
  * https://en.wikipedia.org/wiki/Hash_tree
- > In computing, a hash table (hash map) is a data structure that implements an [associative array](https://en.wikipedia.org/wiki/Associative_array) abstract data type, a structure that can map keys to values. A hash table uses a [hash function](https://en.wikipedia.org/wiki/Hash_function) to compute an index, also called a hash code, into an array of buckets or slots, from which the desired value can be found. During lookup, the key is hashed and the resulting hash indicates where the corresponding value is stored.

## Load Factor

https://en.wikipedia.org/wiki/Hash_table#Load_factor

Buckets, Capacity, and Load Factor https://www.modernescpp.com/index.php/buckets-capacity-and-load-factor/

Build a Hash Table in Python With TDD https://realpython.com/python-hash-table/

What is the significance of load factor in HashMap? https://stackoverflow.com/questions/10901752/what-is-the-significance-of-load-factor-in-hashmap
