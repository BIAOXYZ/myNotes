
# yum

## 常用yum command个人总结

```

```

## yum general

Yum Command Cheat Sheet for Red Hat Enterprise Linux https://access.redhat.com/articles/yum-cheat-sheet

Yum 学习笔记 https://segmentfault.com/a/1190000016194128

## yum配置

yum配置与使用(很详细) http://www.cnblogs.com/xiaochaohuashengmi/archive/2011/10/09/2203916.html

## yum命令

linux yum命令详解 http://www.cnblogs.com/chuncn/archive/2010/10/17/1853915.html

***yum update vs yum upgrade***:
- In CentOS, what is the difference between yum update and yum upgrade? https://unix.stackexchange.com/questions/55777/in-centos-what-is-the-difference-between-yum-update-and-yum-upgrade
  * > `yum upgrade` forces the removal of obsolete packages, while `yum update` may or may not also do this. The removal of obsolete packages can be risky, as it may remove packages that you use. This makes `yum update` the safer option.

## yum其他

在CentOS系统中使用yum安装指定版本软件 https://blog.csdn.net/cy309173854/article/details/78668237

## yum问题错误故障等

Why does yum return error: [Errno 256] No more mirrors to try ? https://access.redhat.com/solutions/203603
```
我是重装openshift时候碰到的，只是执行了一下yum repolist，然后自动更新了下就好了。
```

## EPEL

- 什么是EPEL 及 Centos上安装EPEL https://blog.csdn.net/yasi_xi/article/details/11746255
- CentOS使用EPEL源 https://blog.csdn.net/apache0554/article/details/47733115

yum - epel源 https://segmentfault.com/a/1190000016344259

Centos7.x RHEL 配置EPEL第三方YUM源 https://blog.csdn.net/u011435712/article/details/48751275
```
如何安装 Epel源到 RHEL/CentOS 7/6/5？通过wget命令下载RPM文件，然后安装。

RHEL/CentOS 7
# wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# rpm -ivh epel-release-7.noarch.rpm

RHEL/CentOS 6 
# wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
# rpm -ivh epel-release-6.noarch.rpm

----------------------------------------------------------------------------------------------------

如何检查epel是否安装成功？使用一下命令：
# yum repolist

----------------------------------------------------------------------------------------------------

如何使用epel源安装软件？例如想查看cacti信息
# yum --enablerepo=epel info cacti  

安装则执行以下命令：
# yum --enablerepo=epel install cacti

Note: Epel的配置文件在/etc/yum.repos.d/epel.repo.
```

>> 有的攻略提到也可以用yum方式直接装epel（`yum install -y epel-release`），实战了一把。因为感觉还是能直接yum就直接yum，让软件自动解决依赖问题，比手动用rpm方式稳。
```
root@cloudsec2:~$ yum repolist
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
repo id                                                    repo name                                                     status
base/7/x86_64                                              CentOS-7 - Base                                               10,019
docker-ce-stable/x86_64                                    Docker CE Stable - x86_64                                         43
extras/7/x86_64                                            CentOS-7 - Extras                                                409
updates/7/x86_64                                           CentOS-7 - Updates                                             1,982
repolist: 12,453

root@cloudsec2:bash-completion$ yum install -y epel-release
...
...
...

root@cloudsec2:bash-completion$ yum repolist
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * epel: mirrors.cat.pdx.edu
repo id                                          repo name                                                               status
base/7/x86_64                                    CentOS-7 - Base                                                         10,019
docker-ce-stable/x86_64                          Docker CE Stable - x86_64                                                   43
*epel/x86_64                                     Extra Packages for Enterprise Linux 7 - x86_64                          13,210
extras/7/x86_64                                  CentOS-7 - Extras                                                          409
updates/7/x86_64                                 CentOS-7 - Updates                                                       1,982
repolist: 25,663
```

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# rpm

