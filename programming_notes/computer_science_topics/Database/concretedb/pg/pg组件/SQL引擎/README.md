
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
- > 进入 `query_planner()` 第一步就是对每个基本表生成 `RelOptInfo` 结构：
  * > `基本表就是 FROM 后指定的一个普通的表，而不是由连接等操作生成的表。 在优化生成 plan 的过程中，RelOptInfo 中包含了对一个表所需的信息；`
- > 接下来还需要介绍 `PlannerInfo` 结构，该结构是整个优化器执行过程中信息存放的地方，所以每个生成的 `RelOptInfo` 都存放在 `PlannerInfo` 中：
- > 先通过下面语句为每个要创建 `RelOptInfo` 的基本表申请空间：
- > 一个 `RelOptInfo` 对应一个 `RangeTableEntry`，而这些 RTE 为了避免干扰，是从 Query 中的 jointree 中取出的。
- > 然后在 `add_base_rels_to_query()` 中初始化每个 `RelOptInfo`：
  ```c
  add_base_rels_to_query(root, (Node *) parse->jointree);
  ```
  > 从 Query.jointree 中而不是从 Query.rtable 中取出 RTE 可以仅取到不包含 Join 的基本表；
- > 对于每个基本表进行下列操作：
- > 接下来会对 Query 中的 Jointree 进行处理，Jointree 代表一个 SQL 语句中的 From/Where/Join/On 部分。
- > 该部分的语句可能是连接操作，也可能是一些对表的限制条件(如：attr>2)，所以在这里需要作一个区分的处理：
  ```c
  deconstruct_jointree() -> deconstruct_recurse() 中：
  ```
  * > 如果是针对某个表的限制条件，则调用 `distribute_qual_to_rels()` 将该限制条件下推到该表的 `RelOptInfo->baserestrictinfo` 中去；
  * > 如果是对一些表的连接操作，则先同样调用 `distribute_qual_to_rels()` 将连接的条件下推到该表的 `RelOptInfo->joininfo` 中去。同时，构造一个 `RangeTblRef *` 类型的链表，记录需要在一起连接的基本表。
- > `deconstruct_jointree()` 调用完成后，会返回一个上述的连接链表，同时针对每个基本表的扫描或连接限制条件，都存入了各自的 `RelOptInfo` 的 `baserestrictinfo/joininfo` 中，如下：
  ```c
  joinlist = deconstruct_jointree(root);
  ```
- > 然后就可以利用所获取的信息，进行 Join 的构造了：
  ```c
  /*
   * Ready to do the primary planning.
   */
   final_rel = make_one_rel(root, joinlist);
  ```
- > 在 `make_one_rel()` 中：
    ```c
	/*
	 * Compute size estimates and consider_parallel flags for each base rel,
	 * then generate access paths.
	 */
	set_base_rel_sizes(root); //估算该基本表的行数和宽度
	set_base_rel_pathlists(root); //生成该基本表的 path
    ```
- > 进入后，会根据基本表类型的不同，调用不同的函数处理，对于外部表，就是根据之前 `RelOptInfo` 中初始化的 fdwroutine 调用 fdw 部分的代码的，如下：
  ```c
  rel->fdwroutine->GetForeignRelSize(root, rel, rte->relid);
  以及
  rel->fdwroutine->GetForeignPaths(root, rel, rte->relid);
  ```
- > 针对每个基本表生成 path 后，利用已经生成的 `joinlist` 构造一个 `RELOPT_JOINREL` 类型的 `RelOptInfo` 以及对应的 path，最后返回这个 Join 的 `RelOptInfo`。
  ```c
  /*
  	 * Generate access paths for the entire join tree.
  	 */
  	rel = make_rel_from_joinlist(root, joinlist);
  ```
- > 实例：
