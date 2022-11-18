
# RDMA

Remote direct memory access https://en.wikipedia.org/wiki/Remote_direct_memory_access || 远程直接内存访问 https://zh.wikipedia.org/wiki/%E8%BF%9C%E7%A8%8B%E7%9B%B4%E6%8E%A5%E5%86%85%E5%AD%98%E8%AE%BF%E9%97%AE
- > 在数据中心领域，远程直接内存访问（英语：remote direct memory access，RDMA）是一种绕过远程主机操作系统内核访问其内存中数据的技术，由于不经过操作系统，不仅节省了大量CPU资源，同样也提高了系统吞吐量、降低了系统的网络通信延迟，尤其适合在大规模并行计算机集群中有广泛应用。在基于NVMe over Fabric的数据中心中，RDMA可以配合高性能的NVMe SSD构建高性能、低延迟的存储网络。

深入浅出全面解析RDMA - 围城的文章 - 知乎 https://zhuanlan.zhihu.com/p/37669618

RDMA技术详解（一）：RDMA概述 - 围城的文章 - 知乎 https://zhuanlan.zhihu.com/p/55142557

RDMA 能给数据中心带来什么 https://www.ithome.com/0/654/857.htm || https://mp.weixin.qq.com/s/1h6kX9HUR6mBHqIw0LWkzw
- > **数据中心现状**
  * > 在数据中心内，70% 的流量为东西向流量（服务器之间的流量），这些流量一般为数据中心进行高性能分布式并行计算时的过程数据流，通过 TCP / IP 网络传输。如果服务器之间的 TCP / IP 传输速率提升了，数据中心的性能自然也会跟着提升。
- > **服务器间的 TCP / IP 传输**
  * > 在数据中心，服务器 A 向服务器 B 发送数据的过程如下：![](https://img.ithome.com/newsuploadfiles/2022/11/973c3ef4-9d13-48e3-8fe6-f40284c44da5.png)
  * > 从数据传输的过程可以看出，数据在服务器的 Buffer 内多次拷贝，在操作系统中需要添加 / 卸载 TCP、IP 报文头，这些操作既增加了数据传输时延，又消耗了大量的 CPU 资源，无法很好得满足高性能计算的需求。那么，如何构造高吞吐量、超低时延和低 CPU 开销的高性能数据中心网络呢？RDMA 技术可以做到。
- > **什么是 RDMA**
  * > RDMA（ Remote Direct Memory Access，远程直接地址访问技术 ）是一种新的内存访问技术，可以让服务器直接高速读写其他服务器的内存数据，而不需要经过操作系统 / CPU 耗时的处理。
  * > RDMA 将服务器应用数据直接由内存传输到智能网卡（固化 RDMA 协议），由智能网卡硬件完成 RDMA 传输报文封装，解放了操作系统和 CPU。![](https://img.ithome.com/newsuploadfiles/2022/11/4210deef-a2bd-4bee-8881-be68b30f7d24.png)
  * > 这使得 RDMA 具有两大优势：
    + > Zero Copy（零拷贝）：无需将数据拷贝到操作系统内核态并处理数据包头部的过程，传输延迟会显著减小。
    + > Kernel Bypass（内核旁路）和 Protocol Offload（协议卸载）：不需要操作系统内核参与，数据通路中没有繁琐的处理报头逻辑，不仅会使延迟降低，而且也大大节省了 CPU 的资源。
- > **三大 RDMA 网络**
  * > 目前，大致有三类 RDMA 网络，分别是 `InfiniBand`、`RoCE`（RDMA over Converged Ethernet，RDMA 过融合以太网）和 `iWARP`（RDMA over TCP，互联网广域 RDMA 协议）。***RDMA 最早专属于 Infiniband 网络架构，从硬件级别保证可靠传输，而 RoCE 和 iWARP 都是基于以太网的 RDMA 技术***。
  * > InfiniBand
    + > InfiniBand 是一种专为 RDMA 设计的网络。
    + > 采用 Cut-Through 转发模式（直通转发模式），减少转发时延。
    + > 基于 Credit 的流控机制（基于信用的流控机制），保证无丢包。
    + > 要求 InfiniBand 专用的网卡、交换机和路由器，建网成本最高。
  * > RoCE
    + > 传输层为 InfiniBand 协议。
    + > RoCE 有两个版本：RoCEv1 基于以太网链路层实现，只能在 L2 层传输；RoCEv2 基于 UDP 承载 RDMA，可部署于三层网络。
    + > 需要支持 RDMA 专用智能网卡，不需要专用交换机和路由器（支持 ECN / PFC 等技术，降低丢包率），建网成本最低。
  * > iWARP
    + > 传输层为 iWARP 协议。
    + > iWARP 是以太网 TCP / IP 协议中 TCP 层实现，支持 L2 / L3 层传输，大型组网 TCP 连接会消耗大量 CPU，所以应用很少。
    + > iWARP 只要求网卡支持 RDMA，不需要专用交换机和路由器，建网成本介于 InfiniBand 和 RoCE 之间。
  * > Infiniband 技术先进，但是价格高昂，应用局限在 HPC 高性能计算领域，随着 RoCE 和 iWARPC 的出现，降低了 RDMA 的使用成本，推动了 RDMA 技术普及。
  * > 在高性能存储、计算数据中心中采用这三类 RDMA 网络，都可以大幅度降低数据传输时延，并为应用程序提供更高的 CPU 资源可用性。其中 InfiniBand 网络为数据中心带来极致的性能，传输时延低至百纳秒，比以太网设备延时要低一个量级。RoCE 和 iWARP 网络为数据中心带来超高性价比，基于以太网承载 RDMA，充分利用了 RDMA 的高性能和低 CPU 使用率等优势，同时网络建设成本也不高。基于 UDP 协议的 RoCE 比基于 TCP 协议的 iWARP 性能更好，结合无损以太网的流控技术，解决了丢包敏感的问题，RoCE 网络已广泛应用于各行业高性能数据中心中。
