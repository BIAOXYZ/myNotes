
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

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# distributed transaction system

两阶段提交的工程实践 - 郁白的文章 - 知乎
https://zhuanlan.zhihu.com/p/22594180

两阶段提交及JTA http://www.cnblogs.com/Leo_wl/p/5728027.html

2PC之踵？是时候升级二阶段提交协议了 https://mp.weixin.qq.com/s/fHyvviHGBzYfOugPpbJ2lA

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

Quorum (distributed computing) https://en.wikipedia.org/wiki/Quorum_(distributed_computing)


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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Raft

The Raft Consensus Algorithm https://raft.github.io/
> 《In Search of an Understandable Consensus Algorithm (Extended Version)》 https://raft.github.io/raft.pdf

Raft算法解析 https://www.jianshu.com/p/d5ac9eaeab30
> The Secret Lives of Data -- Raft: Understandable Distributed Consensus http://thesecretlivesofdata.com/raft/

Raft 为什么是更易理解的分布式一致性算法 https://mp.weixin.qq.com/s/ulbJ6nb8GncqMizJCQKweg

分布式一致性算法：Raft 算法（论文翻译） https://www.cnblogs.com/linbingdong/p/6442673.html

寻找一种易于理解的一致性算法（扩展版） https://github.com/maemual/raft-zh_cn/blob/master/raft-zh_cn.md

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Raft实现

一个Raft开源项目的结构分析 https://mp.weixin.qq.com/s/1_KAMAx6je8fLsMG1cM-wQ

Golang implementation of the Raft consensus protocol https://github.com/hashicorp/raft

A feature complete and high performance multi-group Raft library in Go. https://github.com/lni/dragonboat || https://github.com/lni/dragonboat/blob/master/README.CHS.md
- 大规模Go项目几乎必踏的几个坑 - Dragonboat为例 - 我做分布式系统的文章 - 知乎 https://zhuanlan.zhihu.com/p/53284649

C implementation of the Raft Consensus protocol, BSD licensed https://github.com/willemt/raft

LogCabin is a distributed storage system built on Raft that provides a small amount of highly replicated, consistent storage. It is a reliable place for other distributed systems to store their core metadata and is helpful in solving cluster management issues. https://github.com/logcabin/logcabin

C implementation of the Raft consensus protocol https://github.com/canonical/raft

Raft protocol implementation in C https://github.com/postgrespro/raft

## SOFAJRaft

SOFAJRAFT -- An industrial-grade java implementation of RAFT consensus algorithm. https://github.com/alipay/sofa-jraft

蚂蚁金服开源 SOFAJRaft：生产级 Java Raft 算法库 https://mp.weixin.qq.com/s/pmbI_FyOJJyvg008amPutA

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# SnowFlake算法

理解分布式id生成算法SnowFlake https://segmentfault.com/a/1190000011282426

分布式唯一id：snowflake算法思考 https://juejin.im/post/6844903562007314440

忘掉 Snowflake，感受一下性能高出 587 倍的全局唯一 ID 生成算法 https://juejin.im/post/6846687584324681735
