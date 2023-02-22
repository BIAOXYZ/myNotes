
:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

Linux 中 CPU 利用率是如何算出来的 https://www.ithome.com/0/675/129.htm || https://mp.weixin.qq.com/s/40KWGKNBoa35s533YGWYIQ
- > **二、top 命令使用数据在哪儿**
  * > 接下来我们把每一步都展开来详细看看。
  * > 通过使用 `strace` 跟踪 `top` 命令的各种系统调用，可以看的到它对该文件的调用。
    ```sh
    # strace top

    openat(AT_FDCWD, "/proc/stat", O_RDONLY) = 4
    openat(AT_FDCWD, "/proc/2351514/stat", O_RDONLY) = 8
    openat(AT_FDCWD, "/proc/2393539/stat", O_RDONLY) = 8
    ```

Linux 中的负载高低和 CPU 开销并不完全对应 https://www.ithome.com/0/667/128.htm || https://mp.weixin.qq.com/s/1Pl4tT_Nq-fEZrtRpILiig
- > **一、理解负载查看过程**
  * > 我们经常用 `top` 命令查看 Linux 系统的负载情况。一个典型的 `top` 命令输出的负载如下所示。
    ```sh
    # top
    Load Avg: 1.25, 1.30, 1.95  .....
    ......
    ```
  * > 输出中的 **Load Avg** 就是我们常说的负载，也叫系统平均负载。因为单纯某一个瞬时的负载值并没有太大意义。所以 Linux 是计算了过去一段时间内的平均值，这三个数分别代表的是过去 1 分钟、过去 5 分钟和过去 15 分钟的平均负载值。
  * > 那么 `top` 命令展示的数据数是如何来的呢？事实上，`top` 命令里的负载值是从 `/proc/loadavg` 这个伪文件里来的。通过 `strace` 命令跟踪 `top` 命令的系统调用可以看的到这个过程。
    ```sh
    # strace top

    openat(AT_FDCWD, "/proc/loadavg", O_RDONLY) = 7
    ```
  * > 内核中定义了 `loadavg` 这个伪文件的 `open` 函数。当用户态访问 `/proc/loadavg` 会触发内核定义的函数，在这里会读取内核中的平均负载变量，简单计算后便可展示出来。整体流程如下图所示。
  * > ![](https://img.ithome.com/newsuploadfiles/2023/1/2989f096-8ca7-4519-93ca-6f468a669157.png)
  * > 我们根据上述流程图再展开了看下。伪文件 `/proc/loadavg` 在 kernel 中定义是在 `/fs/proc/loadavg.c` 中。在该文件中会创建 `/proc/loadavg`，并为其指定操作方法 `loadavg_proc_fops`。
- 回复里的：
  * > 请教：负载数字区间是0-100吗
    >> 占满4核就是400%
    >>> 答案就在原文中：负载是定时将每个 CPU 上的运行队列中 running 和 uninterruptible 的状态的进程数量汇总到一个全局系统瞬时负载值中，然后再定时使用指数加权移动平均法来统计过去 1 分钟、过去 5 分钟、过去 15 分钟的平均负载。 <br> 举个例子，5分钟内有100个进程在持续进行IO（陷入uninterruptible（D）状态），那load5肯定超过100了。但实际上CPU不怎么繁忙。

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
