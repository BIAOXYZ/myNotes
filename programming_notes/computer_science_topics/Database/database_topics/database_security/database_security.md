
Databases vs. encryption https://blog.2ndquadrant.com/databases-vs-encryption/

# CryptDB

CryptDB代码分析1-lua与加密库 - CSDN博客
https://blog.csdn.net/shaoyiwenet/article/details/79377068

Cryptdb学习笔记（0）——初识 - CSDN博客
https://blog.csdn.net/liuyueyi1995/article/details/54892399

Cryptdb的设计与实现 https://yiwenshao.github.io/categories/Cryptdb%E7%9A%84%E8%AE%BE%E8%AE%A1%E4%B8%8E%E5%AE%9E%E7%8E%B0/
- Cryptdb原理概述(1) https://yiwenshao.github.io/2017/05/01/Cryptdb%E5%8E%9F%E7%90%86%E6%A6%82%E8%BF%B0/
- CryptDB代码分析5-底层加密库与加密层 https://yiwenshao.github.io/2018/03/25/CryptDB%E4%BB%A3%E7%A0%81%E5%88%86%E6%9E%905-%E5%BA%95%E5%B1%82%E5%8A%A0%E5%AF%86%E5%BA%93%E4%B8%8E%E5%8A%A0%E5%AF%86%E5%B1%82/

Re-implementing CryptDB https://medium.com/princeton-systems-course/re-implementing-cryptdb-dbb8c582e9d9
- The source code for our project can be found at https://github.com/somanayr/cs518-cryptdb .

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# other secure DBs

Jana: Private Data as a Service https://galois.com/project/jana-private-data-as-a-service/

SentinelDB https://logsentinel.com/sentineldb/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Database Firewall

- KalepsoDB: 1st End-to-End Encrypted DBMS https://www.kalepso.com/
- Imperva https://www.imperva.com/
- HexaTier http://www.hexatier.com/
- 安华云安全(其实就是安华金和) http://www.dbscloud.cn/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Security of Famous DBs

## DB Security of PostgreSQL

PostgreSQL 辟谣存在任意代码执行漏洞：消息不实 - 安全 - cnBeta.COM https://www.cnbeta.com/articles/tech/836651.htm

PostgreSQL用户密码安全策略管理 https://www.modb.pro/db/21476
- > PostgreSQL提供了一个插件passwordcheck可以满足简单的密码复杂度测验，防止使用过短，或者与包含用户名的密码。

一文读懂PostgreSQL数据库透明数据加密 - 王硕的文章 - 知乎 https://zhuanlan.zhihu.com/p/84829027 || PostgreSQL数据库透明数据加密概述 https://cloud.tencent.com/developer/article/1516612
- > **加密等级**
  * > 社区经过多次讨论，目前由于设计难易度以及开发成本的角度，选择了 ***集簇级加密*** 作为TDE的第一个方案。
- > **数据库中如何选择加密模式**
  * > 开发成本：使用openssl自带的加密算法，加密算法开发成本低；其中除ECB外都需要额外的使用向量或计数器，开发成本相当；***<ins>由于CBC和ECB需要进行填充数据</ins>***，考虑到WAL流复制过程，不推荐使用。最优选择为CFB，OFB和CTR。 安全性：ECB不予考虑，其他皆可。 性能：由于是在刷写磁盘时进行加解密，那么考虑到读取和写入的并行要求，以及加密算法的性能，CTR mode是最优选择。 易用性：在此不需要考虑。
    >> 【[:star:][`*`]】 //notes：这里之所以后面三个（`CFB`、`OFB`、`CTR`）不需要padding，是因为它们是 ***<ins>先完成Encrypt，最后一步是XOR</ins>***；而`ECB`和`CBC`是先XOR，最后放进Encrypt函数。
    >>> 我开始也没想明白这点，是看了这个帖子后来才想到的： Why does a padding block exist for ECB and CBC modes? https://crypto.stackexchange.com/questions/71365/why-does-a-padding-block-exist-for-ecb-and-cbc-modes
  * > 以上，从各个层面来说，CTR都是最优的加密mode，社区同样选择了`CTR mode`作为加密模式。
