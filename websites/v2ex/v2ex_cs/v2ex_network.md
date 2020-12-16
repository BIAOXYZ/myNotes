
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
