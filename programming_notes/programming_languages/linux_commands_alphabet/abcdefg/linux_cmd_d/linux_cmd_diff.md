
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

Linux下快速比较两个目录的不同 https://www.cnblogs.com/f-ck-need-u/p/9071033.html

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
