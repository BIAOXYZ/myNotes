
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
