
# 传统的手动复制公钥方法 --> 这个批处理（集中复制到一个authorized_keys文件，再分发）的方法已经是挺有条理了，但是还是不如用ssh-copy-id

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
- 此外，前两步创建`.ssh`目录和修改其权限为`700`（注意，那个`authorized_keys`文件的权限要求是`600`，并且不是`600`会报错。这个目录权限`700`不知道是不是必须的，先不管了。）的操作**其实可以在机器上自己`ssh 本机名/本机ip/localhost`登陆一下自己就好，让系统自动创建**，更不容易出错吧。


# 利用ssh-copy-id --> 避免手动复制粘贴出错

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


# ssh首次登陆要添加know_hosts时直接通过，不弹出提示

- 如何让ssh的时候不提示添加host key | 如何加快ssh登录的速度 https://www.cnblogs.com/super119/archive/2010/12/18/1909817.html
- ssh登陆之忽略known_hosts文件 https://blog.csdn.net/yasaken/article/details/7348441
- How to disable strict host key checking in ssh? https://askubuntu.com/questions/87449/how-to-disable-strict-host-key-checking-in-ssh

***mynotes:***
- 最基本的办法是在ssh的config文件（`~/.ssh/config`或者`/etc/ssh/ssh_config`）里把`StrictHostKeyChecking`从`ask`变为`no`。
- 但是只改成`StrictHostKeyChecking no`可能在少数情况下还会有些小问题：比如当主机的ip变化的时候，可能会出现警告，并且可能要手动改`known_hosts`的内容（关于这点我没有自己去试，但是应该不假，因为CSDN的那个帖子里也提到了）。所以最好在ssh的config文件里再加上`UserKnownHostsFile /dev/null`。详情参见askubuntu那个帖子，很详细。比前两个加起来内容都多。但是那两个中文的链接方便快速回忆。
- 也可以使用`ssh -o StrictHostKeyChecking=no yourHardenedHost.com`，从而不改配置文件，但是没试过。

# pssh使用

***mynotes:***
- 在尝试pssh时碰到了一个问题。使用一个基本命令在三台机器上同时打印时间（`pssh -h hostpssh -P date`），发现主控机执行失败，两台被控机器执行成功。整个过程记录在了V2EX的帖子了，这里先放一下链接：
  * 请教一个 pssh 的问题：pssh 执行一个命令的时候，能否包括控制机本身 https://www.v2ex.com/t/563378
- 造成这个问题的根本原因是：**我的pssh用的host列表文件`hostpssh`里是用"`用户名@ip地址`"的形式记录需要执行命令的机器的。但是我建互信的时候是用hostname在这些机器之间建立互信的（这些可以参见问题描述部分）**。如果主机名和ip是一一对应的就没问题了，但是我们单位的机器有两套IP，9开头的对外，10开头的对内。**主控机用hostname向其自身建立互信的时候默认用了对内的10开头的IP；向被控机器用hostname建互信时用的是对外的9开头的IP**。所以，归根结底，**还是因为互信没建好才会导致这个错误的出现**。
  

## V2EX那个帖子过程整理

### 问题描述

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

## 解决过程

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

## 最后补充

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
