
# 1. 传统的手动复制公钥方法 --> 这个批处理（集中复制到一个authorized_keys文件，再分发）的方法已经是挺有条理了，但是还是不如用ssh-copy-id

linux双机互信设置 https://blog.csdn.net/seeyouc/article/details/53102280
```
1.在每个节点上创建 RSA密钥和公钥
使用test用户登陆
mkdir ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa
 
2.整合公钥文件
在node1上执行以下命令
ssh node1 cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ssh node2 cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ssh node3 cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
 
3.分发整合后的公钥文件
在node1上执行以下命令
scp ~/.ssh/authorized_keys node2:~/.ssh/
scp ~/.ssh/authorized_keys node3:~/.ssh/
 
4.测试ssh互信
在各个节点上运行以下命令，若不需要输入密码就显示系统当前日期，就说明SSH互信已经配置成功了。
ssh node1 date
ssh node2 date
ssh node3 date
```

***mynotes:***
- 其实原理都是**把自己的公钥写入到对方的`authorized_keys`文件**，只不过这个明显很快速。过去也不是太在意，总是手动一个机器一个机器拷，更慢且更容易出错。
- 此外，前两步创建`.ssh`目录和修改其权限为`700`（注意，那个`authorized_keys`文件的权限要求是`600`，并且不是`600`会报错。这个目录权限`700`不知道是不是必须的，先不管了。）的操作**其实可以在机器上自己`ssh 本机名/本机ip/localhost`登陆一下自己就好，让系统自动创建**，更不容易出错吧。此外，私钥`id_rsa`本身的权限也不能过高，`400`肯定是可以的，`600`不知道行不行，但`644`肯定不行（ https://stackoverflow.com/questions/29933918/ssh-key-permissions-0644-for-id-rsa-pub-are-too-open-on-mac/29948797 ）。


# 2. 利用ssh-copy-id --> 避免手动复制粘贴出错

- ssh-keygen AND ssh-copy-id用法 https://blog.csdn.net/wos1002/article/details/56483277
```
ssh-copy-id [-i [identity_file]] [user@]machine

-i：指定公钥文件

例子
1、把本地的ssh公钥文件安装到远程主机对应的账户下：
ssh-copy-id user@server 
ssh-copy-id -i ~/.ssh/id_rsa.pub user@server
```
> mynotes: 从这里可以看出，`user@`部分也是可以省略的。所以最简单的方式就是进到这台机器的`.ssh`目录里，生成好公私钥，然后直接`ssh-copy-id ${hostname_of_this_machine}`即可。

- 使用ssh-keygen和ssh-copy-id三步实现SSH无密码登录 和ssh常用命令 https://blog.csdn.net/alifrank/article/details/48241699 
```
常见问题：
ssh-copy-id -u eucalyptus -i ~eucalyptus/.ssh/id_rsa.pub ssh 用户名字@192.168.x.xxx
1.第一次需要密码登录
2.上述是给eucalyptus用户赋予无密码登陆的权利
```
> mynotes: 这里是用`-u`指定用户名。（猜测不指定的话用的是当前用户或者密钥对应的用户？）

- ssh-copy-id 的使用方法 https://blog.csdn.net/qianggezhishen/article/details/71249699
```
补充：经网友提示，如果端口不是22，不修改config文件，按如下方式也可以：

ssh-copy-id -i ~/.ssh/id_rsa.pub "-p 10022 user@server"
```
> mynotes: `-p`指定不同的端口。


# 3. ssh首次登陆要添加know_hosts时直接通过，不弹出提示

- 如何让ssh的时候不提示添加host key | 如何加快ssh登录的速度 https://www.cnblogs.com/super119/archive/2010/12/18/1909817.html
- ssh登陆之忽略known_hosts文件 https://blog.csdn.net/yasaken/article/details/7348441
- How to disable strict host key checking in ssh? https://askubuntu.com/questions/87449/how-to-disable-strict-host-key-checking-in-ssh

***mynotes:***
- 最基本的办法是在ssh的config文件（`~/.ssh/config`或者`/etc/ssh/ssh_config`）里把`StrictHostKeyChecking`从`ask`变为`no`。
- 但是只改成`StrictHostKeyChecking no`可能在少数情况下还会有些小问题：比如当主机的ip变化的时候，可能会出现警告，并且可能要手动改`known_hosts`的内容（关于这点我没有自己去试，但是应该不假，因为CSDN的那个帖子里也提到了）。所以最好在ssh的config文件里再加上`UserKnownHostsFile /dev/null`。详情参见askubuntu那个帖子，很详细。比前两个加起来内容都多。但是那两个中文的链接方便快速回忆。
- 也可以使用`ssh -o StrictHostKeyChecking=no yourHardenedHost.com`，从而不改配置文件，但是没试过。

