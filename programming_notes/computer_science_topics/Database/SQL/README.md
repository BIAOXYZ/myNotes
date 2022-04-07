
# DATE

The Ultimate Guide to PostgreSQL Date By Examples https://www.postgresqltutorial.com/postgresql-date/

# Distinct

SQL - Distinct Keyword https://www.tutorialspoint.com/sql/sql-distinct-keyword.htm

SQL中distinct的用法 https://www.cnblogs.com/rainman/archive/2013/05/03/3058451.html

# Group by

SQL中GROUP BY的用法 https://blog.csdn.net/liitdar/article/details/85272035
- > 从上述查询结果能够看到，***当不使用聚合函数时，`GROUP BY`的结果是分组内容中的第一组查询结果***。当然，在实际使用中，我们通常都需要将聚合函数与GROUP BY用法结合使用，来实现某种目的。

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

# Join

【[:star:][`*`]】 What is the difference between "INNER JOIN" and "OUTER JOIN"? https://stackoverflow.com/questions/38549/what-is-the-difference-between-inner-join-and-outer-join
- https://stackoverflow.com/questions/38549/what-is-the-difference-between-inner-join-and-outer-join/38578#38578

Difference between JOIN and INNER JOIN https://stackoverflow.com/questions/565620/difference-between-join-and-inner-join
- https://stackoverflow.com/questions/565620/difference-between-join-and-inner-join/565733#565733
  * > Similarly with `OUTER JOINs`, ***the word `"OUTER"` is optional***. It's ***the `LEFT` or `RIGHT` keyword*** that ***makes the `JOIN` an `"OUTER" JOIN`***.
    >> 【[:star:][`*`]】 //notes：这句的意思是 `OUTER` 是可省略的，并且 `OUTER` 只会在 `LEFT JOIN` 或 `RIGHT JOIN` 中出现。

LEFT JOIN vs. LEFT OUTER JOIN in SQL Server https://stackoverflow.com/questions/406294/left-join-vs-left-outer-join-in-sql-server

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

# 其他

python写多行sql换行，并传递参数 https://blog.csdn.net/qiudechao1/article/details/89150712
