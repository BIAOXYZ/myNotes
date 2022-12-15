
# 1

SQL之case when then用法 https://www.cnblogs.com/richardzhu/p/3571670.html  【//notes：估计这篇文章里的数据库不是pg，所以下面个人实战里对表的列类型进行了一些小修改。】
- > case具有两种格式。简单case函数和case搜索函数。
  ```sql
  --简单case函数
  case sex
    when '1' then '男'
    when '2' then '女’
    else '其他' end
  --case搜索函数
  case when sex = '1' then '男'
       when sex = '2' then '女'
       else '其他' end
  ```
  > 这两种方式，可以实现相同的功能。简单case函数的写法相对比较简洁，但是和case搜索函数相比，功能方面会有些限制，比如写判定式。
- > 还有一个需要注重的问题，case函数只返回第一个符合条件的值，剩下的case部分将会被自动忽略。
  ```sql
  --比如说，下面这段sql，你永远无法得到“第二类”这个结果
  case when col_1 in ('a','b') then '第一类'
       when col_1 in ('a') then '第二类'
       else '其他' end  
  ```

## 文章内容直接实战

```sql
drop table if exists users;

create table users(id int, name varchar(20), sex int);

insert into users(id,name) values(1,'张一');
insert into users(id,name,sex) values(2,'张二',1);
insert into users(id,name) values(3,'张三');
insert into users(id,name) values(4,'张四');
insert into users(id,name,sex) values(5,'张五',2);
insert into users(id,name,sex) values(6,'张六',1);
insert into users(id,name,sex) values(7,'张七',2);
insert into users(id,name,sex) values(8,'张八',1);

select * from users;

select u.id,u.name,u.sex,
    (case u.sex
        when 1 then '男'
        when 2 then '女'
        else '空的' end
    ) 性别
from users u;

select u.id,u.name,
    (case u.sex
        when 1 then '男'
        when 2 then '女'
        else '空的' end
    ) 性别
from users u;

select
    sum(case u.sex when 1 then 1 else 0 end)男性,
    sum(case u.sex when 2 then 1 else 0 end)女性,
    sum(case when u.sex <> 1 and u.sex <> 2 then 1 else 0 end)性别为空
from users u;

select
    count(case when u.sex=1 then 1 end)男性,
    count(case when u.sex=2 then 1 end)女,
    count(case when u.sex <> 1 and u.sex <> 2 then 1 end)性别为空
from users u;
```

