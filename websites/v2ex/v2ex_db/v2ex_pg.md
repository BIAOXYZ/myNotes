
PostgreSQL 的 pg_try_advisory_xact_lock 正确使用姿势是什么 https://www.v2ex.com/t/787443
- > https://github.com/digoal/blog/blob/master/201707/20170720_01.md  google 第一页就有

PG 也不学好 https://www.v2ex.com/t/785716
```console
今天才知道，原来 PG 默认也是可以在 INTEGER 字段上写入以字符串表示的数字的。也会把数值转成字符串写入 VARCHAR 字段，只有宽度限制。
我还以为只有 MySQL 有这种行为。
```
- > PG 本来就有很多 IMPLICIT CAST，甚至你可以自定义 CAST 。
- > 不这样的话，sql 中怎么表达 datetime 类型呢
  >> 你这么一说确实有道理了。
- > 常量定义里，data，timestamp，interval 这一类变量前面都可以用关键字+字符串 表示是某种类型的变量。隐式转换在很多数据库中都存在的

PostgreSQL 为什么不使用 direct IO，而要依赖 os page cahce？ https://www.v2ex.com/t/752942

postgres 用户登录问题 https://www.v2ex.com/t/730231
- > 解决了。。。。没注意到上面的那个 postgres，一直修改的是下面那个两个 all 的。。。。 
  ```conf
  # Database administrative login by Unix domain socket
  local all postgres md5
  
  # TYPE DATABASE USER ADDRESS METHOD
  
  # "local" is for Unix domain socket connections only
  local all all md5
  ```
- > -h 走 tcp socket. 不加走 unix domain socket.

就想问问多少人知道 PostgreSQL ？ https://www.v2ex.com/t/729909

Postgres to_timestamp() 无法转换 unix epoch 字符串 https://www.v2ex.com/t/712510

如何查看 pg data/base/dboid 下每张表里都是啥东西 https://www.v2ex.com/t/700663

emmm 没太能理解, 为啥我用 postgres 的 dbowner 去访问库中的表，还是没权限 https://www.v2ex.com/t/700398

求问各位 V 友 PG 库的批量插入问题 https://www.v2ex.com/t/692169

PG 库，查询优化。 https://www.v2ex.com/t/677846

PostgreSQL 有没有办法统计每个 SQL 执行的次数 https://www.v2ex.com/t/677366
- > pg_stat_statements 这个插件
- > Redhat Debezium 可以监控所有的数据操作，EDA 框架，可以发送 Apache kafka 等。 https://debezium.io/ <br> 其实这东西实现也不是太难，在 SQL 执行之前加入 Hook， 通过消息发送到自己的统计数据库（比如 Redis ）里面去。
- > 日志开启 sql 记录，pgbadger 分析日志
- > https://www.postgresql.org/docs/current/pgstatstatements.html

问一个 postgresql 传参问题 https://www.v2ex.com/t/664998

遇到一个 PostgreSQL 很奇葩的排序问题（BUG？） https://www.v2ex.com/t/663098

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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
