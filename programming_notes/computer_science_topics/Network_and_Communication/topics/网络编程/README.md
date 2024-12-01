
# `select()`

网络通信基础重难点解析 专题介绍 https://github.com/lhy12315/easyserverdev
- 网络通信基础重难点解析 04 ：select 函数用法 https://github.com/lhy12315/easyserverdev/blob/master/%E7%BD%91%E7%BB%9C%E9%80%9A%E4%BF%A1%E5%9F%BA%E7%A1%80%E9%87%8D%E9%9A%BE%E7%82%B9%E8%A7%A3%E6%9E%90%2004%20%EF%BC%9Aselect%20%E5%87%BD%E6%95%B0%E7%94%A8%E6%B3%95.md

linux之select函数用法详解 https://developer.aliyun.com/article/10513

Linux 网络编程必知：深入理解 4 种 IO 网络模型 https://mp.weixin.qq.com/s/os_DV8rM-zPVIx5kHKLLQA
- > **一、什么是 IO ？**
- > **四、IO 多路复用（IO multiplexing）**
  * > `IO multiplexing` 这个词可能有点陌生，但是提到 `select/epoll`，大概就都能明白了。有些地方也称这种 IO 方式为`事件驱动 IO(event driven IO)`。我们都知道，***`select/epoll` 的好处就在于单个 process 就可以同时处理多个网络连接的 IO。它的基本原理就是 `select/epoll` 这个 function 会不断的轮询所负责的所有 socket，当某个 socket 有数据到达了，就通知用户进程***。它的流程如图：
  * > 当用户进程调用了 select，那么整个进程会被 block，而同时，kernel 会“监视”所有 select 负责的 socket，当任何一个 socket 中的数据准备好了，select 就会返回。这个时候用户进程再调用 read 操作，将数据从 kernel 拷贝到用户进程。
