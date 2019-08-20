
第2章 rsync(一)：基本命令和用法 https://www.cnblogs.com/f-ck-need-u/p/7220009.html 【by 骏马金龙】【[`*`][:star:]】

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
