

# ETCD官方

Demo https://coreos.com/etcd/docs/latest/demo.html

Administration https://coreos.com/etcd/docs/latest/v2/admin_guide.html

--------------------------------------------------

# ETCD general

Etcd官方文档中文版 http://etcd.doczh.cn/ ||| from 技术文档中文版 https://doczh.cn/
- 理解失败 http://etcd.doczh.cn/documentation/op-guide/failures.html
  * > 『网络分区类似少数跟随者失败或者 leader 失败。网络分区将 etcd 集群分成两个部分; 一个有多数成员而另外一个有少数成员。多数这边变成可用集群而少数这边不可用。在 etcd 中没有 "脑裂"。』 --> 个人理解脑裂一般会出现多主，而etcd出现网络分区后因为最多只有一个分区能达到多数成员，所以至多只会出现一个master，因此不会出现脑裂。
- 为什么是etcd? http://etcd.doczh.cn/documentation/learning/why.html
  * > 『"etcd"这个名字源于两个想法，即　unix "/etc" 文件夹和分布式系统"d"istibuted。 "/etc" 文件夹为单个系统存储配置数据的地方，而 etcd 存储大规模分布式系统的配置信息。因此，"d"istibuted　的 "/etc" ，是为 "etcd"。』
  
# ETCD源码

raft 学习笔记 https://github.com/lkk2003rty/notes/blob/master/raft.md
> "raft 从何学起呢？工欲善其事，必先利其器。当然首先看 paper 啦。主要的 paper 有两个 raft 和 thesis。相关的资料站点为 https://raft.github.io/。要是嫌弃这个站点 raft 的可视化做得不带好，还有一个比较详细的 http://thesecretlivesofdata.com/raft/ 可以看。"

Etcd 架构与实现解析 http://jolestar.com/etcd-architecture/

# ETCD其他

etcd简介 https://blog.csdn.net/mnasd/article/details/79621155

etcd 集群大小迷思 https://www.yangcs.net/posts/etcd-cluster-number/
> "etcd 使用 raft 协议保证各个节点之间的状态一致。根据 raft 算法原理，节点数目越多，会降低集群的写性能。这是因为每一次写操作，需要集群中大多数节点将日志落盘成功后，Leader 节点才能将修改内部状态机，并返回将结果返回给客户端。但是根据 etcd 分布式数据冗余策略，集群节点越多，容错能力(Failure Tolerance)越强。所以关于集群大小的优化，其实就是容错和写性能的一个平衡。"

