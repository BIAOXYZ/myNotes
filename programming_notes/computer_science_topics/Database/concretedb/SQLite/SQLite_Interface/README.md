
# C/C++

An Introduction To The SQLite C/C++ Interface https://www.sqlite.org/cintro.html

C-language Interface Specification for SQLite https://sqlite.org/c3ref/intro.html
- List Of Objects: https://sqlite.org/c3ref/objlist.html
- List Of Constants: https://sqlite.org/c3ref/constlist.html
- List Of Functions: https://sqlite.org/c3ref/funclist.html

C++ with SQLite3: Part 5: Encapsulating Database Objects https://videlais.com/2018/12/14/c-with-sqlite3-part-5-encapsulating-database-objects/

SQLite C https://zetcode.com/db/sqlitec/

How to read data from SQLite database? https://stackoverflow.com/questions/3957343/how-to-read-data-from-sqlite-database

谈一谈sqlite这种小型数据库（1） https://www.cnblogs.com/bwbfight/p/9306293.html
- > 三、参数绑定：
  * > 和大多数关系型数据库一样，SQLite的SQL文本也支持变量绑定，以便减少SQL语句被动态 解析的次数，从而提高数据查询和数据操作的效率。要完成该操作，我们需要使用SQLite提 供的另外两个接口APIs，`sqlite3_reset`和`sqlite3_bind`。

C++之Sqlite3 https://segmentfault.com/a/1190000021141956

## `sqlite3_bind()`

How does binding parameters work in SQLite3 (with minimal example)? https://stackoverflow.com/questions/31806336/how-does-binding-parameters-work-in-sqlite3-with-minimal-example

sqlite3：sqlite3_bind 函数 https://blog.csdn.net/u012351051/article/details/90644067
- > 常用的sqlite3_bind函数：
  ```c
  int sqlite3_bind_int(sqlite3_stmt*, int, int);
  int sqlite3_bind_doubule(sqlite3_stmt*, int, double);
  int sqlite3_bind_text(sqlite3_stmt*, int, const char*, int, void(*)(void*));
  参数：
      sqlite3_stmt: 准备语句变量指针。
      第2个形参： sqlite3_stmt变量参数的序号索引值，规定最左侧的SQL参数的索引值为 1，也就是说参数索引值从1开始。
      第3个形参： 是要绑定给第2个形参指向的 变量参数的 实际值。第2个形参可以指向不同的索引值。
      第4个形参： 对于有4个形参的函数，第4个形参一般是第3个形参的长度。
      第5个形参： 是用于BLOB和字符串绑定后的 析构函数，用于在sqlite处理完blob或字符串之后处理它，一般可以设置为NULL。
  ```

## uint64 支持

unsigned 64 bit value in sqlite with c bindings https://stackoverflow.com/questions/52535100/unsigned-64-bit-value-in-sqlite-with-c-bindings

让sqlite支持uint64 https://blog.csdn.net/henysugar/article/details/83038928

在SQLite数据库中存储64位无符号整数，既有趣又有益 https://juejin.cn/post/7114625032919203848
- Storing 64-bit unsigned integers in SQLite databases, for fun and profit http://ivory.idyll.org/blog/2022-storing-ulong-in-sqlite-sourmash.html

【[:star:][`*`]】 SQLite, 64-bit integers, and the impossible number http://jakegoulding.com/blog/2011/02/06/sqlite-64-bit-integers/
- > We recently tackled an issue that seemed rather impossible – an unsigned 64-bit value was greater than the maximum value that a 64-bit value can hold. What unfolded was a dark, gritty look at the underbelly of everything we hold dear (or a normal debugging session, as we like to call them).
- > First off, lets create a table with some big numbers:
  ```sql
  CREATE TABLE big_numbers (i INTEGER, r REAL, t TEXT, b BLOB);
  INSERT INTO big_numbers VALUES (9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807); -- 2^63 - 1
  INSERT INTO big_numbers VALUES (9223372036854775808, 9223372036854775808, 9223372036854775808, 9223372036854775808); -- 2^63
  ```
- > Let’s sanity check our data to make sure it looks like what we would expect:
  ```sql
  > SELECT * FROM big_numbers;
  i                     r                     t                     b
  --------------------  --------------------  --------------------  --------------------
  9223372036854775807   9.22337203685478e+18  9223372036854775807   9223372036854775807
  9.22337203685478e+18  9.22337203685478e+18  9.22337203685478e+18  9.22337203685478e+18
  ```
- > Huh. We definitely were not expecting most of those floating point numbers, so let’s see what types are being returned:
  ```sql
  > SELECT typeof(i),typeof(r),typeof(t),typeof(b) FROM big_numbers;
  typeof(i)   typeof(r)   typeof(t)   typeof(b)
  ----------  ----------  ----------  ----------
  integer     real        text        integer
  real        real        text        real
  ```
