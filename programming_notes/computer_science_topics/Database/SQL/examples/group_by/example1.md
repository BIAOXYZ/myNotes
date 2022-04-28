
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

## 文章内容直接实战

```sql
create table makerar (cname varchar(24), wmname	varchar(24), avg numeric);

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

## 文章内容之外

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
