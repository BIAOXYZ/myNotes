
# SQLite官方

SQLite https://en.wikipedia.org/wiki/SQLite

SQLite https://www.sqlite.org/index.html

Official Git mirror of the SQLite source tree https://github.com/sqlite/sqlite

# SQLite新闻

Fedora Linux：计划将 RPM 数据库从 Berkeley DB 迁移到 SQLite https://www.ithome.com/0/478/504.htm
```
祖安卢本伟2020/3/19 9:54:58
…现在就在搞数据库迁移。原来Oracle不支持主键，删掉用来自增的序列和触发器，换成现在的主键自增；还
有前后索引长度限制不同；函数支持不同；字段类型不同；甚至还有优化器导致的性能问题，三个join的语句，
在Oracle神优化器加持下，秒出数据，现在两个小时都不出数据你敢信？基本断定是卡死了。还有那种with as
的树状递归select，也是一样的情况。反正切数据库是个巨坑
```
