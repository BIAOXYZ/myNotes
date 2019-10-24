
# 相关命令

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
