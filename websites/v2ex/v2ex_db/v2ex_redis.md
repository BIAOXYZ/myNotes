
线上服务 redis 查询超时排查求教 https://www.v2ex.com/t/1058091
```console
一年前给某单位做了个门户类的服务，SpringBoot 项目，单节点 redis 、mysql 当时就是几个人瞎写，堆成一堆屎山，现在不知道为什么几乎每隔一两周 redis 都会查询超时，服务报错： java.lang.RuntimeException: org.springframework.dao.QueryTimeoutException: Redis command timed out; nested exception is io.lettuce.core.RedisCommandTimeoutException: Command timed out after 10 second(s) 稍微有点头绪的话就是有个功能会往 redis 里存大量的数据，使用的是 map ，并且取的频率还是挺高的，但是不知道该怎么确定就是这个错，没法找到证据 线上排错这方面自己也没经验，请问应该怎么入手
```
- > 可能是大 key 太多，导致操作缓慢，可以搞个主从读写分离或者 cluster ，看看是不是内存占满了 开启 lru 也会变慢
- > 具体分析一下这个请求包有没有发出去，看是哪里耗时过多了
- > 1.redis 有慢查询 log ；2.首先要排查有没有 `keys *` 查询；
- > https://redis.io/docs/latest/commands/slowlog-get/

Redis 加上密码后，整体性能下降 20%？ https://www.v2ex.com/t/1040022
- > 真的吗？我本地测了一下，不保证正确
  >> 我去，厉害了...怎么做到的，老哥有脚本啥的吗
  >>> redis 自带的 redis-benchmark
- > redis 是基于 TCP 协议的啊，握手(验证密码)之后就一直保持长连接，后续都是处理指令了啊。
- > 使用 redis 密码建议使用长连接；保持 session 。短连接每次新建连接都都需要 auth
- > 长连接就好了，只需要第一次发送 AUTH 命令
- > 去看看 RESP 协议就知道了，非常简单的，就是一来一回，没有额外的东西的，密码验证只需要 tcp 连接建立后 auth 一下，后面跟没有密码是一样的

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
