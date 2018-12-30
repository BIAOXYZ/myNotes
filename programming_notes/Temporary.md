
About CRC:

http://blog.csdn.net/authorlcy/article/details/39941521

https://stackoverflow.com/questions/12428575/multiple-small-crc-checks-or-a-single-large-crc-check

<<PostgreSQL中current_user和current_user()的区别>>
http://blog.csdn.net/wanghai__/article/details/5516938


>:couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:  :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:  :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:

http://www.cnblogs.com/gaojian/p/3164792.html

http://www.cnblogs.com/databaseaffair/p/6864070.html



https://www.cnblogs.com/biterror/p/7161631.html


http://blog.csdn.net/hunanchenxingyu/article/details/8101795

<<pthread的pthread_join()函数理解实验>>
http://blog.csdn.net/dinghqalex/article/details/42921931



<<基于 Raft 构建分布式系统 TiKV>>
https://toutiao.io/posts/17r5g9/preview








### Digital Watermarking

Hexatier 

# 编译

1.将
2. ....../hexatier-ci/DEV-42730f0be9810b241890e6f7efe6e2cfe731d4ad/script 目录下执行：

make DEBUG=1 NO_MNG=1 -j 20

# 安装卸载

Hexatier 服务卸载/安装流程
1. 卸载hexatier服务
    ./hexatier_100.1.21.9408.bin --uninstall
2. 安装hexatier服务
    ./hexatier_100.1.21.9408.bin -- -F
	cp license-editor /opt/GreenSQL/bin/
	cd /opt/GreenSQL/bin/
	./license-editor --folder-path /opt/GreenSQL/data/db --proxies 5 --expire-days 55 --enable-ha
    
    
    
    
