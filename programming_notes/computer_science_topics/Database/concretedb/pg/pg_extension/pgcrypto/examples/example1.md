
# 1

```sh
/* 编译安装PG */ 
// 如果是已安装的PG数据库，前两步忽略。这种情况下要注意第三步配置正确的prefix。

1. 进入代码主目录，后续用当前目录"./"表示。执行下述语句：
./configure --prefix=/home/liuliang3/app/pgsql20 --without-zlib --enable-debug --enable-cassert --enable-thread-safety CFLAGS='-O0' --with-pgport=6920 --enable-depend

2. 接着依然在该目录执行：
make;make install

/* 编译安装pgcrypto */

3. ./configure --prefix=/home/liuliang3/app/pgsql20 
(第3步为可选，如果是一个刚装的数据库接着装扩展，由于刚配过prefix，可以省略这步;但如果是一个之前已经安装好的数据库，可能需要再配一下，不然下一步可能把扩展装到别的PG里了)

4. 进入./contrib/pgcrypto目录，执行下述语句：make;make install
(成功后会自动将 pgcrypto.so 拷贝到数据库服务器的 XXX/lib 目录，将 pgcrypto.control 和几个pgcrypto相关的 .sql 文件拷贝到数据库服务器的 XXX/share/extension 目录)
```

```sql
testdb=# create table employee (id int, name varchar, sal int);
CREATE TABLE

/* test hash */

testdb=# insert into employee values (1,'alice',10000);
INSERT 0 1
testdb=# select * from employee;
 id | name  |  sal
----+-------+-------
  1 | alice | 10000
(1 row)

testdb=# insert into employee values (2,digest('bob','md5'),10002);
INSERT 0 1
testdb=# select * from employee ;
 id |                name                |  sal
----+------------------------------------+-------
  1 | alice                              | 10000
  2 | \x9f9d51bc70ef21ca5c14f307980a29d8 | 10002
(2 rows)

testdb=# select digest('bob','md5');
               digest
------------------------------------
 \x9f9d51bc70ef21ca5c14f307980a29d8
(1 row)


/* test encryption */

testdb=# insert into employee values (3,pgp_sym_encrypt('carol', 'pwd', 'cipher-algo=bf, compress-algo=2, compress-level=9'),10003);
ERROR:  Unsupported compression algorithm
testdb=# insert into employee values (3,pgp_sym_encrypt('carol', 'pwd', 'cipher-algo=bf'),10003);
INSERT 0 1
testdb=# select * from employee ;
 id |                                                               name                                                               |  sal
----+----------------------------------------------------------------------------------------------------------------------------------+-------
  1 | alice                                                                                                                            | 10000
  2 | \x9f9d51bc70ef21ca5c14f307980a29d8                                                                                               | 10002
  3 | \xc30d04040302fd924bb772a27a0771d22e01be9e65e361e050d34dfaea618d677260013de1faf7bc969ecbd860a38c0fa5fbe2405d0d8bae5a0ff2c8254731 | 10003
(3 rows)

testdb=# select pgp_sym_decrypt('\xc30d04040302fd924bb772a27a0771d22e01be9e65e361e050d34dfaea618d677260013de1faf7bc969ecbd860a38c0fa5fbe2405d0d8bae5a0ff2c8254731','pwd');
 pgp_sym_decrypt
-----------------
 carol
(1 row)

testdb=# select pgp_sym_decrypt('\xc30d04040302fd924bb772a27a0771d22e01be9e65e361e050d34dfaea618d677260013de1faf7bc969ecbd860a38c0fa5fbe2405d0d8bae5a0ff2c8254731'::bytea,'pwd');
 pgp_sym_decrypt
-----------------
 carol
(1 row)
```
