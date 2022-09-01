
# 1

Postgresql 编写自定义 C 函数 https://zhmin.github.io/posts/postgresql-c-function/

## 个人实战

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
