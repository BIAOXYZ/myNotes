
# 脉脉数据库

今天被朋友问到一个问题，如果有1亿条数据，深度limit时，怎么优化？我是这么回答的，有木有问题。 https://maimai.cn/web/gossip_detail?src=app&webid=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlZ2lkIjoiYWJiNzBlNjA2YzU4MTFlYWI2Zjc4MDE4NDRlNTAxOTAiLCJ1IjoxOTU4OTUxOTUsImlkIjoyNTU0NDg0N30.QMz3eiKFEn9HHF0RC1efsV3l5BKfPqCEsB36T3n75Bo
- > 我遇到过，当时解决是select * from a where id in (select id from a limit x，y) 充分利用主键索引比二级索引块的优势。如果这样都会事物超时，只能顺序分表了。
  >> 老哥，请问 select * from table where xxx limit a,b和select id from table where xxx limit a,b 速度有区别吗？
  >>> 有，假设 id 是自增主键，引擎是innodb，xxx上有索引。select * 的时候会先查索引找到对应的 id，再通过 id 找到这一行的数据，就是回表，两次IO。而 select id 只走一次IO
- > 典型的分裤分表和分页场景，经验：大于100w条数据时分表，查询时使用id作分页参数而不是limit
- > 只讨论一亿数据是没意义的，一行数据有多大？如果没有复杂查询的话能不能用nosql比如hbase？是oltp还是olap？

# 脉脉算法与数据结构

最近面试的算法题，我想了很久还是没想到，求大佬指点。问题：“假设有一个数字类型的数组，量级达到数亿亿别。如何找到最大的第十个数字？” 答：“新建10个元素的数组，循环取出大数组的数据和小数组对比，大的替换到小数组，小的则抛弃” 再问：“如果要找最中间的那个数字，应该怎么找？” https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU1NDMwMjYsImlhdCI6MTU4NDkzNjAyMX0.eq-ByP2zeWe62KfZbyWpqWl2kLbWaQzek2qk1EtBw58
- > 二进制分治，按最高位是0或者1写入到两个文件，并记录两个文件写了多少个元素，然后就可以知道中间那个数在哪个文件里。接下来对次高位进行同样的操作。。。最后剩下的就是所求。其实就是转换成了求第k个数。
- > 建两个堆，一个大顶堆一个小顶堆。一个个读取数据放入两个堆中，注意需要保持两个堆的数据个数绝对值在1以内。这样两个堆的堆顶即为中间，把这些数据都读完，要找的数据就是两个堆的堆顶数据了。
