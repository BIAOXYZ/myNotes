
教科书《计算机体系结构基础》（胡伟武等，第三版）的开源版本 https://github.com/foxsen/archbase
- https://foxsen.github.io/archbase/

# others

## firmware related

What's the difference between hardware, firmware, and software? https://www.quora.com/Whats-the-difference-between-hardware-firmware-and-software
> Embedded microcontrollers using Flash memory to hold their programs can be updated in place using what is called in-circuit serial programming (ICSP). The programs are called firmware because it is easier to update than making hardware changes, but not as easy as just loading a program from a hard drive, and the programs are non-volatile.
>
> In a desktop or laptop PC, which runs software off of a hard drive or SSD etc., there is still a bit of firmware located in the computer’s BIOS, which handles the bootup process of the machine, loading the operating system into RAM and then giving control over to it.

Basic Difference Between Hardware and Firmware https://medium.com/@TeksunGroup/basic-difference-between-hardware-and-firmware-bae93c524c98
```
Key points of Hardware vs Firmware:

- A hardware has a physical entity and can undergo physical damage, unlike a firmware.
- A hardware needs a program to run. A firmware is a program itself.
- A hardware cannot operate without a firmware. A firmware operates on a hardware.
- A hardware can be reprogrammed. A firmware does not require reprogramming except for a few cases.
- Example of Hardware: Motherboard, RAM, Disk Drive, Sound Card.
- Example of Firmware: BIOS in IBM-Compatible PC, Timing and Control Mechanisms in Washing Machines, Sound and Video Controlling Attributes in Modern TVs.
```

## UEFI

What Is UEFI, and How Is It Different from BIOS? https://www.howtogeek.com/56958/htg-explains-how-uefi-will-replace-the-bios/
- Why the BIOS Is Outdated
  * > The traditional BIOS still has serious limitations. It can only boot from drives of 2.1 TB or less. 3 TB drives are now common, and a computer with a BIOS can’t boot from them. That limitation is due to the way the BIOS’s Master Boot Record system works.
  * > The BIOS must run in 16-bit processor mode, and only has 1 MB of space to execute in. It has trouble initializing multiple hardware devices at once, which leads to a slower boot process when initializing all the hardware interfaces and devices on a modern PC.
- How UEFI Replaces and Improves on the BIOS
  * > There’s no way to switch from BIOS to UEFI on an existing PC. You need to buy new hardware that supports and includes UEFI, as most new computers do. Most UEFI implementations provide BIOS emulation so you can choose to install and boot old operating systems that expect a BIOS instead of UEFI, so they’re backwards compatible.
  * > This new standard avoids the limitations of the BIOS. The UEFI firmware can boot from drives of 2.2 TB or larger—in fact, the theoretical limit is 9.4 zettabytes. That’s roughly three times the estimated size of all the data on the Internet. That’s because UEFI uses the GPT partitioning scheme instead of MBR. It also boots in a more standardized way, launching EFI executables rather than running code from a drive’s master boot record.

# Storage

RAID https://zh.wikipedia.org/wiki/RAID

【IT之家学院】令硬盘速度翻倍还更安全：Raid到底是啥？ https://www.ithome.com/0/414/101.htm

原来PCIe这么简单，一定要看！ https://mp.weixin.qq.com/s/41xHLInKiZh5-JM5G6cgNA
- > 硬盘是大家都很熟悉的设备，一路走来，从HDD到SSD，从SATA到NVMe，作为NVMe SSD的前端接口，PCIe再次进入我们的视野。作为x86体系关键的一环，PCIe标准历经PCI，PCI-X和PCIe，走过近30年时光。其中Host发现与查找设备的方式却一脉沿袭，今天我们先来聊一聊PCIe设备在一个系统中是如何发现与访问的。

关于存储技术的入门科普 https://www.ithome.com/0/500/495.htm

## 块存储 vs 文件存储 vs 对象存储

块存储、文件存储、对象存储这三者的本质差别是什么？ - 知乎 https://www.zhihu.com/question/21536660
- 块存储、文件存储、对象存储这三者的本质差别是什么？ - Alluxio的回答 - 知乎 https://www.zhihu.com/question/21536660/answer/2552351492

