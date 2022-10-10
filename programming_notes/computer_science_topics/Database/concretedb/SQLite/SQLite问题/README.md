
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
