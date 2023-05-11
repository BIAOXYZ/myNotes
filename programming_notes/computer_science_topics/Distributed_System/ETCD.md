

# ETCD官方

ETCD https://coreos.com/etcd/  -->  现在会重定向到 https://etcd.io/ 了，反正都一样。

Demo https://coreos.com/etcd/docs/latest/demo.html

Administration https://coreos.com/etcd/docs/latest/v2/admin_guide.html

etcd playground http://play.etcd.io || https://github.com/etcd-io/etcdlabs
- http://play.etcd.io/install

--------------------------------------------------

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# ETCD命令

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# ETCD general

Etcd官方文档中文版 http://etcd.doczh.cn/ ||| from 技术文档中文版 https://doczh.cn/
- 理解失败 http://etcd.doczh.cn/documentation/op-guide/failures.html
  * > 『网络分区类似少数跟随者失败或者 leader 失败。网络分区将 etcd 集群分成两个部分; 一个有多数成员而另外一个有少数成员。多数这边变成可用集群而少数这边不可用。在 etcd 中没有 "脑裂"。』 --> 个人理解脑裂一般会出现多主，而etcd出现网络分区后因为最多只有一个分区能达到多数成员，所以至多只会出现一个master，因此不会出现脑裂。
- 为什么是etcd? http://etcd.doczh.cn/documentation/learning/why.html || etcd versus other key-value stores https://etcd.io/docs/v3.3.12/learning/why/
  * > 『"etcd"这个名字源于两个想法，即　unix "/etc" 文件夹和分布式系统"d"istibuted。 "/etc" 文件夹为单个系统存储配置数据的地方，而 etcd 存储大规模分布式系统的配置信息。因此，"d"istibuted　的 "/etc" ，是为 "etcd"。』

Etcd 使用入门 https://www.hi-linux.com/posts/40915.html

etcd 使用入门 https://cizixs.com/2016/08/02/intro-to-etcd/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# ETCD源码

raft 学习笔记 https://github.com/lkk2003rty/notes/blob/master/raft.md
> "raft 从何学起呢？工欲善其事，必先利其器。当然首先看 paper 啦。主要的 paper 有两个 raft 和 thesis。相关的资料站点为 https://raft.github.io/。要是嫌弃这个站点 raft 的可视化做得不带好，还有一个比较详细的 http://thesecretlivesofdata.com/raft/ 可以看。"

深入解读Raft算法与etcd工程实现 https://mp.weixin.qq.com/s/x-AdmN0UN5KT58XWO1BCOA

彻底理解 Raft 共识算法及 etcd/raft 源码解析 https://mp.weixin.qq.com/s/KGQYNayiSWeqs2hGyRACWw

Etcd 架构与实现解析 http://jolestar.com/etcd-architecture/

高可用分布式存储 etcd 的实现原理 https://draveness.me/etcd-introduction

etcd分布式锁的实现方式 https://www.myway5.com/index.php/2019/10/09/etcd%e5%88%86%e5%b8%83%e5%bc%8f%e9%94%81%e7%9a%84%e5%ae%9e%e7%8e%b0%e6%96%b9%e5%bc%8f/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# ETCD related projects

Kine (Kine is not etcd) -- Run Kubernetes on MySQL, Postgres, sqlite, dqlite, not etcd. https://github.com/rancher/kine

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# ETCD其他

etcd简介 https://blog.csdn.net/mnasd/article/details/79621155

etcd 集群大小迷思 https://www.yangcs.net/posts/etcd-cluster-number/
> "etcd 使用 raft 协议保证各个节点之间的状态一致。根据 raft 算法原理，节点数目越多，会降低集群的写性能。这是因为每一次写操作，需要集群中大多数节点将日志落盘成功后，Leader 节点才能将修改内部状态机，并返回将结果返回给客户端。但是根据 etcd 分布式数据冗余策略，集群节点越多，容错能力(Failure Tolerance)越强。所以关于集群大小的优化，其实就是容错和写性能的一个平衡。"

从零开始入门 K8s：手把手带你理解 etcd https://www.infoq.cn/article/zqzelyy57xgvb6ecxcfb || https://cloud.tencent.com/developer/news/491089

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# ETCD应用

探索Kubernetes在ETCD中保存数据的规范 https://jingwei.link/2018/11/25/kubernetes-etcd-data-save-specification.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# etcdctl

## 两个版本的etcdctl API对比

