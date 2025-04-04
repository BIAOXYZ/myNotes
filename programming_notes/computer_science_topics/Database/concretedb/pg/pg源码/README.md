
--------------------------------------------------
# `#` PG代码
--------------------------------------------------

PostgreSQL Source Code https://doxygen.postgresql.org/
- postgres.c File Reference https://doxygen.postgresql.org/postgres_8c.html
  * postgres.c https://doxygen.postgresql.org/postgres_8c_source.html
- https://doxygen.postgresql.org/snapbuild_8c.html
- https://doxygen.postgresql.org/reloptions_8c_source.html

<postgres /src/include/access/reloptions.h>
https://searchcode.com/codesearch/view/5324466/

----------------------------------------------------------------------------------------------------

<<PG 内存上下文>>
http://www.zhangxiaojian.name/pg-%E5%86%85%E5%AD%98%E4%B8%8A%E4%B8%8B%E6%96%87/

图解PostgreSQL--MemoryContext(1) - 王硕的文章 - 知乎 https://zhuanlan.zhihu.com/p/350049053

【[:star:][`*`]】 深入理解 PostgreSQL 中的内存上下文（MmeoryContext） https://smartkeyerror.com/PostgreSQL-MemoryContext || MemoryContext.pdf https://github.com/SmartKeyerror/Psyduck/blob/master/database/PostgreSQL/MemoryContext.pdf
- > **3.1 Region-Based Memory Management**
  * > 这里就有必要对 PostgreSQL 的内存管理进行进一步地说明。PostgreSQL 将内存分为`内存块（Block）`和`内存片（Chunk）`，其中内存块是通过 `malloc()` 这一系统调用取得的。而一个内存块中将会有一个或者多个内存片，内存片才是 PostgreSQL 的最小存储单元。简单的理解就是 PostgreSQL 首先向操作系统要一块比较大的内存（Block），然后在对这一块大内存进行切割（Chunk），把切割之后的内存返回给调用方。
  * > 这么做的目的一方面是为了减少系统调用，在下一次的内存分配时即可直接返回给调用方，而无需进行系统调用。另一个作用就是减少额外的系统内存占用，因为 `malloc()` 所返回的内存必须要有 ***Header（或者叫 Cookie）*** 记录其内存总大小， 否则 `free()` 将无法正常工作。
  * > 下图为 VC6 编译器在进行 `malloc` 调用时返回的结果的内存布局，其中 Debug Header 只有在 Debug 模式下才会出现，***但是所分配内存区域的首、尾两端的 Cookie 却必不可少，因为它记录了一次 `malloc` 所分配的总内存，总计占用 8 Bytes***。
  * > 也就是说，我们每次使用 `malloc()` 申请 24 Bytes 的内存，系统最少消耗 32 Bytes 的内存，那么对于应用程序来说，内存的实际使用率为 24/32 = 0.75。如果我们有 100 万个 `malloc` 调用，那么将会有非常多的内存用于 Cookie 中，如此一来内存使用效率将会非常之低。
  * > 因此，PostgreSQL 使用了一种名为 Region-Based Memory Management 的内存管理方式，原理其实非常简单: 使用 `malloc` 申请较大的内存块，然后将该内存块切割成一个一个的小的内存片，将内存片返回给调用方。***当调用方使用完毕返还时，并不会直接返回给操作系统，而是添加至 Free List 这一空闲链表的指定区域内，以用于下一次的内存分配***。
- > **5. 关于内存上下文的切换**
  * > 我们能够在源码中经常看到 `MemoryContextSwitchTo()` 这个函数的调用，其作用就是将当前内存上下文切换至指定的内存上下文之中。
  * > 一个简单的例子就是系统表的缓存内存申请。当我们执行一个 Query 并且需要使用 System Catalog 时，通常会将读取到的 Catalog 缓存到内存中，以便下次更快地读取。那么这部分的内存就肯定需要在 `CacheMemoryContext` 这一内存上下文中申请，而不能在 `MessageContext` 或者是 `CurTransactionContext` 等内存上下文中申请。
- 回复里的：
  * > 大佬你好 好奇一下图是用什么软件绘制的哦
    >> Hi 我是用 https://app.diagrams.net/ 这个在线网站进行绘图的，字体使用的是 `Comic Sans MS`，最近也有在用 `monospace` 字体。【//PS：主要就是记录一下这个字体】

An introduction to Memory Contexts https://www.pgcon.org/2019/schedule/attachments/514_introduction-memory-contexts.pdf

postgresql内核开发 https://blog.csdn.net/postgres20/category_6538868.html
- postgresql源码阅读快速上手 http://blog.csdn.net/postgres20/article/details/53354330
- postgresql内核语法解析器详解 https://blog.csdn.net/postgres20/article/details/54709860

postgres 源码分析 之 insert (1)
http://blog.csdn.net/huguangshanse00/article/details/37045847

