
# distributed system general

List of academic papers on distributed consensus https://github.com/heidi-ann/distributed-consensus-reading-list 【这个在paperRelatedRepository也会记录一下】

awesome-distributed-systems -- A curated list to learn about distributed systems https://github.com/theanalyst/awesome-distributed-systems

Scalable, Available, Stable, Performant, and Intelligent System Design Patterns https://github.com/binhnguyennus/awesome-scalability

【general content from wikipedia】
- Consensus algorithm https://en.wikipedia.org/wiki/Consensus_algorithm
- Consensus (computer science) https://en.wikipedia.org/wiki/Consensus_(computer_science)

Paxos和Raft的前世今生 https://mp.weixin.qq.com/s/OXE7prU9cMuZG8kFydPm9A

分布式系统(Distributed System)资料 https://yq.aliyun.com/articles/8069

【from draveness】【这次这两篇文章干货不多（CAP出处那里还有点错，毕竟这作者不是搞学术的），记录下主要是因为文章里链接比较多，后面懒得找的时候可以直接用】:
- 分布式一致性与共识算法 https://draveness.me/consensus
- 分布式事务的实现原理 https://draveness.me/distributed-transaction-principle

一文总结：分布式一致性技术是如何演进的？ - 阿里技术的文章 - 知乎 https://zhuanlan.zhihu.com/p/163373813

谈谈对分布式事务的一点理解和解决方案 https://mp.weixin.qq.com/s/v7rqlz4erRC9ZvEZk6mwvg

《分布式系统模式》中文版 https://github.com/dreamhead/patterns-of-distributed-systems
- > 《分布式系统模式》（Patterns of Distributed Systems）是 Unmesh Joshi 编写的一系列关于分布式系统实现的文章。这个系列的文章采用模式的格式，介绍了像 Kafka、Zookeeper 这种分布式系统在实现过程采用的通用模式，是学习分布式系统实现的基础。

《分布式系统模式》中文版 https://github.com/dreamhead/patterns-of-distributed-systems

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# distributed transaction system

两阶段提交的工程实践 - 郁白的文章 - 知乎
https://zhuanlan.zhihu.com/p/22594180

两阶段提交及JTA http://www.cnblogs.com/Leo_wl/p/5728027.html

2PC之踵？是时候升级二阶段提交协议了 https://mp.weixin.qq.com/s/fHyvviHGBzYfOugPpbJ2lA

分布式一致性算法 - 2PC、二阶段提交协议 https://www.bilibili.com/video/BV1hP411L7hS

## Seata

由Seata看分布式事务取舍 https://www.jianshu.com/p/917cb4bdaa03 【:star:】

分布式事务框架Seata及EasyTransaction架构的比对思考 https://www.cnblogs.com/skyesx/p/10674700.html

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# Chandy-Lamport algorithm

Chandy-Lamport algorithm https://en.wikipedia.org/wiki/Chandy-Lamport_algorithm

用谁都能看懂的方法解释分布式系统, 大概.. https://zhuanlan.zhihu.com/c_158208519
- (十)简单解释: 分布式数据流的异步快照(Flink的核心) - 阿莱克西斯的文章 - 知乎 https://zhuanlan.zhihu.com/p/43536305
- 简单解释: 分布式快照(Chandy-Lamport算法) - 阿莱克西斯的文章 - 知乎 https://zhuanlan.zhihu.com/p/44454670

Distributed Snapshots http://courses.washington.edu/css434/students/DistributedSnapshots.pdf

Chandy-Lamport Snapshotting https://www.cs.princeton.edu/courses/archive/fall16/cos418/docs/P8-chandy-lamport.pdf

chandy--lamport-snapshot-algorithm https://github.com/topics/chandy--lamport-snapshot-algorithm

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# Quorum

