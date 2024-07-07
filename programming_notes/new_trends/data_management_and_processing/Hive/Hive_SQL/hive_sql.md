
30分钟入门 Hive SQL（HQL 入门篇） - 钟林子钰的文章 - 知乎 https://zhuanlan.zhihu.com/p/195836631
- > **2.5 窗口函数**
  * > 其它更丰富的窗口函数，我这不赘述，篇幅太大，完全可以重开一篇新的文章。建议参考阿里云 MaxCompute 的这份「[窗口函数](https://help.aliyun.com/zh/maxcompute/user-guide/window-functions-1)」的文档，写得非常详细，强烈推荐！

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# hive sql 语法

## Lateral View explode

LanguageManual LateralView https://cwiki.apache.org/confluence/display/hive/languagemanual+lateralview
- > Lateral View Syntax
  ```sql
  lateralView: LATERAL VIEW udtf(expression) tableAlias AS columnAlias (',' columnAlias)*
  fromClause: FROM baseTable (lateralView)*
  ```

【Hive】split()、explode()、lateral view用法和区别 https://blog.csdn.net/qq_32727095/article/details/120367400

Hive SQL语法Explode 和 Lateral View https://www.cnblogs.com/pandaly/p/16397215.html
```console
我们有这样的一份样本数据:
刘德华    演员,导演,制片人 
李小龙    演员,导演,制片人,幕后,武术指导 
李连杰    演员,武术指导 
刘亦菲    演员 

这里我们希望转换成下面这样的格式:
刘德华 演员 
刘德华 导演 
刘德华 制片人 
李小龙 演员 
李小龙 导演 
李小龙 制片人 
李小龙 幕后 
李小龙 武术指导 
```

Hive列转行 (Lateral View + explode)详解 - 考研大魔王的文章 - 知乎 https://zhuanlan.zhihu.com/p/115913870

### 个人实战

```sql
CREATE TABLE Students (ID INT, Name STRING, Hobbies ARRAY<STRING>) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

INSERT INTO Students VALUES (1, 'John', array('Reading', 'Swimming')), (2, 'Mary', array('Dancing', 'Singing')), (3, 'David', array('Football', 'Basketball'));

SELECT s.ID, s.Name, h.hobby FROM Students s LATERAL VIEW explode(s.Hobbies) h AS hobby;

SELECT ID, Name, hobby FROM Students s LATERAL VIEW explode(s.Hobbies) h AS hobby;
```
```sql
-- 结论就是 LATERAL VIEW 这个的结构【 LATERAL VIEW udtf(expression) tableAlias AS columnAlias (',' columnAlias)* 】非常固定：
--- 1. 试着在 tableAlias 前加个 as ；或者去掉 tableAlias。都是不行的。
0: jdbc:hive2://localhost:10000/> SELECT ID, Name, hobby FROM Students s LATERAL VIEW explode(s.Hobbies) h AS hobby;
INFO  : Compiling command(queryId=hive_20240428092628_0adda7de-5ab2-49b7-8824-f49bd2cfa6da): SELECT ID, Name, hobby FROM Students s LATERAL VIEW explode(s.Hobbies) h AS hobby
INFO  : Semantic Analysis Completed (retrial = false)
INFO  : Created Hive schema: Schema(fieldSchemas:[FieldSchema(name:id, type:int, comment:null), FieldSchema(name:name, type:string, comment:null), FieldSchema(name:hobby, type:string, comment:null)], properties:null)
INFO  : Completed compiling command(queryId=hive_20240428092628_0adda7de-5ab2-49b7-8824-f49bd2cfa6da); Time taken: 0.042 seconds
INFO  : Concurrency mode is disabled, not creating a lock manager
INFO  : Executing command(queryId=hive_20240428092628_0adda7de-5ab2-49b7-8824-f49bd2cfa6da): SELECT ID, Name, hobby FROM Students s LATERAL VIEW explode(s.Hobbies) h AS hobby
INFO  : Completed executing command(queryId=hive_20240428092628_0adda7de-5ab2-49b7-8824-f49bd2cfa6da); Time taken: 0.001 seconds
+-----+--------+-------------+
| id  |  name  |    hobby    |
+-----+--------+-------------+
| 1   | John   | Reading     |
| 1   | John   | Swimming    |
| 2   | Mary   | Dancing     |
| 2   | Mary   | Singing     |
| 3   | David  | Football    |
| 3   | David  | Basketball  |
+-----+--------+-------------+
6 rows selected (0.069 seconds)
0: jdbc:hive2://localhost:10000/>
0: jdbc:hive2://localhost:10000/> SELECT ID, Name, hobby FROM Students s LATERAL VIEW explode(s.Hobbies) as h AS hobby;
Error: Error while compiling statement: FAILED: ParseException line 1:71 cannot recognize input near 'as' 'h' 'AS' in table alias (state=42000,code=40000)
0: jdbc:hive2://localhost:10000/>
0: jdbc:hive2://localhost:10000/> SELECT ID, Name, hobby FROM Students s LATERAL VIEW explode(s.Hobbies) AS hobby;
Error: Error while compiling statement: FAILED: ParseException line 1:71 cannot recognize input near 'AS' 'hobby' '<EOF>' in table alias (state=42000,code=40000)
0: jdbc:hive2://localhost:10000/>

--- 2. 试着把 columnAlias 前的 as 去掉；或者去掉 as + columnAlias；甚至去掉得只剩 explode() 结尾。同样都不行。
0: jdbc:hive2://localhost:10000/> SELECT ID, Name, hobby FROM Students s LATERAL VIEW explode(s.Hobbies) h AS hobby;
INFO  : Compiling command(queryId=hive_20240428092743_ae8d4f7f-68c8-47c0-9b27-9f821e5e1cf0): SELECT ID, Name, hobby FROM Students s LATERAL VIEW explode(s.Hobbies) h AS hobby
INFO  : Semantic Analysis Completed (retrial = false)
INFO  : Created Hive schema: Schema(fieldSchemas:[FieldSchema(name:id, type:int, comment:null), FieldSchema(name:name, type:string, comment:null), FieldSchema(name:hobby, type:string, comment:null)], properties:null)
INFO  : Completed compiling command(queryId=hive_20240428092743_ae8d4f7f-68c8-47c0-9b27-9f821e5e1cf0); Time taken: 0.03 seconds
INFO  : Concurrency mode is disabled, not creating a lock manager
INFO  : Executing command(queryId=hive_20240428092743_ae8d4f7f-68c8-47c0-9b27-9f821e5e1cf0): SELECT ID, Name, hobby FROM Students s LATERAL VIEW explode(s.Hobbies) h AS hobby
INFO  : Completed executing command(queryId=hive_20240428092743_ae8d4f7f-68c8-47c0-9b27-9f821e5e1cf0); Time taken: 0.0 seconds
+-----+--------+-------------+
| id  |  name  |    hobby    |
+-----+--------+-------------+
| 1   | John   | Reading     |
| 1   | John   | Swimming    |
| 2   | Mary   | Dancing     |
| 2   | Mary   | Singing     |
| 3   | David  | Football    |
| 3   | David  | Basketball  |
+-----+--------+-------------+
6 rows selected (0.052 seconds)
0: jdbc:hive2://localhost:10000/>
0: jdbc:hive2://localhost:10000/> SELECT ID, Name, hobby FROM Students s LATERAL VIEW explode(s.Hobbies) h hobby;
Error: Error while compiling statement: FAILED: ParseException line 1:73 extraneous input 'hobby' expecting EOF near '<EOF>' (state=42000,code=40000)
0: jdbc:hive2://localhost:10000/>
0: jdbc:hive2://localhost:10000/> SELECT ID, Name, hobby FROM Students s LATERAL VIEW explode(s.Hobbies) h;
Error: Error while compiling statement: FAILED: SemanticException [Error 10004]: Line 1:17 Invalid table alias or column reference 'hobby': (possible column names are: s.id, s.name, s.hobbies, h.col) (state=42000,code=10004)
0: jdbc:hive2://localhost:10000/>
0: jdbc:hive2://localhost:10000/> SELECT ID, Name, hobby FROM Students s LATERAL VIEW explode(s.Hobbies);
Error: Error while compiling statement: FAILED: ParseException line 1:70 cannot recognize input near '<EOF>' '<EOF>' '<EOF>' in table alias (state=42000,code=40000)
0: jdbc:hive2://localhost:10000/>
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 分区表

### 单个分区的例子

```sql
-- 本来非分区表，五个列都在表名后面的括号里；如果是分区表，分区列反而不能出现在那个括号里了，需要独立到 partitioned by 后面的括号里。
create table input_ap (uid int, val int, t int, diag varchar(255)) partitioned by (time1 int);
insert into input_ap values (44969473, 2, 1, 'hd', 23);
insert into input_ap values (1234182, 77, 1, 'aids', 24);
insert into input_ap values (30274561, 1, 2, 'hd', 17);
insert into input_ap values (56520193, 12, 2, 'hd', 29);
insert into input_ap values (11262273, 8, 1, 'aids', 25);
```

```sql
-- 从这里虽然也能看出来分区列，但是不知道多个分区列时会怎么样；另外也不清楚 api 方式调用时返回值时什么样
0: jdbc:hive2://localhost:10000/> show partitions input_ap;
+------------+
| partition  |
+------------+
| time1=17   |
| time1=23   |
| time1=24   |
| time1=25   |
| time1=29   |
+------------+

-- 这个本来是获取所有列的语句，但是意外发现会单独显示下分区列——不过用 api 方式调用时好像不会？
0: jdbc:hive2://localhost:10000/> describe input_ap;
+--------------------------+---------------+----------+
|         col_name         |   data_type   | comment  |
+--------------------------+---------------+----------+
| uid                      | int           |          |
| val                      | int           |          |
| t                        | int           |          |
| diag                     | varchar(255)  |          |
| time1                    | int           |          |
|                          | NULL          | NULL     |
| # Partition Information  | NULL          | NULL     |
| # col_name               | data_type     | comment  |
| time1                    | int           |          |
+--------------------------+---------------+----------+
```

## 两个分区的例子

```sql
CREATE TABLE input_a_partition (uid INT, val INT, t INT, diag VARCHAR(255)) PARTITIONED BY (date STRING, hour INT);

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
insert into input_a_partition values 
  (1, 100, 10, 'diagnosis1', '20240707', 10),
  (2, 200, 20, 'diagnosis2', '20240707', 10),
  (3, 150, 15, 'diagnosis3', '20240708', 10),
  (4, 250, 25, 'diagnosis4', '20240708', 10),
  (5, 300, 30, 'diagnosis5', '20240708', 11),
  (6, 350, 35, 'diagnosis6', '20240708', 11),
  (7, 400, 40, 'diagnosis7', '20240709', 10),
  (8, 450, 45, 'diagnosis8', '20240709', 10),
  (9, 500, 50, 'diagnosis9', '20240709', 11),
  (10, 550, 55, 'diagnosis10', '20240709', 11),
  (11, 600, 60, 'diagnosis11', '20240709', 12),
  (12, 650, 65, 'diagnosis12', '20240709', 12),
  (13, 700, 70, 'diagnosis13', '20240709', 13),
  (14, 750, 75, 'diagnosis14', '20240709', 13);
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# hive sql 问题

## hive sql 叹号表示否定

```sql
0: jdbc:hive2://localhost:10000/> select * from input_a where val > 10 and !(val % 2 = 1);
INFO  : Compiling command(queryId=hive_20240423084153_0e321172-34fc-41ab-afcb-0bc1d036ad50): select * from input_a where val > 10 and !(val % 2 = 1)
INFO  : Semantic Analysis Completed (retrial = false)
INFO  : Created Hive schema: Schema(fieldSchemas:[FieldSchema(name:input_a.uid, type:int, comment:null), FieldSchema(name:input_a.val, type:int, comment:null), FieldSchema(name:input_a.t, type:int, comment:null), FieldSchema(name:input_a.diag, type:varchar(255), comment:null), FieldSchema(name:input_a.time1, type:int, comment:null)], properties:null)
INFO  : Completed compiling command(queryId=hive_20240423084153_0e321172-34fc-41ab-afcb-0bc1d036ad50); Time taken: 0.164 seconds
INFO  : Concurrency mode is disabled, not creating a lock manager
INFO  : Executing command(queryId=hive_20240423084153_0e321172-34fc-41ab-afcb-0bc1d036ad50): select * from input_a where val > 10 and !(val % 2 = 1)
INFO  : Completed executing command(queryId=hive_20240423084153_0e321172-34fc-41ab-afcb-0bc1d036ad50); Time taken: 0.0 seconds
+--------------+--------------+------------+---------------+----------------+
| input_a.uid  | input_a.val  | input_a.t  | input_a.diag  | input_a.time1  |
+--------------+--------------+------------+---------------+----------------+
| 56520193     | 12           | 2          | hd            | 29             |
+--------------+--------------+------------+---------------+----------------+
1 row selected (0.188 seconds)
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## hive sql 中使用绑定变量

How to set variables in HIVE scripts https://stackoverflow.com/questions/12464636/how-to-set-variables-in-hive-scripts

```sql
-- 仅用 set 设置的变量（也就是这里的 modulus）是不行的：
0: jdbc:hive2://localhost:10000/> set modulus=10; select * from input_a where val > '${modulus}';
No rows affected (0.009 seconds)
INFO  : Compiling command(queryId=hive_20240424120938_d55c0082-e596-4195-89a0-1002aa295fce): select * from input_a where val > '${modulus}'
INFO  : Semantic Analysis Completed (retrial = false)
INFO  : Created Hive schema: Schema(fieldSchemas:[FieldSchema(name:input_a.uid, type:int, comment:null), FieldSchema(name:input_a.val, type:int, comment:null), FieldSchema(name:input_a.t, type:int, comment:null), FieldSchema(name:input_a.diag, type:varchar(255), comment:null), FieldSchema(name:input_a.time1, type:int, comment:null)], properties:null)
INFO  : Completed compiling command(queryId=hive_20240424120938_d55c0082-e596-4195-89a0-1002aa295fce); Time taken: 0.119 seconds
INFO  : Concurrency mode is disabled, not creating a lock manager
INFO  : Executing command(queryId=hive_20240424120938_d55c0082-e596-4195-89a0-1002aa295fce): select * from input_a where val > '${modulus}'
INFO  : Completed executing command(queryId=hive_20240424120938_d55c0082-e596-4195-89a0-1002aa295fce); Time taken: 0.0 seconds
+--------------+--------------+------------+---------------+----------------+
| input_a.uid  | input_a.val  | input_a.t  | input_a.diag  | input_a.time1  |
+--------------+--------------+------------+---------------+----------------+
+--------------+--------------+------------+---------------+----------------+
No rows selected (0.135 seconds)
0: jdbc:hive2://localhost:10000/>

-- 必须带上 hiveconf 前缀才可以：
0: jdbc:hive2://localhost:10000/> set modulus=10; select * from input_a where val > '${hiveconf:modulus}';
No rows affected (0.009 seconds)
INFO  : Compiling command(queryId=hive_20240424121246_b82e6539-86fd-4522-827a-b338a533aafc): select * from input_a where val > '10'
INFO  : Semantic Analysis Completed (retrial = false)
INFO  : Created Hive schema: Schema(fieldSchemas:[FieldSchema(name:input_a.uid, type:int, comment:null), FieldSchema(name:input_a.val, type:int, comment:null), FieldSchema(name:input_a.t, type:int, comment:null), FieldSchema(name:input_a.diag, type:varchar(255), comment:null), FieldSchema(name:input_a.time1, type:int, comment:null)], properties:null)
INFO  : Completed compiling command(queryId=hive_20240424121246_b82e6539-86fd-4522-827a-b338a533aafc); Time taken: 0.176 seconds
INFO  : Concurrency mode is disabled, not creating a lock manager
INFO  : Executing command(queryId=hive_20240424121246_b82e6539-86fd-4522-827a-b338a533aafc): select * from input_a where val > '10'
INFO  : Completed executing command(queryId=hive_20240424121246_b82e6539-86fd-4522-827a-b338a533aafc); Time taken: 0.0 seconds
+--------------+--------------+------------+---------------+----------------+
| input_a.uid  | input_a.val  | input_a.t  | input_a.diag  | input_a.time1  |
+--------------+--------------+------------+---------------+----------------+
| 1234182      | 77           | 1          | aids          | 24             |
| 56520193     | 12           | 2          | hd            | 29             |
+--------------+--------------+------------+---------------+----------------+
2 rows selected (0.2 seconds)
0: jdbc:hive2://localhost:10000/>
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
