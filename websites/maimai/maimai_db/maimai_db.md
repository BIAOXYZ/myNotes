
# 脉脉数据库

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
