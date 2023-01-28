
实验室想要实现让一台机器只能访问内网不能访问公网，应该用什么技术实现？ https://www.v2ex.com/t/910930

【[:star:][`*`]】 Linux 的防火墙， iptables， firewalld 和 netfilter 这些东西到底是什么关系啊？ https://www.v2ex.com/t/906174
- > `netfilter`：里世界，实际应用规则的人，但不能直接操作， <br> `iptables`：因为不能直接操作里世界，所以在表世界映射成 iptables 供用户使用， <br> `firewall`、`ufw`：让用户使用更爽的一层 iptables 封装。
  >> 最新的 firewalld 不使用 iptables 了，使用的是 `nftables`。不直接使用 iptables ，使用 firewalld 是因为：firewalld 是有状态的，可以实现有状态运维管理（基于 ansible + git 的代码化运维）
- > 个人理解，netfilter 是内核提供的 API ，允许其他模块 hook 网络流量，iptables 通过调用 netfilter API 来实现各种功能。 <br> firewalld 是用户模式的 iptables 管理工具，通过一些简化的语法来生成对应复杂的 iptables 规则。
- >
  * > --------先给你解释 iptable 和 firewalld 的关系
    + > 假设实际的防火墙规则是一条条内核中的记录, 那么 iptable-save 就是用自己格式输出、保存的防火墙规则, iptabale 的其他命令行工具能对防火墙规则进行增删改查
    + > iptable 本质就是清空防火墙规则 保存防火墙规则 推送保存的防火墙规则的工具
    + > 由于 iptable 对复杂规则的使用不够友好,所以设计了 firewalld 这个以 xml 存储防火墙规则的程序
    + > 但是无论是 iptable 还是 firewalld,最后操作的都是内核中的记录,所以无论使用 firewalld 还是 iptable, 修改、列出的规则都是内核中的规则
    + > ***现在都是尽量避免使用 `iptable` 来操作防火墙,都是用 `firewalld` 来配置***
  * > -------这里解释容器相关防火墙
    + > 容器实现靠的是操作系统的 namespace,每个 namespace 有自己的路由和防火墙规则
    + > 默认所有操作都在 default namespace 中, 你直接执行 iptable-save 导出的是 default namespace 的防火墙规则
    + > default namespace 是系统中所有正常启动的进程所在的 namespace
    + > 你想获取容器中的防火墙规则,需要切换到指定容器对应的 namespace 中执行 iptable-save，具体的 namespace exce 命令随便查下就知道了
- > 防火墙本体是内核的 NetFilter 。iptables 是 mysql-cli, firewalld 是 navicat, ufw 是 heidisql
- > https://isno.github.io/chapter3/iptables-example.html
- > 最底层的是 NetFilter, 然后实际操作层是 iptables, 而 firewall 我认为是 iptables 命令简化版的 gui <br> ***作为 12 年的运维工程师，还是更偏向于 `iptables`*** <br> ***新生代更偏向于用 `firewall` ，因为命令更简单，通俗易懂***. <br> ***现在基于 ubuntu 的程序员更多，所以他们更喜欢用傻瓜相机版的 `ufw`***
- > ufw 不知道, filewall 本质还是 iptable <br> 比如 filewall 标准语法不能描述的规则都用 direct 实现, direct 里面都是 iptable 的语法 <br> 话说前端娱乐圈搞那么多状态管理.... linux 搞两三个防火墙管理怎么了！！才两三个你们就叫,写前端不得疯
- > `因为安装 linkerd 出现一个容器启动错误，说是没有 modprobe` --> 宿主机上把需要的内核模块先装上。用户态不同版本一般没关系。
- > netfilter 是个框架，iptables 是用户态工具(iptables 之类的命令）+内核模块（ `lsmod|grep -i ipt` )，在 netfilter 有几个 iptables 的 hook ，firewalld 就是一个 iptables 规则生成器。 <br> ***不过这个年代别学 `iptables` 了，马上就被 `nft` 替代了***，你看到的 iptables-legacy 就是传统 iptables ，***在新的发行版本里面 iptables 就是 nftable 的一层皮***

