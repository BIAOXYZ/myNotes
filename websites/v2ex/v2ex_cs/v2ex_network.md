
443 端口不能处理 UDP 流量吗? https://www.v2ex.com/t/835072

奇怪，一个服务，用 IP 访问正常，也能 ping 通（IP 和域名都可以），但是用 curl 就是不行 https://www.v2ex.com/t/790445
- > 给你推荐下命令（ mac | linux ）：
  ```sh
  sudo tcpdump -i en0 -n port 80 -vv
  ```
  > 可以看到当前机器和外部网络的所有流量交互，都是 ip 到 ip 的，非常详细，顺便还可以看到那些软件窃取了你的隐私上报给第三方。
- > 怎么把 ip 对应到程序呢?没有打印进程信息.
- > 当然，肯定有人有需求看下 当前流量对应是哪个进程，我推荐这个命令：
  ```sh
  sudo nethogs -d 1 -v 4 -l
  ```
  > 可以看到你当前网络流量开销大的进程是哪一个

tcp/ip 协议栈中，子网掩码是存哪的？ https://www.v2ex.com/t/788054

[问题已解决｜后续] docker 容器能 PING 通 IP 但 PING 不通域名问题的排查经历分享 https://www.v2ex.com/t/770438
```console
编辑好了…… v 站不让我发，就分享这个链接了，写在了博文中
前情提要： https://www.v2ex.com/t/769968
[已解决] 记一次 docker 容器内能 ping 通 ip 但 ping 不通域名问题的排查经过 https://hellodk.cn/post/496
```
- > 还没看，盲猜 `daemon.json` 配置了 `iptables: false`
  >> 比我想象的复杂一点，之前碰到过配置了 `iptables: false` 现象跟你这个一样，手动加防火墙规则就行了 理论上说配置了 `iptables: true`，docker 会自动加防火墙规则的
- > TL;DR
  > 1. 没有配置 udp 转发
  > 2. 自建 dns 没有接受来自 docker 网卡的查询
- > 这个之前再机房得时候遇到过一次,外包开发部署得系统和 docker. 他们说网络异常,然后就装死不解决了,没办法我亲自上去排查. 当时直接先查路由还有 ping 发现全打到本地上了,于是怀疑是不是路由表或者虚拟 IP 导致得,ip addr 一下果然是 docker 得默认 bridge 与实际网卡地址段冲突了.告诉开发让他们修改 docker0 得默认地址段重启就解决了. <br> 还有就是 wsl 每次重启也会随机分配 IP,偶尔也会分配到 172.1X 2X 3X 得地址段上,也是个坑,得注意.

请教个 docker 或是 iptables 防火墙问题：容器内能 ping 通 ip 但 ping 不通域名，提示“bad address” https://www.v2ex.com/t/769968

Linux 网络路由问题 https://www.v2ex.com/t/738878
```console
各位好,请教一个问题,目前这边有台 centos 的服务器. em1 是公网固定 IP,静态配置. 
em2 是内网 dhcp 自动获取.每次重启服务器之后获取一个新的 IP.

这样每次 dhcp 都会覆盖之后的公网 IP 默认路由信息,我想出局的路由默认走公网.(即 em2 获取的网关不生效),有什么好的办法吗?

暂时想到定时刷一下默认网关.
```
- > man 8 dhclient-script 把应用网关的注释掉就行了
- > 分别在两个配置文件里添加 DEFROUTE=yes/no

这么多年了才发现 dnspod 可以这么玩......恨晚啊 https://www.v2ex.com/t/735423

有没有哪个软件可以提供获取家里网络 ip 的？ https://www.v2ex.com/t/724481
- > curl ident.me

浏览器的工作原理：从在地址栏输入 google.com 到显示 google 页面发生了什么？ https://www.v2ex.com/t/722929
```console
https://www.html5rocks.com/zh/tutorials/internals/howbrowserswork/
```
- > 我记得以前在 github 看过一个, 不知道是不是它 https://github.com/alex/what-happens-when
  >> 当···时发生了什么？ https://github.com/skyline75489/what-happens-when-zh_CN

有没有什么练手项目可以充分利用到计算机网络相关知识？ https://www.v2ex.com/t/722860

求解 Linux 对本地主机名的解析方式 https://www.v2ex.com/t/721024
```console
centos7 本机的 hostname 为 xxxa
ping xxxa 解析到了 eth1 对应的 ip，这个解析走的是哪里的 dns ？
为什么会解析到 eth1 的 ip 而不是 eth2 eth3 的？
```
- > 先走 /etc/hosts
  >> /etc/hosts 并里没有单独对 xxxa 做任何解析
- > 主机名解析底层就是调用 gethostbyname，你说为什么不对应第二个 ip，理论上应该对应 0.0.0.0，绑定所有的本机 ip，但 linux 程序员就是写了获取回来的第一个 ip，你也没办法。
  >> 这个是内核里写的逻辑吗？
  >>> 严格来说不算内核，就算是个提供给程序的调用库。
- > strace 一下 ping 看看？
- > traceroute 一下，看看那走的节点
- > man 5 nsswitch.conf
- > 好像 gethostbyname 已被 getaddrinfo 替代

如何对已知 CIDR 地址块求补集 https://www.v2ex.com/t/721018

问一个关于 https 和 www 的小白问题 https://www.v2ex.com/t/720726
```console
网站开了 https 以后直接用域名可以访问，https://www.域名 也可与访问，
但是 www.域名 和 http://www.域名 访问不了，这是为什么呢？

大佬们可以试一下
    2yuansvip.com
    https://2yuansvip.com
    https://www.2yuansvip.com
这三种都可以直接访问，甚至 http://2yuansvip.com 也可以直接访问

但是
    www.2yuansvip.com
    http://www.2yuansvip.com
会提示没有找到站点
```
- > 众所周知，http 和 https 是两个不同的网站，www.xxx.com 和 xxx.com 是两个不同的网站。所以，你要想让这四个网站一样，就需要在 Nginx 都绑定这几个域名。参考如下配置
- > 先看 80 端口开了没 再看做没做 301
- > 没看到配置 盲猜是没配置 请求 www 的 http 重定向到 https 的逻辑
- > 二级域名服务商可以做特定解析，然后服务器也可以做 301 重定向
- > 我是用 certbot-auto --nginx 自动生成的配置 你可以参考一下
  ```
  server {
   if ($host = www.xxx.com) {
   return 301 https://$host$request_uri;
   } 
  
   if ($host = xxx.com) {
   return 301 https://$host$request_uri;
   } 
  
   server_name www.xxx.com xxx.com;
   listen 80;
   return 404; 
  }
  ```
  >> 感谢大佬！用了你的配置可以了！！！祝早日暴富！
