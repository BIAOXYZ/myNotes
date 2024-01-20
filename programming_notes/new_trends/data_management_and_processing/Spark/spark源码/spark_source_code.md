
# 1. [黑泽君的专栏](https://cloud.tencent.com/developer/column/72638)

大数据技术之_19_Spark学习_06_Spark 源码解析 + Spark 通信架构、脚本解析、standalone 模式启动、提交流程 + Spark Shuffle 过程 + Spark 内存 https://cloud.tencent.com/developer/article/1425173

大数据技术Spark学习 https://cloud.tencent.com/developer/article/1423790

【转载】Google 后 Hadoop 时代的新 “三驾马车” -- Caffeine(搜索)、Pregel(图计算)、Dremel(查询) https://cloud.tencent.com/developer/article/1422319
- > 摘要：Google 在 2003 年到 2004 年公布了关于 `GFS`、`MapReduce` 和 `BigTable` 三篇技术论文（旧三驾马车），这也成为后来云计算发展的重要基石，如今 Google 在后 Hadoop 时代的新“三驾马车” -- `Caffeine`、`Pregel`、`Dremel` 再一次影响着全球大数据技术的发展潮流。

# 2. [spark源码分析](https://www.cnblogs.com/huanghanyu/category/1774530.html)

随笔分类 -  spark源码分析 https://www.cnblogs.com/huanghanyu/category/1774530.html
- Spark源码系列（一）spark-submit提交作业过程 https://www.cnblogs.com/huanghanyu/p/12971481.html
- Spark源码系列（二）RDD详解 https://www.cnblogs.com/huanghanyu/p/12971689.html
- Spark源码系列（三）作业运行过程 https://www.cnblogs.com/huanghanyu/p/12972791.html
- Spark源码系列（四）图解作业生命周期 https://www.cnblogs.com/huanghanyu/p/12972837.html
- Spark源码系列（十）spark源码解析大全 https://www.cnblogs.com/huanghanyu/p/12989067.html
- Spark源码系列（十一）spark源码解析总结 https://www.cnblogs.com/huanghanyu/p/12989074.html

Spark源码系列（十）spark源码解析大全 https://www.cnblogs.com/huanghanyu/p/12989067.html
- > **第1章 Spark 整体概述**
  * > **1.3 计算抽象**
    + > 在描述 Spark 中的计算抽象，我们首先需要了解如下几个概念：
      - > 1）Application • 用户编写的 Spark 程序，完成一个计算任务的处理。它是由一个 Driver 程序和一组运行于 Spark 集群上的 Executor 组成。
      - > 2）Job • 用户程序中，每次调用 Action 时，逻辑上会生成一个 Job，一个 Job 包含了多个 Stage 。
      - > 3）Stage • Stage 包括两类：ShuffleMapStage 和 ResultStage，如果用户程序中调用了需要进行 Shuffle 计算的 Operator，如 groupByKey 等，就会以 Shuffle 为边界分成 ShuffleMapStage 和 ResultStage。
      - > 4）TaskSet • 基于 Stage 可以直接映射为 TaskSet，一个 TaskSet 封装了一次需要运算的、具有相同处理逻辑的 Task，这些 Task 可以并行计算，粗粒度的调度是以 TaskSet 为单位的。
      - > 5）Task • Task 是在物理节点上运行的基本单位，Task 包含两类：ShuffleMapTask 和 ResultTask，分别对应于 Stage 中 ShuffleMapStage 和 ResultStage 中的一个执行基本单元。
    + > 下面，我们看一下，上面这些基本概念之间的关系，如下图所示：

# 3

源码解析Spark中的Parquet向量化读取，性能提速9倍！ https://mp.weixin.qq.com/s/KjkCZ8LpgwJ-xdB7DHLuEw

Spark SQL 查询计划是如何执行的，深入探究Spark QueryExecution执行过程 https://mp.weixin.qq.com/s/-kNDup4prWl02N27_SYBTw

爆赞！2023往期文章汇总 https://mp.weixin.qq.com/s/KyhEjmnr8R-751IgV1KxMg
