
# 官方

Apache Hadoop https://github.com/apache/hadoop
- > For the latest information about Hadoop, please visit our website at: http://hadoop.apache.org/
- > and our wiki, at: https://cwiki.apache.org/confluence/display/HADOOP/

`hdfs.h` https://github.com/apache/hadoop/blob/13b427fc05/hadoop-hdfs-project/hadoop-hdfs-native-client/src/main/native/libhdfs/include/hdfs/hdfs.h
- `LIBHDFS_EXTERNAL hdfsFS hdfsConnect(const char* nn, tPort port);`
- `LIBHDFS_EXTERNAL void hdfsBuilderSetNameNode(struct hdfsBuilder *bld, const char *nn);`
- `LIBHDFS_EXTERNAL void hdfsFreeBuilder(struct hdfsBuilder *bld);`
- `LIBHDFS_EXTERNAL int hdfsDisconnect(hdfsFS fs);`
- `LIBHDFS_EXTERNAL hdfsFile hdfsOpenFile(hdfsFS fs, const char* path, int flags, int bufferSize, short replication, tSize blocksize);`
  * > @deprecated Use the `hdfsStreamBuilder` functions instead. This function does not support setting block sizes bigger than 2 GB.
- `LIBHDFS_EXTERNAL hdfsFile hdfsStreamBuilderBuild(struct hdfsStreamBuilder *bld);`
- `LIBHDFS_EXTERNAL int hdfsCloseFile(hdfsFS fs, hdfsFile file);`
- `LIBHDFS_EXTERNAL int hdfsExists(hdfsFS fs, const char *path);`
- `LIBHDFS_EXTERNAL tSize hdfsRead(hdfsFS fs, hdfsFile file, void* buffer, tSize length);`
- `LIBHDFS_EXTERNAL tSize hdfsWrite(hdfsFS fs, hdfsFile file, const void* buffer, tSize length);`
- `LIBHDFS_EXTERNAL int hdfsFlush(hdfsFS fs, hdfsFile file);`
- `LIBHDFS_EXTERNAL int hdfsHFlush(hdfsFS fs, hdfsFile file);` 【`-->` 官方例子里用的上面那个，目前还没看出本质的区别，好像这个的意思是写完随时就能读？】
- `LIBHDFS_EXTERNAL int hdfsDelete(hdfsFS fs, const char* path, int recursive);`
- `LIBHDFS_EXTERNAL char* hdfsGetWorkingDirectory(hdfsFS fs, char *buffer, size_t bufferSize);`
- `LIBHDFS_EXTERNAL int hdfsCreateDirectory(hdfsFS fs, const char* path);`
- `LIBHDFS_EXTERNAL hdfsFileInfo *hdfsListDirectory(hdfsFS fs, const char* path, int *numEntries);`
- `LIBHDFS_EXTERNAL char*** hdfsGetHosts(hdfsFS fs, const char* path, tOffset start, tOffset length);`

Hadoop文档 https://hadoop.apache.org/docs/r1.0.4/cn/index.html
- Hadoop集群搭建 https://hadoop.apache.org/docs/r1.0.4/cn/cluster_setup.html
- Hadoop Shell命令 https://hadoop.apache.org/docs/r1.0.4/cn/hdfs_shell.html
- C API libhdfs https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/LibHdfs.html || https://hadoop.apache.org/docs/r1.2.1/libhdfs.html

# 命令

HDFS Commands: Hadoop Shell Commands to Manage HDFS https://www.edureka.co/blog/hdfs-commands-hadoop-shell-command
- > **expunge**: HDFS Command that makes the trash empty.

常用HDFS命令 https://www.jianshu.com/p/64a92a96fe3c
- > 关于HDFS的文件操作，主要使用以下3个命令：
  ```sh
  hadoop fs {args}
  ~~hadoop dfs {args} ~~ //已经废弃了
  hdfs dfs {args}
  ```
- > 其中命令2已经废弃，大家不要再使用了。fs和dfs的区别简要说一下，fs属于一个更抽象的概念，可以操作任何文件系统；而dfs只能操作HDFS文件系统相关（包括与Local FS间的操作）。比如，Hadoop本地模式中fs是local file system，这个时候dfs就不能用，只能用fs。

## hdfs命令

