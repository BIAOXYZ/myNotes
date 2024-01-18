
# SQL标准

Don’t Tell Anyone: The SQL Standard is Public! https://modern-sql.com/standard

The History of SQL Standards https://learnsql.com/blog/history-of-sql-standards/
- > **SQL-86**
  * > The first SQL standard was **SQL-86**. It was published in 1986 as ANSI standard and in 1987 as International Organization for Standardization (ISO) standard. The starting point for the ISO standard was IBM’s SQL standard implementation. This version of the SQL standard is also known as **SQL 1**.
- > **SQL-92**
  * > The next revision of the standard was **SQL-92** – and it was a major revision. The language introduced by SQL-92 is sometimes referred to as **SQL 2**. The standard document grew ***from `120` to `579` pages***. However, much of the growth was due to more precise specifications of existing features.
- > **SQL:1999**
  * > **SQL:1999** (also called **SQL 3**) was the fourth revision of the SQL standard. Starting with this version, the standard name used a colon instead of a hyphen to be consistent with the names of other ISO standards. This standard was published in multiple installments between 1999 and 2002.

# SQL-92

SQL-92 https://en.wikipedia.org/wiki/SQL-92 || https://zh.wikipedia.org/wiki/SQL-92
- > SQL-92是SQL数据库查询语言规范的第三次修订。与SQL-89不同的是，此次修订是SQL数据库查询语言标准的一次改动较大的修订。除了一些小细节不兼容之外，SQL-92可以向前兼容SQL-89标准。与SQL-89相比，SQL-92规范内容增长了大约五倍。

ISO/IEC 9075:1992 Information technology — Database languages — SQL https://www.iso.org/standard/16663.html

International Standard ISO/IEC 9075:1992 https://www.contrib.andrew.cmu.edu/~shadow/sql/sql1992.txt

# SQL-2023

SQL:2023 is finished: Here is what's new http://peter.eisentraut.org/blog/2023/04/04/sql-2023-is-finished-here-is-whats-new

SQL:2023标准正式发布！ https://mp.weixin.qq.com/s/UU60aygMQAsMNirlisSqqA

世界知名专家 Andy Pavlo 教授带你回顾数据库的 2023 年 https://mp.weixin.qq.com/s/0JlQ8ZE0NbxYpVwyPZPVxA || [翻译][数据库年报] Database in 2023: A Year in Review - 八哥福瑞的文章 - 知乎 https://zhuanlan.zhihu.com/p/676514002
- > 01
  * > 有趣的是，与 DBMS 支持 JSON 的速度相比，向量搜索的支持要快上许多。原生存储 JSON 的 NoSQL 系统在 2000 年代末开始流行（例如 MongoDB 和 CouchDB），但过了好几年之后，关系型 DBMS 才添加对 JSON 的支持（例如 PostgreSQL、Oracle 和 MySQL 的支持时间分别是在 2012 年、2014 年和 2015 年）。***SQL 标准在 `SQL:2016` 中引入了对 JSON 数据进行操作的函数，但直到 `SQL:2023` 才正式将 JSON 数据类型添加进来***。鉴于许多关系 DBMS 早已支持概念上类似的 XML 数据类型，这样的滞后的确令人感到意外。
- > 02
  * > 即将到来的 2024 年将是 Don Chamberlain 和 Ray Boyce 在 IBM 研究院发明 SQL 的 50 周年（RIP）。SQL 最初称为 SEQUEL（结构化英语查询语言），自 20 世纪 80 年代以来一直是与数据库交互的标准编程语言。尽管 SQL 历史悠久，但它的用途和功能却不断增加，尤其是在过去十年中。
  * > 去年，ISO/IEC 9075 规范发布了最新版本，即 SQL:2023。该更新包括许多“锦上添花”的功能，可解决各种 SQL 方言（例如 ANY_VALUE）中的不一致问题。这里值得一提的是对 SQL 的两项增强，它们进一步削弱了对替代数据模型和查询语言的需求。但请记住，SQL 规范包含某些内容并不意味着大家常用的关系 DBMS 会立即支持这些新功能。
  * > **01. 属性图查询（Property Graph Queries, SQL/PGQ）**
  * > **02. 多维数组（Multi-Dimensional Arrays, SQL/MDA）**
  * > 尽管 SQL/MDA 规范自 2019 年就已经发布，但直到 SQL:2023 才被纳入官方 SQL 标准。据我所知，除了 Rasdaman 之外，没有任何生产级的 DBMS 支持 SQL/MDA 扩展。我能找到的唯一其他原型是 HSQLDB 的一个分支，名为 ASQLDB。
- > 03
  * > 不过 MariaDB 也不能失败了，因为据我所知，***Monty 已经没有更多孩子来命名数据库了（例如，MaxDB，MySQL，MariaDB）***。
- > 04 政府数据库崩溃，导致美国航空旅行停飞
  * > 2023 年 1 月 11 日，由于 NOTAM 系统中断，美国联邦航空管理局（FAA）停飞了美国境内的所有航班。NOTAM 系统负责向飞行员提供纯文本编码的消息，并警告他们在飞行路径上可能遇到的意外变化或潜在危险。1 月 11 日上午，NOTAM 系统崩溃，导致美国约 11,000 架航班停止起飞。但拥有独立航空通报系统的其他国家未受此次系统故障的影响。
  * > 有消息人士称，NOTAM 系统每秒只能处理 20 条消息。以现代标准来看，这无疑少得可怜，但请记住，该系统是在 20 世纪 80 年代部署的。***数据库传奇人物、1998 年图灵奖获得者 Jim Gray 在 1985 年撰写了一篇文章，介绍了“普通”DBMS 如何每秒执行约 50 个事务，而非常高端的 DBMS 每秒甚至可以处理 200 个事务***。作为参考，五年前，有人使用 20 世纪 80 年代的基准（***即基于 `TPC-A` 的 `TPC-B`***）在 Raspberry Pi 3 上运行 PostgreSQL，实现了大约每秒 200 个事务 。***忽略跨数据中心使用强一致性复制的系统（限制其性能的瓶颈只有光速），现代单节点 OLTP DBMS 对于某些工作负载可以实现每秒数百万个事务的吞吐量***。总的来说，NOTAM 每秒 20 条消息的峰值吞吐量并没有达到 20 世纪 80 年代的最先进水平，放在今天更是落后得吓人。
