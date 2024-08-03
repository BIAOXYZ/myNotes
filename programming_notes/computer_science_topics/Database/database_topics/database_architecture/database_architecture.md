
# Shared-nothing vs Shared-disk vs Shared-memory

## 个人总结

**关于share nothing、share everything、share disk、share memory、share storage的总结**：
- 首先不论是 share xxx 或者 shared xxx（或者中间有连字符），都只是不同的表达形式。
- share nothing连wiki词条都有，并且也有大牛背书。share everything是share nothing的反面，也很直观。这两个本身意义上也很明显。
- share disk不论wiki词条还是民间/网上，目前看都认为是“**磁盘共享，但内存是独立**（CPU在这种情况下更是独立，无需赘述）”，所以这个争议也不大，该词汇正式程度仅次于前两个。
- share memory好歹有大牛文章，所以正式程度和share disk差不多。但这里一个关键的问题是：“**CPU肯定独立，内存share，那disk呢？**”——论文[《Parallel Database Systems: The Future of Database Processing or a Passing Fad?》](https://jimgray.azurewebsites.net/papers/CacmParallelDB.pdf)里给出的答案是：**disk也是共享的(或者至少是每个CPU都能访问到每块磁盘)**。——个人认为：内存一旦是共享的，内存又介于磁盘和CPU之间，磁盘基本也就等于共享了。
  * > How can we build scaleable multi-processor systems? Stonebraker suggested the following simple taxonomy for the spectrum of designs (see Figures 3 and 4) [STON86]:
    + > `shared-memory`: All processors share direct access to a common global memory ***and to all disks***. The IBM/370, and Digital VAX, and Sequent Symmetry multi-processors typify this design.
    + > shared-disks: Each processor has a private memory but has direct access to all disks. The IBM Sysplex and original Digital VAXcluster typify this design.
    + > shared-nothing: Each memory and disk is owned by some processor that acts as a server for that data. Mass storage in such an architecture is distributed among the processors by connecting one or more disks. The Teradata, Tandem, and nCUBE machines typify this design.
- share storage则更像是一个民间口口相传出来的词。至于其意义，有时是接近share disk（各个节点还是有自己的独立内存，但是磁盘是公共的）；有时是接近share memory（除了CPU是独立的，内存和磁盘都是共享的）。该词汇的正式程度最低。

## 具体展开

Shared-nothing architecture https://en.wikipedia.org/wiki/Shared-nothing_architecture
- > A `shared-nothing architecture` (`SN`) is a distributed-computing architecture in which each update request is satisfied by a single node (processor/memory/storage unit). ***The intent is to eliminate contention among nodes***. Nodes do not share (independently access) ***memory*** or ***storage***. One alternative architecture is ***`shared everything`***, in which requests are satisfied by ***arbitrary combinations of nodes***. This may introduce contention, as multiple nodes may seek to update the same data at the same time.
- > One alternative architecture is `shared everything`, in which ***requests are satisfied by arbitrary combinations of nodes***. This may introduce contention, as multiple nodes may seek to update the same data at the same time. It also contrasts with [shared-disk](https://en.wikipedia.org/wiki/Shared-disk_architecture) and [shared-memory](https://en.wikipedia.org/wiki/Shared-memory_architecture) architectures.
- > SN eliminates [single points of failure](https://en.wikipedia.org/wiki/Single_point_of_failure), allowing the overall system to continue operating despite failures in individual nodes and allowing individual nodes to upgrade without a system-wide shutdown.
- > A SN system can scale simply by adding nodes, since no central resource bottlenecks the system. ***Another term for SN is `sharding`***. A SN system typically partitions its data among many nodes.
- > `Michael Stonebraker` at the University of California, Berkeley used the term in a 1986 database paper. Teradata delivered the first SN database system in 1983.
  >> The Case for Shared Nothing https://dsf.berkeley.edu/papers/hpts85-nothing.pdf

Shared disk architecture https://en.wikipedia.org/wiki/Shared_disk_architecture
- > A `shared disk architecture` (`SD`) is a distributed computing architecture in which all disks are accessible from all cluster nodes. 
- > It contrasts with [`shared nothing architecture`](https://en.wikipedia.org/wiki/Shared-nothing_architecture), in which all nodes have sole access to distinct disks, and with [shared-memory](https://en.wikipedia.org/wiki/Shared-memory_architecture), in which they also share memory. Multiple processors can access all disks directly via intercommunication network and ***every processor has local memory***.
- > Shared Disk has ***two advantages*** over Shared memory. Firstly, each processor has its own memory, the memory bus is not a bottleneck; secondly, the system offers a simple way to provide a degree of fault tolerance.

Shared-memory architecture https://en.wikipedia.org/wiki/Shared-memory_architecture
- > It contrasts with [shared-nothing architecture](https://en.wikipedia.org/wiki/Shared-nothing_architecture), in which each node has distinct memory and storage, and with [shared-disk architecture](https://en.wikipedia.org/wiki/Shared_disk_architecture), in which the nodes share the same storage but not the same memory.
  >> 【[:star:][`*`]】 //notes：所以其实 share-memory 就是所谓的 share-everything 了？

数据库架构设计的三种模式：share nothing , share everythong , share disk https://www.cnblogs.com/kzwrcom/p/6397709.html
- > Shared Everthting:一般是针对单个主机，完全透明共享CPU/MEMORY/IO，并行处理能力是最差的，`典型的代表SQLServer`
- > Shared Disk：各个处理单元使用自己的`私有 CPU和Memory`，共享磁盘系统。`典型的代表Oracle Rac`， 它是数据共享，可通过增加节点来提高并行处理的能力，扩展能力较好。其类似于`SMP（对称多处理）`模式，但是当存储器接口达到饱和的时候，增加节点并不能获得更高的性能 。
- > Shared Nothing：各个处理单元都有自己私有的CPU/内存/硬盘等，不存在共享资源，类似于`MPP（大规模并行处理）`模式，各处理单元之间通过协议通信，并行处理和扩展能力更好。`典型代表DB2 DPF和Hadoop` ，各节点相互独立，各自处理自己的数据，处理后的结果可能向上层汇总或在节点间流转。 <br> 我们常说的 `Sharding` 其实就是Share Nothing架构，它是把某个表从物理存储上被水平分割，并分配给多台服务器（或多个实例），每台服务器可以独立工作，具备共同的schema，比如MySQL Proxy和Google的各种架构，只需增加服务器数就可以增加处理能力和容量。

What are the differences between shared nothing, shared memory, and shared storage architectures in the context of scalable computing/analytics? https://www.quora.com/What-are-the-differences-between-shared-nothing-shared-memory-and-shared-storage-architectures-in-the-context-of-scalable-computing-analytics
- > Let me explain with an example.
  <br><br> Lets say you and your friend are tasked with solving 2 problems. You can use **blackboards** and **notebooks** as you solve the problems. You are expected to produce the solutions in the notebooks.
  <br><br> If you and your friend solve this in different classrooms, with different blackboards, and write the answer down in separate notebooks, this is **shared nothing** architecture -- each of you are solving the problem on your own. You could each solve one of the problems independently.
  <br><br> If you and your friend solve the problem in the same classroom with the same blackboard, so that you can see each other working through the problem, this is similar to **shared memory** architecture. You rub the blackboard clean when you finish, but it helps you both to solve the problems.
  <br><br> If you and your friend solve both problems together, and write down the solutions in the same notebook, it is similar to the **shared storage** architecture - you are sharing the notebook where the final solutions are going to be.
  <br><br> I am equating memory to the blackboard, and storage to your notebooks. Assuming you both know how to solve both problems, **shared nothing** architecture is going to be fastest -- you don't have to wait to use the blackboard or the notebook.

Parallel Programming - Architecture (Shared nothing, Shared disk, Shared Memory) https://gerardnico.com/data/concurrency/architecture
> ![](https://gerardnico.com/_media/data/concurrency/taxonomy_of_parallel_architecture.jpg)
>> 注：上图出自论文《Parallel Database Systems: The Future of Database Processing or a Passing Fad?》 https://www.microsoft.com/en-us/research/publication/parallel-database-systems-the-future-of-database-processing-or-a-passing-fad/ ***所以可见 `share disk` 和 `share memory` 是比 `share storage` 更正式的***。
