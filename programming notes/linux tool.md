
### SSH

<<SSH原理与运用（一）：远程登录>>
http://www.ruanyifeng.com/blog/2011/12/ssh_remote_login.html

### samba

<<Samba 的多用户共享目录配置>>
http://blog.sina.com.cn/s/blog_545f2b4701010t8i.html

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

http://www.linuxidc.com/Linux/2011-07/38996.htm

http://www.linuxidc.com/Linux/2014-02/97349.htm

http://www.linuxidc.com/Linux/2016-12/138498.htm

http://www.linuxidc.com/Linux/2016-03/129195.htm



### Xshell自动断连
在 /etc/profile 末尾加上 
```
export TMOUT=0
```

### 包管理工具

<<yum与rpm、apt的区别：rpm的缺陷及yum的优势>>
http://www.aboutyun.com/thread-9226-1-1.html
