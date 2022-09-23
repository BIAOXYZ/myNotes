
# 1

How To Install libsqlite3-dev on Ubuntu 20.04 https://installati.one/ubuntu/20.04/libsqlite3-dev/
```sh
sudo apt-get update
sudo apt-get install -y libsqlite3-dev
```

【[:star:][`*`]】 SQLite - C/C++ https://www.runoob.com/sqlite/sqlite-c-cpp.html

# 2

【[:star:][`*`]】 sqlite3使用总结(转并且修改) https://www.cnblogs.com/qxxnxxfight/p/4096074.html
- > 此文来自 http://blog.csdn.net/shengfang666/article/details/7937200 ，我在这儿重新发一下，备份参考。
- > **i.2 `exec` 的回调**
  ```c
  typedef int (*sqlite3_callback)(void*,int,char**, char**);
  ```
  > 你的回调函数必须定义成上面这个函数的类型。下面给个简单的例子：
- > **i.3 不使用回调查询数据库**
  * > 上面介绍的 `sqlite3_exec` 是使用回调来执行 select 操作。还有一个方法可以直接查询而不需要回调。但是，我个人感觉还是回调好，因为代码可以更加整齐，只不过用回调很麻烦，你得声明一个函数，如果这个函数是类成员函数，你还不得不把它声明成 `static` 的（要问为什么？这又是C++基础了。C++成员函数实际上隐藏了一个参数：`this`，C++调用类的成员函数的时候，隐含把类指针当成函数的第一个参数传递进去。结果，这造成跟前面说的 sqlite 回调函数的参数不相符。只有当把成员函数声明成 `static` 时，它才没有多余的隐含的 `this` 参数）。

# 3

SQLite C 教程 https://geek-docs.com/sqlite/sqlite-tutorial/sqlitec.html

Reading Data from a Cursor https://riptutorial.com/sqlite/example/19406/reading-data-from-a-cursor
>> 【[:star:][`*`]】 //notes：之前 `sqlite3_prepare_v2()` 都是 insert 多个元素的时候 prepare 一下。这个例子是一个比较好的 select 时候用 prepare 的例子。 select 之所以以前不用 prepare 是因为都是一把梭哈的用法，只是简单的执行一下，假定内存能装下所有的返回结果。
- > A SELECT query is executed like any other statement. To read the returned data, call sqlite3_step() in a loop. It returns:
  * > `SQLITE_ROW`: if the data for the next row is available, or
  * > `SQLITE_DONE`: if there are no more rows, or
  * > any error code.
- > If a query does not return any rows, the very first step returns `SQLITE_DONE`.
- > To read the data from the current row, call the `sqlite3_column_xxx()` functions:
  ```c
  const char *sql = "SELECT ID, Name FROM MyTable";
  sqlite3_stmt *stmt;
  int err;

  err = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
  if (err != SQLITE_OK) {
      printf("prepare failed: %s\n", sqlite3_errmsg(db));
      return /* failure */;
  }

  for (;;) {
      err = sqlite3_step(stmt);
      if (err != SQLITE_ROW)
          break;

      int         id   = sqlite3_column_int (stmt, 0);
      const char *name = sqlite3_column_text(stmt, 1);
      if (name == NULL)
          name = "(NULL)";
      printf("ID: %d, Name: %s\n", id, name);
  }

  if (err != SQLITE_DONE) {
      printf("execution failed: %s\n", sqlite3_errmsg(db));
      sqlite3_finalize(stmt);
      return /* failure */;
  }

  sqlite3_finalize(stmt);
  return /* success */;
  ```
