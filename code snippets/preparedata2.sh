#!/bin/sh


tabnum=2
rownum=10
dbnum=1

viewnum=2

echo "--------------------The number of tables is ${tabnum} and the number of rows per table is ${rownum}--------------------"

dbName=postgres
cnPort=19201
user=liuliangap
password=2017

#for i in {1..${tabnum}}   
## dollar sign "$" cannot be correctly recognized within curly brackets, so we use another form of for-cycle in which loop body is embraced by two levels of brackets.
for((i=1;i<${tabnum}+1;i++))
do
echo "--------------------drop table tb${i}--------------------"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "drop table if exists tb${i};"
done


#for i in {1..${tabnum}}
for((i=1;i<${tabnum}+1;i++))
do
echo "--------------------create table tb${i}--------------------"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "create table tb${i} (id int, name varchar(24), sex char, name2 varchar(24), sex2 char, name3 varchar(24), sex3 char, name4 varchar(24), sex4 char, name5 varchar(24), sex5 char);"
echo "--------------------insert table tb${i}--------------------"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "insert into tb${i} values (generate_series(1,${rownum}), 'a', 'm', 'a', 'm', 'a', 'm', 'a', 'm', 'a', 'm');"
done


for((i=1;i<${tabnum}+1;i++))
do
echo "--------------------insert table tb${i}--------------------"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "insert into tb${i} select * from tb${i};"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "insert into tb${i} select * from tb${i};"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "insert into tb${i} select * from tb${i};"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "insert into tb${i} select * from tb${i};"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "insert into tb${i} select * from tb${i};"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "insert into tb${i} select * from tb${i};"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "insert into tb${i} select * from tb${i};"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "insert into tb${i} select * from tb${i};"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "insert into tb${i} select * from tb${i};"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "insert into tb${i} select * from tb${i};"
done


#for i in {1..${tabnum}}
for((i=1;i<${tabnum}+1;i++))
do
echo "--------------------check tb${i}--------------------"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "select count(*) from tb${i};"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "select pg_size_pretty(pg_relation_size('tb${i}'));"
done

# prepare a new user and her table
echo "--------------------prepare a new user and her table--------------------"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "drop user if exists testuser cascade;"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "create user testuser identified by 'Gauss_234';"
gsql -d ${dbName} -p ${cnPort} -U testuser -W Gauss_234 -c "create table testusertb (id int);"
gsql -d ${dbName} -p ${cnPort} -U testuser -W Gauss_234 -c "insert into testuser.testusertb values (generate_series(1,100));"


dbName2=testdb

echo "--------------------prepare a table with data from copy statement--------------------"

gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "create database testdb;"

gsql -d ${dbName2} -p ${cnPort} -U ${user} -W ${password} -c "drop table if exists customer;"

gsql -d ${dbName2} -p ${cnPort} -U ${user} -W ${password} -c "CREATE TABLE Customer ( c_id int, c_d_id int, c_w_id int, c_first varchar(16), c_middle char(2), c_last varchar(16), c_street_1 varchar(20), c_street_2 varchar(20), c_city varchar(20), c_state char(2), c_zip char(9), c_phone char(16), c_since timestamp, c_credit char(2), c_credit_lim numeric(12,2), c_discount numeric(4,4), c_balance numeric(12,2), c_ytd_payment numeric(12,2), c_payment_cnt int, c_delivery_cnt int, c_data varchar(500));"


gsql -d ${dbName2} -p ${cnPort} -U ${user} -W ${password} -c "copy customer  from '/opt/software/onlineexpansiondata/customer0_0' with csv null '';"
gsql -d ${dbName2} -p ${cnPort} -U ${user} -W ${password} -c "copy customer  from '/opt/software/onlineexpansiondata/customer0_0' with csv null '';"


gsql -d ${dbName2} -p ${cnPort} -U ${user} -W ${password} -c "select count(*) from customer;"
gsql -d ${dbName2} -p ${cnPort} -U ${user} -W ${password} -c "select pg_size_pretty(pg_relation_size('customer'));"



echo "--------------------prepare a table with testschema--------------------"
gsql -d ${dbName2} -p ${cnPort} -U ${user} -W ${password} -c "create schema testschema;"
gsql -d ${dbName2} -p ${cnPort} -U ${user} -W ${password} -c "create table testschema.tb1 (id int);"
gsql -d ${dbName2} -p ${cnPort} -U ${user} -W ${password} -c "insert into testschema.tb1 values (generate_series(1,100));"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "select count(*) from testschema.tb1;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "select pg_size_pretty(pg_relation_size('testschema.tb1'));"


echo "--------------------prepare a table with userschema--------------------"
gsql -d ${dbName2} -p ${cnPort} -U ${user} -W ${password} -c "create table ${user}.tb1 (id int);"
gsql -d ${dbName2} -p ${cnPort} -U ${user} -W ${password} -c "insert into ${user}.tb1 values (generate_series(1,100));"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "select count(*) from ${user}.tb1;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "select pg_size_pretty(pg_relation_size('${user}.tb1'));"



dbName3=testdb2

echo "--------------------prepare a table with data from copy statement--------------------"

gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "create database testdb2;"

gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "drop table if exists customer2;"

gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "CREATE TABLE Customer2 ( c_id int, c_d_id int, c_w_id int, c_first varchar(16), c_middle char(2), c_last varchar(16), c_street_1 varchar(20), c_street_2 varchar(20), c_city varchar(20), c_state char(2), c_zip char(9), c_phone char(16), c_since timestamp, c_credit char(2), c_credit_lim numeric(12,2), c_discount numeric(4,4), c_balance numeric(12,2), c_ytd_payment numeric(12,2), c_payment_cnt int, c_delivery_cnt int, c_data varchar(500));"


gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "copy customer2  from '/opt/software/onlineexpansiondata/customer0_0' with csv null '';"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "copy customer2  from '/opt/software/onlineexpansiondata/customer0_0' with csv null '';"

gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "select count(*) from customer2;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "select pg_size_pretty(pg_relation_size('customer2'));"



echo "--------------------prepare partition tables--------------------"

echo "--------------------prepare partition table tt0--------------------"

gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "drop table if exists tt0;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "create table tt0(c1 int, c2 int) distribute by hash (c1) PARTITION BY RANGE (c2) (partition p0 values less than (10), partition p1 values less than (20), partition p2 values less than (30), partition p3 values less than (maxvalue));"

echo "--------------------prepare partition table tt1--------------------"

gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "drop table if exists tt1;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "create table tt1(c1 int, c2 int) distribute by hash (c1)
PARTITION BY RANGE (c2)
(
        partition p0 values less than (10),
        partition p1 values less than (20),
        partition p2 values less than (30),
        partition p3 values less than (maxvalue)
);"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt1 values (generate_series(1,100), generate_series(1,100));"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt1 select * from tt1;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt1 select * from tt1;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt1 select * from tt1;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt1 select * from tt1;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt1 select * from tt1;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt1 select * from tt1;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "select count(*) from tt1;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "select pg_size_pretty(pg_relation_size('tt1'));"


echo "--------------------prepare partition table tt2--------------------"

gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "drop table if exists tt2;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "create table tt2(c1 int, c2 int) with(orientation = column) distribute by hash (c1)
PARTITION BY RANGE (c2)
(
        partition p0 values less than (10),
        partition p1 values less than (20),
        partition p2 values less than (30),
        partition p3 values less than (maxvalue)
);"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt2 values (generate_series(1,100), generate_series(1,100));"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt2 select * from tt2;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt2 select * from tt2;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt2 select * from tt2;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt2 select * from tt2;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt2 select * from tt2;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt2 select * from tt2;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "select count(*) from tt2;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "select pg_size_pretty(pg_relation_size('tt2'));"


echo "--------------------prepare partition table tt3--------------------"

gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "drop table if exists tt3;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "create table tt3(c1 int, c2 int) with(orientation = column) distribute by hash (c1)
PARTITION BY RANGE (c2)
(
        partition p0 values less than (10),
        partition p1 values less than (20),
        partition p2 values less than (30),
        partition p3 values less than (maxvalue)
);"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt3 values (generate_series(1,100), generate_series(1,100));"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt3 select * from tt3;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt3 select * from tt3;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt3 select * from tt3;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt3 select * from tt3;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt3 select * from tt3;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "insert into tt3 select * from tt3;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "select count(*) from tt3;"
gsql -d ${dbName3} -p ${cnPort} -U ${user} -W ${password} -c "select pg_size_pretty(pg_relation_size('tt3'));"



#for i in {1..${tabnum}}   
## dollar sign "$" cannot be correctly recognized within curly brackets, so we use another form of for-cycle in which loop body is embraced by two levels of brackets.
for((i=1;i<${dbnum}+1;i++))
do
echo "--------------------create db${i}--------------------"
gsql -d ${dbName} -p ${cnPort} -U ${user} -W ${password} -c "drop database if exists db${i};create database db${i};"
done



:<<!


echo "--------------------prepare special objects for table tb${i}--------------------"

#for i in {1..${tabnum}}
for((i=1;i<${tabnum}+1;i++))
do
echo "--------------------create view tbview${i}--------------------"
gsql -d ${dbName} -p ${cnPort} -c "create view tbview${i} as select * from tb${i};"   # create view tbview as select * from tb1;
done

for((i=1;i<2;i++))
do
echo "--------------------create function--------------------"
gsql -d ${dbName} -p ${cnPort} -c "CREATE FUNCTION less_than(a text, b text) RETURNS boolean AS $$ BEGIN RETURN a < b; END;$$ LANGUAGE plpgsql;"
done



for((i=1;i<2;i++))
do
echo "--------------------create rule--------------------"
gsql -d ${dbName} -p ${cnPort} -c "drop table if exists shoelace_log;"
gsql -d ${dbName} -p ${cnPort} -c "drop table if exists shoelace_data;"
gsql -d ${dbName} -p ${cnPort} -c "CREATE TABLE shoelace_log (sl_name text, sl_avail integer, log_who text,log_when timestamp);"
gsql -d ${dbName} -p ${cnPort} -c "CREATE TABLE shoelace_data (sl_name text, sl_avail integer, sl_color text, sl_len real, sl_unit text);"
gsql -d ${dbName} -p ${cnPort} -c "CREATE RULE log_shoelace AS ON UPDATE TO shoelace_data WHERE NEW.sl_avail <> OLD.sl_avail DO INSERT INTO shoelace_log VALUES (NEW.sl_name, NEW.sl_avail, current_user, current_timestamp);"
done

!

