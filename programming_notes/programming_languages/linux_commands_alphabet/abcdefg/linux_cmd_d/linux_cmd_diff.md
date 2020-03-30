
# diff比较两个文件夹的不同

linux 比较两个文件夹不同 (diff命令, md5列表) https://www.cnblogs.com/xudong-bupt/p/6493903.html || https://www.jb51.net/article/140597.htm
```sh
比较文件夹diff，可以直接使用diff命令
[root@~]# diff -urNa dir1 dir2
　　-a Treat all files as text and compare them line-by-line, even if they do not seem to be text.
　　-N, --new-file
　　　　In directory comparison, if a file is found in only one directory, treat it as present but empty in the other directory.
　　-r When comparing directories, recursively compare any subdirectories found.

　　-u Use the unified output format.
 
 
比较文件夹diff，也可以比较文件MD5列表。下面命令可以获取文件夹中文件md5列表
find /home/ -type f -not \( -name '.*' \) -exec md5sum {} \;
说明：(1) /home/文件目录
　　  (2) -type f 文件类型为普通文件
　　  (3) -not \( -name '.*' \)  过滤掉隐藏文件。可以过滤掉不需要考虑的文件
     (4) -exec md5sum {} \;  对每个文件执行md5sum命令


用tar命令压缩后，比较文件的MD5是不行的。tar压缩会带上文件的时间
```

Linux下快速比较两个目录的不同 https://www.cnblogs.com/f-ck-need-u/p/9071033.html 【[`*`][:star:]】
```sh
方法一：使用diff
diff -r directory1 directory2

方法三：find结合diff
----------------------------------------------------------------------------------------------------
find directory1 -printf "%P\n" | sort > file1
find directory2 -printf "%P\n" | sort | diff file1 -
2d1
< 1.png
4a4
> 4.png
----------------------------------------------------------------------------------------------------

方法四：使用rsync
----------------------------------------------------------------------------------------------------
rsync -rvn --delete directory1/ directory2 | sed -n '2,/^$/{/^$/!p}'
deleting a/xyz.avi
rsync.txt
新建文件夹/542D0.mp4
----------------------------------------------------------------------------------------------------
其中deleting所在的行就是directory2中多出的文件。其他的都是directory中多出的文件。

如果想区分出不同的是目录还是文件。可以加上"-i"选项。
----------------------------------------------------------------------------------------------------
rsync -rvn -i --delete directory1/ directory2 | sed -n '2,/^$/{/^$/!p}'
*deleting   a/xyz.avi
>f+++++++++ rsync.txt
>f+++++++++ 新建文件夹/542D0.mp4
----------------------------------------------------------------------------------------------------
其中>f+++++++++中的f代表的是文件，d代表的目录。

上面的rsync比较目录有几点要说明：
1. 一定不能缺少-n选项，它表示dry run，也就是试着进行rsync同步，但不会真的同步。
2. 第一个目录(directory1/)后一定不能缺少斜线，否则表示将directory1整个目录同步到directory2目录下。
3. 其它选项，如"-r -v --delete"也都不能缺少，它们的意义想必都知道。
4. sed的作用是过滤掉和文件不相关的内容。
5. 以上rsync假定了比较的两个目录中只有普通文件和目录，没有软链接、块设备等特殊文件。如果有，请考虑加上对应的
   选项或者使用-a替代-r，否则结果中将出现skipping non-regular file的提示。但请注意，如果有软链接，且加了对应选项
   (-l或-a或其他相关选项)，则可能会出现fileA-->fileB的输出。
6. 效率很高，因为rsync的原因，筛选的可定制性也非常强。
```

# 个人实战

```sh
# 对于某一个目录没有的文件，从时间和那一串0可以看出来
# 目录末尾带不带斜杠貌似都一样
[root@c4-infra02 db2test3.2.0]# diff -urNa ibm-db2oltp-dev ibm-db2oltp-dev2
diff -urNa ibm-db2oltp-dev/ibm_cloud_pak/qualification.yaml ibm-db2oltp-dev2/ibm_cloud_pak/qualification.yaml
--- ibm-db2oltp-dev/ibm_cloud_pak/qualification.yaml    2020-03-11 14:33:17.948523955 +0800
+++ ibm-db2oltp-dev2/ibm_cloud_pak/qualification.yaml   1970-01-01 08:00:00.000000000 +0800
@@ -1,11 +0,0 @@
-qualification:
-  levelName: "ibm-cloud-pak"
-  levelDescription: "IBM Cloud Pak"
-  issueDate: "09/2018"
-  duration: "6M"
-  terms: "Valid from date of issue. Security vulnerability management and enhancements are delivered on the latest version of the chart and images."
-prereqs:
-  security:
-    kubernetes:
-      podSecurityPolicy:
-        name: "ibm-privileged-psp"
diff -urNa ibm-db2oltp-dev/values.yaml ibm-db2oltp-dev2/values.yaml
--- ibm-db2oltp-dev/values.yaml 2020-03-11 14:33:17.947523991 +0800
+++ ibm-db2oltp-dev2/values.yaml        2020-03-13 14:48:41.862479732 +0800
@@ -16,8 +16,8 @@
     secretName: ""
 arch: ""
 image:
-  repository: store/ibmcorp/db2_developer_c
-  tag: 11.1.4.4
+  repository: ibmcom/db2
+  tag: 11.5.0.0
   pullPolicy: IfNotPresent
 service:
   name: ibm-db2oltp-dev
[root@c4-infra02 db2test3.2.0]#

# 这个好像是快速找出具体哪些文件不同，主要就是-q的作用吧
[root@c4-infra02 db2test3.2.0]# diff -Nrq ibm-db2oltp-dev/ ibm-db2oltp-dev2/
Files ibm-db2oltp-dev/db2values_without_persistence.yaml and ibm-db2oltp-dev2/db2values_without_persistence.yaml differ
Files ibm-db2oltp-dev/db2values_with_right_image.yaml and ibm-db2oltp-dev2/db2values_with_right_image.yaml differ
Files ibm-db2oltp-dev/ibm_cloud_pak/manifest.yaml and ibm-db2oltp-dev2/ibm_cloud_pak/manifest.yaml differ
Files ibm-db2oltp-dev/ibm_cloud_pak/qualification.yaml and ibm-db2oltp-dev2/ibm_cloud_pak/qualification.yaml differ
Files ibm-db2oltp-dev/templates/db2-statefulset.yaml and ibm-db2oltp-dev2/templates/db2-statefulset.yaml differ
Files ibm-db2oltp-dev/templates/_sch-chart-config.tpl and ibm-db2oltp-dev2/templates/_sch-chart-config.tpl differ
Files ibm-db2oltp-dev/templates/tests/test-connection.yaml and ibm-db2oltp-dev2/templates/tests/test-connection.yaml differ
Files ibm-db2oltp-dev/values.yaml and ibm-db2oltp-dev2/values.yaml differ
[root@c4-infra02 db2test3.2.0]#
```
