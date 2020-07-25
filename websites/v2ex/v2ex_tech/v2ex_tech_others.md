
[长篇娱乐连载] 网络的那些事儿（S01E04）国内带宽的价格 (IDC/DC 行业内幕) https://www.v2ex.com/t/693018

阿里面试，一个对你而言很陌生的线上系统启动慢，你会如何排查问题？ https://www.v2ex.com/t/692719
- > 主机虚拟内存使用情况； netstat 看看 Recv-Q Send-Q 情况，有时候 DNS 反向解析也可能会导致慢或者一部分功能不可用。
- > 无脑 arthas
- > ng 查看下回复时间，排查是否网络原因；是否 io 密集型任务排查下系统 io 情况； cpu 是否高占用，如果高占用具体排查线程，是 gc 线程还是用户线程。数据库是否有慢查询，缓存连接情况，mq 消费是否正常，是否有三方接口响应过慢。大方向具体就想到那么多。
- > 是启动慢还是系统慢，如果只是启动慢，那说明线上没问题呀，加点日志，下次上线时看看启动到底哪里慢；如果是接口慢，那就看看系统负载瓶颈呗，是 cpu 满了，内存不够了还是网卡爆了
- > 启动慢又不是运行慢，模拟线上环境在线下尝试复现呗。 <br> 线上即然已经上线，启动慢就不是问题，先封禁变更放着，没必要在线上 debug。 <br> 如果线下无法复现，就在线上找个实例，从 LB 上把流量摘了，随便打点加日志折腾

谈谈我为什么喜欢声明变量时类型后置的语言 https://www.v2ex.com/t/678294

关于断言的一个疑问，希望可以和懂的人讨论一下，请不吝赐教。 https://www.v2ex.com/t/671078

最终一致性到底是什么？？ https://www.v2ex.com/t/666807
- > https://zhuanlan.zhihu.com/p/47445841 
  <br> 单机场景一致性主要看并发隔离 
  <br> 分布式场景一致性主要看怎么获得全序关系 
  <br> 一致性门道很多，不系统性的学习根本就弄不清楚的；可以看看 DDIA 这本书
- > 不要弄混 ACID 中的 C 和 CAP 的 C，前者的重心在于系统整体的一致性, 后者指的是多个副本之间的一致性
- > 14 楼说得并不对，理解太浅显 
  <br> ACID 里面的 C 定义非常模糊，与业务定义有关，ACID 这几个概念就不正交；单机数据库谈论 ACID 比较多，AID 是对 C 的约束 
  <br> CAP 里面的 C 也不是指什么副本一致，而是指线性一致性（也就是大家谈论的强一致，但其实大部分人自己是说不清楚什么是强一致的），还是去看书吧，这个需要扎实的理论基础
- > 分布式事务的一致性还是事务的一致性，即业务层面定义的一致性。分布式事务相对与单机事务的难点是：因通信不稳定，参与事务的各个‘进程’如何对状态达成一致。这是个共识问题。
至于 CAP，通常网络 P 很可能发生，无法避免（看到有人说谷歌自建网络非常稳定，不会出现 P ）。所以只能在 CA 上做权衡，C 强一点，A 就弱一点。CA 好像是某个概念（延迟？）的一体两面。建议参考 
  * > http://jepsen.io/consistency
  * > https://www.zhihu.com/people/zhangshuai89/posts
    + CAP，ACID，我们能做什么 - 张帅的文章 - 知乎 https://zhuanlan.zhihu.com/p/37076900

请教一下，阅读 Linux Kernel 最快的解决方案（@Windows）是啥呢? https://www.v2ex.com/t/656319
- > https://elixir.bootlin.com/linux/v5.6-rc7/source
- > https://elixir.bootlin.com/linux/latest/source
- > qtcreator，很久前看内核源码是用这个，现在 c/c++源码基本也是这个。另外，添加源码的时候，不要把所有`**_arch` 都加到工程，只加关注的几个
- > neovim + ctags，然后用 vim 插件 leaderF，堪称搜索神器
- > 使用 sourcegraph https://sourcegraph.com/github.com/torvalds/linux

关于 RSA 的一些趣事 https://www.v2ex.com/t/655096

有无计算机组成原理相关的课程和书推荐 https://www.v2ex.com/t/625781

做一个基础很扎实的程序员是一种什么感受啊 https://www.v2ex.com/t/561411
- > 现在开始学基础也不会晚。最近也一直在看计算机基础相关圣经。我整理了一个计算机基础书单，可以参考参考 https://github.com/tagnja/resources-of-learning/blob/master/%23cs-foundations.md

推荐几篇零知识证明技术博客文章 https://www.v2ex.com/t/586006
> 深入浅出区块链 https://learnblockchain.cn/

翻译了一下破解编码面试这本书，放到 GitHub 上了 https://www.v2ex.com/t/609497
> https://github.com/F8F-1BearCat/CtCI-6th-Edition-CN

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
