
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

# pssh使用

***mynotes:***
- 在尝试pssh时碰到了一个问题。使用一个基本命令在三台机器上同时打印时间（`pssh -h hostpssh -P date`），发现主控机执行失败，两台被控机器执行成功。整个过程记录在了V2EX的帖子了，这里先放一下链接。
  * 请教一个 pssh 的问题：pssh 执行一个命令的时候，能否包括控制机本身 https://www.v2ex.com/t/563378
