
# 脉脉数据库

今晚和男朋友一直在争论一个问题，相互不服气，已经开始吵架了。 https://maimai.cn/web/gossip_detail?gid=32929328&egid=40b8bd537bfd449ea180bcab6d0edee1
```console
男朋友观点：数据库主键偏向于用业务自己生成的全局唯一id(他公司大部分表用的主键都是业务自己生成的id，且他觉得他的公司技术吊打大部分其他公司)。
这样会避免分表情况下，数据库实现的真实拘束和业务的约束条件不一致。比如，如果用自增id做分表的主键，则需要用自增id+分表的规则id(比如用户id)才能成为业务的唯一约束。

我的观点：数据库主键无论单表还是分表，没有特殊情况，都用自增id即可。我说大部分情况都会用自增id做主键的(具体原因就不说了，有点八股了...)，然后被男朋友说水平低下，
但我始终没办法接受男朋友说的要用业务生成id做主键。
```
- > 主键是主键，唯一约束是唯一约束，一般主键使用自增id，可以单独建立一个唯一索引作为业务上的唯一id。分表和主键也没什么关系，分表使用用户id，日期等任何字段都可以。 <br> ***主键推荐使用自增id的原因是innodb的聚簇索引使用主键id作为节点，自增数据只需要在最后的节点插入即可，如果使用业务上的uuid，则`b+树`会出现比较多的分裂和调整***。
  >> 但是如果写入操作因为容灾诉求部署到了不同的两个中心，那么双中心写，必然主键id无法使用自增而必须使用全局id，否则两个中心的写入数据在同步过程中会出现冲突
  >>> 修改自增的步长就行了，PXC架构了解一下？
  >>>> PXC的本质也是单中心，我说的多中心是地域性的，而不是多主问题。多中心网络时延是不可能允许事务性操作跨中心协同的
  >>>>> 你考虑的点是对的，绝大部分场景直接使用数据库的自增id即可，***多主写入和同步这种场景会有全局唯一的诉求，所以这时候会是一个全局唯一的自增id***。它可能是业务唯一id也可能就是一个无意义字段。 <br> ***`雪花算法`就是一个全局唯一，顺序，自增的id***。
  >>>>>> 是的，业务一定规模才会考虑多中心，这种强需求场景很少。正常自增就行。分布式id设计属实吃力不讨好
- > 自增ID?你是没有吃过分库分表的苦。再给你来一波转历史合适合并数据，能叫你回炉重做
  >> 分库分表跟主键有毛关系
- > id自增面相库本身，是数据层面的唯一标识。全局UUID面相业务。 <br> 单库对应一个业务，并且并发也不大的，这俩可以是同一个东西。 <br> 遇到并发太大需要分库，或者设计上需要UUID包含业务含义，那么这俩就得分开。每个库自增id得有，同时用新的字段表示业务上的唯一性，增删改都基于UUID来，自增id基本只有在排查非业务层问题时才会用到。
- > 雪花>自增/有序业务id>无序业务id
- > 看来你俩荷尔蒙分泌不足啊，晚上还有功夫谈数据库主键自增问题
- > 看业务场景，单机房自增id，多机房分布式id，可以通过中间件互相转换的
- > 自增id和全局唯一追求的点不一样，***自增是为了b+树性能考虑，全局唯一考虑的点是数据迁移和同步***。所以可以使用`雪花算法`，既全局唯一，也顺序自增。
- > 我们要求主键是用`snowflake算法`生成的序列号
- > 应该表有两个id，一个是自增id用数据库的技术主键，另外一个是业务id一般用biz id表示作为业务id
- > 自增主键➕业务唯一主键，同时给业务唯一主键加索引
- > 我上家公司，分表的主键id自增。用雪花生成的顺序的用户id来做分表。
- > 抛开数据库就谈主键，等同于默认全世界都用java。nosql一般都按主键来分shard，你主键用个自增业务好做吗。还有一些索引没法保证强一致的，一些关键查询必须依赖主键
- > 自增主键+业务唯一索引，自增主键是给运维用的
- > 习惯用雪花，自增很容易被爬虫枚举捞数据。之前因为这个还做过改造。。
- > 你男朋友就是个水货，我猜他这么做的原因是把id字段应用于业务逻辑了。id、gmt_create、gmt_modified这些是DB层面的系统字段，不能应用于业务。业务应该有自己的唯一标识id以及创建时间等。回去喷他。
  >> 另外，之所以用数据库的自增id，主要是因为mysql数据库innodb的聚簇索引特性决定的（具体原因请自己google）。用业务唯一id作为主键，在集群模式下，怎么保证id的写入顺序？就算业务id的生成是有顺序的，但集群里的每台机器都在写库，怎么保证顺序？所以，不只是你男朋友，他所在的整个公司应该都是水货。

