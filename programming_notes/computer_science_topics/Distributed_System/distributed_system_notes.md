

# distributed system general

Scalable, Available, Stable, Performant, and Intelligent System Design Patterns https://github.com/binhnguyennus/awesome-scalability

Paxos和Raft的前世今生 https://mp.weixin.qq.com/s/OXE7prU9cMuZG8kFydPm9A

分布式系统(Distributed System)资料 https://yq.aliyun.com/articles/8069

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
> 《In Search of an Understandable Consensus Algorithm (Extended Version)》 https://raft.github.io/raft.pdf

Raft算法解析 https://www.jianshu.com/p/d5ac9eaeab30
> The Secret Lives of Data -- Raft: Understandable Distributed Consensus http://thesecretlivesofdata.com/raft/

Raft 为什么是更易理解的分布式一致性算法 https://mp.weixin.qq.com/s/ulbJ6nb8GncqMizJCQKweg

分布式一致性算法：Raft 算法（论文翻译） https://www.cnblogs.com/linbingdong/p/6442673.html

寻找一种易于理解的一致性算法（扩展版） https://github.com/maemual/raft-zh_cn/blob/master/raft-zh_cn.md

# Raft实现

一个Raft开源项目的结构分析 https://mp.weixin.qq.com/s/1_KAMAx6je8fLsMG1cM-wQ

Golang implementation of the Raft consensus protocol https://github.com/hashicorp/raft

## SOFAJRaft

SOFAJRAFT -- An industrial-grade java implementation of RAFT consensus algorithm. https://github.com/alipay/sofa-jraft

蚂蚁金服开源 SOFAJRaft：生产级 Java Raft 算法库 https://mp.weixin.qq.com/s/pmbI_FyOJJyvg008amPutA
