
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

Clickhouse 分析函数 window functions 窗口函数 https://blog.csdn.net/vkingnew/article/details/106781788

SQL 窗口函数的优化和执行 - Eric Fu的文章 - 知乎 https://zhuanlan.zhihu.com/p/80051518 || https://juejin.cn/post/6969371973717590052

【[:star:][`*`]】 Task05：SQL高级处理.md https://github.com/datawhalechina/team-learning-sql/blob/main/Task05%EF%BC%9ASQL%E9%AB%98%E7%BA%A7%E5%A4%84%E7%90%86.md
- > **5.1.1 窗口函数概念及基本的使用方法**
  * > 常规的 `SELECT` 语句都是对整张表进行查询，***而窗口函数可以让我们有选择的去某一部分数据进行汇总、计算和排序***。窗口函数的通用形式：
    ```sql
    <窗口函数> OVER ([PARTITION BY <列名>]
                         ORDER BY <排序用列名>)  
    ```
    > *[]中的内容可以省略。
  * > 窗口函数最关键的是搞明白关键字 **`PARTITON BY`** 和 **`ORDER BY`** 的作用。
  * > **`PARTITON BY`** 是用来分组，***<ins>即选择要看哪个窗口</ins>，类似于 `GROUP BY` 子句的分组功能，但是 `PARTITION BY` 子句<ins>并不具备 `GROUP BY` 子句的汇总功能</ins>，<ins>并不会改变原始表中记录的行数</ins>***。
  * > **`ORDER BY`** 是用来排序，即决定窗口内，是按那种规则(字段)来排序的。
  * > 举个栗子:
    ```sql
    SELECT product_name
           ,product_type
           ,sale_price
           ,RANK() OVER (PARTITION BY product_type
                             ORDER BY sale_price) AS ranking
      FROM product  
    ```
  * > 得到的结果是: <br> ![](https://github.com/datawhalechina/team-learning-sql/blob/main/img/ch05/ch0501.png)
  * > 我们先忽略生成的新列 - [ranking]， 看下原始数据在 `PARTITION BY` 和 `ORDER BY` 关键字的作用下发生了什么变化。
  * > `PARTITION BY` 能够设定窗口对象范围。本例中，为了按照商品种类进行排序，我们指定了 product_type。即一个商品种类就是一个小的"窗口"。
  * > `ORDER BY` 能够指定按照哪一列、何种顺序进行排序。为了按照销售单价的升序进行排列，我们指定了sale_price。此外，窗口函数中的 `ORDER BY` 与 `SELECT` 语句末尾的 `ORDER BY` 一样，可以通过关键字 `ASC/DESC` 来指定升序/降序。省略该关键字时会默认按照ASC，也就是升序进行排序。本例中就省略了上述关键字 。 <br> ![](https://github.com/datawhalechina/team-learning-sql/blob/main/img/ch05/ch0502.png)

# 个人实战1

需求来源：某一个单列表（只有一列，列名就叫 `id`），里面如果元素出现次数大于1，就返回其频率减一的行数；如果等于1就忽略掉（比如，表里是 `{a, a, b, c, d, a, c}`，查询结果为 `{a, a, c}` —— `a` 出现三次，结果里剩两次；`c` 出现两次，结果里剩一次；其他元素只出现了一次，结果里就不出现）。最终是在 SQLite 里用 window function + 子查询解决了。核心思想是用窗口函数编号后，把行号等于1的舍弃掉。
```sql
sqlite> .schema t3
CREATE TABLE t3 (id int);
sqlite> select * from t3;
1
2
3
4
5
6
7
8
9
10
2
3
3
sqlite> select id from (select id, row_number() over (partition by id) as row_num from t3) as sub where sub.row_num != 1;
2
3
3
sqlite> 
```
