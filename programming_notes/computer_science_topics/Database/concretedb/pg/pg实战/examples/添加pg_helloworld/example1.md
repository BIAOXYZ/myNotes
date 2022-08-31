
# `REL8_4_STABLE`
- postgresql内核开发之HelloWorld入门 https://blog.csdn.net/postgres20/article/details/53366995
- 如何向pg内核中添加函数 https://blog.csdn.net/chunchengli0734/article/details/101024616

```sh
ri_triggers.c:256:12: warning: variable 'old_row' set but not used [-Wunused-but-set-variable]
  HeapTuple old_row;
            ^
utils/fmgrtab.o:(.rodata+0x16638): undefined reference to `_null_'
collect2: error: ld returned 1 exit status
make[2]: *** [postgres] Error 1
make[1]: *** [all] Error 2
make: *** [all] Error 2
[pguser@a603a469073b postgres]$
```

看起来是生成的 ***`src/backend/utils/fmgrtab.c`*** 里的函数名字有些问题，本来 Oid `9999` 那行函数名字应该是 `"helloworld"` 的，不知道为什么变成了 `"_null_"`。看了下生产这个文件的脚本 ***`src/backend/utils/Gen_fmgrtab.sh`***，一时没有细看下去，回头再说吧。
```c
  { 3774, "regdictionarysend", 1, true, false, regdictionarysend },
  { 9999, "_null_", 0, false, false, _null_ },
  /* dummy entry is easier than getting rid of comma after last real one */
  /* (not that there has ever been anything wrong with *having* a
     comma after the last field in an array initializer) */
  { 0, NULL, 0, false, false, NULL }
};
```

# `REL_12_STABLE` (`12.12`，也就是有 `src/include/catalog/pg_proc.dat` 的情形)

## 参考文章
- PostgreSQL如何添加内核函数 https://mp.weixin.qq.com/s/0MxZXiororNBZLNxACR2ug || https://www.modb.pro/db/104291

```sh
[pguser@a603a469073b postgres]$ psql -d postgres
psql (12.12)
Type "help" for help.

postgres=# select pg_helloworld();
2022-08-30 17:53:23.550 UTC [1490116] ERROR:  function pg_helloworld() does not exist at character 8
2022-08-30 17:53:23.550 UTC [1490116] HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
2022-08-30 17:53:23.550 UTC [1490116] STATEMENT:  select pg_helloworld();
ERROR:  function pg_helloworld() does not exist
LINE 1: select pg_helloworld();
               ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
postgres=#
```

```diff
[pguser@a603a469073b postgres]$ git diff
diff --git a/src/backend/utils/adt/pseudotypes.c b/src/backend/utils/adt/pseudotypes.c
index 5c886cf..acbccb4 100644
--- a/src/backend/utils/adt/pseudotypes.c
+++ b/src/backend/utils/adt/pseudotypes.c
@@ -29,6 +29,16 @@


 /*
+* pg_helloworld -- function to show 'Hello PostgreSQL!'
+*/
+Datum
+pg_helloworld(PG_FUNCTION_ARGS)
+{
+    char str[] = "Hello PostgreSQL!";
+    PG_RETURN_TEXT_P(cstring_to_text(str));
+}
+
+/*
  * cstring_in          - input routine for pseudo-type CSTRING.
  *
  * We might as well allow this to support constructs like "foo_in('blah')".
diff --git a/src/include/catalog/pg_proc.dat b/src/include/catalog/pg_proc.dat
index d352f9a..cf548ba 100644
--- a/src/include/catalog/pg_proc.dat
+++ b/src/include/catalog/pg_proc.dat
@@ -10676,4 +10676,8 @@
   proname => 'pg_partition_root', prorettype => 'regclass',
   proargtypes => 'regclass', prosrc => 'pg_partition_root' },

+{ oid => '9999', descr => 'Hello PostgreSQL',
+  proname => 'pg_helloworld', prorettype => 'text',
+  proargtypes => '', prosrc => 'pg_helloworld' },
+
 ]
[pguser@a603a469073b postgres]$
```

```sh
[pguser@a603a469073b postgres]$ make install
[pguser@a603a469073b pgdir]$ pg_ctl stop -D $PGDATA
[pguser@a603a469073b pgdir]$ rm -rf $PGDATA
[pguser@a603a469073b pgdir]$ initdb -D $PGDATA
[pguser@a603a469073b pgdir]$ pg_ctl start -D $PGDATA
[pguser@a603a469073b pgdir]$ psql -d postgres
psql (12.12)
Type "help" for help.

postgres=# select pg_helloworld();
   pg_helloworld
-------------------
 Hello PostgreSQL!
(1 row)

postgres=#
postgres=# \q
[pguser@a603a469073b pgdir]$
```