# 4. pssh使用

***mynotes:***
- 在尝试pssh时碰到了一个问题。使用一个基本命令在三台机器上同时打印时间（`pssh -h hostpssh -P date`），发现主控机执行失败，两台被控机器执行成功。整个过程记录在了V2EX的帖子了，这里先放一下链接：
  * 请教一个 pssh 的问题：pssh 执行一个命令的时候，能否包括控制机本身 https://www.v2ex.com/t/563378
- 造成这个问题的根本原因是：**我的pssh用的host列表文件`hostpssh`里是用"`用户名@ip地址`"的形式记录需要执行命令的机器的。但是我建互信的时候是用hostname在这些机器之间建立互信的（这些可以参见问题描述部分）**。如果主机名和ip是一一对应的就没问题了，但是我们单位的机器有两套IP，9开头的对外，10开头的对内。**主控机用hostname向其自身建立互信的时候默认用了对内的10开头的IP；向被控机器用hostname建互信时用的是对外的9开头的IP**。所以，归根结底，**还是因为互信没建好才会导致这个错误的出现**。
  
## 4.1 （V2EX那个帖子）问题描述

> 我有三台机器，分别为`druidcluster1`, `druidcluster2`, `druidcluster4`，对应 ip 分别为`9.116.2.59`, `9.116.2.70`, `9.116.2.254`。其中第一台装了 pssh，拿来当控制机（不知道这个术语准确不- -）。ssh 互信全都见好了，包括机器和自身的互信：
```
[root@druidcluster1 generalsoftware]# ssh druidcluster1 date
Sun May 12 02:02:49 CDT 2019
[root@druidcluster1 generalsoftware]# ssh druidcluster2 date
Sun May 12 02:02:55 CDT 2019
[root@druidcluster1 generalsoftware]# ssh druidcluster4 date
Sun May 12 02:03:01 CDT 2019

[root@druidcluster2 .ssh]# ssh druidcluster2 date
Sun May 12 02:02:19 CDT 2019
[root@druidcluster2 .ssh]# ssh druidcluster1 date
Sun May 12 02:02:25 CDT 2019
[root@druidcluster2 .ssh]# ssh druidcluster4 date
Sun May 12 02:02:31 CDT 2019

[root@druidcluster4 .ssh]# ssh druidcluster4 date
Sun May 12 02:02:01 CDT 2019
[root@druidcluster4 .ssh]# ssh druidcluster1 date
Sun May 12 02:02:08 CDT 2019
[root@druidcluster4 .ssh]# ssh druidcluster2 date
Sun May 12 02:02:14 CDT 2019
```

> 新建一个记录需要并行执行命令的 host 文件的列表`hostpssh`，内容如下：
```
root@9.116.2.59
root@9.116.2.70
root@9.116.2.254
```

> 在控制机（也就是`druidcluster1`）上执行`pssh -h hostpssh -P date`，期待的结果是三个全成功返回日期的，实际是控制机失败，其他成功。
```
[root@druidcluster1 generalsoftware]# pssh -h hostpssh -P date
[1] 01:33:34 [FAILURE] root@9.116.2.59 Exited with error code 255
9.116.2.254: Sun May 12 01:33:37 CDT 2019
[2] 01:33:37 [SUCCESS] root@9.116.2.254
9.116.2.70: Sun May 12 01:33:37 CDT 2019
[3] 01:33:37 [SUCCESS] root@9.116.2.70
```

## 4.2 解决过程

> knktc: "pssh 本身就是在用 python 调用 ssh 命令。你试试直接 ssh root@9.116.2.59 ,不用 hostname，看看有什么效果"
>> 我："@knktc 尝试直接 ssh root@9.116.2.59 ，发现竟然提示认证问题（类似首次连接时候的认证）。同意之后，再次执行，发现解决了～所以看是还是互信的问题？但是我之前互信确实建好了啊。感谢～总之是解决了。过程如下："
```
[root@druidcluster1 ~]# ssh root@9.116.2.59 date
The authenticity of host '9.116.2.59 (9.116.2.59)' can't be established.
ECDSA key fingerprint is SHA256:V9315377iDHed0ETyHal4dBTUUJ4WopShNjXIW/5giw.
ECDSA key fingerprint is MD5:aa:cc:8d:c5:a4:c1:3c:9b:78:f6:75:e2:48:b5:81:e7.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '9.116.2.59' (ECDSA) to the list of known hosts.
Sun May 12 07:13:27 CDT 2019
[root@druidcluster1 ~]#
[root@druidcluster1 ~]# ssh root@9.116.2.59 date
Sun May 12 07:13:33 CDT 2019
[root@druidcluster1 ~]#
[root@druidcluster1 ~]# pssh -h ~/generalsoftware/hostpssh -P date
9.116.2.59: Sun May 12 07:13:45 CDT 2019
[1] 07:13:45 [SUCCESS] root@9.116.2.59
9.116.2.254: Sun May 12 07:13:47 CDT 2019
[2] 07:13:47 [SUCCESS] root@9.116.2.254
9.116.2.70: Sun May 12 07:13:47 CDT 2019
[3] 07:13:47 [SUCCESS] root@9.116.2.70
```

