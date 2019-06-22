
### Tomcat

tomcat 与 nginx，apache的区别是什么？ - 知乎用户的回答 - 知乎 https://www.zhihu.com/question/32212996/answer/87524617
- Java Servlet简介 https://www.tianmaying.com/tutorial/servlet-intro

Tomcat那些事儿 https://zhuanlan.zhihu.com/tomcat

### Communication

云、CDN、IDC 三个概念的区别是什么？有什么相互包含和影响。。 - 知乎 https://www.zhihu.com/question/40534161

能让手机偷偷转账的“伪基站” 是个什么玩意儿 - 通信技术 - cnBeta.COM https://www.cnbeta.com/articles/tech/754469.htm

### QUIC and HTTP/3

下一代HTTP底层协议将弃用TCP协议 改用QUIC技术 - 软件和应用 - cnBeta.COM https://www.cnbeta.com/articles/tech/787877.htm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# http

一次完整的HTTP请求与响应涉及了哪些知识？ https://www.jianshu.com/p/c1d6a294d3c0

TCP 连接断连问题剖析 https://www.ibm.com/developerworks/cn/aix/library/0808_zhengyong_tcp/index.html

HTTP长连接和短连接 https://www.cnblogs.com/0201zcr/p/4694945.html

HTTP Keep-Alive模式 https://www.cnblogs.com/skynet/archive/2010/12/11/1903347.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## http related RFC's

Hypertext Transfer Protocol -- HTTP/1.1 https://www.ietf.org/rfc/rfc2616.txt

HTTP协议(rfc2626)中文翻译(修订版) http://www.blogjava.net/sunchaojin/archive/2009/05/31/279164.html --> 这作者把2616写成2626了。。。
> 超文本传输协议-HTTP/1.1（修订版）---译者：孙超进 http://files.blogjava.net/sunchaojin/http1.3.pdf

## httpd

Is there any difference between apache2 and httpd? https://askubuntu.com/questions/248404/is-there-any-difference-between-apache2-and-httpd
- > httpd is the same as apache2. It depends on the OS you use. For example in RHEL 6.2 it is called httpd and in Ubuntu it is called apache2.
- > TL;DR
  >> They are the same application - just that some Linux distributions refer to it differently within package managers and config files. RedHat-based distros (CentOS, Fedora) refer to it as httpd while Debian-based distros (Ubuntu) refer to it as apache. Gentoo, strangely enough, mostly refers to it as apache - but config files have httpd in the naming conventions.
  > 
  > Background
  >> The application's development is managed by the Apache Foundation. Its name is actually Apache HTTP Server. It is often also called Apache httpd (http daemon) by the Apache Foundation. Colloquially, Unix admins have historically called it Apache and, even with the RedHat-based distributions, everyone already knows what you're referring to when you simply say Apache.
```
结论就是没有区别，就一回事，只是叫法不一样而已。关于这个apache起名字的叽歪事，那可不止这一件：
```

Apache HTTP服务器 https://zh.wikipedia.org/wiki/Apache_HTTP_Server
> 命名
>> 作者宣称因为Apache这个名字好记，所以才在最初选择它，但是流传最广的解释是（也是最显而易见的）：这个名字来自于一个事实：当Apache在1995年初开发的时候，它是由当时最流行的HTTP服务器NCSA HTTPd 1.3的代码修改而成的，因此是“一个修补的（a patchy）”服务器。然而，在Apache服务器官方网站的FAQ中是这么解释的：“Apache这个名字是为了纪念名为Apache的美洲原住民印第安人的一支，众所周知他们拥有高超的作战策略和无穷的耐性。”贝伦多夫说：“我选择阿帕奇这个名字是取其积极含义。阿帕奇族是最后一个屈服于美国政府的民族。当时我们担心大公司迟早会参与竞争并‘教化’这块最早的网络之地，所以在我看来，阿帕奇是个很好的名称，也有人说这个词一语双关-因为正如Apache（与"a patchy"谐音）的名字所表明的那样，他们确实是在给服务器打补丁。”无论如何，Apache 2.x分支不包含任何NCSA的程序代码。
>>> [Apache软件基金会](https://zh.wikipedia.org/wiki/Apache%E8%BD%AF%E4%BB%B6%E5%9F%BA%E9%87%91%E4%BC%9A)wikipedia页面也有提到这点————很正常，毕竟apache（或者更准确地说`Apache HTTP Server`）是Apache Software Foundation命名的来源啊，相当于炮姐之于B站（bilibili）。
>>>> 这个命名是根据北美当地的一支印第安部落而来，这支部落以高超的军事素养和超人的忍耐力著称，19世纪后半期对侵占他们领土的入侵者进行了反抗。为了对这支印第安部落表示敬仰之意，取该部落名称（Apache）作为服务器名。但一提到这个命名，这里还有流传着一段有意思的故事。因为这个服务器是在NCSA HTTPd服务器的基础之上，通过众人努力，不断地修正、打补丁（Patchy）的产物，被戏称为“A Patchy Server”（一个补丁服务器）。在这里，因为“A Patchy”与“Apache”是谐音，故最后正式命名为“Apache Server”。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# others

### localhost versus 127.0.0.1

- localhost、127.0.0.1 和 本机IP 三者的区别? - 知乎 https://www.zhihu.com/question/23940717
- What is the difference between 127.0.0.1 and localhost https://stackoverflow.com/questions/7382602/what-is-the-difference-between-127-0-0-1-and-localhost
- What is the difference between 127.0.0.1 and my assigned IPv4 address? https://superuser.com/questions/897699/what-is-the-difference-between-127-0-0-1-and-my-assigned-ipv4-address

### loopback

What is the loopback device and how do I use it? https://askubuntu.com/questions/247625/what-is-the-loopback-device-and-how-do-i-use-it
- > This is important for troubleshooting (it can be compared to looking in a mirror). The loopback device is sometimes explained as purely a diagnostic tool. But it is also helpful when a server offering a resource you need is running on your own machine.
- > For IPv4, the loopback interface is assigned all the IPs in the 127.0.0.0/8 address block. That is, 127.0.0.1 through 127.255.255.254 all represent your computer. For most purposes, though, it is only necessary to use one IP address, and that is 127.0.0.1. This IP has the hostname of localhost mapped to it.

### IP，子网掩码，默认网关，DNS等

- [ ] 如何理解子网掩码中的“子网”？ - 知乎 https://www.zhihu.com/question/21064101

- [x] IP地址，子网掩码，默认网关，DNS服务器详解 https://www.cnblogs.com/JuneWang/p/3917697.html

- [x] 计算机网络: IP地址，子网掩码，网段表示法，默认网关，DNS服务器详解 https://www.cnblogs.com/iceJava/p/5372033.html

### /etc/resolv.conf

Linux resolv.conf简介 https://blog.csdn.net/K346K346/article/details/83790044

resolv.conf在Linux系统中的作用 https://blog.csdn.net/longcheng217/article/details/81316877

### IPVS

IP Virtual Server https://en.wikipedia.org/wiki/IP_Virtual_Server

Linux负载均衡--LVS（IPVS） https://www.jianshu.com/p/36880b085265

