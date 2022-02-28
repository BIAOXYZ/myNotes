
# 常用

## 1

```sql
create table t1 (id int);
insert into t1 select generate_series(1, 10);

create table t2 (id int, name varchar(24));
insert into t2 (id, name) values (1, 'a');
insert into t2 (id, name) values (2, 'b');
insert into t2 (id, name) values (3, 'a');
insert into t2 (id, name) values (4, 'b');

create table t3 (num int);
insert into t3 select generate_series(11, 20);

select sum(ids) from (select t1.id as ids from t1 join t2 on t1.id = t2.id) as query1;

select sum(t1.id) from t1, t2 where t1.id = t2.id;
```

## 2

```sql
create table input_a (uid int, val int, t int);
insert into input_a values (44969473, 2, 1);
insert into input_a values (1234182, 77, 1);
insert into input_a values (30274561, 1, 2);
insert into input_a values (56520193, 12, 2);
insert into input_a values (11262273, 8, 1);

create table input_b (device_id int, age varchar(255), gender varchar(255), date int, y int);
insert into input_b values (2245633, '24-30', 'female', 20211130, 1);
insert into input_b values (2463745, '50+', 'male', 20211130, 2);
insert into input_b values (8897537, '50+', 'male', 20211130, 3);
insert into input_b values (26351105, '18-23', 'male', 20211130, 2);
insert into input_b values (30274561, '50+', 'female', 20211130, 1);
insert into input_b values (47116801, '50+', 'male', 20211130, 1);
insert into input_b values (56520193, '24-30', 'male', 20211130, 3);
insert into input_b values (60876801, '18-23', 'female', 20211130, 1);
insert into input_b values (86262273, '24-30', 'male', 20211130, 2);
insert into input_b values (44969473, '50+', 'female', 20211130, 1);

/* Clickhouse 的话建表语句不太一样，需要指明表的引擎；但是插数据语句是一样的 */
create table input_a (uid int, val int, t int) ENGINE = TinyLog;
create table input_b (device_id int, age varchar(255), gender varchar(255), date int, y int) ENGINE = TinyLog;
```

【[:star:][`*`]】 然后发现对于下面的查询语句，CK和关系型数据库（这里只试了pg，mysql和pg是一样的）的在处理空值时不一样。。。

```console
postgres=# select input_a.t, input_b.age, sum(input_a.val), sum(pow(input_a.val,2)), sum(input_a.t+input_b.y) FROM input_a left join input_b ON input_a.uid = input_b.device_id GROUP BY input_a.t, input_b.age;
 t |  age  | sum | sum  | sum
---+-------+-----+------+-----
 2 | 24-30 |  12 |  144 |   5
 2 | 50+   |   1 |    1 |   3
 1 | 50+   |   2 |    4 |   2
 1 |       |  85 | 5993 |
(4 rows)
```
```console
eef56cb5d207 :) select input_a.t, input_b.age, sum(input_a.val), sum(pow(input_a.val,2)), sum(input_a.t+input_b.y) FROM input_a left join input_b ON input_a.uid = input_b.device_id GROUP BY input_a.t, input_b.age

SELECT
    input_a.t,
    input_b.age,
    sum(input_a.val),
    sum(pow(input_a.val, 2)),
    sum(input_a.t + input_b.y)
FROM input_a
LEFT JOIN input_b ON input_a.uid = input_b.device_id
GROUP BY
    input_a.t,
    input_b.age

Query id: 1ff71c42-7bba-49e0-bdf1-0ccc078ebf3f

┌─t─┬─age───┬─sum(val)─┬─sum(pow(val, 2))─┬─sum(plus(t, y))─┐
│ 1 │ 50+   │        2 │                4 │               2 │
│ 2 │ 50+   │        1 │                1 │               3 │
│ 1 │       │       85 │             5993 │               2 │
│ 2 │ 24-30 │       12 │              144 │               5 │
└───┴───────┴──────────┴──────────────────┴─────────────────┘

4 rows in set. Elapsed: 0.013 sec.

eef56cb5d207 :) 
```
