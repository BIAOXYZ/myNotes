
# 1

## 参考文章
- PostgreSQL 扩展Extension 简单小实例 https://blog.csdn.net/liguangxianbin/article/details/79865747 || https://www.giserdqy.com/database/postgresql/25169/

## 实战过程

```sh
cat << EOF > Makefile
# contrib/test/Makefile

MODULES = test

EXTENSION = test

DATA = test--1.0.sql

ifdef USE_PGXS
PG_CONFIG = pg_config
PGXS := \$(shell \$(PG_CONFIG) --pgxs)
include \$(PGXS)
else
subdir = contrib/test
top_builddir = ../..
include \$(top_builddir)/src/Makefile.global
include \$(top_srcdir)/contrib/contrib-global.mk
endif
EOF
```

```sh
# 这里的注释写错了，create extension 时的扩展名是 test，而不是 test_table，更不是 test_tabble。。。
cat << EOF > test--1.0.sql
/* contrib/test/test--1.0.sql */
 
--complain if script is sourced in psql rather than via ALTER EXTENSION
\echo Use "CRAETE EXTENSION test_tabble" to load this file. \quit
CREATE TABLE test_table(oid integer,namespace_oid integer,name text,time timestamp);   /* 创建一个表格 */

CREATE FUNCTION test_add_fun(integer,integer)     /* 创建一个函数 */
RETURNS integer
AS 'MODULE_PATHNAME' , 'test_add_fun'
LANGUAGE C STRICT PARALLEL RESTRICTED;
EOF
```

```sh
# 这部分 C 代码里 #ifdef 总觉得用得怪怪的（一般都是直接一行 PG_MODULE_MAGIC; 就可以了）。
# 但是偏偏能 work（我改成 #ifndef 也还能work；我三行全注释掉也能 work。。。），先不管了就。
cat << EOF > test.c
#include "postgres.h"
#include "fmgr.h"

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

PG_FUNCTION_INFO_V1(test_add_fun);
Datum test_add_fun(PG_FUNCTION_ARGS);
Datum test_add_fun(PG_FUNCTION_ARGS)
{
	int sum ,a,b;
	a=PG_GETARG_INT32(0);
	b=PG_GETARG_INT32(1);
	sum = a + b;
	PG_RETURN_INT32(sum);
}
EOF
```

```sh
# 这里开始时自作聪明改了一下： module_pathname = '\$PGHOME/lib/test'
# 后来 create extension 时候就会报错：
# ERROR:  invalid macro name in dynamic library path: $PGHOME/lib/test
# 于是才知道不应该改那一行的。。。可能 $libdir 是中间过程中 pg 自己生成的吧，回头查查。
cat << EOF > test.control
# test extension
comment = 'only test publication'
default_version = '1.0'
module_pathname = '\$libdir/test'
relocatable = true
EOF
```

```sh
[pguser@a603a469073b test]$ ls
Makefile  test--1.0.sql  test.c  test.control
```

```diff
[pguser@a603a469073b postgres]$ git diff
diff --git a/contrib/Makefile b/contrib/Makefile
index 92184ed..524459d 100644
--- a/contrib/Makefile
+++ b/contrib/Makefile
@@ -48,7 +48,8 @@ SUBDIRS = \
                tsm_system_rows \
                tsm_system_time \
                unaccent        \
-               vacuumlo
+               vacuumlo        \
+               test
 
 ifeq ($(with_openssl),yes)
 SUBDIRS += sslinfo
[pguser@a603a469073b postgres]$ 
```

