
# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

# 个人实战

> SUSE下直接可用
```sh
harbor1:~ # lsb_release -a
LSB Version:    n/a
Distributor ID: SUSE
Description:    SUSE Linux Enterprise Server 12 SP3
Release:        12.3
Codename:       n/a
```

> CentOS下有时候需要安装一下
```sh
[root@temptest ~]# lsb_release -a
-bash: lsb_release: command not found
[root@temptest ~]#
[root@temptest ~]# yum install -y redhat-lsb
//内容太多，省略了。我就想吐槽，有155个相关的包，用得着这么多嘛？
...
...
(113/115): urw-base35-z003-fonts-20170801-10.el7.noarch.rpm                                             | 275 kB  00:00:00
(114/115): xdg-utils-1.1.0-0.17.20120809git.el7.noarch.rpm                                              |  70 kB  00:00:00
(115/115): xorg-x11-font-utils-7.5-21.el7.x86_64.rpm                                                    | 104 kB  00:00:00
...
...
Complete!

[root@temptest ~]# lsb_release -a
LSB Version:    :core-4.1-amd64:core-4.1-noarch:cxx-4.1-amd64:cxx-4.1-noarch:desktop-4.1-amd64:desktop-4.1-noarch:languages-4.1-amd64:languages-4.1-noarch:printing-4.1-amd64:printing-4.1-noarch
Distributor ID: CentOS
Description:    CentOS Linux release 7.6.1810 (Core)
Release:        7.6.1810
Codename:       Core
```
