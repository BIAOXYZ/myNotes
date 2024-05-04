
# 1

Hive SQL 教程 https://gairuo.com/p/hive-sql-tutorial
- SQL 高级操作
  * Hive SQL 查询样本 TABLESAMPLE https://gairuo.com/p/hive-sql-tablesample
- 多表查询
  * WITH AS 临时中间表 https://gairuo.com/p/sql-with-as
- 窗口计算
  * SQL 窗口计算 https://gairuo.com/p/sql-window
  * Hive sql 专用窗口函数 https://gairuo.com/p/hive-sql-windowing-functions
  * SQL 移动窗口 https://gairuo.com/p/sql-moving-window
- Hive SQL 函数介绍
  * Hive SQL 内置聚合函数 https://gairuo.com/p/hive-sql-built-in-aggregate
    + collect_list 和 collect_set 函数 https://gairuo.com/p/hive-sql-collect-list-set
    + ntile 分组切片函数 https://gairuo.com/p/hive-sql-ntile 

SQL 窗口计算 https://gairuo.com/p/sql-window
- > 可以把“窗口”（windows）这个理解一个集合，***一个窗口就是一个集合，在统计分析中有需要不同的「窗口」，比如一个部门分成不同组，在统计时会按组进行平均、排名等操作***。再比如，在一些像时间这种有顺序的数据，我们可能5天分一组、一月分一组再进行排序、求中位数等计算。
- > **与聚合的不同**
  * > 窗口函数会按当前所在的分组进行聚合计算，并将聚合计算结果追加在当前行对应的新列，它表达的是当前行与这所在分组的关系。
  * > ![](https://gairuo.com/file/pic/2021/sql-windows-functions-01.png)
  * > ![](https://gairuo.com/file/pic/2021/sql-windows-functions-00.png)
  * > 窗口函数和 Group By 聚合函数区别在于：***窗口函数仅仅只会将结果附加到当前的结果上，它不会对已有的行或列做任何修改***。而 Group By 的做法完全不同：***对于各个 Group 它仅仅会保留一行聚合结果***。
- > **窗口计算语法**
  * > 窗口函数（Windowing functions）基本语法：
    ```sql
    xxx() over(PARTITION by yyy ORDER by zzz)
    ```
  * > 其中：
    ```console
    xxx 为函数名
    OVER() 括号中的内容这窗口内容
    PARTITION by 后的为分组的字段，划分的范围被称为窗口
    ORDER by 后决定着窗口范围内数据的排序方式
    ```
- > **基础用法**
  * > 如果 `over` 不提供分组方法，则将所有数据分为一组，如下取所有数据的计数：
    ```sql
    SELECT
    	id,
    	avg(chinese) over()
    FROM
    	students
    '''
    id|avg(chinese) over()|
    --|-------------------|
     1|  79.33333333333333|
     2|  79.33333333333333|
     3|  79.33333333333333|
     4|  79.33333333333333|
     5|  79.33333333333333|
     6|  79.33333333333333|
     7|  79.33333333333333|
     8|  79.33333333333333|
     9|  79.33333333333333|
    '''
    ```
    > 以上将所有学生的语文成绩进行了平均计算，然后显示在每行数据后边。
- > **`partition by` 子句**
  * > 如果我们按班级对语文求平均数呢？这就要使用 partition by 语句，***`partition by` 的作用和 `group by` 是类似，用于分组，在 `over()` 中使用***。
    ```sql
    SELECT
    	id,
    	avg(chinese) over(PARTITION by class) as avg_class
    FROM
    	students
    '''
    id|avg_class|
    --|---------|
     1|     82.5|
     3|     82.5|
     6|     82.5|
     8|     82.5|
     2|     84.0|
     4|     84.0|
     7|     84.0|
     5|     66.0|
     9|     66.0|
    '''
    ```
    > 就是按班级分组，计算出每班的平均语文成绩，最后显示在对应同学的后边。avg_class 列的意义为当前行同学 ID 所在班的语文平均成绩。
- > **`order by` 子句**
  * > ***在每个窗口（分组）内***，如果我们想按每个人的语文成绩排序，可以使用 `order by` 子句，这里我们用 `RANK()` 指定序号，同样的分数是相同的序号：
    ```sql
    SELECT
    	id,
    	class,
    	chinese,
    	RANK() over(PARTITION by class ORDER by chinese DESC) as odr
    FROM
    	students
    '''
    id|class|chinese|odr|
    --|-----|-------|---|
     6|    1|     99|  1|
     8|    1|     99|  1|
     1|    1|     77|  3|
     3|    1|     55|  4|
     2|    2|     99|  1|
     4|    2|     87|  2|
     7|    2|     66|  3|
     5|    3|     66|  1|
     9|    3|     66|  1|
    '''
    ```
  * > ***当 `order by` 与聚合函数一起使用时，会形成<ins>顺序聚合</ins>***，如 sum 聚合与 order by 结合使用时，就实现类似于累计和的效果：
    ```sql
    SELECT
    	id,
    	class,
    	sum(id) over(PARTITION by class ORDER by id DESC) as sums
    FROM
    	students
    '''
    id|class|sums|
    --|-----|----|
     8|    1|   8|
     6|    1|  14|
     3|    1|  17|
     1|    1|  18|
     7|    2|   7|
     4|    2|  11|
     2|    2|  13|
     9|    3|   9|
     5|    3|  14|
    '''
    ```
  * > 以上例子，按每组 id 倒序后，sums 的值是上行的 id 与本行的 sums 相加而成，***这种计算方法以窗口为单位，在下一个窗口时重新开始***。
  * > 另外，在上边的例子中，***我们发现最终结果的 ID 顺序是比较乱的，我们希望依然按 id 升序显示的话就要将 Order by id 放在 SQL 整体最后，即 `over()` 之外***。
- > **与 group by 的区别**
  * > 结果数据形式
    + > 窗口函数可以在保留原表中的全部数据
    + > group by 只能保留与分组字段聚合的结果
  * > 排序范围不同
    + > 窗口函数中的 order by 只是决定着窗口里的数据的排序方式
    + > 普通的 order by 决定查询出的数据以什么样的方式整体排序
  * > SQL 顺序
    + > group by 先进行计算
    + > 窗口函数在 group by 后进行计算
