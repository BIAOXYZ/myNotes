
# 脉脉数据库

今天被朋友问到一个问题，如果有1亿条数据，深度limit时，怎么优化？我是这么回答的，有木有问题。 https://maimai.cn/web/gossip_detail?src=app&webid=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlZ2lkIjoiYWJiNzBlNjA2YzU4MTFlYWI2Zjc4MDE4NDRlNTAxOTAiLCJ1IjoxOTU4OTUxOTUsImlkIjoyNTU0NDg0N30.QMz3eiKFEn9HHF0RC1efsV3l5BKfPqCEsB36T3n75Bo
- > 我遇到过，当时解决是select * from a where id in (select id from a limit x，y) 充分利用主键索引比二级索引块的优势。如果这样都会事物超时，只能顺序分表了。
  >> 老哥，请问 select * from table where xxx limit a,b和select id from table where xxx limit a,b 速度有区别吗？
  >>> 有，假设 id 是自增主键，引擎是innodb，xxx上有索引。select * 的时候会先查索引找到对应的 id，再通过 id 找到这一行的数据，就是回表，两次IO。而 select id 只走一次IO
- > 典型的分裤分表和分页场景，经验：大于100w条数据时分表，查询时使用id作分页参数而不是limit
- > 只讨论一亿数据是没意义的，一行数据有多大？如果没有复杂查询的话能不能用nosql比如hbase？是oltp还是olap？
