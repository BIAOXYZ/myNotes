
# 官方

https://hub.docker.com/r/apache/hive
```sh
$ export HIVE_VERSION=4.0.0-beta-1
$ docker run -d -p 10000:10000 -p 10002:10002 --env SERVICE_NAME=hiveserver2 --name hive4 apache/hive:${HIVE_VERSION}
...
$ docker run -d -p 9083:9083 --env SERVICE_NAME=metastore --name metastore-standalone apache/hive:${HIVE_VERSION}
...
$ docker exec -it hive4 beeline -u 'jdbc:hive2://localhost:10000/'
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/opt/hive/lib/log4j-slf4j-impl-2.18.0.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/opt/hadoop/share/hadoop/common/lib/slf4j-log4j12-1.7.30.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/opt/hive/lib/log4j-slf4j-impl-2.18.0.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/opt/hadoop/share/hadoop/common/lib/slf4j-log4j12-1.7.30.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]
Connecting to jdbc:hive2://localhost:10000/
Connected to: Apache Hive (version 4.0.0-beta-1)
Driver: Hive JDBC (version 4.0.0-beta-1)
Transaction isolation: TRANSACTION_REPEATABLE_READ
Beeline version 4.0.0-beta-1 by Apache Hive
0: jdbc:hive2://localhost:10000/>
0: jdbc:hive2://localhost:10000/> show tables;
INFO  : Compiling command(queryId=hive_20231217053440_3b0a8c56-20f4-4461-aca0-e4adfd514fdd): show tables
INFO  : Semantic Analysis Completed (retrial = false)
INFO  : Created Hive schema: Schema(fieldSchemas:[FieldSchema(name:tab_name, type:string, comment:from deserializer)], properties:null)
INFO  : Completed compiling command(queryId=hive_20231217053440_3b0a8c56-20f4-4461-aca0-e4adfd514fdd); Time taken: 2.165 seconds
INFO  : Concurrency mode is disabled, not creating a lock manager
INFO  : Executing command(queryId=hive_20231217053440_3b0a8c56-20f4-4461-aca0-e4adfd514fdd): show tables
INFO  : Starting task [Stage-0:DDL] in serial mode
INFO  : Completed executing command(queryId=hive_20231217053440_3b0a8c56-20f4-4461-aca0-e4adfd514fdd); Time taken: 0.081 seconds
+-----------+
| tab_name  |
+-----------+
+-----------+
No rows selected (2.624 seconds)
```

https://hive.apache.org/developement/quickstart/

# 已验证

# 其他

基于docker快速搭建hive环境 https://cloud.tencent.com/developer/article/1668927

使用docker快速搭建hive环境 https://www.cnblogs.com/upupfeng/p/13452385.html
- docker-hive https://github.com/big-data-europe/docker-hive

使用 Docker 搭建 Hadoop + Hive + Spark 集群（上） https://bambrow.com/20210625-docker-hadoop-1/

使用 Docker 搭建 Hadoop + Hive + Spark 集群（下） https://bambrow.com/20210625-docker-hadoop-2/

基于Docker搭建Hadoop+Hive - Gyan的文章 - 知乎 https://zhuanlan.zhihu.com/p/242658224
