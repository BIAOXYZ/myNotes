
# MQ general

mq 选型 https://www.v2ex.com/t/765626

消息队列和 RocketMQ 入门总结 https://mp.weixin.qq.com/s/eXzq5jg-2KkKziSPkcSQ5Q

对Kafka 和 Pulsar进行性能测试后，拉卡拉将消息平台统一换成了 Pulsar https://mp.weixin.qq.com/s/s4PjlOxsRStO3FXL-fvGgQ

# celery

Celery (software) https://en.wikipedia.org/wiki/Celery_(software)

Distributed Task Queue (development branch) http://celeryproject.org
> https://github.com/celery/celery

不得不吐槽一下 Python 的任务队列，异步支持太差了 https://www.v2ex.com/t/849494
- > 因为历史原因，celery 开发的时候没有 asyncio ，改成 asyncio 估计要推到重建，这样就变成了遥遥无期
- > celery 是个传销软件，作者早就弃坑了。连个任务硬超时都没作好
- > 这是 python 的问题还是 celery 的问题呢?
- > celery 从来就没好感。。。。python 里有 3 大骗子营销软件 <br> 1 是 flask <br> 2 是 celery <br> 3 是 gunicorn <br> 其实好多实现都是玩具级别。当然别人是开源项目，没法指责作者什么，但是哪些写教程的把吹上天就不对了。
  >> gunicorn 有什么问题吗，因为现在 fastapi 炒的火，fastapi 里的推荐部署方式都是 gunicorn
  >>> fastapi 我也在用，比如它 http 日志如何规范搜集？ <br> https://github.com/encode/uvicorn/issues/527 <br> gunicorn 这货只要指定了 work ，就甩手啥都不管了。日志日志不管，被 SIGTERM 杀了也不管，感情 gunicorn 就管了个 fd ，管了个寂寞啊。
  >>>> flask 有啥问题啊？
  >>>>> 不是吧，我觉得 fastapi 比 flask 骗子营销多了……至少 flask 没吹过自己压根不存在的“高性能”。
  >>>>>> flask 满世界吹自己 lightweight 啊。。其实一个 werkzeug 设计就比 django 复杂了。。（不对这句话负责。逃。。。。。。。。。。。。。
- > celery 就是个玩具级别的项目，谁用谁被坑
- > 自己用 redis 实现吧，celery 已经被我们抛弃了

# Kafka

一篇文章带你逆袭 Kafka https://mp.weixin.qq.com/s/j8J762sBLKuS4O0JgVsq6w

Kafka 架构原理解析 https://mp.weixin.qq.com/s/gxl3A_YaqTooa-Wb8WrYzg

kafka解决了什么问题? - 知乎 https://www.zhihu.com/question/53331259

Kafka 如果丢了消息，怎么处理？ https://mp.weixin.qq.com/s/TcN5kslQxRQOBlkSjg7_Sg

Kafka 宕机引发的高可用问题 https://mp.weixin.qq.com/s/7_8uOzpPD6XTw3L3cRAk8g

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
