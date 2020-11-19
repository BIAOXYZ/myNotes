
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

> By executing the pg_ctl utility with start option, a postgres server process starts up. Then, it allocates a shared memory area in memory, starts various background processes, starts replication associated processes and background worker processes if necessary, and waits for connection requests from clients. Whenever receiving a connection request from a client, it starts a backend process. (And then, the started backend process handles all queries issued by the connected client.) || `带start参数执行pg_ctl实用程序会启动一个postgres服务器进程。它会在内存中分配共享内存区域，启动各种后台进程，如有必要还会启动复制相关进程与后台工作进程，并等待来自客户端的连接请求。每当接收到来自客户端的连接请求时，它都会启动一个后端进程，然后由启动的后端进程处理该客户端发出的所有查询。`

> A postgres server process listens to one network port, the default port is 5432. Although more than one PostgreSQL server can be run on the same host, each server should be set to listen to different port number in each other, e.g., 5432, 5433, etc. || `一个postgres服务器进程只会监听一个网络端口，默认端口为5432。如果要在同一台主机上运行多个PostgreSQL服务器，则应为每个服务器配置不同的监听端口，如5432、5433等。`

### 2.1.2. Backend Processes || 2.1.2 后端进程

> A backend process, which is also called postgres, is started by the postgres server process and handles all queries issued by one connected client. It communicates with the client by a single TCP connection, and terminates when the client gets disconnected. || `每个后端进程（也称为“postgres”）由 postgres 服务器进程启动，并处理连接另一侧的客户端发出的所有查询。它通过单条TCP连接与客户端通信，并在客户端断开连接时终止。`

> As it is allowed to operate only one database, you have to specify a database you want to use explicitly when connecting to a PostgreSQL server. || `因为一条连接只允许操作一个数据库，所以必须在连接到PostgreSQL服务器时显式地指定要连接的数据库。`

> PostgreSQL allows multiple clients to connect simultaneously; the configuration parameter max_connections controls the maximum number of the clients (default is 100). || `PostgreSQL允许多个客户端同时连接，配置参数max_connections用于控制最大客户端连接数（默认为100）。`

> If many clients such as WEB applications frequently repeat the connection and disconnection with a PostgreSQL server, it increases both costs of establishing connections and of creating backend processes because PostgreSQL has not implemented a native connection pooling feature. Such circumstance has a negative effect on the performance of database server. To deal with such a case, a pooling middleware (either pgbouncer or pgpool-II) is usually used. || `因为 PostgreSQL 没有原生的连接池功能，所以如果许多客户端频繁地重复与 PostgreSQL服务器建立断开连接（譬如 Web应用），则会导致建立连接与创建后端进程的开销变大。这种情况对数据库服务器的性能有负面影响，通常可以使用池化中间件（pgbouncer或pgpool-II）来避免该问题。`

### 2.1.3. Background Processes || 2.1.3 后台进程

> Table 2.1: background processes. || 表2.1 后台进程

| process |	description | reference |
|--|--|--|
| background writer |	In this process, dirty pages on the shared buffer pool are written to a persistent storage (e.g., HDD, SSD) on a regular basis gradually. (In version 9.1 or earlier, it was also responsible for checkpoint process.) | Section 8.6 |
| checkpointer | In this process in version 9.2 or later, checkpoint process is performed. | Section 8.6, Section 9.7 |
| autovacuum launcher | The autovacuum-worker processes are invoked for vacuum process periodically. (More precisely, it requests to create the autovacuum workers to the postgres server.) | Section 6.5 |
| WAL writer | This process writes and flushes periodically the WAL data on the WAL buffer to persistent storage. | Section 9.9 |
| statistics collector | In this process, statistics information such as for pg_stat_activity and for pg_stat_database, etc. is collected. | | 
| logging collector (logger) | This process writes error messages into log files. | |	 
| archiver | In this process, archiving logging is executed. | Section 9.10 |

