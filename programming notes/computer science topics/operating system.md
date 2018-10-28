
# OS general

开源版“Windows 操作系统” ReactOS 0.4.9 版发布 - 软件和应用 - cnBeta.COM
https://www.cnbeta.com/articles/soft/751203.htm

最受欢迎的10个Linux发行版 https://www.linuxprobe.com/linux-welcome.html

# Windows系

微软团队成员谈Windows Kernel的结构 - Windows - cnBeta.COM
https://www.cnbeta.com/articles/tech/781961.htm

# RedHat系

浅析CentOS和RedHat Linux的区别 https://www.cnblogs.com/zjoch/p/6394150.html

## [CentOS](https://www.centos.org/)

> VirtualBox虚拟机里装了CentOS7.5，装完后yum update等都没法用。然后发现ping命令ping数字形式的ip地址可以，但是ping网址就不行，于是猜测是DNS的问题。经过查询后发现应该是要在 `/etc/resolv.conf` 里增加一些可用的DNS（比如8.8.8.8，114.114.114.114等），然后用service network restart重启一下网络服务即可。道理是这个道理，但是蛋疼的是只要一重启网络， `/etc/resolv.conf` 这个文件内容就还原了。。。擦！于是后面就是查一查怎样让修改永久生效。下面三个帖子综合看一下吧，反正核心点是修改 `/etc/sysconfig/network-scripts/ifcfg-eth<N>`，在这个文件里添加 `PEERDNS=no DNS1=XXX.XXX.XXX.XXX DNS2=XXX.XXX.XXX.XXX`等。我是加了如下的就好了。
`PEERDNS=no
DNS1=192.168.1.1
DNS2=8.8.8.8
DNS3=114.114.114.114`

- CentOS修改DNS重启或者重启network服务后丢失问题处理 https://www.linuxidc.com/Linux/2015-09/122761.htm
- /etc/resolv.conf 的更改在重启后丢失的解决办法 https://blog.csdn.net/qq_29350001/article/details/51785176
- linux resolv.conf 配置信息丢失解决方法 https://blog.csdn.net/wt346326775/article/details/56840619

# 其他OS

用于年幼学童教学的 Linux 发行版 PrimTux 发布第 4 版 - Linux - cnBeta.COM
https://www.cnbeta.com/articles/soft/781939.htm
