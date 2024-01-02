
# general

***Awesome Big Data原版及中文翻译版***：
- 史上最全的大数据学习资源(Awesome Big Data) https://www.iteblog.com/archives/2607.html
- Awesome Big Data: A curated list of awesome big data frameworks, ressources and other awesomeness. https://github.com/onurakpolat/awesome-bigdata

大数据入门指南 https://github.com/heibaiying/BigData-Notes

一文看懂大数据的技术生态圈，Hadoop，hive，spark都有了 https://mp.weixin.qq.com/s/Jt-WLRHsKDK_lIESxhgkqQ || 如何用形象的比喻描述大数据的技术生态？Hadoop、Hive、Spark 之间是什么关系？ - Xiaoyu Ma的回答 - 知乎 https://www.zhihu.com/question/27974418/answer/38965760

# Spark v.s. Flink

Spark比拼Flink：下一代大数据计算引擎之争 - 夜城的文章 - 知乎 https://zhuanlan.zhihu.com/p/40402793

# Apache Kylin

一文读懂Apache Kylin https://www.jianshu.com/p/abd5e90ab051

# ELK v.s. EFK

日志搜集、过滤及推送处理框架logstash及fluentd总结 https://blog.csdn.net/benpaobagzb/article/details/50903323

Fluentd vs. Logstash: A Comparison of Log Collectors https://logz.io/blog/fluentd-logstash/

# 数据湖（data lake）

Data lake https://en.wikipedia.org/wiki/Data_lake

微软的数据湖也凉凉了 https://mp.weixin.qq.com/s/9sLeLnzjsrgnQwH-NV3GJQ || https://chuansongme.com/n/2585502252810 || https://cloud.tencent.com/developer/article/1356989

数据湖Delta Lake 进入 Linux 基金会 https://www.ithome.com/0/451/179.htm

# 流处理 v.s. 批处理

流处理和批处理讲解、主流框架对比、流批一体架构 http://www.lzhpo.com/article/1649890657303629826
- > **什么是流批一体架构？**
  * > 以前很多系统的架构都是采用的`Lambda架构`，它将所有的数据分成了三个层次：批处理层、服务层和速率层，每个层次都有自己的功能和目的。
  * > 这种架构，需要一套流处理平台和一套批处理平台，这就可能导致了一些问题：
    + > 资源浪费：一般来说，白天是流计算的高峰期，此时需要更多的计算资源，相对来说，批计算就没有严格的限制，可以选择凌晨或者白天任意时刻，***但是，流计算和批计算的资源无法进行混合调度，无法对资源进行错峰使用，这就会导致资源的浪费***。
    + > 成本高：流计算和批计算使用的是不同的技术，意味着需要维护两套代码，不论是学习成本还是维护成本都会更高。
    + > 数据一致性：两套平台都是不一样的，可能会导致数据不一致的问题。
- > **有哪些流处理的框架？**

批处理计算与流处理计算的区别是什么？ - 知乎 https://www.zhihu.com/question/313869609
- 批处理计算与流处理计算的区别是什么？ - DataPipeline数见科技的回答 - 知乎 https://www.zhihu.com/question/313869609/answer/829714737
  * > **三、`Lambda架构`是批流一体化的必然要求**
    + > 目前在做这样的平台时，业界比较公认的有两种架构：一种是`Lambda架构`，`Lambda架构`的核心是按需使用批量和流式的处理框架，分别针对批式和流式数据提供相应的处理逻辑。最终通过一个服务层进行对外服务的输出。
    + > 为什么我们认为Lambda架构是批流一体化的必然要求？这好像看起来是矛盾的（与之相对，还有一种架构叫`Kappa架构`，即用一个流式处理引擎解决所有问题）。
- 批处理计算与流处理计算的区别是什么？ - 大数据羊说的回答 - 知乎 https://www.zhihu.com/question/313869609/answer/2398291030

批处理和流处理 https://www.jianshu.com/p/5cc07eae1a0c

Big Data Battle : Batch Processing vs Stream Processing https://medium.com/@gowthamy/big-data-battle-batch-processing-vs-stream-processing-5d94600d8103

# 其他

数据埋点是什么？设置埋点的意义是什么？ - Yuki的回答 - 知乎 https://www.zhihu.com/question/36411025/answer/147581103
- > 所谓`埋点`就是**在应用中特定的流程收集一些信息，用来跟踪应用使用的状况，后续用来进一步优化产品或是提供运营的数据支撑**，包括访问数（Visits），访客数（Visitor），停留时长（Time On Site），页面浏览数（Page Views）和跳出率（Bounce Rate）。这样的信息收集可以大致分为两种：页面统计（track this virtual page view），统计操作行为（track this button by an event）。 
- > 数据埋点的方式现在埋点的主流有两种方式：第一种：自己公司研发在产品中注入代码统计，并搭建起相应的后台查询。第二种：第三方统计工具，如友盟、神策、Talkingdata、GrowingIO等。
