
# [Chapter 2 Process and Memory Architecture](http://www.interdb.jp/pg/pgsql02.html) || 第2章 进程和内存架构

## 2.1. Process Architecture

> PostgreSQL is a client/server type relational database management system with the multi-process architecture and runs on a single host. || `PostgreSQL是一个客户端/服务器风格的关系型数据库管理系统，采用多进程架构，运行在单台主机上。`

> A collection of multiple processes cooperatively managing one database cluster is usually referred to as a 'PostgreSQL server', and it contains the following types of processes: || `我们通常所说的“PostgreSQL 服务器（PostgreSQL Server）”，实际上是一系列协同工作的进程集合，其中包含下列进程：`

> Fig. 2.1. An example of the process architecture in PostgreSQL. || `图2.1 PostgreSQL的进程架构示例`
![](http://www.interdb.jp/pg/img/fig-2-01.png)

### 2.1.1. Postgres Server Process || 2.1.1 Postgres服务器进程

> As already described above, a postgres server process is a parent of all in a PostgreSQL server. In the earlier versions, it was called ‘postmaster’. || `如上所述，postgres服务器进程是 PostgreSQL服务器中所有进程的父进程，在早期版本中被称为“postmaster”。`
