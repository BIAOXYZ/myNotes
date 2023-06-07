
### 老版本 sqlite3 二进制不支持 `alter table tb_name drop column col_name;`

```sh
# 这个是 apt install -y sqlite 默认安装的 3.27.2 版本
$ sqlite3
SQLite version 3.27.2 2019-02-25 16:06:06
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> .open 4567
sqlite> create table t1 (id int, name text);
sqlite> insert into t1 values (1, 'a');
sqlite> insert into t1 values (2, 'b');
sqlite> select * from t1;
1|a
2|b
sqlite> alter table t1 drop column id;
Error: near "drop": syntax error
```
```sh
# 这个是目前（2022.10.10）官网最新的 3.39.4 版本
$ wget https://www.sqlite.org/2022/sqlite-tools-linux-x86-3390400.zip
$ unzip sqlite-tools-linux-x86-3390400.zip
$ cd sqlite-tools-linux-x86-3390400
$ ls
sqldiff  sqlite3  sqlite3_analyzer

$ ./sqlite3
bash: ./sqlite3: No such file or directory
# 这个问题出现的原因是现在大多数机器都是 64 位了，然而 sqlite 官方下载页面上的二进制还是 32 位。。。
$ file ./sqlite3
./sqlite3: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, for GNU/Linux 4.3.0, stripped

# 解决办法参考这里： https://stackoverflow.com/questions/14082152/sqlite3-no-such-file-or-directory/14082813#14082813
$ sudo apt-get install lib32z1 -y
...
...
...

$ ./sqlite3
SQLite version 3.39.4 2022-09-29 15:55:41
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> 
sqlite> .open 1234
sqlite> create table t1 (id int, name text);
sqlite> insert into t1 values (1, 'a');
sqlite> insert into t1 values (2, 'b');
sqlite> select * from t1;
1|a
2|b
sqlite> alter table t1 drop column id;
sqlite> select * from t1;
a
b
sqlite>
```
```sh
# （注意，如果你是用 apt install 安装的二进制，那个是跟机器有关的，64 位机器也能正确安装 64 位的二进制）
$ which sqlite3
/usr/bin/sqlite3
$ file /usr/bin/sqlite3
/usr/bin/sqlite3: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=f8a2bb2b99fe8eae437455d74347d1750d7018dc, for GNU/Linux 3.2.0, stripped
```

### 老版本 sqlite3 二进制不支持 right join 和 (full) outer join

```sql
sqlite> select * from ta left join tb on ta.id = tb.id left join tc on ta.id = tc.id;
1|11|1|111|1|1111
1|11|1|111|1|1111
1|11|1|111|1|1111
1|11|1|111|1|1111
2|22|2|222|2|2222
2|22|2|222|2|2222
2|22|2|222|2|2222
2|22|2|222|2|2222
3|33|||3|3333
sqlite> select * from ta left join (tb outer join tc on tb.id = tc.id) as bc on ta.id = tc.id;
Error: RIGHT and FULL OUTER JOINs are not currently supported
sqlite> select * from ta left join (tb full outer join tc on tb.id = tc.id) as bc on ta.id = tc.id;
Error: RIGHT and FULL OUTER JOINs are not currently supported
sqlite>
```

FULL OUTER JOIN with SQLite https://stackoverflow.com/questions/1923259/full-outer-join-with-sqlite  【SQLite 3.39.0 支持了，但是之前只能自己模拟】

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

### `ImportError: /usr/local/lib/python3.7/_sqlite3.so: undefined symbol: _Py_ZeroStruct`

**症状**：
```sh
$ python3
Python 3.7.10 (default, Oct 27 2022, 14:20:05)
[GCC 6.3.0 20170516] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sqlite3
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/usr/local/lib/python3.7/sqlite3/__init__.py", line 23, in <module>
    from sqlite3.dbapi2 import *
  File "/usr/local/lib/python3.7/sqlite3/dbapi2.py", line 27, in <module>
    from _sqlite3 import *
ImportError: /usr/local/lib/python3.7/_sqlite3.so: undefined symbol: _Py_ZeroStruct
>>>
```

**处理过程（参考了`【1】`、`【2】`、`【3】`，主要是`【3】`吧）**：

1.在源码编译安装 Python，执行完 `make` 时，会在屏幕上打印类似下面这段信息（提示这几个库没有编译安装）。
```console
Python build finished successfully!
The necessary bits to build these optional modules were not found:
_curses               _curses_panel         _dbm
_gdbm                 _lzma                 _tkinter
_uuid                 readline
To find the necessary bits, look in setup.py in detect_modules() for the module's name.
```

