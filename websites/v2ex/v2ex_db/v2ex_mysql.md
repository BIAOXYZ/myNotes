
mysql 怎么迁移数据库到另一台机器 https://www.v2ex.com/t/851262

MySQL 只读操作一般需要开启事务吗？ https://www.v2ex.com/t/838964
```console
我之前一般都是开事务的，但是后来发现其实大多数情况下，业务需求并不需要保证 Repetable Read 。
MySQL RR 级别下，只读操作不开启事务，可以看成效果和 RC 级别一样吗？
```
- > 不开的话，一条 sql 一个事务会不会影响性能？不是很懂
- > 一次执行 100 条 `select` 开启事务和不开启事务效率差别还是比较大的，写程序测试过。
  >> 一条一个事务性能会更差？
  >>> 是的，前不久进行过测试。
- > 读也是有开事务的，只是 mysql 默认是 autocommit,你不需要手动标记事务开始与结束而已
  >> 可重复读的事务级别下，读没有事务好吧，除非你加上 `for update` 这种 X 锁，或者 S 锁 <br> `update` 才会默认 autocommit <br> 即便加上 `for update` 也要用先开启事务，才会生效

看到了一份 MySQL 项目经理写的 MySQL 优化器使用指南，很不错，是精品，做了下中文翻译 https://www.v2ex.com/t/835074
```console
原文： http://www.unofficialmysqlguide.com/index.html
翻译： https://www.liuquanhao.com/posts/mysql%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E5%99%A8%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/
```

mysql 里，如果没有用事务直接 select 会脏读吗？ https://www.v2ex.com/t/762930
- > 现在都是 innodb 引擎，在 innodb 下，你 mysql 的普通读 select 是快照读，压根不会加锁，不管是行读锁还是行写锁都不会影响普通 select，快照读会根据 MVCC 版本链 和 read view 去做判断 不会出现读到 某些事物未提交的情况，当然你的事物隔离级别必须是读已提交以上
- > 嗯，你可以详细了解一下 MVCC，如果读还要加锁，那 mysql 的性能可想而知
- > 那三楼说的 select 的时候 ddl 会等待锁住的应该不是数据而是表的元数据？
  >> 顺便说一句，你说的 select xx for update， 应该是这么一个场景，在我读的时候过程中, 假设有数据正在写并且没有提交，那我要保证我读的是最新的数据，我等到写的事务提交后再读。但是你用快照读也就是普通 select 可能就读不到,正在写但没有提交的这个事物，因为你在我读之前你没有提交，假设这个写的动作很长，在普通 selelct 读完之后，那么他相当于一个未来的事物，我 select 的时候完全不需要关系你未来是怎么变的，我只对当前的操作负责，但是如果你 for update 不会，它会傻傻的等着你写完。

mysql 导入超大 sql 文件有什么办法 https://www.v2ex.com/t/750169

生产环境中正在运行的 MySQL，引擎由 myisam 突然改成 innodb 有什么后果？ https://www.v2ex.com/t/710776
- > 要切换表的引擎等于重建表，索引，数据，触发器等等都要重新建立，主要的重建时间在于数据的迁移阶段。用 pt 做这个事比原生的 ddl online 好些。pt 主要是建立新表，然后插入数据，最后删除旧表并重命名新表。至于有什么影响，主要在于你的业务需求，比如你业务有用到 myisam 的特性而 innodb 没有这个，自然会有影响，否则没啥问题。

写了篇新文章 - MySQL PostgreSQL 和 SQLite 都有什么区别？用哪个？ https://www.v2ex.com/t/703105
- > 哈哈，找到原文了： https://www.digitalocean.com/community/tutorials/sqlite-vs-mysql-vs-postgresql-a-comparison-of-relational-database-management-systems  https://blog.ssdnodes.com/blog/sqlite-vs-mysql-vs-postgresql/

MySQL 查询语句执行顺序疑问：多表关联时会先生成笛卡尔乘积？ https://www.v2ex.com/t/701387

MySQL 可重复读隔离级别下是否解决了幻读问题 https://www.v2ex.com/t/692386

MySQL 是这样实现可重复读的 https://www.v2ex.com/t/687341

MySQL 插入意向锁的作用是什么？ https://www.v2ex.com/t/686462

一个关于 mysql 锁问题 https://www.v2ex.com/t/683424

mysql 查询会加锁开启事务吗？ https://www.v2ex.com/t/670314
- > 
  ```
  mysql 读分为两种，锁读和一致性读
  锁读（共享读（ select in share mode ）和排它读（ select for update ））会加锁
  一致性读（普通的那种读）不加锁

  开启还是不开启事务，这和应用端事务设置以及数据库事务设置都有关系
  ```

数据库 MySQL 可以暴力迁移吗？ https://www.v2ex.com/t/667363

求助 mysql & 运算符是什么意思， 怎样解释 https://www.v2ex.com/t/660327

有没有文章直接指出 MYSQL 四个隔离级别（特别中间两个）下到底怎么上锁，上什么锁的？什么不可重复读，幻读乱七八糟的 https://www.v2ex.com/t/655784

最近阅读了《MySQL 必知必会》这本书，写了一篇读书笔记，请大佬们过目！ https://www.v2ex.com/t/581631
- > 客官，这里有一份《MySQL 必知必会》读书笔记，请您笑纳! https://juejin.im/post/5d2335846fb9a07f021a2509

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
