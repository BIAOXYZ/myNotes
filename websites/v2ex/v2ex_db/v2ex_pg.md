
请假各位大哥 pg 中一个相对比较简单的查询为什么效率这么低 https://www.v2ex.com/t/1109750
- > union all 了以后, views 里的 id 就没有索引了.

论坛应用， postgresql 一行的数据大小在什么范围内比较好，超过 1mb 会有什么问题吗？ https://www.v2ex.com/t/1066583
- > pgsql 有 `TOAST` 存储，超过 `TOAST_TUPLE_TARGET`(通常 2KB)的字段会尝试压缩，压缩不下去就存储在物理行外。 <br> mysql 用户处理类似需求的时候，喜欢把大字段单独放一个表，在主表行中存储大字段那个表的 id 。 <br> 当然，在 pgsql 中你也可以这么做，但是要避免 pgsql 给你的副表再搞一个副副表。
- > 用 pg 存文本感觉性能上有点麻烦？我们项目一开始就是用 pg 存的文本，当然我们疑似有点极端了吧可能，一段文本就是 200MB 起步，光是测试环节就能一天生成几千条这种数据（ <br> 最后还是得迁移，大部分塞 mongo ，冷数据转换成 txt 文件塞 minio
- > 在 PostgreSQL 中，TEXT 类型可以存储最多 1 GB 的文本数据，所以存储下来不是问题。问题是要不要采用这种方案，如果你的文本并不需要全文搜索，那可以考虑外部存储的方案。可以看看 MinIO 、Ceph 、OpenStack Swift 、SeaweedFS 、Zenko 等
- > 论坛这个我懂，毕竟搞过几个门户，都是几百万几千万级别用户的。。。一个月 uv 也是千万级别吧。 <br> 数据库可以直接存 id ，文本另外存一个表即可，这样做主要是方便写 `select * from post` 。 <br> 至于性能，那是搜索引擎（我们那时候是 sphinxsearch 和 elasticsearch)和缓存（数据缓存，页面缓存，客户端缓存）的事情，数据库负责写，负载大部分应该在缓存和搜索引擎。

学习 PostgreSQL，有什么资料推荐？ https://www.v2ex.com/t/1062183

有没有懂 PG 数据库的，新项目要使用 PG 数据库，是使用多库单模式，还是使用单库多模式？ https://www.v2ex.com/t/1057710
- > 生产上就是一套实例一个库。其他环境在一台机器上，不同环境用库划分，不同业务用 schema 划分。postgres 库和 public 模式禁止使用。
  >> 大佬 为什么禁止使用 public （刚接触 pg 库
  >>> 应该反问：为什么要用 public 库?
  >>>> 使用 public 的话，后端微服务就不用指定模式了（大概？）就和 mysql 一样用了 这样看起来也体现不出来啥区别，感觉也没有啥问题
  >>>>> 有种东西叫 search_path ，不用特意设置。不带表名，也会默认访问和修改自己 schema 的表。

postgres 咨询锁性能问题 https://www.v2ex.com/t/994540

Postgresql 升级问题 https://www.v2ex.com/t/906314

postgresql 里面的事务，明明又错误为什么也执行了？ https://www.v2ex.com/t/882893
- > 没毛病，两条语句都执行成功了，所以事物成功了。第一条更新 1 条记录，第二条更新 0 条记录，都执行成功。
你问的应该是，怎么让更新 0 条记录的时候 update 语句失败，而不是成功。你可以在 update 之后加 returning id ，返回受到更新影响的行的主键。这时候 0 条记录更新的情况下，会直接失败。

在 PostgreSQL 上面有么有类似美团 SQLAdvisor 的工具？ https://www.v2ex.com/t/874067
```console
基于 MySQL 原生态词法解析，结合分析 SQL 中的 where 条件、聚合条件、多表 Join 关系 给出索引优化建议。 https://github.com/Meituan-Dianping/SQLAdvisor
```

怎么对比 postgres 数据库数据变化 https://www.v2ex.com/t/872353
- > audit.audit_table
- > 我觉得是需要的是 CDC(change data capture), 可以使用类似 WAL 或者 audit_table 这类；还是类似版本管理的那种
- > 感觉你需要的是 CDC -- https://airbyte.com/blog/change-data-capture-definition-methods-and-benefits

请教各位老哥， PostgreSQL、PostGIS 基于地理空间的查询如何优化速度？ https://www.v2ex.com/t/852771

PostgreSQL 分页查询 CPU 吃满的问题 https://www.v2ex.com/t/797877
```console
疑问
数据库服务器配置 20 核 32G，单机。100 并发持续时间 180 秒对某个简单分页查询接口进行压测。
期间应用服务器正常，数据库连接正常，但数据库服务器 CPU 占满，请问这是正常现象还是啥问题....

sql
单表分页的首页查询，表内 1000 万数据，筛选出的数据为 28w，大概 sql 如下：
SELECT a,b,c,d,e FROM table WHERE del_flag = 0 AND c LIKE 'c%' order by e desc limit 10
SELECT COUNT(*) FROM table WHERE del_flag = 0 AND c LIKE 'c%'
```
- > 大表不要 count
  >> 业务需要，无可避免啊
  >>> 业务上可以缓存计数.
  >>>> 完了.带 like..当我没说.查询条件多变的话缓存也救不了
- > `EXPLAIN` 看下索引是否设置正确。另外如果业务经常使用 `COUNT(*)` ，建议把相关值放入内存缓存或者缓存表。
  >> 带 `LIKE` 的话效率不太好优化了就。除非上一些比较复杂的优化，例如搜索数据全量进缓存后续读取靠缓存，以及单独的检索服务器之类的。 
- > 查询条件多变的情况如何处理呢，这个值很难保证准确吧。。。
  >> 加 `gin 索引` & `pg_trgm` 模块是个可以尝试的办法。不过得分析下主要的查询方向交给 DBA 看看怎么加比较优化。
- > 新版本 索引 有优化 <br> pgsql 不(傻瓜)支持忽略大小写查询，业务开展有困扰吗，其它几个关系型数据库都支持 <br> oracle mssql mysql 起步 300M，而 pgsql 只需要 30M，而且性能测评还占上风，对于个站小🐔部署优势巨大，就卡在大小写查询的问题(用 EFCore)
- > del_flag 和 c 都有索引嘛？
  >> 前者无，后者有
  >>> 看看这个 https://github.com/digoal/blog/blob/master/201801/20180119_03.md
- > 可以指定慢 sql 使用某个 cpu 核心, 让这个核心慢慢跑就是了. 比如 8C16G, 打满一个核心, cpu 占用率也就 12.5%

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
