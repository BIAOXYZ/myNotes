
# 命令

HDFS Commands: Hadoop Shell Commands to Manage HDFS https://www.edureka.co/blog/hdfs-commands-hadoop-shell-command
- > **expunge**: HDFS Command that makes the trash empty.

BASIC HDFS FILE OPERATIONS COMMANDS https://www.alluxio.io/learn/hdfs/basic-file-operations-commands/
- > `touchz`: Creates an empty file in HDFS.
  ```sh
  $ hadoop fs -touchz URI
  ```
- > `test`: Test an HDFS file’s existence of an empty file or if it is a directory or not.

常用HDFS命令 https://www.jianshu.com/p/64a92a96fe3c
- > 关于HDFS的文件操作，主要使用以下3个命令：
  ```sh
  hadoop fs {args}
  ~~hadoop dfs {args} ~~ //已经废弃了
  hdfs dfs {args}
  ```
- > 其中命令2已经废弃，大家不要再使用了。fs和dfs的区别简要说一下，fs属于一个更抽象的概念，可以操作任何文件系统；而dfs只能操作HDFS文件系统相关（包括与Local FS间的操作）。比如，Hadoop本地模式中fs是local file system，这个时候dfs就不能用，只能用fs。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

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

## `-tail`

Why is there no 'hadoop fs -head' shell command? https://stackoverflow.com/questions/19778137/why-is-there-no-hadoop-fs-head-shell-command
```sh
A fast method for inspecting files on HDFS is to use tail:

$ hadoop fs -tail /path/to/file

This displays the last kilobyte of data in the file, which is extremely helpful. 
However, the opposite command head does not appear to be part of the shell command collections. I find this very surprising.
```
- https://stackoverflow.com/questions/19778137/why-is-there-no-hadoop-fs-head-shell-command/19779388#19779388
  * > I would say it's more to do with efficiency - ***a head can easily be replicated by piping the output of a `hadoop fs -cat` through the linux `head` command***.
    ```sh
    hadoop fs -cat /path/to/file | head
    ```
  * > This is efficient as ***`head` will close out the underlying stream after the desired number of lines have been output***
  * > Using `tail` in this manner would be considerably less efficient - as you'd have to stream over the entire file (all HDFS blocks) to find the final x number of lines.
    ```sh
    hadoop fs -cat /path/to/file | tail
    ```
  * > The `hadoop fs -tail` command as you note works on the last kilobyte - ***hadoop can efficiently find the last block and skip to the position of the final kilobyte, then stream the output***. Piping via tail can't easily do this.

## `-touchz`

How to create an empty file in Hadoop https://www.edureka.co/community/88364/how-to-create-an-empty-file-in-hadoop

## `-test -[defsz]`
```
参数说明：
-d: 检查指定的路径是否存在且是一个目录
-e: 检查路径是否存在
-f: 检查指定的路径是否存在且是一个文件
-s: 检查文件大小是否大于0（即文件非空）
-z: 检查文件是否为零长度

如果文件存在，命令返回0；如果文件不存在，命令返回1。根据需要，你还可以使用其他选项来检查文件的类型、大小和其他属性。
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 已验证技巧

## 按时间顺序显示 ls 的文件

How can we list files in HDFS directory as per timestamp https://www.edureka.co/community/3134/how-can-we-list-files-in-hdfs-directory-as-per-timestamp
```sh
hdfs dfs -ls /tmp | sort -k6,7
```

## 查看某个目录里所有文件大小的总和

hdfs查看目录文件的大小 https://blog.csdn.net/Aying_seeyou/article/details/109988019
- > 3.第三种方式：查看指定目录的总大小
  ```sh
  hdfs dfs -du -s -h /目录
  ```
  >> //notes：至少我个人目前使用的 `Hadoop 2.6.0` 版本不能写成 `-sh`，必须分开写成 `-s -h`。

## 查看整个目录的结构（实现类似 tree 的效果）
```sh
# 注：在一些文章中看到的是用小写的 -r，可能是旧版 hdfs 的问题。总之，如果遇到问题，大小写互换下就可以。
hdfs dfs -ls -R /目录
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 不常用命令

## `distcp`

DistCp Guide https://hadoop.apache.org/docs/stable/hadoop-distcp/DistCp.html || https://hadoop.apache.org/docs/r1.2.1/distcp.html

DistCp https://hadoop.org.cn/docs/hadoop-distcp/DistCp.html

HDFS并行复制Distcp https://www.cnblogs.com/skyl/p/4744676.html
