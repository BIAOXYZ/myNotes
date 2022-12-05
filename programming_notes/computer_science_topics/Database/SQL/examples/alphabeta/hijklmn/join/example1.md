
# 0

How to Join Tables in SQL Without Using JOINs https://learnsql.com/blog/sql-join-tables-without-join/
- > **The First Method: `FROM` and `WHERE`**
- > **The Second Method: `UNION`/`UNION ALL`**
- > **Yes, Tables Can Be Joined Without the JOIN Keyword**

Can you Join two Tables Without a Common Column? https://learnsql.com/blog/join-tables-without-common-column/

# 1

```sql
create table t1 (id int);
create table t2 (uid int);
insert into t1 values (1), (2), (3);
insert into t2 values (1), (1), (4);
select * from t1;
select * from t2;
select * from t1 join t2 on t1.id = t2.uid;
select * from t1 LEFT join t2 on t1.id = t2.uid;
```
```sql
sqlite> select * from t1;
1
2
3
sqlite> select * from t2;
1
1
4
sqlite> select * from t1 inner join t2 where t1.id = t2.uid;
1|1
1|1
sqlite> select * from t1 left join t2 where t1.id = t2.uid;
1|1
1|1
sqlite>

-- 到这里就觉得很奇怪了，怎么 SQLite 的 (inner) join 和 left join 结果一样呢？
-- 原来是前面没注意该用 on 的用了 where。。。但是 SQLite 也不会报语法错误。。。
-- 试了下如果是 pg，on 换成 where 是会报错的（`syntax error at or near "where"`）。
sqlite> select * from t1 inner join t2 on t1.id = t2.uid;
1|1
1|1
sqlite> select * from t1 left join t2 on t1.id = t2.uid;
1|1
1|1
2|
3|
sqlite>
```
