
TLS 协议分析与工程视角的密码学应用 https://0xffff.one/d/1168-tls-xie-yi-fen-xi-yu-gong-cheng-shi

一篇讲 TLS 的好文分享 https://0xffff.one/d/968-yi-pian-jiang-tls-de-hao-wen-fen
- > 刚好可以和[这一帖](https://0xffff.one/d/1168-tls-xie-yi-fen-xi-yu-gong-cheng-shi)联系在一块
- > TLS 握手过程确实可能会更多的延迟，想起有看到一篇讲腾讯云的负载均衡网关 CLB 的 STGW 的 文档，介绍说他们会用 SSL 加速卡去专门加速相关密码学运算，在网关层面把 tls 加密的流量卸载为明文，再内部传输到目标服务（内部服务之间通常很少会有加密的需要）。