```sql
postgres=# drop table if exists users;
NOTICE:  table "users" does not exist, skipping
DROP TABLE
postgres=#
postgres=# create table users(id int, name varchar(20), sex int);
CREATE TABLE
postgres=#
postgres=# insert into users(id,name) values(1,'张一');
INSERT 0 1
postgres=# insert into users(id,name,sex) values(2,'张二',1);
INSERT 0 1
postgres=# insert into users(id,name) values(3,'张三');
INSERT 0 1
postgres=# insert into users(id,name) values(4,'张四');
INSERT 0 1
postgres=# insert into users(id,name,sex) values(5,'张五',2);
INSERT 0 1
postgres=# insert into users(id,name,sex) values(6,'张六',1);
INSERT 0 1
postgres=# insert into users(id,name,sex) values(7,'张七',2);
INSERT 0 1
postgres=# insert into users(id,name,sex) values(8,'张八',1);
INSERT 0 1
postgres=#
postgres=# select * from users;
 id | name | sex
----+------+-----
  1 | 张一 |
  2 | 张二 |   1
  3 | 张三 |
  4 | 张四 |
  5 | 张五 |   2
  6 | 张六 |   1
  7 | 张七 |   2
  8 | 张八 |   1
(8 rows)

postgres=#
postgres=# select u.id,u.name,u.sex,
postgres-#     (case u.sex
postgres(#         when 1 then '男'
postgres(#         when 2 then '女'
postgres(#         else '空的' end
postgres(#     ) 性别
postgres-# from users u;
 id | name | sex | 性别
----+------+-----+------
  1 | 张一 |     | 空的
  2 | 张二 |   1 | 男
  3 | 张三 |     | 空的
  4 | 张四 |     | 空的
  5 | 张五 |   2 | 女
  6 | 张六 |   1 | 男
  7 | 张七 |   2 | 女
  8 | 张八 |   1 | 男
(8 rows)

postgres=#
postgres=# select u.id,u.name,
postgres-#     (case u.sex
postgres(#         when 1 then '男'
postgres(#         when 2 then '女'
postgres(#         else '空的' end
postgres(#     ) 性别
postgres-# from users u;
 id | name | 性别
----+------+------
  1 | 张一 | 空的
  2 | 张二 | 男
  3 | 张三 | 空的
  4 | 张四 | 空的
  5 | 张五 | 女
  6 | 张六 | 男
  7 | 张七 | 女
  8 | 张八 | 男
(8 rows)

postgres=#
postgres=# select
postgres-#     sum(case u.sex when 1 then 1 else 0 end)男性,
postgres-#     sum(case u.sex when 2 then 1 else 0 end)女性,
postgres-#     sum(case when u.sex <> 1 and u.sex <> 2 then 1 else 0 end)性别为空
postgres-# from users u;
 男性 | 女性 | 性别为空
------+------+----------
    3 |    2 |        0
(1 row)

postgres=#
postgres=# select
postgres-#     count(case when u.sex=1 then 1 end)男性,
postgres-#     count(case when u.sex=2 then 1 end)女,
postgres-#     count(case when u.sex <> 1 and u.sex <> 2 then 1 end)性别为空
postgres-# from users u;
 男性 | 女 | 性别为空
------+----+----------
    3 |  2 |        0
(1 row)

postgres=#
```

# 2

CASE WHEN 用法 https://www.jianshu.com/p/f098606391ea

## 文章（部分）内容直接实战

```sql
CREATE TABLE demo (type varchar(10) NULL, num int NULL);

insert into demo values ('A',10);
insert into demo values ('B',10);
insert into demo values ('C',10);
insert into demo values ('D',10);
insert into demo values ('E',10);
insert into demo values ('F',10);
insert into demo values ('G',10);

select * from demo;

/*利用CASE WHEN 和 GROUP BY 实现自定义分组合计*/
select 
  case 
    when type in('A','C','D') THEN 'ACD'
    when type in('F','G') THEN 'FG'
  else type end as types,sum(num)
  from demo
  group by 
  case 
    when type in('A','C','D') THEN 'ACD'
    when type in('F','G') THEN 'FG'
  else type end;
```
```sql
postgres=# select * from demo;
 type | num
------+-----
 A    |  10
 B    |  10
 C    |  10
 D    |  10
 E    |  10
 F    |  10
 G    |  10
(7 rows)

postgres=#
postgres=# select
postgres-#   case
postgres-#     when type in('A','C','D') THEN 'ACD'
postgres-#     when type in('F','G') THEN 'FG'
postgres-#   else type end as types,sum(num)
postgres-#   from demo
postgres-#   group by
postgres-#   case
postgres-#     when type in('A','C','D') THEN 'ACD'
postgres-#     when type in('F','G') THEN 'FG'
postgres-#   else type end;
 types | sum
-------+-----
 ACD   |  30
 FG    |  20
 B     |  10
 E     |  10
(4 rows)

postgres=#
```

# 其他

SQL之CASE WHEN用法详解 https://blog.csdn.net/rongtaoup/article/details/82183743

# `end` / `end as`

SQL之case when then用法 https://www.cnblogs.com/richardzhu/p/3571670.html
- > 1、上表结果中的"sex"是用代码表示的，希望将代码用中文表示。可在语句中使用case语句：
- > 2、如果不希望列表中出现"sex"列，语句如下：

SQL中的case when then else end用法 https://segmentfault.com/a/1190000020877471

SQL- case when then else end 用法经验总结 https://www.cnblogs.com/Formulate0303/p/11962254.html
