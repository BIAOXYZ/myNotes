
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
-- 方便复制
create table ta (id int, ida int);
create table tb (id int, idb int);
create table tc (id int, idc int);
insert into ta values (1,11), (2,22), (3,33);
insert into tb values (1,111), (1,111), (2,222), (2,222);
insert into tc values (1,1111), (1,1111), (2,2222), (2,2222), (3,3333);
select * from ta;
select * from tb;
select * from tc;
select * from ta left join tb on ta.id = tb.id left join tc on ta.id = tc.id;
select * from ta left join (tb left join tc on tb.id = tc.id) as bc on ta.id = bc.id;
select * from ta left join (tb left join tc on tb.id = tc.id) as bc on ta.id = tb.id;
select * from ta left join (tb left join tc on tb.id = tc.id) as bc on ta.id = tc.id;
```
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

**pg版本**：
1.需要把列名改改，否则会出问题，比如还按上面的列名和结构，执行到下面这里就发现执行不下去了。。。
```sql
d1=# select * from ta left join tb on ta.id = tb.id left join tc on ta.id = tc.id;
 id | ida | id | idb | id | idc
----+-----+----+-----+----+------
  1 |  11 |  1 | 111 |  1 | 1111
  1 |  11 |  1 | 111 |  1 | 1111
  1 |  11 |  1 | 111 |  1 | 1111
  1 |  11 |  1 | 111 |  1 | 1111
  2 |  22 |  2 | 222 |  2 | 2222
  2 |  22 |  2 | 222 |  2 | 2222
  2 |  22 |  2 | 222 |  2 | 2222
  2 |  22 |  2 | 222 |  2 | 2222
  3 |  33 |    |     |  3 | 3333
(9 rows)

d1=# select * from ta left join (tb left join tc on tb.id = tc.id) as bc on ta.id = bc.id;
ERROR:  column reference "id" is ambiguous
LINE 1: ...n (tb left join tc on tb.id = tc.id) as bc on ta.id = bc.id;
                                                                 ^
d1=# select * from ta left join (tb left join tc on tb.id = tc.id) as bc on ta.id = tb.id;
ERROR:  invalid reference to FROM-clause entry for table "tb"
LINE 1: ...n (tb left join tc on tb.id = tc.id) as bc on ta.id = tb.id;
                                                                 ^
HINT:  There is an entry for table "tb", but it cannot be referenced from this part of the query.
```

2.修改下列名，避免重复：
```sql
create table ta (ida int, agea int);
create table tb (idb int, ageb int);
create table tc (idc int, agec int);
insert into ta values (1,11), (2,22), (3,33);
insert into tb values (1,111), (1,111), (2,222), (2,222);
insert into tc values (1,1111), (1,1111), (2,2222), (2,2222), (3,3333);
select * from ta;
select * from tb;
select * from tc;
select * from ta left join tb on ta.ida = tb.idb left join tc on ta.ida = tc.idc;
select * from ta left join (tb left join tc on tb.idb = tc.idc) as bc on ta.ida = bc.idb;
select * from ta left join (tb left join tc on tb.idb = tc.idc) as bc on ta.ida = bc.idc;
-- 这个不行： select * from ta left join (tb left join tc on tb.idb = tc.idc) as bc on ta.ida = tb.idb;
select * from ta left join (tb full outer join tc on tb.idb = tc.idc) as bc on ta.ida = bc.idc;
```
```sql
d1=# select * from ta;
 ida | agea
-----+------
   1 |   11
   2 |   22
   3 |   33
(3 rows)

d1=# select * from tb;
 idb | ageb
-----+------
   1 |  111
   1 |  111
   2 |  222
   2 |  222
(4 rows)

d1=# select * from tc;
 idc | agec
-----+------
   1 | 1111
   1 | 1111
   2 | 2222
   2 | 2222
   3 | 3333
(5 rows)

-- 最基本的形式：三表连续用两个 left join
d1=# select * from ta left join tb on ta.ida = tb.idb left join tc on ta.ida = tc.idc;
 ida | agea | idb | ageb | idc | agec
-----+------+-----+------+-----+------
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   3 |   33 |     |      |   3 | 3333
(9 rows)

-- ！！！但是在基本形式中，如果换一下最后的join key，结果不太一样了：
d1=# select * from ta left join tb on ta.ida = tb.idb left join tc on tb.idb = tc.idc;
 ida | agea | idb | ageb | idc | agec
-----+------+-----+------+-----+------
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   3 |   33 |     |      |     |
(9 rows)

-- 先做后面那个 left join，然后 join key 可能多种情况
d1=# select * from ta left join (tb left join tc on tb.idb = tc.idc) as bc on ta.ida = bc.idb;
 ida | agea | idb | ageb | idc | agec
-----+------+-----+------+-----+------
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   3 |   33 |     |      |     |
(9 rows)

d1=# select * from ta left join (tb left join tc on tb.idb = tc.idc) as bc on ta.ida = bc.idc;
 ida | agea | idb | ageb | idc | agec
-----+------+-----+------+-----+------
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   3 |   33 |     |      |     |
(9 rows)

