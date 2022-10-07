
# `find . -mmin 1`

爹地，我找到了!, 15个极好的Linux find命令示例 https://www.oschina.net/translate/15-practical-unix-linux-find-command-examples-part-2
```console
test@cloudsec1 ~ $ touch 123
test@cloudsec1 ~ $ find . -mmin 1
.
./123

//一分钟过去后，但是两分钟不到
test@cloudsec1 ~ $ find . -mmin 1
test@cloudsec1 ~ $ find . -mmin 2
.
./123

//修改文件也能察觉到
test@cloudsec1 ~ $ echo asd > 123
test@cloudsec1 ~ $ find . -mmin 2
.
test@cloudsec1 ~ $ find . -mmin 1
./123
```
>> notes：这个`-mmin 1`不好的地方就在于，只能是1分钟以内，超过了就不行。也就是这个命令有时效性。可以通过增加条件来解决，回头再试试并总结。

# find后直接删除

Linux中如何正确删除：find-rm http://tiramisutes.github.io/2016/03/21/find-rm.html

```console
[root@c2-infra01 yum.repos.d]# ll
total 36
-rw-r--r--. 1 root root 1664 Nov 23  2018 CentOS-Base.repo
-rw-r--r--. 1 root root 1309 Nov 23  2018 CentOS-CR.repo
-rw-r--r--. 1 root root  649 Nov 23  2018 CentOS-Debuginfo.repo
-rw-r--r--. 1 root root  314 Nov 23  2018 CentOS-fasttrack.repo
-rw-r--r--. 1 root root  630 Nov 23  2018 CentOS-Media.repo
-rw-r--r--. 1 root root 1331 Nov 23  2018 CentOS-Sources.repo
-rw-r--r--. 1 root root 5701 Nov 23  2018 CentOS-Vault.repo
-rw-r--r--. 1 root root  195 Jun  7 00:50 local-repository-0.repo

// 这个小插曲是因为 Cent* 没有用引号引起来。但是有时候确实是不用引号的，懒得深究了，反正注意用引号不会错就行了。
[root@c2-infra01 yum.repos.d]# find . -name Cent*
find: paths must precede expression: CentOS-CR.repo
Usage: find [-H] [-L] [-P] [-Olevel] [-D help|tree|search|stat|rates|opt|exec] [path...] [expression]

[root@c2-infra01 yum.repos.d]# find . -name "Cent*"
./CentOS-Base.repo
./CentOS-CR.repo
./CentOS-Debuginfo.repo
./CentOS-Media.repo
./CentOS-Sources.repo
./CentOS-Vault.repo
./CentOS-fasttrack.repo

[root@c2-infra01 yum.repos.d]# find . -name "Cent*" | xargs rm
[root@c2-infra01 yum.repos.d]# ll
total 4
-rw-r--r--. 1 root root 195 Jun  7 00:50 local-repository-0.repo
----------------------------------------------------------------------------------------------------
// 也可以在目录外使用，比如该例子中要删除的都是 yum.repos.d/ 里的CentOS打头的yum仓库信息文件。
// 前面那个例子是进到 yum.repos.d/ 里进行的，但是完全可以在 yum.repos.d/ 之外进行。
[root@c2-infra02 etc]# find yum.repos.d/ -name "Cent*"
yum.repos.d/CentOS-Base.repo
yum.repos.d/CentOS-CR.repo
yum.repos.d/CentOS-Debuginfo.repo
yum.repos.d/CentOS-Media.repo
yum.repos.d/CentOS-Sources.repo
yum.repos.d/CentOS-Vault.repo
yum.repos.d/CentOS-fasttrack.repo
[root@c2-infra02 etc]# find yum.repos.d/ -name "Cent*" | xargs rm
[root@c2-infra02 etc]# cd yum.repos.d/
[root@c2-infra02 yum.repos.d]# ll
total 4
-rw-r--r--. 1 root root 195 Jun  7 00:50 local-repository-0.repo
----------------------------------------------------------------------------------------------------
[root@c2-infra03 etc]# ll yum.repos.d/
total 36
-rw-r--r--. 1 root root 1664 Nov 23  2018 CentOS-Base.repo
-rw-r--r--. 1 root root 1309 Nov 23  2018 CentOS-CR.repo
-rw-r--r--. 1 root root  649 Nov 23  2018 CentOS-Debuginfo.repo
-rw-r--r--. 1 root root  314 Nov 23  2018 CentOS-fasttrack.repo
-rw-r--r--. 1 root root  630 Nov 23  2018 CentOS-Media.repo
-rw-r--r--. 1 root root 1331 Nov 23  2018 CentOS-Sources.repo
-rw-r--r--. 1 root root 5701 Nov 23  2018 CentOS-Vault.repo
-rw-r--r--. 1 root root  195 Jun  7 00:50 local-repository-0.repo
[root@c2-infra03 etc]# find yum.repos.d/ -name "Cent*"
yum.repos.d/CentOS-Base.repo
yum.repos.d/CentOS-CR.repo
yum.repos.d/CentOS-Debuginfo.repo
yum.repos.d/CentOS-Media.repo
yum.repos.d/CentOS-Sources.repo
yum.repos.d/CentOS-Vault.repo
yum.repos.d/CentOS-fasttrack.repo
[root@c2-infra03 etc]# find yum.repos.d/ -name "Cent*" -exec rm {} \;
[root@c2-infra03 etc]# ll yum.repos.d/
total 4
-rw-r--r--. 1 root root 195 Jun  7 00:50 local-repository-0.repo
```

Linux下如何删除指定路径下所有的__pycache__文件夹？ https://cloud.tencent.com/developer/article/1732251
```sh
find . -name '__pycache__' -type d -exec rm -rf {} \;
```

# 通过 `find` 把某个目录及其子目录添加到 `PATH` 环境变量

How can I set all subdirectories of a directory into $PATH? https://unix.stackexchange.com/questions/17715/how-can-i-set-all-subdirectories-of-a-directory-into-path || 如何将目录的所有子目录设置为$ PATH？ https://qastack.cn/unix/17715/how-can-i-set-all-subdirectories-of-a-directory-into-path