- PostgreSQL中page页结构源码解析 https://www.linuxidc.com/Linux/2015-05/117974.htm
- PostgreSQL的Page分析记录 https://my.oschina.net/Suregogo/blog/176279

PostgreSQL B+Tree论文解读1 - 北侠的文章 - 知乎 https://zhuanlan.zhihu.com/p/165149237
- > PostgreSQL数据库的nbtree索引参考了2篇论文：
  * > 《Efficient Locking for Concurrent Operations on B-Trees》：高并发读写的原理；
  * > 《A SYMMETRIC CONCURRENT B-TREE ALGORITHM》：高并发删除的原理；

文章 https://blog.csdn.net/qq_37517281?type=blog
- PostgreSql源码阅读笔记9（参考husthxd在ITPUB的博客） https://blog.csdn.net/qq_37517281/article/details/104484006
- PostgreSql源码阅读笔记10（参考husthxd在ITPUB的博客） https://blog.csdn.net/qq_37517281/article/details/105524880

PostgreSQL执行路径生成的代码阅读笔记 https://www.modb.pro/db/12288

postgres的initdb解析——从一次插件升级失败说起 https://www.cnblogs.com/flying-tiger/p/8385208.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# leehao

PostgreSQL执行引擎简介 http://www.leehao.org/postgresql-executioneng/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 那海蓝蓝

数据库 https://blog.csdn.net/fly2nn/category_806804.html
- 深入理解缓冲区（九） https://blog.csdn.net/fly2nn/article/details/6854316

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# mingjie https://cloud.tencent.com/developer/user/2061863

Postgresql源码分析 https://cloud.tencent.com/developer/column/95448

pgsql https://blog.csdn.net/jackgo73/category_8879705.html

~~Postgresql源码（1）Tuple组装工厂 https://cloud.tencent.com/developer/article/2000622~~  【//已转移】

Postgresql源码（25）子事务可见性判断和性能问题 https://blog.csdn.net/jackgo73/article/details/122363386

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 王果壳 https://cloud.tencent.com/developer/article/1127404

原 PostgreSQL源码中的List和ListCell的说明 https://cloud.tencent.com/developer/article/1127404
- > 1、其中如果这是一个由 `int` 或者 `Oid` 构成的 `List`，那么 `ListCell` 直接存储 `int` 或者 `Oid`。若不是，则使用 `void*` 来存储，这样可以存储的类型就多了。一般用的时候直接使用强制转换为 `(Type *)` 即可使用。
- > 接下来是有 `ListCell` 组成的 `List`，`List`，没有将整个链存储起来，仅仅将由 `ListCell` 组成的线性链表的头和尾。在做查询的时候，也仅仅是通过头进行向后查询。同时还存储了链的两个属性：（1）ListCell的个数；（2）List的类型（T_List, T_IntList, or T_OidList）。
- > List的类型是在构建List的时候指定的：
- > 遍历List的方法为：
  ```c
  #define foreach(cell, l)	\
  	for ((cell) = list_head(l); (cell) != NULL; (cell) = lnext(cell))
  #define for_each_cell(cell, initcell)	\
  	for ((cell) = (initcell); (cell) != NULL; (cell) = lnext(cell))
  ```
- > 方法有许多，可以参考 `pg_list.h`。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Zhenglong Li (SmartKeyerror)

PostgreSQL 中的 MVCC (01)——基本可见性判断 https://smartkeyerror.com/PostgreSQL-MVCC-01 || https://github.com/SmartKeyerror/Psyduck/blob/master/database/PostgreSQL/PostgreSQL%20%E4%B8%AD%E7%9A%84%20MVCC.pdf

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

第 0 课 PostgreSQL 系列文章列表 https://www.jianshu.com/p/a9b12ca52caa
- > 我在喜马拉雅上分享声音 [《PostgreSQL数据库内核分析》](https://www.ximalaya.com/keji/17008073/)，点开链接可以听听，有点意思。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

PostgreSQL查询SQL的语法分析（1）——词法分析 https://www.jianshu.com/p/1c8183d93eae

从Raw parse tree 到Query tree — PostgreSQL 查询处理第一步（1） https://jnxnj.wordpress.com/2008/04/20/%E4%BB%8Eraw-parse-tree-%E5%88%B0query-tree-postgresql-%E6%9F%A5%E8%AF%A2%E5%A4%84%E7%90%86%E7%AC%AC%E4%B8%80%E6%AD%A5%EF%BC%881-%EF%BC%89/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

postgres代码解析 https://www.zhihu.com/column/c_1660357508995837952
- postgres外存管理之fsm - 朝闻夕死的文章 - 知乎 https://zhuanlan.zhihu.com/p/649713391
- postgres外存管理之vm - 朝闻夕死的文章 - 知乎 https://zhuanlan.zhihu.com/p/649717804
- postgres查询分析(parser) - 朝闻夕死的文章 - 知乎 https://zhuanlan.zhihu.com/p/656626486
- page prune - 朝闻夕死的文章 - 知乎 https://zhuanlan.zhihu.com/p/665245660

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
