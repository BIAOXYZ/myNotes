
MySQL资源大全中文版 https://github.com/jobbole/awesome-mysql-cn
> 伯乐在线资源频道 http://hao.jobbole.com/

【from draveness】:
- 『浅入浅出』MySQL 和 InnoDB https://draveness.me/mysql-innodb
- 『浅入深出』MySQL 中事务的实现 https://draveness.me/mysql-transaction
- MySQL 索引设计概要 https://draveness.me/sql-index-intro
- MySQL 索引性能分析概要 https://draveness.me/sql-index-performance

《图解MySQL》 https://xiaolincoding.com/mysql/ || 图解MySQL介绍 https://github.com/xiaolincoder/CS-Base/blob/main/mysql/README.md

# mysql存储

MYSQL INNODB 三大特性之双写 https://blog.csdn.net/bohu83/article/details/81252045

InnoDB的功能缺陷及其他 - 赵伟的文章 - 知乎 https://zhuanlan.zhihu.com/p/99007766

# mysql索引

MySQL索引原理，一篇从头到尾讲清楚 https://mp.weixin.qq.com/s/3tlhF7t97mQmhIRrZq21ww

MYSQL-B+TREE索引原理 https://www.jianshu.com/p/486a514b0ded
- > 左边是数据表，一共有两列七条记录，最左边的是数据记录的物理地址（注意逻辑上相邻的记录在磁盘上也并不是一定物理相邻的）。为了加快Col2的查找，可以维护一个右边所示的二叉查找树，每个节点分别包含索引键值和一个指向对应数据记录物理地址的指针，这样就可以运用二叉查找在O(log2n)O(log2n)的复杂度内获取到相应数据。![](https://upload-images.jianshu.io/upload_images/3575048-03fb02c336ddcd7d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/588/format/webp)

# mysql锁

MySQL中的读锁和写锁 https://blog.csdn.net/u013063153/article/details/53432468
- > MyISAM 在执行查询语句(SELECT)前,会自动给涉及的所有表加读锁,在执行更新操作 (UPDATE、DELETE、INSERT 等)前，会自动给涉及的表加写锁，这个过程并不需要用户干预，因此，用户一般不需要直接用LOCK TABLE命令给MyISAM表显式加锁。

2万字+30张图，彻底搞懂MySQL加行级锁！ https://mp.weixin.qq.com/s/sebKS5CGM7lUJstUWAKxEg

# mysql待分类

字节三面：详解一条 SQL 的执行过程 https://mp.weixin.qq.com/s/xVWq3u-rekmg6HNGKRncng || 执行一条SQL后MySQL做了哪些事情.md https://github.com/allentofight/easy-cs/blob/main/MySQL/%E6%89%A7%E8%A1%8C%E4%B8%80%E6%9D%A1SQL%E5%90%8EMySQL%E5%81%9A%E4%BA%86%E5%93%AA%E4%BA%9B%E4%BA%8B%E6%83%85.md

程序员校招必看系列一：MySQL八股文背诵版 https://mp.weixin.qq.com/s/ZjvzhE5kZLyn35ewpobVJQ

MySQL 三万字精华总结 + 面试100 问，吊打面试官绰绰有余 https://mp.weixin.qq.com/s/Zgq_OX6imQMORkqd-HEBsg

# mysql application develop

MySQL Connector/ODBC Developer Guide https://dev.mysql.com/doc/connector-odbc/en/
- Chapter 1 Introduction to MySQL Connector/ODBC https://dev.mysql.com/doc/connector-odbc/en/connector-odbc-introduction.html
- Chapter 5 Configuring Connector/ODBC https://dev.mysql.com/doc/connector-odbc/en/connector-odbc-configuration.html

25.2. MySQL C API https://www.mysqlzh.com/doc/196.html
- 25.2.2. C API函数概述 https://www.mysqlzh.com/doc/196/114.html

Chapter 1 Introduction to Connector/C++ https://docs.oracle.com/cd/E17952_01/connector-cpp-8.0-en/connector-cpp-introduction.html

使用MySQL Connector/C(libmysqlclient) 连接MySQL服务器 https://blog.csdn.net/shuxiaogd/article/details/47778357
- > MySQL实现了三种Connector用于C/C++ 客户端程序来访问MySQL服务器：`Connector/ODBC`, `Connector/C++`(`JDBC`)以及`Connector/C`(`libmysqlclient`)。

C++操作mysql方法总结（1) https://www.cnblogs.com/magicsoar/p/3817518.html

libmysqlclient 使用浅析 https://blog.lucode.net/backend-development/libmysqlclient-usage.html
