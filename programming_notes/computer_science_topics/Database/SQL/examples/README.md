
# 常用

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
