
AWS 中国区域  »  服务运行状况控制面板 [Service Health Dashboard] https://status.amazonaws.cn/
> [RESOLVED] 错误率增高 | Increased Error Rates
>> 在北京时间2020年1月14日上午 9点49 分到11点 09分之间，CN-NORTH-1 （北京）区域 AWS 服务 API调用错误率上升以及延迟增大，以及 CN-NORTH-1 （北京） 和 CN-NORTHWEST-1 （宁夏区 ）AWS 控制台不能登录的问题。目前问题已经解决，服务已经回复正常。 | Between 5:49 PM and 7:09 PM PST we experienced increased error rates and latencies for AWS Service APIs in the CN-NORTH-1 Region and authentication failures for the AWS Management Console in the CN-NORTH-1 and CN-NORTHWEST-1 Regions. The issue has been resolved and the service is operating normally.

# AWS EMR

## 官方

Amazon EMR 功能 https://aws.amazon.com/cn/emr/features/

Amazon EMR 入门 https://aws.amazon.com/cn/emr/getting-started/

Amazon EMR 概览 https://docs.aws.amazon.com/zh_cn/emr/latest/ManagementGuide/emr-overview.html

教程：Amazon EMR 入门 https://docs.aws.amazon.com/zh_cn/emr/latest/ManagementGuide/emr-gs.html

Amazon EMR实战心得浅谈 https://aws.amazon.com/cn/blogs/china/brief-introduction-to-emr-practical-experience/

## 其他

AWS云VS阿里云 EMR 横向对比 - WuKongCoder的文章 - 知乎 https://zhuanlan.zhihu.com/p/624081156
- > **AWS EMR on Outposts**
  * > 这种解决方案目前阿里云还没有跟进，Outposts可以理解为，一些大一点的厂商，希望用AWS云的服务同时又很看重数据安全性，AWS可以支持在厂商的数据中心部署一整天AWS服务，但是网络是和外部隔离的，安全性更有保障，EMR on Outposts也就是可以在自己的数据中心中，使用AWS EMR服务。
- > **节点类型**
  * > Core 节点：可以理解为 Hadoop DataNode ，HDFS存储的位置，同时也提供计算资源，***但是EMR集群的使用中，一般不会把重要数据存储在这里，云上都是计算存储分离，AWS云提供S3 对象存储，阿里云提供OSS对象存储，所以正确用法，只使用EMR的计算资源，HDFS只存储临时日志或者提交任务的相关依赖文件。这样就只会挂少量的云盘存储，节省存储费用***。Core节点一般只需要少量固定数量就可以，同时需要注意Core节点不适合缩容，所以注意不要设置过大。

开源大数据平台 E-MapReduce https://help.aliyun.com/zh/emr/

## AWS EMR Flink

Apache Flink https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-flink.html

How to Setup Pyflink on Amazon EMR https://medium.com/@nesreensada/how-to-setup-pyflink-on-amazon-emr-bb466fbcfc6e
