
# HDFS官方

Apache Hadoop https://en.wikipedia.org/wiki/Apache_Hadoop

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
- Hadoop分布式文件系统：架构和设计 https://hadoop.apache.org/docs/r1.0.4/cn/hdfs_design.html
- Hadoop集群搭建 https://hadoop.apache.org/docs/r1.0.4/cn/cluster_setup.html
- Hadoop Shell命令 https://hadoop.apache.org/docs/r1.0.4/cn/hdfs_shell.html
- C API libhdfs https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/LibHdfs.html || https://hadoop.apache.org/docs/r1.2.1/libhdfs.html

# HDFS构架和组件

【[:star:][`*`]】 Hadoop Tutorial: All you need to know about Hadoop! https://www.edureka.co/blog/hadoop-tutorial/

Hadoop之HDFS简介 https://mp.weixin.qq.com/s/39gkTDLyumUYK_eFlM2Pzg || https://www.infoq.cn/article/rudfbprmb5vwfpydus5r

HDFS介绍(一) https://juejin.cn/post/6979117624978325534
