
# 官方

Apache Hadoop https://github.com/apache/hadoop
- > For the latest information about Hadoop, please visit our website at: http://hadoop.apache.org/
- > and our wiki, at: https://cwiki.apache.org/confluence/display/HADOOP/

Hadoop文档 https://hadoop.apache.org/docs/r1.0.4/cn/index.html
- Hadoop集群搭建 https://hadoop.apache.org/docs/r1.0.4/cn/cluster_setup.html
- Hadoop Shell命令 https://hadoop.apache.org/docs/r1.0.4/cn/hdfs_shell.html
- C API libhdfs https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/LibHdfs.html || https://hadoop.apache.org/docs/r1.2.1/libhdfs.html

# 命令

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

# 集群搭建

## docker方式（缺点是容器里估计编译困难）

docker-compose快速搭建hadoop https://www.jianshu.com/p/9b548517abbb  【已验证】

## 二进制方式

How to Install Hadoop in Stand-Alone Mode on Debian 9 https://www.digitalocean.com/community/tutorials/how-to-install-hadoop-in-stand-alone-mode-on-debian-9  【已验证】【不过文章里用的Hadoop版本已经过时了，我用的是`Hadoop 3.2.1`版本】
- How To Install Java with Apt on Debian 9 https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-debian-9
  * > 
    ```sh
    sudo apt update
    sudo apt install default-jre
    ```

# Hadoop application develop

https://github.com/tmacam/libhdfscpp
- HDFS-APIs ~~http://wiki.apache.org/hadoop/HDFS-APIs~~  -->  https://cwiki.apache.org/confluence/display/HADOOP2/HDFS-APIs

《Hadoop MapReduce实战手册》一2.9 使用HDFS的C API（libhdfs） https://developer.aliyun.com/article/97939

# 其他

Apache Hadoop https://en.wikipedia.org/wiki/Apache_Hadoop
