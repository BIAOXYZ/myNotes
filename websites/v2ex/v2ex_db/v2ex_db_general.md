
【[:star:][`*`]】 《DDIA 逐章精读》小册和逐章分享 https://www.v2ex.com/t/876038
- > 在理解[《 Designing Data-Intensive Applications 》英文原文](https://dataintensive.net/)的基础上，结合我的几年存储和数据库开发工作经验，进行一些相应的解读和扩展，并参考 github 上 [Vonng 的中文翻译版](https://github.com/Vonng/ddia)，对每一章用中文逐句翻译、梳理、重新组织，作为每次分享的文字稿，在此 集结为一本开源小册：[《DDIA 逐章精读》](https://ddia.qtmuniao.com/)，希望可以对喜欢分布式系统、数据系统、系统设计的同学有所帮助. 水平所限，精力所囿，难免疏漏，如发现有任何有误之处，欢迎在 [repo](https://github.com/DistSysCorp/ddia) 中提 issue 和 PR ，这里是每次分享的[录屏](https://space.bilibili.com/30933812/channel/collectiondetail?sid=240551)。

数据库事务 原子性和隔离性的疑问 https://www.v2ex.com/t/871401
- > RC 级别，一个事务里每次 select 可以获取到其他事务已经提交的数据。 <br> RR 级别，一个事务里每次 select 获取的数据都是快照，可以重复读。 <br> update 、delete 、select .... for update 里 where 后边的查询都是取得当前读，也就是最新的数据。
- > 建议把 pg 的隔离等级文档看一下，就比较清楚了 http://www.postgres.cn/docs/12/transaction-iso.html
- > 这些事情自己开两个 session 试一下就知道了，有现成的代码，https://github.com/ept/hermitage

操作数据库 update 忘了加 where https://www.v2ex.com/t/829615

关于外键，为什么国内基本都不推荐使用，国外基本都推荐使用？ https://www.v2ex.com/t/799876

数据库做了集群后，比如 mysql，做了 mgr，双 master。那么对外提供服务时， ip 一般是怎么处理的？
- > 1.只考虑高可用，为了方便后续扩展，建议用 keepalived 作 vip，这样程序可以只需要指定唯一 IP 地址即可，而不用关心后边数据库的运维动作。 <br> 2.同时考虑负载均衡，那么再上个 haproxy 来做 4 层(TCP)代理 <br> 3.可以考虑用 dns 记录，也是比较简单的方式 <br> 3.1 dns 服务器可以用 consul 来做，同时来做服务发现自动去注册数据库服务，并做健康检查。有个缺点是可能需要其它要访问数据库的服务需要配合 dnsmasq 来做本地 hosts 和 dns 解析服务器管理

如何系统学习数据库？ https://www.v2ex.com/t/741026
- > 书：Database System Concepts 课程：CMU 15-445

LSM (Log Structured Merge Trees) 牺牲了部分读性能，以换取写入的最大化性能，有没有反过来，牺牲写性能以最大化读性能的存储结构呢？ https://www.v2ex.com/t/741006
- > RAID1 ？写入时几个磁盘同步写入，读取时如果一个磁盘繁忙，可以从其它磁盘读取。。。

关于 B+树索引的问题 https://www.v2ex.com/t/737599

MySQL B+树的 “孩子个数” 和 “key 的个数” 到底是不是相等的 https://www.v2ex.com/t/719174
- > https://15445.courses.cs.cmu.edu/fall2019/slides/07-trees1.pdf <br> 看第十页，DBMS 中世界级大佬讲的，要错就一起错了，但不管怎么样，国人写的很有问题

想要学习分布式数据库应该如何入门？ https://www.v2ex.com/t/700418
- > PingCAP University 以及 PingCAP Talent Plan 了解一下： https://university.pingcap.com/ https://university.pingcap.com/talent-plan/ 教你学习，使用和实现分布式数据库
- > 学下 6.824 和 DBMS 差不多就行了
- > 强烈推荐“DDIA” 中文书名《数据密集型应用系统设计》 跟着翻一遍就可以系统了解数据库和分布式系统了，深入的话可以跟着书中给出的论文引用走

关于“数据库系统概念 - 第 15 章 并发控制 - 15.5 基于有效性检查的协议”的疑问 https://www.v2ex.com/t/684807

事务的原子性是由 redo log 还是 undo log 实现的? https://www.v2ex.com/t/674050
- > undo log 用来保证事务的原子性以及 InnoDB 的 MVCC，redo log 用来保证事务的持久性。

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
    + 设计数据密集型应用 - 中文翻译 ~~https://legacy.gitbook.com/book/vonng/ddia-cn/details~~ || http://ddia.vonng.com/
  * 《Designing Data-Intensive Applications》 http://www.java1234.com/a/javabook/javabase/2017/0914/8912.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
