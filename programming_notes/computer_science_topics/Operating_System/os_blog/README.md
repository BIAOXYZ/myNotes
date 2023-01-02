
:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

Docker 容器里进程的 pid 是如何申请出来的？ https://www.ithome.com/0/664/923.htm || https://mp.weixin.qq.com/s/LDu6s1eZw6_xEwfa6pMM-A  【from `开发内功修炼`】
- > 前面我们在《Linux 进程是如何创建出来的？》中介绍了进程的创建过程。事实上进程的 pid 命名空间、pid 也都是在这个过程中申请的。我今天就来带大家深入理解一下 docker 核心之一 pid 命名空间的工作原理。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

上帝视角看进程调度 https://www.ithome.com/0/652/817.htm || https://mp.weixin.qq.com/s/zzGcNr59AJ3bqI9GF9xMqA

你管这叫 IO 多路复用？ https://www.ithome.com/0/645/683.htm || https://mp.weixin.qq.com/s/YdIdoZ_yusVWza1PU7lWaw  【from `低并发编程`】

Linux 0.11 第 6 回 | 段寄存器的历史包袱 https://www.ithome.com/0/645/025.htm || https://mp.weixin.qq.com/s/p1a6QxYZyMpJF__uBSE1Kg

Linux 0.11 第五回 | 进入保护模式前的最后一次折腾内存 https://www.ithome.com/0/644/932.htm || https://mp.weixin.qq.com/s/5s_nmrWRZbA_4mkNKOQ2Cg

Linux 0.11 第 4 回 | 把全部的操作系统代码从硬盘搬到内存 https://www.ithome.com/0/644/814.htm || https://mp.weixin.qq.com/s/hStc-y-sabP-KwJUDUesTw

Linux 0.11 第 3 回 | 做好访问内存的最基础准备工作 https://www.ithome.com/0/644/583.htm || https://mp.weixin.qq.com/s/90QBJ-lP_-du2qQJxNF-Fw

Linux 0.11 第 2 回 | 从 0x7c00 到 0x90000 https://www.ithome.com/0/644/371.htm || https://mp.weixin.qq.com/s/U-txDYt0YqLh5EeFOcB4NQ  【from `低并发编程`】

Linux 0.11 第一回 | 最开始的两行代码 https://www.ithome.com/0/644/055.htm  【from `低并发编程`】
- > 当你按下开机键的那一刻，在主板上提前写死的固件程序 BIOS 会将硬盘中启动区的 `512` 字节的数据，原封不动复制到内存中的 `0x7c00` 这个位置，并跳转到那个位置进行执行。
- > 启动区的定义非常简单，只要硬盘中的 `0 盘 0 道 1 扇区`的 512 个字节的最后两个字节分别是 `0x55` 和 `0xaa`，那么 BIOS 就会认为它是个启动区。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
