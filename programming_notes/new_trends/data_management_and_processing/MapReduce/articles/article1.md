
# 1

结合源码深入理解 MapReduce 工作原理 https://s1mple.cc/2021/10/22/%E7%BB%93%E5%90%88%E6%BA%90%E7%A0%81%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3-MapReduce-%E5%B7%A5%E4%BD%9C%E5%8E%9F%E7%90%86/
- > **MapReduce 架构**
  * > 本文讨论的 MapReduce 架构是 Hadoop 1.0 版本时的架构，从 Hadoop 2.0 开始，Hadoop 推出了资源管理框架 YARN。在 YARN 中，使用 ResourceManager 来负责容器的调度（任务运行在容器中），以及作业的管理。使用 NodeManager 来向 ResourceManager 汇报节点资源以及容器运行状态，NodeManager 负责创建并管理执行任务的容器。***从职责方面，`ResourceManager` 等同于 `JobTracker`，`NodeManager` 等同于 `TaskTracker`***。大多数的分布式框架都符合这种主从设计，***如 HDFS 的 NameNode 和 DataNode、Spark 的 Driver 和 Executor 等***。
  * > 以下是 MapReduce 架构和工作流程中的常用术语：
    + > Job（作业）：是客户端需要执行的一个工作单元，包括输入数据、MapReduce 程序和配置信息；
    + > Task（任务）：Hadoop 将作业分成若干个任务来执行，任务分为两类，即 Map 任务和 Reduce 任务；
    + > Map/Reduce：从执行阶段来看，Map 和 Reduce 代表两个大类阶段。从计算模型角度看，它们代表两个计算步骤。从代码层面看，它们是定义在 Mapper 和 Reducer 类中的函数；
    + > Mapper/Reducer：从执行阶段的详细划分来看，Mapper 和 Reducer 代表执行 map 与 reduce 函数的步骤。从代码层面看，这是定义在代码中的两个 Java 类。某些语境下，Mapper 可以指代 Map 任务，Reducer 同理。
  * > 与多数的大数据分布式框架相同，MapReduce 的架构也遵循主从结构：
    + > ***运行在 `HDFS NameNode` 主节点上的 `JobTracker` 程序***，负责接收从客户端提交的 Job，将其划分成 Map 任务和 Reduce 任务，分发给从节点 TaskTracker 执行。JobTracker 负责任务之间的协作，并通过 TaskTracker 发送来的心跳包维护集群的运行状态，以及作业进度信息。
    + > ***多个运行在 `HDFS DataNode` 节点上的 `TaskTracker` 程序***，负责执行 Map 任务和 Reduce 任务，直接与 HDFS 交互。每隔一段时间，TaskTracker 向 JobTracker 发送心跳包，汇报节点运行状态，以及任务完成进度。
  * > 为了减少网络传输带来的性能影响，JobTracker 在分发 Map 任务时基于 **数据本地化优化**（Data locality optimization）策略，将 Map 任务分发给包含此 Map 处理数据的从节点，并将程序 Jar 包发送给该 TaskTracker，遵循“运算移动，数据不移动”的原则。
- > **新旧版本 API 说明**
  * > 本文中的源码是 Hadoop 3.2.0 版本的源码，使用的是 Hadoop 新版 API。新版 API 位于 `org.apache.hadoop.mapreduce` 包下，旧版 API 位于 `org.apache.hadoop.mapred` 包下，两版 API 并不兼容，你可以在 [这里](https://www.slideshare.net/sh1mmer/upgrading-to-the-new-map-reduce-api) 查看两者的区别。为保证向后兼容，Hadoop 并没有移除旧版 API，因此依赖库中两个版本并存，使用时要注意。
  * > 设计新版 API 的主要目的是给用户提供更加简洁优雅的接口，框架的核心代码并没有调整包，比如执行 Map 与 Reduce 任务的 MapTask 和 ReduceTask 类仍位于 `org.apache.hadoop.mapred` 包下。但由于使用了两套 API，在该类中你会经常看到以 Old/New 命名的类或方法，如 `runNewMapper()` 和 `runOldMapper()`。
  * > 在旧版本中，Mapper 与 Reducer 被定义为接口，而在新版本中被定义为具体类，并提供默认的 map 和 reduce 实现：仅是通过 context.write() 重新写回数据。旧版本的 Mapper 接口源码如下：
    ```java
    public interface Mapper<K1, V1, K2, V2> extends JobConfigurable, Closeable {
      void map(K1 key, V1 value, OutputCollector<K2, V2> output, Reporter reporter) throws IOException;
    }
    ```
  * > 新版本中广泛使用上下文 Context 对象，整合了 OutputCollector、Reporter 和部分 JobConf 的功能，来实现与 MapReduce 系统的通信，如使用 context.write() 代替旧版的 output.collect() 功能。
  * > 新版本使用 Job 类替换旧版的 JobClient 类，实现作业控制，并使用统一的配置类 Configuration 来替换旧版的 JobConf 类，用于作业配置。因此，现在的一个 MapReduce 程序的入口函数可能如下所示：
    ```java
    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "word count");
        job.setJarByClass(WordCount.class);
        
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        
        job.setMapperClass(TokenizerMapper.class);
        job.setCombinerClass(IntSumReducer.class);
        job.setReducerClass(IntSumReducer.class);
        
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
        
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
    ```
- > **MapReduce 中的数据格式**
- > **MapReduce 工作流程详解**
- > **MapReduce 的局限**
- > **参考**
  * > Hadoop 权威指南（第四版）
  * > Apache Hadoop 官方文档：MapReduce Tutorial https://hadoop.apache.org/docs/stable/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html#Mapper
  * > Phases of MapReduce – How Hadoop MapReduce Works https://techvidvan.com/tutorials/how-mapreduce-works/
  * > Difference between Hadoop OLD API and NEW API http://hadoopbeforestarting.blogspot.com/2012/12/difference-between-hadoop-old-api-and.html
