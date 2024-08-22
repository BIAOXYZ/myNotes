
分布式事务到是什么 https://www.v2ex.com/t/1066563
- > https://pdai.tech/md/arch/arch-z-transection.html 不知道楼主面试的是什么岗位，这些八股文还是多准备下比较好
- > 才疏学浅，至今没用过分布式事务，我来个八股文链接，一起学习下： https://github.com/doocs/advanced-java/blob/main/docs/distributed-system/distributed-transaction.md
- > https://www.thebyte.com.cn/distributed-transaction/transaction.html 我这里介绍了 4 中分布式事务：BASE 、TCC 、SAGA 你可以看看。
- > 事务和线程很相似，但又不是很相似。得先认识到并发线程原子性和事务原子性的区别。一个是不可打断，不可继续分割；一个是存在回退机制，不会出现”错误数据“。其它的就可以利用你”如何安全的并发编程“相关理论，来认识分布式事务。就像一个变量参与多个线程，一个数据同步到多个数据库。
  * > 你是如何控制这个变量在多个线程同步的？
    ```console
    - 锁：最简单的阻塞，同步
    - 协程：有局限性但很合适的调度
    - 事件/回调：可用但也仅仅可用
    ```
  * > 你又是如何控制这个服务在多个数据库保存操作中不会部分成功，部分失败的?
    ```console
    - 多个事务当然也可以阻塞：一致性拉满，可用性降低，与线程锁的特性高度一致。
    - 多个事务当然也可以协作：可用性提高，一致性降低。倾斜程度根据协作方式而定，
    - 多个事务当然也可以回调：或许就是最终一致性了，到回调完成那一刻，数据才会变得正确。
    ```
  * > 我认为分布式事务本身没什么复杂的，更多是因为涉及分布式事务的业务太复杂了。导致分布式事务看起来很难。其实回到本质还是同步问题。

关于 2PC/3PC https://www.v2ex.com/t/1059730

分布式事务，怎么感觉不需要那么复杂 https://www.v2ex.com/t/1019248

关于持久化的一点疑问 https://www.v2ex.com/t/825944
- > https://github.com/dreamhead/patterns-of-distributed-systems/blob/master/content/write-ahead-log.md <br> 这个名词叫做 Write-Ahead Log

关于 Raft Consensus Algorithm 的疑问 https://www.v2ex.com/t/802818

用 Go 轻松完成一个 TCC 分布式事务，保姆级教程 https://www.v2ex.com/t/794530

用 Python 轻松完成一个分布式事务 TCC，保姆级教程 https://www.v2ex.com/t/794155
```console
阅读完此篇干货，欢迎大家访问 https://github.com/yedf/dtm
```

Paxos 的变种（一）： Multi-Paxos 是如何劝退大家去选择 Raft 的 https://www.v2ex.com/t/716187
```console
博客地址： http://tangwz.com/post/multi-paxos/
如果打不开上面的地址，知乎文章： https://zhuanlan.zhihu.com/p/266580107

《强力研分布式系统》系列前文：
1. 分布式系统的核心：共识问题  https://www.v2ex.com/t/704779
2. 分布式系统共识算法：理解 Paxos （含伪代码）  https://www.v2ex.com/t/711746
```

分布式系统的核心：共识问题 https://www.v2ex.com/t/704779

一个关于 Raft 协议的疑问 https://www.v2ex.com/t/686420