```sh
[pguser@a603a469073b test]$ make
make -C ../../src/backend generated-headers
make[1]: Entering directory `/home/pguser/pgdir/postgres/src/backend'
make -C catalog distprep generated-header-symlinks
make[2]: Entering directory `/home/pguser/pgdir/postgres/src/backend/catalog'
make[2]: Nothing to be done for `distprep'.
make[2]: Nothing to be done for `generated-header-symlinks'.
make[2]: Leaving directory `/home/pguser/pgdir/postgres/src/backend/catalog'
make -C utils distprep generated-header-symlinks
make[2]: Entering directory `/home/pguser/pgdir/postgres/src/backend/utils'
make[2]: Nothing to be done for `distprep'.
make[2]: Nothing to be done for `generated-header-symlinks'.
make[2]: Leaving directory `/home/pguser/pgdir/postgres/src/backend/utils'
make[1]: Leaving directory `/home/pguser/pgdir/postgres/src/backend'
gcc -std=gnu99 -Wall -Wmissing-prototypes -Wpointer-arith -Wdeclaration-after-statement -Werror=vla -Wendif-labels -Wmissing-format-attribute -Wformat-security -fno-strict-aliasing -fwrapv -fexcess-precision=standard -g -pg -DLINUX_PROFILE -O0 -fPIC -I. -I. -I../../src/include  -D_GNU_SOURCE   -c -o test.o test.c
gcc -std=gnu99 -Wall -Wmissing-prototypes -Wpointer-arith -Wdeclaration-after-statement -Werror=vla -Wendif-labels -Wmissing-format-attribute -Wformat-security -fno-strict-aliasing -fwrapv -fexcess-precision=standard -g -pg -DLINUX_PROFILE -O0 -fPIC test.o -L../../src/port -L../../src/common   -Wl,--as-needed -Wl,-rpath,'/home/pguser/pgdir/pgsql/lib',--enable-new-dtags  -shared -o test.so
[pguser@a603a469073b test]$
[pguser@a603a469073b test]$ ls
Makefile  test--1.0.sql  test.c  test.control  test.o  test.so
[pguser@a603a469073b test]$
[pguser@a603a469073b test]$ make install
make -C ../../src/backend generated-headers
make[1]: Entering directory `/home/pguser/pgdir/postgres/src/backend'
make -C catalog distprep generated-header-symlinks
make[2]: Entering directory `/home/pguser/pgdir/postgres/src/backend/catalog'
make[2]: Nothing to be done for `distprep'.
make[2]: Nothing to be done for `generated-header-symlinks'.
make[2]: Leaving directory `/home/pguser/pgdir/postgres/src/backend/catalog'
make -C utils distprep generated-header-symlinks
make[2]: Entering directory `/home/pguser/pgdir/postgres/src/backend/utils'
make[2]: Nothing to be done for `distprep'.
make[2]: Nothing to be done for `generated-header-symlinks'.
make[2]: Leaving directory `/home/pguser/pgdir/postgres/src/backend/utils'
make[1]: Leaving directory `/home/pguser/pgdir/postgres/src/backend'
/bin/mkdir -p '/home/pguser/pgdir/pgsql/share/extension'
/bin/mkdir -p '/home/pguser/pgdir/pgsql/share/extension'
/bin/mkdir -p '/home/pguser/pgdir/pgsql/lib'
/bin/install -c -m 644 ./test.control '/home/pguser/pgdir/pgsql/share/extension/'
/bin/install -c -m 644 ./test--1.0.sql  '/home/pguser/pgdir/pgsql/share/extension/'
/bin/install -c -m 755  test.so '/home/pguser/pgdir/pgsql/lib/'
[pguser@a603a469073b test]$
```

```sql
postgres=# \d test_table
Did not find any relation named "test_table".
postgres=# \sf test_add_fun
ERROR:  function "test_add_fun" does not exist
postgres=# 
-- 注意：无需重启 postgres 服务端，甚至连 psql 客户端都不用断开连接。
postgres=# create extension test;
CREATE EXTENSION
postgres=# \d test_table
                          Table "public.test_table"
    Column     |            Type             | Collation | Nullable | Default 
---------------+-----------------------------+-----------+----------+---------
 oid           | integer                     |           |          | 
 namespace_oid | integer                     |           |          | 
 name          | text                        |           |          | 
 time          | timestamp without time zone |           |          | 

postgres=# \sf test_add_fun
CREATE OR REPLACE FUNCTION public.test_add_fun(integer, integer)
 RETURNS integer
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/test', $function$test_add_fun$function$
postgres=# select test_add_fun(2,3);
 test_add_fun 
--------------
            5
(1 row)

postgres=# 
```

```sql
-- drop extension 后是连扩展里创建的表也会删掉的。
postgres=# drop extension test;
DROP EXTENSION
postgres=# 
postgres=# select test_add_fun(2,3);
ERROR:  function test_add_fun(integer, integer) does not exist
LINE 1: select test_add_fun(2,3);
               ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
postgres=# 
postgres=# \d test_table
Did not find any relation named "test_table".
postgres=# 
postgres=# \sf test_add_fun
ERROR:  function "test_add_fun" does not exist
postgres=# 
```

## 其他参考文章
- PostgreSQL 扩展开发基础教程 http://joshuais.me/postgresql-extension-develop/ || https://github.com/nxy105/my-new-blog/blob/gh-pages/_posts/2017-04-20-postgresql-extension-develop.md
- Postgresql扩展Sql-添加插件 https://gangzai.online/2018/08/30/database/Postgresql%E6%89%A9%E5%B1%95Sql-%E6%B7%BB%E5%8A%A0%E6%8F%92%E4%BB%B6/
