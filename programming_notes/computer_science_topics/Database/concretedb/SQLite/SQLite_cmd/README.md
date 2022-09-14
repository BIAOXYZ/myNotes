
# SQLite 命令

Command Line Shell For SQLite https://www.sqlite.org/cli.html
- > **4.3. Dot-command execution**
  * > The dot-commands are interpreted by the sqlite3.exe command-line program, not by SQLite itself. ***So none of the dot-commands will work as an argument to SQLite interfaces such as `sqlite3_prepare()` or `sqlite3_exec()`***.

不需要进入sqlite3命令的方法 https://blog.csdn.net/zhouzhenhe2008/article/details/79407072
- > `sqlite3 xxx.db "sql语句"`
  >> 【[:star:][`*`]】 //notes：实际上这种方式不但能执行SQL（比如：`sqlite3 ./1234 "select * from mytable;"`），也可以执行命令（比如：`sqlite3 ./1234 ".tables"`）

The SQLite command line https://datacarpentry.org/sql-socialsci/08-sqlite-command-line/index.html
- > create a file `commands.sql` containing the following content:
  ```console
  result.csv
  .mode csv
  .output results.csv
  .open SQL_SAFI.sqlite
  SELECT * from Farms where A09_village='God';
  ```
- > run the sqlite3 program in the following way
  ```sh
  $ sqlite3 < commands.sql
  ```
  > Notice that there is no output to the screen and that the shell is closed. The results of running the query have been placed in the `results.csv` file.

5 Ways to Run an SQL Script from a File in SQLite https://database.guide/5-ways-to-run-sql-script-from-file-sqlite/
- > The `cat` Command
  ```sh
  cat create_table.sql | sqlite3 Test.db
  ```
  >> 【[:star:][`*`]】 //notes：实际上不论是这个，还是下面的重定向方式，都无法解决一个问题：如果我的 sql 脚本是在程序里拼接成的，但是我又不想让这个脚本落盘（尽管我可以落盘后，执行一下，再删除），该怎么办。经过验证，用下面的办法：
  ```sh
  root# echo -e ".tables\n.tables\n.tables" | sqlite3 ./1234
  mytable
  mytable
  mytable
  ```
  >>> //notes：如果拼接好后用 `os.system(cmd)` 或 `subprocess.call(cmd, shell=True)` 来执行的话，需要注意把 `echo` 的 `-e` 参数去掉。
- > The `.read` Command
  ```console
  .read insert_data.sql
  ```
- > Use the `.read` Command Without Opening SQLite
  ```sh
  sqlite3 Test.db ".read insert_data.sql"
  ```
- > Redirect the Input to the Database when Connecting to SQLite
  ```sh
  sqlite3 Test.db < insert_data.sql
  ```
- > The `-init` Option
  ```sh
  sqlite3 Test.db -init insert_data.sql
  ```
  >> //notes：这个不是很好，因为执行完 sqlite3 命令行还是打开的状态。。。

Execute SQLite script https://stackoverflow.com/questions/11643611/execute-sqlite-script

## 导入/导出

SQLite - Import Data from a CSV File https://www.quackit.com/sqlite/tutorial/import_data_from_csv_file.cfm

SQLite - Export Data to a CSV File https://www.quackit.com/sqlite/tutorial/export_data_to_csv_file.cfm

How to use SQLite3 C interface to load CSV file into a main memory database? https://stackoverflow.com/questions/36046828/how-to-use-sqlite3-c-interface-to-load-csv-file-into-a-main-memory-database
- https://stackoverflow.com/questions/36046828/how-to-use-sqlite3-c-interface-to-load-csv-file-into-a-main-memory-database/36165138#36165138
  * > The SQLite 3 C - API can be used to import csv into an Sqlite3 database.
    + > Your C code needs to open the CSV file, read in each line of the CSV file, making sure to store the column values (in the current row) in an appropriate container (i.e. column boundaries determined by comma separator).
    + > These column values can be bound to parameters in a prepared statement and then committed to the database. Here is a useful link: http://blog.quibb.org/2010/08/fast-bulk-inserts-into-sqlite/

## 其他

sqlite显示查询所消耗时间 https://www.cnblogs.com/ftrako/p/5294691.html
```console
sqlite>.timer on　　　　　　　　// 打开显示执行操作所消耗时间
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
