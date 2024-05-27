
分类/分布式数据库 https://caroly.fun/categories/disdatabase || https://web.archive.org/web/20231205122403/https://caroly.fun/categories/disdatabase
- 【[:star:][`*`]】 分布式数据库（七） https://caroly.fun/archives/%E5%88%86%E5%B8%83%E5%BC%8F%E6%95%B0%E6%8D%AE%E5%BA%93%E4%B8%83

【[:star:][`*`]】 分布式数据库（七） https://caroly.fun/archives/%E5%88%86%E5%B8%83%E5%BC%8F%E6%95%B0%E6%8D%AE%E5%BA%93%E4%B8%83 || https://web.archive.org/web/20231002183937/https://caroly.fun/archives/%E5%88%86%E5%B8%83%E5%BC%8F%E6%95%B0%E6%8D%AE%E5%BA%93%E4%B8%83
- > **HTAP 的两种存储设计**
  * > **Spanner：存储合一**
    + > 首先，先看看 Spanner 的方案。Spanner2017 论文“Spanner: Becoming a SQL System”中介绍了它的新一代存储 `Ressi`，其中使用了类似 PAX 的方式。这个 PAX 并不是 Spanner 的创新，早在 VLDB2002 的论文 ["Data Page Layouts for Relational Databases on Deep Memory Hierarchies"](https://research.cs.wisc.edu/multifacet/papers/vldbj02_pax.pdf) 中就被提出了。论文从 CPU 缓存友好性的角度，对不同的存储方式进行了探讨，涉及 `NSM`、`DSM`、`PAX` 三种存储格式。
    + > **NSM（行式存储）**
      - > `NSM`（`N-ary Storage Model`）就是行式存储，也是 OLTP 数据库默认的存储方式，始终伴随着关系型数据库的发展。常用的 OLTP 数据库，比如 MySQL（InnoDB）、PostgreSQL、Oracle 和 SQL Server 等等都使用了行式存储。
      - > 顾名思义，行式存储的特点是将一条数据记录集中存在一起，这种方式更加贴近于关系模型。写入的效率较高，在读取时也可以快速获得一个完整数据记录，这种特点称为`记录内的局部性`（`Intra-Record Spatial Locality`）。 
      - > 但是，行式存储对于 OLAP 分析查询并不友好。***OLAP 系统的数据往往是从多个 OLTP 系统中汇合而来，单表可能就有上百个字段***。而用户一次查询通常只访问其中的少量字段，如果以行为单位读取数据，查询出的多数字段其实是无用的，也就是说大量 I/O 操作都是无效的。同时，大量无效数据的读取，又会造成 CPU 缓存的失效，进一步降低了系统的性能。
    + > **DSM（列式存储）**
      - > `DSM`（`Decomposition Storage Model`）就是列式存储，它的出现要晚于行式存储。典型代表系统是 C-Store，它是迈克尔·斯通布雷克（Micheal Stonebraker）主导的开源项目，后来的商业化产品就是 Vertica。
      - > 列式存储就是将所有列集中存储，不仅更加适应 OLAP 的访问特点，对 CACHE 也更友好。这种特点称为`记录间的局部性`（`Inter-Record Spatial Locality`）。列式存储能够大幅提升查询性能，以速度快著称的 ClickHouse 就采用了列式存储。
      - > 列式存储的问题是写入开销更大，这是因为根据关系模型，在逻辑上数据的组织单元仍然是行，改为列式存储后，同样的数据量会被写入到更多的数据页（page）中，而数据页直接对应着物理扇区，那么磁盘 I/O 的开销自然增大了。
      - > 列式存储的第二个问题，就是很难将不同列高效地关联起来。毕竟在多数应用场景中，不只是使用单列或单表数据，数据分散后，关联的成本会更高。
    + > **PAX**
      - > PAX 增加了 minipage 这个概念，是原有的数据页下的二级单位，这样一行数据记录在数据页上的基本分布不会被破坏，而相同列的数据又被集中地存储在一起。***PAX 本质上还是更接近于行式存储***，但它也在努力平衡记录内局部性和记录间局部性，提升了 OLAP 的性能。
      - > 理论上，PAX 提供了一种兼容性更好的存储方式，可让人有些信心不足的是其早在 2002 年提出，但在 Spanner 之前却少有落地实现。
      - > 与这个思路类似的设计还有 HyPer 的 [`DataBlock`](http://db.in.tum.de/downloads/publications/datablocks.pdf)(SIGMOD2016)，DataBlock 构造了一种独有的数据结构，同时面向 OLTP 和 OLAP 场景。
  * > **TiFlash：存储分离**
    + > ***如果底层存储是一份数据，那么天然就可以保证 OLTP 和 OLAP 的数据一致性，这是 PAX 的最大优势***，但是由于访问模式不同，性能的相互影响似乎也是无法避免，只能尽力选择一个平衡点。TiDB 展现了一种不同的思路，介于 PAX 和传统 OLAP 体系之间，那就是 OLTP 和 OLAP 采用不同的存储方式，物理上是分离的，然后通过创新性的复制策略，保证两者的数据一致性。
    + > TiDB 是在较早的版本中就提出了 HTAP 这个目标，并增加了 TiSpark 作为 OLAP 的计算引擎，但仍然共享 OLTP 的数据存储 TiKV，所以两种任务之间的资源竞争依旧不可避免。直到近期的 4.0 版本中，TiDB 正式推出了 TiFlash 作为 OLAP 的专用存储。
    + > 关注点集中在 TiFlash 与 TiKV 之间的同步机制上。其实，这个同步机制仍然是基于 Raft 协议的。***TiDB 在 Raft 协议原有的 Leader 和 Follower 上增加了一个角色 Learner。这个 Learner 和 Paxos 协议中的同名角色，有类似的职责，就是负责学习已经达成一致的状态，但不参与投票***。这就是说，Raft Group 在写入过程中统计多数节点时，并没有包含 Learner，这样的好处是 Learner 不会拖慢写操作，但带来的问题是 Learner 的数据更新必然会落后于 Leader。
    + > Raft 协议能够实现数据一致性，是因为限制了只有主节点提供服务，否则别说是 Learner 就是 Follower 直接对外服务，都不能满足数据一致性。所以，这里还有另外一个设计。
    + > Learner 每次接到请求后，首先要确认本地的数据是否足够新，而后才会执行查询操作。怎么确认足够新呢？ Learner 会拿着读事务的时间戳向 Leader 发起一次请求，获得 Leader 最新的 Commit Index，就是已提交日志的顺序编号。然后，就等待本地日志继续 Apply，直到本地的日志编号等于 Commit Index 后，数据就足够新了。而在本地 Region 副本完成同步前，请求会一直等待直到超时。
    + > 这种同步机制有效运转的前提是 TiFlash 不能落后太多，否则每次请求都会带来数据同步操作，大量请求就会超时，也就没法实际使用了。但是，TiFlash 是一个列式存储，列式存储的写入性能通常不好，TiFlash 怎么能够保持与 TiKV 接近的写入速度呢？
    + > 这就要说到 TiFlash 的存储引擎 Delta Tree，它参考了 B+ Tree 和 LSM-Tree 的设计，分为 Delta Layer 和 Stable Layer 两层，其中 Delta Layer 保证了写入具有较高的性能。
    + > 当然，TiFlash 毕竟是 OLAP 系统，首要目标是保证读性能，因此写入无论多么重要，都要让位于读优化。作为分布式系统，还有最后一招可用，那就是通过扩容降低单点写入的压力。
  * > **小结**
    + > OLTP 通过 ETL 与 OLAP 衔接，所以 OLAP 的数据时效性通常是 T+1，不能及时反映业务的变化。这个问题有两种解决思路，一种是重建 OLAP 体系，通过流计算方式替代批量数据处理，缩短 OLAP 的数据延迟，典型代表是 Kappa 架构。第二种思路是 Gartner 提出的 HTAP。
    + > HTAP 的设计要点在计算引擎和存储引擎，其中存储引擎是基础。对于存储引擎也两种不同的方案，一种是以 PAX 为代表，用一份物理存储融合行式和列式的特点，Spanner 采用了这种方式。另一种是 TiDB 的 TiFlash，为 OLTP 和 OLAP 分别设置行式存储和列式存储，通过创新性的同步机制保证数据一致。
    + > TiDB 的同步机制仍然是基于 Raft 协议的，通过增加 Learner 角色实现异步复制。异步复制必然带来数据的延迟，Learner 在响应请求前，通过与 Leader 同步增量日志的方式，满足数据一致性，但这会带来通讯上的额外开销。
    + > TiFlash 作为列存，首先要保证读取性能，但因为要保证数据一致性，所以也要求具备较高的写入性能，TiFlash 通过 Delta Tree 的设计来平衡读写性能。这个问题我们没有展开，将在 22 讲继续讨论。
  * > **加餐**：
    + > 每次 TiFlash 接到请求后，都会向 TiKV Leader 请求最新的日志增量，本地 replay 日志后再继续处理请求。这种模式虽然能够保证数据一致性，但会增加一次网络通讯。这个模式还能优化吗？
    + > 可以利用 Raft 协议的特性进行优化。***Raft 在同步数据时是不允许出现“日志空洞”的，这意味着如果 Follower 节点收到时间戳为 300 的日志，则代表一定已经收到了小于这个时间戳的所有日志***。所以，在 TiFlash 接收到查询请求时，如果查询时间戳小于对应分片的最后写入时间戳，那么本地分片的数据一定是足够新的，不用再与 TiKV 的 Leader 节点通讯。
- > **查询性能优化**
  * > 分布式数据库的主体架构是朝着计算和存储分离的方向发展的，这一点在 NewSQL 架构中体现得尤其明显。但是计算和存储是一个完整的过程，架构上的分离会带来一个问题：是应该将数据传输到计算节点 (Data Shipping)，还是应该将计算逻辑传输到数据节点 (Code Shipping)？
  * > 从直觉上说，肯定要选择 Code Shipping，因为 Code 的体量远小于 Data，因此它能传输得更快，让系统的整体性能表现更好。
  * > 这个将 code 推送到存储节点的策略被称为『计算下推』，是计算存储分离架构下普遍采用的优化方案。
  * > **计算下推**
    + > 将计算节点的逻辑推送到存储节点执行，避免了大量的数据传输，也达到了计算并行执行的效果。这个思路还是很好理解的，用一个例子来具体说明下。

分布式数据库（九） https://caroly.fun/archives/%E5%88%86%E5%B8%83%E5%BC%8F%E6%95%B0%E6%8D%AE%E5%BA%93%E4%B9%9D || https://web.archive.org/web/20231002180958/https://caroly.fun/archives/%E5%88%86%E5%B8%83%E5%BC%8F%E6%95%B0%E6%8D%AE%E5%BA%93%E4%B9%9D
- > **查询执行引擎**
  * > 查询执行引擎是否高效与其采用的模型有直接关系，模型主要有三种：`火山模型`、`向量化模型`和`代码生成`。
  * > **`火山模型`**
  * > **`向量化：TiDB&CockroachDB`**
  * > **`代码生成：OceanBase`**
- > **RUM 猜想**
  * > RUM 猜想来自论文 "[Designing Access Methods: The RUM Conjecture](https://stratos.seas.harvard.edu/files/stratos/files/rum.pdf)"（Manos Athanassoulis et al.(2016)），***同时被 SIGMOD 和 EDBT 收录***。它说的是，***对任何数据结构来说，在 Read Overhead（读）、Update Overhead（写） 和 Memory or Storage Overhead（存储）中，同时优化两项时，需要以另一项劣化作为代价***。论文用一幅图展示了常见数据结构在这三个优化方向中的位置。
