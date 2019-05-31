
### bash-completion

RedHat - yum install completion https://serverfault.com/questions/511876/redhat-yum-install-completion
- > first check that you have the bash_completion package installed;
  ```
  $ rpm -qa | grep compl
  bash-completion-2.1-2.fc18.noarch
  ```

Bash completion is very incomplete on centos 7 https://unix.stackexchange.com/questions/264102/bash-completion-is-very-incomplete-on-centos-7
- > You might want to try `bash-completion-extras`. It's currently still in epel-testing, but will eventually be released into epel. Right now, you should be able to run: `yum --enablerepo=epel-testing install bash-completion-extras` to get bash-completion-extras.
  >> notes: 补充一下，`bash-completion-extras`现在已经进epel了，所以安装的话和安装`bash-completion`一样 。有人喜欢直接这样装：`yum install bash-completion bash-completion-extras`，但是我好像一般还是简单点用`yum install bash-completion`安装。
- > I have the bash-completion package installed on my CentOS system and by default it's got plenty of support for many applications. Check the version you have also, just in case.
```
$  yum list installed | grep completion
bash-completion.noarch                1:1.3-7.el6               @epel
$  repoquery --list bash-completion.noarch 
/etc/bash_completion
/etc/bash_completion.d
/etc/bash_completion.d/abook
/etc/bash_completion.d/ant
/etc/bash_completion.d/apt
/etc/bash_completion.d/aspell
/etc/bash_completion.d/autoconf
/etc/bash_completion.d/automake
/etc/bash_completion.d/autorpm
/etc/bash_completion.d/bash-builtins
/etc/bash_completion.d/bind-utils
/etc/bash_completion.d/bitkeeper
/etc/bash_completion.d/bittorrent
...
...
```

### SSH & SSL & TLS

<<SSH用私钥登录远程服务器时提示私钥不安全>>
http://www.codeweblog.com/ssh%E7%94%A8%E7%A7%81%E9%92%A5%E7%99%BB%E5%BD%95%E8%BF%9C%E7%A8%8B%E6%9C%8D%E5%8A%A1%E5%99%A8%E6%97%B6%E6%8F%90%E7%A4%BA%E7%A7%81%E9%92%A5%E4%B8%8D%E5%AE%89%E5%85%A8/

### 阮一峰SSL/TLS相关
- <<SSH原理与运用（一）：远程登录>> http://www.ruanyifeng.com/blog/2011/12/ssh_remote_login.html
```
SSH主要用于远程登录。假定你要以用户名user，登录远程主机host，只要一条简单命令就可以了。
　　$ ssh user@host

如果本地用户名与远程用户名一致，登录时可以省略用户名。
　　$ ssh host
  
SSH的默认端口是22，也就是说，你的登录请求会送进远程主机的22端口。使用p参数，可以修改这个端口。
　　$ ssh -p 2222 user@host
```
- SSL/TLS协议运行机制的概述 http://www.ruanyifeng.com/blog/2014/02/ssl_tls.html
- 图解SSL/TLS协议 http://www.ruanyifeng.com/blog/2014/09/illustration-ssl.html

#### SSH建互信

- http://blog.csdn.net/seeyouc/article/details/53102280
- http://www.cnblogs.com/jyzhao/p/3781072.html
- https://www.linuxdaxue.com/linux-auto-make-ssh-authon.html

#### SSH免密登陆（和建互信一个意思）

- ssh免密登录配置 https://www.jianshu.com/p/0922095f69f3
- Linux之ssh免密登录 https://blog.csdn.net/mmd0308/article/details/73825953

### samba

<<Samba 的多用户共享目录配置>>
http://blog.sina.com.cn/s/blog_545f2b4701010t8i.html

http://www.linuxidc.com/Linux/2011-07/38996.htm

http://www.linuxidc.com/Linux/2014-02/97349.htm

http://www.linuxidc.com/Linux/2016-12/138498.htm

http://www.linuxidc.com/Linux/2016-03/129195.htm

### 忘记密码

**后来配置windows笔记本和xubuntu本互联时**

<<Ubuntu 14.04 文件服务器--samba的安装和配置>> 
https://jingyan.baidu.com/article/00a07f38b9194082d028dc08.html
> 这个解决开始sudo apt-get install samba有依赖无法成功的场景。解决方法很简单，执行下sudo apt-get update先升级。不过升级后还是使用了sudo apt-get install samba语句来安装，而不是该帖中使用的sudo apt-get install samba samba-common语句来安装samba

<<ubuntu系统用户密码忘记了怎么办>>
https://jingyan.baidu.com/article/e2284b2b3cea8ae2e6118de1.html
> 这个解决知道普通用户密码，但是忘了root密码的情况。不需要一般的重启设置的方法，而是
```
进入终端 #sudo su root然后输入普通用户的密码，就暂时获得了root帐号的权限了，同时也进入了root账号下了；
```

### Xshell自动断连
在 /etc/profile 末尾加上 
```
export TMOUT=0
```

### MobaXterm

<<MobaXTerm的复制/粘贴没有Ctrl+Ins/Shift+Ins快捷键，怎么设置呢？>>
https://www.zhihu.com/question/34830447
```
在 Linux/BSD 的图形环境（X Window）里，鼠标选中对象之后，点击鼠标中键就可以粘贴了。
```
```
Settings->Configuration->Terminal

可以修改字体，字号

勾选Paste using right-click，启用右键复制功能，此时如果要用右键菜单，用Ctrl+右键即可。
```

全功能的终端软件MobaXterm推荐配置
https://www.jianshu.com/p/161b9be14494

免费开源SSH客户端神器MobaXterm，是时候puttty、Xshell和SecureCRT说Byebye了 https://www.freebuf.com/column/163631.html

### CMake
<<find_package与CMake如何查找链接库详解>>
http://blog.csdn.net/bytxl/article/details/50637277

### 包管理工具

<<yum与rpm、apt的区别：rpm的缺陷及yum的优势>>
http://www.aboutyun.com/thread-9226-1-1.html

### 性能

宋宝华：火焰图：全局视野的Linux性能剖析
http://blog.csdn.net/21cnbao/article/details/78527777  -- by 21cnbao
