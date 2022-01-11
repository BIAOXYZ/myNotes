
# 1

SQL之case when then用法 https://www.cnblogs.com/richardzhu/p/3571670.html
>> //notes：估计这篇文章里的数据库不是pg，所以下面个人实战里对表的列类型进行了一些小修改。

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
