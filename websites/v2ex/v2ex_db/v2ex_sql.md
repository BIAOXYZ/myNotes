
哪里有 sql 的练习可以做 https://www.v2ex.com/t/1034135
- > 你需要的是这个： https://www.sql-practice.com/
  >> 这个挺好，不用自己建表了，还是多张表关联，日常用到的都涵盖了。
- > 《 SQL 解惑（第二版）》，里面有 75 个问题，并用 SQL 编程解决。跟着做完，SQL 能力肯定能提升很多。。
- > 不知道有没有过时 sqlzoo
- > hackerrank

【[:star:][`*`]】 大家喜欢用 ORM 还是直接写 SQL https://www.v2ex.com/t/1004383
- > 投 SQL92 一票。小项目怎么顺手怎么来。大项目特别是有性能要求的，ORM hold 不 hold 得住先？
- > 都用，***简单的 orm ，复杂的 sql***
- > orm 好用的多，特别是那种关联关系 <br> 手写 sql ，如果在后续需求中，需要加入软删除，是不是每个 sql 都要检查，包括链表查询 <br> 还有一对多和多对多，后续调整的时候，如果手写这种 sql ，是不是差不多项目要重构了？如果用 orm 的话，就简单很多了 <br> 有说如果 sql 很复杂，orm 的性能跟不上，可能我代码写的少了，我并没有遇到 sql 很复杂的情况，如果 sql 很复杂多链表的情况，一般都是 分成多个简单的 sql ，然后用程序处理的吧
- > 不确定我理解的对不对。ORM 主要解决的是编程语言数据类型与数据库类型不一致，进而实现了，切换数据库而不用修改代码的结果。但是这种结果在现实条件里太少了，没有人会无聊了换数据库玩。那么回到语言类型与数据库类型不一致的问题上来，其实自己解决也并没有多麻烦，特别是现在许多数据库支持一些非简单类型的数据，（例如 JSON/Blob 等等），对于这些类型，ORM 反而支持的不太好，还不如自己手写。所以现阶段来看，我粗浅的认为，ORM 并不是必须的（也就是说并没有解决什么实质上的问题），依据个人习惯来好了。手搓 SQL 更能控制 SQL 语句的质量与规模。我想没几个项目从头至尾都是简单的单表查询吧，多表查询，ORM 生成的语句质量，一般也就是个中规中矩，能用的水平。
  >> 现在数据库之间的差异 太大了.已经不是 orm 能弥补得了.对于日常两三张表 join 以上的情况 只有手写 sql.如果日常不 join 表 那肯定可以用 orm.
- > ***我只知道原生 SQL 防 SQL 注入很麻烦，特别是自己拼的原生 SQL***。而如果你自己做防注入了，又很像在干 ORM 该干的事情。 <br> ORM 的话，因为我写 python ，公司的项目用的 SQLAlchemy+FastAPI+Gino ，稍微有点学习成本，有些写法文档也没介绍，会有隐藏的坑，但是熟悉之后写起来还是挺舒服的。 <br> ***性能肯定是原生好，因为 ORM 除了负责把代码对象变成 SQL 语句去执行，还要把查询结果又加载成代码对象，写起来是很舒服，但是中间的转换是有代价的***。
- > python+sqlalchemy ，非常好用，三四张表 join 起来没什么问题
- > 那些说喜欢 ORM 的来，***多表链接 + 多个子查询 + 聚合查询 + 动态条件，用 ORM 给我写个看看***
  >> 大点的业务一般都不让连表和聚合。ORM 的优势正是动态条件，几十个条件拼接，完全不用考虑语法错误，SQL 拼接会死人的。
- > ***让你看看真正的 SQL*** ![](https://pic.imgdb.cn/item/658e6c03c458853aef6eb1ee.png)
  >> 这条 sql 是不是直接保住了饭碗，没人敢动
- > ***直接手搓 sql ，别人也能看得懂***，复杂的逻辑可以取完值后再做逻辑运算。
- > 最近在做信创迁移，A 系统中存在大段手写的 MySQL 方言，B 系统基本上使用的都是 mybatis 框架实现的（SQL 标准兼容比较好）。***两个系统的迁移成本估计为 5:1 ，因此从可维护性角度还是建议采用 ORM 框架***
  >> 那明显是 A 好啊。要是都得 A 至少有多四个人有活干，养活一家老小。你可能只是用一个简简单单的 orm 框架，未来有四个人因为你的这一举动而失业，换不起房贷，老婆和别人跑了，3 个还不是自己的，收手吧
- > ORM 实现不了、性能过低才考虑 SQL
- > 我们查询的报表 sql ***一堆函数和嵌套***，orm 不太适合这种场合
- > 表设计好，orm 当然效率更高。表设计差，当然 sql 更好写。

【[:star:][`*`]】 SQL 中 on 条件与 where 条件的区别 https://www.v2ex.com/t/892254
- > 实际上一棍子打死还是不行的，总得看是什么类型的数据库，然后看其优化的逻辑；我干了 6 年一直用 Oracle ，实际用下来，很多场景中，其实 CBO 优化器都已经帮忙计算好了执行计划，两者基本没有差距；但是在复杂的语句（动辄百行以上），CBO 分析不过来的时候，on 能更好的帮助确定过滤集。
- > A join B, on 与 where 效果是一致的 <br> A left join B, on 与 where 就有差别了，on 是过滤临时表的，B 表中的数据不满足 on 条件时会只返回 A 表数据(B 表数据为 null)，where 是对整个结果进行过滤

逻辑大量的写在 sql 语句里 https://www.v2ex.com/t/835439

求 sql 优化才几万数据查询都破 1s 了 https://www.v2ex.com/t/782918

sql 改写类的数据脱敏遇到的问题求助 https://www.v2ex.com/t/727240

SQL 怎么查询满足多个属性的数据？ https://www.v2ex.com/t/713866
- > 你指的是什么呢？下面这个例子里 C 并不会被选出来呀。 <br> www.db-fiddle.com/f/8rhX2qJheqvz1Gg2t7oasc/0

大佬们求救，慢 SQL 问题 https://www.v2ex.com/t/695266

这两种 sql 写法有什么区别么？把查询结果当做临时 table 来查会更快么？ https://www.v2ex.com/t/687580

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

各位好，请教个 SQL 查询问题 https://www.v2ex.com/t/675639

abc 联合索引查 bc 走不走索引 https://www.v2ex.com/t/655560

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
