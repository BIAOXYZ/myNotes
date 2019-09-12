
# `#` 0.各种操作系统自带类

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

## rpm其他

Difference between yum update vs yum install https://unix.stackexchange.com/questions/157448/difference-between-yum-update-vs-yum-install
> As to installing vs. upgrading. Both tools can perform an install, and RPM will even allow you to install multiple versions simultaneously, but YUM will tell you that that package is already installed. So no YUM will not allow you to install multiple versions.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# dnf

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# devtoolset + scl

Developer Toolset 7 by Software Collections https://www.softwarecollections.org/en/scls/rhscl/devtoolset-7/

CentOS/RHEL 开发环境之 devtoolset http://blog.fungo.me/2016/03/centos-development-env/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# apt & apt-get

***这俩内容差不多，并且都是转自同一个帖子。都记下来是因为：第二个内容更全，第一个排版更好。***
- apt 和 apt-get的区别 https://blog.csdn.net/liudsl/article/details/79200134
- Linux中apt与apt-get命令的区别与解释 https://blog.csdn.net/maizousidemao/article/details/79859669

apt-get命令 http://man.linuxde.net/apt-get

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# dpkg

***From（Ubuntu或Debian）官方网站:***
- dpkg https://help.ubuntu.com/lts/serverguide/dpkg.html
- 5.4. 通过dpkg来操作软件包 https://www.debian.org/doc/manuals/debian-handbook/sect.manipulating-packages-with-dpkg.zh-cn.html

Ubuntu下deb包的安装方法 https://blog.csdn.net/kevinhg/article/details/5934462

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# apk (for [Alpine Linux](https://en.wikipedia.org/wiki/Alpine_Linux))

```
$ apk --help
apk-tools 2.10.3, compiled for x86_64.

Installing and removing packages:
  add       Add PACKAGEs to 'world' and install (or upgrade) them, while ensuring that all dependencies are met
  del       Remove PACKAGEs from 'world' and uninstall them

System maintenance:
  fix       Repair package or upgrade it without modifying main dependencies
  update    Update repository indexes from all remote repositories
  upgrade   Upgrade currently installed packages to match repositories
  cache     Download missing PACKAGEs to cache and/or delete unneeded files from cache

Querying information about packages:
  info      Give detailed information about PACKAGEs or repositories
  list      List packages by PATTERN and other criteria
  dot       Generate graphviz graphs
  policy    Show repository policy for packages

Repository maintenance:
  index     Create repository index file from FILEs
  fetch     Download PACKAGEs from global repositories to a local directory
  verify    Verify package integrity and signature
  manifest  Show checksums of package contents

Use apk <command> --help for command-specific help.
Use apk --help --verbose for a full command listing.

This apk has coffee making abilities.
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# pacman (for [Arch Linux](https://en.wikipedia.org/wiki/Arch_Linux))

pacman (简体中文) https://wiki.archlinux.org/index.php/Pacman_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# pkg

**//又从[hub](https://github.com/github/hub)项目知道`FreeBSD`下的包管理工具`pkg`**。。。

The `hub` executable has no dependencies, but since it was designed to wrap
`git`, it's recommended to have at least **git 1.7.3** or newer.

platform | manager | command to run
---------|---------|---------------
macOS, Linux | [Homebrew](https://docs.brew.sh/Installation) | `brew install hub`
Windows | [Scoop](http://scoop.sh/) | `scoop install hub`
Windows | [Chocolatey](https://chocolatey.org/) | `choco install hub`
Fedora Linux | [DNF](https://fedoraproject.org/wiki/DNF) | `sudo dnf install hub`
Arch Linux | [pacman](https://wiki.archlinux.org/index.php/pacman) | `sudo pacman -S hub`
FreeBSD | [pkg(8)](http://man.freebsd.org/pkg/8) | `pkg install hub`
Debian | apt | `sudo apt install hub`
Ubuntu | [Snap](https://snapcraft.io) | `snap install hub --classic`

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

Comparison of major Linux package management systems https://linuxconfig.org/comparison-of-major-linux-package-management-systems
- `aptitude`
- [Portage] (https://wiki.gentoo.org/wiki/Portage)
  * `emerge`

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# [wget](https://www.gnu.org/software/wget/)

【:star:】 GNU Wget 1.20 Manual https://www.gnu.org/software/wget/manual/

17. wget 文件下载 https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/wget.html

linux 下载 命令 wget 和 curl https://blog.csdn.net/freeking101/article/details/53691481

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` 1.第三方类

# Chocolatey

About Chocolatey https://chocolatey.org/about
> "Chocolatey is a package manager for Windows (like apt-get or yum but for Windows). It was designed to be a decentralized framework for quickly installing applications and tools that you need. It is built on the NuGet infrastructure currently using PowerShell as its focus for delivering packages from the distros to your door, err computer."
>> 非常巧合地发现了这个Windows下的包管理软件————因为偶然在看[TikZiT](https://github.com/tikzit/tikzit)的README.md，里面提到在Windows下装`flex/bison`的话可以用`WinFlexBison`或者用`Chocolatey`————不过回头有时间再试试好了。
>>> "In addition to Qt itself, TikZiT needs flex/bison, Poppler (with Qt bindings), and OpenSSL. For flex/bison, the simplest way to install this is to download WinFlexBison, then make sure both are in your %Path% so the build tools can find them. Altflex/bisonernatively, you can install it via Chocolatey, via: `choco install winflexbison`"

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Scoop

「一行代码」搞定软件安装卸载，用 Scoop 管理你的 Windows 软件 https://sspai.com/post/52496

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# GoFish

```
//来源：https://github.com/helm/helm -- Install

If you want to use a package manager:
  - Homebrew users can use brew install kubernetes-helm.
  - Chocolatey users can use choco install kubernetes-helm.
  - Scoop users can use scoop install helm.
  - GoFish users can use gofish install helm.
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Snappy

```
//来源：https://helm.sh/docs/using_helm/ -- INSTALLING THE HELM CLIENT -- From Snap (Linux)
//忍不住吐个槽，这个Helm花样还挺多的，并且和包管理杠上了。。。自己就是个“包管理”（只不过是k8s平台的包管理）
//    软件，然后还可以通过一堆各种各样的包管理软件来装。。。

The Snap package for Helm is maintained by Snapcrafters.
$ sudo snap install helm --classic
```

Snappy (package manager) https://en.wikipedia.org/wiki/Snappy_(package_manager)

Snapcraft: The app store for Linux - Publish your app for Linux users — for desktop, cloud, and Internet of Things. https://snapcraft.io/

Installing snapd https://snapcraft.io/docs/installing-snapd

使用 Snapcraft 构建、测试并发布 Snap 软件包 https://linux.cn/article-8788-1.html

What is the classic mode of snap, and why do some snaps not install without it (e.g. MS Visual Studio)? https://askubuntu.com/questions/917049/what-is-the-classic-mode-of-snap-and-why-do-some-snaps-not-install-without-it

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vcpkg

C++ Library Manager for Windows, Linux, and MacOS https://github.com/microsoft/vcpkg

如何看待 Windows 的 C++ 包管理器 vcpkg？ - 知乎 https://www.zhihu.com/question/263416411