干货科普：大火的「对象存储」到底是什么 https://www.ithome.com/0/501/133.htm

文件存储、块存储还是对象存储？ https://www.redhat.com/zh/topics/data-storage/file-block-object-storage

分布式存储：你知道对象存储是如何保存图片文件的吗？ https://zq99299.github.io/note-book/back-end-storage/03/04.html

块存储 https://www.ibm.com/cn-zh/cloud/learn/block-storage

## disk

硬盘基本知识（磁头、磁道、扇区、柱面） https://www.cnblogs.com/jswang/p/9071847.html
- > 硬盘中一般会有多个`盘片`组成，每个盘片包含`两个面`，每个盘面都对应地有一个读/写`磁头`。受到硬盘整体体积和生产成本的限制，盘片数量都受到限制，一般都在5片以内。盘片的编号自下向上从0开始，如最下边的盘片有0面和1面，再上一个盘片就编号为2面和3面。
- > 下图显示的是一个盘面，盘面中一圈圈灰色***同心圆***为一条条`磁道`，从圆心向外画直线，可以将磁道划分为若干个弧段，每个磁道上一个***弧段***被称之为一个`扇区`（图践绿色部分）。***扇区是磁盘的最小组成单元***，通常是512字节。（由于不断提高磁盘的大小，部分厂商设定每个扇区的大小是4096字节）
- > 硬盘通常由重叠的一组盘片构成，每个盘面都被划分为数目相等的磁道，并从外缘的“0”开始编号，具有相同编号的磁道形成一个圆柱，称之为磁盘的`柱面`。***磁盘的柱面数与一个盘面上的磁道数***是相等的。由于每个盘面都有自己的磁头，因此，***盘面数等于总的磁头数***。
- > 存储容量 ＝ 磁头数 × 磁道(柱面)数 × 每道扇区数 × 每扇区字节数
- > 每个磁道的扇区数一样是说的老的硬盘，外圈的密度小，内圈的密度大，每圈可存储的数据量是一样的。新的硬盘数据的密度都一致，这样磁道的周长越长，扇区就越多，存储的数据量就越大。
- > 读写一次磁盘信息所需的时间可分解为：寻道时间、（旋转）延迟时间、（数据）传输时间。为提高磁盘传输效率，软件应着重考虑减少寻道时间和延迟时间。

## SSD

为什么说固态硬盘的4K性能很重要？ - 木头龙的文章 - 知乎 https://zhuanlan.zhihu.com/p/93032287
- > **前言**
  * > 很多对硬件有所了解的朋友，都知道把电脑的机械硬盘升级成固态硬盘，开机、打开程序/文件都会快很多；再深入一点的，知道看固态硬盘好不好，要看随机4K访问的性能；但如果再问，随机4K性能是什么？为什么要看随机4K性能？有些测试软件有好几个随机4K性能看哪个？能回答上来的人可能就不多了。
  * > 这篇文章，我给大家介绍一下操作系统是怎么访问一个硬盘上的文件的，了解了操作系统访问文件的过程，我们就会知道为什么固态硬盘的4K性能可以大幅提高访问文件的速度了——而开机、打开程序/文件，对于硬盘来说，都不过是访问硬盘上不同的文件而已。

大容量SSD有什么用途 是对系统有特别加成吗？ - 硬件 - cnBeta.COM https://www.cnbeta.com/articles/tech/718891.htm

异常断电为什么对SSD伤害这么大？ - 硬件 - cnBeta.COM https://www.cnbeta.com/articles/soft/746109.htm

IT之家学院：SSD 固态硬盘求真记 https://www.ithome.com/0/468/724.htm
- > 这两种路就是总线，其中比较窄的路是SATA总线，比较宽的路是PCIe总线。
- > 当然，要想货物运得快，不仅路要宽敞，交通工具也要先进才行。现在有两种交通工具，一种是拖拉机，另一种是大货车。这两种交通工具对应SSD里的传输协议。拖拉机可以理解为AHCI协议，而大货车是NVMe协议。显然，大货车比拖拉机速度快多了。
- > 这些厂家开的订单窗口就可以理解为SSD的物理接口。小厂家的就叫SATA接口，大厂家的就叫M.2接口。
- > 首先，我们规定，大货车不能往乡间小路上跑，也就是NVMe协议的硬盘不能走在SATA通道上。正常情况下，拖拉机也不能上高速的。就是AHCI协议硬盘也不能走在PCIe通道上。不过，很早的时候是有这种情况的，现在基本看不到了。

