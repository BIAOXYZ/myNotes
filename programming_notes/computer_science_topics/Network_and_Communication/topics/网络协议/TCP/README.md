
图解 | 你管这破玩意儿叫 TCP？ https://www.ithome.com/0/642/946.htm || https://mp.weixin.qq.com/s/Uf42QEL6WUSHOwJ403FwOA  【from `低并发编程`】

用了 TCP 协议，就一定不会丢包吗？ https://www.ithome.com/0/641/703.htm || https://mp.weixin.qq.com/s/8cXYXAHZCJMPSaaMpDqYtQ

【from `小白debug`】 既然有 HTTP 协议，为什么还要有 RPC https://www.ithome.com/0/641/957.htm || https://mp.weixin.qq.com/s/0QWxFylodn7T6nvcS6HsDg
- > **使用纯裸 TCP 会有什么问题**
  * > 八股文常背，TCP 是有三个特点，**面向连接、可靠、基于字节流**。
  * > 正因为这个没有**任何边界**的特点，所以当我们选择使用 TCP 发送 "夏洛" 和 "特烦恼" 的时候，接收端收到的就是 "夏洛特烦恼"，这时候接收端没发区分你是想要表达 "夏洛"+"特烦恼" 还是 "夏洛特"+"烦恼"。
  * > 这就是所谓的**粘包问题**，之前也写过一篇专门的文章聊过这个问题。
- > **既然有 HTTP 协议，为什么还要有 RPC？**
- > **HTTP 和 RPC 有什么区别**
  * > 首先要向某个服务器发起请求，你得先建立连接，而建立连接的前提是，你得知道 **IP 地址和端口**。这个找到服务对应的 IP 端口的过程，其实就是**服务发现**。
  * > 在 HTTP 中，你知道服务的域名，就可以通过 DNS 服务去解析得到它背后的 IP 地址，默认 80 端口。
  * > 而 RPC 的话，就有些区别，一般会有专门的中间服务去保存服务名和 IP 信息，比如 consul 或者 etcd，甚至是 redis。想要访问某个服务，就去这些中间服务去获得 IP 和端口信息。由于 dns 也是服务发现的一种，所以也有基于 dns 去做服务发现的组件，比如 CoreDNS。
