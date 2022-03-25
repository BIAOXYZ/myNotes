
# 数据库相关

PostgreSQL 从文件时间戳获悉一些信息(如数据库创建时间) https://developer.aliyun.com/article/590345
- > 使用SQL查询所有数据库的创建时间，取modification。
  ```sql
  select   
  datname,  
  (pg_stat_file(format('%s/%s/PG_VERSION',  
  case   
    when spcname='pg_default' then 'base'   
    else 'pg_tblspc/'||t2.oid||'/PG_11_201804061/'    
  end,  
  t1.oid))).*    
  from   
  pg_database t1,    
  pg_tablespace t2   
  where t1.dattablespace=t2.oid;  
  ```
  ```console
    datname  | size |         access         |      modification      |         change         | creation | isdir   
  -----------+------+------------------------+------------------------+------------------------+----------+-------  
   postgres  |    3 | 2018-04-07 17:07:05+08 | 2018-04-07 17:07:05+08 | 2018-04-07 17:07:05+08 |          | f  
   test      |    3 | 2018-04-13 16:30:08+08 | 2018-04-13 16:30:08+08 | 2018-04-13 16:30:08+08 |          | f  
   template1 |    3 | 2018-04-07 17:07:02+08 | 2018-04-07 17:07:02+08 | 2018-04-07 17:07:02+08 |          | f  
   template0 |    3 | 2018-04-07 17:07:05+08 | 2018-04-07 17:07:05+08 | 2018-04-07 17:07:05+08 |          | f  
  (4 rows)  
  ```
- > 但是，它对表的创建时间是无法准确获得的，原因如下：
  * > 1、access time，mount atime=off 的话，不记录atime
  * > 2、注意表在rewrite(例如truncate, 导致rewrite的alter)后，会产生新的filenode，所以即使access time不变，也不完全准确。
  * > 3、touch文件，会改变access time
