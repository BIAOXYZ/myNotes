
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
>> 【[:star:][`*`]】 //notes：额外试了下如何调试这个函数，也比较直观：
1. 编译动态库的时候加上 `-g`。在本例子中即为：
   ```sh
   gcc -fPIC my_tuple_func.c -I`pg_config --includedir-server` -shared -o my_tuple_func.so -g
   ```
2. create function 语句不变。
3. gdb attach 上进程之后断点直接打到函数上，即：
   ```sh
   (gdb) b my_tuple_func
   Breakpoint 1 at 0x7fa9d98929ab: file my_tuple_func.c, line 8.
   (gdb) c
   Continuing.

   ```
4. 然后执行一个带这个函数的查询，就能看到在断点停住了，代码也出来了，可以开始单不调试了。
   ```sql
   postgres=# select (my_tuple_func(t1)).* from t1;

   ```
   ```sh
   Breakpoint 1, my_tuple_func (fcinfo=0x2848748) at my_tuple_func.c:8
   (gdb) bt
   #0  my_tuple_func (fcinfo=0x2848748) at my_tuple_func.c:8
   #1  0x0000000000700596 in ExecMakeFunctionResultSet (fcache=0x28481a0, econtext=0x28474b8, argContext=0x28510a0, isNull=0x28480f0, isDone=0x2848180) at execSRF.c:614
   #2  0x000000000072fe36 in ExecProjectSRF (node=0x28473a0, continuing=false) at nodeProjectSet.c:175
   #3  0x000000000072fce7 in ExecProjectSet (pstate=0x28473a0) at nodeProjectSet.c:105
   #4  0x00000000006fd085 in ExecProcNodeFirst (node=0x28473a0) at execProcnode.c:445
   #5  0x00000000006f1ffd in ExecProcNode (node=0x28473a0) at ../../../src/include/executor/executor.h:242
   #6  0x00000000006f482b in ExecutePlan (estate=0x2847148, planstate=0x28473a0, use_parallel_mode=false, operation=CMD_SELECT, sendTuples=true, numberTuples=0, direction=ForwardScanDirection, dest=0x2888f20, execute_once=true) at execMain.c:1632
   #7  0x00000000006f2632 in standard_ExecutorRun (queryDesc=0x2884ad8, direction=ForwardScanDirection, count=0, execute_once=true) at execMain.c:350
   #8  0x00000000006f2463 in ExecutorRun (queryDesc=0x2884ad8, direction=ForwardScanDirection, count=0, execute_once=true) at execMain.c:294
   #9  0x00000000008fa429 in PortalRunSelect (portal=0x27d1ca8, forward=true, count=0, dest=0x2888f20) at pquery.c:938
   #10 0x00000000008fa0c6 in PortalRun (portal=0x27d1ca8, count=9223372036854775807, isTopLevel=true, run_once=true, dest=0x2888f20, altdest=0x2888f20, completionTag=0x7fff9da5e8f0 "") at pquery.c:779
   #11 0x00000000008f40fc in exec_simple_query (query_string=0x276bcd8 "select my_tuple_func(t1) from t1;") at postgres.c:1214
   #12 0x00000000008f836e in PostgresMain (argc=1, argv=0x2795e48, dbname=0x2795c80 "postgres", username=0x2769ab8 "pguser") at postgres.c:4281
   #13 0x000000000084aef7 in BackendRun (port=0x278dbb0) at postmaster.c:4510
   #14 0x000000000084a6ae in BackendStartup (port=0x278dbb0) at postmaster.c:4193
   #15 0x0000000000846a52 in ServerLoop () at postmaster.c:1725
   #16 0x0000000000846303 in PostmasterMain (argc=3, argv=0x2767a10) at postmaster.c:1398
   #17 0x0000000000763625 in main (argc=3, argv=0x2767a10) at main.c:228
   (gdb)
   ```
