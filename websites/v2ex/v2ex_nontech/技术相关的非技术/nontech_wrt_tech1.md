
最近各家服务崩的此起彼伏，到底是不是跟裁员有关？ https://www.v2ex.com/t/996703
- > 我感觉有关系，可能每个事件具体到细节上，都不一定是因为某个大佬被裁了导致出现的问题。但是大规模的事件，就类似航空业，经济低迷的时候，航空安全相对来说就是更容易出现事故是一样的。最起码往前推三四年，我个人印象中没有大厂接连的出现如此规模的服务宕机。
- > 当年携程网挂的时候，我学到了要用自己的电脑办公。直到了自己离职的时候，发现原来以前所爱的公司也就那么个鸟样。所以该留的东西要留一手，不搞破坏就不错了。。。 <br> ***有些东西没有经验的人是搞不清楚为什么，是什么会导致这种故障，特别还是 1+2 两个问题出现才会出现的故障***。再说了工作交接谁给你那么细的经验，密码交出去就好，其他的自己搜索去。。。
- > 白鹿原上的地主都知道，秋天收割麦子的几个月，必须给麦客吃饱饭，才能保证自家的收成 <br> 麦客和程序员都是吃的力气饭，可当前的老板明显不如以前的地主良心了
- > 业务复杂度演化到一定程度自然会涌现出这些问题。之前互联网高歌猛进的时候，更多的是新开项目攻城略地，现在各家都砍了新业务，聚焦现有业务做效率提升和功能演化。而复杂度的增加是指数型的，也就是说初期和线性无异，到了某个阈值就会跃迁呈现出远超预期的指数复杂度。
- > 你说滴滴 k8s 1.12 用的好好的，干嘛吃饱了升到 1.2 ？？？换我做决策我是能不升级就不升级，实在不行我再升级，而且就老业务用老的，新业务才用新的。跑的好好的干嘛去动啊。
  >> k8s 中间件，云原生部门也有开发的啊。不升级系统，市面上的新技术，k8s 的新特性用不了，人家也交不了差。就像你也不可能用一辈子的 centos 6 吧？
- > 我就在其中某个厂。肯定没直接关系，但是和经常裁员的管理模式关系很大。 <br> ***如果一个员工没有在一个岗位稳定工作的预期，那么他的所有的工作结果只会对当前一个季度负责。那么构建在所有人的这种自发的想法的基础上的系统上去聊稳定性，就是痴人说梦***
- > ***<ins>不光人在裁，机器也在裁啊，降本，机器资源，集群资源</ins>***，然后在降本的时候发现某些东西很老，有隐患，然后又想冲一波考核，那就拿出来升升级，然后发现，哦豁，没考虑到那么全面，因为最了解的人走了，现在都是看看文档的人，自然就崩一下，你要说解决不了，那不可能，只是因为没遇到所以才出问题，遇到了后面就不出了，然后后面又裁，新的问题再暴露。
- > 肯定有关系啊，但不会影响什么。人总是相信自己相信的话，“裁员了崩溃了——你看，惹程序员没有好下场”。***实际上这点问题跟裁员取得收益相比，仍然不会影响一点老板的想法***。
- > 不敢想象当时一线的工程师修复的时候压力有多大
- > 现在系统越来越复杂, 发生问题是必然的 <br> 想要不出问题, 你需要花很多精力在“预防”上, 比如定期评估测试发布/回滚流程, 进行灾备演练, 随机给某个机房断网断电什么的 <br> ***如果上头只看直接的成果, 对这些优化根本就不会在意, 下面的人自然也很少会去动它***, 毕竟这就和对现有的程序做重构与性能优化一样, 性价比特别低
- > 一定是有关系的，不一定是把干活的人裁了，也有可能是把本来打杂的裁了 现在杂事、大事、小事 都压在几个人身上了，人难免忙中出乱的
- > 如果是非常熟悉的，按照大厂的情况，哪怕出事故 30 分钟内也能够处理完成。如果几个小时，甚至十几个小时，肯定是不熟悉或者知道一部分的人接手，然后找各个参与过一些的人问，问着问着发现这个离职了，那个知道点，然后再和代码、日志核对，拿不准尝试修复，因为有些代码细节不了解，比如某个 if 可能是处理历史遗留问题数据的，没处理，又炸了，反复几次好不容易修好。
- > 绝对有关，离职交接其实是一笔烂账。有时候你会发现，一些小的功能，看起来不是很重要，但是离职交接没人管，可能就会出大事。最近在公司内部碰到离职交接后，无人看护的服务。
- > 我觉得是有关系的，楼上有人说了 经常裁员 势必会引起自保，那就是代码和人有一个能跑的心态。另外，***从 0 到 1 的人优化了，交接可不会从 0 到 1***，这中间的坑小还好说，大了就容易出事。
- > 有没有可能是国产化？

# 开源

原来 Linux 代码也有公司利益、政治斗争。 https://www.v2ex.com/t/1024652
```console
https://www.zhihu.com/question/648215689/answer/3432678754

关于新闻“Linux 6.9 将移除旧版 NTFS 驱动程序”，答主高志刚说了他和旧版 NTFS 驱动的维护者的故事，简单说就是他提出了改进这个残缺的旧版 NTFS 驱动的补丁。先是被怀疑动机，最后被无视。
答主最后对新闻作出评论“外行人看是优化了三万行代码，我看就是为了优化掉他这个支线 maintainer 。”
```

# BUG

敢不敢说说你曾经写过那些地动山摇的 BUG？ https://www.v2ex.com/t/994763

《地下城与勇士》修复了一个近 10 年的 BUG，我以为这是正常的设定，原来特么是个 BUG https://www.v2ex.com/t/932089

# 信创

交付过信创产品，或者被信创蹂躏过的兄弟们，让我解脱吧 https://www.v2ex.com/t/1013618

各位被信创折磨的程序员们，你们有用 GaussDB 的吗 https://www.v2ex.com/t/1013406
- > 如果是分布式版的高斯，注意用对分布列、尽量不要用全局唯一索引、尽量不要用复制表，被这三个点坑挺惨的
- > XC 下尽量不要用 MariaDB ，有些问题导致需要升级数据库的，无解，只能从其他渠道解决。。。
- > 碰到过一次 oracle 转 高斯 DB ，然后这张表有说有十几亿数据，换完之后查询就崩了，数据量太多直接走全局了，这个是我们对接其他项目组 他们给我们提供的 SQL 。
- > 就是 postgres ，但是他用的 postgres 的版本太老了，很多特性不支持，比如 on duplicate 就不支持，很难用。
  >> on duplicate 不是 mysql 方言么，pg 最新版本支持了？...你是否想说 ON CONFLICT
  >>> 对 ON CONFLICT 。。

# 其他

写一句你所知的计算机界名言名句。 https://www.v2ex.com/t/1017108
- > Software is like sex, it's better when it's free. -Linus Torvalds
- > Rule 34, If it exists, there is porn of it – no exceptions 算么
- > Across the Great Wall, we can reach every corner in the world”（越过长城，走向世界每个角落）
- > 永远不要低估一辆装满磁带在高速公路上飞驰的小货车的传输带宽。 —— 安德鲁·谭宁邦（ Andrew Tanenbaum ，1981 ）
