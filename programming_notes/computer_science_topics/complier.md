
# 来，把你排第一

面对舆论，方舟编译器首次公布源码分析及基础架构 https://www.infoq.cn/article/qcfC3pa21xGeWxiu5vq9

# GCC/G++

## GCC版本升级

CentOS 7 升级gcc/g++编译器 https://www.cnblogs.com/ToBeExpert/p/10297697.html

CentOS 下安装高版本 GCC https://www.hi-linux.com/posts/25767.html

CentOS7 升级gcc版本 https://www.cnblogs.com/Hi-blog/p/How-To-Update-Gcc-On-CentOS7.html
> 在一些使用场景下需要高版本的GCC编译器，网上有介绍的下载源码编译，但个人在编译的时候老是会出一些问题，而且编译过程较为冗长，现简单copy stackoverflow上的回答。
>> How to Install gcc 5.3 with yum on CentOS 7.2? https://stackoverflow.com/questions/36327805/how-to-install-gcc-5-3-with-yum-on-centos-7-2
```sh
sudo yum install centos-release-scl
sudo yum install devtoolset-7-gcc*
scl enable devtoolset-7 bash
which gcc
gcc --version
```

***个人实战（就是加了`-y`）***：
```sh
[root@temptest ~]# yum install centos-release-scl -y
//输出省略
[root@temptest ~]# yum install devtoolset-7-gcc* -y
//输出省略


[root@temptest ~]# gcc --version
gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[root@temptest sci]# which gcc
/usr/bin/gcc
[root@temptest ~]# scl enable devtoolset-7 bash
[root@temptest ~]#
[root@temptest ~]# gcc --version
gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[root@temptest sci]# which gcc
/opt/rh/devtoolset-7/root/usr/bin/gcc
```

# LLVM

# Zapcc [https://github.com/yrnkrn/zapcc]

缓存型C++编译器Zapcc开源 号称比Clang更快 - Open Source 开源 - cnBeta.COM
https://www.cnbeta.com/articles/soft/737459.htm
