
# 1

Postgresql 编写自定义 C 函数 https://zhmin.github.io/posts/postgresql-c-function/

## 个人实战

**添加简单加法函数**：
```sh
[pguser@a603a469073b postgres]$ mkdir newfunc
[pguser@a603a469073b postgres]$ cd newfunc/
cat << EOF > my_add_func.c
#include "postgres.h"
#include "fmgr.h"
PG_MODULE_MAGIC;
PG_FUNCTION_INFO_V1(my_add_func);
Datum my_add_func(PG_FUNCTION_ARGS)
{
    int32 a = PG_GETARG_INT32(0);
    int32 b = PG_GETARG_INT32(1);
    int64 result = a + b;
    PG_RETURN_INT64(result);
}
EOF
[pguser@a603a469073b newfunc]$ gcc -fPIC my_add_func.c -I`pg_config --includedir-server` -shared -o my_add_func.so
[pguser@a603a469073b newfunc]$ ls
gmon.out  my_add_func.c  my_add_func.so
```
```sql
postgres=# CREATE FUNCTION my_add(a integer, b integer) RETURNS integer
postgres-#      AS '/home/pguser/pgdir/postgres/newfunc/my_add_func.so', 'my_add_func' LANGUAGE C STRICT;
CREATE FUNCTION
postgres=#
postgres=# select my_add(1, 2);
 my_add
--------
      3
(1 row)

postgres=#
```

**添加处理行数据的函数**：
```sh
cat << EOF > my_tuple_func.c
#include "postgres.h"
#include "funcapi.h"
PG_MODULE_MAGIC;
PG_FUNCTION_INFO_V1(my_tuple_func);
Datum my_tuple_func(PG_FUNCTION_ARGS)
{
    // 第一个参数为复合类型
	HeapTupleHeader tuple = PG_GETARG_HEAPTUPLEHEADER(0);
	
	// 取出返回数据的类型，由TupleDesc表示
	TupleDesc tupdesc;
	if (get_call_result_type(fcinfo, NULL, &tupdesc) != TYPEFUNC_COMPOSITE)
		elog(ERROR, "return type must be a row type");

	// 构建返回值
	Datum values[2];
	values[0] = PointerGetDatum(cstring_to_text("hello"));
	values[1] = Int32GetDatum(1);
    // nulls 数组表示值是否为空
	bool nulls[2];
	memset(nulls, 0, sizeof(nulls));
	// 构建返回数据，由HeapTuple表示
	HeapTuple result = heap_form_tuple(tupdesc, values, nulls);
	PG_RETURN_DATUM(HeapTupleGetDatum(result));
}
EOF
[pguser@a603a469073b newfunc]$ gcc -fPIC my_tuple_func.c -I`pg_config --includedir-server` -shared -o my_tuple_func.so
[pguser@a603a469073b newfunc]$ ls
gmon.out  my_add_func.c  my_add_func.so  my_tuple_func.c  my_tuple_func.so
```
```sql
postgres=# CREATE FUNCTION my_tuple_func(tuple record) RETURNS TABLE (message text ,num int) AS '/home/pguser/pgdir/postgres/newfunc/my_tuple_func', 'my_tuple_func' LANGUAGE C STRICT;
CREATE FUNCTION
postgres=#
postgres=# \d+ t1
                                     Table "public.t1"
 Column |  Type   | Collation | Nullable | Default | Storage  | Stats target | Description
--------+---------+-----------+----------+---------+----------+--------------+-------------
 id     | integer |           |          |         | plain    |              |
 name   | text    |           |          |         | extended |              |
Access method: heap

postgres=#
postgres=# select * from t1;
 id | name
----+-------
  1 | alice
  2 | bob
(2 rows)

postgres=#
postgres=# select my_tuple_func(t1) from t1;;
 my_tuple_func
---------------
 (hello,1)
 (hello,1)
(2 rows)

postgres=# select my_tuple_func(t1) from t1 where id = 1;
 my_tuple_func
---------------
 (hello,1)
(1 row)

postgres=#
postgres=# select (my_tuple_func(t1)).* from t1 where id = 1;
 message | num
---------+-----
 hello   |   1
(1 row)

postgres=#
```
