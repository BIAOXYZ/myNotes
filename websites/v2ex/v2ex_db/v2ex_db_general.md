
MySQL B+树的 “孩子个数” 和 “key 的个数” 到底是不是相等的 https://www.v2ex.com/t/719174
- > https://15445.courses.cs.cmu.edu/fall2019/slides/07-trees1.pdf <br> 看第十页，DBMS 中世界级大佬讲的，要错就一起错了，但不管怎么样，国人写的很有问题

想要学习分布式数据库应该如何入门？ https://www.v2ex.com/t/700418
- > PingCAP University 以及 PingCAP Talent Plan 了解一下： https://university.pingcap.com/ https://university.pingcap.com/talent-plan/ 教你学习，使用和实现分布式数据库
- > 学下 6.824 和 DBMS 差不多就行了
- > 强烈推荐“DDIA” 中文书名《数据密集型应用系统设计》 跟着翻一遍就可以系统了解数据库和分布式系统了，深入的话可以跟着书中给出的论文引用走

关于“数据库系统概念 - 第 15 章 并发控制 - 15.5 基于有效性检查的协议”的疑问 https://www.v2ex.com/t/684807

事务的原子性是由 redo log 还是 undo log 实现的? https://www.v2ex.com/t/674050

数据库索引笔记 https://www.v2ex.com/t/660228
- > https://use-the-index-luke.com/
- > Use the Index, Luke! 笔记1 https://www.kawabangga.com/posts/3893

关于 B+tree 索引的疑问 https://www.v2ex.com/t/657136
- > 在网上遇到自己不确定知识点的时候，最简单且有效的办法就是自己动手验证。MySQL InnoDB 存储引擎实际存储就 3 个文件: .opt, .frm, .ibd ，其中.ibd 为实际存储数据和索引的地方，聚簇索引和辅助索引数据均在该文件中。建一张测试表，写点儿数据，然后闷头分析.ibd 文件就行了。
当初我对这东西也很有疑问，动手分析了之后明白了个大概。后面自己写了篇博客，希望对你有帮助。PS: 推荐《 MySQL 技术内幕-InnoDB 存储引擎》，相信能解答你许多疑惑。
  >> MySQL物理存储方式 https://smartkeyerror.com/MySQL-physical-structure

多源数据融合，建数仓，数据统计分析一般有哪些架构和技术？区别是什么？ https://www.v2ex.com/t/625567

数据库的发展趋势是什么？ https://www.v2ex.com/t/612782
- > NoSQL 的建议看一下《 NoSql 精粹》，里面讲了不同的 nosql 数据库的擅长的地方、与关系型数据库的对比。挺薄的一本书的。作者是（著名的） Martin Fowler。
  * 《NoSQL 精粹》 http://www.java1234.com/a/javabook/database/2016/0721/6434.html
- > 看一下这本书: Designing Data-Intensive Applications, 就知道分布式(强)一致性有多么难做. 不知道 NewSQL 是怎么解决这个问题的.
  * 《Designing Data-Intensive Application》DDIA中文翻译 https://github.com/Vonng/ddia
    + 设计数据密集型应用 - 中文翻译 https://legacy.gitbook.com/book/vonng/ddia-cn/details
  * 《Designing Data-Intensive Applications》 http://www.java1234.com/a/javabook/javabase/2017/0914/8912.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
