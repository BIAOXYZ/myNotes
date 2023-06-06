
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
    >> 【[:star:][`*`]】 //notes：个人实战成功的命令为：`hdfs dfs -cat hdfs://xxx/yyy/zzz/* | hdfs dfs -put - hdfs://xxx/yyy/zzz/merged.txt`
    >>> 【[:star:][`*`]】 //notes2：会自动创建 `merged.txt`，***如果这个文件已经存在，命令会执行失败***——要想能不止一次合并，***且不经过本地文件***（这个是核心点所在，否则如果允许经过本地文件，那 `-getmerge` 本身就可以合并，然后下载合并后的文件到本地），可以参考 `-appendToFile` 部分的实战。

Hadoop fs getmerge to remote server/machine due to low disk space https://stackoverflow.com/questions/27627535/hadoop-fs-getmerge-to-remote-server-machine-due-to-low-disk-space

Best way to merge multi part file into single file? https://community.cloudera.com/t5/Support-Questions/Best-way-to-merge-multi-part-file-into-single-file/m-p/104773

How to join multiple csv files in folder to one output file? https://community.cloudera.com/t5/Support-Questions/How-to-join-multiple-csv-files-in-folder-to-one-output-file/td-p/181377

## `-appendToFile`

HDFS Command Line Append https://stackoverflow.com/questions/13365604/hdfs-command-line-append

Can I change the contents of a file present inside HDFS? If Yes, how and what are the Pros and cons ? https://community.cloudera.com/t5/Support-Questions/Can-I-change-the-contents-of-a-file-present-inside-HDFS-If/td-p/221122
- https://community.cloudera.com/t5/Support-Questions/Can-I-change-the-contents-of-a-file-present-inside-HDFS-If/m-p/221123#M182997
  * > Yes, you can append some rows to the existing text file in hdfs `appendToFile`
  * > Usage: `hdfs dfs -appendToFile <localsrc> ... <dst>`
  * > Append single src, or multiple srcs from local file system to the destination file system. Also reads input from stdin and appends to destination file system.
    ```sh
    hdfs dfs -appendToFile localfile /user/hadoop/hadoopfile
    hdfs dfs -appendToFile localfile1 localfile2 /user/hadoop/hadoopfile
    hdfs dfs -appendToFile localfile hdfs://nn.example.com/hadoop/hadoopfile
    hdfs dfs -appendToFile - hdfs://nn.example.com/hadoop/hadoopfile Reads the input from stdin.
    echo "hi"|hdfs dfs -appendToFile - /user/hadoop/hadoopfile
    ```
  * > pros: A small file is one which is significantly smaller than the HDFS block sizeEvery file, Directory and block in HDFS is represented as an object in the namenode’s memory, the problem is that HDFS can’t handle lots of files, it is good to have large files in HDFS instead of small files.
  * > Cons: When we wants append to hdfs file we must need to obtain a lease which is essentially a lock, to ensure the single writer semantics.

***个人实战：***
>> 【[:star:][`*`]】 //notes：实际上即使是 `-appendToFile`，标准的用法也是把一个本地文件的内容追加到一个远程文件里。但是综合考虑 `-appendToFile` 和 `-getmerge` 里的例子，最终还是解决了（下面这个命令可以多次执行，不会因为执行一次后 `merged.txt` 已经存在了报错）：
```sh
hdfs dfs -cat hdfs://xxx/yyy/zzz/111.txt | hdfs dfs -appendToFile - hdfs://xxx/yyy/zzz/merged.txt
```
>>> 【[:star:][`*`]】 //notes：上面那句会把表头都 append 过去，如果想要省略表头，可以先经过 `| tail -n +2` 过滤一下——这个还是 ChatGPT 出的主意，真的还不错呢。
```sh
hdfs dfs -cat hdfs://xxx/yyy/zzz/111.txt | tail -n +2 | hdfs dfs -appendToFile - hdfs://xxx/yyy/zzz/merged.txt
```
