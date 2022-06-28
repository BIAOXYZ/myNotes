
# [LevelDB](http://leveldb.org/) general

- http://leveldb.org/  //官网都砍了。。。
- https://github.com/google/leveldb

LevelDB key/value database in Go. https://github.com/syndtr/goleveldb

# LevelDB 原理/源码

LevelDB 原理解析：数据的读写与合并是怎样发生的？ https://www.infoq.cn/article/h0bmx47zzmjt9yqlpavw || https://mp.weixin.qq.com/s/LIENlLDeF8shOnvhksR9RQ

【from draveness】:
- 浅析Bigtable和LevelDB的实现 https://draveness.me/bigtable-leveldb || https://www.infoq.cn/article/fx6aXJ7ijkPlQwPWKalS

leveldb-handbook https://github.com/rjl493456442/leveldb-handbook || https://leveldb-handbook.readthedocs.io/zh/latest/

深入浅出LevelDB https://mrcroxx.github.io/categories/%E6%B7%B1%E5%85%A5%E6%B5%85%E5%87%BAleveldb/
- 深入浅出LevelDB —— 01 Architecture https://mrcroxx.github.io/posts/code-reading/leveldb-made-simple/1-architecture/
- 深入浅出LevelDB —— 10 Read & Write https://mrcroxx.github.io/posts/code-reading/leveldb-made-simple/10-read-write/

漫谈 LevelDB 数据结构（三）：LRU 缓存（ LRUCache） - 木鸟杂记的文章 - 知乎 https://zhuanlan.zhihu.com/p/370972240

LevelDB源码剖析 https://www.zhihu.com/column/c_1282795241104465920
- [LevelDB] 存储3：有备无患——WAL - zw Huang的文章 - 知乎 https://zhuanlan.zhihu.com/p/258091002

LevelDB 完全解析 https://www.zhihu.com/column/c_1258068131073183744
- LevelDB 完全解析（9）：写操作 - FOCUS的文章 - 知乎 https://zhuanlan.zhihu.com/p/149796289

当前标签：leveldb https://www.cnblogs.com/xueqiuqiu/tag/leveldb/
- LevelDB的源码阅读（三） Put操作 https://www.cnblogs.com/xueqiuqiu/p/8296324.html

LevelDB详解 - CSDN博客 https://blog.csdn.net/linuxheik/article/details/52768223

Leveldb二三事 https://segmentfault.com/a/1190000009707717

数据分析与处理之二（Leveldb 实现原理） https://www.cnblogs.com/haippy/archive/2011/12/04/2276064.html

https://juejin.cn/user/3104676535872733/posts
- LevelDB 入门 —— 全面了解 LevelDB 的功能特性 https://juejin.cn/post/6844903751346716686
- 鸿篇巨制 —— LevelDB 的整体架构 https://juejin.cn/post/6844903758627864589
- 深入 LevelDB 数据文件 SSTable 的结构 https://juejin.cn/post/6844903779112845319

LevelDB深入浅出之整体架构 - itworld123的文章 - 知乎 https://zhuanlan.zhihu.com/p/67833030
- > **设计思路**
  * > 做存储的同学都很清楚，***对于普通机械磁盘顺序写的性能要比随机写大很多。比如对于15000转的SAS盘，4K写IO， 顺序写在200MB/s左右，而随机写性能可能只有1MB/s左右***。而LevelDB的设计思想正是利用了磁盘的这个特性。 LevelDB的数据是存储在磁盘上的，采用LSM-Tree的结构实现。LSM-Tree将磁盘的随机写转化为顺序写，从而大大提高了写速度。为了做到这一点LSM-Tree的思路是将索引树结构拆成一大一小两颗树，较小的一个常驻内存，较大的一个持久化到磁盘，他们共同维护一个有序的key空间。写入操作会首先操作内存中的树，随着内存中树的不断变大，会触发与磁盘中树的归并操作，而归并操作本身仅有顺序写。

# LevelDB 安装、调试

leveldb编译与调试 http://mingxinglai.com/cn/2015/08/gdb-leveldb/

初识：LevelDB https://www.debugger.wiki/article/html/1594740966069758

# LevelDB 使用

leveldb 日常使用 https://juejin.cn/post/6844903978061283341 || https://quant67.com/post/db/leveldb/ussage.html

LevelDB C API 整理分类 https://www.cnblogs.com/pandang/p/7279306.html

# LevelDB 性能

LevelDB性能分析和表现 https://www.51cto.com/article/267852.html

leveldb(ssdb)性能、使用场景评估 https://www.cnblogs.com/lulu/p/4231810.html

键值数据库LevelDB的优缺点及性能分析 https://www.modb.pro/db/181292

从LevelDB谈存储与检索 https://juejin.cn/post/6844904113122050055

【深度知识】区块链数据库LevelDB从入门到原理详解 https://learnblockchain.cn/article/728
