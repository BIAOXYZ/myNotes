
# DATE

The Ultimate Guide to PostgreSQL Date By Examples https://www.postgresqltutorial.com/postgresql-date/

# Distinct

SQL - Distinct Keyword https://www.tutorialspoint.com/sql/sql-distinct-keyword.htm

SQL中distinct的用法 https://www.cnblogs.com/rainman/archive/2013/05/03/3058451.html

# Group by

SQL中GROUP BY用法示例 https://www.jianshu.com/p/8b135d373df1

Using group by on multiple columns https://stackoverflow.com/questions/2421388/using-group-by-on-multiple-columns

Using Group By and Order By in the Same Query https://www.navicat.com/en/company/aboutus/blog/1708-using-group-by-and-order-by-in-the-same-query
- > **Points to Keep in Mind**
  * > When combining the Group By and Order By clauses, it is important to bear in mind that, in terms of placement within a SELECT statement:
    + > The GROUP BY clause is placed after the WHERE clause.
    + > The GROUP BY clause is placed before the ORDER BY clause.
  * > ***GROUP BY goes before the ORDER BY*** statement because the latter operates on the final result of the query.
- > **Bonus Section: the Having Clause**
  * > You can filter the grouped data further by using the HAVING clause. The HAVING clause ***is similar to the WHERE clause, but operates on groups of rows rather than on individual rows***. To illustrate how the HAVING clause works, we can use it to limit results to those actors who've appeared in more than ten films:

7 Common GROUP BY Errors https://learnsql.com/blog/error-with-group-by/

GROUP BY without aggregate function https://stackoverflow.com/questions/20074562/group-by-without-aggregate-function

Are the columns used in the order / group by clause(s) mandatory in the select clause? https://stackoverflow.com/questions/27976643/are-the-columns-used-in-the-order-group-by-clauses-mandatory-in-the-select-c

# Hint

What are "SQL-Hints"? https://stackoverflow.com/questions/262004/what-are-sql-hints

# Join

An overview of SQL Join types with examples https://blog.quest.com/an-overview-of-sql-join-types-with-examples/

【[:star:][`*`]】 What is the difference between "INNER JOIN" and "OUTER JOIN"? https://stackoverflow.com/questions/38549/what-is-the-difference-between-inner-join-and-outer-join
- https://stackoverflow.com/questions/38549/what-is-the-difference-between-inner-join-and-outer-join/38578#38578

Difference between JOIN and INNER JOIN https://stackoverflow.com/questions/565620/difference-between-join-and-inner-join
- https://stackoverflow.com/questions/565620/difference-between-join-and-inner-join/565733#565733
  * > Similarly with `OUTER JOINs`, ***the word `"OUTER"` is optional***. It's ***the `LEFT` or `RIGHT` keyword*** that ***makes the `JOIN` an `"OUTER" JOIN`***.
    >> 【[:star:][`*`]】 //notes：这句的意思是 `OUTER` 是可省略的，并且 `OUTER` 只会在 `LEFT JOIN` 或 `RIGHT JOIN` 中出现。

LEFT JOIN vs. LEFT OUTER JOIN in SQL Server https://stackoverflow.com/questions/406294/left-join-vs-left-outer-join-in-sql-server

## non-ANSI JOIN syntax v.s. ANSI JOIN syntax

Will ANSI JOIN vs. non-ANSI JOIN queries perform differently? https://stackoverflow.com/questions/1599050/will-ansi-join-vs-non-ansi-join-queries-perform-differently

Why select from multiple tables without join https://stackoverflow.com/questions/17618007/why-select-from-multiple-tables-without-join

Why isn't SQL ANSI-92 standard better adopted over ANSI-89? https://stackoverflow.com/questions/334201/why-isnt-sql-ansi-92-standard-better-adopted-over-ansi-89

## join顺序相关

Are left outer joins associative? https://stackoverflow.com/questions/20022196/are-left-outer-joins-associative

# Limit

SQL LIMIT https://www.sqltutorial.org/sql-limit/
- > The `OFFSET` clause is optional. If you omit it, the query will return the "row_count" rows from the first row returned by the `SELECT` clause.

"LIMIT 5,10" returns 9 rows in MySQL? https://stackoverflow.com/questions/11963177/limit-5-10-returns-9-rows-in-mysql

