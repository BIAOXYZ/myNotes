

HBase vs. MongoDB vs. MySQL vs. Oracle vs. Redis，三大主流开源 NoSQL 数据库的 PK 两大主流传统 SQL 数据库 
http://blog.csdn.net/defonds/article/details/48471087

“王者对战”之 MySQL 8 vs PostgreSQL 10 - MySQL - cnBeta.COM https://www.cnbeta.com/articles/tech/737331.htm
- Why Uber Engineering Switched from Postgres to MySQL https://eng.uber.com/mysql-migration/
- MySQL Might Be Right for Uber, but Not for You https://dzone.com/articles/on-ubers-choice-of-databases
- A PostgreSQL Response to Uber http://thebuild.com/presentations/uber-perconalive-2017.pdf

MySQL资源大全中文版 https://github.com/jobbole/awesome-mysql-cn
> 伯乐在线资源频道 http://hao.jobbole.com/

# mysql索引

MYSQL-B+TREE索引原理 https://www.jianshu.com/p/486a514b0ded
- > 左边是数据表，一共有两列七条记录，最左边的是数据记录的物理地址（注意逻辑上相邻的记录在磁盘上也并不是一定物理相邻的）。为了加快Col2的查找，可以维护一个右边所示的二叉查找树，每个节点分别包含索引键值和一个指向对应数据记录物理地址的指针，这样就可以运用二叉查找在O(log2n)O(log2n)的复杂度内获取到相应数据。![](https://upload-images.jianshu.io/upload_images/3575048-03fb02c336ddcd7d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/588/format/webp)
