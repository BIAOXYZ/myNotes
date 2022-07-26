
# SQLite官方

SQLite https://en.wikipedia.org/wiki/SQLite

SQLite https://www.sqlite.org/index.html
- Getting Started https://www.sqlite.org/quickstart.html
  * > See also the [Introduction To The SQLite C/C++ Interface](https://www.sqlite.org/cintro.html) for an introductory overview and roadmap to the dozens of SQLite interface functions.
  * > See the [How To Compile SQLite](https://www.sqlite.org/howtocompile.html) document for instructions and hints on how to compile the program shown above.

Documentation https://www.sqlite.org/docs.html
- Dynamic Memory Allocation In SQLite https://www.sqlite.org/malloc.html || SQLite中的动态内存分配 https://www.sqlite.net.cn/malloc.html  【这个不一定是中文官网，但是看样子好像翻译得还行。】
- In-Memory Databases https://www.sqlite.org/inmemorydb.html
  * > The most common way to force an SQLite database to exist purely in memory is to open the database using the special filename "`:memory:`". In other words, instead of passing the name of a real disk file into one of the `sqlite3_open()`, `sqlite3_open16()`, or `sqlite3_open_v2()` functions, pass in the string "`:memory:`". For example:
    ```c
    rc = sqlite3_open(":memory:", &db);
    ```
    > When this is done, no disk file is opened. Instead, a new database is created purely in memory. The database ceases to exist as soon as the database connection is closed. Every `:memory:` database is distinct from every other. So, opening two database connections each with the filename "`:memory:`" will create two independent in-memory databases.
  * > **Temporary Databases**
- SQLite Shared-Cache Mode https://www.sqlite.org/sharedcache.html

Official Git mirror of the SQLite source tree https://github.com/sqlite/sqlite || SQLite Source Repository https://sqlite.org/src/doc/trunk/README.md

Why SQLite Does Not Use Git https://sqlite.org/whynotgit.html
- > SQLite does not use the Git version control system. SQLite uses Fossil instead, which is a version control system that was specifically designed and written to support SQLite.

# 其他较权威链接

SQLite https://en.wikipedia.org/wiki/SQLite

SQLite https://db-engines.com/en/system/SQLite

SQLite权威指南 (The Definitive Guide to SQLite) https://wizardforcel.gitbooks.io/the-definitive-guide-to-sqlite/content/index.html
- 第1章 SQLite介绍
  * > **可靠性**
    + > SQLite的源代码不但免费，还编写得很好。SQLite源代码包含大约30000行标准C代码，它是干净的、模块化的和完好注释的。SQLite源代码易理解、易定制。
    + > SQLite的核心软件(库和工具)由约30000行代码组成，但分发的程序中还包含有超过30000行的回归测试代码，它们覆盖了97%的核心代码。也就是说，超过一半的SQLite项目代码是专门用于回归测试的，也就是说，差不多每写一行功能代码，都要写一行测试代码对它进行测试。
  * > **性能和限制**
    + > SQLite是一个快速数据库。但“快速”这个词本身是一个主观的和不明确的词。诚实地讲，有些事情SQLite能比其它数据库做得快，也有些事情不能。这么说吧，利用SQLite提供的配置参数，SQLite是足够快速和高效的。跟大多数其它数据库一样，SQLite使用B-tree处理索引，使用B+tree处理表数据。因此，***在对单表进行查询时，SQLite要快于(或至少相当于)其它数据库的速度***。
    + > 在一些情况下SQLite可能不如大型数据库快，但大多数这些情况是可理解的。SQLite是一个内嵌式的数据库，设计用于中小规模的应用程序。这些限制是符合设计目的的。很多新用户错误地假设使用SQLite可以代替大型关系型数据库，这有时行，但有时不行，依赖于你准备用SQLite来做什么。一般情况下，SQLite在三个主要的方面具有局限性：
- 第5章 设计和概念 https://wizardforcel.gitbooks.io/the-definitive-guide-to-sqlite/content/7.html

# SQLite连接池（是否需要都不一定，只是随便记一下）

sqlite需要连接池吗？ https://segmentfault.com/q/1010000040020650/

sqlite连接池的简单实现 https://www.cnblogs.com/ngxianyu/archive/2013/06/08/3126543.html

SQLite/C# Connection Pooling and Prepared Statement Confusion https://stackoverflow.com/questions/10703814/sqlite-c-connection-pooling-and-prepared-statement-confusion

# SQLite新闻

Fedora Linux：计划将 RPM 数据库从 Berkeley DB 迁移到 SQLite https://www.ithome.com/0/478/504.htm
```
祖安卢本伟2020/3/19 9:54:58
…现在就在搞数据库迁移。原来Oracle不支持主键，删掉用来自增的序列和触发器，换成现在的主键自增；还
有前后索引长度限制不同；函数支持不同；字段类型不同；甚至还有优化器导致的性能问题，三个join的语句，
在Oracle神优化器加持下，秒出数据，现在两个小时都不出数据你敢信？基本断定是卡死了。还有那种with as
的树状递归select，也是一样的情况。反正切数据库是个巨坑
```

# 其他文章

SQLite3 实践教程 https://linux.cn/article-13117-1.html
- > SQLite 中有五种数据类型（实际上是 储存类别）：

SQLite页缓冲区管理 https://www.cnblogs.com/amdb/p/4035614.html || https://blog.csdn.net/apple7912/article/details/101962813