ubuntu 有什么命令可以关闭网络，不然上网的？ https://www.v2ex.com/t/885457
- > 禁用网卡驱动应该可以吧？ `ifconfig [网卡名称] Down/Up`
  >> 还是 v 友给力！现在的搜索引擎出来都是一个结果，还有内容农场。导致知识获取效率低下。
- > `iptables -A OUTPUT -o eth1 -j DROP`
- > 我不信 关掉它们还不行 `systemctl disable --now NetworkManager network`
  >> 是失败了，不知道为啥。用一楼的哥们的命令就可以了
- > 
  ```sh
  sudo ufw default deny incoming
  sudo ufw default deny outgoing
  sudo ufw default deny routed
  ```
- > 你直接把机器 IP 配成一个不可用的 IP 不就行了
- > 直接把网卡配置删除
- > 关网卡太暴力了，还是像 2 楼的防火墙控制一下吧… 你要想确保不能访问外网、但是可以访问内网的话也可以做到的
- > 推荐用 `ip` 命令 `sudo ip link set eth0 down`
- > 更加暴力点 `rmmod` 把网卡驱动卸了？或者破坏掉 `/proc` 中和网卡相关的？或者 `lspci` 看下网卡，把网卡所在的 `pci-e` 给干掉

同一个网段的两个 ip 无法互相 ping 通，可能是什么原因呢 https://www.v2ex.com/t/867960

`ethtool -i -1` 如何理解 https://www.v2ex.com/t/839421
```console
偶然一次项目中，用户要求使用 ethtool -i -1 ip -c 1000 来测试服务器之间丢包率，一直很不理解-i -1 这个参数的意义，求解。
```
- > -1 Drop the matched flow
- > https://man7.org/linux/man-pages/man8/ethtool.8.html

【[:star:][`*`]】 请教大佬一个关于网络的问题 https://www.v2ex.com/t/836870
```console
有两台机子，各自设置了静态 IP：
- A 机：ifconfig eth0 192.168.32.10 netmask 255.255.254.0
- B 机：ifconfig eth0 192.168.1.15 netmask 255.255.254.0

A 机 Ping B 机时，显示异常：
[root@test]# ping 192.168.1.15
PING 192.168.1.15 (192.168.1.15): 56 data bytes
ping: sendto: Network is unreachable

想问怎么才能在不改变 AB 机 IP 的情况下，让网络互通。 能不能通过 route 命令之类的方法？
```
- > 最省事的就是掩码改成 `255.255.192.0` ***从而在二层打通 `192.168.0.0 - 192.168.63.255` ，两个设备间可以走二层直接交付***。
  >> 十分感谢，可以用
- > 1.改掩码 2.加路由 二选一
- > 静态路由，上面敲错发出去了
  ```sh
  A 机：ip route add 192.168.0.0/23 dev eth0
  B 机：ip route add 192.168.32.0/23 dev eth0
  ```
- > 由于掩码是 23 位，A 机所在局域网 IP 地址范围是 `192.168.32.1 ~ 192.168.33.254` (0 和 255 一般不分配给主机)，B 机所在局域网 IP 地址范围是 `192.168.1.1 ~ 192.168.2.254` <br> 所以不是同一个 network ，网络不可达，无法 ping 通。解决方法既然要求了 “想问怎么才能在不改变 AB 机 IP 的情况下，让网络互通。”，就只能在 A 机上添加一条到 B 机 network 的静态路由（或者在 B 机器上添加 A 机器的 static route ）。
  ```sh
  ip route add 192.168.1.0/23 dev eth0
  ```
  > 注意掩码是 23 个。
- > 结案：
  ```console
  方法 1. @laozhoubuluo 的答案：两台机子的掩码都改成 255.255.192.0
  方法 2. @anyclue 的答案：两台机子都要设置静态路由
  A 机：ip route add 192.168.0.0/23 dev eth0
  B 机：ip route add 192.168.32.0/23 dev eth0
  ```

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
