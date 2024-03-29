
# SSD general

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

SSD中，SATA、m2、PCIE和NVME各有什么意义呢？ - 知乎 https://www.zhihu.com/question/48972075

固态硬盘技术：什么是NVMe？有什么特点？ - 知乎用户fB10GU的文章 - 知乎 https://zhuanlan.zhihu.com/p/55236054

看完这篇，你就是选固态硬盘的高手 https://www.ithome.com/0/658/398.htm
- > 固态硬盘的总线包括三种：SATA 总线、PCIe 总线、SAS 总线。它们的传输速率及带宽数据参见下表。
- > 固态硬盘涉及到的协议有三种：AHCI 协议、NVMe 协议、SCSI 协议。SCSI 协议常用在服务器上，这里不作展开。生活中固态硬盘常涉及到的协议是 AHCI 和 NVMe，它们的具体原理比较复杂，这里依然以车辆在道路上行驶为例进行解释，AHCI 协议相当于一个限速 30 的指示牌，而 NVMe 相当于一个限速 60 的指示牌。
- 回复里的：
  * > 没写全啊 老式电脑上除了achi 还有个ata m2接口的还有E-key的硬盘 经常出现在工控机上
  * > 高手还要看颗粒、主控、温度、回收策略、缓外速度、4k、质保条件……
  * > 对我来说就是接口，缓存，颗粒类型，寿命BTW，温度，主控稳定性，掉盘0E几率，还有脏盘全盘写入速度曲线
  * > 所有固态在傲腾固态下都是渣渣！正常使用可以当传家宝！(不是傲腾加速盘) 不服来辩！
    >> 用过32G的傲腾，也就那么回事，设置可折腾了，有的主板兼容还不好，还占用一个M.2固态盘位，不如直接买M.2固态用得省心，你说的应该是傲腾混合固态盘，贵不说，速度也不如现在的PCIE 4.0的速度，现在英特尔直接将傲腾产品线都直接砍了，因为在PCIE的固态下毫无优势
    >>> 不是垃圾傲腾加速盘，也不是傲腾混合固态盘，就是傲腾固态，例如900p 905p 去测测4K，pcie4.0也比不上傲腾
    >>>> 那你去看看旗舰级别的pcie 4.0的4K呢，不差了吧，大文件读写都强傲腾好几倍了还在吹傲腾
    >>>>> 说这些有啥用，都停产了。就是因为太耐用，厂家没法做持续性生意了。真正能在市场上混得好的是厂家包括上下游和用户之间有一个性能价格平衡点。一旦打破平衡，应用范围就很窄。我公司的产品，我们可以在质量上做到真正的20年免维护。但是，没必要啊。产品可以低价卖，维护必须赚够。后期维护太赚钱了。

# 闪存

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
