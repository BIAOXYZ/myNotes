
# PostgreSQL

### 关于postgresql.auto.conf文件

<<PostgreSQL9.4: 新增 ALTER SYSTEM 命令>> by francs

http://francs3.blog.163.com/blog/static/4057672720144194492582/

<<postgresql之ctid的浅谈>>
http://www.cnblogs.com/lottu/p/5613098.html

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