> 又仔细看了看，算是彻底弄明白了原因。这边的机器有两套IP，一套对内一套对外。开始使用hostname建立互信的时候，对于控制机本身，在`known_hosts`文件里添加的是对内的那个IP。

> 在下图中可以看到，最开始使用`druidcluster1`这个hostname去建互信的时候，系统（对本机）默认选用了对内的那个IP地址`10.129.203.59`（对`druidcluster2`和`druidcluster4`还是用9开头的外部IP地址）。最后那个`9.116.2.59`是我自己（用`ssh root@IP`的形式）**又连了控制机一次以后，添加上了**。至此，pssh命令就可以对本机执行了。

```
[root@druidcluster1 ~]# cat ~/.ssh/known_hosts
druidcluster1,10.129.203.59 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzd密钥后面部分省略
druidcluster2,9.116.2.70 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGRzuV9cxRVOkDESx3fhMj8pXHa4密钥后面部分省略
druidcluster3 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBCN7iIherrtnj5b+Ru3zMwicJtjjQc+密钥后面部分省略
druidcluster4,9.116.2.254 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBBBa2oNjufGaFk6qcmlkcAI/7pq7Kf密钥后面部分省略
9.116.2.59 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBCN7iIherrtnj5b+Ru3zMwicJtjjQc+密钥后面部分省略
```

## 4.3 最后补充

> 最后复盘（这部分内容不在V2EX帖子里）：就是主控机和被控机对hostname解析的IP不一样————或者更准确的说法应该是，如果机器和其自身（用hostname方式）建互信，会用10开头的内部IP；如果和其他机器（用hostname方式）建互信，会用9开头的外部IP。
```
//在控制机（druidcluster1）上执行下面这两条命令会发现：
//1.控制机“解析”自己的时候，是优先用10开头的IP来“解析”本机（druidcluster1）的hostname的。
//  ————所以其实可以在最开始的时候在这里（`/etc/hosts`）把10开头的IP直接改成9开头的IP（10.129.203.59 --> 9.116.2.59），也就解决了。
//  ————同理，其实也可以只把前面`hostpssh`文件里的第一行改成10开头的IP（root@9.116.2.59 --> root@10.129.203.59）
//      或者干脆用`root@druidcluster1`这种形式，应该也就不会出现这个问题了。
//2.但是在“解析”被控制机的时候，是优先（还是只能？）用9开头的IP。比如druidcluster2被“解析”成9.116.2.70

[root@druidcluster1 ~]# cat /etc/hosts
127.0.0.1 localhost.localdomain localhost
10.129.203.59 druidcluster1.sl.cloud9.ibm.com druidcluster1
[root@druidcluster1 ~]#
[root@druidcluster1 ~]# getent hosts druidcluster2
9.116.2.70      druidcluster2.sl.cloud9.ibm.com
```

## 4.4 pssh安装。。。

