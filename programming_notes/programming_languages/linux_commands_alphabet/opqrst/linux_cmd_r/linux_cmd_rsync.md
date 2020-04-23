
# 源头
// 已无法记起。

# 相关命令

- `scp`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

Rsync (简体中文) https://wiki.archlinux.org/index.php/Rsync_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

# 其他博客类链接

rsync 的使用方法 https://segmentfault.com/a/1190000015669114
```sh
目录SRC是否以斜杠结尾，会影响同步的结果：

以斜杠结尾：目录DEST里面有 [目录SRC里面的文件]
不以斜杠结尾：目录DEST里面有 [目录SRC本身]
----------------------------------------------------------------------------------------------------
但rsync不会同步文件的 modify time ，凡是有数据同步的文件，目的端的文件的 modify time 总是会被
修改为最新时刻的时间。

rsync不会太关注目的端文件的 rwx 权限，如果目的端没有此文件，那么权限会保持与源端一致；如果目
的端有此文件，则权限不会随着源端变更。

只要rsync有对源文件的读权限，且对目标路径有写权限，rsync就能确保目的端文件同步到和源端一致。

rsync只能以登陆目的端的账号来创建文件，它没有能力保持目的端文件的输主和属组和源端一致。除非
你使用 root 权限，才有资格要求属主一致、属组一致。
----------------------------------------------------------------------------------------------------
-a 选项

-a选项是rsync里比较霸道的一个选项，因为你使用-a选项，就相当于使用了-rlptgoD这一坨选项。以一
敌七，唯-a选项也。（在看了前文之后，你应该可以很轻松的理解这七个选项的作用了。）

-a选项的学名应该叫做 archive option，中文叫做归档选项。使用-a选项，就表明你希望采取递归方式来
同步，且尽可能的保持各个方面的一致性。

但是-a选项也有阿克琉斯之踵，那就是-a无法同步“硬链接”情况。如果有这方面需求，要加上-H选项。
```

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

rsync+inotify实现文件双向同步 https://blog.csdn.net/liuwei0376/article/details/89155277

rsync 一个文件夹到另一台服务器，同步完成后刚好多 40kb，是怎么回事？ https://www.v2ex.com/t/665242

# 个人实战