固态硬盘的PCIE，SATA，M2，NVMe，AHCI https://www.cnblogs.com/yi-mu-xi/p/10469458.html

### 闪存

固态硬盘SSD与闪存（Flash Memory） https://www.cnblogs.com/ghj1976/p/3642260.html

闪存和固态硬盘有什么区别和共同点？ - 北极的回答 - 知乎 https://www.zhihu.com/question/32251227/answer/55309032
```
U盘=USB控制器+闪存控制器+FLASH
固态硬盘=硬盘控制器+FLASH
FLASH一般就是各种闪存芯片，一般都是NAND的片子。

所以，U盘和SSD是加了控制器的闪存，而影响闪存速度的是控制器的性能，比如SSD性能高于
U盘，主要靠的不是闪存的速度而是控制器的实现。
补充一点：高速U盘用的其实是硬盘机的主控芯片，所以才比一般U盘速度要快，SSD的主控一般
都是32位的芯片，而山寨U盘一般是量产的8位芯片，性能差别是非常大的。
```

内存和闪存的区别是什么？ - 张冬的回答 - 知乎 https://www.zhihu.com/question/24759973/answer/29728428
- > 内存RAM使用寄生电容充放电来表示0和1，充了电的电容需要不断的被充电维持状态，否则很快漏电，所以需要持续供电，但是速度块。
- > Flash闪存使用MOS管中间的一个绝缘体包括层来储备电子，充电之后可以长期保存，外部使用sense amp比较放大器来感受每个MOS管内的状态，从而输出0和1状态，断电后数据依然保存，比RAM慢一个数量级，但是比磁盘快多个数量级。

一文读懂热插拔 https://www.ithome.com/0/467/290.htm
- > 可能有IT之家小伙伴会好奇，那么为什么键盘鼠标这样的外设可以直接用手拔插，U盘就建议大家弹出了呢？
- > 那是因为，U盘这样的存储设备是有缓存空间的，例如文件传输到U盘上，会先写到高速的缓存中，再存到闪存芯片中，所以有时候系统提示文件已经传完了，但可能U盘其实还在读写。
- > 从实现的角度来讲，热插拔其实是一个软硬件结合的过程。
- > 总线，可以理解为计算机各种功能部件之间传送信息的公共通信干线。可以分为片总线，内总线和外部总线。其中外部总线是指系统总线，即CPU与存储器、I/O系统之间的连线，外部设备和它直接相关。
- > 在接口电路设计方面，如图，当外部设备插入系统时，会有一个很大的瞬时电流向输入电容充电，这可能导致电路损坏。热插拔电路设计的目的就是把这个瞬时电流控制在合适的水平。  

### 数据

AMD 与群联演示 PCIe 5.0 M.2 SSD，顺序读写破 10GB/s https://www.ithome.com/0/633/012.htm
- > 据报道，本次展示的 PCIe 5.0 SSD 为 M.2 规格，采用的是美光 232 层 B58R TLC 闪存，由于这款闪存还在调整阶段，这款 SSD 的速度仅突破 10GB / s，最终成品应该可以实现 12/11 GB / s 的顺序读 / 写速度。
- 回复里的：
  * > 顺序读写卷上天，一看4k美如画
  * > 随机提升一下吧，现在的顺序提升已经没啥感知了。
    >> 随机速度提升很难，主要受存储材质的物理限制

# 内存

内存标签上这串数字，暗藏了内存工作的“秘密” https://www.ithome.com/0/427/495.htm

## 内存寻址

内存寻址 https://liam.page/2016/05/01/Introduction-to-Memory-Addressing/

