
# 1

预编译SQL为什么能够防止SQL注入 https://www.cnblogs.com/Createsequence/p/16963891.html
- > 二、JDBC的预编译
  * > 2、虚假的“预编译”
    + > 现在答案就很明显了，转义在 preparedStatement.setString 方法调用的时候完成，而 PreparedStatement 在发起请求前就把转义后的参数和 SQL 模板进行了格式化，最后发送到 MySQL 的时候就是一条普通的 SQL。
  * > 3、真正的预编译
    + > 好吧，那既然 MySQL 提供了这个预编译的功能，***那通过 JDBC 肯定也还是有办法用上真正的预编译功能的，实际上要做到这点也很简单，就是直接在`驱动的 url` 上配上 `useServerPrepStmts=true`***，这样就会真正的启用 MySQL 的预编译功能。
- > 三、Myabtis占位符与预编译
  * > 至此问题真相大白了，不过还是顺带扯一下八股文常提到的 Mybatis 占位符 `#{}` 与 `${}` 是如何影响 SQL 注入问题的。
  * > 当然，看完上面的内容其实就已经很好猜到原因了：
    ```console
    #{} 对应的内容会作为 SQL 参数的一部分通过 PreparedStatement.setXXX 装入请求；
    ${} 对应的内容会直接作为 SQL 模板的一部分，而不会视为独立的请求参数；
    ```
  * > 这就是 Mybatis 用 `#{}` 而不是 `${}` 可以防止 SQL 注入的真相。

预编译语句(Prepared Statements)介绍，以MySQL为例 https://www.cnblogs.com/micrari/p/7112781.html

## 个人实战
```sql
MariaDB [ppsql]> select * from books;
+------+-------+
| isbn | price |
+------+-------+
|    1 |    10 |
|    2 |    20 |
|    3 |    30 |
|    4 |    40 |
+------+-------+
4 rows in set (0.001 sec)
```

```sql
----- 基本使用（只绑定值）以及取消prepare的语句。

MariaDB [ppsql]> prepare query from 'select * from books where isbn = ?';
Query OK, 0 rows affected (0.000 sec)
Statement prepared

MariaDB [ppsql]> set @no = '1';
Query OK, 0 rows affected (0.000 sec)

MariaDB [ppsql]> execute query using @no;
+------+-------+
| isbn | price |
+------+-------+
|    1 |    10 |
+------+-------+
1 row in set (0.000 sec)

MariaDB [ppsql]> set @no = '2';
Query OK, 0 rows affected (0.000 sec)

MariaDB [ppsql]> execute query using @no;
+------+-------+
| isbn | price |
+------+-------+
|    2 |    20 |
+------+-------+
1 row in set (0.001 sec)

MariaDB [ppsql]> deallocate prepare query;
Query OK, 0 rows affected (0.000 sec)

MariaDB [ppsql]> execute query using @no;
ERROR 1243 (HY000): Unknown prepared statement handler (query) given to EXECUTE
MariaDB [ppsql]>
```

```sql
----- 表名必须明确指定，否则报错。

-- 看起来不绑定表是不行的：最直观的原因，表都不知道，后面的 isbn 列如何能知道潜在的表里有没有呢？
MariaDB [ppsql]> prepare query from 'select * from ? where isbn = ?';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '? where isbn = ?' at line 1

-- 更进一步，即使不涉及某个具体的列，只涉及表也是不行的。
MariaDB [ppsql]> prepare query from 'select * from ?';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '?' at line 1
```

```sql
----- 不指定列名的话倒是也能查，但是其实就是简单的文本替换？

MariaDB [ppsql]> prepare query from 'select ? from books';
Query OK, 0 rows affected (0.000 sec)
Statement prepared

MariaDB [ppsql]> set @column_name = 'price';
Query OK, 0 rows affected (0.000 sec)

MariaDB [ppsql]> execute query using @column_name;
+-------+
| ?     |
+-------+
| price |
| price |
| price |
| price |
+-------+
4 rows in set (0.001 sec)

----- 再多指定一个能用的（值类型），也就是过滤了下
MariaDB [ppsql]> prepare query from 'select ? from books where isbn = ?';
Query OK, 0 rows affected (0.000 sec)
Statement prepared

MariaDB [ppsql]> set @column_name = 'price';
Query OK, 0 rows affected (0.000 sec)

MariaDB [ppsql]> set @isbn_value = 3;
Query OK, 0 rows affected (0.000 sec)

MariaDB [ppsql]> execute query using @column_name, @isbn_value;
+-------+
| ?     |
+-------+
| price |
+-------+
1 row in set (0.000 sec) 
```
```sql
----- PS：如果实在想后面再指定列名，可以用动态 SQL。但是就没有预编译语句的性能优势了。


-- 设置列名和 ISBN
SET @column_name = 'price';
SET @isbn_value = 3;
-- 构建动态 SQL 查询
SET @query = CONCAT('SELECT ', @column_name, ' FROM books WHERE isbn = ?');
-- 准备语句
PREPARE stmt FROM @query;
-- 执行准备好的语句
EXECUTE stmt USING @isbn_value;
-- 释放准备的语句
DEALLOCATE PREPARE stmt;


MariaDB [ppsql]> -- 设置列名和 ISBN
MariaDB [ppsql]> SET @column_name = 'price';
Query OK, 0 rows affected (0.000 sec)

MariaDB [ppsql]> SET @isbn_value = 3;
Query OK, 0 rows affected (0.000 sec)

MariaDB [ppsql]>
MariaDB [ppsql]> -- 构建动态 SQL 查询
MariaDB [ppsql]> SET @query = CONCAT('SELECT ', @column_name, ' FROM books WHERE isbn = ?');
Query OK, 0 rows affected (0.000 sec)

MariaDB [ppsql]>
MariaDB [ppsql]> -- 准备语句
MariaDB [ppsql]> PREPARE stmt FROM @query;
Query OK, 0 rows affected (0.000 sec)
Statement prepared

MariaDB [ppsql]>
MariaDB [ppsql]> -- 执行准备好的语句
MariaDB [ppsql]> EXECUTE stmt USING @isbn_value;
+-------+
| price |
+-------+
|    30 |
+-------+
1 row in set (0.001 sec)

MariaDB [ppsql]>
MariaDB [ppsql]> -- 释放准备的语句
MariaDB [ppsql]> DEALLOCATE PREPARE stmt;
Query OK, 0 rows affected (0.000 sec)
```


