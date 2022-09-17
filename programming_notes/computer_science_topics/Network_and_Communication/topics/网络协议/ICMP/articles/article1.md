
# 1

能 Ping 通，TCP 就一定能连通吗？ https://www.ithome.com/0/641/433.htm || https://mp.weixin.qq.com/s/fb2uUWz5ZjPEfYv_l6e4Zg
- > 基于 **Dijkstra 算法**，封装出了一个新的协议，**OSPF 协议**（Open Shortest Path First, 开放最短路径优先）。
- > 有了 OSPF，路由器就得到了网络图里自己到其他点之间的最短距离，于是就知道了数据包要到某个点，该走哪条最优路径。
- > 将这些信息汇成一张表，也就是我们常说的**路由表**。
- > 路由表里记录了到什么 IP 需要走什么端口，以及走这条路径的成本（metric）。
- > 可以通过 `route` 命令查看到。
- > 本文来自微信公众号：小白 debug （ID：xiaobaidebug）： https://mp.weixin.qq.com/s/fb2uUWz5ZjPEfYv_l6e4Zg
