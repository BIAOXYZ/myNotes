
解密 MySQL：索引—优化数据库性能的关键（二） https://www.v2ex.com/t/992179
```console
参考资料
- 高性能 MySQL(第三版)
- MySQL 官方手册
```

mysql 这个查询速度正常吗，怎么优化？ https://www.v2ex.com/t/986389
- > `count(journal_pub_year)` 试一试？或者 `count(pm_id)` 试一试？
- > 500 万行 = 5M 行, 你要是不需要 InnoDB 的特性，试试用 MyISAM 。一般这种静态表可以不用 InnoDB ，如果必须要 InnoDB 看看增大 `innodb_buffer_pool_size` 。
- > 我测试了一下，甚至 sqlite3 也没有这么慢
  ```sh
  $ sqlite3 test.db
  SQLite version 3.40.1 2022-12-28 14:03:47
  Enter ".help" for usage hints.
  sqlite> create table random_data as
  with recursive tmp(x) as (
  select random()
  union all
  select random() from tmp
  limit 5000000
  )
  sqlite> select count(1) from random_data;
  5000000

  $ time sqlite3 test.db 'select count(1) from random_data;'
  5000000

  real 0m0.175s
  user 0m0.124s
  sys 0m0.051s
  ```
- > mysql 的全表 count 就是这么慢的, 你要么换 sql server 或者 oracle, 表 count 瞬间返回
- > 缺少数据库参数，`innodb_buffer_pool_size` 是多少
- > 无语…才四千万你优化它干毛
- > 肯定是用了默认的 InnoDB 存储引擎，***InnoDB 的 `count` 是需要全表扫描的，如果不需要用到事务，建议换成 `myisam` 存储引擎，元数据直接记录表的记录数的***；另外，***不要 `count(1)`，`count(pm_id)`，`count("主键")`是最快的了***。
- > 这个 count 语句相等于扫描全表了，慢是正常的。
  * > 1.MySQL 单表数量上限很高，这种数据量级不算大。
  * > 2.建议根据具体场景优化，比如针对这个 SQL ，如果不考虑删除，那么可以 count 1 次，然后用缓存计数，后面就不用 count 了；或者加一个自增 id 字段，设置从当前 count 之后开始自增，这样只需要记录新增后的自增 id 值就行了。
- > 你这 4000 万数据不用分表，直接查询，count 一定要代条件，建议为时间建立索引，只 count 最近几天的，就能快非常多。

自定义表单在数据库中要怎么储存？ https://www.v2ex.com/t/985627
- > mysql 5.7 以上 支持 json 类型，要么这种自定义结构存类型 要不使用 meta 元数据表和字段 <br> 你可以看看 wordpress 的表结构是如何扩展的 https://codex.wordpress.org/Database_Description
- > text 改成 json 吧 不然不好做搜索，但是要支持搜索还是得用 es ck 啥的

【[:star:][`*`]】 MySQL 单机 QPS 是多少？ https://www.v2ex.com/t/983276
```console
在一篇博客中看到 MySQL 不适合高并发，2000QPS 就开始报警，真是这样的吗？ MySQL 单机的 QPS 在怎样的一个范围？

mysql 这么重的数据库，压根儿设计不是让你玩儿高并发的，虽然也可以玩儿，但是天然支持不好。mysql 单机支撑到 2000QPS 也开始容易报警了。
https://doocs.gitee.io/advanced-java/#/docs/high-concurrency/why-cache
```
- > 这不得看机器配置么。而且数据库不仅要看 QPS ，也得看 TPS 。明天看看华为给的手册再回复你，mark 一下。
- > QPS 的话，MariaDB 达到过 100 万 qps https://mariadb.org/10-1-mio-qps/ <br> TPS 的话，2000 压力其实挺大了
- > https://help.aliyun.com/zh/rds/support/test-results-of-apsaradb-rds-instances-that-run-mysql-8 哥们,这个是阿里云的 mysql 性能测试, 你可以看下, 不同的机器表现不同. 我查了一下,腾讯云和华为云的性能差不多. 在高级 SSD 加成的情况下, 1 核 1G 的机器都可以到 40 万 QPS. <br> 这个问题,你也可以实际安装一个 mysql 看下. 跑一些脚本很快的. 要是只有 windows 机器, 你可以花 1000 块钱买一个 7 年前的 macbook air 专门用来做类 unix 的性能测试什么的. 这个测试的过程会让你学到很多. 自己测出来的数据,你也会更加理解这些数据的意义.
  >> 感谢老哥，这个很有参考价值
