
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

## 1 官方文档纯 docker 方式改成 docker-compose 方式

**`docker-compose.yml`（这个不太好，没有持久化数据，一旦 `docker-compose down` 结束，里面表就没了- -）**
```yaml
version: '3.7'

services:
  hive-server:
    image: apache/hive:4.0.0-beta-1
    container_name: hive-server
    environment:
      SERVICE_NAME: hiveserver2
    ports:
      - "10000:10000"  # HiveServer2 JDBC
      - "10002:10002"  # HiveServer2 HTTP
    depends_on:
      - hive-metastore
    command: >
      bash -c "
        sleep 10;
        hiveserver2
      "
    restart: always

  hive-metastore:
    image: apache/hive:4.0.0-beta-1
    container_name: hive-metastore
    environment:
      SERVICE_NAME: metastore
      HIVE_METASTORE_DB_TYPE: derby
    ports:
      - "9083:9083"  # Hive Metastore
    volumes:
      - ./metastore_db:/opt/hive/metastore_db
    command: >
      bash -c "
        schematool -initSchema -dbType derby;
        start-metastore
      "
    restart: always
```

**连接 hive server**
```sh
docker exec -it hive-server beeline -u 'jdbc:hive2://localhost:10000/'
```

**TODO:这里准备搞一个能持久化的数据的，但是还没搞完，不得不打断先搞别的**
```yml
version: '0.1'

services:
  hive-server:
    image: apache/hive:4.0.0-beta-1
    container_name: hive-server
    environment:
      SERVICE_NAME: hiveserver2
    ports:
      - "10000:10000"  # HiveServer2 JDBC
      - "10002:10002"  # HiveServer2 HTTP
    depends_on:
      - hive-metastore
    volumes:
      - hive_data:/opt/hive/warehouse  # 持久化 Hive 数据
    command: bash -c "sleep 10; hiveserver2"
    restart: always

  hive-metastore:
    image: apache/hive:4.0.0-beta-1
    container_name: hive-metastore
    environment:
      SERVICE_NAME: metastore
      HIVE_METASTORE_DB_TYPE: derby
      DERBY_LOG: /opt/hive/logs/derby.log
      DERBY_DATA: /opt/hive/metastore_db
    ports:
      - "9083:9083"  # Hive Metastore
    volumes:
      - derby_data:/opt/hive/metastore_db
      - hive_data:/opt/hive/warehouse  # 持久化 Hive 数据
      - logs:/opt/hive/logs
    command: bash -c "schematool -initSchema -dbType derby; start-metastore"
    restart: always

volumes:
  derby_data:
  hive_data:
  logs:
```

# 其他

基于docker快速搭建hive环境 https://cloud.tencent.com/developer/article/1668927

使用docker快速搭建hive环境 https://www.cnblogs.com/upupfeng/p/13452385.html
- docker-hive https://github.com/big-data-europe/docker-hive

使用 Docker 搭建 Hadoop + Hive + Spark 集群（上） https://bambrow.com/20210625-docker-hadoop-1/

使用 Docker 搭建 Hadoop + Hive + Spark 集群（下） https://bambrow.com/20210625-docker-hadoop-2/

基于Docker搭建Hadoop+Hive - Gyan的文章 - 知乎 https://zhuanlan.zhihu.com/p/242658224
