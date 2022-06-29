
# 集群搭建

Hadoop集群搭建 https://hadoop.apache.org/docs/r1.0.4/cn/cluster_setup.html

## docker方式（缺点是容器里估计编译困难）

docker-compose快速搭建hadoop https://www.jianshu.com/p/9b548517abbb  【已验证】

## 二进制方式

Hadoop: Setting up a Single Node Cluster. https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Installing_Software 【`-->` 官方文档反而几乎没有去参考，直接用别的文档了。】

`【1】`【[:star:][`*`]】 How to Install Hadoop in Stand-Alone Mode on Debian 9 https://www.digitalocean.com/community/tutorials/how-to-install-hadoop-in-stand-alone-mode-on-debian-9 【`-->` 不过文章里用的Hadoop版本已经过时了，我用的是`Hadoop 3.2.1`版本。此外这个好像只是用hadoop跑了个任务，似乎不涉及HDFS。】
- > The `JAVA_HOME` environment variable set in `/etc/environment`, as shown in How to Install Java with Apt on Debian 9. Hadoop requires this variable to be set.
  >> How To Install Java with Apt on Debian 9 https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-debian-9
  >>> 
    ```sh
    sudo apt update
    sudo apt install default-jre
    ```
- ***个人实战部分***：
```sh
# https://www.katacoda.com/courses/ubuntu/playground

apt update && apt install -y default-jre
mkdir test && cd test/
wget http://www-us.apache.org/dist/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
tar zxvf hadoop-3.2.1.tar.gz
sudo mv hadoop-3.2.1 /usr/local/hadoop

/usr/local/hadoop/bin/hadoop
mkdir ~/input
cp /usr/local/hadoop/etc/hadoop/*.xml ~/input
# $ ll ~/input/
# total 60
# drwxr-xr-x 2 root root  4096 Mar 11 03:37 ./
# drwx------ 6 root root  4096 Mar 11 03:36 ../
# -rw-r--r-- 1 root root  8260 Mar 11 03:37 capacity-scheduler.xml
# -rw-r--r-- 1 root root   774 Mar 11 03:37 core-site.xml
# -rw-r--r-- 1 root root 11392 Mar 11 03:37 hadoop-policy.xml
# -rw-r--r-- 1 root root   775 Mar 11 03:37 hdfs-site.xml
# -rw-r--r-- 1 root root   620 Mar 11 03:37 httpfs-site.xml
# -rw-r--r-- 1 root root  3518 Mar 11 03:37 kms-acls.xml
# -rw-r--r-- 1 root root   682 Mar 11 03:37 kms-site.xml
# -rw-r--r-- 1 root root   758 Mar 11 03:37 mapred-site.xml
# -rw-r--r-- 1 root root   690 Mar 11 03:37 yarn-site.xml

/usr/local/hadoop/bin/hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar grep ~/input ~/grep_example 'allowed[.]*'
cat ~/grep_example/*
# $ ll ~/grep_example/
# total 20
# drwxr-xr-x 2 root root 4096 Mar 11 03:40 ./
# drwx------ 7 root root 4096 Mar 11 03:40 ../
# -rw-r--r-- 1 root root   22 Mar 11 03:40 part-r-00000
# -rw-r--r-- 1 root root   12 Mar 11 03:40 .part-r-00000.crc
# -rw-r--r-- 1 root root    0 Mar 11 03:40 _SUCCESS
# -rw-r--r-- 1 root root    8 Mar 11 03:40 ._SUCCESS.crc
# $ cat ~/grep_example/*
# 21      allowed.
# 1       allowed
```

