
# PostgreSQL

### 关于postgresql.auto.conf文件

<<PostgreSQL9.4: 新增 ALTER SYSTEM 命令>> by francs

http://francs3.blog.163.com/blog/static/4057672720144194492582/

<<postgresql之ctid的浅谈>>
http://www.cnblogs.com/lottu/p/5613098.html

<<PostgreSQL的autovacuum 与 vacuum full>> by 技术者高健
http://www.cnblogs.com/gaojian/p/3272620.html

### coredump文件

<<详解coredump>>
http://blog.csdn.net/tenfyguo/article/details/8159176

## books

<<The Internals of PostgreSQL - for database administrators and system developers>> by SUZUKI Hironobu

http://www.interdb.jp/pg/



# Oracle


<<oracle数据库，表空间和表之间是什么关系？>>
http://bbs.csdn.net/topics/320169443

>在sqlserver2000(不好意思,本人只用过2000)服务运行后,里面可以有好几个数据库(包括temp,pubs什么的)
我们可以自己建库和这些并列,一个库可以有好几个不同的数据文件,可以放在不同的驱动器里面,然后在库里面建表,根据我个人的理解,谁建的表关系不大,反正都在这个库里面

>而oracle就不同了,他一个服务就是一个库,库下面是表空间,一个表空间可以有几个不同的数据文件,这点有点象sqlserver的库,然后就是表了,oracle里的表,每个用户有个缺省的表空间,也就是说这个用户建的表会在这个表空间里面,a用户建的表ta,用a用户登录可以直接select * from ta这样访问,而其他用户(有权限的)要用select * from a.ta这样来访问


<<oracle 体系结构 >>
http://blog.csdn.net/wanghai__/article/details/4683983

<<Oracle表空间（tablespaces）>>
http://www.cnblogs.com/fnng/archive/2012/08/12/2634485.html


# 一般性的

## 事务

### 两阶段提交

http://blog.jobbole.com/95632/

https://zh.wikipedia.org/zh-hans/%E4%BA%8C%E9%98%B6%E6%AE%B5%E6%8F%90%E4%BA%A4

## 并发管理

### 两阶段锁

https://www.cnblogs.com/zszmhd/p/3365220.html


https://www.2cto.com/database/201403/286730.html

## 索引

<<深入 聚集索引与非聚集索引(一)>>
http://www.cnblogs.com/lwzz/archive/2012/08/05/2620824.html

<<聚集索引和非聚集索引（整理）>>
http://www.cnblogs.com/aspnethot/articles/1504082.html

<<唯一性索引（Unique Index）与普通索引（Normal Index）差异（上）>>
http://blog.itpub.net/17203031/viewspace-700089/




