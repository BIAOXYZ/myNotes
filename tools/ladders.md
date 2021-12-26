
# articles

2019年翻墙方法大合集，包含安卓及IOS翻墙 https://www.hwboke.com/24689.html

翻墙方法简介 https://wordpresshi.com/shawdowsocks-centos/

# VPN

SetupVPN http://desktopclient.net/gw/index.html#/ || https://setupvpn.com/download/
- > 重要的：我们确实有两个版本的桌面客户端，0.4.0版本是用登录和密码登录，而0.5.0及以上的版本只支持authcode。只支持0.5.0及以上版本的注册。

Lantern https://github.com/getlantern/download

Security you can rely on. A name you can trust. https://vpn.mozilla.org/
- > Available in 6 countries now. More regions coming soon.
  * > We currently offer Mozilla VPN in the US, the UK, Canada, New Zealand, Singapore and Malaysia.

双十一别人在买买买，我在被客服“制裁” https://www.v2ex.com/t/725109
- > 这年头找一个好用的机场太难了，当初也想过买 rixcloud 来着，但是差评太多望而却步

# DNS

Simple DNSCrypt https://www.simplednscrypt.org/

--------------------------------------------------

谷歌公共DNS正式支持DoH加密 更安全并且不影响速度 - Google 谷歌 - cnBeta.COM https://www.cnbeta.com/articles/tech/807293.htm
-  ```
   附谷歌公共DNS地址：

   IPv4：8.8.8.8 / 8.8.4.4 IPv6：2001:4860:4860::8888 / 2001:4860:4860::8844 斜杠前后分别为主要DNS和备用DNS，
   用户使用时请在DNS配置的第一栏和第二栏里分别填写主要地址和备用地址。
   ```

网速变慢？你可能需要先设置好 DNS | 科普 https://sspai.com/post/42125

公共 DNS 性能大比拼：1.1.1.1 vs 8.8.8.8 vs 9.9.9.9 https://mp.weixin.qq.com/s/-Hj8zhe0vujQQlePkNDbhw

## DoH and DoT

腾讯云 DNS 方案 DoH 和 DoT 开始公测 https://www.ithome.com/0/499/992.htm
- > DoT 全称是 DNS over TLS，它使用 TLS 协议来传输 DNS 协议。TLS 协议是目前互联网最常用的安全加密协议之一，我们访问 HTTPs 的安全基础就是基于 TLS 协议的。相比于之前使用无连接无加密的 UDP 模式，TLS 本身已经实现了保密性与完整性。
- > DoH 全称是 DNS over HTTPs，它使用 HTTPs 来传输 DNS 协议。DoH 的安全原理与 DoT 一样，他们之间的区别只在于：DoH 有了 HTTP 格式封装，更加通用。
- > PC 端教程：
  * > 让 DNSPod 保护您的网页安全也非常简单，如果您使用的是 Chrome 浏览器（83 及以上），只需要在 Chrome 浏览器的设置项中设置好 DNS 访问安全选项即可。操作步骤如下：
    ```console
    进入到 Chrome 浏览器设置页面，在设置搜索框中搜索 DNS。

    1：点击搜索结果中的 “安全”，往下拉，就能看到 DNS 安全设置。
    2：输入 DNS 安全服务提供商地址：https://doh.pub/dns-query
    ```
  * > 使用 FireFox 也可轻松设置，与 Chrome 步骤类似。进入到设置页面，搜索 “dns”，点击 “网络设置”，下拉后勾选 “DNS over HTTPS“，输入 DNS 安全服务商地址 https://doh.pub/dns-query 即可。

# hosts

镜像：https://coding.net/u/scaffrey/p/hosts/git https://github.com/googlehosts/hosts

完美解决github访问速度慢 - 月正明的文章 - 知乎 https://zhuanlan.zhihu.com/p/93436925

github 改host - 闪电侠的右手的文章 - 知乎 https://zhuanlan.zhihu.com/p/339927339

GitHub520 https://github.com/521xueweihan/GitHub520

# IPV6

IT之家网友：快速获取教育网IPv6独享地址教程 https://www.ithome.com/0/406/684.htm

# extensions

SetupVPN - Lifetime Free VPN https://chrome.google.com/webstore/detail/setupvpn-lifetime-free-vp/oofgbpoabipfcfjapgnbbjjaenockbdp
> http://desktopclient.net/gw/index.html#/setupvpn

uVPN - free and unlimited VPN for everyone https://chrome.google.com/webstore/detail/uvpn-free-and-unlimited-v/coahpcpgfnnaddeelpphpifmgfobflog
> Secure your everyday Web routine with Unlimited VPN http://unlimitedvpn.net/

Betternet Unlimited Free VPN Proxy https://chrome.google.com/webstore/detail/betternet-unlimited-free/gjknjjomckknofjidppipffbpoekiipm
> http://betternet.co/

# others

蓝灯最新版本下载 (https://github.com/getlantern/download) https://github.com/getlantern/lantern

shadowsocks-windows https://github.com/shadowsocks/shadowsocks-windows/releases

firefly-proxy https://github.com/yinghuocho/firefly-proxy/releases
