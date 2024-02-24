
# 1

```sql
create table input_a (col1 int, col2 varchar(50));
insert into input_a (col1, col2) values (1, 'data1');
insert into input_a (col1, col2) values (2, 'data2');

create table input_b (col1 int, col3 decimal(10, 2));
insert into input_b (col1, col3) values (1, 100.00);
insert into input_b (col1, col3) values (3, 200.00);

-- 使用CTE进行查询
with tb_a as (
    select * from input_a
),
tb_b as (
    select * from input_b
)
select * from tb_a inner join tb_b on tb_a.col1 = tb_b.col1;

-- 使用CTE进行查询2
with tb_a as (
    select * from input_a
)
select * from tb_a;
```
```sql
antlr_test=# select * from input_a;
 col1 | col2
------+-------
    1 | data1
    2 | data2
(2 rows)

antlr_test=#
antlr_test=# select * from input_b;
 col1 |  col3
------+--------
    1 | 100.00
    3 | 200.00
(2 rows)

antlr_test=# with tb_a as (
    select * from input_a
),
tb_b as (
    select * from input_b
)
select * from tb_a inner join tb_b on tb_a.col1 = tb_b.col1;
 col1 | col2  | col1 |  col3
------+-------+------+--------
    1 | data1 |    1 | 100.00
(1 row)

antlr_test=# with tb_a as (
    select * from input_a
)
select * from tb_a;
 col1 | col2
------+-------
    1 | data1
    2 | data2
(2 rows)
```
