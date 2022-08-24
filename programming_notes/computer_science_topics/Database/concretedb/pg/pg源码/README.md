
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

深入理解 PostgreSQL 中的内存上下文（MmeoryContext） https://smartkeyerror.com/PostgreSQL-MemoryContext || MemoryContext.pdf https://github.com/SmartKeyerror/Psyduck/blob/master/database/PostgreSQL/MemoryContext.pdf
- > **3.1 Region-Based Memory Management**
  * > 这里就有必要对 PostgreSQL 的内存管理进行进一步地说明。PostgreSQL 将内存分为`内存块（Block）`和`内存片（Chunk）`，其中内存块是通过 `malloc()` 这一系统调用取得的。而一个内存块中将会有一个或者多个内存片，内存片才是 PostgreSQL 的最小存储单元。简单的理解就是 PostgreSQL 首先向操作系统要一块比较大的内存（Block），然后在对这一块大内存进行切割（Chunk），把切割之后的内存返回给调用方。
  * > 这么做的目的一方面是为了减少系统调用，在下一次的内存分配时即可直接返回给调用方，而无需进行系统调用。另一个作用就是减少额外的系统内存占用，因为 `malloc()` 所返回的内存必须要有 ***Header（或者叫 Cookie）*** 记录其内存总大小， 否则 `free()` 将无法正常工作。
  * > 下图为 VC6 编译器在进行 `malloc` 调用时返回的结果的内存布局，其中 Debug Header 只有在 Debug 模式下才会出现，***但是所分配内存区域的首、尾两端的 Cookie 却必不可少，因为它记录了一次 `malloc` 所分配的总内存，总计占用 8 Bytes***。
  * > 也就是说，我们每次使用 `malloc()` 申请 24 Bytes 的内存，系统最少消耗 32 Bytes 的内存，那么对于应用程序来说，内存的实际使用率为 24/32 = 0.75。如果我们有 100 万个 `malloc` 调用，那么将会有非常多的内存用于 Cookie 中，如此一来内存使用效率将会非常之低。
  * > 因此，PostgreSQL 使用了一种名为 Region-Based Memory Management 的内存管理方式，原理其实非常简单: 使用 `malloc` 申请较大的内存块，然后将该内存块切割成一个一个的小的内存片，将内存片返回给调用方。***当调用方使用完毕返还时，并不会直接返回给操作系统，而是添加至 Free List 这一空闲链表的指定区域内，以用于下一次的内存分配***。

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

# husthxd

数据库 http://blog.itpub.net/6906/cid-184206/list-1/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# mingjie https://cloud.tencent.com/developer/user/2061863

Postgresql源码（1）Tuple组装工厂 https://cloud.tencent.com/developer/article/2000622

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 王果壳 https://cloud.tencent.com/developer/article/1127404

原 PostgreSQL源码中的List和ListCell的说明 https://cloud.tencent.com/developer/article/1127404
