
# 0.早期转移过来的内容

## samba早期第一批链接

<<Samba 的多用户共享目录配置>>
http://blog.sina.com.cn/s/blog_545f2b4701010t8i.html

http://www.linuxidc.com/Linux/2011-07/38996.htm

http://www.linuxidc.com/Linux/2014-02/97349.htm

http://www.linuxidc.com/Linux/2016-12/138498.htm

http://www.linuxidc.com/Linux/2016-03/129195.htm

## samba早期第二批链接（更详细的资料）

在CentOS 7上安装和配置Samba服务器 https://www.howtoing.com/samba-server-installation-and-configuration-on-centos-7

CentOS 7下Samba服务器的安装与配置 https://www.cnblogs.com/muscleape/p/6385583.html

CentOS7下Samba服务安装与配置 https://www.jianshu.com/p/cc9da3a154a0

Linux samba的配置和使用 https://blog.csdn.net/weixin_40806910/article/details/81917077

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

# 1.后来的链接

Samba (简体中文) https://wiki.archlinux.org/index.php/Samba_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

***// 此外`linuxprobe`第12章就是关于samba配置的***。

samba 共享问题 https://www.v2ex.com/t/825831

# 2.实战部分
