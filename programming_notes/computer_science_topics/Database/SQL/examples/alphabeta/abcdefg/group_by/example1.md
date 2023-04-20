
# 1

must appear in the GROUP BY clause or be used in an aggregate function https://www.cnblogs.com/zxhyJack/p/9934259.html
- > 今天在分组统计的时候pgsql报错 `must appear in the GROUP BY clause or be used in an aggregate function`，***在mysql里面是可以的，但是pgsql报错***，我去stackoverflow查询了一下，发现有人遇到过和我一样的问题，这是pgsql一个常见的聚合问题，***在SQL3标准以前，选择显示的字段必须出现在在 `GROUP BY` 中***。
- > 有一张表叫 makerar，表中记录如下：
  ```console
  cname	wmname	avg
  canada	zoro	2.00
  spain	luffy	1.00
  spain	usopp	5.00
  ```
  > 我想要查询每个 cname 的最大 avg，按照mysql的写法是 `SELECT cname, wmname, MAX(avg) FROM makerar GROUP BY cname;`
- > 在pgsql中报错
  ```console
  ERROR:  column "makerar.wmname" must appear in the GROUP BY clause or be used in an aggregate function 
  LINE 1: SELECT cname, wmname, MAX(avg)  FROM makerar GROUP BY cname;
  ```
  > 意思是 wmname 字段必须在 GROUP BY 中出现或者被用于聚合函数。
- > 参考链接：https://stackoverflow.com/questions/19601948/must-appear-in-the-group-by-clause-or-be-used-in-an-aggregate-function

## 1.1 文章内容直接实战

```sql
create table makerar (cname varchar(24), wmname varchar(24), avg numeric);

/* 双引号形式貌似不行
insert into makerar values ("canada", "zoro", 2.00);
*/
insert into makerar values ('canada', 'zoro', 2.00);
insert into makerar values ('spain', 'luffy', 1.00);
insert into makerar values ('spain', 'usopp', 5.00);

select * from makerar;

/* 这条会报错，因为：
1. wmname 没有在 group by 字段出现。
2. wmname 没有被用于聚合函数。
*/
SELECT cname, wmname, MAX(avg) FROM makerar GROUP BY cname;

/* 这条能查但是结果不是想要的 */
SELECT cname, wmname, MAX(avg) FROM makerar GROUP BY cname, wmname;

SELECT   
  t.cname,
  m.wmname,
  t.max
FROM 
  (SELECT 
    cname,
    MAX(avg) AS max 
  FROM makerar
  GROUP BY cname) t
LEFT JOIN makerar m ON t.cname = m.cname AND t.max = m.avg;
```

```sql
postgres=# drop table if exists makerar;
DROP TABLE
postgres=#
postgres=# create table makerar (cname varchar(24), wmname varchar(24), avg numeric);
CREATE TABLE
postgres=# insert into makerar values ('canada', 'zoro', 2.00);
INSERT 0 1
postgres=# insert into makerar values ('spain', 'luffy', 1.00);
INSERT 0 1
postgres=# insert into makerar values ('spain', 'usopp', 5.00);
INSERT 0 1
postgres=#
postgres=# select * from makerar;
 cname  | wmname | avg
--------+--------+------
 canada | zoro   | 2.00
 spain  | luffy  | 1.00
 spain  | usopp  | 5.00
(3 rows)

postgres=#
postgres=# SELECT cname, wmname, MAX(avg) FROM makerar GROUP BY cname;
ERROR:  column "makerar.wmname" must appear in the GROUP BY clause or be used in an aggregate function
LINE 1: SELECT cname, wmname, MAX(avg) FROM makerar GROUP BY cname;
                      ^
postgres=#
postgres=# SELECT cname, wmname, MAX(avg) FROM makerar GROUP BY cname, wmname;
 cname  | wmname | max
--------+--------+------
 canada | zoro   | 2.00
 spain  | luffy  | 1.00
 spain  | usopp  | 5.00
(3 rows)

postgres=#
postgres=# SELECT
postgres-#   t.cname,
postgres-#   m.wmname,
postgres-#   t.max
postgres-# FROM
postgres-#   (SELECT
postgres(#     cname,
postgres(#     MAX(avg) AS max
postgres(#   FROM makerar
postgres(#   GROUP BY cname) t
postgres-# LEFT JOIN makerar m ON t.cname = m.cname AND t.max = m.avg;
 cname  | wmname | max
--------+--------+------
 canada | zoro   | 2.00
 spain  | usopp  | 5.00
(2 rows)

postgres=#
```

