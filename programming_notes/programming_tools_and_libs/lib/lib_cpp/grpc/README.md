
# gRPC官方

gRPC - An RPC library and framework https://github.com/grpc/grpc

gRPC – A high-performance, open source universal RPC framework https://grpc.io/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 官方文档

Guides https://grpc.io/docs/guides/
- https://grpc.io/docs/what-is-grpc/introduction/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# gRPC源码

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# gRPC系列教程

go-grpc-example，分为入门教程和进阶教程，包括请求超时设置、TLS认证、自定义方法认证、数据验证、拦截器、go-grpc-middleware、grpc-gateway和swagger、gRPC负载均衡等。附博客教程 https://www.cnblogs.com/FireworksEasyCool/category/1693727.html || https://github.com/Bingjian-Zhu/go-grpc-example
- Go gRPC教程-简单RPC（二） https://www.cnblogs.com/FireworksEasyCool/p/12674120.html
  * > 该方法需要传入RPC的上下文context.Context，它的作用结束超时或取消的请求。更具体的说请参考[该文章](https://blog.csdn.net/chinawangfei/article/details/86559975)
    + 理解Go的Context机制 https://blog.csdn.net/chinawangfei/article/details/86559975
- Go gRPC教程-双向流式RPC（五） https://www.cnblogs.com/FireworksEasyCool/p/12698194.html || https://github.com/Bingjian-Zhu/go-grpc-example/tree/master/5-both_stream_rpc || https://bingjian-zhu.github.io/2020/04/14/Go-gRPC%E6%95%99%E7%A8%8B-%E5%8F%8C%E5%90%91%E6%B5%81%E5%BC%8FRPC%EF%BC%88%E4%BA%94%EF%BC%89/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# gRPC语法

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# gRPC其他

关于 gRPC 的问题请教一下各位 https://www.v2ex.com/t/847144

gRPC 跑分分享(2022 03 15 bench results) https://www.v2ex.com/t/844350
```console
直接贴来源： https://github.com/LesnyRumcajs/grpc_bench/wiki/2022-03-15-bench-results
总结：
Rust 性能上天，资源利用高。
CPP 不落王者
Scala 机制优化
Java 依然强悍
Donet 有金主爸爸就是不一样
Golang 名列前茅
JavaScript 、PHP 、Ruby 洗洗睡了。
```
>> https://github.com/LesnyRumcajs/grpc_bench

gRPC的那些事 - streaming https://colobu.com/2017/04/06/dive-into-gRPC-streaming/ || https://github.com/smallnest/smallnest.github.io/blob/55327d81424aaa798705a006f7c6cbad81b860cb/2017/04/06/dive-into-gRPC-streaming/gRPC.png

gRPC双向数据流的交互控制（go语言实现）| gRPC双向数据流的交互控制系列(1) https://www.jianshu.com/p/5158d6686769

周末调试了 grpc C++ https://www.v2ex.com/t/797311
```console
层层封装，单步调试也没看出来 socket 收发是在哪里处理的。。。。
有比较熟的大神吗，指点一个
```
- > strace + pmap + pstack
- > 高级点，上 systemtap，自己写调试脚本。

gRPC 基础概念详解 https://mp.weixin.qq.com/s/I2QHEBO26nGqhGwIw281Pg || https://panzhongxian.cn/cn/2021/06/grpc-basic-concepts-note/ || https://zhuanlan.zhihu.com/p/389328756

## stub

桩 (计算机) https://zh.wikipedia.org/wiki/%E6%A1%A9_(%E8%AE%A1%E7%AE%97%E6%9C%BA)
- > 在远程方法调用（RMI）中将客户辅助对象称之为`Stub（桩）`；将服务辅助对象称之为`skeleton（骨架）`。
- > RMI的过程是：***客户对象一旦被调用，`客户对象`调用`stub`，`stub`调用网络远端的`skeleton`，而`skeleton`最终调用真正的`服务对象`***。由此，在调用客户对象的时候，感觉上就是直接调用了真正的服务对象。
  >> //notes：`gRPC` 里好像不用 `skeleton` 这个概念，应该是隐含了 `gRPC Server` 就包含了这部分。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 视频

[中英字幕] 完整的gRPC课程（The complete gRPC course [Golang, Java, Protobuf]） https://www.bilibili.com/video/BV1Xv411t7h5

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 个人实战