Hadoop - hdfs dfs常用命令的使用 https://www.cnblogs.com/lizm166/p/13355183.html
```sh
# 假定服务器端目录是 /opt/tmp/；服务器地址为 hdfs://${your_server_name}/。各个命令和本地文件系统操作差不多，还是很直观的。

hdfs dfs -ls hdfs://${your_server_name}/opt/tmp/
## 也可以加 -p 从而在服务器上创建多个目录，跟本地文件系统使用是类似的。
hdfs dfs -mkdir [-p] hdfs://${your_server_name}/opt/tmp/test

## 可选参数 -f 的意思是如果存在的话强制覆盖。
hdfs dfs -put [-f] 1.log hdfs://${your_server_name}/opt/tmp/test/
hdfs dfs -get hdfs://${your_server_name}/opt/tmp/test/1.log

hdfs dfs -rm hdfs://${your_server_name}/opt/tmp/test/1.log
## 虽然现在也还不清楚不带这个 -skipTrash 参数，也就是删除后放垃圾箱里，到底占不占服务器存储- -
hdfs dfs -rm -skipTrash hdfs://${your_server_name}/opt/tmp/test/1.log
hdfs dfs -rm -r hdfs://${your_server_name}/opt/tmp/test/
```

https://hadoop.apache.org/docs/r2.7.2/hadoop-project-dist/hadoop-common/FileSystemShell.html#text
- > **text**
  ```console
  Usage: hadoop fs -text <src>
  Takes a source file and outputs the file in text format. The allowed formats are zip and TextRecordInputStream.
  ```
  >> //notes：`hdfs dfs -text hdfs://${your_server_name}/${file_path}/filename.tsv`。之前碰到过一个 `.tsv` 文件，下载下来后 `cat` 是一堆乱码，但是用 `-text` 参数就可以正确读。

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

# Hadoop application develop (C/C++)

https://github.com/tmacam/libhdfscpp
- HDFS-APIs ~~http://wiki.apache.org/hadoop/HDFS-APIs~~  -->  https://cwiki.apache.org/confluence/display/HADOOP2/HDFS-APIs

HDFS简单介绍及用C语言訪问HDFS接口操作实践 https://www.cnblogs.com/mfmdaoyou/p/7008322.html
- > 1)主要用于存储和管理大数据文件(因为HDFS默认数据块为128M。所以它主要适合于存储百M级别及以上大小的文件)。
- > 3)设计理念为“一次写，多次读”。
- > 格式化一个HDFS文件系统，使用例如以下命令： `hdfs namenode -format`
- > 删除HDFS文件系统中存在的坏块及对应已损坏的文件，使用例如以下命令： `hdfs fsck -delete -files /`
- > 为了成功编译C语言client程序，我们须要预先安装7.0及以上版本号的JAVA JDK和Hadoop发行版，前者提供`libjvm.so`等库，后者则提供LIB HDFS连接所须要的库。
- > 为了成功运行C语言client程序，除了预先安装上面提到的程序外，我们还须要正确地设置几个关键环境变量。包含`LD_LIBRARY_PATH`和`CLASSPATH`的设置。关于`LD_LIBRARY_PATH`环境变量。主要是须要加入`libjvm.so`和`libhdfs.so`库所在路径；而针对CLASSPATH则须要囊括Hadoop提供的全部jar包的全路径信息(详细可通过find+awk组合命令来实现)。否则C语言client程序总会报缺少某个类而无法运行的错误。

《Hadoop MapReduce实战手册》一2.9 使用HDFS的C API（libhdfs） https://developer.aliyun.com/article/97939

C APIs https://support.huaweicloud.com/intl/en-us/devg-mrs/mrs_06_0141.html 【这个内容很全。】
- > View PDF:
  >> MapReduce Service Development Guide https://support.huaweicloud.com/intl/en-us/devg-mrs/mrs-devg.pdf

