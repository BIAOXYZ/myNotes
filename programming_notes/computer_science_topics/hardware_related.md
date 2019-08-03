
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

块存储、文件存储、对象存储这三者的本质差别是什么？ - 知乎 https://www.zhihu.com/question/21536660

原来PCIe这么简单，一定要看！ https://mp.weixin.qq.com/s/41xHLInKiZh5-JM5G6cgNA
- > 硬盘是大家都很熟悉的设备，一路走来，从HDD到SSD，从SATA到NVMe，作为NVMe SSD的前端接口，PCIe再次进入我们的视野。作为x86体系关键的一环，PCIe标准历经PCI，PCI-X和PCIe，走过近30年时光。其中Host发现与查找设备的方式却一脉沿袭，今天我们先来聊一聊PCIe设备在一个系统中是如何发现与访问的。

## SSD

大容量SSD有什么用途 是对系统有特别加成吗？ - 硬件 - cnBeta.COM https://www.cnbeta.com/articles/tech/718891.htm

异常断电为什么对SSD伤害这么大？ - 硬件 - cnBeta.COM https://www.cnbeta.com/articles/soft/746109.htm

# CPU

服务器中的u是什么意思 http://blog.chinaunix.net/uid-21505614-id-289333.html

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

# 笔记本

<<联想笔记本电脑 怎么能将第一排默认的是F1 F2............F12 按FN后才是设置功能 我打游戏不方便啊>>
https://zhidao.baidu.com/question/486620110.html
```
请以电脑启动时按F2，进入BOIS模式，进入第二项CONFIG，设置HOTKEY为DISABLE，就可以默认切换了！
```

# 台式机

2019年上半年如何攒机？一文看懂的攒机指南 https://www.ithome.com/0/411/255.htm