Quorum (distributed computing) https://en.wikipedia.org/wiki/Quorum_(distributed_computing) || Quorum (分布式系统) https://zh.wikipedia.org/wiki/Quorum_(%E5%88%86%E5%B8%83%E5%BC%8F%E7%B3%BB%E7%BB%9F)
- > Quorum 机制，是一种分布式系统中常用的，用来保证数据冗余和最终一致性的投票算法，其主要数学思想来源于[鸽巢原理]()。
- > **基于Quorum投票的冗余控制算法**
  * > 在有冗余数据的分布式存储系统当中，冗余数据对象会在不同的机器之间存放多份拷贝。但是同一时刻一个数据对象的多份拷贝只能用于读或者用于写。
  * > 该算法可以保证同一份数据对象的多份拷贝不会被超过两个访问对象读写。
  * > 算法来源于[Gifford, 1979]。 分布式系统中的每一份数据拷贝对象都被赋予一票。每一个读操作获得的票数必须大于最小读票数（read quorum）（Vr），每个写操作获得的票数必须大于最小写票数（write quorum）(Vw）才能读或者写。如果系统有 V 票（意味着一个数据对象有V份冗余拷贝），那么最小读写票数(quorum)应满足如下限制：
    + > Vr + Vw > V
    + > Vw > V/2
  * > 第一条规则保证了一个数据不会被同时读写。当一个写操作请求过来的时候，它必须要获得 Vw 个冗余拷贝的许可。而剩下的数量是 V-Vw 不够 Vr，因此不能再有读请求过来了。同理，当读请求已经获得了 Vr 个冗余拷贝的许可时，写请求就无法获得许可了。
  * > 第二条规则保证了数据的串行化修改。一份数据的冗余拷贝不可能同时被两个写请求修改。
- > **算法的好处**
  * > 在分布式系统中，冗余数据是保证可靠性的手段，因此冗余数据的一致性维护就非常重要。一般而言，一个写操作必须要对所有的冗余数据都更新完成了，才能称为成功结束。比如一份数据在5台设备上有冗余，因为不知道读数据会落在哪一台设备上，那么一次写操作，必须5台设备都更新完成，写操作才能返回。
  * > 对于写操作比较频繁的系统，这个操作的瓶颈非常大。Quorum算法可以让写操作只要写完3台就返回。剩下的由系统内部缓慢同步完成。而读操作，则需要也至少读3台，才能保证至少可以读到一个最新的数据。
  * > Quorum的读写最小票数可以用来做为系统在读、写性能方面的一个可调节参数。写票数 Vw 越大，则读票数 Vr 越小，这时候系统读的开销就小。反之则写的开销就小。

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## 脑裂

Split-brain (computing) https://en.wikipedia.org/wiki/Split-brain_(computing)

- 集群脑裂问题分析 https://blog.csdn.net/cweeyii/article/details/72354363
- HA领域的“脑裂” https://blog.csdn.net/972301/article/details/50589654

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# PBFT

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## PBFT实现

Sample implementation of PBFT consensus algorithm https://github.com/bigpicturelabsinc/consensusPBFT

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Paxos

Paxos算法详解 - 祥光的文章 - 知乎 https://zhuanlan.zhihu.com/p/31780743

如何浅显易懂地解说 Paxos 的算法？ - 张立羽的回答 - 知乎 https://www.zhihu.com/question/19787937/answer/85568631
> http://harry.me/blog/2014/12/27/neat-algorithms-paxos/

The Part-Time Parliament(Paxos算法中文翻译) https://wenku.baidu.com/view/87276e1dfad6195f312ba6d7.html

Paxos made simple 论文导读 - 木鸟杂记的文章 - 知乎 https://zhuanlan.zhihu.com/p/380587949

## multi-Paxos

使用multi-paxos实现日志同步应用 - 吴镝的文章 - 知乎
https://zhuanlan.zhihu.com/p/20872811

## ZAB

分布式一致性与共识算法简介 | 周末送书 https://mp.weixin.qq.com/s/FNsP6whFDWdPujIf9jSIZg
- > ZooKeeper的核心是一个名叫ZAB的算法，这是Paxos算法的一个变种。ZAB算法的详细内容这里不做展开，一方面ZAB算法和Paxos算法有相同的地方，另一方面ZooKeeper在面向客户端方面所做的设计可能比ZAB算法更加复杂，因此就算理解了ZAB算法也不一定能完全理解ZooKeeper的设计。

Zab vs. Paxos https://cwiki.apache.org/confluence/display/ZOOKEEPER/Zab+vs.+Paxos

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Paxos实现

C++ Paxos library that has been used in Wechat production environment. https://github.com/Tencent/phxpaxos

About: simple CASPaxos implementation written in rust on top of a simulator for finding bugs quickly https://github.com/spacejam/paxos

BIGO | Paxos的工程实践与极致优化 https://mp.weixin.qq.com/s/OfbwhxCNOUGrpcHSHNeKFw 【Paxoskv】

PaxosStore https://github.com/Tencent/paxosstore
- > PaxosStore has been deployed in WeChat production for more than two years, providing storage services for the core businesses of WeChat backend. Now PaxosStore is running on thousands of machines, and is able to afford billions of peak TPS.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Raft

The Raft Consensus Algorithm https://raft.github.io/
> 《In Search of an Understandable Consensus Algorithm (Extended Version)》 https://raft.github.io/raft.pdf

Raft算法解析 https://www.jianshu.com/p/d5ac9eaeab30
> The Secret Lives of Data -- Raft: Understandable Distributed Consensus http://thesecretlivesofdata.com/raft/

Raft 为什么是更易理解的分布式一致性算法 https://mp.weixin.qq.com/s/ulbJ6nb8GncqMizJCQKweg

深入剖析共识性算法Raft https://mp.weixin.qq.com/s/Fc1mgAsa1aDOpfosUtcJhQ

Raft算法原理 https://www.codedump.info/post/20180921-raft/
- > **概述**
  * > 本文是博客解析raft算法及etcd raft库实现的系列三篇文章之一，之所以详细结合etcd实现解析raft算法原理及实现，因为etcd的raft实现是最接近论文本身的，结合论文原理一起阅读十分酸爽。这个系列文章的索引如下：
  * > 另外，我个人还针对etcd 3.1.10版本的raft相关代码实现做了一些代码的注释笔记，地址在此：[etcd-3.1.10-codedump](https://github.com/lichuang/etcd-3.1.10-codedump)。
- > **简介**
  * > 关于Raft算法，有两篇经典的论文，一篇是《In search of an Understandable Consensus Algorithm》，这是作者最开始讲述Raft算法原理的论文，但是这篇论文太简单了，很多算法的细节没有涉及到。更详细的论文是《Consensus: Bridging Theory and Practice》，除了包括第一篇论文的内容以外，还加上了很多细节的描述。在我阅读完etcd raft算法库的实现之后，发现这个库的代码基本就是按照后一篇论文来写的，甚至有部分测试用例的注释里也写明了是针对这篇论文的某一个小节的情况做验证。

## Raft论文

Raft一致性算法论文的中文翻译 https://github.com/maemual/raft-zh_cn
- 【[:star:][`*`]】 寻找一种易于理解的一致性算法（扩展版） https://github.com/maemual/raft-zh_cn/blob/master/raft-zh_cn.md

寻找一种易于理解的一致性算法（扩展版） https://leeweir.github.io/posts/raft/

分布式一致性算法：Raft 算法（论文翻译） https://www.cnblogs.com/linbingdong/p/6442673.html

Raft 一致性算法论文中文译文 https://mp.weixin.qq.com/s/zMnqOCUVvRLQuJUwvM3QRA

Raft：寻找一种易于理解的一致性算法 https://mp.weixin.qq.com/s/u4WUx3C6x-_Wr6Tg87uPNw

Raft算法论文翻译 https://mp.weixin.qq.com/s/XcH7Ay96I0zU_Lp0mMw5OQ

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Raft实现

一个Raft开源项目的结构分析 https://mp.weixin.qq.com/s/1_KAMAx6je8fLsMG1cM-wQ

A feature complete and high performance multi-group Raft library in Go. https://github.com/lni/dragonboat || https://github.com/lni/dragonboat/blob/master/README.CHS.md
- 大规模Go项目几乎必踏的几个坑 - Dragonboat为例 - 我做分布式系统的文章 - 知乎 https://zhuanlan.zhihu.com/p/53284649

C implementation of the Raft Consensus protocol, BSD licensed https://github.com/willemt/raft

LogCabin is a distributed storage system built on Raft that provides a small amount of highly replicated, consistent storage. It is a reliable place for other distributed systems to store their core metadata and is helpful in solving cluster management issues. https://github.com/logcabin/logcabin

C implementation of the Raft consensus protocol https://github.com/canonical/raft

Raft protocol implementation in C https://github.com/postgrespro/raft

Openraft https://github.com/datafuselabs/openraft
- > Advanced Raft in Rust using Tokio.
- > Raft is not yet good enough. This project intends to improve raft as the next-generation consensus protocol for distributed data storage systems (SQL, NoSQL, KV, Streaming, Graph ... or maybe something more exotic).
- > Currently, openraft is the consensus engine of meta-service cluster in databend.

## hashicorp raft

Consensus Protocol https://developer.hashicorp.com/consul/docs/architecture/consensus
- > Consul uses a [consensus protocol](https://en.wikipedia.org/wiki/Consensus_(computer_science)) to provide [Consistency (as defined by CAP)](https://en.wikipedia.org/wiki/CAP_theorem). The consensus protocol is based on ["Raft: In search of an Understandable Consensus Algorithm"](https://raft.github.io/raft.pdf). For a visual explanation of Raft, see [The Secret Lives of Data](http://thesecretlivesofdata.com/raft).

Golang implementation of the Raft consensus protocol https://github.com/hashicorp/raft

🔥 技术笔记 ( 高性能/分布式/kubernetes/golang/kv引擎等 ) https://github.com/rfyiamcool/notes

## SOFAJRaft

SOFAJRAFT -- An industrial-grade java implementation of RAFT consensus algorithm. https://github.com/alipay/sofa-jraft

蚂蚁金服开源 SOFAJRaft：生产级 Java Raft 算法库 https://mp.weixin.qq.com/s/pmbI_FyOJJyvg008amPutA

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 分布式一致性hash

分布式系统中一致性哈希算法 https://www.cnblogs.com/jajian/p/10896624.html
- > **基本思想原理**
  * > 既然 hash的计算结果是 int 类型，而 java 中 int 的最小值是 `-2^31`，最大值是 `2^31-1`。意味着任何通过哈希取模之后的无符号值都会在 `0 ~ 2^31-1` 范围之间，共 `2^32` 个数。那我们是否可以不对服务器的数量进行取模而是直接对 `2^32` 取模。这就形成了一致性哈希的基本算法思想，什么意思呢？
  * > 简单来说，一致性Hash算法将整个哈希值空间组织成一个虚拟的圆环，如假设某哈希函数 H 的值空间为 `0 ~ 2^32-1`（即哈希值是一个32位无符号整形），整个哈希环如下：

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# SnowFlake算法

雪花算法 https://zh.wikipedia.org/wiki/%E9%9B%AA%E8%8A%B1%E7%AE%97%E6%B3%95 || Snowflake ID https://en.wikipedia.org/wiki/Snowflake_ID

理解分布式id生成算法SnowFlake https://segmentfault.com/a/1190000011282426

分布式唯一id：snowflake算法思考 https://juejin.im/post/6844903562007314440

忘掉 Snowflake，感受一下性能高出 587 倍的全局唯一 ID 生成算法 https://juejin.im/post/6846687584324681735

Twitter的雪花算法（snowflake）分布式&自增ID https://github.com/cloudyan/snowflake
