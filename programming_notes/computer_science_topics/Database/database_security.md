
Databases vs. encryption https://blog.2ndquadrant.com/databases-vs-encryption/

# CryptDB

CryptDB代码分析1-lua与加密库 - CSDN博客
https://blog.csdn.net/shaoyiwenet/article/details/79377068

Cryptdb学习笔记（0）——初识 - CSDN博客
https://blog.csdn.net/liuyueyi1995/article/details/54892399

# other secure DBs

Jana: Private Data as a Service https://galois.com/project/jana-private-data-as-a-service/

SentinelDB https://logsentinel.com/sentineldb/

# Database Firewall

- KalepsoDB: 1st End-to-End Encrypted DBMS https://www.kalepso.com/
- Imperva https://www.imperva.com/
- HexaTier http://www.hexatier.com/
- 安华云安全(其实就是安华金和) http://www.dbscloud.cn/

# Security of Famous DBs

## DB Security of PostgreSQL

PostgreSQL 辟谣存在任意代码执行漏洞：消息不实 - 安全 - cnBeta.COM https://www.cnbeta.com/articles/tech/836651.htm

PostgreSQL用户密码安全策略管理 https://www.modb.pro/db/21476
- > PostgreSQL提供了一个插件passwordcheck可以满足简单的密码复杂度测验，防止使用过短，或者与包含用户名的密码。

一文读懂PostgreSQL数据库透明数据加密 - 王硕的文章 - 知乎 https://zhuanlan.zhihu.com/p/84829027 || PostgreSQL数据库透明数据加密概述 https://cloud.tencent.com/developer/article/1516612

PG透明加密（from 公众号）：
- 原创|搞懂PostgreSQL数据库透明数据加密之加密算法介绍 https://mp.weixin.qq.com/s/Uyjkx1Op4e-bDW0S9q8ckA 【2020.08.30】 || 原创|搞懂PostgreSQL数据库透明数据加密之加密算法介绍 https://mp.weixin.qq.com/s/TaxE1u3nJH5Dm6OPjcOXiw 【2019.10.09】
- 原创|搞懂PostgreSQL数据库透明数据加密之PG中的TDE https://mp.weixin.qq.com/s/TmciHCEDRMpdNgWfUf4zDw 【2020.08.31】
- 原创|搞懂PostgreSQL数据库透明数据加密之密钥管理介绍 https://mp.weixin.qq.com/s/gPQ5FJDfkeOWn7seVXczYQ 【2020.08.31】

PostgreSQL Transparent Data Encryption tool development https://github.com/nec-postgres/tdeforpg
- Transparent Data Encryption for PostgreSQL `PostgreSQLのセキュリティや保守運用を支えるサブスクリプション` https://jpn.nec.com/tdeforpg/
- Manual(JA) https://github.com/nec-postgres/tdeforpg/wiki/Manual(JA)

Row-level security on distributed tables https://www.citusdata.com/updates/v11-0/#row-level-sec
- > Postgres provides [row security policies](https://www.postgresql.org/docs/current/ddl-rowsecurity.html) that restrict, on a per-user basis, which rows can be returned by normal queries or inserted, updated, or deleted by data modification commands. This feature is also known as Row-Level Security.
- > With Citus 11.0, this feature is available for distributed tables as well.

## DB Security of Oracle

Oracle数据安全解决方案透明数据加密TDE
http://www.linuxidc.com/Linux/2011-12/48689.htm


## DB Security of AWS 

Thread: Explain the difference between HSM and HSA
https://forums.aws.amazon.com/thread.jspa?threadID=232163

破解云中数据管理难题 AWS推新服务亚马逊Macie http://www.techweb.com.cn/cloud/2017-08-16/2574110.shtml 

## DB Security of SQL Server and Azure 

<< SQL SERVER COLUMN LEVEL ENCRYPTION >>
https://info.townsendsecurity.com/sql-server-column-level-encryption
>https://info.townsendsecurity.com/definitive-guide-to-encryption-key-management-fundamentals  

- << Getting Started with Always Encrypted with SSMS >>
https://channel9.msdn.com/Shows/Data-Exposed/Getting-Started-with-Always-Encrypted-with-SSMS
- << Always Encrypted in SQL Server and Azure SQL Database >>
https://channel9.msdn.com/Events/Community-Poland/Data-Community-106/Always-Encrypted
- << Enabling Confidential Computing with Always Encrypted using Enclaves (Early Access Preview) >>
https://blogs.msdn.microsoft.com/sqlsecurity/2017/10/05/enabling-confidential-computing-with-always-encrypted-using-enclaves-early-access-preview/

数据库加密都有什么方式？ https://www.v2ex.com/t/647734
- 参考这篇《使用 SQL Server 2016 的 Always Encrypt 功能防止系統管理員讀取私密性資料》  https://www.uuu.com.tw/Public/content/article/19/20190805.htm
