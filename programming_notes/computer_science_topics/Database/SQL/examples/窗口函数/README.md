
# 窗口函数

Window function (SQL) https://en.wikipedia.org/wiki/Window_function_(SQL)
- > In SQL, a `window function` or `analytic function` is a function which ***uses values from one or multiple rows*** to ***return a value for each row***. (This contrasts with an `aggregate function`, which returns a single value for multiple rows.) `Window functions` have an `OVER` clause; any function without an `OVER` clause is not a `window function`, but rather an `aggregate` or `single-row (scalar)` function.
- > As an example, here is a query which uses a window function ***to compare each employee with the average salary of their department*** (example from the PostgreSQL documentation):
  ```sql
  SELECT depname, empno, salary, avg(salary) OVER (PARTITION BY depname) FROM empsalary;
  ```
  > Output:
  ```console
   depname  | empno | salary |          avg          
  ----------+-------+--------+----------------------
  develop   |    11 |   5200 | 5020.0000000000000000
  develop   |     7 |   4200 | 5020.0000000000000000
  develop   |     9 |   4500 | 5020.0000000000000000
  develop   |     8 |   6000 | 5020.0000000000000000
  develop   |    10 |   5200 | 5020.0000000000000000
  personnel |     5 |   3500 | 3700.0000000000000000
  personnel |     2 |   3900 | 3700.0000000000000000
  sales     |     3 |   4800 | 4866.6666666666666667
  sales     |     1 |   5000 | 4866.6666666666666667
  sales     |     4 |   4800 | 4866.6666666666666667
  (10 rows)
  ```
- > The `PARTITION BY` clause groups rows into partitions, and the function ***is applied to each partition separately***. If the `PARTITION BY` clause is omitted (such as if we have an empty `OVER()` clause), ***then the entire result set treated as a single partition***. For this query, the average salary reported would be the average taken over all rows.
- > Window functions ***are evaluated after aggregation*** (after the `GROUP BY` clause and `non-window aggregate functions`, for example).

通俗易懂的学会：SQL窗口函数 - 猴子的文章 - 知乎 https://zhuanlan.zhihu.com/p/92654574

SQL 窗口函数是什么？涨见识了！ https://segmentfault.com/a/1190000040088969
