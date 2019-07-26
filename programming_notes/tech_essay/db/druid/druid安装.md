
:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 单节点0.9.0版本安装（参照的是中文版官方网站）

https://github.com/druid-io/docker-druid

http://druidio.cn/docs/0.9.0/tutorials/quickstart.html
- https://github.com/apache/incubator-superset
- https://github.com/metabase/metabase 

## 

> curl -O http://static.druid.io/artifacts/releases/druid-0.9.1.1-bin.tar.gz && tar -xzf druid-0.9.1.1-bin.tar.gz && wget https://archive.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz && tar xzf zookeeper-3.4.6.tar.gz && cd zookeeper-3.4.6 && cp conf/zoo_sample.cfg conf/zoo.cfg && ./bin/zkServer.sh start && cd ../druid-0.9.1.1/ && ./bin/init

```
cat << EOF | tee startScriptAtDruidFolder.sh
java `cat conf-quickstart/druid/historical/jvm.config | xargs` -cp conf-quickstart/druid/_common:conf-quickstart/druid/historical:lib/* io.druid.cli.Main server historical >> /dev/null &
java `cat conf-quickstart/druid/broker/jvm.config | xargs` -cp conf-quickstart/druid/_common:conf-quickstart/druid/broker:lib/* io.druid.cli.Main server broker >> /dev/null &
java `cat conf-quickstart/druid/coordinator/jvm.config | xargs` -cp conf-quickstart/druid/_common:conf-quickstart/druid/coordinator:lib/* io.druid.cli.Main server coordinator >> /dev/null &
java `cat conf-quickstart/druid/overlord/jvm.config | xargs` -cp conf-quickstart/druid/_common:conf-quickstart/druid/overlord:lib/* io.druid.cli.Main server overlord >> /dev/null &
java `cat conf-quickstart/druid/middleManager/jvm.config | xargs` -cp conf-quickstart/druid/_common:conf-quickstart/druid/middleManager:lib/* io.druid.cli.Main server middleManager >> /dev/null &
EOF
```

> bash startScriptAtDruidFolder.sh

> cd druid-0.9.1.1/ && curl -X 'POST' -H 'Content-Type:application/json' -d @quickstart/wikiticker-index.json localhost:8090/druid/indexer/v1/task

## 

> cd ~ && curl -O http://static.druid.io/tranquility/releases/tranquility-distribution-0.7.4.tgz && tar -xzf tranquility-distribution-0.7.4.tgz && cd tranquility-distribution-0.7.4/ && bin/tranquility server -configFile ../druid-0.9.1.1/conf-quickstart/tranquility/server.json >> /dev/null &

##

> cd druid-0.9.1.1/ && bin/generate-example-metrics | curl -XPOST -H'Content-Type: application/json' --data-binary @- http://localhost:8200/v1/post/metrics && curl -L -H'Content-Type: application/json' -XPOST --data-binary @quickstart/wikiticker-top-pages.json http://localhost:8082/druid/v2/?pretty

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 单节点0.14.0版本安装（参照的是英文版官方网站）

Druid Quickstart http://druid.io/docs/latest/tutorials/index.html
> cd ~ && wget http://mirrors.tuna.tsinghua.edu.cn/apache/incubator/druid/0.14.0-incubating/apache-druid-0.14.0-incubating-bin.tar.gz && tar -xzf apache-druid-0.14.0-incubating-bin.tar.gz && cd apache-druid-0.14.0-incubating/ && curl https://archive.apache.org/dist/zookeeper/zookeeper-3.4.11/zookeeper-3.4.11.tar.gz -o zookeeper-3.4.11.tar.gz && tar -xzf zookeeper-3.4.11.tar.gz && mv zookeeper-3.4.11 zk && bin/supervise -c quickstart/tutorial/conf/tutorial-cluster.conf &

Tutorial: Loading a file http://druid.io/docs/latest/tutorials/tutorial-batch.html
- > cd ~/apache-druid-0.14.0-incubating/ && bin/post-index-task --file quickstart/tutorial/wikipedia-index.json 
- >> or use the following command————
- > cd ~/apache-druid-0.14.0-incubating/ && curl -X 'POST' -H 'Content-Type:application/json' -d @quickstart/tutorial/wikipedia-index.json http://localhost:8090/druid/indexer/v1/task

Tutorial: Querying data http://druid.io/docs/latest/tutorials/tutorial-query.html
- > cd ~/apache-druid-0.14.0-incubating/ && curl -X 'POST' -H 'Content-Type:application/json' -d @quickstart/tutorial/wikipedia-top-pages.json http://localhost:8082/druid/v2?pretty
- > cd ~/apache-druid-0.14.0-incubating/ && curl -X 'POST' -H 'Content-Type:application/json' -d @quickstart/tutorial/wikipedia-top-pages-sql.json http://localhost:8082/druid/v2/sql
- > bin/dsql

Tutorial: Load streaming data from Kafka http://druid.io/docs/latest/tutorials/tutorial-kafka.html
> cd ~ && curl -O https://archive.apache.org/dist/kafka/0.10.2.2/kafka_2.12-0.10.2.2.tgz && tar -xzf kafka_2.12-0.10.2.2.tgz && cd kafka_2.12-0.10.2.2 && ./bin/kafka-server-start.sh config/server.properties >> /dev/null & 

> cd ~/kafka_2.12-0.10.2.2/ && ./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic wikipedia && cd ~/apache-druid-0.14.0-incubating/ && curl -XPOST -H'Content-Type: application/json' -d @quickstart/tutorial/wikipedia-kafka-supervisor.json http://localhost:8090/druid/indexer/v1/supervisor && cd quickstart/tutorial && gunzip -k wikiticker-2015-09-12-sampled.json.gz && cd ~/kafka_2.12-0.10.2.2/ && export KAFKA_OPTS="-Dfile.encoding=UTF-8" && ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic wikipedia < ~/apache-druid-0.14.0-incubating/quickstart/tutorial/wikiticker-2015-09-12-sampled.json

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 与可视化前端匹配

- 数据可视化的开源方案: Superset vs Redash vs Metabase (一) https://www.cnblogs.com/felixzh/p/9094694.html
- 数据可视化的开源方案: Superset vs Redash vs Metabase (二) https://www.cnblogs.com/felixzh/p/9094700.html

##

Custom install https://metabase.com/start/jar.html  --> This will launch a Metabase server on port 3000 by default.
> cd ~ && mkdir metabasedir && cd ~/metabasedir/ && wget http://downloads.metabase.com/v0.32.5/metabase.jar && java -jar metabase.jar >> /dev/null &