innodb一行数据（compact格式）包涵varchar或者null时，修改导致一行数据长度发生变化，因为一行是连续存储，导致操作变成重新写一行数据，这样效率不会低吗？ https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mjc3MDU1OTcsImlhdCI6MTYwMjk5ODkxNH0.gIjKEjSwCod778aOwMLsMIxH2z9sgeLiHsK8iJ6Alrw

InnoDB为什么不把二级索引设计为叶节点直接指向数据? 这样就不用再使用主键二次查找数据了 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI3NTc3NTQ0IiwiaWF0IjoxNjAyMjE2NjgwfQ.QASj2RTIb4D7NTjp5xuTU1ZaJrhIR2BkdTa4bhEL5LA
- > 这些东西都是要序列化成文件的 辅助索引只指向主键 那么每次插入删除只要主键所在的页分裂就好 如果指向数据 那么最坏情况下更新数据需要更新所有二级索引里面的所有数据地址
- > 头条面试题，你可以参考《高性能mysql第三版》166页
- > 数据的地址会改变，页分裂页合并
- > 更新的代价太高，二级索引指向主键，页分裂导致记录地址变更只需要修改主键，指向物理地址的话需要将索引和主键一起加锁，保证原子性，同时，更新索引会需要更多的io，写入性能会受到很大影响

想问一下mysql innodb 的mvcc在rr隔离级别下到底解决幻读没，我看有的是说间隙锁解决的 有人讲一下吗？ https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU4ODk4MDEsImlhdCI6MTU4NzUzMzY3NH0.yESruSQzmlM8NISB4dxhgkDWPn8QkMjljyd7Brh0Mv0

lsm 或者 b+树都是对于早期机械硬盘而设计的数据库结构，像lsm就是把随机写变成顺序写，但是现在ssd逐渐是主流，请问在对于ssd这种固态硬盘，他的缺点有哪些，我就知道有一个写放大，那么对于ssd，数据库的优化角度有哪些，请大佬们知道的说下呗 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU2OTY1NzAsImlhdCI6MTU4NjMyMzMyMH0.aJtXNA09oHye8-qbU6KGu3xp3so-KtByC2qXX_wZPLg
- > WiscKey了解一下
- > 有点像bitcask
- 自查链接:
  * 如何理解SSD的写放大? - 知乎 https://www.zhihu.com/question/31024021
    + 如何理解SSD的写放大? - 瞎折腾DIY的回答 - 知乎 https://www.zhihu.com/question/31024021/answer/110423556
  * 写入放大 https://zh.wikipedia.org/wiki/%E5%86%99%E5%85%A5%E6%94%BE%E5%A4%A7
  * WiscKey：LSM-Tree 写放大优化 https://www.jianshu.com/p/1b438f850844

今天被朋友问到一个问题，如果有1亿条数据，深度limit时，怎么优化？我是这么回答的，有木有问题。 https://maimai.cn/web/gossip_detail?src=app&webid=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlZ2lkIjoiYWJiNzBlNjA2YzU4MTFlYWI2Zjc4MDE4NDRlNTAxOTAiLCJ1IjoxOTU4OTUxOTUsImlkIjoyNTU0NDg0N30.QMz3eiKFEn9HHF0RC1efsV3l5BKfPqCEsB36T3n75Bo
- > 我遇到过，当时解决是select * from a where id in (select id from a limit x，y) 充分利用主键索引比二级索引块的优势。如果这样都会事物超时，只能顺序分表了。
  >> 老哥，请问 select * from table where xxx limit a,b和select id from table where xxx limit a,b 速度有区别吗？
  >>> 有，假设 id 是自增主键，引擎是innodb，xxx上有索引。select * 的时候会先查索引找到对应的 id，再通过 id 找到这一行的数据，就是回表，两次IO。而 select id 只走一次IO
- > 典型的分裤分表和分页场景，经验：大于100w条数据时分表，查询时使用id作分页参数而不是limit
- > 只讨论一亿数据是没意义的，一行数据有多大？如果没有复杂查询的话能不能用nosql比如hbase？是oltp还是olap？
