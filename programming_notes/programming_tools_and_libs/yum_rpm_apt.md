
# yum

Yum 学习笔记 https://segmentfault.com/a/1190000016194128

## yum配置

yum配置与使用(很详细) http://www.cnblogs.com/xiaochaohuashengmi/archive/2011/10/09/2203916.html

## yum命令

linux yum命令详解 http://www.cnblogs.com/chuncn/archive/2010/10/17/1853915.html

## yum其他

在CentOS系统中使用yum安装指定版本软件 https://blog.csdn.net/cy309173854/article/details/78668237

## EPEL

- 什么是EPEL 及 Centos上安装EPEL https://blog.csdn.net/yasi_xi/article/details/11746255
- CentOS使用EPEL源 https://blog.csdn.net/apache0554/article/details/47733115

yum - epel源 https://segmentfault.com/a/1190000016344259

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# rpm


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# apt & apt-get

***这俩内容差不多，并且都是转自同一个帖子。都记下来是因为：第二个内容更全，第一个排版更好。***
- apt 和 apt-get的区别 https://blog.csdn.net/liudsl/article/details/79200134
- Linux中apt与apt-get命令的区别与解释 https://blog.csdn.net/maizousidemao/article/details/79859669

apt-get命令 http://man.linuxde.net/apt-get

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# dpkg


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

