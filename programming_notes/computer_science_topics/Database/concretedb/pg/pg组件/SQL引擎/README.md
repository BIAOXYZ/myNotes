
# 优化器

PostgreSQL 查询优化器的一些工作原理 https://www.modb.pro/db/164780 || POSTGRESQL查询优化器如何工作 https://www.modb.pro/db/48488

PostgreSQL查询优化器详解（逻辑优化篇） https://dbaplus.cn/news-155-2060-1.html
- > 注：本故事后续请看DBAplus社群同天发布的第二篇文章《PostgreSQL查询优化器详解（物理优化篇）》。

PostgreSQL查询优化器详解（物理优化篇） https://dbaplus.cn/news-155-2061-1.html

PgSQL · 最佳实践 · EXPLAIN 使用浅析（优化器，查询计划） https://www.cnblogs.com/xueqiuqiu/articles/10999863.html

## 系列文章

PostgreSQL 优化器入门 https://blog.csdn.net/shujiezhang/category_10400711.html

PostgreSQL 优化器入门_专栏 - GitChat https://gitbook.cn/gitchat/column/5bbee9ed2409541174645a2d

## 优化器源码

PostgreSQL 优化器代码概览 - 阿里云云栖号的文章 - 知乎 https://zhuanlan.zhihu.com/p/56702915 || https://developer.aliyun.com/article/689615

PgSQL · 源码分析 · PG优化器物理查询优化 https://developer.aliyun.com/article/71982

PostgreSQL 优化器的初步分析：query_planner() https://github.com/davidzwb/davidzwb.github.io/blob/c3c6a600ffc80e2afc318c9cd3eb77b8e974e1b5/_posts/postgresql/2016-11-28-PostgreSQL%20%E4%BC%98%E5%8C%96%E5%99%A8%E7%9A%84%E5%88%9D%E6%AD%A5%E5%88%86%E6%9E%90%EF%BC%9Aquery_planner().md || https://davidzwb.github.io/postgresql/2016/11/28/PostgreSQL-%E4%BC%98%E5%8C%96%E5%99%A8%E7%9A%84%E5%88%9D%E6%AD%A5%E5%88%86%E6%9E%90-query_planner().html
- > query_planner() 是优化器生成 path 的基础，所以首先从这里开始分析起。
- > query_planner() 负责生成一个基本的 path，这个 path 除了基本的扫描表的操作外，最后最多只包含连接操作，剩下的其他诸如聚合或者 limit 等操作，则会到更外层的 grouping_planner() 中进行。
- > 进入 query_planner() 第一步就是对每个基本表生成 `RelOptInfo` 结构：
  * > `基本表就是 FROM 后指定的一个普通的表，而不是由连接等操作生成的表。 在优化生成 plan 的过程中，RelOptInfo 中包含了对一个表所需的信息；`
- > 接下来还需要介绍 `PlannerInfo` 结构，该结构是整个优化器执行过程中信息存放的地方，所以每个生成的 `RelOptInfo` 都存放在 `PlannerInfo` 中：
