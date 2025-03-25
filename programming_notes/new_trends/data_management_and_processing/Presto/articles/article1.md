
# 1

深入浅出Presto：PB级OLAP引擎 https://www.zhihu.com/column/c_1294277883771940864
- 第1章02节 | Presto概述：特性、原理、架构 - 高英举的文章 - 知乎 https://zhuanlan.zhihu.com/p/260399749
- 第2章02节 | 分布式SQL查询引擎原理（以Presto SQL为例） - 高英举的文章 - 知乎 https://zhuanlan.zhihu.com/p/293775390

第1章02节 | Presto概述：特性、原理、架构 - 高英举的文章 - 知乎 https://zhuanlan.zhihu.com/p/260399749
- > ***`Presto`是一个开源的分布式SQL查询的执行引擎***，在Facebook、Amazon、Uber、京东、美团、滴滴、阿里等企业支持了非常多的分析型需求，还有一些企业基于Presto搭建了商业化的服务。在易用性、灵活性和扩展性的设计上，Presto还是做的非常不错的，这个笔者在多年的Presto使用经验中，也有真实的感受。企业中常见的数据计算需求，如BI报表，Ad-Hoc查询，甚至是运行时间比较长的ETL任务，Presto都是支持的，***不过目前来说，笔者所知和所用的Presto应用场景中，主要还是查询时延要求在毫秒或者秒级别的SQL并发BI报表，Ad-Hoc查询以及多数据源关联查询居多***，用Presto来做ETL工具的不多，毕竟Spark，Flink这些成熟的流批计算工具，用作ETL工具相对更成熟一些。
- > 从Presto的论文标题我们可以看到，它推崇的是“SQL on Everything”， ![](https://pic1.zhimg.com/v2-deadd7fb8777d6aac5849010c9865628_1440w.jpg)
- > 上图中是一个四节点的Presto集群架构，在Presto的架构中，有两种角色的节点：
  * > `Coordinator`，负责接收SQL Query，解析SQL，生成和优化执行计划，生成和调度Task到Worker上。Coordinator将一个完整的Query，拆分成了多个Stage，每个Stage拆分出多个可以并行的Task。
  * > `Worker`，负责执行Coordinator发给它的Task，有部分Task负责到外部存储系统拉取数据，这部分Task会先执行，之后再执行那些负责计算的Task。从上图中可以看到，拉取数据的Task是在右侧两个Worker上执行的，负责计算的Task是在左侧一个Worker上执行的。
- > ***`Worker`是可以横向扩容多个来支撑更多的计算需求的，`Coordinator`只能有一个***，由此我们可以得出结论，***`Coordinator`是单点，在集群可用性上有一定的风险，至于这个问题如何解决，请你仔细阅读本专栏后面的章节***，会详细的讲到。
- > ***`Presto`的架构实际上就是一套分布式的SQL执行架构，<ins>它最大的特点就是天然就是存储计算分离，`Presto`只负责计算</ins>，存储的部分由数据源自身提供***。这种存储与计算分离的架构很符合当今云计算发展的趋势——独立的存储云服务与计算云服务，这样做的好处是存储资源不够时可以独立扩容存储，计算资源不够时可以独立扩容计算，而且计算和存储能够分别使用适合自己的机型。分布式的存储系统的实现一般都比较复杂，涉及到数据的分区、副本、容灾、文件格式、IO优化等，是一项非常大的工程。***`Presto`直接放弃了存储，只做计算，<ins>而且它的计算也是做了一些妥协的</ins>，如不支持单个Query内部的执行容错，<ins>如果Query中的某个Task失败了，会导致整个Query失败</ins>。这样实现起来更简单，代价是需要用户侧来重试***。
- > 本质上，你可以这么理解Presto是由以下几个部分组成的：
- > **第一部分：一个高性能、分布式的SQL执行框架**
  * > SQL是一种声明式的编程语言，能够很清晰的表达用户想要什么，正是因为它学习难度比较低、易用性比较高，已经成为数据库和大数据计算领域最常用的业务计算逻辑编写的方式。然而，在生产环境中，有很多系统没有对外暴露SQL执行接口，对内也没有SQL执行能力，如`Elasticsearch`和`HBase`；而有些系统虽然有SQL接口，但是没有海量数据计算能力，如`MySQL`；还有另外一些系统用MapReduce完成SQL计算，时延太长不满足业务需求，如`Hive`。Presto这个SQL执行框架主要解决的问题是为这些数据源提供了一种通用统一的SQL执行能力，在海量数据规模下，还具备了高性能、分布式的计算能力。一个SQL Query进入到Presto系统中，分别完成了以下几个关键步骤，最终将结果输出：
    ```console
    第一步：接收SQL Query请求
    第二步：SQL解析、语义分析（生成AST）
    第三步：生成执行计划、优化执行计划
    第四步：划分Stage、生成和调度Task
    第五步：在Presto Worker上执行Task（有从数据源拉取数据的Task，也有计算为主的Task），生成结果
    第六步：分批返回Query结果给客户端
    ```
  * > 有了Presto以后，它为用户屏蔽了SQL解析之行的底层细节，并尽它所能在查询延迟、并行度、数据本地性、根据规则或成本选择最优执行计划上做了非常多的优化。
- > **第二部分：一套插件化体系，包含`数据源Connector`和自定义执行逻辑的SQL functions**
  * > 简单的说，借助`Connector机制`，Presto可以将来自一切数据源的数据计算SQL化，无论用户的数据源是`本地文件(File Connector)`、`内存（Memory Connector）`、`HTTP API（Http Connector）`，还是`Hive（Hive Connector）`、`HBase（HBase Connector）`、`MySQL（MySQL Connector）`。
  * > 通过提供Connector机制，Presto实现了完全插件化的数据源的元数据获取、注册、数据读取，不同的数据源对于Presto来说就是不同的Connector，用户操作数据源是通过Connector来操作的，同时它本身就自带了多个可以直接使用的数据源Connector，如`Hive Connector`，`Kafka Connector`，`Elasticsearch Connector`，`MySQL Connector`。举个例子，用户可以使用Presto的Hive Connector来查看Hive中都有哪些表，表结构是什么，也可以写SQL查询Hive中的数据，还可以把数据写到Hive。***这个场景中，<ins>`用Presto执行SQL`与直接执行`Hive SQL`的区别是</ins>，Presto SQL的底层SQL执行引擎并不是Hive SQL，而是自行实现的一套MPP执行架构，实际执行SQL的时候，无论是Query的调度、执行计划的生成，还是执行任务的生成和执行，<ins>其速度都是Hive SQL的5-10倍</ins>（行业内有相关的性能对比测试报告）***。众所周知，Hive SQL底层是使用Hadoop MapReduce执行模型实现的，而且Query的调度和执行都是通过启动新的JVM来完成，它更适合去处理数据量超大而且对处理延迟要求比较低（一般是小时，天级别）的数据计算任务，如果是BI报表，Ad-hoc查询类型需求的技术选型中，显然Presto SQL要优于Hive SQL。
  * > ***其实`Presto Connector`能做的远不止于此，它还有一个很实用很吸引人的特性，即`多数据源关联分析`（有的人称之为`联邦查询`）***。思考一下这样的场景，当用户有2个数据源，一个在Hive中(hive_table)，一个在HBase中(hbase_table)，如果他想执行这样的一个SQL计算：
    ```sql
    select
       t2.region as region,
       sum(t1.sales_unit) as sales_count 
    from
       hive_table as t1 
       join
          hbase_table as t2 
          on t1.uid = t2.uid 
    where
       t2.region in 
       (
          'beijing',
          'shanghai'
       )
    group by
       t2.region 
    order by
       sales_count desc limit 100;
    ```
  * > ***传统的做法是要么把HBase的数据导入到Hive中，创建Hive表执行`Hive SQL`，要么就是把Hive数据导入到HBase中，创建HBase表执行`Phoneix SQL`，这样带来了比较大的数据同步开销和数据一致性风险***。如果用Presto来实现以上需求，要简单很多——***只需要配置好Presto的Hive Connector与HBase Connector，启动Presto SQL客户端输入上面的SQL即可得到查询结果***。这是怎么实现的呢？***在Presto内部，SQL被解析后生成执行计划，并将Hive和HBase的数据读取任务调度到Worker上来读取HDFS和HBase的数据，这些数据随后被传输到其他Worker上完成JOIN以及其他SQL的计算（如聚合操作）***，由于计算过程中的数据交换的中间存储介质都是内存，而且Presto也做了很多提高并发度的优化，整体来说，计算速度还是非常快的。
  * > 在Connector体系中，Presto提供了一系列的Java Interface接口，允许用户实现自定义的Connector。这些Java Interface暴露出的接口是极度丰富的，使用这些接口开发者能够自定义许多逻辑，如下面列出了几个常见的：
    ```console
    • 获取Table元数据及数据的位置
    • 获取Table的统计数据，用于CBO优化
    • 控制Split的生成和划分，Split是Presto定义的数据分片基本单位
    • 实现Pushdown接口，来决定哪些操作可以Pushdown（下推），如常见的Pushdown类型有Limit，Projection，Filter，Aggregation。Connector拉取数据时，通过此功能将必要的操作下推到数据源的存储引擎中，减少不必要的数据传输开销。
    • 实现CreateTableAsSelect接口，实现通过Presto写数据到存储系统的目的。
    ```
  * > 类似Hive，Presto也支持用户自定义 **SQL functions（俗称`UDF`）**，来实现那些直接用SQL不好表达，但是用Java代码比较容易实现的业务计算逻辑。
  * > 笔者近五年阅读过大量的大数据`SQL On Hadoop`系统（如`Hive、Spark、Flink`）的代码实现，重点关注过SQL执行框架与数据源插件化体系，一直认为Presto的源码实现，是很优秀的，值得学习和借鉴。
- > **第三部分：多个已经预先实现好，开箱即用的Connector和SQL内置functions**
  * > 上面已经说过部分预先实现的Connector，这里列举一下常见的Connector，我们在本专栏课程中的部分章节中也会做详细的介绍：
    ```console
    Hive Connector
    Kafka Connector
    MySQL Connector
    Elasticsearch Connector
    ```
  * > 可以翻阅一下Presto的官方文档，它已经支持的Functions是非常丰富的，笔者时常感叹于使用`SparkSQL`和`FlinkSQL`时，如果能有这么多Functions就好了，列举一下Presto常见的Functions：
    + > Json系列：可以方便的做json与presto内置type之间的转换和提取。
    + > Date/Time系列：可以方便的操作时间字段，改变时间字段内容。
    + > 近似聚合系列：允许那些对准确度要求不是100%的用户，通过牺牲一定的准确性换来更高的执行性能。
    + > Array/Map系列：允许用户方便的操作Array，Map这种嵌套类型的字段，很多用户喜欢用Parquet文件存储嵌套类型的数据，而Presto为操作这种数据提供了便利。
  * > 如果在生产环境中，你发现Presto预先实现的Connector不满足你的功能、性能需求，再或者Presto没有预先实现你需要的数据源，***请放心大胆得去改进或实现，Presto源码的分层抽象做的比较好，有需求只需要调整对应的Connector源码即可，编译打包也是比较方便的***。
  * > 这里再举几个国内互联网公司改造`Presto Connector`的案例：
    + > 案例一：`京东`曾经改造MySQL Connector的源码，***调整了Split生成的方式***，大大提高了Hive与MySQL关联分析时，MySQL拉取数据的并行能力。
    + > 案例二：`阿里云`因为有多个自研的存储系统，如对象存储OSS，他们的工程师开发了Presto的`OSS Connector`，来允许Presto对接OSS中的数据查询。类似的，国外的云计算巨头`AWS`也开发了`对象存储S3服务的Presto Connector`，来为商业客户提供服务。
    + > 案例三：笔者之前所在的某家公司在使用Elasticsearch Connector时发现性能、功能都不满足需求，也做了诸多改进，如优先查询keyword字段，优化了projection pushdown功能，scroll api拉取数据时默认从doc_values中拉取，提高拉取效率。
    + > 案例四：Presto的 `HBase Connector`在`Facebook`内部有实现，可惜的是他们没有开源出来，国内易观国这家公司在github上提供了开源实现，从他们的性能测试报告来看，性能还是很优越的。笔者之前也是使用过SQL On HBase的其他方案如`Phoenix`，这个项目现在已经不怎么维护了，使用体验也不怎么好，如果用户需要在HBase上执行SQL，Presto的HBase Connector是一个不错的选择。
  * > 这里有个特别提示，如果你在互联网上搜索Presto，你会发现两个项目地址：
    + > PrestoDB： https://prestodb.io/ ，源代码： https://github.com/prestodb/presto
    + > PrestoSQL： https://prestosql.io/ ，源代码： https://github.com/prestosql/presto
  * > 这两个Presto的关系是，`PrestoDB`是`2013年`Facebook的三个核心工程师创造和开源出来的，在Facebook内部，它的应用规模是很庞大的（部署了多个集群，总节点数10000+台），这三个工程师一直想把Presto发扬光大，但是一直到了2019年，他们感觉到公司好像不怎么给力，同时期的三个开源大数据技术Spark、Flink、Kafka都已经创建了自己的商业化公司推广到家喻户晓了，如果说哪家公司在力推Presto，可能只有一家叫`Teradata`的小公司。无奈之下，这三位核心工程师离职加入了刚成立两年的`Starburst`公司，***这家公司Fork了Presto的项目源码，取名为`PrestoSQL`***，创建了自己的代码仓库和官方网站，在做商业化运营的Presto。***<ins>如果你问笔者该选哪个，笔者更倾向于选择`PrestoSQL`</ins>，因为他近两年的源码迭代速度更快，而且还有三位创始人的支持***，相信PrestoSQL的发展前景，***所以本专栏中，如果有涉及源码讲解的内容，我们也会使用`PrestoSQL`的源码作为学习示例***。不过事情也不是绝对的，PrestoDB与PrestoSQL也在互相学习，并且会把对方比较好的实现，merge到自己的项目里，所以同时关注一下这两个项目的动态，没有坏处。
- > References：
  * > Facebook Presto 论文 https://www.facebook.com/notes/facebook-engineering/presto-interacting-with-petabytes-of-data-at-facebook/10151786197628920
- 回复：
  * > 那个叫teradata的小公司也是个不懂球的胖子
  * > Facebook 的 PrestoDB，引入了新的节点角色 Resource Manager，提供了原生的 Coordinator HA 解决方案。能把这部分内容也加入到书中么？
