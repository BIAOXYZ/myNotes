
【from 鸟哥的Linux私房菜：基础学习篇 第四版】`8.3 打包指令： tar` https://wizardforcel.gitbooks.io/vbird-linux-basic-4e/content/71.html
> 另外，由于“ -f filename ”是紧接在一起的，过去很多文章常会写成“-jcvf filename”，这样是对的， 但由于选项的顺序理论上是可以变换的，所以很多读者会误认为“-jvfc filename”也可以～事实上这样会导致产生的文件名变成 c ！ 因为 -fc 嘛！所以啰，建议您在学习 tar 时，将“ -f filename ”与其他选项独立出来，会比较不容易发生问题。
>> 感觉并没有必要，踩过一两次坑也就记住了。

linux系统下tar/gz/7z/xz/bz2/zip等各种格式的打包压缩解压 https://blog.csdn.net/LEON1741/article/details/54317715
```sh
2、压缩命令

tar -cvf target_name.tar dir_or_file					# 将目标打包成一个*.tar格式的文件
tar -czvf target_name.tgz dir_or_file					# 将目标打包成一个*.tgz格式的文件
tar -czvf target_name.tar.gz dir_or_file				# 将目标打包并压缩成一个*.tar.gz格式的文件
tar -cjvf target_name.tar.bz2 dir_or_file				# 将目标打包并压缩成一个*.tar.bz2格式的文件
```

# 实战

```shell
root@myopenshift backup $ ll
total 4
drwxr-x---. 7 root root 4096 Aug 22 22:08 scaler-operator


root@myopenshift backup $ tar czvf scaler-operator.tgz scaler-operator/
scaler-operator/
scaler-operator/config_ocsingle
scaler-operator/deploy/
scaler-operator/deploy/crds/
scaler-operator/deploy/crds/scalerop_v1_scaler_crd.yaml
scaler-operator/deploy/crds/scalerop_v1_scaler_cr2.yaml
...
...
...
root@myopenshift backup $ ll
total 48
drwxr-x---. 7 root root  4096 Aug 22 22:08 scaler-operator
-rw-r--r--. 1 root root 42659 Aug 23 03:44 scaler-operator.tgz


root@myopenshift backup $ tar czvf scaler-operator.tar.gz scaler-operator/
...
...
...
root@myopenshift backup $ ll
total 92
drwxr-x---. 7 root root  4096 Aug 22 22:08 scaler-operator
-rw-r--r--. 1 root root 42659 Aug 23 03:56 scaler-operator.tar.gz
-rw-r--r--. 1 root root 42659 Aug 23 03:44 scaler-operator.tgz


root@myopenshift backup $ tar cvf scaler-operator.tar scaler-operator/
...
...
...
root@myopenshift backup $ ll
total 336
drwxr-x---. 7 root root   4096 Aug 22 22:08 scaler-operator
-rw-r--r--. 1 root root 245760 Aug 23 03:59 scaler-operator.tar
-rw-r--r--. 1 root root  42659 Aug 23 03:56 scaler-operator.tar.gz
-rw-r--r--. 1 root root  42659 Aug 23 03:44 scaler-operator.tgz


root@myopenshift backup $ tar cjvf scaler-operator.tar.bz2 scaler-operator/
...
...
...
root@myopenshift backup $ ll
total 380
drwxr-x---. 7 root root   4096 Aug 22 22:08 scaler-operator
-rw-r--r--. 1 root root 245760 Aug 23 03:59 scaler-operator.tar
-rw-r--r--. 1 root root  41333 Aug 23 04:01 scaler-operator.tar.bz2
-rw-r--r--. 1 root root  42659 Aug 23 03:56 scaler-operator.tar.gz
-rw-r--r--. 1 root root  42659 Aug 23 03:44 scaler-operator.tgz
```
