
# 1

使用 Docker 快速部署 Spark + Hadoop 大数据集群 - s1mple的文章 - 知乎 https://zhuanlan.zhihu.com/p/421375012
- > **集群网络**
  * > 默认情况下，通过 `docker-compose` 启动的容器集群，会创建并使用名为 `镜像名_default` 的桥接网络，如 `spark_default`。集群内的容器处于同一子网网段，因此可以相互通信。
- > **使用 Spark Shell 进行交互**
  * > 在启动交互式 Shell 时，Spark 驱动器程序（Driver Program）会创建一个名为 `sc` 的 SparkContext 对象，我们可以通过该对象来创建 `RDD`。例如，通过 `sc.textFile()` 方法读取本地或 HDFS 文件，或者通过 `sc.parallelize()` 方法直接由 Python 集合创建 `RDD`。
    ```py
    >>> lines = sc.textFile('README.md')
    >>> lines.count()
    108                                   
    >>> lines.filter(lambda line: len(line) > 10)
    PythonRDD[3] at RDD at PythonRDD.scala:53
    >>> lines.filter(lambda line: len(line) > 10).count()
    67
    >>> strs = sc.parallelize(['hello world', 'i am spark', 'hadoop'])
    >>> strs.flatMap(lambda s: s.split(' ')).collect()
    ['hello', 'world', 'i', 'am', 'spark', 'hadoop']
    >>> strs.flatMap(lambda s: s.split(' ')).reduce(lambda x, y: x + '-' + y)
    'hello-world-i-am-spark-hadoop'
    ```
  * > 注：由于 Spark 的惰性求值特性，只有当执行 Action 操作时，如 `count`、`collect`、`reduce`，才会真正执行计算并返回结果。
  * > Spark Shell 默认以本地模式运行，但也支持以集群模式运行。可以通过指定 `--master` 参数，如 `pyspark --master spark://master:7077`，以 Standalone 模式运行 PySpark Shell。

## 个人实战该文章

```sh
mkdir -p ~/docker/spark/
cd ~/docker/spark/

cat << EOF > docker-compose.yml
version: '2'

services:
  spark:
    image: docker.io/bitnami/spark:3
    hostname: master
    environment:
      - SPARK_MODE=master
      - SPARK_RPC_AUTHENTICATION_ENABLED=no
      - SPARK_RPC_ENCRYPTION_ENABLED=no
      - SPARK_LOCAL_STORAGE_ENCRYPTION_ENABLED=no
      - SPARK_SSL_ENABLED=no
    volumes:
      - ~/docker/spark/share:/opt/share
    ports:
      - '8080:8080'
      - '4040:4040'
  spark-worker-1:
    image: docker.io/bitnami/spark:3
    hostname: worker1
    environment:
      - SPARK_MODE=worker
      - SPARK_MASTER_URL=spark://master:7077
      - SPARK_WORKER_MEMORY=1G
      - SPARK_WORKER_CORES=1
      - SPARK_RPC_AUTHENTICATION_ENABLED=no
      - SPARK_RPC_ENCRYPTION_ENABLED=no
      - SPARK_LOCAL_STORAGE_ENCRYPTION_ENABLED=no
      - SPARK_SSL_ENABLED=no
    volumes:
      - ~/docker/spark/share:/opt/share
    ports:
      - '8081:8081'
  spark-worker-2:
    image: docker.io/bitnami/spark:3
    hostname: worker2
    environment:
      - SPARK_MODE=worker
      - SPARK_MASTER_URL=spark://master:7077
      - SPARK_WORKER_MEMORY=1G
      - SPARK_WORKER_CORES=1
      - SPARK_RPC_AUTHENTICATION_ENABLED=no
      - SPARK_RPC_ENCRYPTION_ENABLED=no
      - SPARK_LOCAL_STORAGE_ENCRYPTION_ENABLED=no
      - SPARK_SSL_ENABLED=no
    volumes:
      - ~/docker/spark/share:/opt/share
    ports:
      - '8082:8081'
EOF

# 如果机器上已经安装了 docker-compose 了当然就不用再安装了。
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

docker-compose up -d

# 然后只要笔记本能连上远程 Linux 机器，直接在笔记本的浏览器里用 http://<remote_linux_ip>:8080/ 就可以访问 Spark Web UI 了。
# 此外可以考虑把 8080 8081 8082 改成 9080，9081，9082，因为 8080 容易冲突。
# --> 但是有个问题：在 http://<remote_linux_ip>:8080/ 里显示的 worker 数量是 0，也就是看起来 worker 没有连上 master。不知道为什么，回头再看吧。
```

Bitnami Docker Image for Apache Spark https://github.com/bitnami/bitnami-docker-spark

# 2
>> //notes：这个很容易部署起来，美中不足的是没有对外（除了localhost外）暴露端口。

使用 Docker 快速部署 Spark + Hadoop 大数据集群 https://s1mple.cc/2021/10/12/%E4%BD%BF%E7%94%A8-Docker-%E5%BF%AB%E9%80%9F%E9%83%A8%E7%BD%B2-Spark-Hadoop-%E5%A4%A7%E6%95%B0%E6%8D%AE%E9%9B%86%E7%BE%A4/
- spark-hadoop-docker https://github.com/s1mplecc/spark-hadoop-docker

# 3
>> //notes：这个部署更容易，且向外暴漏了端口

https://github.com/zq2599/blog_demos/blob/e0212b2be61832de0f97d2c9984db44228b29aa3/sparkdockercomposefiles/docker-compose.yml

docker下，极速搭建spark集群(含hdfs集群) https://juejin.cn/post/6844903879004389384
```sh
wget https://raw.githubusercontent.com/zq2599/blog_demos/master/sparkdockercomposefiles/docker-compose.yml \
&& wget https://raw.githubusercontent.com/zq2599/blog_demos/master/sparkdockercomposefiles/hadoop.env \
&& docker-compose up -d
```

# 4

Install Spark On Ubuntu- A Beginners Tutorial for Apache Spark https://data-flair.training/blogs/install-spark-ubuntu/
