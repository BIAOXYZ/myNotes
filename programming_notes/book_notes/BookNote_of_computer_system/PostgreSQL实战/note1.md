
# `#` 第1章　安装与配置基础

## `##` 1.1 初识PostgreSQL
> PostgreSQL是由PostgreSQL社区全球志愿者开发团队开发的开源对象-关系型数据库。它源于UC Berkeley大学1977年的Ingres计划，这个项目是由著名的数据库科学家Michael Stonebraker（2015年图灵奖获得者）领导的。在1994年，两个UC Berkeley大学的研究生Andrew Yu和Jolly Chen增加了一个SQL语言解释器来替代早先的基于Ingres的QUEL系统，建立了Postgres95。为了反映数据库的新SQL查询语言特性，Postgres95在1996年重命名为PostgreSQL，并第一次发行了以PostgreSQL命名的6.0版本，在2005年，PostgreSQL发行了以原生方式运行在Windows系统下的8.0版本。随着2010年PostgreSQL 9.0的发行，PostgreSQL进入了黄金发展阶段，目前，PostgreSQL最新的稳定版是PostgreSQL 10。

## `##` 1.2　安装PostgreSQL

### `###` 1.2.1　通过yum源安装

#### 2.安装PostgreSQL
> postgresql10-debuginfo.x86_64：postgresql10的调试信息，如果需要进行DEBUG，可以安装它，生产环境中一般不需要安装；

#### 3.卸载通过yum源安装的PostgreSQL
> 可以使用yum remove命令逐个卸载，最简单粗暴的办法是卸载libs包即可，因为其他几个包都会依赖它，卸载libs包会将其他包一并卸载：`yum remove postgresql10-libs-10.0-1PGDG.rhel6.x86_64`

## `##` 1.3　客户端程序和服务器程序
> share目录存放着PostgreSQL的文档、man、示例文件以及一些扩展，include目录是PostgreSQL的C、C++的头文件，bin目录就是PostgreSQL的应用程序了。PostgreSQL本身是一个C/S架构的程序，这些应用程序可以分为两类：客户端程序和服务器程序

### `###` 1.3.1　客户端程序

#### 1.封装SQL命令的客户端程序
> clusterdb是SQL CLUSTER命令的一个封装。PostgreSQL是堆表存储的，clusterdb通过索引对数据库中基于堆表的物理文件重新排序，它在一定场景下可以节省磁盘访问，加快查询速度。

> reindexdb是SQL REINDEX命令的一个封装。在索引物理文件发生损坏或索引膨胀等情况发生时，可以使用reindexdb命令对指定的表或者数据库重建索引并且删除旧的索引。

> vacuumdb是PostgreSQL数据库独有的VACUUM、VACUUM FREEZE和VACUUM FULL，VACUUM ANALYZE这几个SQL命令的封装。VACUUM系列命令的主要职责是对数据的物理文件等的垃圾回收，是PostgreSQL中非常重要的一系列命令。

> vacuumlo用来清理数据库中未引用的大对象。

#### 2.备份与恢复的客户端程序

#### 3.其他客户端程序
> oid2name解析一个PostgreSQL数据目录中的OID和文件结点，在文件系统章节会详细讲解它。

> pg_receivexlog可以从一个运行中的实例获取事务日志的流。

> pg_recvlogical控制逻辑解码复制槽以及来自这种复制槽的流数据。

> 连接到数据库之后，就进入PostgreSQL的shell界面，如果是用数据库超级用户连接，提示符由数据库名称和“=#”组成，如果是普通的数据库用户，提示符则由数据库名称和“=>”组成。

### `###` 1.3.2　服务器程序

## `##` 1.4　创建数据库实例
### `###` 1.4.1　创建操作系统用户
> 创建系统用户组和用户的命令如下所示：
```sh
[root@pghost1 ~]$ groupadd -g 1000 postgres
[root@pghost1 ~]$ useradd -g 1000 -u 1000 postgres
[root@pghost1 ~]$ id postgres
uid=1000(postgres) gid=1000(postgres) groups=1000(postgres)
```
