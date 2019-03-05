

# distributed system general

Scalable, Available, Stable, Performant, and Intelligent System Design Patterns https://github.com/binhnguyennus/awesome-scalability

Paxos和Raft的前世今生 https://mp.weixin.qq.com/s/OXE7prU9cMuZG8kFydPm9A

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# transaction system

两阶段提交的工程实践 - 郁白的文章 - 知乎
https://zhuanlan.zhihu.com/p/22594180

两阶段提交及JTA http://www.cnblogs.com/Leo_wl/p/5728027.html

2PC之踵？是时候升级二阶段提交协议了 https://mp.weixin.qq.com/s/fHyvviHGBzYfOugPpbJ2lA

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

# Paxos

Paxos算法详解 - 祥光的文章 - 知乎 https://zhuanlan.zhihu.com/p/31780743

如何浅显易懂地解说 Paxos 的算法？ - 张立羽的回答 - 知乎 https://www.zhihu.com/question/19787937/answer/85568631
> http://harry.me/blog/2014/12/27/neat-algorithms-paxos/

The Part-Time Parliament(Paxos算法中文翻译) https://wenku.baidu.com/view/87276e1dfad6195f312ba6d7.html

## multi-Paxos

使用multi-paxos实现日志同步应用 - 吴镝的文章 - 知乎
https://zhuanlan.zhihu.com/p/20872811

# Paxos实现

C++ Paxos library that has been used in Wechat production environment. https://github.com/Tencent/phxpaxos


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# Raft

The Raft Consensus Algorithm https://raft.github.io/

Raft 为什么是更易理解的分布式一致性算法 https://mp.weixin.qq.com/s/ulbJ6nb8GncqMizJCQKweg

分布式一致性算法：Raft 算法（论文翻译） https://www.cnblogs.com/linbingdong/p/6442673.html

# Raft实现

一个Raft开源项目的结构分析 https://mp.weixin.qq.com/s/1_KAMAx6je8fLsMG1cM-wQ

## ETCD

raft 学习笔记 https://github.com/lkk2003rty/notes/blob/master/raft.md

ETCD实现技术总结 https://www.jianshu.com/p/d63265949e52

etcd 集群大小迷思 https://www.yangcs.net/posts/etcd-cluster-number/
> "etcd 使用 raft 协议保证各个节点之间的状态一致。根据 raft 算法原理，节点数目越多，会降低集群的写性能。这是因为每一次写操作，需要集群中大多数节点将日志落盘成功后，Leader 节点才能将修改内部状态机，并返回将结果返回给客户端。但是根据 etcd 分布式数据冗余策略，集群节点越多，容错能力(Failure Tolerance)越强。所以关于集群大小的优化，其实就是容错和写性能的一个平衡。"

### ETCD文档

Etcd官方文档中文版 http://etcd.doczh.cn/ ||| from 技术文档中文版 https://doczh.cn/
- 理解失败 http://etcd.doczh.cn/documentation/op-guide/failures.html
  * > 『网络分区类似少数跟随者失败或者 leader 失败。网络分区将 etcd 集群分成两个部分; 一个有多数成员而另外一个有少数成员。多数这边变成可用集群而少数这边不可用。在 etcd 中没有 "脑裂"。』 --> 个人理解脑裂一般会出现多主，而etcd出现网络分区后因为最多只有一个分区能达到多数成员，所以至多只会出现一个master，因此不会出现脑裂。
- 为什么是etcd? http://etcd.doczh.cn/documentation/learning/why.html
  * > 『"etcd"这个名字源于两个想法，即　unix "/etc" 文件夹和分布式系统"d"istibuted。 "/etc" 文件夹为单个系统存储配置数据的地方，而 etcd 存储大规模分布式系统的配置信息。因此，"d"istibuted　的 "/etc" ，是为 "etcd"。』
  