## 1.2 文章内容之外

**对pg来说，如下两种情况都是可以的**：
1. 只有聚合函数，没有group by。
2. 只有group by，没有聚合函数。

其实，更一般的情况是：**只要有“聚合”的情况（aggregate function 或者 group by）出现，那么任何 select 选中的列要么出现在聚合函数中，要么出现在group by中**。

```sql
postgres=# SELECT MAX(avg) FROM makerar;
 max
------
 5.00
(1 row)

postgres=#
postgres=# SELECT cname, MAX(avg) FROM makerar;
ERROR:  column "makerar.cname" must appear in the GROUP BY clause or be used in an aggregate function
LINE 1: SELECT cname, MAX(avg) FROM makerar;
               ^
postgres=#
postgres=# SELECT cname, wmname FROM makerar GROUP BY cname, wmname;
 cname  | wmname
--------+--------
 canada | zoro
 spain  | luffy
 spain  | usopp
(3 rows)

postgres=#
postgres=# SELECT cname, wmname, avg FROM makerar GROUP BY cname, wmname;
ERROR:  column "makerar.avg" must appear in the GROUP BY clause or be used in an aggregate function
LINE 1: SELECT cname, wmname, avg FROM makerar GROUP BY cname, wmnam...
                              ^
postgres=#
```

## 1.3 用 mysql 试了试发现这作者说的也不对啊，mysql5.7（但是后来 mysql8.0 也试了，一样的） 和 pg 的表现是一样的：只要有“聚合”出现，select 的列同样必须满足`在聚合函数内`或`在group by内`  -->  后来破案了，是因为 mysql 的 sql_mode 可以选 `'ansi'` 或者 `'traditional'`。前者会和 pg 一样报错，后者是能执行的。详情参见 《CMU 15-445/645 Database Systems》 Fall/2019 的[笔记](https://github.com/BIAOXYZ/paperRelatedRepository/blob/master/notes/CourseNotes/from_university/CMU/database/CMU_15-445/fall2019/01--10.md#%E7%AC%94%E8%AE%B0-1)。

```sh
docker run -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=123456 -itd mysql:5.7
docker exec -it mysql bash
# 在容器里
mysql -uroot -p123456
```
```sql
mysql> create table makerar (cname varchar(24), wmname varchar(24), avg numeric);
ERROR 1046 (3D000): No database selected
mysql>
mysql> use mysql;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql>
mysql> create table makerar (cname varchar(24), wmname varchar(24), avg numeric);
Query OK, 0 rows affected (0.04 sec)

mysql>
mysql> insert into makerar values ('canada', 'zoro', 2.00);
Query OK, 1 row affected (0.01 sec)

mysql> insert into makerar values ('spain', 'luffy', 1.00);
Query OK, 1 row affected (0.01 sec)

mysql> insert into makerar values ('spain', 'usopp', 5.00);
Query OK, 1 row affected (0.02 sec)

mysql>
mysql> select * from makerar;
+--------+--------+------+
| cname  | wmname | avg  |
+--------+--------+------+
| canada | zoro   |    2 |
| spain  | luffy  |    1 |
| spain  | usopp  |    5 |
+--------+--------+------+
3 rows in set (0.00 sec)

mysql>
mysql> SELECT cname, wmname, MAX(avg) FROM makerar GROUP BY cname;
ERROR 1055 (42000): Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'mysql.makerar.wmname' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
mysql>
mysql> SELECT cname, wmname, MAX(avg) FROM makerar GROUP BY cname, wmname;
+--------+--------+----------+
| cname  | wmname | MAX(avg) |
+--------+--------+----------+
| canada | zoro   |        2 |
| spain  | luffy  |        1 |
| spain  | usopp  |        5 |
+--------+--------+----------+
3 rows in set (0.00 sec)

mysql>
mysql> SELECT MAX(avg) FROM makerar;
+----------+
| MAX(avg) |
+----------+
|        5 |
+----------+
1 row in set (0.00 sec)

mysql>
mysql> SELECT cname, MAX(avg) FROM makerar;
ERROR 1140 (42000): In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'mysql.makerar.cname'; this is incompatible with sql_mode=only_full_group_by
mysql>
mysql> SELECT cname, wmname FROM makerar GROUP BY cname, wmname;
+--------+--------+
| cname  | wmname |
+--------+--------+
| canada | zoro   |
| spain  | luffy  |
| spain  | usopp  |
+--------+--------+
3 rows in set (0.00 sec)

mysql>
mysql> SELECT cname, wmname, avg FROM makerar GROUP BY cname, wmname;
ERROR 1055 (42000): Expression #3 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'mysql.makerar.avg' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
mysql>
```

