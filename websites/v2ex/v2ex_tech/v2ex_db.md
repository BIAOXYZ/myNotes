
MySQL 可重复读隔离级别下是否解决了幻读问题 https://www.v2ex.com/t/692386

求问各位 V 友 PG 库的批量插入问题 https://www.v2ex.com/t/692169

这两种 sql 写法有什么区别么？把查询结果当做临时 table 来查会更快么？ https://www.v2ex.com/t/687580

MySQL 是这样实现可重复读的 https://www.v2ex.com/t/687341

MySQL 插入意向锁的作用是什么？ https://www.v2ex.com/t/686462

关于“数据库系统概念 - 第 15 章 并发控制 - 15.5 基于有效性检查的协议”的疑问 https://www.v2ex.com/t/684807

一个关于 mysql 锁问题 https://www.v2ex.com/t/683424

自学 sql 中，遇到了一个问题，请教大家：如何在以下 query 里显示排名 3-5 的国家？ https://www.v2ex.com/t/679847
```console
我在这个网站上训练自己对 query 的理解：
https://sqlzoo.net/wiki/SELECT_basics

我想知道，如何显示在“Asia”里，“population” 排名 3-5 名的国家？
```

工作中同事问的一个问题，查了很久没有明白，望大神指点 https://www.v2ex.com/t/677955
```console
有一个表 TableA，数据量很大，约 4000w 条。
使用 where 条件，where TableA.columnA='value'后，可以查出约 70w 条数据。

现在有个业务逻辑: 想在 TableA 中使用 where 条件 where TableA.columnA='value'查询数据，并且将数据按照时间戳排序，所以最后的 sql 是:
select * from TableA where TableA.columnA='value' order by timestamp;

通过 explain 发现，此次执行是一个 simple 查询，扫描了全表 4000w 数据(columnA 上没有建索引，所以是正常的)，耗时 13s 。
但是奇怪的是，如果不用 order by，直接 select * from TableA where TableA.columnA='value'; 花了 1s 不到的时间，因此，可以认为时间都花在了 order by 排序上。
于是他用 select * from TableA order by timestamp; 发现也需要 17s 左右的时间，验证了时间都花在了 order by 上。

现在我的同事灵机一动，想到可以把数据用子查询先查出，再做排序，按道理因为子查询查出的数据量只有 70w，已经降了两个量级了，
这个时候再做排序应该要轻松一些。于是: select * from (select * from TableA where Table.A.columnA='value') as B order by B.timestamp; 但是用 explain 一看:

'1','SIMPLE','ulog_data_attitude',NULL,'ALL',NULL,NULL,NULL,NULL, 'xxx','xxx','Using where; Using filesort'

发现用没用子查询执行计划都一样。

现在的问题是:
1. 为什么「先用子查询查出数据，再用 order by 排序子查询的数据」的方法行不通?
2. 这个查询除了对 columnA 建索引外，有没有其他更好的优化方法?
```

PG 库，查询优化。 https://www.v2ex.com/t/677846

PostgreSQL 有没有办法统计每个 SQL 执行的次数 https://www.v2ex.com/t/677366
- > pg_stat_statements 这个插件
- > Redhat Debezium 可以监控所有的数据操作，EDA 框架，可以发送 Apache kafka 等。 https://debezium.io/ <br> 其实这东西实现也不是太难，在 SQL 执行之前加入 Hook， 通过消息发送到自己的统计数据库（比如 Redis ）里面去。
- > 日志开启 sql 记录，pgbadger 分析日志
- > https://www.postgresql.org/docs/current/pgstatstatements.html

各位好，请教个 SQL 查询问题 https://www.v2ex.com/t/675639

事务的原子性是由 redo log 还是 undo log 实现的? https://www.v2ex.com/t/674050

如何选择国产数据库：人大金仓？达梦？南大通用？请 V 友指点 https://www.v2ex.com/t/670566
- > 估计你是要做 AK 项目吧。目前都不够成熟，两个版本之间，都会出现 api 不兼容差异很大的情况，而且这几家都是几百人的公司，比 oracle 的技术服务能力差太多了。最重要要考虑的是选技术支持出现场方便的。如果在帝都建议选金仓，南方地区选达梦。
- > 最近做过高斯、人大金仓和达梦的适配，性能没去具体测试，就迁移难度和技术支持来说，我选达梦，人大金仓也还可以，华为的高斯请直接放弃。
- > 人大金仓好象是基于 PostgreSQL 来做的。如果考虑 oracle 移植的话 人大金仓不二选择。但是要说这两个国产数据库那个做得好的话，那还得是达梦。
- > 看你的描述 如果对数据库的性能要求不太大的话，基本不需要 dba 对数据库进行针对性调优的话，用人大金仓好一些， 如果考虑到后期扩展还是上达梦。话说国产化这些东西 应该根据客户的需求来考虑兼容具体的数据库品牌吧。
- > 让我想起来前一段时间因为 neo4j 企业版 3.5 以后的需要收费。所以选择了国产的 nebula graph 图数据库。然后感受了不到三周经理受不了了，就换回了版本低一些的 neo4j 。。。。。白给了三周时间。。。。。
- > 用过达梦和南大通用,还是达梦好用些...
- > 达梦的空间数据。。。一言难尽。为了保证上线演示，安排专人在机房重启服务。不过这个是好几年前的事情了，现在不知道怎么样了