- > 我们用的 rds mysql 最低配要到 2w qps 才会 cpu 100% <br> 日常几千 qps 吧
- 个人补充链接：
  * MariaDB 10.1 can do 1 million queries per second https://mariadb.org/10-1-mio-qps/
  * MySQL 8.0测试结果 https://help.aliyun.com/zh/rds/support/test-results-of-apsaradb-rds-instances-that-run-mysql-8
    + > 根据业务场景的不同，RDS MySQL 8.0的测试结果可能会低于RDS MySQL 5.7，属于正常现象。

公司数据库数据被我更新成 null 了，救命！ https://www.v2ex.com/t/865464
```console
数据库有些数据值为: "保密"
前面我在用 regex_replace 函数更新一些不规范数据
我顺手就用 update lawyers set working_years=regexp_replace(working_years, "保密", null); 把 "保密" 更新为 null
结果 working_years 字段全部被更新为 null !!!
有办法恢复吗，大佬救命！！！
```
```console
大哥们，数据没找回来，事情解决了是因为数据是实时抓取的数据，每天都要从互联网某些网站抓取更新，所以并不是很重要。
```
- > 手机叫个快车，赶紧收拾东西跑路
- > 有备份的话回档吧
  >> 没备份咋办
  >>> 备份没有，binlog 也没有？
- > mysql 的 update 有一个很强的非标准特性，就是可以加 limit 。初学者请务必每次 update 请务必用 limit 1 。
- > 开事务日志 /binlog 没？没就抗拒从严 回家过年
- > 备份没有的话 就看 binlog 开了没有 开了就可以解决(记好时间点)， 没有开的话....
- > 先不要操作了，看下 data 目录下的 binlog 日志文件吧，以 utf8 打开，一个一个补数据吧
- > 解决了，想问一下大佬 <br> `update lawyers set working_years=regexp_replace(working_years, "保密", null)` <br> 这条命令为什么会把我的全部数据替换为 null
  >> 把保密更改为 null ，为什么要用 regexp_replace 这个正则函数？正常思路难道不是这样吗？ `update lawyers set working_years=null where regexp_replace='保密';` <br> 至于为什么换替换为 null ，根据文档 https://dev.mysql.com/doc/refman/8.0/en/regexp.html <br> `Replaces occurrences in the string expr that match the regular expression specified by the pattern pat with the replacement string repl, and returns the resulting string. If expr, pat, or repl is NULL, the return value is NULL.` <br> 大概意思正则匹配到了，则返回替换后的结果字符串，如果给定的三个参数里有 null ，则返回 null 。而你的第三个参数恰好是 null ，所以全被替换成 null 了。
- > 下辈子改数据库前记得先打 begin;
- > 都是惨痛教训:
  ```console
  1. 不是迫不得已不要手动改库
  2. 真的要手动改库一定先 select 一下看看影响的行数
  3. 改之前先改一条试试看, 防止写错了
  4. 大规模改库要备份
  ```
- > 生产环境改数据一定要备份再执行,开日志
- > 这种 update 或者 delete 都还好，都有 log ，dba 都能恢复 <br> truncate 或者 drop 那种很难抢救回来（只能依靠之前的备份数据，会有丢失）
- > update 不加 where dba 能让你跑？

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