# 2

SQL中GROUP BY的用法 https://blog.csdn.net/liitdar/article/details/85272035
- > **2 常见用法**
  * > 现有一数据库表，内容如下：
    ```console
    mysql> select * from roles;
    +---------+------------+----------+---------------------+
    | role_id | occupation | camp     | register_time       |
    +---------+------------+----------+---------------------+
    |       1 | mage       | alliance | 2018-12-03 16:11:28 |
    |       2 | paladin    | alliance | 2018-11-30 16:11:28 |
    |       3 | rogue      | horde    | 2018-12-01 16:11:28 |
    |       4 | priest     | alliance | 2018-12-02 16:11:28 |
    |       5 | shaman     | horde    | NULL                |
    |       6 | warrior    | alliance | NULL                |
    |       7 | warlock    | horde    | 2018-12-04 16:11:28 |
    |       8 | hunter     | horde    | NULL                |
    +---------+------------+----------+---------------------+
    8 rows in set (0.00 sec)
     
    mysql> 
    ```
- > **2.1 结合聚合函数**
  * > 首先，不使用聚合函数，只使用 `GROUP BY`，查询结果如下：
    ```sql
    mysql> select camp,role_id,occupation,register_time from roles group by camp;
    +----------+---------+------------+---------------------+
    | camp     | role_id | occupation | register_time       |
    +----------+---------+------------+---------------------+
    | alliance |       1 | mage       | 2018-12-03 16:11:28 |
    | horde    |       3 | rogue      | 2018-12-01 16:11:28 |
    +----------+---------+------------+---------------------+
    2 rows in set (0.00 sec)
     
    mysql>
    ```
    > 上述查询结果能够看到，***当不使用聚合函数时，`GROUP BY`的结果是分组内容中的第一组查询结果***。当然，在实际使用中，我们通常都需要**将聚合函数与 `GROUP BY` 用法结合使用，来实现某种目的**。
    >> 【[:star:][`*`]】 //notes：后来又经过了一些查找和学习，估计这篇文章里 mysql 的 `sql_mode` 是 `'traditional'`，此时其他几个列（`role_id, occupation, register_time`）虽然既没有在聚合函数里，也没有在`group by`里（此时对于列 `camp` 里的某一个具体值 —— 比如 'alliance' 或 'horde' —— 有多个可能的行可选），但是数据库采取了 ***选择满足条件的第一个行的策略***。
  * > 例如，我们想查找“联盟和部落阵营中所有角色最早的注册时间”，则可以通过如下语句实现：
    ```sql
    mysql> select camp,MIN(register_time) as register_time from roles group by camp;
    +----------+---------------------+
    | camp     | register_time       |
    +----------+---------------------+
    | alliance | 2018-11-30 16:11:28 |
    | horde    | 2018-12-01 16:11:28 |
    +----------+---------------------+
    2 rows in set (0.01 sec)
     
    mysql>
    ```
    > 上述查询结果表明，通过使用聚合函数“`MIN()`”，我们找到了每个阵营中最早的注册时间。
