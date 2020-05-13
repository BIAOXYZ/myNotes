
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