> The actual processes of a PostgreSQL server is shown here. In the following example, one postgres server process (pid is 9687), two backend processes (pids are 9697 and 9717) and the several background processes listed in Table 2.1 are running. See also Fig. 2.1. || `这里展示了PostgreSQL服务器包含的实际进程。在以下示例中有1个postgres服务器进程（pid为9687）、2个后端进程（pid为9697和9717）及表2.1中列出的几个后台进程正在运行，详见图2.1。`
```console
postgres> pstree -p 9687
-+= 00001 root /sbin/launchd
 \-+- 09687 postgres /usr/local/pgsql/bin/postgres -D /usr/local/pgsql/data
   |--= 09688 postgres postgres: logger process     
   |--= 09690 postgres postgres: checkpointer process     
   |--= 09691 postgres postgres: writer process     
   |--= 09692 postgres postgres: wal writer process     
   |--= 09693 postgres postgres: autovacuum launcher process     
   |--= 09694 postgres postgres: archiver process     
   |--= 09695 postgres postgres: stats collector process     
   |--= 09697 postgres postgres: postgres sampledb 192.168.1.100(54924) idle  
   \--= 09717 postgres postgres: postgres sampledb 192.168.1.100(54964) idle in transaction  
```

## 2.2. Memory Architecture || 2.2 内存架构

> Memory architecture in PostgreSQL can be classified into two broad categories: || `PostgreSQL的内存架构可以分为两个部分：`
- Local memory area – allocated by each backend process for its own use. || `本地内存区域——由每个后端进程分配，供自己使用。`
- Shared memory area – used by all processes of a PostgreSQL server. || `共享内存区域——供PostgreSQL服务器的所有进程使用。`

> Fig. 2.2. Memory architecture in PostgreSQL. || 图2.2 PostgreSQL的内存架构
![](http://www.interdb.jp/pg/img/fig-2-02.png)

### 2.2.1. Local Memory Area

> Each backend process allocates a local memory area for query processing; each area is divided into several sub-areas – whose sizes are either fixed or variable. Table 2.2 shows a list of the major sub-areas. The details will be described in the following chapters. || `每个后端进程都会分配一块本地内存区域用于查询处理。该区域会分为几个子区域 —— 子区域的大小有的固定，有的可变。表2.2 列出了主要的子区域。更多详细内容将在后续章节中介绍。`

> Table 2.2: Local memory area || 表2.2 本地内存区域

| sub-area | description | reference |
|--|--|--|
| work_mem | Executor uses this area for sorting tuples by ORDER BY and DISTINCT operations, and for joining tables by merge-join and hash-join operations. | Chapter 3 |
| maintenance_work_mem | Some kinds of maintenance operations (e.g., VACUUM, REINDEX) use this area. | Section 6.1 |
| temp_buffers | Executor uses this area for storing temporary tables. | |

### 2.2.2. Shared Memory Area || 2.2.2 共享内存区域

> A shared memory area is allocated by a PostgreSQL server when it starts up. This area is also divided into several fix sized sub-areas. Table 2.3 shows a list of the major sub-areas. The details will be described in the following chapters. || `PostgreSQL服务器启动时会分配共享内存区域，该区域分为几个固定大小的子区域。表2.3列出了主要的子区域。更多详细内容将在后续章节中介绍。`

> Table 2.3: Shared memory area || 表2.3 共享内存区域

|sub-area | description | reference |
|--|--|--|
| shared buffer pool | PostgreSQL loads pages within tables and indexes from a persistent storage to here, and operates them directly. | Chapter 8 |
| WAL buffer | To ensure that no data has been lost by server failures, PostgreSQL supports the WAL mechanism. WAL data (also referred to as XLOG records) are transaction log in PostgreSQL; and WAL buffer is a buffering area of the WAL data before writing to a persistent storage. | Chapter 9 |
| commit log | Commit Log(CLOG) keeps the states of all transactions (e.g., in_progress,committed,aborted) for Concurrency Control (CC) mechanism. | Section 5.4 |

> In addition to them, PostgreSQL allocates several areas as shown below: || `除了上面这些，PostgreSQL还分配了以下几个区域：`
- Sub-areas for the various access control mechanisms. (e.g., semaphores, lightweight locks, shared and exclusive locks, etc) || `用于访问控制机制的子区域（例如信号量、轻量级锁、共享和排他锁等）。`
- Sub-areas for the various background processes, such as checkpointer and autovacuum. || `各种后台进程使用的子区域，例如checkpointer和autovacuum。`
- Sub-areas for transaction processing such as save-point and two-phase-commit. || `用于事务处理的子区域，例如保存点与两阶段提交（2PC）。`