- > **2.2 `HAVING`子句**
  * > `HAVING` 子句可以筛选通过 `GROUP BY` 分组后的各组数据。承接上文内容，通过 `HAVING` 子句筛选出所有阵营中最早的注册时间，语句如下：
    ```sql
    mysql> select camp,MIN(register_time) as register_time from roles group by camp HAVING register_time > '2018-12-01 00:00:00';
    +-------+---------------------+
    | camp  | register_time       |
    +-------+---------------------+
    | horde | 2018-12-01 16:11:28 |
    +-------+---------------------+
    1 row in set (0.00 sec)
     
    mysql> 
    ```
  * > 注意：上述语句中 `HAVING` 的对象 register_time，实际上是前面聚合函数 `MIN(register_time)` 的结果集。而由于 `WHERE` 子句不能包含聚合函数，所以此处只能使用 `HAVING` 子句。如果使用 `WHERE` 子句替换 `HAVING` 子句，命令会报错，信息如下：
    ```sql
    mysql> select camp,MIN(register_time) as register_time from roles group by camp WHERE register_time > '2018-12-01 00:00:00';
    ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'WHERE register_time > '2018-12-01 00:00:00'' at line 1
    mysql>
    ```
  * > 【`HAVING` 与 `WHERE` 的区别】：
    + > `WHERE` 子句的作用：***在对查询结果进行分组前***，把不符合 `WHERE` 条件的行去掉，即在分组之前过滤数据。另外，***`WHERE` 条件中不能包含聚组函数***。
    + > `HAVING` 子句的作用：筛选满足条件的组，***即在分组后过滤数据***，条件中经常包含聚组函数，使用 `HAVING` 条件过滤出特定的组。

## 2.1 文章内容直接实战

```sh
docker run -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=123456 -itd mysql:8.0
docker exec -it mysql bash
# 如果用 mysql -h localhost -u root -p 的话需要交互式输入密码
mysql -uroot -p123456
```

```sql
create table roles (role_id int, occupation varchar(36), camp varchar(36), register_time timestamp);
insert into roles values (1, 'mage', 'alliance', '2018-12-03 16:11:28');
insert into roles values (2, 'paladin', 'alliance', '2018-11-30 16:11:28');
insert into roles values (3, 'rogue', 'horde', '2018-12-01 16:11:28');
insert into roles values (4, 'priest', 'alliance', '2018-12-02 16:11:28');
insert into roles values (5, 'shaman', 'horde', NULL);
insert into roles values (6, 'warrior', 'alliance', NULL);
insert into roles values (7, 'warlock', 'horde', '2018-12-04 16:11:28');
insert into roles values (8, 'hunter', 'horde', NULL);
select * from roles;

/* 这句在原文里是可以成功执行的（作者都列出来查询结果了），但是我用 mysql8.0 就不行。
 * 所以应该是某个版本的 mysql 确实是可以（既不出现在aggr函数里，也不出现在groupby）的，
 * 但是后来都改得比较正规了，也就是——只要有“聚合”出现，那么 select 的列要么在聚合函数里，要么在group by里。
 */
select camp,role_id,occupation,register_time from roles group by camp;

select camp,MIN(register_time) as register_time from roles group by camp;

/* 这两句主要是对比 having 和 where的区别，说明where的过滤里不能有聚合 */
select camp,MIN(register_time) as register_time from roles group by camp HAVING register_time > '2018-12-01 00:00:00';
select camp,MIN(register_time) as register_time from roles group by camp WHERE register_time > '2018-12-01 00:00:00';
```