`【2】`【[:star:][`*`]】 Install Hadoop: Setting up a Single Node Hadoop Cluster https://www.edureka.co/blog/install-hadoop-single-node-hadoop-cluster `+` [安装hadoop3.0版本踩坑](https://blog.csdn.net/qq_32635069/article/details/80859790)
- ***个人实战部分***：
```sh
# 接上一个攻略，到把hadoop下载下来，解压放到 /usr/local/hadoop 那步就行，也就是 `sudo mv hadoop-3.2.1 /usr/local/hadoop` 这步。
# 后面启动那步（ /usr/local/hadoop/bin/hadoop ）就不用执行了。
# 环境也同样是用 Katacoda 的 Ubuntu： https://www.katacoda.com/courses/ubuntu/playground

# 前述步骤已经做差不多了，直接从 Step 5 开始。但是其实这一步我没配那么多环境变量，就配了这俩：
export PATH=$PATH:$JAVA_HOME/bin
export PATH=$PATH:/usr/local/hadoop/bin

# 然后 Step 6-11 就是改那几个xml配置文件的内容，直接照做即可，没啥坑，故这里省略了。总之依次修改了：
# core-site.xml、hdfs-site.xml、mapred-site.xml（需要从 mapred-site.xml.template 复制过去）、yarn-site.xml 、hadoop–env.sh

$ hadoop namenode -format
WARNING: Use of this script to execute namenode is deprecated.
WARNING: Attempting to execute replacement "hdfs namenode" instead.

WARNING: /usr/local/hadoop/logs does not exist. Creating.
2021-03-11 06:40:17,415 INFO namenode.NameNode: STARTUP_MSG: 
/************************************************************
STARTUP_MSG: Starting NameNode
STARTUP_MSG:   host = localhost/127.0.0.1
STARTUP_MSG:   args = [-format]
STARTUP_MSG:   version = 3.2.1
STARTUP_MSG:   classpath = /usr/local/hadoop/etc/hadoop:/usr/local/hadoop/share/hadoop/common/lib/commons-logging-1.1.3.jar:/usr/local/hadoop/share/hadoop/common/lib/javax.servlet-api-3.1.0.jar:/usr/local/hadoop/share/hadoop/common/lib/jaxb-api-2.2.11.jar:/usr/local/hadoop/share/hadoop/common/lib/htrace-core4-4.1.0-incubating.jar:/usr/local/hadoop/share/hadoop/common/lib/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-beanutils-1.9.3.jar:/usr/local/hadoop/share/hadoop/common/lib/jetty-security-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/common/lib/jetty-servlet-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/common/lib/paranamer-2.3.jar:/usr/local/hadoop/share/hadoop/common/lib/json-smart-2.3.jar:/usr/local/hadoop/share/hadoop/common/lib/kerb-common-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/zookeeper-3.4.13.jar:/usr/local/hadoop/share/hadoop/common/lib/slf4j-log4j12-1.7.25.jar:/usr/local/hadoop/share/hadoop/common/lib/kerby-asn1-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/curator-client-2.13.0.jar:/usr/local/hadoop/share/hadoop/common/lib/checker-qual-2.5.2.jar:/usr/local/hadoop/share/hadoop/common/lib/token-provider-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jetty-server-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/common/lib/kerby-pkix-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/netty-3.10.5.Final.jar:/usr/local/hadoop/share/hadoop/common/lib/log4j-1.2.17.jar:/usr/local/hadoop/share/hadoop/common/lib/jersey-server-1.19.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-net-3.6.jar:/usr/local/hadoop/share/hadoop/common/lib/jackson-jaxrs-1.9.13.jar:/usr/local/hadoop/share/hadoop/common/lib/animal-sniffer-annotations-1.17.jar:/usr/local/hadoop/share/hadoop/common/lib/httpcore-4.4.10.jar:/usr/local/hadoop/share/hadoop/common/lib/jersey-core-1.19.jar:/usr/local/hadoop/share/hadoop/common/lib/asm-5.0.4.jar:/usr/local/hadoop/share/hadoop/common/lib/jettison-1.1.jar:/usr/local/hadoop/share/hadoop/common/lib/curator-recipes-2.13.0.jar:/usr/local/hadoop/share/hadoop/common/lib/jackson-mapper-asl-1.9.13.jar:/usr/local/hadoop/share/hadoop/common/lib/jetty-io-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/common/lib/kerb-simplekdc-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jaxb-impl-2.2.3-1.jar:/usr/local/hadoop/share/hadoop/common/lib/curator-framework-2.13.0.jar:/usr/local/hadoop/share/hadoop/common/lib/jetty-xml-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-io-2.5.jar:/usr/local/hadoop/share/hadoop/common/lib/httpclient-4.5.6.jar:/usr/local/hadoop/share/hadoop/common/lib/kerby-util-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jul-to-slf4j-1.7.25.jar:/usr/local/hadoop/share/hadoop/common/lib/error_prone_annotations-2.2.0.jar:/usr/local/hadoop/share/hadoop/common/lib/jetty-util-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/common/lib/hadoop-annotations-3.2.1.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-collections-3.2.2.jar:/usr/local/hadoop/share/hadoop/common/lib/guava-27.0-jre.jar:/usr/local/hadoop/share/hadoop/common/lib/kerb-identity-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/j2objc-annotations-1.1.jar:/usr/local/hadoop/share/hadoop/common/lib/stax2-api-3.1.4.jar:/usr/local/hadoop/share/hadoop/common/lib/kerb-crypto-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/nimbus-jose-jwt-4.41.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jsp-api-2.1.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-lang3-3.7.jar:/usr/local/hadoop/share/hadoop/common/lib/kerb-util-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jackson-core-asl-1.9.13.jar:/usr/local/hadoop/share/hadoop/common/lib/woodstox-core-5.0.3.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-codec-1.11.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-text-1.4.jar:/usr/local/hadoop/share/hadoop/common/lib/metrics-core-3.2.4.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-math3-3.1.1.jar:/usr/local/hadoop/share/hadoop/common/lib/avro-1.7.7.jar:/usr/local/hadoop/share/hadoop/common/lib/gson-2.2.4.jar:/usr/local/hadoop/share/hadoop/common/lib/accessors-smart-1.2.jar:/usr/local/hadoop/share/hadoop/common/lib/protobuf-java-2.5.0.jar:/usr/local/hadoop/share/hadoop/common/lib/snappy-java-1.0.5.jar:/usr/local/hadoop/share/hadoop/common/lib/jsr305-3.0.0.jar:/usr/local/hadoop/share/hadoop/common/lib/kerb-core-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jcip-annotations-1.0-1.jar:/usr/local/hadoop/share/hadoop/common/lib/jetty-http-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/common/lib/kerb-admin-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/slf4j-api-1.7.25.jar:/usr/local/hadoop/share/hadoop/common/lib/kerb-client-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jersey-json-1.19.jar:/usr/local/hadoop/share/hadoop/common/lib/jackson-xc-1.9.13.jar:/usr/local/hadoop/share/hadoop/common/lib/kerb-server-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jersey-servlet-1.19.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-compress-1.18.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-configuration2-2.1.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jsr311-api-1.1.1.jar:/usr/local/hadoop/share/hadoop/common/lib/kerby-xdr-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jetty-webapp-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/common/lib/jackson-annotations-2.9.8.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-cli-1.2.jar:/usr/local/hadoop/share/hadoop/common/lib/failureaccess-1.0.jar:/usr/local/hadoop/share/hadoop/common/lib/dnsjava-2.1.7.jar:/usr/local/hadoop/share/hadoop/common/lib/jackson-core-2.9.8.jar:/usr/local/hadoop/share/hadoop/common/lib/kerby-config-1.0.1.jar:/usr/local/hadoop/share/hadoop/common/lib/hadoop-auth-3.2.1.jar:/usr/local/hadoop/share/hadoop/common/lib/audience-annotations-0.5.0.jar:/usr/local/hadoop/share/hadoop/common/lib/re2j-1.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jackson-databind-2.9.8.jar:/usr/local/hadoop/share/hadoop/common/lib/jsch-0.1.54.jar:/usr/local/hadoop/share/hadoop/common/hadoop-common-3.2.1.jar:/usr/local/hadoop/share/hadoop/common/hadoop-nfs-3.2.1.jar:/usr/local/hadoop/share/hadoop/common/hadoop-common-3.2.1-tests.jar:/usr/local/hadoop/share/hadoop/common/hadoop-kms-3.2.1.jar:/usr/local/hadoop/share/hadoop/hdfs:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-logging-1.1.3.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/javax.servlet-api-3.1.0.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jaxb-api-2.2.11.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/htrace-core4-4.1.0-incubating.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/netty-all-4.0.52.Final.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-beanutils-1.9.3.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jetty-security-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jetty-servlet-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/paranamer-2.3.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/json-smart-2.3.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerb-common-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/zookeeper-3.4.13.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerby-asn1-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/curator-client-2.13.0.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/checker-qual-2.5.2.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/token-provider-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jetty-server-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerby-pkix-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/netty-3.10.5.Final.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/json-simple-1.1.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/log4j-1.2.17.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jersey-server-1.19.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-net-3.6.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-daemon-1.0.13.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jackson-jaxrs-1.9.13.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/animal-sniffer-annotations-1.17.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/httpcore-4.4.10.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jersey-core-1.19.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/asm-5.0.4.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jettison-1.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/curator-recipes-2.13.0.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jackson-mapper-asl-1.9.13.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jetty-io-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerb-simplekdc-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jaxb-impl-2.2.3-1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/curator-framework-2.13.0.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jetty-xml-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-io-2.5.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/httpclient-4.5.6.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerby-util-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/error_prone_annotations-2.2.0.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jetty-util-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/hadoop-annotations-3.2.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-collections-3.2.2.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/guava-27.0-jre.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/leveldbjni-all-1.8.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerb-identity-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/j2objc-annotations-1.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jetty-util-ajax-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/stax2-api-3.1.4.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerb-crypto-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/nimbus-jose-jwt-4.41.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-lang3-3.7.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerb-util-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jackson-core-asl-1.9.13.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/woodstox-core-5.0.3.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-codec-1.11.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-text-1.4.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-math3-3.1.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/avro-1.7.7.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/gson-2.2.4.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/accessors-smart-1.2.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/protobuf-java-2.5.0.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/snappy-java-1.0.5.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jsr305-3.0.0.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerb-core-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jcip-annotations-1.0-1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jetty-http-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerb-admin-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerb-client-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jersey-json-1.19.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jackson-xc-1.9.13.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerb-server-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jersey-servlet-1.19.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-compress-1.18.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/okhttp-2.7.5.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-configuration2-2.1.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/okio-1.6.0.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jsr311-api-1.1.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerby-xdr-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jetty-webapp-9.3.24.v20180605.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jackson-annotations-2.9.8.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-cli-1.2.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/failureaccess-1.0.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/dnsjava-2.1.7.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jackson-core-2.9.8.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/kerby-config-1.0.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/hadoop-auth-3.2.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/audience-annotations-0.5.0.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/re2j-1.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jackson-databind-2.9.8.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jsch-0.1.54.jar:/usr/local/hadoop/share/hadoop/hdfs/hadoop-hdfs-client-3.2.1.jar:/usr/local/hadoop/share/hadoop/hdfs/hadoop-hdfs-nfs-3.2.1.jar:/usr/local/hadoop/share/hadoop/hdfs/hadoop-hdfs-3.2.1.jar:/usr/local/hadoop/share/hadoop/hdfs/hadoop-hdfs-rbf-3.2.1-tests.jar:/usr/local/hadoop/share/hadoop/hdfs/hadoop-hdfs-client-3.2.1-tests.jar:/usr/local/hadoop/share/hadoop/hdfs/hadoop-hdfs-3.2.1-tests.jar:/usr/local/hadoop/share/hadoop/hdfs/hadoop-hdfs-native-client-3.2.1-tests.jar:/usr/local/hadoop/share/hadoop/hdfs/hadoop-hdfs-httpfs-3.2.1.jar:/usr/local/hadoop/share/hadoop/hdfs/hadoop-hdfs-rbf-3.2.1.jar:/usr/local/hadoop/share/hadoop/hdfs/hadoop-hdfs-native-client-3.2.1.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/junit-4.11.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/hamcrest-core-1.3.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-uploader-3.2.1.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-shuffle-3.2.1.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-core-3.2.1.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-nativetask-3.2.1.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-plugins-3.2.1.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-3.2.1-tests.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-3.2.1.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-3.2.1.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-app-3.2.1.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-common-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn:/usr/local/hadoop/share/hadoop/yarn/lib/guice-servlet-4.0.jar:/usr/local/hadoop/share/hadoop/yarn/lib/json-io-2.5.1.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jackson-jaxrs-base-2.9.8.jar:/usr/local/hadoop/share/hadoop/yarn/lib/geronimo-jcache_1.0_spec-1.0-alpha-1.jar:/usr/local/hadoop/share/hadoop/yarn/lib/mssql-jdbc-6.2.1.jre7.jar:/usr/local/hadoop/share/hadoop/yarn/lib/ehcache-3.3.1.jar:/usr/local/hadoop/share/hadoop/yarn/lib/guice-4.0.jar:/usr/local/hadoop/share/hadoop/yarn/lib/java-util-1.9.0.jar:/usr/local/hadoop/share/hadoop/yarn/lib/javax.inject-1.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jackson-jaxrs-json-provider-2.9.8.jar:/usr/local/hadoop/share/hadoop/yarn/lib/metrics-core-3.2.4.jar:/usr/local/hadoop/share/hadoop/yarn/lib/fst-2.50.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jersey-client-1.19.jar:/usr/local/hadoop/share/hadoop/yarn/lib/snakeyaml-1.16.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jersey-guice-1.19.jar:/usr/local/hadoop/share/hadoop/yarn/lib/swagger-annotations-1.5.4.jar:/usr/local/hadoop/share/hadoop/yarn/lib/aopalliance-1.0.jar:/usr/local/hadoop/share/hadoop/yarn/lib/objenesis-1.0.jar:/usr/local/hadoop/share/hadoop/yarn/lib/bcprov-jdk15on-1.60.jar:/usr/local/hadoop/share/hadoop/yarn/lib/HikariCP-java7-2.4.12.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jackson-module-jaxb-annotations-2.9.8.jar:/usr/local/hadoop/share/hadoop/yarn/lib/bcpkix-jdk15on-1.60.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-services-core-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-nodemanager-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-registry-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-common-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-submarine-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-services-api-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-applicationhistoryservice-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-web-proxy-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-api-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-sharedcachemanager-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-applications-distributedshell-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-router-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-common-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-client-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-applications-unmanaged-am-launcher-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-timeline-pluginstorage-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-resourcemanager-3.2.1.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-tests-3.2.1.jar
STARTUP_MSG:   build = https://gitbox.apache.org/repos/asf/hadoop.git -r b3cbbb467e22ea829b3808f4b7b01d07e0bf3842; compiled by 'rohithsharmaks' on 2019-09-10T15:56Z
STARTUP_MSG:   java = 1.8.0_272
************************************************************/
2021-03-11 06:40:19,204 INFO namenode.NameNode: registered UNIX signal handlers for [TERM, HUP, INT]
2021-03-11 06:40:36,760 INFO namenode.NameNode: createNameNode [-format]
Formatting using clusterid: CID-3c5471a2-83d1-4636-8aac-3b2bfe59a675
2021-03-11 06:40:59,009 INFO namenode.FSEditLog: Edit logging is async:true
2021-03-11 06:40:59,640 INFO namenode.FSNamesystem: KeyProvider: null
2021-03-11 06:40:59,643 INFO namenode.FSNamesystem: fsLock is fair: true
2021-03-11 06:40:59,652 INFO namenode.FSNamesystem: Detailed lock hold time metrics enabled: false
2021-03-11 06:40:59,688 INFO namenode.FSNamesystem: fsOwner             = root (auth:SIMPLE)
2021-03-11 06:40:59,688 INFO namenode.FSNamesystem: supergroup          = supergroup
2021-03-11 06:40:59,688 INFO namenode.FSNamesystem: isPermissionEnabled = true
2021-03-11 06:40:59,688 INFO namenode.FSNamesystem: HA Enabled: false
2021-03-11 06:40:59,814 INFO common.Util: dfs.datanode.fileio.profiling.sampling.percentage set to 0. Disabling file IO profiling
2021-03-11 06:40:59,849 INFO blockmanagement.DatanodeManager: dfs.block.invalidate.limit: configured=1000, counted=60, effected=1000
2021-03-11 06:40:59,850 INFO blockmanagement.DatanodeManager: dfs.namenode.datanode.registration.ip-hostname-check=true
2021-03-11 06:40:59,858 INFO blockmanagement.BlockManager: dfs.namenode.startup.delay.block.deletion.sec is set to 000:00:00:00.000
2021-03-11 06:40:59,858 INFO blockmanagement.BlockManager: The block deletion will start around 2021 Mar 11 06:40:59
2021-03-11 06:40:59,866 INFO util.GSet: Computing capacity for map BlocksMap
2021-03-11 06:40:59,866 INFO util.GSet: VM type       = 64-bit
2021-03-11 06:40:59,871 INFO util.GSet: 2.0% max memory 361.6 MB = 7.2 MB
2021-03-11 06:40:59,871 INFO util.GSet: capacity      = 2^20 = 1048576 entries
2021-03-11 06:40:59,903 INFO blockmanagement.BlockManager: Storage policy satisfier is disabled
2021-03-11 06:40:59,913 INFO blockmanagement.BlockManager: dfs.block.access.token.enable = false
2021-03-11 06:40:59,923 INFO Configuration.deprecation: No unit for dfs.namenode.safemode.extension(30000) assuming MILLISECONDS
2021-03-11 06:40:59,924 INFO blockmanagement.BlockManagerSafeMode: dfs.namenode.safemode.threshold-pct = 0.9990000128746033
2021-03-11 06:40:59,924 INFO blockmanagement.BlockManagerSafeMode: dfs.namenode.safemode.min.datanodes = 0
2021-03-11 06:40:59,943 INFO blockmanagement.BlockManagerSafeMode: dfs.namenode.safemode.extension = 30000
2021-03-11 06:40:59,945 INFO blockmanagement.BlockManager: defaultReplication         = 1
2021-03-11 06:40:59,945 INFO blockmanagement.BlockManager: maxReplication             = 512
2021-03-11 06:40:59,945 INFO blockmanagement.BlockManager: minReplication             = 1
2021-03-11 06:40:59,945 INFO blockmanagement.BlockManager: maxReplicationStreams      = 2
2021-03-11 06:40:59,945 INFO blockmanagement.BlockManager: redundancyRecheckInterval  = 3000ms
2021-03-11 06:40:59,946 INFO blockmanagement.BlockManager: encryptDataTransfer        = false
2021-03-11 06:40:59,946 INFO blockmanagement.BlockManager: maxNumBlocksToLog          = 1000
2021-03-11 06:41:00,055 INFO namenode.FSDirectory: GLOBAL serial map: bits=29 maxEntries=536870911
2021-03-11 06:41:00,056 INFO namenode.FSDirectory: USER serial map: bits=24 maxEntries=16777215
2021-03-11 06:41:00,056 INFO namenode.FSDirectory: GROUP serial map: bits=24 maxEntries=16777215
2021-03-11 06:41:00,056 INFO namenode.FSDirectory: XATTR serial map: bits=24 maxEntries=16777215
2021-03-11 06:41:00,110 INFO util.GSet: Computing capacity for map INodeMap
2021-03-11 06:41:00,111 INFO util.GSet: VM type       = 64-bit
2021-03-11 06:41:00,127 INFO util.GSet: 1.0% max memory 361.6 MB = 3.6 MB
2021-03-11 06:41:00,127 INFO util.GSet: capacity      = 2^19 = 524288 entries
2021-03-11 06:41:00,128 INFO namenode.FSDirectory: ACLs enabled? false
2021-03-11 06:41:00,128 INFO namenode.FSDirectory: POSIX ACL inheritance enabled? true
2021-03-11 06:41:00,128 INFO namenode.FSDirectory: XAttrs enabled? true
2021-03-11 06:41:00,129 INFO namenode.NameNode: Caching file names occurring more than 10 times
2021-03-11 06:41:00,142 INFO snapshot.SnapshotManager: Loaded config captureOpenFiles: false, skipCaptureAccessTimeOnlyChange: false, snapshotDiffAllowSnapRootDescendant: true, maxSnapshotLimit: 65536
2021-03-11 06:41:00,150 INFO snapshot.SnapshotManager: SkipList is disabled
2021-03-11 06:41:00,158 INFO util.GSet: Computing capacity for map cachedBlocks
2021-03-11 06:41:00,159 INFO util.GSet: VM type       = 64-bit
2021-03-11 06:41:00,159 INFO util.GSet: 0.25% max memory 361.6 MB = 925.6 KB
2021-03-11 06:41:00,159 INFO util.GSet: capacity      = 2^17 = 131072 entries
2021-03-11 06:41:00,190 INFO metrics.TopMetrics: NNTop conf: dfs.namenode.top.window.num.buckets = 10
2021-03-11 06:41:00,191 INFO metrics.TopMetrics: NNTop conf: dfs.namenode.top.num.users = 10
2021-03-11 06:41:00,191 INFO metrics.TopMetrics: NNTop conf: dfs.namenode.top.windows.minutes = 1,5,25
2021-03-11 06:41:00,203 INFO namenode.FSNamesystem: Retry cache on namenode is enabled
2021-03-11 06:41:00,207 INFO namenode.FSNamesystem: Retry cache will use 0.03 of total heap and retry cache entry expiry time is 600000 millis
2021-03-11 06:41:00,212 INFO util.GSet: Computing capacity for map NameNodeRetryCache
2021-03-11 06:41:00,213 INFO util.GSet: VM type       = 64-bit
2021-03-11 06:41:00,213 INFO util.GSet: 0.029999999329447746% max memory 361.6 MB = 111.1 KB
2021-03-11 06:41:00,213 INFO util.GSet: capacity      = 2^14 = 16384 entries
2021-03-11 06:41:00,258 INFO namenode.FSImage: Allocated new BlockPoolId: BP-776872012-127.0.0.1-1615444860244
2021-03-11 06:41:00,284 INFO common.Storage: Storage directory /tmp/hadoop-root/dfs/name has been successfully formatted.
2021-03-11 06:41:00,372 INFO namenode.FSImageFormatProtobuf: Saving image file /tmp/hadoop-root/dfs/name/current/fsimage.ckpt_0000000000000000000 using no compression
2021-03-11 06:41:00,537 INFO namenode.FSImageFormatProtobuf: Image file /tmp/hadoop-root/dfs/name/current/fsimage.ckpt_0000000000000000000 of size 399 bytes saved in 0 seconds .
2021-03-11 06:41:00,567 INFO namenode.NNStorageRetentionManager: Going to retain 1 images with txid >= 0
2021-03-11 06:41:00,589 INFO namenode.FSImage: FSImageSaver clean checkpoint: txid=0 when meet shutdown.
2021-03-11 06:41:00,590 INFO namenode.NameNode: SHUTDOWN_MSG: 
/************************************************************
SHUTDOWN_MSG: Shutting down NameNode at localhost/127.0.0.1
************************************************************/
$ 

$ ./start-all.sh
Starting namenodes on [localhost]
ERROR: Attempting to operate on hdfs namenode as root
ERROR: but there is no HDFS_NAMENODE_USER defined. Aborting operation.
Starting datanodes
ERROR: Attempting to operate on hdfs datanode as root
ERROR: but there is no HDFS_DATANODE_USER defined. Aborting operation.
Starting secondary namenodes [host01]
ERROR: Attempting to operate on hdfs secondarynamenode as root
ERROR: but there is no HDFS_SECONDARYNAMENODE_USER defined. Aborting operation.
Starting resourcemanager
ERROR: Attempting to operate on yarn resourcemanager as root
ERROR: but there is no YARN_RESOURCEMANAGER_USER defined. Aborting operation.
Starting nodemanagers
ERROR: Attempting to operate on yarn nodemanager as root
ERROR: but there is no YARN_NODEMANAGER_USER defined. Aborting operation.
$ 

# 这里用下面那个帖子（也就是加号后面那个）里的办法把用户改成root后就可以启动了。但是我怀疑可能hdfs的最佳实践是不用root启动。。。
# 另外，后来发现如果要关闭的话，也得把对应的 stop-dfs.sh 和 stop-yarn.sh 改用户名。方法是一样的，都是复制粘贴到脚本前面就行。
$ vi start-dfs.sh 
$ vi start-yarn.sh
$ 
$ ./start-all.sh
WARNING: HADOOP_SECURE_DN_USER has been replaced by HDFS_DATANODE_SECURE_USER. Using value of HADOOP_SECURE_DN_USER.
Starting namenodes on [localhost]
localhost: Warning: Permanently added 'localhost' (ECDSA) to the list of known hosts.
Starting datanodes
Starting secondary namenodes [host01]
host01: Warning: Permanently added 'host01' (ECDSA) to the list of known hosts.
Starting resourcemanager
Starting nodemanagers
$ 

# 成功启动后
$ jps
21892 NameNode
22454 NodeManager
22136 SecondaryNameNode
22920 Jps
21995 DataNode
22348 ResourceManager
$ 
$ hdfs dfs -mkdir hdfs://localhost:9000/tmp
$ 
$ hdfs dfs -ls hdfs://localhost:9000/
Found 1 items
drwxr-xr-x   - root supergroup          0 2021-03-11 06:51 hdfs://localhost:9000/tmp
$
```

