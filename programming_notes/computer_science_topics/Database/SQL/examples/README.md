
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

# 3

```sql
create table cipher_agg_input_a (uid int, val_a1 Float64, val_a2 Float64, val_a3 Float64, cls_a varchar(255)) ENGINE = TinyLog;
insert into cipher_agg_input_a values (101, 10, -10, 1, 'a');
insert into cipher_agg_input_a values (102, 5, 1, 1, 'a');
insert into cipher_agg_input_a values (113, -1, 1, 1, 'a');
insert into cipher_agg_input_a values (201, 100, 0.01, -0.01, 'b');
insert into cipher_agg_input_a values (202, -100, 0.02, -0.02, 'b');
insert into cipher_agg_input_a values (203, 100, 0.01, 100.2, 'b');

create table cipher_agg_input_b (device_id int, val_b1 Float64, val_b2 Float64, val_b3 Float64, cls_b varchar(255)) ENGINE = TinyLog;
insert into cipher_agg_input_b values (101, 10, 10, 1, 'x');
insert into cipher_agg_input_b values (102, 5, 1, 1, 'x');
insert into cipher_agg_input_b values (113, -1, 3, 1, 'y');
insert into cipher_agg_input_b values (201, 100, 100, -0.01, 'x');
insert into cipher_agg_input_b values (202, -100, 10, -0.02, 'x');
insert into cipher_agg_input_b values (203, 100, 1000, 100.2, 'x');

select sum(cipher_agg_input_b.val_b1) as sum_of_val_b1, count(cipher_agg_input_a.val_a1) as count_of_val_a1,
count(distinct cipher_agg_input_b.val_b1) as count_distinct_val_b1, quantile(0.2)(cipher_agg_input_b.val_b2) as percentile_val_b2_0_2
from cipher_agg_input_a left join cipher_agg_input_b on cipher_agg_input_a.uid =cipher_agg_input_b.device_id
group by cipher_agg_input_a.cls_a, cipher_agg_input_b.cls_b;
```
```console
eef56cb5d207 :) select sum(cipher_agg_input_b.val_b1) as sum_of_val_b1, count(cipher_agg_input_a.val_a1) as count_of_val_a1,
                count(distinct cipher_agg_input_b.val_b1) as count_distinct_val_b1, quantile(0.2)(cipher_agg_input_b.val_b2) as percentile_val_b2_0_2
                from cipher_agg_input_a left join cipher_agg_input_b on cipher_agg_input_a.uid =cipher_agg_input_b.device_id
                group by cipher_agg_input_a.cls_a, cipher_agg_input_b.cls_b;

SELECT
    sum(cipher_agg_input_b.val_b1) AS sum_of_val_b1,
    count(cipher_agg_input_a.val_a1) AS count_of_val_a1,
    countDistinct(cipher_agg_input_b.val_b1) AS count_distinct_val_b1,
    quantile(0.2)(cipher_agg_input_b.val_b2) AS percentile_val_b2_0_2
FROM cipher_agg_input_a
LEFT JOIN cipher_agg_input_b ON cipher_agg_input_a.uid = cipher_agg_input_b.device_id
GROUP BY
    cipher_agg_input_a.cls_a,
    cipher_agg_input_b.cls_b

Query id: a41e3e48-42b9-498c-a004-a462276e4209

┌─sum_of_val_b1─┬─count_of_val_a1─┬─count_distinct_val_b1─┬─percentile_val_b2_0_2─┐
│            15 │               2 │                     2 │                   2.8 │
│            -1 │               1 │                     1 │                     3 │
│           100 │               3 │                     2 │                    46 │
└───────────────┴─────────────────┴───────────────────────┴───────────────────────┘

3 rows in set. Elapsed: 0.005 sec.

eef56cb5d207 :)
```