Linux rpm 命令参数使用详解［介绍和应用］ https://www.cnblogs.com/xiaochaohuashengmi/archive/2011/10/08/2203153.html
```
-ivh：安装显示安装进度--install--verbose--hash
-Uvh：升级软件包--Update；
-qpl：列出RPM软件包内的文件信息[Query Package list]；
-qpi：列出RPM软件包的描述信息[Query Package install package(s)]；
-qf：查找指定文件属于哪个RPM软件包[Query File]；
-Va：校验所有的RPM软件包，查找丢失的文件[View Lost]；
-e：删除包
```
```
rpm -q samba //查询程序是否安装

rpm -ivh  /media/cdrom/RedHat/RPMS/samba-3.0.10-1.4E.i386.rpm //按路径安装并显示进度
rpm -ivh --relocate /=/opt/gaim gaim-1.3.0-1.fc4.i386.rpm    //指定安装目录

rpm -ivh --test gaim-1.3.0-1.fc4.i386.rpm　　　 //用来检查依赖关系；并不是真正的安装；
rpm -Uvh --oldpackage gaim-1.3.0-1.fc4.i386.rpm //新版本降级为旧版本

rpm -qa | grep httpd　　　　　 ＃[搜索指定rpm包是否安装]--all搜索*httpd*
rpm -ql httpd　　　　　　　　　＃[搜索rpm包]--list所有文件安装目录

rpm -qpi Linux-1.4-6.i368.rpm　＃[查看rpm包]--query--package--install package信息
rpm -qpf Linux-1.4-6.i368.rpm　＃[查看rpm包]--file
rpm -qpR file.rpm　　　　　　　＃[查看包]依赖关系
rpm2cpio file.rpm |cpio -div    ＃[抽出文件]

rpm -ivh file.rpm 　＃[安装新的rpm]--install--verbose--hash
rpm -ivh

rpm -Uvh file.rpm    ＃[升级一个rpm]--upgrade
rpm -e file.rpm      ＃[删除一个rpm包]--erase
```

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# apt & apt-get

***这俩内容差不多，并且都是转自同一个帖子。都记下来是因为：第二个内容更全，第一个排版更好。***
- apt 和 apt-get的区别 https://blog.csdn.net/liudsl/article/details/79200134
- Linux中apt与apt-get命令的区别与解释 https://blog.csdn.net/maizousidemao/article/details/79859669

apt-get命令 http://man.linuxde.net/apt-get

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# dpkg

***From（Ubuntu或Debian）官方网站:***
- dpkg https://help.ubuntu.com/lts/serverguide/dpkg.html
- 5.4. 通过dpkg来操作软件包 https://www.debian.org/doc/manuals/debian-handbook/sect.manipulating-packages-with-dpkg.zh-cn.html

Ubuntu下deb包的安装方法 https://blog.csdn.net/kevinhg/article/details/5934462

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# curl

cURL 作者 Daniel Stenberg 宣布即将从 Mozilla 离职 https://www.cnbeta.com/articles/tech/789651.htm

Linux中使用curl命令访问https站点4种常见错误和解决方法 https://www.jb51.net/LINUXjishu/287588.html
> "解决办法是将签发该证书的私有CA公钥cacert.pem文件内容，追加到/etc/pki/tls/certs/ca-bundle.crt。"
```
[root@cloudsec2 bin]# curl https://9.186.102.71:2379/v3alpha/kv/range
curl: (60) Peer's Certificate issuer is not recognized.
More details here: http://curl.haxx.se/docs/sslcerts.html

试ETCD的时候碰到的问题。试了下把自己生成的ca.pem内容按帖子里说的追加到"/etc/pki/tls/certs/ca-bundle.crt"末尾了，
但是还是不行。猜测是因为我这边ETCD是双向SSL认证的原因，所以client端也得改点啥???回头再研究吧，反正目前重点不在ETCD。
```

记一次解决curl https证书问题 https://www.cnblogs.com/xuxinkun/p/5417836.html

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# wget

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# zypper

SuSE的命令安装软件 zypper，yast2
https://blog.csdn.net/s_k_yliu/article/details/6674079

SUSE Linux – Zypper 命令示例
https://www.linuxidc.com/Linux/2014-11/109214.htm
```
zypper lr    以表格的形式列出仓库的URI
zypper ar <url> <alias>   添加仓库
zypper rr <alias>   移除仓库
zypper install xxx   安装软件包
zypper rm xxx   卸载软件包
```

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# Chocolatey

About Chocolatey https://chocolatey.org/about
> "Chocolatey is a package manager for Windows (like apt-get or yum but for Windows). It was designed to be a decentralized framework for quickly installing applications and tools that you need. It is built on the NuGet infrastructure currently using PowerShell as its focus for delivering packages from the distros to your door, err computer."
>> 非常巧合地发现了这个Windows下的包管理软件————因为偶然在看[TikZiT](https://github.com/tikzit/tikzit)的README.md，里面提到在Windows下装`flex/bison`的话可以用`WinFlexBison`或者用`Chocolatey`————不过回头有时间再试试好了。
>>> "In addition to Qt itself, TikZiT needs flex/bison, Poppler (with Qt bindings), and OpenSSL. For flex/bison, the simplest way to install this is to download WinFlexBison, then make sure both are in your %Path% so the build tools can find them. Altflex/bisonernatively, you can install it via Chocolatey, via: `choco install winflexbison`"