***内存寻址中一个经典问题，之前就知道，但是其实没完全想清楚***：一个bit有0和1两种取值，那么32位机器能表示的内存是`2^32 {bit}`，但是我们平时说的`GB`可是`(B)byte`啊，不应该是`2^32 {bit} = (2^32)/8 {byte} = 0.5GB`才对吗？
- 详解为什么32位系统只能用4G内存 https://blog.csdn.net/nvd11/article/details/8749375
  * > 但是问题来了，我刚说了内存里的格子数量非常巨大，如果cpu要读出某个指定的数据，怎么去找呢？1个1个格子去遍历吗，其实稍微接触过数据结构的都知道，遍历虽然实现简单，但是在海量数据面前简直是自杀行为。所以实际上内存是把8个bit排成1组，每1组成为1个单位，大小是1byte(字节），cpu每一次只能访问1个byte，而不能单独去访问具体的1个小格子(bit). 1个byte字节就是内存的最小的IO单位.
  * > 那么内存地址的长度是多少呢? 这个就是这篇文章标题所涉及的. 在32位操作系统中, 内存的地址就是32位的2进制数, 
  * > 那么2^32到底是多少个？2^32 = 4 * 1024(G) * 1024(M) * 1024(K) = 4294967296, 就是4G啊, 而每1个地址对应1个1个字节，容量就是1byte，所以2^32个地址就总共能对应应4GB的内存容量啊，这里的B指的是byte字节啊。
- Why does a 32-bit OS support 4 GB of RAM? https://stackoverflow.com/questions/1119278/why-does-a-32-bit-os-support-4-gb-of-ram
```
  1. 32bits can represent numbers 0..2^32 = 0..4,294,967,296
  2. 32bits can address up to 2^32Bytes (assuming Byte-size blocks)
  3. 2^32Bytes is the max size
2^32B = 4,194,304KiB = 4,194MiB = 4GiB
```
>> notes：从这两个回答里简单总结下就是：CPU访问内存的**最小单位是byte而不是bit**；32位就是**32条地址总线**，一共能表示**2^32个数字**，这里每个数字对应到一个**内存地址**；每一个内存地址**对应一个字节（而不是每一个内存地址对应一个bit，这是根因所在）**。所以能表示的最大内存是**2^32个字节**，也就是4GB。

## 傲腾Optane

应对数据爆炸时代，英特尔又放大招 https://mp.weixin.qq.com/s/Gt2WqDqoLahdUA_UF06tdg

Intel 傲腾是怎样工作的，为什么叫做内存，配合机械盘能不能媲美 NAND SSD ？ - 知乎 https://www.zhihu.com/question/58976033

# RDMA

Remote direct memory access https://en.wikipedia.org/wiki/Remote_direct_memory_access

深入浅出全面解析RDMA - 围城的文章 - 知乎 https://zhuanlan.zhihu.com/p/37669618

RDMA技术详解（一）：RDMA概述 - 围城的文章 - 知乎 https://zhuanlan.zhihu.com/p/55142557

# 服务器

主流服务云端对决：华为云HECS/阿里云S6谁更强 https://www.ithome.com/0/484/123.htm 【这个其实也是恰饭文，但是不考虑其立场，仅看知识】
```
聊天室2020/4/23 21:03:06
vultr的6美金高io机型能跑900M+

Versvck2020/4/23 20:40:44
一台说明不了问题，这取决于当时VM所在的物理NC的负载

ITITIT2020/4/23 19:34:39
性能指标是一方面，管理的方便性也是非常重要的。我们公司两种都有，不过华为云服务器不归我管，
我不太清楚管理是不是方便，阿里云管理方面是非常方便的。

挑战性的bug2020/4/23 18:24:05
不过，s6不是共享型吗，CPU性能不行的，内网带宽也稍低，感觉应该和c6来比
```

鲲鹏云服务器实战：华为云鲲鹏KC1实例 vs. 阿里云G5实例 https://www.ithome.com/0/444/828.htm
- > 我们使用Unixbench对这两款服务器进行性能跑分，
- > 再来看二者内存性能的表现。内存方面，不同厂家对内存选取也不同，出于节省成本的考虑，云服务器厂商往往很少公布内存的频率和型号，这里我们通过stream工具进行测试。
- > 现阶段的处理器一般都有三级缓存，处理器在取数据的时候会优先从最靠近的缓存开始，取不到再去内存取数据。越靠近处理器，取数据的速度越快，通过LMBench等工具我们能精准的刻画这种读取的延时，也就是我们说的内存时延，不同缓存的时延呈现的是指数级增长，在对应的缓存中，时延是稳定的。
- > 这里我们首先使用netperf工具对这两家服务器运营商内网间TCP带宽性能进行测试。这里我们需要在各个主机中开启2台陪练机，测试机与2台陪练机均安装netperf，测试机做Server，陪练机做Client负责打流。
- > 当然，除了内网的带宽，时延也是一个重要的参数。延迟决定系统每秒处理的最大请求数，而带宽决定了可支撑的最大负荷。qperf和iperf/netperf一样可以评测两个节点之间的带宽和延时。可以在测试tcp/ip协议和RDMA传输。不过相比netperf和iperf，支持RDMA是qperf工具的独有特性。在CentOS中安装qperf比较简单，直接使用yum工具就能直接安装。
- > 我们这次针对两家厂商的超高IO云盘/SSD盘进行测试，测试所使用的工具为fio，测试项目包括随机读写IOPS和顺序读写吞吐量，测试磁盘大小均为1000GB。
```
// 上面原文的内容主要是为了记一下涉及到的工具，后面可能用得着。下面则是评论区里的回复。
// 其实这种对标在数据库性能测试里见多了，所以不会怎么信的，主要就是记下工具学点东西。

14717651222019-9-12 15:53:16
应该使用spec2017在相同的环境进行测试，这样更有说服力，而且最好在非虚拟机环境下测试，因为很多云服务商会对CPU性能进行限制。
编译时不同参数会影响代码的优化策略，所以应该列出来编译参数。
引用spec官网的话，一个好的benchmark应该是这样的：发不了网址，自己去spec官网看吧What is a (good) benchmark?
直接买vps测试无法较为准确测出性能，因为这台机器往往是很多其他人正在用，结果没有参考意义

efferz2019-9-12 18:01:23
SPEC2017的成绩要发到官网的才是可以参考的，其他的都是estimate

14717651222019-9-12 18:22:36
回复3# efferz：对的，要符合一堆rules，而且base更有参考价值。

efferz2019-9-12 22:22:35
回复4# 1471765122：base不能开Profile Guide Optimiztion，但实际应用程序中PGO已经很普及了。例如Chrome从53版本开始编译引入PGO，性能提升14.8%，从SPEC2017来看，PGO对解释型语言和XML处理确实有加成(Peak)

陌生老朋友2019-9-12 16:43:21
虽然都是最大20Gbps,具体配置下的华为没有写,
阿里G5规格写的很清楚,20Gbps是该系列最高内网速度(需要64C/256G实例), 但4C16G实例下,内网速度是1.5Gbps 18万K明明跑的很满一点都没差了, 这哪有一丁点的公平公正?之前那篇文章就这么搞(田忌赛马,拿华为次旗舰对比阿里次入门系列), 真恶心

落花依旧水依寒2019-9-12 17:25:50
就算我不是非专业人士
就算我知道计算型C5没有4*16的
你也不能用通用型G5替换计算型C5的理由啊

efferz2019-9-12 17:59:10
Dhrystone很容易编译器过度优化，我在E5 2620v4上用icc 2019 O3，单核3.0G，一秒可以跑62160064次，折合为DMIPS是35378DMIPS，11.8DMIPS/MHz。SKL可以跑到13.7DMIPS/MHz。
```

# HCI (Hyper Converged Infrastructure / 超融合基础架构)

Hyper-converged infrastructure https://en.wikipedia.org/wiki/Hyper-converged_infrastructure

深度剖析——超融合架构应用与实践分享 https://community.qingcloud.com/topic/345/%E6%B7%B1%E5%BA%A6%E5%89%96%E6%9E%90-%E8%B6%85%E8%9E%8D%E5%90%88%E6%9E%B6%E6%9E%84%E5%BA%94%E7%94%A8%E4%B8%8E%E5%AE%9E%E8%B7%B5%E5%88%86%E4%BA%AB

什么条件下适合使用超融合架构产品，包括Nutanix等？ - 知乎 https://www.zhihu.com/question/44203035

# 其他

再次拯救摩尔定律：一文了然 GAA 芯片技术 https://www.ithome.com/0/513/206.htm

海底光缆，到底是怎么安装和维护的？ https://www.ithome.com/0/442/997.htm