-- 不能用 tb 的 idb （或者 tc 的 idc）当 key 了（也就是只能用 bc 里的列当 join key 了）。
d1=# select * from ta left join (tb left join tc on tb.idb = tc.idc) as bc on ta.ida = tb.idb;
ERROR:  invalid reference to FROM-clause entry for table "tb"
LINE 1: ...b left join tc on tb.idb = tc.idc) as bc on ta.ida = tb.idb;
                                                                ^
HINT:  There is an entry for table "tb", but it cannot be referenced from this part of the query.
d1=#

-- 把后面那个 left join 换成 full outer join 看起来是可以的似乎
d1=# select * from ta left join (tb full outer join tc on tb.idb = tc.idc) as bc on ta.ida = bc.idc;
 ida | agea | idb | ageb | idc | agec
-----+------+-----+------+-----+------
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   1 |   11 |   1 |  111 |   1 | 1111
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   2 |   22 |   2 |  222 |   2 | 2222
   3 |   33 |     |      |   3 | 3333
(9 rows)
```

3.试试更一般的情况：
```sql
create table ta (ida int, namea text);
create table tb (idb int, nameb text);
create table tc (idc int, namec text);
insert into ta values (100,'a'), (110,'ab'), (101,'ac'), (111,'abc');
insert into ta values (100,'a'), (110,'ab'), (101,'ac'), (111,'abc');
insert into tb values (10,'b'), (110,'ba'), (11,'bc'), (111,'bac');
insert into tb values (10,'b'), (110,'ba'), (11,'bc'), (111,'bac');
insert into tc values (1,'c'), (101,'ca'), (11,'cb'), (111,'cab');
insert into tc values (1,'c'), (101,'ca'), (11,'cb'), (111,'cab');
select * from ta;
select * from tb;
select * from tc;
select * from ta left join tb on ta.ida = tb.idb left join tc on ta.ida = tc.idc;
select * from ta left join (tb full outer join tc on tb.idb = tc.idc) as bc on ta.ida = bc.idb;
select * from ta left join (tb full outer join tc on tb.idb = tc.idc) as bc on ta.ida = bc.idc;
select * from ta left join (tb full outer join tc on tb.idb = tc.idc) as bc on ta.ida in (bc.idb, bc.idc);
```
```sql
d1=# select * from ta left join tb on ta.ida = tb.idb left join tc on ta.ida = tc.idc;
 ida | namea | idb | nameb | idc | namec
-----+-------+-----+-------+-----+-------
 100 | a     |     |       |     |
 100 | a     |     |       |     |
 101 | ac    |     |       | 101 | ca
 101 | ac    |     |       | 101 | ca
 101 | ac    |     |       | 101 | ca
 101 | ac    |     |       | 101 | ca
 110 | ab    | 110 | ba    |     |
 110 | ab    | 110 | ba    |     |
 110 | ab    | 110 | ba    |     |
 110 | ab    | 110 | ba    |     |
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
(18 rows)

d1=# select * from ta left join (tb full outer join tc on tb.idb = tc.idc) as bc on ta.ida = bc.idc;
 ida | namea | idb | nameb | idc | namec
-----+-------+-----+-------+-----+-------
 100 | a     |     |       |     |
 100 | a     |     |       |     |
 101 | ac    |     |       | 101 | ca
 101 | ac    |     |       | 101 | ca
 101 | ac    |     |       | 101 | ca
 101 | ac    |     |       | 101 | ca
 110 | ab    |     |       |     |
 110 | ab    |     |       |     |
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
(16 rows)

d1=# select * from ta left join (tb full outer join tc on tb.idb = tc.idc) as bc on ta.ida = bc.idb;
 ida | namea | idb | nameb | idc | namec
-----+-------+-----+-------+-----+-------
 100 | a     |     |       |     |
 100 | a     |     |       |     |
 101 | ac    |     |       |     |
 101 | ac    |     |       |     |
 110 | ab    | 110 | ba    |     |
 110 | ab    | 110 | ba    |     |
 110 | ab    | 110 | ba    |     |
 110 | ab    | 110 | ba    |     |
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
(16 rows)

-- 只有这样才能符合顺序做 left join 的语义，两个 key 都得用，并且是 or 的关系。
-- SQL: join with OR in condition https://stackoverflow.com/questions/39206937/sql-join-with-or-in-condition
d1=# select * from ta left join (tb full outer join tc on tb.idb = tc.idc) as bc on ta.ida in (bc.idb, bc.idc);
 ida | namea | idb | nameb | idc | namec
-----+-------+-----+-------+-----+-------
 100 | a     |     |       |     |
 110 | ab    | 110 | ba    |     |
 110 | ab    | 110 | ba    |     |
 101 | ac    |     |       | 101 | ca
 101 | ac    |     |       | 101 | ca
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 100 | a     |     |       |     |
 110 | ab    | 110 | ba    |     |
 110 | ab    | 110 | ba    |     |
 101 | ac    |     |       | 101 | ca
 101 | ac    |     |       | 101 | ca
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
 111 | abc   | 111 | bac   | 111 | cab
(18 rows)
```