```sql
mysql> create table roles (role_id int, occupation varchar(36), camp varchar(36), register_time timestamp);
Query OK, 0 rows affected (0.02 sec)

mysql> insert into roles values (1, 'mage', 'alliance', '2018-12-03 16:11:28');
Query OK, 1 row affected (0.00 sec)

mysql> insert into roles values (2, 'paladin', 'alliance', '2018-11-30 16:11:28');
Query OK, 1 row affected (0.00 sec)

mysql> insert into roles values (3, 'rogue', 'horde', '2018-12-01 16:11:28');
Query OK, 1 row affected (0.01 sec)

mysql> insert into roles values (4, 'priest', 'alliance', '2018-12-02 16:11:28');
Query OK, 1 row affected (0.01 sec)

mysql> insert into roles values (5, 'shaman', 'horde', NULL);
Query OK, 1 row affected (0.01 sec)

mysql> insert into roles values (6, 'warrior', 'alliance', NULL);
Query OK, 1 row affected (0.01 sec)

mysql> insert into roles values (7, 'warlock', 'horde', '2018-12-04 16:11:28');
Query OK, 1 row affected (0.01 sec)

mysql> insert into roles values (8, 'hunter', 'horde', NULL);
Query OK, 1 row affected (0.01 sec)

mysql> select * from roles;
+---------+------------+----------+---------------------+
| role_id | occupation | camp     | register_time       |
+---------+------------+----------+---------------------+
|       1 | mage       | alliance | 2018-12-03 16:11:28 |
|       2 | paladin    | alliance | 2018-11-30 16:11:28 |
|       3 | rogue      | horde    | 2018-12-01 16:11:28 |
|       4 | priest     | alliance | 2018-12-02 16:11:28 |
|       5 | shaman     | horde    | NULL                |
|       6 | warrior    | alliance | NULL                |
|       7 | warlock    | horde    | 2018-12-04 16:11:28 |
|       8 | hunter     | horde    | NULL                |
+---------+------------+----------+---------------------+
8 rows in set (0.00 sec)

mysql> 
mysql> select camp,role_id,occupation,register_time from roles group by camp;
ERROR 1055 (42000): Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'mysql.roles.role_id' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
mysql> 
mysql> select camp,MIN(register_time) as register_time from roles group by camp;
+----------+---------------------+
| camp     | register_time       |
+----------+---------------------+
| alliance | 2018-11-30 16:11:28 |
| horde    | 2018-12-01 16:11:28 |
+----------+---------------------+
2 rows in set (0.00 sec)

mysql> 
mysql> select camp,MIN(register_time) as register_time from roles group by camp HAVING register_time > '2018-12-01 00:00:00';
+-------+---------------------+
| camp  | register_time       |
+-------+---------------------+
| horde | 2018-12-01 16:11:28 |
+-------+---------------------+
1 row in set (0.00 sec)

mysql> 
mysql> select camp,MIN(register_time) as register_time from roles group by camp WHERE register_time > '2018-12-01 00:00:00';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'WHERE register_time > '2018-12-01 00:00:00'' at line 1
mysql> 
mysql>
```

# 3

SELECT https://www.sqlite.org/lang_select.html
- 2.5. Bare columns in an aggregate query https://www.sqlite.org/lang_select.html#bare_columns_in_an_aggregate_query
  * > The usual case is that all column names in an aggregate query are either arguments to aggregate functions or else appear in the GROUP BY clause. A result column which contains a column name that is not within an aggregate function and that does not appear in the GROUP BY clause (if one exists) is called a "bare" column. Example:
    ```sql
    SELECT a, b, sum(c) FROM tab1 GROUP BY a;
    ```
  * > In the query above, the "a" column is part of the GROUP BY clause and so each row of the output contains one of the distinct values for "a". The "c" column is contained within the sum() aggregate function and so that output column is the sum of all "c" values in rows that have the same value for "a". But what is the result of the bare column "b"? The answer is that the "b" result will be the value for "b" in one of the input rows that form the aggregate. The problem is that you usually do not know which input row is used to compute "b", and so in many cases the value for "b" is undefined.
