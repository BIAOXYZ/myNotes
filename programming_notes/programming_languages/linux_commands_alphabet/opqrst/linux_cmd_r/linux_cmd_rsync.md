
第2章 rsync(一)：基本命令和用法 https://www.cnblogs.com/f-ck-need-u/p/7220009.html 【by 骏马金龙】【[`*`][:star:]】
```sh
另外，使用rsync一定要注意的一点是，源路径如果是一个目录的话，带上尾随斜线和不带尾随斜线是不一样的，不带
尾随斜线表示的是整个目录包括目录本身，带上尾随斜线表示的是目录中的文件，不包括目录本身。例如：

[root@xuexi ~]# rsync -a /etc /tmp
[root@xuexi ~]# rsync -a /etc/ /tmp

# 补充：经我实际测试，以上文两个目录为例，更详细的一般结果如下：
1.如果源地址不带最后的斜杠，会把etc目录里的文件连同etc目录一起复制到tmp目录下，结果是 /tmp/etc/FILES-in-etc
2.如果源地址带了最后的斜杠，只会把etc目录里的文件复制到tmp目录下，结果是 /tmp/FILES-in-etc
以上两点不止适用于两个本地目录，对远程目录间同步也是一样的。

3.目标目录的/tmp带不带尾斜杠无影响，也就是/tmp和/tmp/一样（至少CentOS 7是这样）
4.即使目标目录不存在也可以直接用，会自动创建。比如假定tmp目录下没有123子目录，直接执行 rsync -a /etc /tmp/123 
  命令执行成功后目标机器是 /tmp/123/etc/FILES-in-etc
```

```
$ pwd
/opt/ansible/roles

$ rsync -a /root/tutorial/workshop-operator/roles/workshop/ /opt/ansible/roles/
$ ll
total 32
drwxr-x---. 2 root root 4096 Jul 18 02:04 defaults
drwxr-x---. 2 root root 4096 Jul 18 02:04 files
drwxr-x---. 2 root root 4096 Jul 18 02:04 handlers
drwxr-x---. 2 root root 4096 Jul 18 02:04 meta
-rw-r--r--. 1 root root 1328 Jul 18 02:04 README.md
drwxr-x---. 2 root root 4096 Jul 18 02:04 tasks
drwxr-x---. 2 root root 4096 Jul 18 02:07 templates
drwxr-x---. 2 root root 4096 Jul 18 02:04 vars

$ rsync -a /root/tutorial/workshop-operator/roles/workshop /opt/ansible/roles/
$ ll
total 4
drwxr-x---. 9 root root 4096 Jul 18 02:04 workshop
```

Rsync（远程同步）：10 Linux中Rsync命令的实际示例 https://www.howtoing.com/rsync-local-remote-file-synchronization-commands/

rsync 一个超大文件夹“./attachments”过后，怎样检测两台服务器的这个“./attachments”文件夹一模一样 https://www.v2ex.com/t/593361
- > -c, --checksum skip based on checksum, not mod-time & size <br> 用 rsync -c