greensql-fw.cpp   main(


****************************************************************************************************

Watermarking POC

***从头开始安装PostgreSQL及pgcrypto插件***

/* 编译安装PG */
1. 进入代码主目录，后续用当前目录"./"表示。执行下述语句：
./configure --prefix=/home/liuliang3/app/pgsql20 --without-zlib --enable-debug --enable-cassert --enable-thread-safety CFLAGS='-O0' --with-pgport=6920 --enable-depend
2. 接着依然在该目录执行：
make;make install

/* 编译安装pgcrypto */
3. ./configure --prefix=/home/liuliang3/app/pgsql20 
(第3步为可选，如果是一个刚装的数据库接着装扩展，由于刚配过prefix，可以省略这步;但如果是一个之前已经安装好的数据库，可能需要再配一下，不然下一步可能把扩展装到别的PG里了)
4. 进入./contrib/pgcrypto目录，执行下述语句：make;make install
(成功后会自动将pgcrypto.so拷贝到数据库服务器的XXX/lib目录，将pgcrypto.control和几个pgcrypto相关的.sql文件拷贝到数据库服务器的XXX/share/extension目录)


***自定义C函数***

1. gcc -I`pg_config --includedir-server` -fPIC  -c cfunc.c
2. gcc -shared -o cfunc.so cfunc.o
3. cp cfunc.so `pg_config --libdir`
4. load cfunc.so
5. CREATE OR REPLACE FUNCTION add_one(integer) RETURNS integer AS '$libdir/cfunc', 'add_one' LANGUAGE C STRICT;

***自定义PL/pgSQL函数***

CREATE TABLE public.test_table
(
  xm character varying(50),
  pinyin character varying(200),
  sm character(15)
);
INSERT INTO test_table VALUES ('张三', '测试', '测试');
INSERT INTO test_table VALUES ('李四', '测试', '测试');


CREATE TABLE testtable (id int, name varchar(2048), salary float);

INSERT INTO testtable VALUES (1, 'alice', 10000.00000001);
INSERT INTO testtable VALUES (2, 'bob', 10000.00000001);

select encode(name::bytea, 'escape') from testtable;


//encode函数的使用
testdb=# select encode(E'123\\000\\001', 'base64');
  encode
----------
 MTIzAAE=
(1 row)


select E'\u00f0';

//发现从E'\u2000'到E'\u200f'都是不可见字符
select E'\u200b';

postgres=# select E'\u200b';
 ?column?
----------
 ​
(1 row)


//此外还有E'\u202a'到E'\u202f'（最后一个看着没字符，实际有）：
postgres=# select E'\u202a', E'\u202f';
 ?column? | ?column?
----------+----------
 ‪         |  
(1 row)





/* basic example：
 * Chapter 36. 扩展SQL
 * 36.4. 查询语言（SQL）函数
 */

/* 36.4.3. 组合类型上的SQL函数 */
// 准备emp表和插入数据
CREATE TABLE emp (
name text,
salary numeric,
age integer,
cubicle point
);
INSERT INTO emp VALUES ('Bill', 4200, 45, '(2,1)');

// double_salary函数，主要注意$1.salary的用法吧
CREATE FUNCTION double_salary(emp) RETURNS numeric AS $$
    SELECT $1.salary * 2 AS salary;
$$ LANGUAGE SQL;

//// 两种查询结果的方法效果一样，但是后一种由于比较模糊，所以应该用第一种
testdb=# SELECT name, double_salary(emp.*) AS dream FROM emp WHERE emp.cubicle ~= point '(2,1)';
 name | dream
------+-------
 Bill |  8400
(1 row)

testdb=# SELECT name, double_salary(emp) AS dream FROM emp WHERE emp.cubicle ~= point '(2,1)';
 name | dream
------+-------
 Bill |  8400
(1 row)

//// "有时候实时构建一个组合参数很方便。这可以用ROW结构完成。"
testdb=# SELECT name, double_salary(ROW(name, salary*1.1, age, cubicle)) AS dream FROM emp;
 name | dream
------+--------
 Bill | 9240.0
(1 row)


// "也可以构建一个返回组合类型的函数。这是一个返回单一emp行的函数例子："
CREATE FUNCTION new_emp() RETURNS emp AS $$
    SELECT text 'None' AS name,
    1000.0 AS salary,
    25 AS age,
    point '(2,2)' AS cubicle;
$$ LANGUAGE SQL;

//// "定义同样的函数的一种不同的方法是："
CREATE FUNCTION new_emp() RETURNS emp AS $$
    SELECT ROW('None', 1000.0, 25, '(2,2)')::emp;
$$ LANGUAGE SQL;

//// 一堆各种查询方法（两个函数都是这个结果） 
testdb=# SELECT new_emp();
         new_emp
--------------------------
 (None,1000.0,25,"(2,2)")
(1 row)

testdb=# SELECT * FROM new_emp();
 name | salary | age | cubicle
------+--------+-----+---------
 None | 1000.0 |  25 | (2,2)

testdb=# SELECT (new_emp()).name;
 name
------
 None
(1 row)

//// "另一个选项是使用函数记号来抽取一个属性。简而言之就是
//// 我们可以交换使用attribute(table)和table.attribute。" 
testdb=# SELECT name(new_emp());
 name
------
 None
(1 row)
 

//"另一种使用返回组合类型的函数的方法是把结果传递给另一个接收正确行类型作为输入的函数："
CREATE FUNCTION getname(emp) RETURNS text AS $$
    SELECT $1.name;
$$ LANGUAGE SQL;

////这个函数不但依赖new_emp()函数，还依赖emp表。。。 
testdb=# SELECT getname(new_emp());
 getname
---------
 None
(1 row) 

/* 36.4.5. 带有可变数量参数的SQL函数 */ 
// VARIADIC类型 
//// PostgreSQL的generate_subscripts 
//// https://www.cnblogs.com/gaojian/archive/2012/11/09/2762523.html
CREATE FUNCTION mleast(VARIADIC arr numeric[]) RETURNS numeric AS $$
    SELECT min($1[i]) FROM generate_subscripts($1, 1) g(i);
$$ LANGUAGE SQL;
 
testdb=# SELECT mleast(10, -1, 5, 4.4);
 mleast
--------
     -1
(1 row)

testdb=# SELECT mleast(ARRAY[10, -1, 5, 4.4]);
2018-04-02 15:54:57.623 CST [120191] ERROR:  function mleast(numeric[]) does not exist at character 8
2018-04-02 15:54:57.623 CST [120191] HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
2018-04-02 15:54:57.623 CST [120191] STATEMENT:  SELECT mleast(ARRAY[10, -1, 5, 4.4]);
ERROR:  function mleast(numeric[]) does not exist
LINE 1: SELECT mleast(ARRAY[10, -1, 5, 4.4]);
               ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.

testdb=# SELECT mleast(VARIADIC ARRAY[10, -1, 5, 4.4]);
 mleast
--------
     -1
(1 row)

testdb=# SELECT mleast(VARIADIC ARRAY[]::numeric[]);
 mleast
--------

(1 row)
 
/* 36.4.7. SQL 函数作为表来源 */ 
//准备数据
CREATE TABLE foo (fooid int, foosubid int, fooname text);
INSERT INTO foo VALUES (1, 1, 'Joe');
INSERT INTO foo VALUES (1, 2, 'Ed');
INSERT INTO foo VALUES (2, 1, 'Mary');

testdb=# select * from foo;
 fooid | foosubid | fooname
-------+----------+---------
     1 |        1 | Joe
     1 |        2 | Ed
     2 |        1 | Mary
(3 rows)

//函数getfoo
CREATE FUNCTION getfoo(int) RETURNS foo AS $$
    SELECT * FROM foo WHERE fooid = $1;
$$ LANGUAGE SQL;

testdb=# SELECT *, upper(fooname) FROM getfoo(1) AS t1;
 fooid | foosubid | fooname | upper
-------+----------+---------+-------
     1 |        1 | Joe     | JOE
(1 row)

//自己试了一个getfoo2函数，发现表中三行只能查出来一行，因为没有用SETOF
CREATE FUNCTION getfoo2() RETURNS foo AS $$
    SELECT * FROM foo;
$$ LANGUAGE SQL;

testdb=# select getfoo2();
  getfoo2
-----------
 (1,1,Joe)
(1 row)

////用select *的方法能够把上面那个展示结果变为多列
testdb=# select * from getfoo2();
 fooid | foosubid | fooname
-------+----------+---------
     1 |        1 | Joe
(1 row)
 
/* 36.4.8. 返回集合的SQL函数 */
//也没必要准备数据了，就用上一节的表foo就可以
CREATE FUNCTION getfoo(int) RETURNS SETOF foo AS $$
    SELECT * FROM foo WHERE fooid = $1;
$$ LANGUAGE SQL;

testdb=# SELECT * FROM getfoo(1) AS t1;
 fooid | foosubid | fooname
-------+----------+---------
     1 |        1 | Joe
     1 |        2 | Ed
(2 rows)

 
// "也可以返回多个带有由输出参数定义的列的行，像这样："
CREATE TABLE tab (y int, z int);
INSERT INTO tab VALUES (1, 2), (3, 4), (5, 6), (7, 8);

CREATE FUNCTION sum_n_product_with_tab (x int, OUT sum int, OUT product int)
RETURNS SETOF record
AS $$
    SELECT $1 + tab.y, $1 * tab.y FROM tab;
$$ LANGUAGE SQL; 
 
testdb=# SELECT * FROM sum_n_product_with_tab(10);
 sum | product
-----+---------
  11 |      10
  13 |      30
  15 |      50
  17 |      70
(4 rows)

/* 36.4.9. 返回TABLE的SQL函数 */
//这个函数和上面那个同名，创建之前得把前面那个删除。或者加OR REPLACE
CREATE FUNCTION sum_n_product_with_tab (x int)
RETURNS TABLE(sum int, product int) AS $$
    SELECT $1 + tab.y, $1 * tab.y FROM tab;
$$ LANGUAGE SQL;
 
testdb=# select sum_n_product_with_tab(5);
 sum_n_product_with_tab
------------------------
 (6,5)
 (8,15)
 (10,25)
 (12,35)
(4 rows)

testdb=# select * from sum_n_product_with_tab(5);
 sum | product
-----+---------
   6 |       5
   8 |      15
  10 |      25
  12 |      35
(4 rows)
 
/* 36.4.10. 多态SQL函数 */ 
// 创建函数make_array
CREATE FUNCTION make_array(anyelement, anyelement) RETURNS anyarray AS $$
    SELECT ARRAY[$1, $2];
$$ LANGUAGE SQL;

testdb=# SELECT make_array(1, 2) AS intarray, make_array('a'::text, 'b') AS textarray;
 intarray | textarray
----------+-----------
 {1,2}    | {a,b}
(1 row)

testdb=# SELECT make_array(1, 2) AS intarray;
 intarray
----------
 {1,2}
(1 row)

testdb=# SELECT make_array('a'::text, 'b') AS textarray;
 textarray
-----------
 {a,b}
(1 row)

testdb=# SELECT make_array('a', 'b') AS textarray;
2018-04-03 15:17:13.793 CST [120191] ERROR:  could not determine polymorphic type because input has type unknown
2018-04-03 15:17:13.793 CST [120191] STATEMENT:  SELECT make_array('a', 'b') AS textarray;
ERROR:  could not determine polymorphic type because input has type unknown


 
 /* basic example 2：
 * Chapter 41. PL/pgSQL - SQL过程语言
 * 本章所有小节
 */

CREATE FUNCTION sales_tax(subtotal real) RETURNS real AS $$
BEGIN
RETURN subtotal * 0.06;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION sales_tax(integer) RETURNS real AS $$
DECLARE
subtotal ALIAS FOR $1;
BEGIN
RETURN subtotal * 2;
END;
$$ LANGUAGE plpgsql;

testdb=# select sales_tax(100);
 sales_tax
-----------
       200
(1 row)

testdb=# select sales_tax(100.0);
 sales_tax
-----------
         6
(1 row)


// 利用OUT省略RETURNS定义的返回值
CREATE FUNCTION sum_n_product(x int, y int, OUT sum int, OUT prod int) AS $$
BEGIN
    sum := x + y;
    prod := x * y;
END;
$$ LANGUAGE plpgsql;

testdb=# select sum_n_product(5,6);
 sum_n_product
---------------
 (11,30)
(1 row)

testdb=# select * from sum_n_product(5,6);
 sum | prod
-----+------
  11 |   30
(1 row)

// example: return table
create table sales (itemname text, quantity int, price numeric, itemno int);
insert into sales values ('apple', 10, 4.2, 1);
insert into sales values ('banana', 20, 3, 2);

CREATE FUNCTION extended_sales(p_itemno int)
RETURNS TABLE(name text, quantity int, total numeric) AS $$
BEGIN
RETURN QUERY SELECT s.itemname, s.quantity, s.quantity * s.price FROM sales AS s
WHERE s.itemno = p_itemno;
END;
$$ LANGUAGE plpgsql;

testdb=# select extended_sales(2);
 extended_sales
----------------
 (banana,20,60)
(1 row)

// 多态类型的参数时，还必须保证实际输入参数类型一致才行
CREATE FUNCTION add_three_values(v1 anyelement, v2 anyelement, v3 anyelement,
OUT sum anyelement)
AS $$
BEGIN
sum := v1 + v2 + v3;
END;
$$ LANGUAGE plpgsql;

testdb=# select add_three_values(1,2,3);
 add_three_values
------------------
                6
(1 row)

testdb=# select add_three_values(1,2.5,3);
2018-04-02 09:15:42.086 CST [120191] ERROR:  function add_three_values(integer, numeric, integer) does not exist at character 8
2018-04-02 09:15:42.086 CST [120191] HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
2018-04-02 09:15:42.086 CST [120191] STATEMENT:  select add_three_values(1,2.5,3);
ERROR:  function add_three_values(integer, numeric, integer) does not exist
LINE 1: select add_three_values(1,2.5,3);
               ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.

/* 41.9.1. 数据改变的触发器 */
CREATE TABLE emp (
    empname text,
    salary integer,
    last_date timestamp,
    last_user text
);

CREATE FUNCTION emp_stamp() RETURNS trigger AS $emp_stamp$
    BEGIN
        -- Check that empname and salary are given
        IF NEW.empname IS NULL THEN
            RAISE EXCEPTION 'empname cannot be null';
        END IF;
        IF NEW.salary IS NULL THEN
            RAISE EXCEPTION '% cannot have null salary', NEW.empname;
        END IF;

        -- Who works for us when they must pay for it?
        IF NEW.salary < 0 THEN
            RAISE EXCEPTION '% cannot have a negative salary', NEW.empname;
        END IF;

        -- Remember who changed the payroll when
        NEW.last_date := current_timestamp;
        NEW.last_user := current_user;
        RETURN NEW;
    END;
$emp_stamp$ LANGUAGE plpgsql;

CREATE TRIGGER emp_stamp BEFORE INSERT OR UPDATE ON emp
    FOR EACH ROW EXECUTE PROCEDURE emp_stamp();

testdb=# select * from pg_trigger;
-[ RECORD 1 ]--+----------
tgrelid        | 57615
tgname         | emp_stamp
tgfoid         | 57621
tgtype         | 23
tgenabled      | O
tgisinternal   | f
tgconstrrelid  | 0
tgconstrindid  | 0
tgconstraint   | 0
tgdeferrable   | f
tginitdeferred | f
tgnargs        | 0
tgattr         |
tgargs         | \x
tgqual         |
tgoldtable     |
tgnewtable     |






// ongoing example

/// wrong
CREATE FUNCTION return_tab(tbname text, username text) RETURNS SETOF record
AS $$
BEGIN
SELECT *, digest($2) FROM $1; 
END
$$ LANGUAGE plpgsql;

/// wrong
CREATE FUNCTION return_tab(tbname text, username text) RETURNS SETOF record
AS $$
SELECT *, digest($2) FROM $1::text; 
$$ LANGUAGE SQL;



// components

//// add column

testdb=# select *, digest('foo','md5') from foo;
 fooid | foosubid | fooname |               digest
-------+----------+---------+------------------------------------
     1 |        1 | Joe     | \xacbd18db4cc2f85cedef654fccc4a4d8
     1 |        2 | Ed      | \xacbd18db4cc2f85cedef654fccc4a4d8
     2 |        1 | Mary    | \xacbd18db4cc2f85cedef654fccc4a4d8
(3 rows)

testdb=# select *, digest('foo','md5') as newCol from foo;
 fooid | foosubid | fooname |               newcol
-------+----------+---------+------------------------------------
     1 |        1 | Joe     | \xacbd18db4cc2f85cedef654fccc4a4d8
     1 |        2 | Ed      | \xacbd18db4cc2f85cedef654fccc4a4d8
     2 |        1 | Mary    | \xacbd18db4cc2f85cedef654fccc4a4d8
(3 rows)


testdb=# select * from tab;
 y | z
---+---
 1 | 2
 3 | 4
 5 | 6
 7 | 8
(4 rows)

testdb=# create table tab2 as select * from tab;
SELECT 4
testdb=# select * from tab2;
 y | z
---+---
 1 | 2
 3 | 4
 5 | 6
 7 | 8
(4 rows)

testdb=# insert into t1 values (1,'a'), (2,'b');
INSERT 0 2
testdb=# select * from t1;
 id | name
----+------
  1 | a
  2 | b
(2 rows)

testdb=# create table t2 (like t1 including all);
CREATE TABLE
testdb=# select * from t2;
 id | name
----+------
(0 rows)

CREATE OR REPLACE RULE "_RETURN" AS 
    ON SELECT TO t3 
    DO INSTEAD 
        SELECT * FROM t1;
        
CREATE RULE "_RETURN" AS ON SELECT TO t3 DO INSTEAD SELECT * FROM t1;

testdb=# select * from pg_rules;
 schemaname |  tablename  |   rulename    |                                            definition
------------+-------------+---------------+---------------------------------------------------------------------------------------------------
 pg_catalog | pg_settings | pg_settings_n | CREATE RULE pg_settings_n AS                                                                     +
            |             |               |     ON UPDATE TO pg_settings DO INSTEAD NOTHING;
 pg_catalog | pg_settings | pg_settings_u | CREATE RULE pg_settings_u AS                                                                     +
            |             |               |     ON UPDATE TO pg_settings                                                                     +
            |             |               |    WHERE (new.name = old.name) DO  SELECT set_config(old.name, new.setting, false) AS set_config;
(2 rows)


/// wrong
CREATE OR REPLACE RULE "_RETURN" AS 
    ON SELECT TO t3 
    DO INSTEAD 
        SELECT *, digest('t1','md5') FROM t1;
        
        
https://stackoverflow.com/questions/31477177/postgresql-create-rule-on-select-where-clause

CREATE RULE CodeRetrieve AS  
    ON SELECT TO RC.Code from RC WHERE RC.CODEID = FromQuery.CODEID
    DO INSTEAD  
    RCAA.Code from RCAA WHERE RCAA.CODEID = FromQuery.CODEID  


    
36.4.1. SQL函数的参数
"SQL 函数参数只能被用做数据值而不能作为标识符。例如这是合理的：
INSERT INTO mytable VALUES ($1);
但这样就不行：
INSERT INTO $1 VALUES (42);"

//似乎有这个限制就写不出通用的以函数名字做入参的add_col函数了。所以只能是特定表上的add_col_for_xxx函数
//然后用一个大的C函数外部调用

CREATE OR REPLACE FUNCTION add_col_for_foo(username text) RETURNS SETOF record
AS $$
SELECT *, digest('foo', 'md5') FROM foo; 
$$ LANGUAGE SQL;




// 这个可以重点关注下，感觉这个能行

CREATE OR REPLACE FUNCTION show_table()
RETURNS TABLE(quantity int, total numeric) AS $$
BEGIN
RETURN QUERY SELECT s.quantity, s.quantity * s.price FROM sales AS s;
END;
$$ LANGUAGE plpgsql;

testdb=# select * from sales;
 itemname | quantity | price | itemno
----------+----------+-------+--------
 apple    |       10 |   4.2 |      1
 banana   |       20 |     3 |      2
(2 rows)

testdb=# select show_table();
 show_table
------------
 (10,42.0)
 (20,60)
(2 rows)



//// example

CREATE FUNCTION print_unicode RETURNS integer AS $$
-- DECLARE
BEGIN
    SELECT * FROM testtable;
END;
$$ LANGUAGE plpgsql;



CREATE FUNCTION add_column 




