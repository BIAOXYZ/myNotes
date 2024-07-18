
# 常用命令总结

```sh
.tables
.schema <table_name>
.header on
.mode column
```

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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 导入/导出相关命令

SQLite - Import Data from a CSV File https://www.quackit.com/sqlite/tutorial/import_data_from_csv_file.cfm
```console
.mode csv
.import /Users/quackit/sqlite/dumps/genres.csv Genres
```

SQLite - Export Data to a CSV File https://www.quackit.com/sqlite/tutorial/export_data_to_csv_file.cfm
```console
.header on
.mode csv
.once /Users/quackit/sqlite/dumps/artists.csv
SELECT * FROM Artists;
```

How to use SQLite3 C interface to load CSV file into a main memory database? https://stackoverflow.com/questions/36046828/how-to-use-sqlite3-c-interface-to-load-csv-file-into-a-main-memory-database
- https://stackoverflow.com/questions/36046828/how-to-use-sqlite3-c-interface-to-load-csv-file-into-a-main-memory-database/36165138#36165138
  * > The SQLite 3 C - API can be used to import csv into an Sqlite3 database.
    + > Your C code needs to open the CSV file, read in each line of the CSV file, making sure to store the column values (in the current row) in an appropriate container (i.e. column boundaries determined by comma separator).
    + > These column values can be bound to parameters in a prepared statement and then committed to the database. Here is a useful link: http://blog.quibb.org/2010/08/fast-bulk-inserts-into-sqlite/

Upload A CSV File (Or Any Data File) To SQLite Using Python https://www.youtube.com/watch?v=UZIhVmkrAEs
>> //notes：这个视频的核心点是用 pandas 的 `df.to_sql()` 方法进行导入。

## 导入数据不带header

csv import without header row https://sqlite.org/forum/forumpost/9366feb243
- (2) By Larry Brasfield (LarryBrasfield) on 2020-06-10 01:31:32
  * > Study this session scrape:
    ```sh
    sqlite> create table Pets (name text, species text);
    sqlite> insert into Pets values('Fido', 'dog');
    sqlite> insert into Pets values('Fluffy', 'cat');
    sqlite> insert into Pets values('Hiss', 'serpent');
    sqlite> .mode csv
    sqlite> .header on
    sqlite> .once pets.csv
    sqlite> select * from Pets;
    sqlite> create table Beasts (name text, species text);
    sqlite> .import --csv --skip 1 pets.csv Beasts
    sqlite> select * from Beasts;
    name,species
    Fido,dog
    Fluffy,cat
    Hiss,serpent
    sqlite>
    ```

How do I use the SQLite CLI's "--skip 1" option? https://stackoverflow.com/questions/61981598/how-do-i-use-the-sqlite-clis-skip-1-option
- https://stackoverflow.com/questions/61981598/how-do-i-use-the-sqlite-clis-skip-1-option/61981659#61981659
  * > According to the sqlite release notes, the `--skip` option was implemented in `3.32.0`:
  * > SQLite Release `3.32.0` On 2020-05-29 ... 9. Enhancements to the CLI: (a) Add options to the `.import` command: `--csv`, `--ascii`, `--skip`

## 导入数据时只导入部分列（只导入部分行很简单）

Only import two columns from a CSV https://stackoverflow.com/questions/14933691/only-import-two-columns-from-a-csv
```console
I have a CSV file with 20 columns and 100s of rows. I want to create an SQLite database using 
just two of the columns - the date in column 1 and temperature is column 10. I have modified 
some example code I found, but am not sure how to get it to just use these two columns.
```
```py
import csv, sqlite3
import sys

filename = sys.argv[-1]

con = sqlite3.connect("my.db")
con.execute("create table stats(date, temperature)")                               
cur = con.cursor()

stats = csv.reader(open(filename))

con.executemany("insert into stats(date, temperature) values (?, ?)", stats)

con.commit()
```
- https://stackoverflow.com/questions/14933691/only-import-two-columns-from-a-csv/14933711#14933711
  * >
    ```py
    con.executemany("insert into stats(date, temperature) values (?, ?)",
                    ((rec[0], rec[9]) for rec in stats))
    ```
    >> //notes：其实核心就是 `csv.reader()` 形成的变量里可以用索引来标识列，于是想要哪列就直接取出来当 `INSERT` 语句的插入值就行。