- 回复里的：
  * > 我查了一个帖子，不知道是不是您说的社区讨论，感觉内容很相似，包括里面提到的威胁模型、双层加密之类的，帖子名称为：[[Proposal] Table-level Transparent Data Encryption (TDE) and Key Management Service (KMS)](https://www.postgresql.org/message-id/031401d3f41d$5c70ed90$1552c8b0$@lab.ntt.co.jp)
    >> 这个帖子就是社区加密的原贴。现在换到别的地方了。你可以找找相关的wiki。关于你说的blob的加密，而且是一部分的，我想这没什么问题，索引之所以有风险是因为他的顺序暴露些信息。

[[Proposal] Table-level Transparent Data Encryption (TDE) and Key Management Service (KMS)](https://www.postgresql.org/message-id/031401d3f41d$5c70ed90$1552c8b0$@lab.ntt.co.jp)
- > In `KMIP protocol` and most KMS manage keys by string IDs. We can get keys by key ID from KMS. <br> So in my proposal, all master keys are distinguished by its ID, called "master key ID". <br> The master key ID is made, for example, using the database oid and a sequence number, like `<OID>_<SeqNo>`. And they are managed in PostgreSQL. <br> When database startup, all master key ID is ***loaded to shared memory***, and they are protected by `LWLock`. <br> When it comes time to rotate the master keys, run this query.
- > If we encrypt all WAL records, performance overhead can be significant. <br> Therefore, this proposes a method to encrypt only WAL record excluding WAL header when writing WAL on the WAL buffer, instead of encrypting a whole WAL record.
- 回复邮件：
  * Re: [Proposal] Table-level Transparent Data Encryption (TDE) and Key Management Service (KMS) at 2018-05-29 06:22:31 from Antonin Houska https://www.postgresql.org/message-id/4968.1527574951%40localhost
    + > This patch seems to implement some of the features you propose, especially encryption of buffers and WAL. I recommend you to check so that no effort is duplicated: [WIP: Data at rest encryption](https://www.postgresql.org/message-id/CA+CSw_tb3bk5i7if6inZFc3yyf+9HEVNTy51QFBoeUk7UE_V=w@mail.gmail.com)

PG透明加密（from 公众号）：
- 原创|搞懂PostgreSQL数据库透明数据加密之加密算法介绍 https://mp.weixin.qq.com/s/Uyjkx1Op4e-bDW0S9q8ckA 【2020.08.30】 || 原创|搞懂PostgreSQL数据库透明数据加密之加密算法介绍 https://mp.weixin.qq.com/s/TaxE1u3nJH5Dm6OPjcOXiw 【2019.10.09】
- 原创|搞懂PostgreSQL数据库透明数据加密之PG中的TDE https://mp.weixin.qq.com/s/TmciHCEDRMpdNgWfUf4zDw 【2020.08.31】【和上面知乎那个是同一篇】
- 原创|搞懂PostgreSQL数据库透明数据加密之密钥管理介绍 https://mp.weixin.qq.com/s/gPQ5FJDfkeOWn7seVXczYQ 【2020.08.31】
- Transparent Data Encryption https://wiki.postgresql.org/wiki/Transparent_Data_Encryption
- A Guide to Transparent Data Encryption in PostgreSQL https://arctype.com/blog/transparent-data-encryption/
- Thread: Transparent Data Encryption in PostgreSQL? https://postgrespro.com/list/thread-id/2527981
  * > `There is at least one fork with TDE, which maybe is what your colleague is thinking of, but it doesn't exist in the community code today. Various people are interested in merging the feature.  At this point I'd lay odds against it being ready for v14, but perhaps it will happen for v15. regards, tom lane`
  * > `Oh, Cybertec has an open source version of Postgres 12.3 with TDE:`
    + > https://www.cybertec-postgresql.com/en/products/postgresql-transparent-data-encryption/
    + > https://www.cybertec-postgresql.com/en/transparent-data-encryption-installation-guide/
    > `and Postgres 12.3 was released on 2020-05-14, and their TDE version was packaged on 2020-07-10, based on the tarball file dates. Their TDE feature is not part of community Postgres, and I don't if that will ever happen.`
  * > `Yeah, we could get the key management into PG 14, but it wouldn't do anything, so it would have to be hidden so it didn't confuse people, so what's the point of adding it now?  Also, I don't know anyone who is currently working on the data encryption stage, which is the next step.`

PostgreSQL Transparent Data Encryption tool development https://github.com/nec-postgres/tdeforpg
- Transparent Data Encryption for PostgreSQL `PostgreSQLのセキュリティや保守運用を支えるサブスクリプション` https://jpn.nec.com/tdeforpg/
- Manual(JA) https://github.com/nec-postgres/tdeforpg/wiki/Manual(JA)

Row-level security on distributed tables https://www.citusdata.com/updates/v11-0/#row-level-sec
- > Postgres provides [row security policies](https://www.postgresql.org/docs/current/ddl-rowsecurity.html) that restrict, on a per-user basis, which rows can be returned by normal queries or inserted, updated, or deleted by data modification commands. This feature is also known as Row-Level Security.
- > With Citus 11.0, this feature is available for distributed tables as well.

## DB Security of MySQL

图文实录｜MySQL技术分享：MySQL的数据加密 https://mp.weixin.qq.com/s/SqW8kExiuLRcBy8KbeFXiw
- > 本文金句：为了保证数据安全，MySQL支持了`透明加密`，`函数加密`等特性，其中尤其是透明加密为所有落盘数据提供了充分的安全保障。
- > **1 数据加密简介**
  * > MySQL也提供了多种方式的加密来保证数据安全，主要包括：
    + > 函数加密：通过提供若干加密函数的方式来对敏感数据进行编码处理，防止明文数据泄露；下图即为MySQL企业级函数加密的示意图。
    + > `透明数据加密`：在存储引擎中对数据进行加密，用户无感知。所有落盘数据都可加密。这个特性是MySQL在安全方面非常重要的一个特性，后面的分享我们将会对这一特性的原理和实现方法进行详细的介绍。
- > **2 数据加密详解**
  * > 透明数据加密原理（总体设计）：
    + > `MySQL5.7.11`开始支持单表数据透明加密，***`8.0`版本支持所有数据（redo，binlog，relay log等所有落盘数据）加密***。
  * > 总体架构上来说，MySQL采用了双层秘钥的设计：
    + > Tablespace key：表空间秘钥，用于加解密每个数据页，***加密后存放于每个表空间数据`ibd文件`的第一个页***；
    + > Master key：主秘钥，用于加解密各个tablespace key，***存储于`oracle key vault`或者`秘钥文件`中***。
  * > ***双层秘钥的最大好处在于秘钥轮转（key rotation）的时候，不需要把所有数据都解密后再重新加密，而只需要重新加密tablespace key即可***。
  * > `Keyring plugin`插件：
    + > 秘钥接口插件，用于从`Oracle key vault`或`秘钥文件`中获取master key，***并提供接口给存储引擎以获取master key***。
  * > 加解密流程：
    ```console
    如下图所示，透明数据加密的主要流程是：
    1.读取秘钥：InnoDB调用keyring插件接口获取master key并用之解密存储于ibd文件第一页的Tablespace key。解密后的tablespace key置于表空间内存对象fil_space_t中；
    2.加密：在写入每一个数据页的时候，使用fil_space_t对象中的表空间秘钥加密数据页的数据部分；
    3.解密：在读取每一个数据页的时候，使用fil_space_t对象中的表空间秘钥解密数据页的数据部分；
    ```
  * > 其他细节问题：
    + > Master key rotate：由于采用了双层秘钥设计，rotate的时候，只需要使用新的master key将所有表空间的tablespace key重新加密并写入ibd文件的第一页。
    + > 加密表的 import/export：在export的时候随机生成一个临时的 `transfer_key`，***把现有的 tablespace_key 用 transfer_key 加密，<ins>并将两者同时写入 `.cfp` 的文件中</ins>***。Import时会读取transfer_key用来解密tablespace_key，然后执行正常的 import 操作即可。
- > **3 透明数据加密的问题**
  * > 问题1：性能问题：
    + > 5.7早期版本如果使用`yassl`性能下降严重，最高>30%。
    + > 8.0采用openssl后，总体对性能影响不大，但在某些场景下性能影响也比较大，比如：oltp_read_only低并发可能会>10%
    + > 如下图所示：（数据来源：阿里云RDS MySQL TDE测试报告）
  * > 问题2：数据安全问题
    + > `Tablespace key` 放在 `ibd文件` 的固定位置，虽然是经过加密，但也有泄漏的可能；
    + > import/export生成的临时 `transfer_key` 保存在 `.cfp文件` 中，也有泄漏的可能。
- > **4 Q&A**
  * > q1：key rotate 如何保证原子性？
  * > a1：如之前所描述的，key rotate是将各个tablespace key重新加密并写入ibd文件的第一个页面的，***而这个过程是会记录redo log的***。InnoDB除了写入相关的redo log外，还会将当前表的加密信息也写入redo log，比如说master key的版本号等。所以，在发生crash时，可以在recovery的过程中，通过redo log中记录的相关信息来保证key rotate的一致性状态。
  * > q2：Klustron在加密这块做了哪些工作？
  * > a2：Klustron除了支持MySQL已经提供的加密特性外，还实现了落盘数据（包括数据，日志，备份等等）的全流程加密。另外，KunlunBase正在实现对国五加密标准的支持。

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

## DB Security of GaussDB

### 防篡改数据库
>> //notes：看到新闻吓了我一跳，还以为竟然把 verifiability 做到数据库产品里了。后来看了下使用手册里`“账本数据库机制”`部分的内容才知道原来核心是 ***防止用户去篡改***。这。。。motivation 有点不够 strong 啊。你都云数据库了，不更应该防止 server 去篡改嘛。。。

官宣！华为云GaussDB两大数据库通过中国信通院多项评测 https://mp.weixin.qq.com/s/SGq2vnsMCGfZje5BLMjUFg
- > 在防篡改数据库基础能⼒专项评测中，GaussDB(for openGauss)以最高分通过全部二十八项能力评测，包括防篡改能⼒、不可抵赖能⼒、安装适配及兼容能⼒、易⽤性能⼒、信任域能⼒以及⻛险识别能⼒，充分验证了防篡改数据库在保障数据安全⽅⾯的卓越性能。这说明GaussDB(for openGauss)不仅能保障数据在云上的增、删、改全⽣命周期可追溯、可校验，为数据完整性提供更强有⼒的保护，还能极⼤降低⽤户使⽤⻔槛和业务切换的难度，全方位实时保障企业数据安全。

华为云GaussDB（for openGauss）完成中国信通院首个防篡改数据库产品评测 https://bbs.csdn.net/topics/606844977 || https://bbs.huaweicloud.com/forum/forum.php?mod=viewthread&tid=188842

账本数据库机制 https://www.bookstack.cn/read/openGauss-2.1-zh/CharacteristicDescription-%E8%B4%A6%E6%9C%AC%E6%95%B0%E6%8D%AE%E5%BA%93%E6%9C%BA%E5%88%B6.md

### 全密态数据库

全密态数据库 https://docs-opengauss.osinfra.cn/zh/docs/3.1.0/docs/BriefTutorial/%E5%85%A8%E5%AF%86%E6%80%81%E6%95%B0%E6%8D%AE%E5%BA%93.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
