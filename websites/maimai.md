
# 脉脉数据库

lsm 或者 b+树都是对于早期机械硬盘而设计的数据库结构，像lsm就是把随机写变成顺序写，但是现在ssd逐渐是主流，请问在对于ssd这种固态硬盘，他的缺点有哪些，我就知道有一个写放大，那么对于ssd，数据库的优化角度有哪些，请大佬们知道的说下呗 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU2OTY1NzAsImlhdCI6MTU4NjMyMzMyMH0.aJtXNA09oHye8-qbU6KGu3xp3so-KtByC2qXX_wZPLg
- > WiscKey了解一下
- > 有点像bitcask
- 自查链接:
  * 如何理解SSD的写放大? - 知乎 https://www.zhihu.com/question/31024021
  * WiscKey：LSM-Tree 写放大优化 https://www.jianshu.com/p/1b438f850844

今天被朋友问到一个问题，如果有1亿条数据，深度limit时，怎么优化？我是这么回答的，有木有问题。 https://maimai.cn/web/gossip_detail?src=app&webid=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlZ2lkIjoiYWJiNzBlNjA2YzU4MTFlYWI2Zjc4MDE4NDRlNTAxOTAiLCJ1IjoxOTU4OTUxOTUsImlkIjoyNTU0NDg0N30.QMz3eiKFEn9HHF0RC1efsV3l5BKfPqCEsB36T3n75Bo
- > 我遇到过，当时解决是select * from a where id in (select id from a limit x，y) 充分利用主键索引比二级索引块的优势。如果这样都会事物超时，只能顺序分表了。
  >> 老哥，请问 select * from table where xxx limit a,b和select id from table where xxx limit a,b 速度有区别吗？
  >>> 有，假设 id 是自增主键，引擎是innodb，xxx上有索引。select * 的时候会先查索引找到对应的 id，再通过 id 找到这一行的数据，就是回表，两次IO。而 select id 只走一次IO
- > 典型的分裤分表和分页场景，经验：大于100w条数据时分表，查询时使用id作分页参数而不是limit
- > 只讨论一亿数据是没意义的，一行数据有多大？如果没有复杂查询的话能不能用nosql比如hbase？是oltp还是olap？

# 脉脉算法与数据结构

leetcode第85题最大矩形，对着题干瞪眼一晚上，心态要崩 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU1NzMyNjQsImlhdCI6MTU4NTIxMTQ4Nn0.9fpBl4A5y6yG56Cdbi6-L4X3alNGk5gBl9FD9HgrGwY
- > 老哥先做84题，然后85就明白了
- > 有一道神题，Count of Range Sums，把离散化，uniq，二分查找，树状数组，前缀和都搞进去了，这道题我写了一个月了
- > 那是你没遇到过数论背景下的树形dp
- > 这题我面Amazon被面到了，84 85一起面的

最近面试的算法题，我想了很久还是没想到，求大佬指点。问题：“假设有一个数字类型的数组，量级达到数亿亿别。如何找到最大的第十个数字？” 答：“新建10个元素的数组，循环取出大数组的数据和小数组对比，大的替换到小数组，小的则抛弃” 再问：“如果要找最中间的那个数字，应该怎么找？” https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU1NDMwMjYsImlhdCI6MTU4NDkzNjAyMX0.eq-ByP2zeWe62KfZbyWpqWl2kLbWaQzek2qk1EtBw58
- > 二进制分治，按最高位是0或者1写入到两个文件，并记录两个文件写了多少个元素，然后就可以知道中间那个数在哪个文件里。接下来对次高位进行同样的操作。。。最后剩下的就是所求。其实就是转换成了求第k个数。
- > 建两个堆，一个大顶堆一个小顶堆。一个个读取数据放入两个堆中，注意需要保持两个堆的数据个数绝对值在1以内。这样两个堆的堆顶即为中间，把这些数据都读完，要找的数据就是两个堆的堆顶数据了。

# 脉脉技术类其他

面试题提问，有http为什么要用dubbo，期待大佬们的回答 阿里腾讯美团滴滴华为引流 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU2MDk5MjQsImlhdCI6MTU4NTMwNzk0NH0.WsAUUfUHlGLEhXypL6lhqlcev0pKWShiUtY0PrmMNqU
- > 不用维护域名，因为域名解析的缓存千奇百怪
- > 长链接，适合高并发，http每次需要三次握手四次挥手
- > 知乎上热贴，rpc比http强在哪，可以看看
- > 当你每扩容一批机器你就得切nginx你就知道为什么了
- > 链接是一方面，另一方面http报文里面有很多无用信息，rpc协议通常都是相当简化的

面试题：如何快速定位死锁 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU1NTQzNTYsImlhdCI6MTU4NTIwOTUxMX0.UAvO_vPImQ4ZYxjwDvqOwZB3r0JcG4sNzABjF7nC7F4
- > top看cpu占用，看load
- > 如果是C++，gdb attach 到进程上，generate core，gdb 打开 core，threads apply all bt
- > C++一般是 top -Hp和pstack配合用
- > pstack 就够了

# 脉脉八卦

头条用户运营前领导终于要滚蛋了，每天混吃混喝 躲休息室玩消消乐，淘宝 外卖资深用户，业务找她从来都是拖拖拖，没事看不到他 出事只会甩锅，这样的** 公司早该摒除了！！最后还是给了机会改过自新 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU3ODI4NTYsImlhdCI6MTU4NjkyMjgzMX0.qjracjZLFESxI8IFLf1NL_h5k9aGbGMEzqdN1tI1q4Y

没喝多真实情况，我带的一个新来的小实习生一直投怀送抱寻求身体接触，应该有所图（转正），如果你们怎么处理。我男的单身，实习生很好看。 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU3NzM3ODUsImlhdCI6MTU4NjY2Nzk3OX0.y_d37q0ugzEJ4OSa70n_3mK9QUMAPxYqo0g96pP92LE
- > 来了就搬到我小区住，一下班没人看到就抱着我胳膊不放这是不小心吗
