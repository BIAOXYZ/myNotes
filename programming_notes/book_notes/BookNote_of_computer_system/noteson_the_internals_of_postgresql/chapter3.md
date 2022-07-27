
版本：
- https://web.archive.org/web/20220713233414/https://www.interdb.jp/pg/pgsql03.html

# [Chapter 3. Query Processing](http://www.interdb.jp/pg/pgsql03.html) || 第3章 查询处理

> 本章包括下列三个部分：
- 第一部分：第3.1节这一部分会简单介绍PostgreSQL中查询处理的流程。
- 第二部分：第3.2～3.4节这一部分会描述获取单表查询上最优执行计划的步骤。第3.2节讨论代价估计的过程，第3.3节描述创建计划树的过程，第3.4节将简要介绍执行器的工作过程。
- 第三部分：第3.5～3.6节这一部分会描述获取多表查询上最优执行计划的步骤。第3.5节介绍了三种连接算法，分别是嵌套循环连接、归并连接和散列连接。第 3.6 节将介绍为多表查询创建计划树的过程。

> PostgreSQL supports three technically interesting and practical features, namely, `Foreign Data Wrappers (FDW)`, `Parallel Query` and `JIT compilation` which is supported ***from version 11***. The first two of them will be described in `Chapter 4`. The JIT compilation is out of scope of this document; see the official document in details. || `PostgreSQL 支持三种技术上很有趣也很实用的功能，分别是外部数据包装（Foreign Data Wrapper，FDW）、并行查询及版本 11.0即将支持的 JIT编译。前两者将在第 4章中描述，JIT编译超出本书的范围，更多内容见官方文档。`

## 3.1. Overview || 3.1 概览

> In PostgreSQL, although the `parallel query` implemented in ***version 9.6*** uses ***multiple background worker processes***, a backend process basically handles all queries issued by the connected client. This backend consists of five subsystems, as shown below: || `尽管PostgreSQL在9.6版本后有了基于多个后台工作进程的并行查询，但大体上来讲，还是每个连接对应一个后端进程。后端进程由以下5个子系统组成：`
1. `Parser`: The parser generates a ***parse tree*** from an SQL statement in plain text. || `1.解析器，根据SQL语句生成一棵语法解析树（parse tree）。`
2. `Analyzer/Analyser`: The analyzer/analyser carries out a semantic analysis of a parse tree and generates a ***query tree***. || `2.分析器，对语法解析树进行语义分析，生成一棵查询树（query tree）。`
3. `Rewriter`: The rewriter transforms a query tree using the rules stored in the rule system if such rules exist. || `3.重写器，按照规则系统中存在的规则对查询树进行改写。`
4. `Planner`: The planner generates the ***plan tree*** that can most effectively be executed from the query tree. || `4.计划器，基于查询树生成一棵执行效率最高的计划树（plan tree）。`
5. `Executor`: The executor executes the query via accessing the tables and indexes in the order that was created by the plan tree. || `5.执行器，按照计划树中的顺序访问表和索引，执行相应查询。`