libhdfs3 https://github.com/erikmuttersbach/libhdfs3
- > HDFS is implemented in JAVA language and additionally provides a JNI based C language library libhdfs. To use libhdfs, users must deploy the HDFS jars on every machine. This adds operational complexity for non-Java clients that just want to integrate with HDFS.
- > **Libhdfs3**, designed as an alternative implementation of libhdfs, is implemented based on native Hadoop RPC protocol and HDFS data transfer protocol. It gets rid of the drawbacks of JNI, and it has a lightweight, small memory footprint code base. In addition, it is easy to use and deploy.
- > Libhdfs3 is developed by [Pivotal]() and used in [HAWQ](), which is a massive parallel database engine in [Pivotal Hadoop Distribution](http://www.pivotal.io/big-data/pivotal-hd).

使用Hadoop的C API操作HDFS https://blog.csdn.net/cjf_wei/article/details/76374389

## 个人实战

C API libhdfs https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/LibHdfs.html `+` [C语言操作hdfs](https://www.jianshu.com/p/9a237f8c2314)
- > A Sample Program 
  >> 官网的例子还少标准库。。。下面是补全后的。。。
```sh
cat << EOF > above_sample.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hdfs.h"

int main(int argc, char **argv) {

    hdfsFS fs = hdfsConnect("default", 0);
    const char* writePath = "/tmp/testfile.txt";
    hdfsFile writeFile = hdfsOpenFile(fs, writePath, O_WRONLY |O_CREAT, 0, 0, 0);
    if(!writeFile) {
          fprintf(stderr, "Failed to open %s for writing!\n", writePath);
          exit(-1);
    }
    char* buffer = "Hello, World!";
    tSize num_written_bytes = hdfsWrite(fs, writeFile, (void*)buffer, strlen(buffer)+1);
    if (hdfsFlush(fs, writeFile)) {
           fprintf(stderr, "Failed to 'flush' %s\n", writePath);
          exit(-1);
    }
    hdfsCloseFile(fs, writeFile);
}
EOF

gcc above_sample.c -I/usr/local/hadoop/include -L/usr/local/hadoop/lib/native -lhdfs -o above_sample
$ ./above_sample
./above_sample: error while loading shared libraries: libhdfs.so.0.0.0: cannot open shared object file: No such file or directory
$
$ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/hadoop/lib/native
$
$ ./above_sample
Environment variable CLASSPATH not set!
getJNIEnv: getGlobalJNIEnv failed
Failed to open /tmp/testfile.txt for writing!
$

# 参考下面帖子（也就是加号后面那个）里的办法，配置一下 CLASSPATH 环境变量即可。再执行下发现hdfs里确实多了 /tmp/testfile.txt 文件。
$ export CLASSPATH=`hadoop classpath --glob`
$
$ ./above_sample
2021-03-12 03:07:30,237 INFO sasl.SaslDataTransferClient: SASL encryption trust check: localHostTrusted = false, remoteHostTrusted = false
$
```

[C语言操作hdfs](https://www.jianshu.com/p/9a237f8c2314)
- > libhdfs.so动态链接库实现了c调用hdfs java程序，即其依赖于java，所以hadoop的jar包和相关配置文件也就需要加载到内存中。为此在运行前需要配置CLASSPAT环境变量，这样在程序运行过程中就可以根据CLASSPATH指定的路径去加载jar和相关配置到内存，以提供c通过JNI调用。
- > 配置临时classpath
  ```sh
  #hadoop classpath --glob命令会生成classpath所需内容
  [root@CentOS /]# export CLASSPATH=`hadoop classpath --glob`
  ```

# Hadoop application develop (Go)

HDFS for Go
- https://github.com/colinmarc/hdfs
- https://pkg.go.dev/github.com/colinmarc/hdfs/v2 
- https://pkg.go.dev/github.com/colinmarc/hdfs

Making HDFS a hundred times faster https://medium.com/sqooba/making-hdfs-a-hundred-times-faster-ac75b8b5e0b4

go http实现HDFS操作 https://studygolang.com/articles/17042
- >
  ```console
  目前使用golang调用hdfs的方式有以下几种：
    · 使用go http 调用webHDFS/httpfs接口实现。
    · 使用c lib提供的API, 并用cgo进行封装，然后调用实现。
    · 使用第三方golang客户端实现。（https://github.com/colinmarc/hdfs）。
  ```
- > Hadoop 官方接口地址：http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/WebHDFS.html

Go day 30 (HDFS to Redis & keep going) https://ithelp.ithome.com.tw/articles/10206670

How to write Map/Reduce tasks in Golang? https://stackoverflow.com/questions/31832266/how-to-write-map-reduce-tasks-in-golang

Golang Client Examples https://golang.hotexamples.com/examples/github.com.colinmarc.hdfs/Client/-/golang-client-class-examples.html

A Simple MapReduce in Go https://levelup.gitconnected.com/a-simple-mapreduce-in-go-42c929b000c5

# hdfs源码相关

libhdfs源码分析(1) https://blog.csdn.net/vinowan/article/details/7440163

Hadoop源代码分析(完整版) https://blog.csdn.net/huoyunshen88/article/details/8611629

# 其他

Apache Hadoop https://en.wikipedia.org/wiki/Apache_Hadoop

【[:star:][`*`]】 Hadoop Tutorial: All you need to know about Hadoop! https://www.edureka.co/blog/hadoop-tutorial/

## hdfs的append模式

python 与hadoop之pyhdfs的append https://blog.csdn.net/w894607785/article/details/50245655

libhdfs does not call FileSystem.append when O_APPEND passed to hdfsOpenFile https://issues.apache.org/jira/browse/HADOOP-4494

# 问题处理

## 1.语言问题，只需要 `export LC_ALL=C` 即可

What is the correct way to fix an assertion in loadlocale.c? https://askubuntu.com/questions/1081901/what-is-the-correct-way-to-fix-an-assertion-in-loadlocale-c

## 2.`hdfsGetPathInfo()`函数的使用要在`hdfsOpenFile()`之后

https://cpp.hotexamples.com/zh/examples/-/-/hdfsGetPathInfo/cpp-hdfsgetpathinfo-function-examples.html
```cpp
// 这个函数返回一个构造好的chunkid和每个chunk的指针
// 这个里面的chunkId肯定是要在blockManager注册然后汇报信息的
// put的话也是会这样的，可以将这个函数中调用put然后统一汇报信息的接口
ChunkInfo BlockManager::loadFromHdfs(string file_name){
	// 由此函数得到的<blockId,指针>
	ChunkInfo ci;
	string file_name_former,file_name_latter;
	unsigned pos=file_name.rfind("$");
	file_name_former=file_name.substr(0,pos);
	file_name_latter=file_name.substr(pos+1,file_name.length());
	int offset=atoi(file_name_latter.c_str());
	hdfsFS fs=hdfsConnect(Config::hdfs_master_ip.c_str(),Config::hdfs_master_port);
	hdfsFile readFile=hdfsOpenFile(fs,file_name_former.c_str(),O_RDONLY,0,0,0);
	hdfsFileInfo *hdfsfile=hdfsGetPathInfo(fs,file_name_former.c_str());
	if(!readFile){
		cout<<"open file error"<<endl;
	}
	unsigned length=0;
	length=length+CHUNK_SIZE*offset;
	if(length<hdfsfile->mSize){
		void *rt=malloc(CHUNK_SIZE);		//newmalloc
		tSize bytes_num=hdfsPread(fs,readFile,length,rt,CHUNK_SIZE);
		ostringstream chunkid;
		chunkid<<file_name.c_str()<<"$"<<offset;
//		ci.chunkId=chunkid.gestr().c_str();
		ci.hook=rt;
	}else{
		ostringstream chunkid;
		chunkid<<file_name.c_str()<<"$"<<offset;
//		ci.chunkId=chunkid.str().c_str();
		ci.hook=0;
	}
	hdfsCloseFile(fs,readFile);
	hdfsDisconnect(fs);
	return ci;
}
```

hdfsGetPathInfo() https://docs.datafabric.hpe.com/62/DevelopmentGuide/hdfsGetPathInfo.html

## 3. 并发读写问题

HDFS在同一时刻只能读或者写同一文件么，能不能并发执行？ - 知乎 https://www.zhihu.com/question/28723376

HDFS多线程追加写数据踩坑 https://blog.csdn.net/weixin_44252761/article/details/89517393

HDFS的读写流程 https://www.cnblogs.com/feiyumo/p/12541296.html

《hadoop权威指南》笔记二： hdfs读写过程剖析 https://cloud.tencent.com/developer/article/1500068

## 4. libhdfs内存泄露

Hdfs FileSystem 使用姿势不对导致的内存泄露 https://blog.csdn.net/u013332124/article/details/89302271

HDFS简单介绍及用C语言訪问HDFS接口操作实践 https://www.cnblogs.com/mfmdaoyou/p/7008322.html || https://blog.csdn.net/weixin_34010949/article/details/85903011
- > 3.遇到的主要问题描写叙述与分析
  ```console
  对于LIB HDFS接口的不足之处，在本文第三部分(LIB HDFS接口简单介绍)已有大致描写叙述。
  在实际性能測试过程中。因LIB HDFS接口引起的问题主要包含：lease租约回收异常和程序句柄资源释放异常等两大类。
  
  我们换了多种測试模型，基本确认LIB HDFS接口在某些异常情况下(如频繁对同一个文件运行append操作)会产生上述问题。
  
  所以假设在项目中须要实际应用LIB HDFS接口，就须要我们改进client程序处理流程，尽量规避和降低上述问题的产生。能够採用例如以下方法：
  1)在client程序和HDFS文件系统间添加缓存的方式降低HDFS的读写密度；
  2)降低对HDFS文件系统的更新操作，比如文件写入完毕后就不再运行append操作，仅仅运行read操作。
  ```