```
[root@cloudsec2 files]# etcdctl -h
NAME:
   etcdctl - A simple command line client for etcd.

WARNING:
   Environment variable ETCDCTL_API is not set; defaults to etcdctl v2.
   Set environment variable ETCDCTL_API=3 to use v3 API or ETCDCTL_API=2 to use v2 API.

USAGE:
   etcdctl [global options] command [command options] [arguments...]

VERSION:
   3.3.10

COMMANDS:
     backup          backup an etcd directory
     cluster-health  check the health of the etcd cluster
     mk              make a new key with a given value
     mkdir           make a new directory
     rm              remove a key or a directory
     rmdir           removes the key if it is an empty directory or a key-value pair
     get             retrieve the value of a key
     ls              retrieve a directory
     set             set the value of a key
     setdir          create a new directory or update an existing directory TTL
     update          update an existing key with a given value
     updatedir       update an existing directory
     watch           watch a key for changes
     exec-watch      watch a key for changes and exec an executable
     member          member add, remove and list subcommands
     user            user add, grant and revoke subcommands
     role            role add, grant and revoke subcommands
     auth            overall auth controls
     help, h         Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --debug                          output cURL commands which can be used to reproduce the request
   --no-sync                        don't synchronize cluster information before sending request
   --output simple, -o simple       output response in the given format (simple, `extended` or `json`) (default: "simple")
   --discovery-srv value, -D value  domain name to query for SRV records describing cluster endpoints
   --insecure-discovery             accept insecure SRV records describing cluster endpoints
   --peers value, -C value          DEPRECATED - "--endpoints" should be used instead
   --endpoint value                 DEPRECATED - "--endpoints" should be used instead
   --endpoints value                a comma-delimited list of machine addresses in the cluster (default: "http://127.0.0.1:2379,http://127.0.0.1:4001")
   --cert-file value                identify HTTPS client using this SSL certificate file
   --key-file value                 identify HTTPS client using this SSL key file
   --ca-file value                  verify certificates of HTTPS-enabled servers using this CA bundle
   --username value, -u value       provide username[:password] and prompt if password is not supplied.
   --timeout value                  connection timeout per request (default: 2s)
   --total-timeout value            timeout for the command execution (except watch) (default: 5s)
   --help, -h                       show help
   --version, -v                    print the version

```

```
[root@cloudsec3 ~]# etcdctl -h
NAME:
        etcdctl - A simple command line client for etcd3.

USAGE:
        etcdctl

VERSION:
        3.3.10

API VERSION:
        3.3


COMMANDS:
        get                     Gets the key or a range of keys
        put                     Puts the given key into the store
        del                     Removes the specified key or range of keys [key, range_end)
        txn                     Txn processes all the requests in one transaction
        compaction              Compacts the event history in etcd
        alarm disarm            Disarms all alarms
        alarm list              Lists all alarms
        defrag                  Defragments the storage of the etcd members with given endpoints
        endpoint health         Checks the healthiness of endpoints specified in `--endpoints` flag
        endpoint status         Prints out the status of endpoints specified in `--endpoints` flag
        endpoint hashkv         Prints the KV history hash for each endpoint in --endpoints
        move-leader             Transfers leadership to another etcd cluster member.
        watch                   Watches events stream on keys or prefixes
        version                 Prints the version of etcdctl
        lease grant             Creates leases
        lease revoke            Revokes leases
        lease timetolive        Get lease information
        lease list              List all active leases
        lease keep-alive        Keeps leases alive (renew)
        member add              Adds a member into the cluster
        member remove           Removes a member from the cluster
        member update           Updates a member in the cluster
        member list             Lists all members in the cluster
        snapshot save           Stores an etcd node backend snapshot to a given file
        snapshot restore        Restores an etcd member snapshot to an etcd directory
        snapshot status         Gets backend snapshot status of a given file
        make-mirror             Makes a mirror at the destination etcd cluster
        migrate                 Migrates keys in a v2 store to a mvcc store
        lock                    Acquires a named lock
        elect                   Observes and participates in leader election
        auth enable             Enables authentication
        auth disable            Disables authentication
        user add                Adds a new user
        user delete             Deletes a user
        user get                Gets detailed information of a user
        user list               Lists all users
        user passwd             Changes password of user
        user grant-role         Grants a role to a user
        user revoke-role        Revokes a role from a user
        role add                Adds a new role
        role delete             Deletes a role
        role get                Gets detailed information of a role
        role list               Lists all roles
        role grant-permission   Grants a key to a role
        role revoke-permission  Revokes a key from a role
        check perf              Check the performance of the etcd cluster
        help                    Help about any command

OPTIONS:
      --cacert=""                               verify certificates of TLS-enabled secure servers using this CA bundle
      --cert=""                                 identify secure client using this TLS certificate file
      --command-timeout=5s                      timeout for short running command (excluding dial timeout)
      --debug[=false]                           enable client-side debug logging
      --dial-timeout=2s                         dial timeout for client connections
  -d, --discovery-srv=""                        domain name to query for SRV records describing cluster endpoints
      --endpoints=[127.0.0.1:2379]              gRPC endpoints
      --hex[=false]                             print byte strings as hex encoded strings
      --insecure-discovery[=true]               accept insecure SRV records describing cluster endpoints
      --insecure-skip-tls-verify[=false]        skip server certificate verification
      --insecure-transport[=true]               disable transport security for client connections
      --keepalive-time=2s                       keepalive time for client connections
      --keepalive-timeout=6s                    keepalive timeout for client connections
      --key=""                                  identify secure client using this TLS key file
      --user=""                                 username[:password] for authentication (prompt if password is not supplied)
  -w, --write-out="simple"                      set the output format (fields, json, protobuf, simple, table)

```

