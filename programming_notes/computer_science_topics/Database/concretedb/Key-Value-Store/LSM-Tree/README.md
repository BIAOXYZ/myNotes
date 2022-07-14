
# LSM-Tree

LSM 算法的原理是什么？ - 知乎 https://www.zhihu.com/question/19887265
- LSM 算法的原理是什么？ - wuxinliulei的回答 - 知乎 https://www.zhihu.com/question/19887265/answer/78839142
- ~~LSM 算法的原理是什么？ - henryPKU的回答 - 知乎 https://www.zhihu.com/question/19887265/answer/1714901833~~  【//已转移】
  * > 以下内容引自：[LSM Tree：一种支持高效读写的存储引擎](https://hzhu212.github.io/posts/2d7c5edb/)

深入理解什么是LSM-Tree https://cloud.tencent.com/developer/article/1441835
- > 我们总结下在在LSM-Tree里面如何写数据的？
  * > 4，把内存里面不可变的Memtable给dump到到硬盘上的SSTable层中，此步骤也称为`Minor Compaction`，这里需要注意在L0层的SSTable是没有进行合并的，所以这里的key range在多个SSTable中可能会出现重叠，在层数大于0层之后的SSTable，不存在重叠key。
  * > 5，当每层的磁盘上的SSTable的体积超过一定的大小或者个数，也会周期的进行合并。此步骤也称为`Major Compaction`，这个阶段会真正的清除掉被标记删除掉的数据以及多版本数据的合并，避免浪费空间，注意由于SSTable都是有序的，我们可以直接采用merge sort进行高效合并。

LSM-Tree - LevelDb 源码解析 https://segmentfault.com/a/1190000041864579

【from `LittleMagic`】：
- LSM Tree-Based存储引擎的compaction策略（feat. RocksDB） https://www.jianshu.com/p/e89cd503c9ae
- 从B+树到LSM树，及LSM树在HBase中的应用 https://www.jianshu.com/p/f911cb9e42de
