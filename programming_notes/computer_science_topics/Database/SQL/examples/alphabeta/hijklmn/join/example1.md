
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

# 2
>> 【[:star:][`*`]】 //notes：关于join顺序是否满足结合律。

## 2.1 两个 left join 的 trivial 结合不满足，用 sqlite 举例如下：
```sql
-- 准备数据
sqlite> create table ta (id int, ida int);
sqlite> create table tb (id int, idb int);
sqlite> create table tc (id int, idc int);
sqlite> insert into ta values (1,11), (2,22), (3,33);
sqlite> insert into tb values (1,111), (1,111), (2,222), (2,222);
sqlite> insert into tc values (1,1111), (1,1111), (2,2222), (2,2222), (3,3333);
sqlite> select * from ta;
1|11
2|22
3|33
sqlite> select * from tb;
1|111
1|111
2|222
2|222
sqlite> select * from tc;
1|1111
1|1111
2|2222
2|2222
3|3333

-- 最基本的形式：三表连续用两个 left join
sqlite> select * from ta left join tb on ta.id = tb.id left join tc on ta.id = tc.id;
1|11|1|111|1|1111
1|11|1|111|1|1111
1|11|1|111|1|1111
1|11|1|111|1|1111
2|22|2|222|2|2222
2|22|2|222|2|2222
2|22|2|222|2|2222
2|22|2|222|2|2222
3|33|||3|3333

-- 先做后面那个 left join，然后 join key 可能会有三种情况，分别是 ta.id 和 tb.id tc.id 以及 bc.id
sqlite> select * from ta left join (tb left join tc on tb.id = tc.id) as bc on ta.id = bc.id;
1|11|1|111|1|1111
1|11|1|111|1|1111
1|11|1|111|1|1111
1|11|1|111|1|1111
2|22|2|222|2|2222
2|22|2|222|2|2222
2|22|2|222|2|2222
2|22|2|222|2|2222
3|33||||
sqlite> select * from ta left join (tb left join tc on tb.id = tc.id) as bc on ta.id = tb.id;
1|11|1|111|1|1111
1|11|1|111|1|1111
1|11|1|111|1|1111
1|11|1|111|1|1111
2|22|2|222|2|2222
2|22|2|222|2|2222
2|22|2|222|2|2222
2|22|2|222|2|2222
3|33||||
sqlite> select * from ta left join (tb left join tc on tb.id = tc.id) as bc on ta.id = tc.id;
1|11|1|111|1|1111
1|11|1|111|1|1111
1|11|1|111|1|1111
1|11|1|111|1|1111
2|22|2|222|2|2222
2|22|2|222|2|2222
2|22|2|222|2|2222
2|22|2|222|2|2222
3|33||||
sqlite>

/* 
原因是 ta 和 tc 中可能存在 tb 中没有的 key（这里的 3），一旦先做后面的 left join，导致 tc 里的部分列值变 null 了。
试一试查查先做后面的 left join，看看产生的中间结果就知道了：

sqlite> select * from tb left join tc on tb.id = tc.id;
1|111|1|1111
1|111|1|1111
1|111|1|1111
1|111|1|1111
2|222|2|2222
2|222|2|2222
2|222|2|2222
2|222|2|2222
*/
```
