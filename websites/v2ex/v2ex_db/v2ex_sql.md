
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
