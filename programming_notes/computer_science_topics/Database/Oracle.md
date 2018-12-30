

# Oracle general

<<oracle 体系结构 >>
http://blog.csdn.net/wanghai__/article/details/4683983


# Oracle存储

<<oracle数据库，表空间和表之间是什么关系？>> http://bbs.csdn.net/topics/320169443
>在sqlserver2000(不好意思,本人只用过2000)服务运行后,里面可以有好几个数据库(包括temp,pubs什么的)
我们可以自己建库和这些并列,一个库可以有好几个不同的数据文件,可以放在不同的驱动器里面,然后在库里面建表,根据我个人的理解,谁建的表关系不大,反正都在这个库里面
> 
>而oracle就不同了,他一个服务就是一个库,库下面是表空间,一个表空间可以有几个不同的数据文件,这点有点象sqlserver的库,然后就是表了,oracle里的表,每个用户有个缺省的表空间,也就是说这个用户建的表会在这个表空间里面,a用户建的表ta,用a用户登录可以直接select * from ta这样访问,而其他用户(有权限的)要用select * from a.ta这样来访问

<<Oracle表空间（tablespaces）>>
http://www.cnblogs.com/fnng/archive/2012/08/12/2634485.html

## Oracle日志相关

RedoLog Checkpoint 和 SCN关系 https://blog.csdn.net/xujinyang/article/details/6829693

## Oracle连接

- <<ORA-12560:TNS:协议器错误>> https://jingyan.baidu.com/article/d71306350fa53b13fdf4753d.html
- <<ORA-01031: insufficient privileges>> https://jingyan.baidu.com/article/8cdccae946893f315413cdf4.html
```
C:\Users\l00384038>sqlplus /nolog

SQL> conn /as sysdba
```

## Oralce FLASHBACK(闪回)

Oracle 闪回特性(FLASHBACK DATABASE) - CSDN博客
https://blog.csdn.net/leshami/article/details/6100429


# Oracle others

程序员吐槽：我永远不会再为 Oracle 工作了 - Oracle 甲骨文 - cnBeta.COM https://www.cnbeta.com/articles/tech/789179.htm