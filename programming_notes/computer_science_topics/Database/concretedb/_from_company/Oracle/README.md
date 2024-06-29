

# Oracle general

<<oracle 体系结构 >>
http://blog.csdn.net/wanghai__/article/details/4683983

# Oracle索引

Oracle数据库中B-Tree以及BitMap index 的性能对比 https://blog.csdn.net/renfengjun/article/details/8453999

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

ORACLE用SYS登录报ORA-28009：connection as SYS should be as SYSDBA OR SYSOPER解决方法 https://www.cnblogs.com/zangdalei/p/5483691.html 【起因是重新安装了一下后用下面链接里的办法登录数据库，发现用sys登录不行】
> WINDOWS下使用DOS命令行连接oracle数据库 https://www.jb51.net/article/136785.htm

## Oralce FLASHBACK(闪回)

Oracle 闪回特性(FLASHBACK DATABASE) - CSDN博客
https://blog.csdn.net/leshami/article/details/6100429


# Oracle others

Oracle 砍掉 5000 人 https://mp.weixin.qq.com/s/ZSzd5KZr3isnGDmZ-2ZBPA
- > 2024 年 6 月 24 日，Oracle 在发布的 2024 财年年报，2024 财年收入 530 亿美元，比 2023 财年增长 6.0%；净收益 105 亿美元，比 2023 财年猛增 23%；利润率 20%，比 2023 财年增长 17%。利润率增长来自更高的收入。
- > 年报中承认，美国封禁 TikTok 会损害这家软件公司的收入和利润。
- > 独立投资银行公司 Evercore ISI 的分析师 Kirk Materne 估计，Oracle 来自 TikTok 的年收入可能在 4.8 亿美元至 8 亿美元之间。
- > Oracle 为 TikTok 提供云基础设施，而 TikTok 在美国拥有逾 1.5 亿用户。
- > 截至 2024 年 5 月 31 日，Oracle 雇有约 159000 名全日职员工，其中约 58000 人在美国，约 101000 人在全球其他国家。
- > 相比之下，在 2023 财年（截至 2023 年 5 月 31 日），Oracle 雇有约 164000 名全日职员工，其中约 62000 人在美国，约 102000 人在全球其他国家。

程序员吐槽：我永远不会再为 Oracle 工作了 - Oracle 甲骨文 - cnBeta.COM https://www.cnbeta.com/articles/tech/789179.htm || https://cloud.tencent.com/developer/news/356372 || Oracle 程序员吐槽：永远不会再为 Oracle 工作了 ！ https://mp.weixin.qq.com/s/qdSlOb4JaECwUIOdspVYjQ || https://www.sohu.com/a/276319163_465914
- > 近日，某网友在 Hacker News 上发起了一个 “[你见过的最糟糕的代码是什么？](https://news.ycombinator.com/item?id=18442637)” 的问题，引起了广泛关注和讨论，评论数已接近600条。其中，一位 ID 为“oraguy”的程序员对 Oracle 数据库代码的吐槽，更是引发热议。内容大意如下： 
