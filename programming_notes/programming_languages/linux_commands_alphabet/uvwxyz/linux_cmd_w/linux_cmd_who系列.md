
# 相关命令

- `w`
- `who`
- `whoami`
- `who am i`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

whoami https://zh.wikipedia.org/wiki/Whoami

# 其他博客类链接

Linux命令（18）查看当前用户who、whoami、who am i https://www.cnblogs.com/lovychen/p/5707279.html
```sh
首先看命令的使用情况：

[@sjs_9_108 ~]$ whoami
spider
[@sjs_9_108 ~]$ who am i 
spider   pts/3        2016-07-26 13:16 (192.168.1.1)
[@sjs_9_108 ~]$ su - root
Password: 
[@sjs_9_108 ~]# whoami  #变了
root
[@sjs_9_108 ~]# who am i #这个却没变
spider   pts/3        2016-07-26 13:16 (192.168.1.1)
[@sjs_9_108 ~]#

那么问题来了，为什么切换用户后，who am i，不会变化呢？
whoami 显示的是当前“操作用户”的用户名
who am i显示的是“登录用户”的用户名（用户登录时用过的id）
实际用户 = uid  即 user id、有效用户 = euid 即effecttive user id
who am i  此命令相当于 who -m
```

图解Linux命令之--w命令 https://blog.csdn.net/Jerry_1126/article/details/52088987
```console
备注:
1) 区别于who命令，w命令不仅可以看到登录服务器的用户信息，而且可以看到这些用户做了什么
2) who am i命令，显示出自己在系统中的用户名，登录终端，登录时间
3) whoami命令，显示自己在系统中的用户名
4) logname命令，可以显示自己初次登录到系统中的用户名，主要识别sudo前后情形
5) last命令，查看最近1个月用户登录服务器的情况 
6) tty命令，来查看所连接的设备或终端
```
