
数据量较大，数据库选型问题 https://www.v2ex.com/t/1007852
```console
接了个新项目，数据量大概上亿，业务类型主要是订单数据，插入为主，简单的查询和统计，按公司传统的方案要不就是上 mycat,或者用 Sharding-JDBC,
这些在公司内部都有一定的使用量的，不过个人想看看其他方案，简单做了一下调研，有几个备选：
  1.GreenPlum ，开源，支持 OLTP 和 OLAP ，分布式数据库， 
  2.TiDB,公司其他项目有使用，据说对磁盘有一定的要求。 
  3.Oceanbase ，开源 不知道各位有没有相关的建议和使用经验。
```
- > 你们调研过 clickhouse 嘛？
  >> clickhouse 不是分析的吗，我们就简单查询和统计，写入的时候有事务要求的
- > 我们这是 mysql + clickhouse。用 mysql 做事务性的写入，然后同步到 clickhouse。蛮多数据的，好几张上亿条数据的表。因为统计分析比较多，mysql 完全扛不住
- > ***我之前用过托管的 TiDB ，反正统计分析性能被 Clickhouse 甩出几条街，其他的不好说***，但是都不看好。还是看你们的需求
- > 我们用的 pg ，不过有的查询已经挺慢了
- > 你不知道用啥就 postgresql 完事
- > mycat: 太古老了，而且没人修 bug ，觉得不会出现新 bug 的话偷懒可以用 <br> Sharding-JDBC： 万金油解决方案，开源的首选，没有比这个更好的了。有更好的都是闭源 <br> GreenPlum：貌似偏向分析的，不太推荐 <br> TiDB：太耗机器了，有钱人首选 <br> Oceanbase：没有完全开源，也非常耗机器，有钱人考虑
- > 写入和分析分开，放一起不是自找麻烦吗 <br> 上面 mysql+clickhouse 的方案，我现在也在用 <br> mysql 冷热分离，clickhouse 单机 32gb 足够了
- > 你得说下你具体的查询逻辑啊。你也别小看 MySQL ，上亿数据算啥，我之前在头部前三的商城负责订单业务，就是 MySQL 单表存上亿数据啊
  ```console
  1.如果需要事物，无脑 MySQL Oracle pg 三选一
  2.不需要事物，是否需要实时性？需要，ck sr doris 三选一，看你需求。不需要，走离线数仓那一套
  3.c 端高 qps 查询，es
  ```
- > 歪一个 其实 mysql 单表不建议上亿是上古时代的说法，现代硬件和数据库版本完全能支撑，我们几千万的表用起来跟普通表基本没什么区别，做好索引就行

数据库设计时，主表中有唯一业务编码字段，关联表还需要设计外键吗 https://www.v2ex.com/t/999254
- > 外键比较少用了，做删除时有点麻烦，如果有 db 迁移也麻烦
- > 早就不用物理外键了，都是逻辑外键。
- > 别用物理外键 大坑
- > 楼上说不用物理外键的，这还是要看具体情况。一些项目并发不高，数据量不大，但对数据准确性要求高，还是能用外键的。一般大部分互联网公司不用外键 看楼主的描述，可能是一些工业项目呢
- > 楼上有人提到了，要看具体业务，据我所了解到的，互联网公司很多都是不用物理外键的，但金融行业，比如我目前就职的某个外资银行，就有很多地方会用到，物理外键能在数据库层面保证数据的一致性，逻辑外键的话，代码要是有 bug ，导致的数据问题，要修复的话很麻烦。
- > 只要你的数据库只有你的程序能写，并且你的程序能可靠地约束写入的数据的正确性，多步操作失败时能有效回滚，数据库可以不加外键。这个就看实力了。。如果项目不大也不用考虑后续运维菜鸡的问题，所以我建议数据库顶得住，加个外键约束挺好的。
- > 现在很少有用外键的，性能受限

云数据库也太贵了，小规模使用有什么优势吗？ https://www.v2ex.com/t/993114

关于存储选型问题 https://www.v2ex.com/t/991770
- > 没事别玩 hbase,你把握不住
  >> 哈哈哈，HBase 确实容易出问题

【[:star:][`*`]】 数据库/存储学习路径推荐 https://www.v2ex.com/t/913147
```console
必看课程
  - CMU-15445 和 CMU-15721 https://www.youtube.com/@CMUDatabaseGroup
  - 这两个不用多说，经典的数据库入门教程，由数据库的大佬 Andy Pavlo 亲自授课。可以了解到数据库的基本概念，例如存储、BufferPool 管理、索引、优化器、执行器、事务、MVCC 等。
  - 15445 的实验部分是基于其开源的教学项目 bustub，补全其中几个重要的部分，这个项目是 C++ 写的，如果对 C++ 不熟悉的话，那么我觉得实验部分可以暂时跳过，有多余的精力再来搞，毕竟我们是来学数据库的，而不是学 C++ 的。

存储小项目
  - 学习教学课程的同时，顺便可以了解下存储方面的内容，例如 B+ 树，bitcask ，LSM Tree ，以及 LSM Tree 的优化 Wisckey ，不用专门去学，找几篇文章看看，了解下基本概念，或者直接看看论文。
  - 然后自己去实践写一个，例如写一个简单的 bitcask 、B+ 树存储引擎，或者 LSM 存储引擎。
  - 之所以推荐写存储类的小项目，主要是因为存储层的 KV 一般比较好实现，同时又能够了解到一些数据库的基本设计理念。
  - 这里推荐下我的两个项目：
      * https://github.com/flower-corp/rosedb
      * https://github.com/flower-corp/lotusdb

事务 /MVCC

分布式
  - 这部分内容首推 Mit.6824 ，分布式系统入门的首选课程。 https://www.youtube.com/@6.824/videos 有精力的话可以跟着把实验部分做完。
  - 然后可以挑战下 PingCAP 的 talent plan 中的 TinyKV ，它和 6824 的实验部分比较类似，实现一个基于 raft 的分布式 KV 存储系统，难度比较大，但是代码框架已经搭好了，只需要往里面添加内容即可，测试也比较完备。 https://github.com/talent-plan/tinykv
  - 如果还有时间的话，可以再上一个台阶，挑战下 PingCAP talent plan 的 TinySQL 项目，主要是实现一个简单的分布式数据库项目，有完备的文字教程 https://github.com/talent-plan/tinysql
```
- > 分享一本关于数据库事务的书，Jim Gray 的《 Transaction Processing: Concepts and Techniques 》
- > 另外，TiDB 的这个整理也挺好的 https://github.com/pingcap/awesome-database-learning <br> 以及里面提到的一些书： https://drive.google.com/drive/folders/1x7SaYLmcdQb3kkk0_ZMIHDgDDE-YwNge?usp=sharing

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
