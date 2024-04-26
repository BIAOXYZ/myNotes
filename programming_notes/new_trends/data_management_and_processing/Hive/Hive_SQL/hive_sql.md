
# hive sql 语法

## Lateral View explode

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
