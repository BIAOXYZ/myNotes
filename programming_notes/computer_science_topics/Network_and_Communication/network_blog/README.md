
为什么我在公司里访问不了家里的电脑 https://www.ithome.com/0/668/688.htm || https://mp.weixin.qq.com/s/TEWUmAoW50Mut3ImFThd5A
- 回复里的：
  * > `Parsec`，免费UDP点对点远程软件，带宽只取决于家里带宽和公司带宽，没有中转，延迟很低。
    >> 没有公网IP的话也能实现点对点传输？
    >>> 就是udp打洞的思路吧，不会parsec似乎也有一套自己的编码，反正用下来体验还好
    >>>> 这个真的超级好用, 三年前就开始用了, 不仅网络上优化好, 硬件上编解码也非常高效, 占用很低, 唯一缺点就是必须登录, 不能直接输入ip直连

为什么我们家里的 IP 都是 192.168 开头的 https://www.ithome.com/0/666/834.htm || https://mp.weixin.qq.com/s/DKqUtFXpne4GrEKSHqyKug
- 回复里的：
  * > 补充:中小型局域网用`192.168`和`172.16`只有一段。大型的普遍用`10.`段。特殊单位用A类地址，我们就是`125.`段。
    >> 公安网以前用`10`段的 现在改成`41`段了
  * > 码农路过。这玩意天天上班都要用科普下 常见私有地址分为三个 `10.0.0.0/8` `172.16.0.0/12` `192.168.0.0/16` 所以有这三个段的内网都是正常的。之前在某大厂摸鱼，设备之多，网络大到`10./8`都用完了，开始强制使用 ipv6 了
    >> 真大厂
    >>> 1千6百万个ip都用完了？

IPv4：超网，你是我的“神” https://www.ithome.com/0/654/991.htm || https://mp.weixin.qq.com/s/W7ORERpCqQD__5-KEcU64g

502 问题怎么排查？ https://www.ithome.com/0/653/236.htm || https://mp.weixin.qq.com/s/98Vr1MkFte7oZcQk2t-f_A  【from `小白debug`】
- > **HTTP 状态码**
  * > 一般来说，前端并不存储太多数据，大部分时候都需要从后端服务器那获取数据。于是前后端之间需要通过 TCP 协议去建立连接，然后在 TCP 的基础上传输数据。而 TCP 是基于数据流的协议，传输数据时，并不会为每个消息加入数据边界，直接使用裸的 TCP 进行数据传输会有 "粘包" 问题。
  * > ***比方说一切正常，那服务端返回个 `200` 状态码，前端收到后，可以放心使用响应的数据。<ins>但如果服务端发现客户端发的东西异常，就响应个 `4xx` 状态码，意思是这是个客户端的错误</ins>，`4xx` 里头的 xx 可以根据错误的类型，再细分成各种码，比如 `401` 是客户端没权限，`404` 是客户端请求了一个根本不存在的网页。反过来，<ins>如果是服务器有问题，就返回 `5xx` 状态码</ins>***。
  * > 但问题就来了。服务端都有问题了，搞严重点，服务器可能直接就崩溃了，那它还怎么给你返回状态码？是的，这种情况，服务端是不可能给客户端返回状态码的。所以说，**一般情况下 `5xx` 的状态码其实并不是服务器返回给客户端的**。它们是由网关返回的，常见的网关，比如 nginx。
- > **nginx 的作用**
  * > 像这种，**屏蔽掉具体有哪些服务器的代理方式就是所谓的反向代理**。
  * > 反过来，屏蔽掉具体有哪些客户端的代理方式，就是所谓的正向代理。
- > **服务端过早断开连接**
  * > 过早断开连接的原因常见的有两个。
  * > 第一个是，服务端设置的超时时间过短。不管是用的哪种编程语言，一般都有现成的HTTP库，服务端一般都会有几个timeout参数，比如golang的HTTP服务框架里有个写超时（`WriteTimeout`），假设设置了2s，那它的含义就是，服务端在收到请求后需要在2s内处理完并将结果写到响应中，如果等不到，就会将连接给断掉。
  * > 第二个原因，也是造成502状态码最常见的原因，就是服务端应用进程崩了（crash）。
  * > 除此之外你还通过下面的命令，看下进程上次的启动时间是什么时候。
    ```sh
    ps -o lstart {pid}
    ```
- > **总结**
  * > HTTP 状态码用来表示响应结果的状态，其中 200 是正常响应，4xx 是客户端错误，5xx 是服务端错误。
  * > 客户端和服务端之间加入 nginx，可以起到反向代理和负载均衡的作用，客户端只管向 nginx 请求数据，并不关心这个请求具体由哪个服务器来处理。
  * > 后端服务端应用如果发生崩溃，nginx 在访问服务端时会收到服务端返回的 RST 报文，然后给客户端返回 502 报错。502 并不是服务端应用发出的，而是 nginx 发出的。因此发生 502 时，后端服务端很可能没有没有相关的 502 日志，需要在 nginx 侧才能看到这条 502 日志。
  * > 如果发现 502，优先通过监控排查服务端应用是否发生过崩溃重启，如果是的话，再看下是否留下过崩溃堆栈日志，如果没有日志，看下是否可能是 oom 或者是其他原因导致进程主动退出。如果进程也没崩溃过，去排查下 nginx 的日志，看下是否将请求打到了某个不知名 IP 端口上。

为什么有 HTTP 协议，还要有 websocket 协议 https://www.ithome.com/0/645/884.htm  【from `小白debug`】

--------------------------------------------------

万字长文爆肝路由协议！ https://www.ithome.com/0/645/890.htm || https://mp.weixin.qq.com/s/1TRVhg1iiK0dNtV157yrQw  【from `程序员cxuan`】

--------------------------------------------------

最多能创建多少个 TCP 连接？ https://www.ithome.com/0/645/438.htm || https://mp.weixin.qq.com/s/X6c_H5_4OInR8nFQVn7IMA  【from `低并发编程`】

--------------------------------------------------

为什么服务端程序都需要先 listen 一下？ https://www.ithome.com/0/647/291.htm || https://mp.weixin.qq.com/s/hv2tmtVpxhVxr6X-RNWBsQ

图解 Linux 网络包接收过程 https://www.ithome.com/0/645/789.htm || https://mp.weixin.qq.com/s/GoYDsfy9m0wRoXi_NCfCmg

万字多图，搞懂 Nginx 高性能网络工作原理！ https://www.ithome.com/0/645/041.htm || https://mp.weixin.qq.com/s/AX6Fval8RwkgzptdjlU5kg

能将三次握手理解到这个深度，面试官拍案叫绝 https://www.ithome.com/0/644/953.htm || https://mp.weixin.qq.com/s/vlrzGc5bFrPIr9a7HIr2eA

图解 | 深入揭秘 epoll 是如何实现 IO 多路复用的 https://www.ithome.com/0/644/835.htm || https://mp.weixin.qq.com/s/OmRdUgO1guMX76EdZn11UQ

漫画 | 理解了 TCP 连接的实现以后，客户端的并发也爆发了 https://www.ithome.com/0/644/714.htm || https://mp.weixin.qq.com/s/ta6upubg0o1w03YGUo8Trg  【from `开发内功修炼`】

漫画 | 一台 Linux 服务器最多能支撑多少个 TCP 连接？ https://www.ithome.com/0/644/631.htm || https://mp.weixin.qq.com/s/Lkyj42NtvqEj63DoCY5btQ  【from `开发内功修炼`】