2.以其中的 `_lzma` 和 `readline` 为例，执行了下述语句安装。
```sh
apt install -y liblzma-dev
apt install -y libreadline-dev
```

3.再次在 Python 源码目录执行 `make`，会发现 `_lzma` 和 `readline` 这次就好了（不提示了）。然后重新 `sudo make install` 一次就可以了。
```console
Python build finished successfully!
The necessary bits to build these optional modules were not found:
_curses               _curses_panel         _dbm
_gdbm                 _tkinter              _uuid
To find the necessary bits, look in setup.py in detect_modules() for the module's name.
```

4.同样的操作对 `sqlite3` 却不行，后来参考`【4】`，发现可能是因为之前用 `apt install -y python3-dev` 装过 python3.5，以及其他杂七杂八的原因，导致我的机器上相应的库路径（`/usr/local/lib/python3.7/site-packages`）里虽然有 `_sqlite3.so`，但是 import 就是不对。最后是灵机一动，把已有的两个都重命名了一下，然后再次 `sudo make install`，最后终于可以了。
```sh
$ python3
Python 3.7.10 (default, Oct 27 2022, 14:31:48)
[GCC 6.3.0 20170516] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import site; site.getsitepackages()
['/usr/local/lib/python3.7/site-packages']
>>>
```
```sh
$ cd usr/local/lib/
$ sudo mv python3.5/ python3.5-bak/
$ sudo mv python3.7/ python3.7-bak/
# 回到 Python 源码目录再安装一次。
```
```sh
$ python3
Python 3.7.10 (default, Oct 27 2022, 14:31:48)
[GCC 6.3.0 20170516] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sqlite3
>>> 
```

**相关帖子**：
- Building Python and more on missing modules https://stackoverflow.com/questions/6171210/building-python-and-more-on-missing-modules  `【1】`
- How can I add the sqlite3 module to Python? https://stackoverflow.com/questions/19530974/how-can-i-add-the-sqlite3-module-to-python  `【2】`
- 解决办法：Python3.x UserWarning: Could not import the lzma module. Your installed Python is incomplete https://blog.csdn.net/dietime1943/article/details/120658063  `【3】`
  * > **原因分析**：出现该错误的原因，是因为在依次执行完./configure 和 sudo make 的时候出现了错误提示，被忽略了。
  * > 如果发现在执行make的时候出现类似下面的错误提示，那么就是因为依赖包没有提前安装好，需要提前安装好。
  * > 提示如下：
    ```console
    Python build finished successfully!
    The necessary bits to build these optional modules were not found:
    _dbm                  _gdbm                 _lzma              nis
    To find the necessary bits, look in setup.py in detect_modules() for the module's name.
    ```
- Python安装sqlite3 https://www.cnblogs.com/yanzi-meng/p/8353729.html  `【4】`
  * > 1.查看是Python是否有该库
    + > 使用http://django-china.cn/topic/413/ 查看自己Python库的路径，
      ```py
      >>> import site; site.getsitepackages()
      ['/home/user/usr/python/python2.7/lib/python2.7/site-packages', '/home/user/usr/python/python2.7/lib/site-python']
      ```
    + > 进入 `/home/user/usr/python/python2.7/lib/python2.7/lib-dynload` 看看是否有 `_sqlite3.so` 这个文件，发现没有这个文件，说明没有安装此扩展。
- https://flaggo.github.io/python3-source-code-analysis/preface/unix-linux-build/

# `Failed to prepare statement: database or disk is full`

"database or disk is full" with in-memory database. Suggested next steps? https://sqlite.org/forum/forumpost/d592a0554b

sqlite3.OperationalError: database or disk is full. https://sqlite.org/forum/info/da7042310fd0e8c1098df013e3d64ef913f310b8d0cd35ef62d829730c1973db

"sqlite3.OperationalError: database or disk is full" on Lustre https://stackoverflow.com/questions/16685016/sqlite3-operationalerror-database-or-disk-is-full-on-lustre

SQLITE3 VACUUM, "database or disk is full" https://stackoverflow.com/questions/23249843/sqlite3-vacuum-database-or-disk-is-full

Sqlite drop table error: database or disk is full https://stackoverflow.com/questions/69568108/sqlite-drop-table-error-database-or-disk-is-full