> Fig. 3.1. Query Processing. || 图3.1是查询处理的大概流程。
![](http://www.interdb.jp/pg/img/fig-3-01.png)

### 3.1.1. Parser || 3.1.1 解析器

> The `parser` generates a `parse tree` that can be read by subsequent subsystems from an SQL statement in plain text. Here a specific example is shown in the following without a detailed description. Let us consider the query shown below. || `解析器基于SQL语句的文本，生成一棵后续子系统可以理解的语法解析树。下面是一个具体的例子。考虑以下查询：`
```sql
testdb=# SELECT id, data FROM tbl_a WHERE id < 300 ORDER BY data;
```

> A `parse tree` is a tree whose root node is the [SelectStmt]() structure defined in [parsenodes.h](https://github.com/postgres/postgres/blob/master/src/include/nodes/parsenodes.h). `Figure 3.2(b)` illustrates the parse tree of the query shown in `Fig. 3.2(a)`. || `语法解析树的根节点是一个定义在parsenodes.h中的SelectStmt数据结构。图3.2（1）展示了一个查询，图3.2（2）则是该查询对应的语法解析树。`
```c
typedef struct SelectStmt
{
        NodeTag         type;

        /*
         * These fields are used only in "leaf" SelectStmts.
         */
        List       *distinctClause;     /* NULL, list of DISTINCT ON exprs, or
                                         * lcons(NIL,NIL) for all (SELECT DISTINCT) */
        IntoClause *intoClause;         /* target for SELECT INTO */
        List       *targetList;         /* the target list (of ResTarget) */
        List       *fromClause;         /* the FROM clause */
        Node       *whereClause;        /* WHERE qualification */
        List       *groupClause;        /* GROUP BY clauses */
        Node       *havingClause;       /* HAVING conditional-expression */
        List       *windowClause;       /* WINDOW window_name AS (...), ... */

        /*
         * In a "leaf" node representing a VALUES list, the above fields are all
         * null, and instead this field is set.  Note that the elements of the
         * sublists are just expressions, without ResTarget decoration. Also note
         * that a list element can be DEFAULT (represented as a SetToDefault
         * node), regardless of the context of the VALUES list. It's up to parse
         * analysis to reject that where not valid.
         */
        List       *valuesLists;        /* untransformed list of expression lists */

        /*
         * These fields are used in both "leaf" SelectStmts and upper-level
         * SelectStmts.
         */
        List       *sortClause;         /* sort clause (a list of SortBy's) */
        Node       *limitOffset;        /* # of result tuples to skip */
        Node       *limitCount;         /* # of result tuples to return */
        List       *lockingClause;      /* FOR UPDATE (list of LockingClause's) */
        WithClause *withClause;         /* WITH clause */

        /*
         * These fields are used only in upper-level SelectStmts.
         */
        SetOperation op;                /* type of set op */
        bool            all;            /* ALL specified? */
        struct SelectStmt *larg;        /* left child */
        struct SelectStmt *rarg;        /* right child */
        /* Eventually add fields for CORRESPONDING spec here */
} SelectStmt;
```

> Fig. 3.2. An example of a parse tree. || `图3.2 语法解析树的例子`
![](http://www.interdb.jp/pg/img/fig-3-02.png)

> The elements of the `SELECT` query and the corresponding elements of the `parse tree` are numbered the same. For example, (1) is ***an item of the first target list*** and it is ***the column ‘id’ of the table***, (4) is a `WHERE clause`, and so on. || `SELECT 查询中的元素和语法解析树中的元素有着对应关系。比如，（1）是目标列表中的一个元素，与目标表的'id'列相对应，（4）是一个WHERE子句，诸如此类。`

> Due to the fact that the parser only checks the syntax of an input when generating a parse tree, it only returns an error if there is a syntax error in the query. The parser does not check the semantics of an input query. For example, even if the query contains a table name that does not exist, the parser does not return an error. Semantic checks are done by the analyzer/analyser. || `当解析器生成语法分析树时只会检查语法，只有当查询中出现语法错误时才会返回错误。解析器并不会检查输入查询的语义，举个例子，如果查询中包含一个不存在的表名，解析器并不会报错，那么语义检查由分析器负责。`

### 3.1.2. Analyzer/Analyser || 3.1.2 分析器

> The `analyzer/analyser` runs a semantic analysis of a `parse tree` generated by the parser and generates a `query tree`. || `分析器对解析器产出的语法解析树进行语义分析，并产出一棵查询树。`

> The root of a `query tree` is the [Query](https://doxygen.postgresql.org/structQuery.html) structure defined in [parsenodes.h](https://doxygen.postgresql.org/parsenodes_8h.html); this structure contains metadata of its corresponding query such as the type of this command (`SELECT`, `INSERT` or others) and several leaves; each leaf forms a list or a tree and holds data of the individual particular clause. || `查询树的根节点是parsenode.h中定义的Query数据结构，这个结构包含着对应查询的元数据，比如命令的类型（SELECT/INSERT等），还包括一些叶子节点，叶子节点由列表或树组成，包含了与特定子句相对应的数据。`

> Figure 3.3 illustrates the query tree of the query shown in Fig. 3.2(a) in the previous subsection.

> Fig. 3.3. An example of a query tree. || `图3.3 查询树`
![](http://www.interdb.jp/pg/img/fig-3-03.png)

> The above query tree is briefly described as follows.
- The ***targetlist*** is a list of columns that are the result of this query. In this example, this list is composed of two columns: ‘id’ and ‘data’. If the input query tree uses `‘∗’` (asterisk), the analyzer/analyser will explicitly replace it to all of the columns. || `targetlist 是查询结果中列的列表。在本例中该列表包含id和data 两列。如果在输入的查询树中使用了*（星号），分析器就会将其显式替换为所有具体的列。`
- The ***range table*** is a list of relations that are used in this query. In this example, this table holds the information of the table ‘tbl_a’ such as the oid of this table and the name of this table. || `范围表rtable是该查询所用到关系的列表。本例中该变量包含了表tbl_a的信息，如该表的表名与oid。`
- The ***join tree*** stores the `FROM clause` and the `WHERE clauses`. || `连接树join tree存储着与FROM和WHERE子句相关的信息。`
- The ***sort clause*** is a list of `SortGroupClause`. || `排序子句sortClause是SortGroupClause结构体的列表。`

### 3.1.3. Rewriter || 3.1.3 重写器

> The `rewriter` is the system that realizes the [rule system](https://www.postgresql.org/docs/current/rules.html), and transforms a `query tree` according to the rules stored in the [`pg_rules`](https://www.postgresql.org/docs/current/view-pg-rules.html) system catalog if necessary. The rule system is an interesting system in itself, however, the descriptions of the rule system and the rewriter have been omitted to prevent this chapter from becoming too long. || `PostgreSQL的规则系统正是基于重写器实现的。当需要时，重写器会根据存储在pg_rules中的规则对查询树进行转换。规则系统本身也是一个很有趣的系统，不过本章略去了关于规则系统和重写器的描述，以免内容过于冗长。`

> `Views` in PostgreSQL are implemented by using the rule system. When a view is defined by the `CREATE VIEW` command, ***the corresponding rule is automatically generated and stored in the catalog***. || `在PostgreSQL中，视图是基于规则系统实现的。当使用CREATE VIEW命令定义一个视图时，PostgreSQL就会创建相应的规则，并存储到系统目录中。`

> Assume that the following `view` is already defined and `the corresponding rule` is stored in the `pg_rules` system catalog. || `假设下面的视图已经被定义，而pg_rule中也存储了相应的规则。`
```sql
sampledb=# CREATE VIEW employees_list 
sampledb-#      AS SELECT e.id, e.name, d.name AS department 
sampledb-#            FROM employees AS e, departments AS d WHERE e.department_id = d.id;
```
> When a query that contains a view shown below is issued, the `parser` creates the `parse tree` as shown in `Fig. 3.4(a)`. || `当执行一个包含该视图的查询时，解析器会创建一棵语法解析树。`
```sql
sampledb=# SELECT * FROM employees_list;
```
> At this stage, the `rewriter` processes the `range table node` to a `parse tree` of the `subquery`, which is the corresponding `view`, stored in `pg_rules`. || `在该阶段，重写器会基于pg_rule中存储的视图规则将range table节点重写为一棵查询子树，与子查询相对应。`

> Fig. 3.4. An example of the rewriter stage. || `图3.4 重写阶段`
![](http://www.interdb.jp/pg/img/fig-3-04.png)

> Since PostgreSQL realizes `views` using such a mechanism, ***views could not be updated until `version 9.2`***. However, ***views can be updated from `version 9.3` onwards***; nonetheless, there are many limitations in updating the view. These details are described in the official document. || `因为PostgreSQL使用这种机制实现视图，所以直到9.2版本，视图都是不能更新的。虽然9.3及更高版本可以对视图进行更新，但对视图的更新仍然存在很多限制，具体细节请参考官方文档。`

### 3.1.4. Planner and Executor || 3.1.4 计划器与执行器

> The `planner` receives a `query tree` from the `rewriter` and generates a `(query) plan tree` that can be processed by the `executor` most effectively. || `计划器从重写器获取一棵查询树，基于查询树生成一棵能被执行器高效执行的（查询）计划树。`

> The planner in PostgreSQL is based on pure `cost-based optimization`; it does **not** support `rule-based optimization` and `hints`. This planner is the most complex subsystem in RDBMS; therefore, an overview of the planner will be provided in the subsequent sections of this chapter. || `在PostgreSQL中，计划器是完全基于代价估计的，它不支持基于规则的优化与提示。计划器是RDBMS中最复杂的部分，因此本章的后续内容会对计划器做一个概述。`

> PostgreSQL does not support the planner hints in SQL, and ***it will not be supported forever***. If you want to use hints in your queries, the extension referred to [pg_hint_plan]() will be worth considering. Refer to the official site in detail. || `PostgreSQL不支持 SQL中的提示（hint），并且永远也不会去支持。如果你想在查询中使用提示，可以考虑使用pg_hint_plan扩展，具体细节请参考官方文档。`

> As in the other RDBMS, the [EXPLAIN](https://www.postgresql.org/docs/current/sql-explain.html) command in PostgreSQL displays the plan tree itself. A specific example is shown below. || `与其他RDBMS类似，PostgreSQL中的EXPLAIN命令会显示命令的计划树。下面给出了一个具体的例子。`
```sql
testdb=# EXPLAIN SELECT * FROM tbl_a WHERE id < 300 ORDER BY data;
                          QUERY PLAN                           
---------------------------------------------------------------
 Sort  (cost=182.34..183.09 rows=300 width=8)
   Sort Key: data
   ->  Seq Scan on tbl_a  (cost=0.00..170.00 rows=300 width=8)
         Filter: (id < 300)
(4 rows)
```

> Fig. 3.5. A simple plan tree and the relationship between the plan tree and the result of the EXPLAIN command. || `图3.5 一棵简单的计划树及其与EXPLAIN命令的关系`
![](http://www.interdb.jp/pg/img/fig-3-05.png)

> A `plan tree` is composed of elements called `plan nodes`, and it is connected to the `plantree list` of the [PlannedStmt]() structure. These elements are defined in [plannodes.h](). Details will be explained in `Section 3.3.3` (and `Section 3.5.4.2`). || `计划树由被许多称为计划节点的元素组成，这些节点挂在PlannedStmt 结构对应的计划树上。这些元素的定义在plannodes.h中，第3.3.3节与第3.5.4.2节会解释相关细节。`

> Each `plan node` has information that the `executor` requires for processing, and the `executor` processes ***`from the end` of the plan tree `to the root` in the case of a `single-table query`***. || `每个计划节点都包含着执行器进行处理所需要的信息，在单表查询的场景中，执行器会按照从终端节点往根节点的顺序依次处理这些节点。`

> For example, the `plan tree` shown in Fig. 3.5 is a list of a `sort node` and a `sequential scan node`; thus, the `executor` scans the table: tbl_a by a `sequential scan` and then sorts the obtained result. || `比如图 3.5 中的计划树就是一个列表，包含一个排序节点和一个顺序扫描节点，因而执行器会首先对表tbl_a执行顺序扫描，并对获取的结果进行排序。`

> The `executor` reads and writes tables and indexes in the database cluster via the `buffer manager` described in `Chapter 8`. When processing a query, the executor uses some memory areas, such as `temp_buffers` and `work_mem`, allocated in advance and creates temporary files if necessary. || `执行器会通过将在第 8章介绍的缓冲区管理器来访问数据库集簇的表和索引。当处理一个查询时，执行器会使用预先分配的内存空间，比如temp_buffers和work_mem，必要时还会创建临时文件。`

> Fig. 3.6. The relationship among the executor, buffer manager and temporary files. || `图3.6 执行器、缓冲管理器和临时文件之间的关系`
![](http://www.interdb.jp/pg/img/fig-3-06.png)

> In addition, when accessing tuples, PostgreSQL uses the ***concurrency control mechanism*** to maintain `consistency` and `isolation` of the running transactions. The concurrency control mechanism is described in `Chapter 5`. || `除此之外，当访问元组的时候，PostgreSQL还会使用并发控制机制来维护运行中事务的一致性和隔离性。第5章将介绍并发控制机制。`

## 3.2. Cost Estimation in Single-Table Query || 3.2 单表查询的代价估计

> PostgreSQL's ***query optimization*** is based on cost. Costs are dimensionless values, and these are not absolute performance indicators but are indicators to compare the relative performance of operations. || `PostgreSQL的查询优化是基于代价的。代价是一个无量纲的值，它不是一种绝对的性能指标，但可以作为比较各种操作代价时的相对性能指标。`

> Costs are estimated by the functions defined in [costsize.c](https://github.com/postgres/postgres/blob/master/src/backend/optimizer/path/costsize.c). All of operations executed by the `executor` have the corresponding `cost functions`. For example, the costs of `sequential scans` and `index scans` are estimated by `cost_seqscan()` and `cost_index()`, respectively. || `costsize.c 中的函数用于估算各种操作的代价。所有被执行器执行的操作都有着相应的代价函数。例如，函数cost_seqscan()和 cost_index()分别用于估算顺序扫描和索引扫描的代价。`

> In PostgreSQL, there are three kinds of costs: **start-up**, **run** and **total**. The ***total cost is the sum of start-up and run costs***; thus, only the **start-up** and **run** costs are independently estimated. || `在PostgreSQL中有三种代价，分别是启动代价、运行代价和总代价。总代价是启动代价和运行代价的和，因此只有启动代价和运行代价是单独估计的。`
- The **start-up** cost is the cost expended before the first tuple is fetched. For example, the start-up cost of the index scan node is the cost to read index pages to access the first tuple in the target table. || `启动代价：在读取到第一条元组前花费的代价，比如索引扫描节点的启动代价就是读取目标表的索引页，获取到第一个元组的代价。`
- The **run** cost is the cost to fetch all tuples. || `运行代价：获取全部元组的代价。`
- The **total** cost is the sum of the costs of both start-up and run costs. || `总代价：前两者之和。`

> The [`EXPLAIN`](https://www.postgresql.org/docs/current/sql-explain.html) command shows both of ***start-up*** and ***total*** costs in each operation. The simplest example is shown below: || `EXPLAIN命令显示了每个操作的启动代价和总代价，下面是一个简单的例子：`
```sql
testdb=# EXPLAIN SELECT * FROM tbl;
                       QUERY PLAN                        
---------------------------------------------------------
 Seq Scan on tbl  (cost=0.00..145.00 rows=10000 width=8)
(1 row)
```
>> 【[:star:][`*`]】 //notes：所以注意了，explain里的cost指的是`start-up cost`和`total cost`。用后者减去前者，才是运行代价（`run cost`）。

> In Line 4, the command shows information about the `sequential scan`. In the cost section, there are two values: ***0.00*** and ***145.00***. In this case, the `start-up` and `total` costs are 0.00 and 145.00, respectively. || `第4行显示了顺序扫描的相关信息。代价部分包含了0.00和145.00两个值。在本例中，启动代价和总代价分别为0.00和145.00。`

> In this section, we explore how to estimate the `sequential scan`, `index scan` and `sort` operation in detail. || `在本节中，我们将详细介绍顺序扫描，索引扫描和排序操作的代价是如何估算的。`

> In the following explanations, we use a specific table and an index that are shown below: || `在接下来的内容中，我们使用下面这个表及其索引作为例子。`
```sql
testdb=# CREATE TABLE tbl (id int PRIMARY KEY, data int);
testdb=# CREATE INDEX tbl_data_idx ON tbl (data);
testdb=# INSERT INTO tbl SELECT generate_series(1,10000),generate_series(1,10000);
testdb=# ANALYZE;
testdb=# \d tbl
      Table "public.tbl"
 Column |  Type   | Modifiers 
--------+---------+-----------
 id     | integer | not null
 data   | integer | 
Indexes:
    "tbl_pkey" PRIMARY KEY, btree (id)
    "tbl_data_idx" btree (data)
```

### 3.2.1. Sequential Scan || 3.2.1 顺序扫描

> The cost of the `sequential scan` is estimated by the `cost_seqscan()` function. In this subsection, we explore how to estimate the sequential scan cost of the following query. || `顺序扫描的代价是通过函数cost_seqscan()估计的。本节将研究顺序扫描代价是如何估计的，以下面的查询为例：`
```sql
testdb=# SELECT * FROM tbl WHERE id < 8000;
```

> In the `sequential scan`, the ***start-up cost*** is equal to ***0***, and the ***run cost*** is defined by the following equation: || `在顺序扫描中，启动代价等于0，而运行代价由以下公式定义：`
```console
‘run cost’ = ‘cpu run cost’ + ‘disk run cost’
           = (cpu_tuple_cost + cpu_operator_cost) × N_tuple + seq_page_cost × N_page
```
> where [seq_page_cost](), [cpu_tuple_cost]() and [cpu_operator_cost]() are set in the `postgresql.conf` file, and ***the default values are `1.0`, `0.01`, and `0.0025`***, respectively; `N_tuple` and `N_page` are the numbers of all tuples and all pages of this table, respectively, and these numbers can be shown using the following query: || `其中seq_page_cost、cpu_tuple_cost和cpu_operator_cost是在postgresql.conf中配置的参数，默认值分别为1.0、0.01和0.0025。Ntuple和Npage分别是表中的元组总数与页面总数，这两个值可以使用以下查询获取：`
```sql
testdb=# SELECT relpages, reltuples FROM pg_class WHERE relname = 'tbl';
 relpages | reltuples 
----------+-----------
       45 |     10000
(1 row)
```
```console
    N_tuple = 10000
    N_page  = 45

Thus,
    ‘run cost’ = (0.01 + 0.0025) × 10000 + 1.0 × 45 = 170.0

Finally,
    ‘total cost’ = 0.0 + 170.0 = 170.0
```
> For confirmation, the result of the `EXPLAIN` command of the above query is shown below: || `作为验证，下面是该查询的EXPLAIN结果：`
```sql
testdb=# EXPLAIN SELECT * FROM tbl WHERE id < 8000;
                       QUERY PLAN                       
--------------------------------------------------------
 Seq Scan on tbl  (cost=0.00..170.00 rows=8000 width=8)
   Filter: (id < 8000)
(2 rows)
```

> In Line 4, we can find that ***the `start-up` and `total` costs are `0.00` and `170.00`***, respectively, and it is estimated that `8000` rows (tuples) will be selected by scanning all rows. || `在第4行中可以看到，启动代价和总代价分别是 0.00和170.0，且预计全表扫描返回行数为8000条（元组）。`

> In Line 5, a filter ‘`Filter:(id < 8000)`’ of the sequential scan is shown. More precisely, it is called a `table level filter predicate`. Note that this type of filter is used when reading all the tuples in the table, and it does not narrow the scanned range of table pages. || `第5行显示了一个顺序扫描的过滤器Filter:(id < 8000)。更精确地说，它是一个表级过滤谓词。注意，这种类型的过滤器只会在读取所有元组的时候使用，它并不会减少需要扫描的表页面数量。`

>> 【[:star:][`*`]】 //notes：看一下上面那段的翻译——“注意，这种类型的过滤器只会在读取所有元组的时候使用，它并不会减少需要扫描的表页面数量。” || 英文原版："Note that this type of filter is used when reading all the tuples in the table, and it does not narrow the scanned range of table pages."
>>> 这段中文版翻译的不是很好，意思稍有偏颇——人家英文原文的意思准确说是指`WHERE id < 8000`这个filter在使用的时候是对全表的所有tuple进行过滤（那么执行器肯定所有的tuple都要读）；而不是说“只会在读取所有元组的时候才会使用（这个filter）”。

> As understood from the run-cost estimation, PostgreSQL assumes that all pages will be read from storages; that is, PostgreSQL does not consider whether the scanned page is in the shared buffers or not. || `从优化运行代价的角度来看，PostgreSQL假设所有的物理页都是从存储介质中获取的，即PostgreSQL不会考虑扫描的页面是否来自共享缓冲区。`

### 3.2.2. Index Scan || 3.2.2 索引扫描

> Although PostgreSQL supports [some index methods](https://www.postgresql.org/docs/current/indexes-types.html), such as `BTree`, [`GiST`](https://www.postgresql.org/docs/current/gist.html), [`GIN`](https://www.postgresql.org/docs/current/gin.html) and [`BRIN`](https://www.postgresql.org/docs/current/brin.html), the cost of the index scan is estimated using the ***common*** cost function: `cost_index()`. || `尽管PostgreSQL支持很多索引方法，比如B树、GiST、GIN和BRIN，但是索引扫描的代价估计是使用一个共用的代价函数：cost_index()。`

> In this subsection, we explore how to estimate the index scan cost of the following query: || `本节将研究索引扫描的代价是如何估计的，以下列查询为例。`
```sql
testdb=# SELECT id, data FROM tbl WHERE data < 240;
```