Omitting columns when importing CSV into Sqlite https://stackoverflow.com/questions/31822174/omitting-columns-when-importing-csv-into-sqlite

## 导入数据时因为索引问题慢

slow import of CSV files https://sqlite.org/forum/info/292d3cc4868ca032
- > This is extremely faked, but notice the difference between in-order insertion and out-of-order insertion:
  ```sql
  >sqlite sample.db
  SQLite version 3.34.0 2020-09-26 18:58:45
  Enter ".help" for usage hints.
  sqlite> create table x(x text primary key not null);
  sqlite> .timer on
  sqlite> pragma cache_size=1000;
  Run Time: real 0.000 user 0.000000 sys 0.000000
  sqlite> insert into x select random() from wholenumber where value between 1 and 10000000;
  Run Time: real 197.973 user 36.953125 sys 160.046875
  sqlite> .exit
  >dir sample.db
  2020-09-26  18:22       601,960,448 sample.db
  >del sample.db
  >sqlite sample.db
  SQLite version 3.34.0 2020-09-26 18:58:45
  Enter ".help" for usage hints.
  sqlite> pragma cache_size=1000;
  sqlite> create table x(x text primary key not null);
  sqlite> .timer on
  sqlite> insert into x select random() from wholenumber where value between 1 and 10000000 order by 1;
  Run Time: real 14.937 user 17.078125 sys 2.843750
  ```
  * > In the first case the insertion is in "random" order, meaning that the index structures must be continually updated and the B-Tree rebalanced as the insert progresses.
  * > In the second case the insertion is "in-order" so the B-Tree is always built in-order with a minimum of rebalancing as the insert progresses.
  * > Note that I have reduced the cache to itty-bitty (which is the default) since this will have an devastatingly huge impact on the amount of I/O performed (I have a cruise-ship-load of RAM for caching, so without this the difference is less noticeable).
  * > Even with the sort (order by clause) the in-order insertion is more than 10 times faster than the out-of-order insertion.

## 使用 `ATTACH` 连接两个sqlite数据库

How to copy data from one SQLite database to another https://www.educative.io/answers/how-to-copy-data-from-one-sqlite-database-to-another

SQLite - How to copy data from one database to another? https://tableplus.com/blog/2018/07/sqlite-how-to-copy-table-to-another-database.html

SQLite - Backup a Database to File https://www.quackit.com/sqlite/tutorial/backup_a_database_to_file.cfm
- > The `.backup` Command
  * > This will create a file called backup.db containing a backup of the database. You can attach this back into the SQLite3 command-line shell if required (then do a `.databases` to view the list of database connections):
    ```sql
    sqlite> ATTACH DATABASE 'mybackup.db' AS MyBackup;
    sqlite> .databases
    seq  name             file                                                      
    ---  ---------------  ----------------------------------------------------------
    0    main             /Users/quackit/sqlite/music.db                            
    1    temp                                                                       
    2    MyBackup         /Users/quackit/sqlite/mybackup.db  
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# PRAGMA 相关命令

SQLite PRAGMA https://www.runoob.com/sqlite/sqlite-pragma.html

How and When to Execute PRAGMA statement in SQLite? https://stackoverflow.com/questions/53027770/how-and-when-to-execute-pragma-statement-in-sqlite
- https://stackoverflow.com/questions/53027770/how-and-when-to-execute-pragma-statement-in-sqlite/53028722#53028722
  * > `PRAGMA journal_mode = OFF` will return a result of off. `PRAGMA journal_mode` will return the current value without affecting it.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

sqlite显示查询所消耗时间 https://www.cnblogs.com/ftrako/p/5294691.html
```console
sqlite>.timer on　　　　　　　　// 打开显示执行操作所消耗时间
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
