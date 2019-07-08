
# 参考链接

## 主参考链接

怎样在 CentOS 7.0 上安装和配置 VNC 服务器 https://linux.cn/article-5335-1.html

## 其他参考链接

CentOS7.2安装VNC，让Windows远程连接CentOS 7.2 图形化界面 https://blog.51cto.com/12217917/2060252

# 实战过程

```
[root@temptest packages]# yum check-update
//省略输出
[root@temptest packages]# yum -y groupinstall "X Window System"
...
...
...
Transaction Summary
===========================================================================================================================================================
Install  11 Packages (+272 Dependent packages)
Upgrade              (   5 Dependent packages)

Total download size: 171 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/288): NetworkManager-wifi-1.12.0-10.el7_6.x86_64.rpm                                                                             | 187 kB  00:00:02     
(2/288): ModemManager-glib-1.6.10-1.el7.x86_64.rpm                                                                                  | 231 kB  00:00:03     
(3/288): GConf2-3.2.6-8.el7.x86_64.rpm                                                                                              | 1.0 MB  00:00:06 
...
...
...
[root@temptest packages]# yum -y install gnome-classic-session gnome-terminal nautilus-open-terminal control-center liberation-mono-fonts
...
...
...
Transaction Summary
===========================================================================================================================================================
Install  5 Packages (+137 Dependent packages)

Total download size: 75 M
Installed size: 303 M
Downloading packages:
(1/142): accountsservice-libs-0.6.50-4.el7.1.x86_64.rpm                                                                             |  80 kB  00:00:02     
(2/142): accountsservice-0.6.50-4.el7.1.x86_64.rpm                                                                                  |  98 kB  00:00:02     
(3/142): adwaita-gtk2-theme-3.28-2.el7.x86_64.rpm                                                                                   | 134 kB  00:00:02 
...
...
...
[root@temptest packages]# unlink /etc/systemd/system/default.target
[root@temptest packages]# ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
[root@temptest packages]#
[root@temptest packages]# reboot
连接断开
连接成功
Last login: Fri Jul  5 13:48:40 2019 from 9.200.45.42
[root@temptest ~]# 
[root@temptest ~]# yum install tigervnc-server -y
//省略输出
[root@temptest ~]# cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service
[root@temptest ~]# 
[root@temptest ~]# vi /etc/systemd/system/vncserver\@\:1.service
[root@temptest ~]#
[root@temptest ~]# systemctl daemon-reload
[root@temptest ~]# 
//这里攻略里没提到，网上搜了搜感觉都是选n
[root@temptest ~]# vncpasswd
Password:
Verify:
Would you like to enter a view-only password (y/n)? n
A view-only password is not used
[root@temptest ~]# 
[root@temptest ~]# sudo systemctl enable vncserver@:1.service
Created symlink from /etc/systemd/system/multi-user.target.wants/vncserver@:1.service to /etc/systemd/system/vncserver@:1.service.
[root@temptest ~]# sudo systemctl start vncserver@:1.service

//最后防火墙那步没配，因为看了下本机防火墙就是关的。
[root@temptest ~]# systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; disabled; vendor preset: enabled)
   Active: inactive (dead)
     Docs: man:firewalld(1)
```