mysql 查询会加锁开启事务吗？ https://www.v2ex.com/t/670314
- > 
  ```
  mysql 读分为两种，锁读和一致性读
  锁读（共享读（ select in share mode ）和排它读（ select for update ））会加锁
  一致性读（普通的那种读）不加锁

  开启还是不开启事务，这和应用端事务设置以及数据库事务设置都有关系
  ```

数据库 MySQL 可以暴力迁移吗？ https://www.v2ex.com/t/667363

问一个 postgresql 传参问题 https://www.v2ex.com/t/664998

遇到一个 PostgreSQL 很奇葩的排序问题（BUG？） https://www.v2ex.com/t/663098

求助 mysql & 运算符是什么意思， 怎样解释 https://www.v2ex.com/t/660327

数据库索引笔记 https://www.v2ex.com/t/660228
- > https://use-the-index-luke.com/
- > Use the Index, Luke! 笔记1 https://www.kawabangga.com/posts/3893

关于 B+tree 索引的疑问 https://www.v2ex.com/t/657136
- > 在网上遇到自己不确定知识点的时候，最简单且有效的办法就是自己动手验证。MySQL InnoDB 存储引擎实际存储就 3 个文件: .opt, .frm, .ibd ，其中.ibd 为实际存储数据和索引的地方，聚簇索引和辅助索引数据均在该文件中。建一张测试表，写点儿数据，然后闷头分析.ibd 文件就行了。
当初我对这东西也很有疑问，动手分析了之后明白了个大概。后面自己写了篇博客，希望对你有帮助。PS: 推荐《 MySQL 技术内幕-InnoDB 存储引擎》，相信能解答你许多疑惑。
  >> MySQL物理存储方式 https://smartkeyerror.com/MySQL-physical-structure

关于用 Redis 限制用户行为频率的方法，麻烦 V 友帮看看 https://www.v2ex.com/t/657135

有没有文章直接指出 MYSQL 四个隔离级别（特别中间两个）下到底怎么上锁，上什么锁的？什么不可重复读，幻读乱七八糟的 https://www.v2ex.com/t/655784

abc 联合索引查 bc 走不走索引 https://www.v2ex.com/t/655560

PostgreSQL 用正则表达式对字符串进行截取的方法 https://www.v2ex.com/t/654241
- > `select regexp_replace(str,'.*(A\d{10}).*','\1','g')`
```sh
# 个人试了一下：

$ docker volume create pgdata
pgdata
$ docker run --name postgres -e POSTGRES_PASSWORD=2018 -d -p 54320:5432 -v pgdata:/var/lib/postgresql/data postgres:9.6
// ...
// 拖镜像过程输出省略
// ...
$ docker exec -it postgres bash
root@93ace25c5739:/# 
root@93ace25c5739:/# psql -U postgres
psql (9.6.17)
Type "help" for help.

postgres=# select regexp_replace('阿萨框架获得撒阿斯达 A3829232472 家快捷键', '.*(A\d{10}).*', '\1', 'g');
 regexp_replace
----------------
 A3829232472
(1 row)

postgres=# select regexp_replace('000A3829232472000', '.*(A\d{10}).*', '\1', 'g');
 regexp_replace
----------------
 A3829232472
(1 row)
```

为什么手动编译后的 MongoDB 比官方提供的（包管理器下载）二进制版文件大这么多？ https://www.v2ex.com/t/635085
- > 可能是没 strip 吧，关键词 linux strip
- > 这么大也不像是 debug 版的大小啊，静态链接了？
- > linux 下用 readelf，其次就是看编译的时候有没有指定参数比如"-g"这种。

多源数据融合，建数仓，数据统计分析一般有哪些架构和技术？区别是什么？ https://www.v2ex.com/t/625567

腾讯基于 PostgreSQL 历时 8 年研发的 HTAP 分布式数据库 TBase 开源了，对数据库有兴趣的同学可以去了解体验一下 https://www.v2ex.com/t/619632

数据库的发展趋势是什么？ https://www.v2ex.com/t/612782
- > NoSQL 的建议看一下《 NoSql 精粹》，里面讲了不同的 nosql 数据库的擅长的地方、与关系型数据库的对比。挺薄的一本书的。作者是（著名的） Martin Fowler。
  * 《NoSQL 精粹》 http://www.java1234.com/a/javabook/database/2016/0721/6434.html
- > 看一下这本书: Designing Data-Intensive Applications, 就知道分布式(强)一致性有多么难做. 不知道 NewSQL 是怎么解决这个问题的.
  * 《Designing Data-Intensive Application》DDIA中文翻译 https://github.com/Vonng/ddia
    + 设计数据密集型应用 - 中文翻译 https://legacy.gitbook.com/book/vonng/ddia-cn/details
  * 《Designing Data-Intensive Applications》 http://www.java1234.com/a/javabook/javabase/2017/0914/8912.html

最近阅读了《MySQL 必知必会》这本书，写了一篇读书笔记，请大佬们过目！ https://www.v2ex.com/t/581631
- > 客官，这里有一份《MySQL 必知必会》读书笔记，请您笑纳! https://juejin.im/post/5d2335846fb9a07f021a2509

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
