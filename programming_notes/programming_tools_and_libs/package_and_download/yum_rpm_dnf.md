
# [yum](http://yum.baseurl.org/)

Yellowdog Updater, Modified (YUM) https://en.wikipedia.org/wiki/Yum_(software)
- > The Yellowdog Updater, Modified (YUM) is a free and open-source command-line package-management utility for computers running the Linux operating system using the RPM Package Manager. Though YUM has a command-line interface, several other tools provide graphical user interfaces to YUM functionality.

Yum Package Manager http://yum.baseurl.org/

## 常用yum command个人总结

```

```

## yum general

Yum 学习笔记 https://segmentfault.com/a/1190000016194128

20 Linux YUM (Yellowdog Updater, Modified) Commands for Package Management https://www.tecmint.com/20-linux-yum-yellowdog-updater-modified-commands-for-package-mangement/

## yum from Red Hat

Yum Command Cheat Sheet for Red Hat Enterprise Linux https://access.redhat.com/articles/yum-cheat-sheet

8.4.5. ADDING, ENABLING, AND DISABLING A YUM REPOSITORY https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/deployment_guide/sec-managing_yum_repositories
- > Adding a Yum Repository
  >> To define a new repository, you can either add a [repository] section to the /etc/yum.conf file, or to a .repo file in the /etc/yum.repos.d/ directory. All files with the .repo file extension in this directory are read by yum, and it is recommended to define your repositories here instead of in /etc/yum.conf.

## yum配置

yum配置与使用(很详细) http://www.cnblogs.com/xiaochaohuashengmi/archive/2011/10/09/2203916.html

### 配置本地仓库

搭建本地离线yum仓库 https://www.cnblogs.com/asheng2016/p/local-yum.html 【[:star:][`*`]】

下载rpm包与本地yum仓库的制作 https://www.jianshu.com/p/286fcef565ab

***其他配置方式（如用挂载镜像的方式，但是这种应该比较少，所以没细研究）***：
- https://blog.csdn.net/leshami/article/details/78133716
- https://blog.csdn.net/danneel/article/details/52098527
- https://blog.csdn.net/jack_nichao/article/details/51685312

## yum命令

linux yum命令详解 http://www.cnblogs.com/chuncn/archive/2010/10/17/1853915.html

***yum update vs yum upgrade***:
- In CentOS, what is the difference between yum update and yum upgrade? https://unix.stackexchange.com/questions/55777/in-centos-what-is-the-difference-between-yum-update-and-yum-upgrade
  * > `yum upgrade` forces the removal of obsolete packages, while `yum update` may or may not also do this. The removal of obsolete packages can be risky, as it may remove packages that you use. This makes `yum update` the safer option.

## yum其他

### 安装指定版本软件

在CentOS系统中使用yum安装指定版本软件 https://blog.csdn.net/cy309173854/article/details/78668237

## yum问题错误故障等

Why does yum return error: [Errno 256] No more mirrors to try ? https://access.redhat.com/solutions/203603
```
我是重装openshift时候碰到的，只是执行了一下yum repolist，然后自动更新了下就好了。
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# [rpm](https://rpm.org/)

RPM Package Manager https://en.wikipedia.org/wiki/RPM_Package_Manager
- > RPM Package Manager (RPM) (originally Red Hat Package Manager; now a recursive acronym) is a free and open-source package management system. The name RPM refers to .rpm file format and the package manager program itself. RPM was intended primarily for Linux distributions; the file format is the baseline package format of the Linux Standard Base.

RPM Package Manager https://rpm.org/

## rpm常用命令

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

CentOS等Linux发行版中使用的RPM软件管理器 https://itbilu.com/linux/man/EkSbng7SG.html
```sh
3.1 rpm软件安装
安装名为foo-1.1-5-i386.rpm的软件，可以使用以下命令：
    rpm -i foo-1.1-5-i386.rpm
为了看到安装信息及安装进度，我们通常还会加上-vh参数：
    rpm -ivh foo-1.1-5-i386.rpm
-i - 表示install安装的意思
-v - 显示安装信息
-h - 表示显示安装进度

3.2 rpm软件升级与更新
软件升级可以使用-U或-F参数，为了显示安装信息及安装进度通常也会加上-vh参数。如，升级foo-1.1-5-i386.rpm软件：
    rpm -Uvh foo-1.1-5-i386.rpm
# 或
    rpm -Fvh foo-1.1-5-i386.rpm
两者的区别是：
-Uvh - 当软件未安装时，会直接安装最新版。当已安装时，会升级到最新版
-Fvh - 只有当已安装时，才会升级到最新版。未安装则无操作
```

## rpm其他

Difference between yum update vs yum install https://unix.stackexchange.com/questions/157448/difference-between-yum-update-vs-yum-install
> As to installing vs. upgrading. Both tools can perform an install, and RPM will even allow you to install multiple versions simultaneously, but YUM will tell you that that package is already installed. So no YUM will not allow you to install multiple versions.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# dnf

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
