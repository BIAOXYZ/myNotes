
# DMA

Direct memory access https://en.wikipedia.org/wiki/Direct_memory_access || 直接内存访问 https://zh.wikipedia.org/wiki/%E7%9B%B4%E6%8E%A5%E8%A8%98%E6%86%B6%E9%AB%94%E5%AD%98%E5%8F%96
- > 直接内存访问（Direct Memory Access，DMA）是计算机科学中的一种内存访问技术。它允许某些电脑内部的硬件子系统（电脑外设），可以独立地直接读写系统内存，而不需中央处理器（CPU）介入处理 。在同等程度的处理器负担下，DMA是一种快速的数据传送方式。很多硬件的系统会使用DMA，包含硬盘控制器、绘图显卡、网卡和声卡。

太慢不能忍，CPU 又拿硬盘和网卡开刀了 https://www.ithome.com/0/647/043.htm  【from `编程技术宇宙`】

DMA 技术是什么，在哪里用？看完绝对有收获 https://www.jianshu.com/p/3a26e8c9f402

DMA & RDMA 基本概念 https://zdyxry.github.io/2020/03/02/RDMA-%E6%A6%82%E5%BF%B5/

RDMA技术详解——DMA和RDMA概念 https://blog.csdn.net/u013253075/article/details/119842869

What is the difference between RDMA and DMA? https://stackoverflow.com/questions/34589423/what-is-the-difference-between-rdma-and-dma
- https://stackoverflow.com/questions/34589423/what-is-the-difference-between-rdma-and-dma/72331861#72331861
  * > DMA is usually accessing memory internal to the computer. RDMA is accessing memory of a computer across the network.
    + > `Direct memory access (DMA) is a feature of computer systems that allows certain hardware subsystems to access main system memory independently of the central processing unit (CPU).` -- https://en.wikipedia.org/wiki/Direct_memory_access
  * > ***Lots of cards implement DMA access to the computers memory to reduce the load on the CPU and improve performance, such as network cards, graphics cards, disk controllers, etc***. Most modern computers have a number of generic and task specific DMA controllers.
  * > Remote Direct Memory Access, RDMA, is the ability to get at a remote computers memory across the network potentially without CPU intervention. It is a network operation, as opposed to DMA which is usually internal to the computer or buses like Thunderbolt or PCIe. Newer network protocols such as NVidia (Mellanox) Infiniband or RoCE (RDMA over Converged Ethernet), support RDMA. This opens a set of newer ways to think about distributing problems. Arrays of GPUs or other custom FPGAs or ASICs can grab chunks of information from a computer to work on. There are newer disk drives that directly support NVMEoF, Non Volatile Memory Express over Fabric, that are connected directly over Infiniband or RoCE. You just connect your drives to network switches. With NVidia ConnectX-5, dual 100 Gbit, or ConnectX-6, dual 200 Gbit, links, you can connect your drives to network switches and have large arrays of drives. There are lots of vendors doing this, NVidia is just the one I have worked with.
  * > Not so many years ago an internal disk drive to a computer would transfer 100 Mbits/second. Now you can have massive arrays of drives connected at 100, 200, 400 Gbits/second.