- ~~首先，不要和另外一个同名的python ssh库项目（[parallel-ssh - Asynchronous parallel SSH client library.](https://github.com/ParallelSSH/parallel-ssh)）混淆了 --> 虽说这个项目看起来也基本凉了，但总比pssh最新版本是12年发布的要好些。。。 --> 此外，这个网站（ https://parallel-ssh.org/ ）也是那个python ssh库的~~。
- pssh之前的地址（ http://parallel-ssh.googlecode.com/ ）已经失效了，新地址在这里：
  * parallel-ssh https://code.google.com/archive/p/parallel-ssh/downloads

```
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/parallel-ssh/pssh-2.3.1.tar.gz
tar xvf pssh-2.3.1.tar.gz
cd pssh-2.3.1/

[root@druidcluster1 pssh-2.3.1]# python setup.py install
running install
running build
running build_py
creating build
creating build/lib
creating build/lib/psshlib
copying psshlib/cli.py -> build/lib/psshlib
copying psshlib/__init__.py -> build/lib/psshlib
copying psshlib/askpass_server.py -> build/lib/psshlib
copying psshlib/askpass_client.py -> build/lib/psshlib
copying psshlib/color.py -> build/lib/psshlib
copying psshlib/task.py -> build/lib/psshlib
copying psshlib/version.py -> build/lib/psshlib
copying psshlib/manager.py -> build/lib/psshlib
copying psshlib/psshutil.py -> build/lib/psshlib
running build_scripts
creating build/scripts-2.7
copying and adjusting bin/pssh -> build/scripts-2.7
copying and adjusting bin/pnuke -> build/scripts-2.7
copying and adjusting bin/prsync -> build/scripts-2.7
copying and adjusting bin/pslurp -> build/scripts-2.7
copying and adjusting bin/pscp -> build/scripts-2.7
copying and adjusting bin/pssh-askpass -> build/scripts-2.7
changing mode of build/scripts-2.7/pssh from 644 to 755
changing mode of build/scripts-2.7/pnuke from 644 to 755
changing mode of build/scripts-2.7/prsync from 644 to 755
changing mode of build/scripts-2.7/pslurp from 644 to 755
changing mode of build/scripts-2.7/pscp from 644 to 755
changing mode of build/scripts-2.7/pssh-askpass from 644 to 755
running install_lib
creating /usr/lib/python2.7/site-packages/psshlib
copying build/lib/psshlib/cli.py -> /usr/lib/python2.7/site-packages/psshlib
copying build/lib/psshlib/__init__.py -> /usr/lib/python2.7/site-packages/psshlib
copying build/lib/psshlib/askpass_server.py -> /usr/lib/python2.7/site-packages/psshlib
copying build/lib/psshlib/askpass_client.py -> /usr/lib/python2.7/site-packages/psshlib
copying build/lib/psshlib/color.py -> /usr/lib/python2.7/site-packages/psshlib
copying build/lib/psshlib/task.py -> /usr/lib/python2.7/site-packages/psshlib
copying build/lib/psshlib/version.py -> /usr/lib/python2.7/site-packages/psshlib
copying build/lib/psshlib/manager.py -> /usr/lib/python2.7/site-packages/psshlib
copying build/lib/psshlib/psshutil.py -> /usr/lib/python2.7/site-packages/psshlib
byte-compiling /usr/lib/python2.7/site-packages/psshlib/cli.py to cli.pyc
byte-compiling /usr/lib/python2.7/site-packages/psshlib/__init__.py to __init__.pyc
byte-compiling /usr/lib/python2.7/site-packages/psshlib/askpass_server.py to askpass_server.pyc
byte-compiling /usr/lib/python2.7/site-packages/psshlib/askpass_client.py to askpass_client.pyc
byte-compiling /usr/lib/python2.7/site-packages/psshlib/color.py to color.pyc
byte-compiling /usr/lib/python2.7/site-packages/psshlib/task.py to task.pyc
byte-compiling /usr/lib/python2.7/site-packages/psshlib/version.py to version.pyc
byte-compiling /usr/lib/python2.7/site-packages/psshlib/manager.py to manager.pyc
byte-compiling /usr/lib/python2.7/site-packages/psshlib/psshutil.py to psshutil.pyc
running install_scripts
copying build/scripts-2.7/pslurp -> /usr/bin
copying build/scripts-2.7/pscp -> /usr/bin
copying build/scripts-2.7/pssh-askpass -> /usr/bin
copying build/scripts-2.7/pnuke -> /usr/bin
copying build/scripts-2.7/prsync -> /usr/bin
copying build/scripts-2.7/pssh -> /usr/bin
changing mode of /usr/bin/pslurp to 755
changing mode of /usr/bin/pscp to 755
changing mode of /usr/bin/pssh-askpass to 755
changing mode of /usr/bin/pnuke to 755
changing mode of /usr/bin/prsync to 755
changing mode of /usr/bin/pssh to 755
running install_data
creating /usr/man
creating /usr/man/man1
copying man/man1/pssh.1 -> /usr/man/man1
copying man/man1/pscp.1 -> /usr/man/man1
copying man/man1/prsync.1 -> /usr/man/man1
copying man/man1/pslurp.1 -> /usr/man/man1
copying man/man1/pnuke.1 -> /usr/man/man1
running install_egg_info
Writing /usr/lib/python2.7/site-packages/pssh-2.3.1-py2.7.egg-info
```

# 5. ssh-keyscan命令实战过程

## 5.1 如何发现这个命令

安装Ansile https://getansible.com/begin/an_zhuang_ansile
```
$ # 生成ssh key
$ ssh-keygen
$ # 拷贝ssh key到远程主机，ssh的时候就不需要输入密码了
$ ssh-copy-id remoteuser@remoteserver
$ # ssh的时候不会提示是否保存key
$ ssh-keyscan remote_servers >> ~/.ssh/known_hosts
```
>> notes: 从这里发现了`ssh-keyscan`这个命令，还没用过，回来研究下。

## 5.2 主要参考下面这篇

利用 ssh-keyscan 获取集群机器 SSH 公钥指纹 https://liam.page/2018/01/24/ssh-keyscan/
```
首先应准备好需要获取公钥指纹的 IP 或 HOSTNAME 列表，保存在文件中。例如演示用的文件是这样的。
hostlist.txt
  127.0.0.1
  127.0.0.2


而后执行命令
$ ssh-keyscan -f hostlist.txt
# 127.0.0.1 SSH-2.0-OpenSSH_6.6.1
127.0.0.1 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCWBZ3XrIajPmnd6R+g/wcUuOPOiRBMOYjAl4Dv8SfcZtgHqKTK6Zb1EeG3u/uzRYxqXMctG/2A4iXRDG9mvg9H9bimCWbA3xtR79NImPYg4m7BNuH9C+OXRYYJwoOGpjVMs0rGLXkq3/WVkXvQreBuhVD8NI2pEPnQsT1J5abdVbCHlwFYG6wVCJQqFY6jdntJJlxQv5EJu6w4/+Fd4LvdjysH+ngqArac6HMJUxqSxLQjzMdCRWEQKp3ySwmnRp9rHYVaJnnsXeYPfnMN1iMjdIQJPzc89Mepg4ip1q2bCMbMcx2XFO3I7YjYRdcOameFNafMGY0q5RHzhvgnNnal
# 127.0.0.1 SSH-2.0-OpenSSH_6.6.1
127.0.0.1 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBCPWoEQ7iCCYDrpyb5KeMmCaQ8aOnSfehqmrplZRkbqqnkS9++PdSX/eSLJ0tkFd5902/C+HTCqbDgso4mCKpMo=
# 127.0.0.2 SSH-2.0-OpenSSH_6.6.1
127.0.0.2 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCWBZ3XrIajPmnd6R+g/wcUuOPOiRBMOYjAl4Dv8SfcZtgHqKTK6Zb1EeG3u/uzRYxqXMctG/2A4iXRDG9mvg9H9bimCWbA3xtR79NImPYg4m7BNuH9C+OXRYYJwoOGpjVMs0rGLXkq3/WVkXvQreBuhVD8NI2pEPnQsT1J5abdVbCHlwFYG6wVCJQqFY6jdntJJlxQv5EJu6w4/+Fd4LvdjysH+ngqArac6HMJUxqSxLQjzMdCRWEQKp3ySwmnRp9rHYVaJnnsXeYPfnMN1iMjdIQJPzc89Mepg4ip1q2bCMbMcx2XFO3I7YjYRdcOameFNafMGY0q5RHzhvgnNnal
# 127.0.0.2 SSH-2.0-OpenSSH_6.6.1
127.0.0.2 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBCPWoEQ7iCCYDrpyb5KeMmCaQ8aOnSfehqmrplZRkbqqnkS9++PdSX/eSLJ0tkFd5902/C+HTCqbDgso4mCKpMo=


如此，将标准错误的输出重定向到 /dev/null 即可获得机器列表的公钥指纹了。
$ ssh-keyscan -f hostlist.txt 1>>~/.ssh/known_hosts 2>/dev/null
而后将 ~/.ssh/known_hosts 用 scp 拷贝到 hostlist.txt 中的所有机器上即可。
```

## 5.3 个人实战过程

```
//关于待解析主机列表文件的两个关键点：
//1.hostpssh2文件里每一行的内容不能带用户名。最开始用的是`root@9.116.2.59`之类的写法，直接报错。
[root@druidcluster1 generalsoftware]# cat hostpssh2
9.116.2.59
9.116.2.70
9.116.2.254
[root@druidcluster1 generalsoftware]# ssh-keyscan -f hostpssh2
# 9.116.2.70:22 SSH-2.0-OpenSSH_7.4
9.116.2.70 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbu9lu5zheztbL2c+8dNJIJOi2Q9JpMqGl4zHB6Cvc9wk/Tv1vu4SEk+wuCn/feOHLm9xQw7mg8O1Ysk7xDM83eUuZrZTwbNkkCBvV6KN+P/gdFD5sKt19MafOilQ1OA7nXu23IsiTDLAffdaVoO5z31I0oTLGw4ytI6XMmQ5ZyWq4CsaUZ7v5ijxHr1KcyknGWNhMUlXwNkB8mCOMYSPVS6L3pBR4lRX7As8ac4FqGdRybDRvO+NwxhUGXNRmunD+9CAFl9nnTLPO3bUDsA6RSH1OOjZDhsUGbTu07OqAPDUDkEAOF7wo4mwsKhBour3BKn2PlmuEdxqjaBC3he0/
# 9.116.2.70:22 SSH-2.0-OpenSSH_7.4
9.116.2.70 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGRzuV9cxRVOkDESx3fhMj8pXHa4yDRIheVrso6rqDMDkyEvabYhyYHqSfuHs7y5IaWxbomTmuH4KtnhI+MZSDo=
# 9.116.2.70:22 SSH-2.0-OpenSSH_7.4
9.116.2.70 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLr0ywIe7YEpcT9+xs3ud4EnPGsQUu/RRTw3/zVaYVx
# 9.116.2.59:22 SSH-2.0-OpenSSH_7.4
9.116.2.59 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhvCewtZ1xhWUB347oZ34QCpbLaco2NhSvGHfwVprAWVJEK02WJCwLgxiypxhHSb2Z/FurU7nE5kyt4GEsQQFd6zsv83bPOyJO62poFsrCPLAn1jJTekxih9663YRfMDD4OFtNZ3pCP87gdHzdS3IOoJ4j1xHNnt0AhYaeUMPDCHJEMfPfwTjMEJiSiNKICdS57mPsH9ZalWAZFd968N8tNW0WjBpUWKH3sl7m3gvi7iNFdK+44xfr1ER6x1fJGxnH+AJpEGe10G23k3ZRzxhjgPtIsJhxEHd8FwGGQY+ZMb2AbDxsln8u3I0UZMpw7RqJyzP9g5jWa2IUlhCnulN/
# 9.116.2.59:22 SSH-2.0-OpenSSH_7.4
9.116.2.59 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBCN7iIherrtnj5b+Ru3zMwicJtjjQc+N+aYHtzyq6qcQmvfowh0mLuAt78/f7QS6OvvFo7tBliHleFPqQYDAkSY=
# 9.116.2.59:22 SSH-2.0-OpenSSH_7.4
9.116.2.59 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEcbVvh0ZwNHVGBdxjc98JSnnkWdjnZmfpKwHPtYS6uK
# 9.116.2.254:22 SSH-2.0-OpenSSH_7.4
9.116.2.254 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZWxkYVHytUu0rGIDlrp9kADgI0z/xIn7/u/zxCt3SFO0T7Neg3vtOG70YdDowa1pRNUktH7zetFKT6r/rFFSVCe2JyvvepJx74gOFGoOiQ/0wgAznVMLMsXJ4BaOWciXGOMrrEnGC2NLC/KXb6cB76Rn5ki3iVqqsIi46trvYZOm5XYIjx5KrrW67Mun4nGKyE3/W4gyUaHHZuvi15CowVMi+sNue7hjVFIU3f6ah2A8JseTy7+EiWiSN4BAiSE3PCkSYDT8hEJjEyG7pB1nkAdTd9+qJfS/5wCDKz+qACzWa/g8o69WByFLIJHMZ2ffeTGtqFaQ5IT4BsddGBXq9
# 9.116.2.254:22 SSH-2.0-OpenSSH_7.4
9.116.2.254 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBBBa2oNjufGaFk6qcmlkcAI/7pq7KfA0gJ3BjMRbxQ30MXLGiuAuHj7tyFe1J7bKAt9qvPgI0V0uIFVsuVUSD6o=
# 9.116.2.254:22 SSH-2.0-OpenSSH_7.4
9.116.2.254 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFNSKuD1/jzIAsbTAgIYckle6OSbo/xS8bBIfaizaSgO

//2.里面的IP也可以直接用主机名，解析出来的结果全是主机名开头的。
[root@druidcluster1 generalsoftware]# cat hostpssh3
druidcluster1
druidcluster2
druidcluster4
[root@druidcluster1 generalsoftware]# ssh-keyscan -f hostpssh3
# druidcluster1:22 SSH-2.0-OpenSSH_7.4
druidcluster1 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhvCewtZ1xhWUB347oZ34QCpbLaco2NhSvGHfwVprAWVJEK02WJCwLgxiypxhHSb2Z/FurU7nE5kyt4GEsQQFd6zsv83bPOyJO62poFsrCPLAn1jJTekxih9663YRfMDD4OFtNZ3pCP87gdHzdS3IOoJ4j1xHNnt0AhYaeUMPDCHJEMfPfwTjMEJiSiNKICdS57mPsH9ZalWAZFd968N8tNW0WjBpUWKH3sl7m3gvi7iNFdK+44xfr1ER6x1fJGxnH+AJpEGe10G23k3ZRzxhjgPtIsJhxEHd8FwGGQY+ZMb2AbDxsln8u3I0UZMpw7RqJyzP9g5jWa2IUlhCnulN/
# druidcluster1:22 SSH-2.0-OpenSSH_7.4
druidcluster1 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBCN7iIherrtnj5b+Ru3zMwicJtjjQc+N+aYHtzyq6qcQmvfowh0mLuAt78/f7QS6OvvFo7tBliHleFPqQYDAkSY=
# druidcluster1:22 SSH-2.0-OpenSSH_7.4
druidcluster1 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEcbVvh0ZwNHVGBdxjc98JSnnkWdjnZmfpKwHPtYS6uK
# druidcluster2:22 SSH-2.0-OpenSSH_7.4
druidcluster2 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbu9lu5zheztbL2c+8dNJIJOi2Q9JpMqGl4zHB6Cvc9wk/Tv1vu4SEk+wuCn/feOHLm9xQw7mg8O1Ysk7xDM83eUuZrZTwbNkkCBvV6KN+P/gdFD5sKt19MafOilQ1OA7nXu23IsiTDLAffdaVoO5z31I0oTLGw4ytI6XMmQ5ZyWq4CsaUZ7v5ijxHr1KcyknGWNhMUlXwNkB8mCOMYSPVS6L3pBR4lRX7As8ac4FqGdRybDRvO+NwxhUGXNRmunD+9CAFl9nnTLPO3bUDsA6RSH1OOjZDhsUGbTu07OqAPDUDkEAOF7wo4mwsKhBour3BKn2PlmuEdxqjaBC3he0/
# druidcluster2:22 SSH-2.0-OpenSSH_7.4
druidcluster2 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGRzuV9cxRVOkDESx3fhMj8pXHa4yDRIheVrso6rqDMDkyEvabYhyYHqSfuHs7y5IaWxbomTmuH4KtnhI+MZSDo=
# druidcluster2:22 SSH-2.0-OpenSSH_7.4
druidcluster2 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLr0ywIe7YEpcT9+xs3ud4EnPGsQUu/RRTw3/zVaYVx
# druidcluster4:22 SSH-2.0-OpenSSH_7.4
druidcluster4 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZWxkYVHytUu0rGIDlrp9kADgI0z/xIn7/u/zxCt3SFO0T7Neg3vtOG70YdDowa1pRNUktH7zetFKT6r/rFFSVCe2JyvvepJx74gOFGoOiQ/0wgAznVMLMsXJ4BaOWciXGOMrrEnGC2NLC/KXb6cB76Rn5ki3iVqqsIi46trvYZOm5XYIjx5KrrW67Mun4nGKyE3/W4gyUaHHZuvi15CowVMi+sNue7hjVFIU3f6ah2A8JseTy7+EiWiSN4BAiSE3PCkSYDT8hEJjEyG7pB1nkAdTd9+qJfS/5wCDKz+qACzWa/g8o69WByFLIJHMZ2ffeTGtqFaQ5IT4BsddGBXq9
# druidcluster4:22 SSH-2.0-OpenSSH_7.4
druidcluster4 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBBBa2oNjufGaFk6qcmlkcAI/7pq7KfA0gJ3BjMRbxQ30MXLGiuAuHj7tyFe1J7bKAt9qvPgI0V0uIFVsuVUSD6o=
# druidcluster4:22 SSH-2.0-OpenSSH_7.4
druidcluster4 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFNSKuD1/jzIAsbTAgIYckle6OSbo/xS8bBIfaizaSgO


//此时看结果会发现有个问题，输出的结果都是`#开头，然后换一行才是内容的形式`，比较不方便。我们仍然使用上面帖子里的命令，
//  但只是为了测试下所谓的“标准错误的输出重定向到 /dev/null”到底起了什么作用。
[root@druidcluster1 generalsoftware]# ssh-keyscan -f hostpssh2 1>>~/result 2>~/err
[root@druidcluster1 generalsoftware]# cat ~/result
9.116.2.254 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFNSKuD1/jzIAsbTAgIYckle6OSbo/xS8bBIfaizaSgO
9.116.2.59 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhvCewtZ1xhWUB347oZ34QCpbLaco2NhSvGHfwVprAWVJEK02WJCwLgxiypxhHSb2Z/FurU7nE5kyt4GEsQQFd6zsv83bPOyJO62poFsrCPLAn1jJTekxih9663YRfMDD4OFtNZ3pCP87gdHzdS3IOoJ4j1xHNnt0AhYaeUMPDCHJEMfPfwTjMEJiSiNKICdS57mPsH9ZalWAZFd968N8tNW0WjBpUWKH3sl7m3gvi7iNFdK+44xfr1ER6x1fJGxnH+AJpEGe10G23k3ZRzxhjgPtIsJhxEHd8FwGGQY+ZMb2AbDxsln8u3I0UZMpw7RqJyzP9g5jWa2IUlhCnulN/
9.116.2.59 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBCN7iIherrtnj5b+Ru3zMwicJtjjQc+N+aYHtzyq6qcQmvfowh0mLuAt78/f7QS6OvvFo7tBliHleFPqQYDAkSY=
9.116.2.59 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEcbVvh0ZwNHVGBdxjc98JSnnkWdjnZmfpKwHPtYS6uK
9.116.2.70 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbu9lu5zheztbL2c+8dNJIJOi2Q9JpMqGl4zHB6Cvc9wk/Tv1vu4SEk+wuCn/feOHLm9xQw7mg8O1Ysk7xDM83eUuZrZTwbNkkCBvV6KN+P/gdFD5sKt19MafOilQ1OA7nXu23IsiTDLAffdaVoO5z31I0oTLGw4ytI6XMmQ5ZyWq4CsaUZ7v5ijxHr1KcyknGWNhMUlXwNkB8mCOMYSPVS6L3pBR4lRX7As8ac4FqGdRybDRvO+NwxhUGXNRmunD+9CAFl9nnTLPO3bUDsA6RSH1OOjZDhsUGbTu07OqAPDUDkEAOF7wo4mwsKhBour3BKn2PlmuEdxqjaBC3he0/
9.116.2.70 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGRzuV9cxRVOkDESx3fhMj8pXHa4yDRIheVrso6rqDMDkyEvabYhyYHqSfuHs7y5IaWxbomTmuH4KtnhI+MZSDo=
9.116.2.70 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLr0ywIe7YEpcT9+xs3ud4EnPGsQUu/RRTw3/zVaYVx
9.116.2.254 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZWxkYVHytUu0rGIDlrp9kADgI0z/xIn7/u/zxCt3SFO0T7Neg3vtOG70YdDowa1pRNUktH7zetFKT6r/rFFSVCe2JyvvepJx74gOFGoOiQ/0wgAznVMLMsXJ4BaOWciXGOMrrEnGC2NLC/KXb6cB76Rn5ki3iVqqsIi46trvYZOm5XYIjx5KrrW67Mun4nGKyE3/W4gyUaHHZuvi15CowVMi+sNue7hjVFIU3f6ah2A8JseTy7+EiWiSN4BAiSE3PCkSYDT8hEJjEyG7pB1nkAdTd9+qJfS/5wCDKz+qACzWa/g8o69WByFLIJHMZ2ffeTGtqFaQ5IT4BsddGBXq9
9.116.2.254 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBBBa2oNjufGaFk6qcmlkcAI/7pq7KfA0gJ3BjMRbxQ30MXLGiuAuHj7tyFe1J7bKAt9qvPgI0V0uIFVsuVUSD6o=
[root@druidcluster1 generalsoftware]# cat ~/err
# 9.116.2.254:22 SSH-2.0-OpenSSH_7.4
# 9.116.2.59:22 SSH-2.0-OpenSSH_7.4
# 9.116.2.59:22 SSH-2.0-OpenSSH_7.4
# 9.116.2.59:22 SSH-2.0-OpenSSH_7.4
# 9.116.2.70:22 SSH-2.0-OpenSSH_7.4
# 9.116.2.70:22 SSH-2.0-OpenSSH_7.4
# 9.116.2.70:22 SSH-2.0-OpenSSH_7.4
# 9.116.2.254:22 SSH-2.0-OpenSSH_7.4
# 9.116.2.254:22 SSH-2.0-OpenSSH_7.4

//从上面结果不难看出，其实就是把输出结果做了分离，所以~/result文件直接就可以当known_hosts文件用了。
```

# 6. ssh端口转发 / ssh隧道

SSH 教程 https://github.com/wangdoc/ssh-tutorial || https://wangdoc.com/ssh/
- SSH 端口转发 https://github.com/wangdoc/ssh-tutorial/blob/main/docs/port-forwarding.md

SSH/OpenSSH/PortForwarding https://help.ubuntu.com/community/SSH/OpenSSH/PortForwarding

SSH Port Forwarding Example https://www.ssh.com/ssh/tunneling/example

SSH tunnel https://www.ssh.com/ssh/tunneling/

SSH 的三板斧 https://wgzhao.github.io/notes/tips/ssh-three-key-features/

SSH examples, tips and tunnels https://wgzhao.github.io/notes/tips/ssh-tips/

# 7. ssh连接复用（or 长连接）

ssh复用连接配置 https://github.com/int32bit/dotfiles/blob/master/ssh/README.md

# 8. 防止ssh自动断开

保持ssh服务连接不断开的方法 https://ngwind.github.io/2019/01/25/%E4%BF%9D%E6%8C%81ssh%E6%9C%8D%E5%8A%A1%E8%BF%9E%E6%8E%A5%E4%B8%8D%E6%96%AD%E5%BC%80%E7%9A%84%E6%96%B9%E6%B3%95/
>> //notes：还是 `ssh -o ServerAliveInterval=60 ${USER}@${HOST}` 最好用。

SSH 保持连接不断开 https://www.jianshu.com/p/a84a6abf76c9
