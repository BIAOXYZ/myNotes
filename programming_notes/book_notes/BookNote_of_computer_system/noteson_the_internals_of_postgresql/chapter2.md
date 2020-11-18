
# [Chapter 2 Process and Memory Architecture](http://www.interdb.jp/pg/pgsql02.html) || 第2章 进程和内存架构

## 2.1. Process Architecture || 2.1 进程架构

> PostgreSQL is a client/server type relational database management system with the multi-process architecture and runs on a single host. || `PostgreSQL是一个客户端/服务器风格的关系型数据库管理系统，采用多进程架构，运行在单台主机上。`

> A collection of multiple processes cooperatively managing one database cluster is usually referred to as a 'PostgreSQL server', and it contains the following types of processes: || `我们通常所说的“PostgreSQL 服务器（PostgreSQL Server）”，实际上是一系列协同工作的进程集合，其中包含下列进程：`
- A **postgres server process** is a parent of all processes related to a database cluster management. || `Postgres服务器进程（postgres server process）是所有数据库集簇管理进程的父进程。`
- Each **backend process** handles all queries and statements issued by a connected client. || `每个后端进程（backend process）负责处理客户端发出的查询和语句。`
- Various **background processes** perform processes of each feature (e.g., VACUUM and CHECKPOINT processes) for database management. || `各种后台进程（background process）负责执行各种数据库管理任务（例如清理过程与存档过程）。`
- In the **replication associated processes**, they perform the streaming replication. The details are described in Chapter 11. || `各种复制相关进程（replication associated process）负责流复制，流复制的细节会在第11章中介绍。`
- In the **background worker process** supported from version 9.3, it can perform any processing implemented by users. As not going into detail here, refer to the official document. || `后台工作进程（background worker process）在9.3版本中被引入，它能执行任意由用户实现的处理逻辑。这里不做详述，更多内容请参阅官方文档。`

> Fig. 2.1. An example of the process architecture in PostgreSQL. || `图2.1 PostgreSQL的进程架构示例`
![](http://www.interdb.jp/pg/img/fig-2-01.png)

### 2.1.1. Postgres Server Process || 2.1.1 Postgres服务器进程

> As already described above, a postgres server process is a parent of all in a PostgreSQL server. In the earlier versions, it was called ‘postmaster’. || `如上所述，postgres服务器进程是 PostgreSQL服务器中所有进程的父进程，在早期版本中被称为“postmaster”。`
