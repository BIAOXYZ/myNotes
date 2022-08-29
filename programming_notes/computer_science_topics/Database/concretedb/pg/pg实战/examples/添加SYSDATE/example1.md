
# 1 添加 `SYSDATE` 关键词/函数

## 1.1 参考文章
- `【1】` postgresql内核开发之 SYSDATE实现 https://blog.csdn.net/postgres20/article/details/53427406
- `【2】` PostgreSQL 保留关键字添加方法之一，不带参数的函数 https://blog.csdn.net/veryhappypig/article/details/21639371
- 文章 `【1】`的步骤更详细，但是在 `src/backend/parser/gram.y` 文件里的 `c_expr` 部分下添加的代码不对（应该就是不同版本的原因）；文章 `【2】`的步骤比较模糊，但是那一处代码基本对了（还是需要注释掉一行，不过无关痛痒了）。

## 1.2 步骤（版本为 `REL8_4_STABLE`，OS 为 Docker 官方的 CentOS 7 镜像）

- > 1.增加一个关键字 `sysdate`，postgresql关键字声明在 `\src\include\parser\kwlist.h` 中，增加一行 `SYSDATE` 的关键字声明：
  ```c
  PG_KEYWORD("sysdate", SYSDATE, RESERVED_KEYWORD)
  ```
  > ***注意增加位置要严格按字符串排序***，加到 `sysid` 和 `symmetric` 之间，否则检查将不能通过。这里的第一个（`sysdate`)是关键字，第二个值（`SYSDATE`）是枚举值，由 `gram.y` 中token定，第三个值（`RESERVED_KEYWORD`）是声名是否为保留字。  
- > 2.在 `src/backend/parser/gram.y` 中增加语法逻辑。先声名关键字对应的token, 最终会转化成上面对应的枚举值，在 `%token <keyword>` 中增加 `SYSDATE`，***这个可以不排序，但最好放到S开头的地方***，如下图： <br> ![](https://img-blog.csdn.net/20161202203159566)
- > 3.接下来增加将 `sysdate` 和 `now()` 对应的关键代码。在 `c_expr:` 中增加如下代码，
  >> 【[:star:][`*`]】 //notes：至少在 pg 8.4 版本，这个代码不对，用下面 diff 里的代码吧。
  ```yacc
  | SYSDATE
      {
          $$ = (Node *) makeFuncCall(list_make1(makeString("now")), NIL, @1);
      }
  ```
  > 如下图： <br> ![](https://img-blog.csdn.net/20161201234108960)
- > 4.最后在 `reserved_keyword:` 增加 `| SYSDATE`，注意，***这个必须严格排序***，加在 `SYMMETRIC`  和 `TABLE` 之间： <br> ![](https://img-blog.csdn.net/20161201234127163)

## 1.3 过程记录
>> //notes：记得修改完编译过之后要 `make install` 重新装一下。。。好久没改 pg 了，一时没想起来，还以为出了什么奇怪的问题。

```sh
# 修改前
[pguser@a603a469073b pgdir]$ psql -d postgres
psql (8.4.22)
Type "help" for help.

postgres=# select sysdate;
ERROR:  column "sysdate" does not exist at character 8
STATEMENT:  select sysdate;
ERROR:  column "sysdate" does not exist
LINE 1: select sysdate;
               ^
postgres=# \q
```

```diff
[pguser@a603a469073b postgres]$ git diff
diff --git a/src/backend/parser/gram.y b/src/backend/parser/gram.y
index c05a19b..a68d549 100644
--- a/src/backend/parser/gram.y
+++ b/src/backend/parser/gram.y
@@ -490,7 +490,7 @@ static TypeName *TableFuncTypeName(List *columns);
        SERIALIZABLE SERVER SESSION SESSION_USER SET SETOF SHARE
        SHOW SIMILAR SIMPLE SMALLINT SOME STABLE STANDALONE_P START STATEMENT
        STATISTICS STDIN STDOUT STORAGE STRICT_P STRIP_P SUBSTRING SUPERUSER_P
-       SYMMETRIC SYSID SYSTEM_P
+       SYMMETRIC SYSID SYSTEM_P SYSDATE

        TABLE TABLESPACE TEMP TEMPLATE TEMPORARY TEXT_P THEN TIME TIMESTAMP
        TO TRAILING TRANSACTION TREAT TRIGGER TRIM TRUE_P
@@ -8703,6 +8703,20 @@ c_expr:          columnref                                                               { $$ = $1; }
                                        else
                                                $$ = (Node *) p;
                                }
+                       | SYSDATE
+                               {
+                                       // $$ = (Node *) makeFuncCall(list_make1(makeString("now")), NIL, @1);
+                                       FuncCall *n = makeNode(FuncCall);
+                                       n->funcname = SystemFuncName("now");
+                                       n->args = NIL;
+                                       //n->agg_order = NIL;
+                                       n->agg_star = FALSE;
+                                       n->agg_distinct = FALSE;
+                                       n->func_variadic = FALSE;
+                                       n->over = NULL;
+                                       n->location = @1;
+                                       $$ = (Node *)n;
+                               }
                        | '(' a_expr ')' opt_indirection
                                {
                                        if ($4)
@@ -10571,6 +10585,7 @@ reserved_keyword:
                        | SESSION_USER
                        | SOME
                        | SYMMETRIC
+                       | SYSDATE
                        | TABLE
                        | THEN
                        | TO
diff --git a/src/include/parser/kwlist.h b/src/include/parser/kwlist.h
index 23f5d87..3c6d9c6 100644
--- a/src/include/parser/kwlist.h
+++ b/src/include/parser/kwlist.h
@@ -353,6 +353,7 @@ PG_KEYWORD("strip", STRIP_P, UNRESERVED_KEYWORD)
 PG_KEYWORD("substring", SUBSTRING, COL_NAME_KEYWORD)
 PG_KEYWORD("superuser", SUPERUSER_P, UNRESERVED_KEYWORD)
 PG_KEYWORD("symmetric", SYMMETRIC, RESERVED_KEYWORD)
+PG_KEYWORD("sysdate", SYSDATE, RESERVED_KEYWORD)
 PG_KEYWORD("sysid", SYSID, UNRESERVED_KEYWORD)
 PG_KEYWORD("system", SYSTEM_P, UNRESERVED_KEYWORD)
 PG_KEYWORD("table", TABLE, RESERVED_KEYWORD)
[pguser@a603a469073b postgres]$
```

```sh
# 修改后：
# （傻了，之前先是改完代码没编译；后来想起来编译了一下，但是编译完把数据库文件所在的目录删了，又重新 initdb，发现还是不行。）
# （后来才反应过来————不应该是要 make install 替换新编译好的 postgres 程序吗，删数据库文件目录有啥用- -）
[pguser@a603a469073b postgres]$ make install
[pguser@a603a469073b pgdir]$ pg_ctl restart -D $PGDATA
[pguser@a603a469073b pgdir]$ psql -d postgres
psql (8.4.22)
Type "help" for help.

postgres=# select sysdate;
              now
-------------------------------
 2022-08-29 13:41:25.268999+00
(1 row)

postgres=#
```
