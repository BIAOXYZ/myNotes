
# `#` 第1章　安装与配置基础

## `##` 1.1 初识PostgreSQL

> PostgreSQL是由PostgreSQL社区全球志愿者开发团队开发的开源对象-关系型数据库。它源于UC Berkeley大学1977年的Ingres计划，这个项目是由著名的数据库科学家Michael Stonebraker（2015年图灵奖获得者）领导的。在1994年，两个UC Berkeley大学的研究生Andrew Yu和Jolly Chen增加了一个SQL语言解释器来替代早先的基于Ingres的QUEL系统，建立了Postgres95。为了反映数据库的新SQL查询语言特性，Postgres95在1996年重命名为PostgreSQL，并第一次发行了以PostgreSQL命名的6.0版本，在2005年，PostgreSQL发行了以原生方式运行在Windows系统下的8.0版本。随着2010年PostgreSQL 9.0的发行，PostgreSQL进入了黄金发展阶段，目前，PostgreSQL最新的稳定版是PostgreSQL 10。

### `###` 1.2.1　通过yum源安装

> postgresql10-debuginfo.x86_64：postgresql10的调试信息，如果需要进行DEBUG，可以安装它，生产环境中一般不需要安装；

> 可以使用yum remove命令逐个卸载，最简单粗暴的办法是卸载libs包即可，因为其他几个包都会依赖它，卸载libs包会将其他包一并卸载：`yum remove postgresql10-libs-10.0-1PGDG.rhel6.x86_64`

## `##` 1.3　客户端程序和服务器程序

> share目录存放着PostgreSQL的文档、man、示例文件以及一些扩展，include目录是PostgreSQL的C、C++的头文件，bin目录就是PostgreSQL的应用程序了。PostgreSQL本身是一个C/S架构的程序，这些应用程序可以分为两类：客户端程序和服务器程序
