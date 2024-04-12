
今天咱也用 rust 实现一个 redis 的 demo,性能差不多。[第二弹] https://www.v2ex.com/t/1031987

今天咱也用 rust 实现一个 redis 的 demo,性能差不多。 https://v2ex.com/t/1029385
```console
源码
https://github.com/lsk569937453/rcache

本地压测 docker-compose.yml
用户可以本地启动 docker-compose 来进行压测。

https://github.com/lsk569937453/rcache/blob/main/docker-compose/docker-compose.yml
```
- > 对于这种 IO 性的网络应用，很多开销是在网络协议栈里，对于一些简单的 case ，不如用 DPDK 去实现，性能更高，参考 dperf ，整机可以达到 8 千万新建每秒，吞吐 800Gbps ，几十亿并发。 https://dperf.org/
- > 你使用的是 `mpsc::channel` ，这就相当于一把锁，读写冲突下跟单线程当然没有优势 <br> 多线程情况下可以采用多种方式优化读写锁冲突，缓存的读是远大于写的其实优化空间更大 <br> 我用 rust 实现的 redis 轻松 10 倍

关于用 Redis 限制用户行为频率的方法，麻烦 V 友帮看看 https://www.v2ex.com/t/657135
