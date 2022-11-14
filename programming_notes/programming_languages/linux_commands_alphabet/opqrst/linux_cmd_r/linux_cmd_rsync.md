
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
  >>（时隔若干年后于 `2022.11.14`）补充：测试了下 Debian 9 也是一样的。也就是说：到底是把 src 整个目录复制进去 dst，还是把 src 目录里的内容复制进去 dst，
      单方面取决于是用 src 还是用 src/，与 dst 目录带不带斜杠无关！！！！！下面阮一峰的文章也展示了这点。
      此外，个人感觉可以这样记忆：
      - 如果没有斜杠，可以认为是把 src 当成了“一个整体的文件”，那么当然就是在 dst 里多这么“一个整体文件”，这个“文件”的名字叫 src；
      - 但是如果加了斜杠，也就是 src/，那就明显看出来源是一个目录，所以相当于是把源这个目录里的各种文件都复制到目标目录。
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

rsync 用法教程 https://www.ruanyifeng.com/blog/2020/08/rsync.html
- > **3.2 `-a` 参数**
  * > `-a` 参数可以替代 `-r`，除了可以递归同步以外，还可以同步元信息（比如修改时间、权限等）。由于 `rsync` 默认使用文件大小和修改时间决定文件是否需要更新，所以 `-a` 比 `-r` 更有用。下面的用法才是常见的写法。
    ```sh
    $ rsync -a source destination
    ```
  * > 目标目录 `destination` 如果不存在，`rsync` 会自动创建。执行上面的命令后，源目录 `source` 被完整地复制到了目标目录 `destination` 下面，即形成了 `destination/source` 的目录结构。
  * > 如果只想同步源目录 `source` 里面的内容到目标目录 `destination`，***则需要在<ins>源目录</ins>后面加上斜杠***。
    ```sh
    $ rsync -a source/ destination
    ```
  * > 上面命令执行后，`source` 目录里面的内容，就都被复制到了 `destination` 目录里面，并不会在 `destination` 下面创建一个 `source` 子目录。
- > **3.4 `--delete` 参数**
  * > 默认情况下，`rsync` 只确保源目录的所有内容（明确排除的文件除外）都复制到目标目录。它不会使两个目录保持相同，并且不会删除文件。如果要使得目标目录成为源目录的镜像副本，则必须使用 `--delete` 参数，这将删除只存在于目标目录、不存在于源目录的文件。
    ```sh
    $ rsync -av --delete source/ destination
    ```
  * > 上面命令中，`--delete` 参数会使得 `destination` 成为 `source` 的一个镜像。

Rsync（远程同步）：10 Linux中Rsync命令的实际示例 https://www.howtoing.com/rsync-local-remote-file-synchronization-commands/

rsync 一个超大文件夹“./attachments”过后，怎样检测两台服务器的这个“./attachments”文件夹一模一样 https://www.v2ex.com/t/593361
- > -c, --checksum skip based on checksum, not mod-time & size <br> 用 rsync -c

rsync+inotify实现文件双向同步 https://blog.csdn.net/liuwei0376/article/details/89155277

rsync 一个文件夹到另一台服务器，同步完成后刚好多 40kb，是怎么回事？ https://www.v2ex.com/t/665242

# 个人实战1：rsync + crontab 自动同步目录A的变更到目录B
>> //notes：一个典型的应用场景如下：有时候，代码仓库里的 Python 代码是通过 `setup.py` 之类的手段打包安装到机器的 Python `site-packages` 目录的。此时在项目里修改了还得再安装一下，比较麻烦。实际上可以直接手动 `cp` 过去替换就行。既然这样，那何不用 `rsync + 定时任务` 来自动同步呢。

## 参考链接

使用 rsync 保持两台计算机同步 https://docs.rockylinux.org/zh/guides/backup/rsync_ssh/
- > **rsync 参数和设置脚本¶**
  * > 在设置脚本之前，首先需要确定要与 `rsync` 一起使用的参数选项。有许多选项，详情参见 `rsync` 手册。`rsync` 最常用的选项是 `-a` 选项，因为 `-a` 或 archive 将多个选项组合为一个选项，而这些选项都是非常常见的选项。`-a` 包括什么？
    ```console
    -r, 递归目录
    -l, 将符号链接保持为符号链接
    -p, 保留权限
    -t, 保留修改时间
    -g, 保留 group-
    -o, 保留所有者
    -D, 保留设备文件
    ```
- > **自动化¶**
  * > 我们可能不希望每次想要同步时都手动运行此脚本，因此下一步是自动执行此操作。假设您想每天晚上 11 点运行此脚本。要使用 Rocky Linux 实现自动化，使用 `crontab`：

## 实战过程

```sh
$ cd crontabfiles/
# 这个是之前配置的自动启动 code-server 的定时任务。
$ crontab -l
* * * * * export PASSWORD="2022" && nohup code-server --host 0.0.0.0 --port 9999 > /dev/null 2 >&1 &
$ 
$ vi sync_python_lib.sh
$ cat sync_python_lib.sh
#!/bin/bash
rsync -a /home/<your_user_name>/prefix1/prefix2/....../pythonlib1/ /home/<your_user_name>/.local/lib/python3.7/site-packages/pythonlib1/
rsync -a /home/<your_user_name>/prefix1/prefix2/....../pythonlib2/ /home/<your_user_name>/.local/lib/python3.7/site-packages/pythonlib2/
$ chmod +x sync_python_lib.sh

# 此时按照过去在 code-server 那里的经验，应该是这么来：
$ vi sync_python_lib_crontab
$ cat sync_python_lib_crontab
*/2 * * * * /home/<your_user_name>/tmpfiles/crontabfiles/sync_python_lib.sh
$ crontab sync_python_lib_crontab
# 但是会发现直接替换了，而不是append的效果。。。所以还是用 crontab -e 来编辑吧。
$ crontab -l
*/2 * * * * /home/<your_user_name>/tmpfiles/crontabfiles/sync_python_lib.sh

# crontab 默认的编辑器是 nano，所以通过环境变量先改成 vim。
$ export EDITOR=vim
$ echo $EDITOR
vim
$ crontab -e
crontab: installing new crontab
$ crontab -l
* * * * * export PASSWORD="2018" && nohup code-server --host 0.0.0.0 --port 9999 > /dev/null 2 >&1 &
*/2 * * * * /home/<your_user_name>/tmpfiles/crontabfiles/sync_python_lib.sh
```
