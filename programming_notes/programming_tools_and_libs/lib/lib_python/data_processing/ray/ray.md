
# 官方

ray-project https://github.com/ray-project
- Ray https://github.com/ray-project/ray
- KubeRay https://github.com/ray-project/kuberay
  * > KubeRay is an open source toolkit to run Ray applications on Kubernetes. It provides several tools to simplify managing Ray clusters on Kubernetes.
- Ray Educational Materials https://github.com/ray-project/ray-educational-materials
- RayFed https://github.com/ray-project/rayfed

Welcome to the Ray documentation https://docs.ray.io/en/latest/
- Ray Clusters Overview https://docs.ray.io/en/master/cluster/getting-started.html

# 其他

Ray 分布式计算框架介绍 - lipi的文章 - 知乎 https://zhuanlan.zhihu.com/p/111340572

Ray从理论到实战 - xiedidan的文章 - 知乎 https://zhuanlan.zhihu.com/p/460189842
- > Ray的使用非常简洁直接。可以用Ray Cli拉起集群：
  ```sh
  ray start --head
  ```
  > 这样就启动了head node，Ray的head node只是多了几个管理进程，***如果head node死掉之后，整个集群都挂掉了***。与Spark不同，Ray任务可以从集群中任意一台机器发起（***也可以从集群外发起***，比如你笔记本上的Jupyter）。
- > 启动head node之后它会直接告诉你怎样启其它节点和连接集群，照做即可：

How Ray Uses gRPC (and Arrow) to Outperform gRPC https://medium.com/distributed-computing-with-ray/how-ray-uses-grpc-and-arrow-to-outperform-grpc-43ec368cb385

Ray for the Curious https://medium.com/distributed-computing-with-ray/ray-for-the-curious-fa0e019e17d3

# ray 实践

字节跳动基于 Ray 的大规模多模态数据处理框架 https://mp.weixin.qq.com/s/PtlQ-SYQKTNXY8kAhsZhbA
- > RayCore 提供了强大的分布式计算能力，比如Actor、Task，使用RayCore可以方便的开发分布式应用程序，构建数据处理pipeline。但是RayCore提供的是low level的API，直接使用它进行开发需要自行处理很多问题，包括不限于：1) 数据切片和分片管理，需要手动管理数据分片和分布，这无疑增加了复杂性；2）数据读取和加载效率低的问题，缺乏高效的自动化数据读取和加载机制，会影响整体效率；3）缺乏高级数据操作功能，需要手动实现常见的数据操作，开发成本高。
- > 所以我们开始在Pipeline中使用`RayData`，它提供了一系列开箱即用的算子，和丰富的多模态数据DataSource支持，自动管理数据分片能力，同时具有自动扩缩容的能力，极大的减少了开发成本。