- > Sure enough, the numeric types in the second row are all reals. Let’s do a nice simple addition operation on our data:
  ```sql
  > SELECT i+1,r+1,t+1,b+1 FROM big_numbers;
  i+1                   r+1                   t+1                   b+1
  --------------------  --------------------  --------------------  --------------------
  -9223372036854775808  9.22337203685478e+18  -9223372036854775808  -9223372036854775808
  9.22337203685478e+18  9.22337203685478e+18  9.22337203685478e+18  9.22337203685478e+18
  ```
- > Woah, what happened here? Those familiar with signed and unsigned integers are already nodding and going “Mmm-hmm”. For everyone else, I suggest brushing up on [two’s compliment](http://en.wikipedia.org/wiki/Two's_complement) notation. Suffice it to say that integers are usually represented by a fixed number of bits, and once you run out of bits you roll over back to the beginning, in this case a large negative number.
- > As it turns out, SQLite is pretty straight-forward about this. From the [datatype reference](http://www.sqlite.org/datatype3.html) in SQLite (emphasis mine): `INTEGER. The value is a signed integer, stored in 1, 2, 3, 4, 6, or 8 bytes depending on the magnitude of the value.`
- > That is, you can only store values from `-2**63` to (`2**63-1`). What does SQLite do for a value outside of this range? As we saw earlier, it switches over into floating point. Again, quoting from the SQLite reference: `REAL. The value is a floating point value, stored as an 8-byte IEEE floating point number.`
- > Many programmers are familiar with this type under the name [double](http://en.wikipedia.org/wiki/Double_precision_floating-point_format).

How to read Int64 values from sqlite database? https://stackoverflow.com/questions/17858652/how-to-read-int64-values-from-sqlite-database
- https://stackoverflow.com/questions/17858652/how-to-read-int64-values-from-sqlite-database/17860562#17860562

## 其他接口

How do I check in SQLite whether a database exists C# https://stackoverflow.com/questions/21159790/how-do-i-check-in-sqlite-whether-a-database-exists-c-sharp

How do I check if a table exists in sqlite3 c++ API? [duplicate] https://stackoverflow.com/questions/3499295/how-do-i-check-if-a-table-exists-in-sqlite3-c-api
- https://stackoverflow.com/questions/3499295/how-do-i-check-if-a-table-exists-in-sqlite3-c-api/3501527#3501527
  * > Variation on another given answer:
    ```sql
    select count(type) from sqlite_master where type='table' and name='TABLE_NAME_TO_CHECK';
    ```
    > Will return 0 if table does not exist, 1 if it does.
  * 个人小实战（主要是为了说明sqlite对表名的大小写处理有点魔幻。。。虽然也能想通其中的道理：毕竟一个是直接用 `Cars/cars`，一个是把这两个放到引号里用 `'Cars'`/`'cars'`）：
    ```sql
    sqlite> .tables
    COMPANY  Cars   
    sqlite> 
    sqlite> select count(type) from sqlite_master where type = 'table' and name = 'Cars';
    1
    sqlite> 
    sqlite> select count(type) from sqlite_master where type = 'table' and name = 'cars';
    0
    sqlite> 
    sqlite> select count(*) from Cars;
    5
    sqlite> select count(*) from cars;
    5
    sqlite> 
    ```

How do I check in SQLite whether a table exists? https://stackoverflow.com/questions/1601151/how-do-i-check-in-sqlite-whether-a-table-exists
- https://stackoverflow.com/questions/1601151/how-do-i-check-in-sqlite-whether-a-table-exists/1601172#1601172
  * > See [(7) How do I list all tables/indices contained in an SQLite database](http://sqlite.org/faq.html#q7) in the SQLite FAQ:
    ```sql
    SELECT name FROM sqlite_master
    WHERE type='table'
    ORDER BY name;
    ```
- https://stackoverflow.com/questions/1601151/how-do-i-check-in-sqlite-whether-a-table-exists/1604121#1604121

How to count number of columns in a table in SQLITE? https://stackoverflow.com/questions/4301320/how-to-count-number-of-columns-in-a-table-in-sqlite

# C++

SQLiteC++ https://github.com/SRombauts/SQLiteCpp || http://srombauts.github.io/SQLiteCpp/

基于sqlitecpp的sqlite3 c++封装 https://www.cnblogs.com/pandamohist/p/13457499.html

# Python

sqlite3 --- SQLite 数据库 DB-API 2.0 接口模块 https://docs.python.org/zh-cn/3/library/sqlite3.html

解决Python3 No module named '_sqlite3'错误 https://www.jianshu.com/p/dd4532457b9f

使用SQLite https://www.liaoxuefeng.com/wiki/1016959663602400/1017801751919456

How to set SQLite isolation levels, using Python https://stackoverflow.com/questions/34000868/how-to-set-sqlite-isolation-levels-using-python
