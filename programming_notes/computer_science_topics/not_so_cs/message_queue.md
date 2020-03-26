
# MQ general

消息队列和 RocketMQ 入门总结 https://mp.weixin.qq.com/s/eXzq5jg-2KkKziSPkcSQ5Q

# celery

Celery (software) https://en.wikipedia.org/wiki/Celery_(software)

Distributed Task Queue (development branch) http://celeryproject.org
> https://github.com/celery/celery

# Kafka

kafka解决了什么问题? - 知乎 https://www.zhihu.com/question/53331259

# Pulsar

- 选择Pulsar而不是Kafka的7大理由 https://mp.weixin.qq.com/s/9FJVEtvJuH4amkD96ssAyA
- 比拼Kafka，大数据分析新秀Pulsar到底好在哪 https://mp.weixin.qq.com/s/v4A--nGiDTt58pZyIzepeg
- 开源实时数据处理系统Pulsar：一套搞定Kafka+Flink+DB https://mp.weixin.qq.com/s/B9zo0zThARAi11hRuJ-AqA

消息传输的设计方式：不单是消息或存储 - AI前线的文章 - 知乎 https://zhuanlan.zhihu.com/p/30865021
> Pulsar 提供了灵活消息传输、多租户、跨地理位置数据复制等特性。Pulsar 的创始人 Joe 和 Matteo 等人认为需求是 Pulsar 项目启动的原因，如果应用程序提供实时服务，需要保证平均 5ms 以内的发布延迟，99% 的请求不会超过 15ms 的延迟，同时满足分类、强持久性以及传输保证等特征的消息传输系统，这个系统必须满足提交到各个磁盘或者节点达到 99.99% 的准确性。

Yahoo’s New Pulsar: A Kafka Competitor? https://www.datanami.com/2016/09/07/yahoos-new-pulsar-kafka-competitor/
> “These applications provide real-time services, and need publish-latencies of 5ms on average and no more than 15ms at the 99th percentile,” they write. “At Internet scale, these applications require a messaging system with ordering, strong durability, and delivery guarantees.” The messages must also be committed to multiple disks or nodes in order to get to the 99.999% guaranteed durability level, they add.
>
> “At the time we started, we could not find any existing open-source messaging solution that could provide the scale, performance, and features Yahoo required to provide messaging as a hosted service, supporting a million topics,” Francis and Merli write. “So we set out to build Pulsar as a general messaging solution, that also addresses these specific requirements.”

# Talos (小米)

万亿级消息背后: 小米消息队列的实践 https://www.infoq.cn/article/azHldfbaDD9Iq368SxOo
