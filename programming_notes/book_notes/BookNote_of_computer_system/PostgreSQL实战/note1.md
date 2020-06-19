
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
> 注意事项
- > 1）出于安全考虑，这个操作系统用户不能是 root或具有操作系统管理权限的账号，例如拥有sudo权限的用户。
- > 2）如果是部署集群，建议配置NTP服务，统一集群中每个节点的操作系统用户的uid和gid，如果集群中某些节点的数据库操作系统用户的uid和gid与其他节点不一致，可以通过groupmod命令和usermod命令进行修改，例如：
  ```sh
  [root@pghost1 ~]$ groupmod -g 1000 postgres
  [root@pghost1 ~]$ usermod -u 1000 -g 1000 postgres
  ```
  
### `###` 1.4.2　创建数据目录
> 作为例子，这里我们不考虑多实例并存的情况，创建`/pgdata/10/data`目录作为数据目录，在data的同级目录创建backups、scripts、archive_wals目录，这几个目录的作用后续章节再详述。

> 将数据目录的属主修改为我们创建的操作系统用户，并且修改数据目录的权限为0700。修改目录权限这一步其实并不需要，因为initdb会回收除PostgreSQL用户之外所有用户的访问权限。但我们应该明确知道数据目录包含所有存储在数据库里的数据，保护这个目录不受未授权的访问非常重要。

### `###` 1.4.3　初始化数据目录
> 因为我们指定了-W参数，所以在初始化的过程中，initdb工具会要求为数据库超级用户创建密码。在initdb的输出中可以看到系统自动创建了template1数据库和postgres数据库，template1是生成其他数据库的模板，postgres数据库是一个默认数据库，用于给用户、工具或者第三方应用提供默认数据库。

> 需要注意一点的是：不要在将要初始化的数据目录中手动创建任何文件，如果数据目录中已经有文件，会有如下错误提示：
```
initdb: directory "/pgdata/10/data" exists but is not empty
If you want to create a new database system, either remove or empty the directory "/pgdata/10/data" or run initdb
with an argument other than "/pgdata/10/data".
```

> 除了使用initdb来初始化数据目录，还可以使用pg_ctl工具进行数据库目录的初始化，用法如下所示：

> 使用官方yum源安装PostgreSQL时会自动创建/var/lib/pgsql/10目录和它的两个子目录：data目录和backups目录。通过service postgresql-10init命令会初始化/var/lib/pgsql/10/data目录作为数据目录。这样很方便，但是可定制性并不好，建议按照上面的步骤初始化数据目录。

## `##` 1.5　启动和停止数据库服务器
> 在使用数据库服务器之前，必须先启动数据库服务器。可以通过service方式、PostgreSQL的命令行工具启动或停止数据库。

### `###` 1.5.2　使用pg_ctl进行管理
> 还可以使用pg_isready工具来检测数据库服务器是否已经允许接受连接：
```sh
[postgres@pghost1 ~]$ /opt/pgsql/bin/pg_isready -p 1921
/tmp:1921 - accepting connections

或者：

/tmp:1921 - no response
```

#### 3.停止数据库
> 其中的“-m”参数控制数据库用什么模式停止，PostgreSQL支持三种停止数据库的模式：smart、fast、immediate，默认为fast模式。
- > smart模式会等待活动的事务提交结束，并等待客户端主动断开连接之后关闭数据库。
- > fast模式则会回滚所有活动的事务，并强制断开客户端的连接之后关闭数据库。
- > immediate模式立即终止所有服务器进程，当下一次数据库启动时它会首先进入恢复状态，一般不推荐使用。

### `###` 1.5.3　其他启动和关闭数据库服务器的方式
> 还有其他一些启动和停止数据库的方式，例如使用postmaster或postgres程序启动数据库，命令如下所示：

> 在PostgreSQL的守护进程postmaster的入口函数中注册了信号处理程序，对SIGINT、SIGTERM、SIGQUIT的处理方式分别对应PostgreSQL的三种关闭方式smart、fast、immediate。因此我们还可以使用kill命令给postgres进程发送SIGTERM、SIGINT、SIGQUIT信号停止数据库，例如使用smart方式关闭数据库的命令如下所示：
```sh
[postgres@pghost1 ~]$ kill -sigterm `head -1 /pgdata/10/data/postmaster.pid`
received smart shutdown request
shutting down
database system is shut down
```
> 通过日志输出可以看到该命令是通过smart关闭数据库的。它内部的原理可以查看PostgreSQL内核相关的书籍或者阅读源码中pqsignal和pmdie相关的代码进行了解。

### `###` 1.5.4　配置开机启动

#### 1.配置服务脚本
> 在源码包的contrib目录中有Linux、FreeBSD、OSX适用的服务脚本，如下所示：
```sh
[root@pghost1 ~]$ ls postgresql-10.0/contrib/start-scripts/
freebsd linux osx
```
> 我们将名称为linux的脚本拷贝到/etc/init.d/目录中，将脚本重命名为postgresql-10，并赋予可执行权限，命令如下所示：

#### 2.设置开机启动
> chkconfig--list命令可以查看PostgreSQL是否是开机启动的，如下所示：
```sh
[root@pghost1 ~]$ chkconfig --list | grep postgresql-10
postgresql-10 0:off 1:off 2:off 3:off 4:off 5:off
```
> chkconfig命令将启用或禁用PostgreSQL开机启动，如下所示：
```sh
[root@pghost1 ~]$ chkconfig postgresql-10 on/off
```

## `##` 1.6　数据库配置基础
