
PyArrow 0.16.0 fs.HadoopFileSystem throws HDFS connection failed https://stackoverflow.com/questions/60954201/pyarrow-0-16-0-fs-hadoopfilesystem-throws-hdfs-connection-failed
- https://stackoverflow.com/questions/60954201/pyarrow-0-16-0-fs-hadoopfilesystem-throws-hdfs-connection-failed/63201160#63201160
  * > Set your HDFS classpath environment
    ```sh
    export CLASSPATH=`$HADOOP_HOME/bin/hdfs classpath --glob`
    ```
    > locate the hdfs bin directory to set this variable
    >> //notes：一般只要是 `hdfs` 命令能 work，但是同样的环境下用 programming api 却不行，那大概率都是环境变量的问题。
