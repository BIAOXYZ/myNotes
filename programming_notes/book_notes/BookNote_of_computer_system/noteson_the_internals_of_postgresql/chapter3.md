
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

> The root of a query tree is the [Query]() structure defined in [parsenodes.h](https://doxygen.postgresql.org/parsenodes_8h.html); this structure contains metadata of its corresponding query such as the type of this command (`SELECT`, `INSERT` or others) and several leaves; each leaf forms a list or a tree and holds data of the individual particular clause. || `查询树的根节点是parsenode.h中定义的Query数据结构，这个结构包含着对应查询的元数据，比如命令的类型（SELECT/INSERT等），还包括一些叶子节点，叶子节点由列表或树组成，包含了与特定子句相对应的数据。`

> Figure 3.3 illustrates the query tree of the query shown in Fig. 3.2(a) in the previous subsection.

> Fig. 3.3. An example of a query tree. || `图3.3 查询树`
![](http://www.interdb.jp/pg/img/fig-3-03.png)

> The above query tree is briefly described as follows.
- The ***targetlist*** is a list of columns that are the result of this query. In this example, this list is composed of two columns: ‘id’ and ‘data’. If the input query tree uses `‘∗’` (asterisk), the analyzer/analyser will explicitly replace it to all of the columns. || `targetlist 是查询结果中列的列表。在本例中该列表包含id和data 两列。如果在输入的查询树中使用了*（星号），分析器就会将其显式替换为所有具体的列。`
- The ***range table*** is a list of relations that are used in this query. In this example, this table holds the information of the table ‘tbl_a’ such as the oid of this table and the name of this table. || `范围表rtable是该查询所用到关系的列表。本例中该变量包含了表tbl_a的信息，如该表的表名与oid。`
- The ***join tree*** stores the `FROM clause` and the `WHERE clauses`. || `连接树jointree存储着与FROM和WHERE子句相关的信息。`
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

### 3.1.4. Planner and Executor

## 3.2. Cost Estimation in Single-Table Query

> In PostgreSQL, there are three kinds of costs: start-up, run and total. The total cost is the sum of start-up and run costs; thus, only the start-up and run costs are independently estimated. || "在PostgreSQL中有三种代价，分别是启动代价、运行代价和总代价。总代价是启动代价和运行代价的和，因此只有启动代价和运行代价是单独估计的。"
- > 1.启动代价：在读取到第一条元组前花费的代价，比如索引扫描节点的启动代价就是读取目标表的索引页，获取到第一个元组的代价。
- > 2.运行代价：获取全部元组的代价。

### 3.2.1. Sequential Scan

> 中译版：“注意，这种类型的过滤器只会在读取所有元组的时候使用，它并不会减少需要扫描的表页面数量。” || 英文版："Note that this type of filter is used when reading all the tuples in the table, and it does not narrow the scanned range of table pages."
>> notes：这段中文版翻译的不是很好，意思稍有偏颇——人家英文原文的意思准确说是指`WHERE id < 8000`这个filter在使用的时候是对全表的所有tuple进行过滤（那么执行器肯定所有的tuple都要读）；而不是说“只会在读取所有元组的时候才会使用（这个filter）”。