[安装hadoop3.0版本踩坑](https://blog.csdn.net/qq_32635069/article/details/80859790)
```console
1、hdfs的web页面默认端口是9870 yarn的web页面端口是8088
2、配置文件中的slaves文件没了，变成了workers文件，在里面配置datanode节点
3、在进行namenode格式化是有几个Fail，不要因此怀疑自己，只要common.Storage: Storage directory /usr/local/hadoop-3.0.2/hdfs/name has been successfully formatted. 这个提醒是存在的就没有问题
4、在启动时，start-dfs.sh start-yarn.sh时报错
``
Starting namenodes on [namenode]
ERROR: Attempting to operate on hdfs namenode as root
ERROR: but there is no HDFS_NAMENODE_USER defined. Aborting operation.
Starting datanodes
ERROR: Attempting to operate on hdfs datanode as root
ERROR: but there is no HDFS_DATANODE_USER defined. Aborting operation.
Starting secondary namenodes [datanode1]
ERROR: Attempting to operate on hdfs secondarynamenode as root
ERROR: but there is no HDFS_SECONDARYNAMENODE_USER defined. Aborting operation.
Starting resourcemanager
ERROR: Attempting to operate on yarn resourcemanager as root
ERROR: but there is no YARN_RESOURCEMANAGER_USER defined. Aborting operation.
Starting nodemanagers
ERROR: Attempting to operate on yarn nodemanager as root
ERROR: but there is no YARN_NODEMANAGER_USER defined. Aborting operation.
``

解决办法：
注意是在文件开始空白处

在start-dfs.sh中：
``
HDFS_DATANODE_USER=root
HADOOP_SECURE_DN_USER=hdfs
HDFS_NAMENODE_USER=root
HDFS_SECONDARYNAMENODE_USER=root 
``

在start-yarn.sh中
``
YARN_RESOURCEMANAGER_USER=root
HADOOP_SECURE_DN_USER=yarn
YARN_NODEMANAGER_USER=root
``

```
>> //notes：此外，还可能碰到ssh互信的问题，或者用这个帖子里的 `cat id_rsa.pub >> authorized_keys` 或者自己用 `ssh-copy-id` 搞定（我发现前者也是有其好处的：比如用 `sudo -i` 切到root后，想用 `ssh-copy-id` 时发现不知道root的密码- -）。
