
# HDFS application develop (C/C++)

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

# HDFS application develop (Go)

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
