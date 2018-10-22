

# VirtualBox

- 在VirtualBox中安装CentOS 7 https://www.linuxidc.com/Linux/2016-09/135593.htm  【1】
- VirtualBox下安装CentOS7系统 https://www.cnblogs.com/hihtml5/p/8217062.html  【2】

How can I fix “cannot find a valid baseurl for repo” errors on CentOS? https://unix.stackexchange.com/questions/22924/how-can-i-fix-cannot-find-a-valid-baseurl-for-repo-errors-on-centos
> If pinging a well known host by its name (e.g. ping www.google.com) returns ping: unknown host but pinging an ip (e.g. ping 8.8.8.8) works fine then you have a DNS resolution issue -- try adding these entries to /etc/resolv.conf:
```
nameserver 8.8.8.8
nameserver 8.8.4.4
```

如何开启VirtualBox的共享粘贴板功能 https://jingyan.baidu.com/article/cbf0e500f88a4f2eaa289338.html

## VirtualBox网络问题

- `1.连外网需用网络地址转换(NAT)方式。`按照【1】的步骤把linux在虚拟机装下来（不用装图形界面！），设置网络连接时网卡1用`NAT`方式就可以连外网了。
- `2.ssh连虚拟机需用仅主机(host-only)方式。`接着按照【2】里宿主机是wifi联网的情况下，网卡2用`仅主机`方式，这样可以用ssh连虚拟机了。
