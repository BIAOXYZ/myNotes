
# ClickHouse

## 条件函数 https://clickhouse.com/docs/zh/sql-reference/functions/conditional-functions/
>> //notes：官方文档就给说明了，没给建表语句，这些是我自己搞的。
>>> 如果创建表时的列的 int 不带 Nullable 的话，在这个例子里默认值会是 0，就和官方文档的例子不完全一致了。

```sql
DROP table if exists left_right;
create table left_right (left Nullable(int), right Nullable(int)) ENGINE = TinyLog;
insert into left_right (right) values (4);
insert into left_right values (1,3);
insert into left_right values (2,2);
insert into left_right values (3,1);
insert into left_right (left) values (4);

SELECT * from left_right;

SELECT 
left, right, if(left < right, 'left is smaller than right', 'right is greater or equal than left') AS is_smaller
FROM left_right
WHERE isNotNull(left) AND isNotNull(right);
```

PS：又发现了 ClickHouse 和 PG 不一样的地方：**表名是区分大小写的**。。。
```console
f79c4f8c4201 :) select * from left_right;

SELECT *
FROM left_right

Query id: 922a6e31-9a29-44f5-a736-d5d5cc36a909

┌─left─┬─right─┐
│ ᴺᵁᴸᴸ │     4 │
│    1 │     3 │
│    2 │     2 │
│    3 │     1 │
│    4 │  ᴺᵁᴸᴸ │
└──────┴───────┘

5 rows in set. Elapsed: 0.003 sec. 

f79c4f8c4201 :) 
f79c4f8c4201 :) select * from LEFT_RIGHT;

SELECT *
FROM LEFT_RIGHT

Query id: 3eae87be-d437-4fe7-bc94-9eb41246ecfa


0 rows in set. Elapsed: 0.002 sec. 

Received exception from server (version 22.1.3):
Code: 60. DB::Exception: Received from clickhouse-server:9000. DB::Exception: Table default.LEFT_RIGHT doesn't exist. (UNKNOWN_TABLE)

f79c4f8c4201 :) 
f79c4f8c4201 :) SELECT 
                left, right, if(left < right, 'left is smaller than right', 'right is greater or equal than left') AS is_smaller
                FROM left_right
                WHERE isNotNull(left) AND isNotNull(right);

SELECT
    left,
    right,
    if(left < right, 'left is smaller than right', 'right is greater or equal than left') AS is_smaller
FROM left_right
WHERE (left IS NOT NULL) AND (right IS NOT NULL)

Query id: 68ff99bf-7327-425a-841f-ee8aca5a2437

┌─left─┬─right─┬─is_smaller──────────────────────────┐
│    1 │     3 │ left is smaller than right          │
│    2 │     2 │ right is greater or equal than left │
│    3 │     1 │ right is greater or equal than left │
└──────┴───────┴─────────────────────────────────────┘

3 rows in set. Elapsed: 0.003 sec. 

f79c4f8c4201 :) 
```
