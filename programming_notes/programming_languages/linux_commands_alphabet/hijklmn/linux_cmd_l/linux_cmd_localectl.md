
# 源头

起因是在公司新申请的OCP 4.6.1集群上装东西，需要先装ansible，结果按惯例执行下面语句时，
```sh
yum install epel-release -y 
yum install ansible -y
```

一上来就报错：
```sh
[root@oprinstall-inf ~]# yum install epel-release -y
Failed to set locale, defaulting to C.UTF-8
Updating Subscription Management repositories.
Unable to read consumer identity
This system is not registered to Red Hat Subscription Management. You can use subscription-manager to register.
Last metadata expiration check: 0:28:24 ago on Thu Nov 12 17:51:36 2020.
No match for argument: epel-release
Error: Unable to find a match: epel-release
```

按照这个帖子： https://www.tecmint.com/fix-failed-to-set-locale-defaulting-to-c-utf-8-in-centos/ 里说的执行了`localectl set-locale LANG=en_US.UTF-8`后也不行：
```sh
[root@oprinstall-inf ~]# localectl set-locale LANG=en_US.UTF-8
[root@oprinstall-inf ~]# yum install epel-release -y
Failed to set locale, defaulting to C.UTF-8
Updating Subscription Management repositories.
Unable to read consumer identity
This system is not registered to Red Hat Subscription Management. You can use subscription-manager to register.
Last metadata expiration check: 0:28:24 ago on Thu Nov 12 17:51:36 2020.
No match for argument: epel-release
Error: Unable to find a match: epel-release
```

后来发现OS版本是CentOS 8.2。。。呵呵，腊鸡CentOS 8啊，各种问题。最终是用dnf装上了ansible，不过这里主要就是说下碰到这个命令的源头。
```sh
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
dnf install ansible -y
```

# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

# 个人实战
