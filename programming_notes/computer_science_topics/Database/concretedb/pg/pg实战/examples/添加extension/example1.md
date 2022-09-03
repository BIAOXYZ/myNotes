
>> 注：这种（通过扩展的方式）和直接通过加载自己编译的动态库来加载函数的方式（比如[这里](../加载动态库方式添加函数/example1.md)）实质其实是类似的，只是用扩展的方式更系统化一些，能做的事也更多些（比如还能在加载扩展的时候建表）。

# 1

## 参考文章

PostgreSQL 扩展Extension 简单小实例 https://blog.csdn.net/liguangxianbin/article/details/79865747 || https://www.giserdqy.com/database/postgresql/25169/
- >  PostgreSQL被设计为易于扩展. PostgreSQL引入了一种方式来安装contrib模块，称为扩展（extensions）。此方法适用于所有使用扩展规范构建的contrib模块，包括如下：
  * > 扩展SQL文件（ extension_name.sql ）
  * > 扩展控制文件 （ extension_name.control ）
  * > 扩展库文件（extension_name.so）

## 实战过程

```sh
[pguser@a603a469073b postgres]$ cd contrib/
[pguser@a603a469073b contrib]$ mkdir test && cd test/
```

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
# 修改一下 contrib/ 目录下的代码库里本身的 Makefile。
[pguser@a603a469073b test]$ cd ../..
[pguser@a603a469073b postgres]$ vi contrib/Makefile
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
PostgreSQL 扩展开发基础教程 http://joshuais.me/postgresql-extension-develop/ || https://github.com/nxy105/my-new-blog/blob/gh-pages/_posts/2017-04-20-postgresql-extension-develop.md
- > **开发扩展**
  * > **我们要开发什么**
    + > 我们打算在这个扩展中支持一个新的函数，用于为给定的数组中插入元素。如果插入的元素已经存在数组中，则不再重复插入，否则插入到数组的末尾。设计的函数如下：`jsonb array_ext_append(jsonb arr, int elm)`。这是我们扩展函数中最简单的一个，用于基础的教程再合适不过。
  * > **编写代码**
    + > 接下来，我们开始编写 `jsonb array_ext_append(jsonb arr, int elm)` 函数的实现代码。
      ```c
      #include "postgres.h"
      #include "fmgr.h"
      #include "utils/jsonb.h"

      PG_MODULE_MAGIC;

      JsonbValue *IteratorAppend(JsonbIterator **, Numeric, JsonbParseState **);

      PG_FUNCTION_INFO_V1(array_ext_append);

      Datum
      array_ext_append(PG_FUNCTION_ARGS)
      {
          Numeric     elm;
          Jsonb       *arr = NULL;
          JsonbValue  *res = NULL;
          JsonbIterator   *it;
          JsonbParseState *st = NULL;

          arr = PG_GETARG_JSONB(0);
          elm = PG_GETARG_NUMERIC(1);

          it = JsonbIteratorInit(&arr->root);
          res = IteratorAppend(&it, elm, &st);

          PG_RETURN_JSONB(JsonbValueToJsonb(res));
      }

      JsonbValue *
      IteratorAppend(JsonbIterator **it, Numeric value, JsonbParseState  **state)
      {
          uint32          r, rk;
          bool            t;
          JsonbValue      v, *res = NULL;
          t = true;
          r = rk = JsonbIteratorNext(it, &v, false);
          if (rk == WJB_BEGIN_ARRAY) {
              res = pushJsonbValue(state, r, NULL);
              for(;;) {
                  r = JsonbIteratorNext(it, &v, true);
                  if (r == WJB_END_OBJECT || r == WJB_END_ARRAY)
                      break;

                  if (strcmp(numeric_normalize(v.val.numeric), numeric_normalize(value)) == 0) {
                      t = false;
                  }
                  pushJsonbValue(state, r, &v);
              }

              if (t) {
                  v.type = jbvNumeric;
                  v.val.numeric = value;
                  pushJsonbValue(state, WJB_ELEM, &v);
              }
              res = pushJsonbValue(state, WJB_END_ARRAY, NULL);
          }
          return res;
      }
      ```
  * > 我将完整的代码摘录下来，方便大家参考和测试。我选择部分重要的代码一一说明。
    + > `#include "postgres.h"` 包含 PostgreSQL 基础的接口。这是开发 PostgreSQL 扩展必需包含的头文件。
    + > `#include "fmgr.h"` 包含了 `PG_GETARG_XX` 和 `PG_RETURN_XX` 等获取参数和返回结果的重要的宏，基本上是必需的。
    + > `PG_MODULE_MAGIC` 是一个从 PostgreSQL 8.2版本后就必须的宏，必须写在 `#include "fmgr.h"` 之后。
    + > `PG_FUNCTION_INFO_V1` 宏声明了我们所定义的函数为 Version-1 约定的函数。我们选择了 Version-1 的开发约定，所以在定义方法之前，需要调用 `PG_FUNCTION_INFO_V1(array_ext_append)` 宏对函数声明。对 Version-1 有兴趣的同学可以移步 [Version 1 Calling Conventions](https://www.postgresql.org/docs/9.4/static/xfunc-c.html#AEN55804) 查看详情。
    + > ***`Datum` 等同于 `void *`，表示函数返回任意类型的数据***。
    + > `arr = PG_GETARG_JSONB(0);` 获取函数的第一个参数的值，并且将其转换为 `jsonb` 类型。
    + > `PG_RETURN_JSONB(JsonbValueToJsonb(res));` 将结果转换为 `jsonb` 类型并返回。
- > **测试**
  * > 我们为 PostgreSQL 扩展开发开了一个不错的头，但接下来持续的开发将会面对一个问题：如何快速的回归测试。这里，我介绍一个简单的回归测试的方法：`make installcheck`。

Postgresql扩展Sql-添加插件 https://gangzai.online/2018/08/30/database/Postgresql%E6%89%A9%E5%B1%95Sql-%E6%B7%BB%E5%8A%A0%E6%8F%92%E4%BB%B6/
- > PostgreSQL 支持使用 `PL/pgSQL` 语言或者原生的C语言开发扩展。`PL/pgSQL` 开发简单，然而性能上较原生的C语言要逊色不少。有不少人已经做过相关的性能测试，这里就不再重复说明。我们开发的扩展的目的是为了增强生产的 PostgreSQL，自然要选择性能更好的C语言。
- > **插件更新**
- > **补充**
  * > 插件是通过动态库形式引入到内核中。和内核在同一个进程中运行，且没有内存保护，影响内核的稳定性。开发中需要特别注意内存的使用。不要造成内存泄露或越界写。建议使用 PostgreSQL 的内存管理机制，插件中也能使用。
  * > 内核中被标记成 `PGDLLIMPORT` 的全局变量都能在插件中直接使用，这些通常是一些 `GUC` 参数。
  * > 内核中非 `static` 的函数也能在插件中使用，只需要先 `extern` 它们。
  * > 我们可以实现 `_PG_init` 用于实现一些初始化工作，该函数在连接建立后只会被执行一次。
  * > 我们可以在 `_PG_init` 中使用函数 `DefineCustom*Variable` 定义对应插件相关的 `GUC` 参数，他们可以用于开启和关闭该插件的一些功能。
  * > 插件的参数需要以插件名开头且加上点，例如 `oss_fdw.enable_parallel_read`。
