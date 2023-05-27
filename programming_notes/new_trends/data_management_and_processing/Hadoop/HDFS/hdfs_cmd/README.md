
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

# hdfs命令

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

BASIC HDFS FILE OPERATIONS COMMANDS https://www.alluxio.io/learn/hdfs/basic-file-operations-commands/

12 frequently used Hadoop HDFS Commands with Examples & usage https://data-flair.training/blogs/hdfs-hadoop-commands/

## `-text`

https://hadoop.apache.org/docs/r2.7.2/hadoop-project-dist/hadoop-common/FileSystemShell.html#text
- > **text**
  ```console
  Usage: hadoop fs -text <src>
  Takes a source file and outputs the file in text format. The allowed formats are zip and TextRecordInputStream.
  ```
  >> //notes：`hdfs dfs -text hdfs://${your_server_name}/${file_path}/filename.tsv`。之前碰到过一个 `.tsv` 文件，下载下来后 `cat` 是一堆乱码，但是用 `-text` 参数就可以正确读。

## `-getmerge`

Merging multiple files into one within Hadoop https://stackoverflow.com/questions/3548259/merging-multiple-files-into-one-within-hadoop

### 合并远程的文件，且本地不下载

How can I merge files in directory in hdfs without using get merge command? https://stackoverflow.com/questions/41116074/how-can-i-merge-files-in-directory-in-hdfs-without-using-get-merge-command
- https://stackoverflow.com/questions/41116074/how-can-i-merge-files-in-directory-in-hdfs-without-using-get-merge-command/41118618#41118618
  * > `hadoop fs -cat [dir]/* | hadoop fs -put - [destination file]`
    >> //notes：个人实战成功的命令为：`hdfs dfs -cat hdfs://xxx/yyy/zzz/* | hdfs dfs -put - hdfs://xxx/yyy/zzz/merged.txt`
    >>> //notes2：会自动创建 `merged.txt`，如果这个文件已经存在，命令会执行失败。

Hadoop fs getmerge to remote server/machine due to low disk space https://stackoverflow.com/questions/27627535/hadoop-fs-getmerge-to-remote-server-machine-due-to-low-disk-space

## `-appendToFile`

HDFS Command Line Append https://stackoverflow.com/questions/13365604/hdfs-command-line-append