# Order by

MySQL中ORDER BY与LIMIT一起使用（有坑） https://www.cnblogs.com/cjsblog/p/10874938.html

What can an aggregate function do in the ORDER BY clause? https://stackoverflow.com/questions/13099282/what-can-an-aggregate-function-do-in-the-order-by-clause

## ASC、DESC

MySQL数据排序asc、desc https://blog.csdn.net/qq_37923253/article/details/79688313

# With

WITH common_table_expression (Transact-SQL) https://docs.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql?view=sql-server-ver15

SQL With As 用法 https://www.cnblogs.com/linyijia/p/11238992.html

# 其他关键词或函数

PostgreSQL SUM Function https://www.postgresqltutorial.com/postgresql-sum-function/

MySQL ifnull()函数 https://www.yiibai.com/mysql/ifnull.html

## 聚合函数无法嵌套，只能通过子查询、CTE等来达到类似的功能

How to Combine Two Aggregate Functions in SQL https://learnsql.com/blog/two-aggregate-functions-sql/
- > **Real Solution 2: CTE**
  * > ***Unlike nesting the subquery, using the CTE allows you to use the aggregate functions in the logical order***: first SUM(), then AVG(). The ‘inner’ function is used in the CTE, while the second SELECT statement is for the ‘outer’ aggregate function.

# 其他

python写多行sql换行，并传递参数 https://blog.csdn.net/qiudechao1/article/details/89150712

## 执行计划缓存

执行计划缓存 https://docs.pingcap.com/zh/tidb/v5.4/sql-prepared-plan-cache
- > TiDB 支持对 `Prepare` / `Execute` 请求的执行计划缓存。其中包括以下两种形式的预处理语句：
- > 当开启执行计划缓存后，每条 Prepare 语句的第一次 Execute 会检查当前查询是否可以使用执行计划缓存，如果可以则将生成的执行计划放进一个由 LRU 链表构成的缓存中；在后续的 Execute 中，会先从缓存中获取执行计划，并检查是否可用，如果获取和检查成功则跳过生成执行计划这一步，否则重新生成执行计划并放入缓存中。
- > LRU 链表是设计成 session 级别的缓存，因为 Prepare / Execute 不能跨 session 执行。LRU 链表的每个元素是一个 key-value 对，value 是执行计划，key 由如下几部分组成：
  * > 执行 Execute 时所在数据库的名字；
  * > Prepare 语句的标识符，即紧跟在 PREPARE 关键字后的名字；
  * > 当前的 schema 版本，每条执行成功的 DDL 语句会修改 schema 版本；
  * > 执行 Execute 时的 SQL Mode；
  * > 当前设置的时区，即系统变量 time_zone 的值；
  * > 系统变量 sql_select_limit 的值；
- > key 中任何一项变动（如切换数据库，重命名 `Prepare` 语句，执行 DDL，或修改 SQL Mode / time_zone 的值），或 LRU 淘汰机制触发都会导致 Execute 时无法命中执行计划缓存。
- > 成功从缓存中获取到执行计划后，TiDB 会先检查执行计划是否依然合法，如果当前 Execute 在显式事务里执行，并且引用的表在事务前序语句中被修改，而缓存的执行计划对该表访问不包含 UnionScan 算子，则它不能被执行。
- > 在通过合法性检测后，会根据当前最新参数值，对执行计划的扫描范围做相应调整，再用它执行获取数据。

谈一谈SQL Server中的执行计划缓存（上） https://www.cnblogs.com/CareySon/archive/2013/05/04/plancacheinsqlserver.html

MySQL · 特性分析 · 执行计划缓存设计与实现 http://mysql.taobao.org/monthly/2016/09/04/ || https://developer.aliyun.com/article/71928

执行计划缓存 - 晓彬SQL的文章 - 知乎 https://zhuanlan.zhihu.com/p/360390117
- > 计划缓存是一个典型的 Key-Value 结构，Key 就是参数化后的 SQL 字符串，Value 就是该条 SQL 所对应的执行计划。在 OceanBase 数据库的计划缓存中，SQL 的执行计划可以分为本地计划、远程计划和分布式计划三种类型。在计划缓存中，同一条 SQL 根据其需要访问的数据不同，可能同时具有三种执行计划。
