
基于对象存储构建数据库、消息系统等基础软件已经成为一种新趋势了吗？ https://www.v2ex.com/t/1023663
```console
消息系统
- Confluent: 兑现了 Kafka KIP-405 的分层存储能力，将大量数据存储到 S3 来缓解其数据复制的压力和降低存储成本。
- WarpStream: 闭源产品，兼容 Kafka API 的一个 Kafka 替代品，完全将 S3 上作为主存储。
- Redpanda: 开源产品，可以看作是 Kafka 的一个 rust 实现版本，存储层也实现了和 Confluent 类似的分层存储来降本。
- AutoMQ: 国人的开源产品，对 Kafka 底层存储做重新改造实现了一个存算分离的 Kafka 。底层也依赖对象存储作为主存储来进行降本。
- Pulsar: 国人的开源产品。前面的都算 Kafka 生态的，这个属于自建生态。主打一个存算分离，也支持将数据卸载给对象存储来降本。
- RocketMQ: 国人开源产品，在阿里在线业务大面积应用而发扬光大。5.x 冷热分离后也实现了类似 Kafka 的二级存储，冷数据可以利用对象存储降本。

数据库
- Snowflake: 应该是云原生基础软件的标杆产品，算是最早开始充分挖掘对象存储无限容量、弹性、低成本潜力的企业了
- TiDB: 23 年开始应该也是洞悉到了这个趋势，后来推出了基于 S3 对象存储的 TiDB Serverless

其他还有很多软件，你看他们软件迭代的 roadmap ，基于都可以观察到，对象存储重塑基础软件似乎已经成为了一个潮流。不过仔细想想，这也合理，对象存储提供了太多优异的特质了：
- 无限的存储容量：无限扩展的容量
- 近乎无限的吞吐：几十 GB/s 的吞吐（不够可以找云厂商再开 limit ）
- 极致弹性，pay-as-you-go: 按照 API 、实际存储容量来按需收费。用多少花多少钱
- 内建免费的跨 zone 多副本容灾：内建可用区容灾的能力，而且免流量费。基于对象存储构建具备跨可用区容灾能力的应用将会非常轻松。
- 极低的存储存本：相比其提供的技术能力来看，其存储成本非常低，比 SSD 有一个数量级的成本优势
```
- > 其实主要还是为了适应 Serverless 的趋势，上云降本增效。
  >> 是的，本质是对象存储是一个非常好的弹性基础存储设施。不过云下也不是不能做，自己用 minio 这类开源对象存储解决方案成本也比使用 ssd 低廉的多。
- > 云场景、实时性要求不高的场景有成本和灵活性优势，非云场景或者实时性要求高的场景就不适合了
  >> 实时性要求高可以配合小容量的云盘来做软件设计呀。小容量的 SSD （小于 10GB ）每个月就几十块，automq 就是这么干的。非云场景本质和云是一样的，只不过是私有云，没有云规模化的技术红了和成本优势。自建机房自己配 minio+ssd 也一样的。
- > 我再补充两个有意思的项目：
  ```console
  1. neon： https://github.com/neondatabase/neon
  2. dolt： https://github.com/dolthub/dolt
  ```
  * > 里面基于对象存储做了很多数据共享方面的产品创新。云计算聚集了超大的规模，“无限容量”的低成本对象存储将成为数据密集型软件的唯一选择，同时基于共享存储的各类数据互通，格式互认，甚至完全的 Zero ETL 都正在发生。
- > 把软件架构里部非随机、非高密读写的存储功能放到对象存储，大概是最具有可操作性的云原生化了。 <br> 一个软件系统里真需要高频随机读写，不能日志化的操作，其实不会很多的。
- > 补充下：redpanda 是 C++写的，不是 rust ，上面写的有误更正下

Linux 下，大存储(84Tb)选什么文件系统好？ https://www.v2ex.com/t/865940
- > 盘多的话 zfs ，盘少随意
- > openzfs
- > 一般的话 ext4 xfs 都行，zfs 的话需要大内存 ECC 内存条，要求高些。
  >> 12 个 16T 的机械硬盘做的 raid10 用 H710min 卡做的 <br> 内存有很多。几百个 G 都有。
  >>> zfs 属于软 raid ，一般用 hba 卡。如果硬 raid 就没必要用这个文件系统了，ext4 xfs 都可以
- > xfs 正解
- > 别用 ext4 ，没 xfs 稳定
- > min.io 最好了解一下，万一要扩呢。
