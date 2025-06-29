
突破浏览器极限：我花了 4 年时间，开发了一个在浏览器上运行的操作系统！ https://www.v2ex.com/t/1137949
```console
大家好，我是 pikay 。四年前我在 V2EX 上发过一个帖子（《想做一个操作系统，问问大家意见》），用了很多业余时间和非业余时间，终于把它搞出来了！它叫 NoneOS，现在已经有了一个初步可用的 Demo ，现在就分享出来给大家试试看。（记得挂梯子）

https://os.tutous.com/
```
- > https://win11.blueedge.me/
  >> 这个之前玩过，那个系统只是玩的，我这个是要做成私人 NAS 系统。😂
- > https://webvm.io/
  >> 这个虚拟 linux 知道，但是我并不是想做这种从机器码开始虚拟的操作系统，是想做类似 Firefox OS 的 Gaia 层的东西，或者 chrome os 的应用虚拟层。😂

Centos 7 真是低配小鸡的福音！ https://www.v2ex.com/t/1117168
```console
之前买了一个 1 核 512MB 的小鸡，安装 debian 11 系统，发现启动某些服务，结果服务死活起不来，最后查看内核日志，发现是被系统进程 kill 掉了，
原因是可用内存不足，一看系统内存，已用内存 230M ，可用内存 96M ，这还只是开机后的状态，装 ubuntu 14.04 也是差不多的情况，后面干脆直接吃灰快大半年。

上周末闲着无事，就尝试用 Centos 7 构建那服务，好多服务不能直接 yum ，直接编译安装各种组件坑了我大半天，结果运行还真跑起来了。
Centos 7 启动后已使用内存只占 86M ，可用内存还有 200M 多 M ，最后服务跑起来才占 100 多 M 内存，Centos 7 果然是香！！！
```
- > FreeBSD 也行，而且适合养老，服务挂号几年不用管没问题（
- > 抛开使用难度的话，alpine 或者 debian i686 是最适合低配（<512M ）机器的
- > CentOS 7 是 2014 首发的，对应的 Debian 版本是 7 到 8 之间。
- > 确实，centos7 适合小内存，之前我 AMD1C1G 的 oracle Linux 刚开通，啥都没装就卡的要死。换了 centos7 后立马不卡了。
- > alpine 系统才是更小的，我 128M 甚至 64M 的都可以跑起来

Linux 写时复制问题 https://www.v2ex.com/t/1069433

请教一个 winodows 下 cpu 核心配分问题 https://www.v2ex.com/t/1041235
```console
windos10 环境下,有一颗 10 核心 20 线程的 cpu.为什么每次启动不同任务的时候,核心 1 总是负载很高?
注意哈,我的意思是我启动不同的任务的时候,他总是搞不犹豫的选择核心 1!
正常来说,核心 1 上已经有负载了,不应该到负载低的核心上吗?
再不济,你随机选一个核心也行啊?为什么非得选择核心 1 呢?
有什么那么一个程序,可以让我每次启动的时候,随机分配一个核心跑?
```
- > 如果你启动的程序不是启动器之类的还要启动主要程序，直接写一个 bat 批处理就能随机分配核心，所需指令 start /affinity 。bat 伪随机数怎么生成直接网上 copy 代码
- > 为啥纠结这种问题。Windows 使用复杂的算法来决定哪个进程或线程应该在哪个核心上运行，某些应用程序可能被设计为更倾向于使用特定的可用的核心，而不是随机选择。
- > 一般来讲，使用 Windows API 亲和性函数 SetProcessAffinityMask 来将当前进程绑定到选定的核心上
- > 命令行：`START /AFFINITY 1 "C:\Path\To\YourProgram.exe"` <br> Ref: https://stackoverflow.com/questions/7759948/set-affinity-with-start-affinity-command-on-windows-7

Memory used 很高 但是 top 却查不到高消耗的进程 https://www.v2ex.com/t/1034590
- > 可能有硬件驱动，直接 map 了物理内存，看 `directmap` 能看出来。以前碰到过类似的问题，因为 huge page，网卡驱动有 bug，ringbuf 占用了大量物理内存。
- > ***在操作系统角度来看，物理内存除了分配给用户空间进程使用***，还要给内核任务、硬件外设和 cpu 交换（ `dma` ）、文件系统 buffer/cache 、内核内存算法还有开销。 <br> ***所以只看资源管理器或 `top` 里面的用户进程不一定能查到内存消耗在哪里了***。那个设备的内核内存开销也不正常，`cat /proc/slabinfo` 看看。

Linux 内核该怎么学啊？ https://www.v2ex.com/t/932062
- > 同济大学赵炯编著的《 Linux 内核完全注释》 <br> 中文版：www.oldlinux.org/download/CLK-5.0-WithCover.pdf <br> 英文版：www.oldlinux.org/download/ECLK-5.0-WithCover.pdf
  >> 【[:star:][`*`]】 //notes：这两本书是真的牛，都是一千多页。。。
- > 看 xv6?
- > 1.跟着 mit 6.s081 做完 lab ，主要学 `gdb` 怎么用 `qemu` 调试内核，还有一些 C 的语法，启动、RV ISA 相关的感觉可以跳过。 <br> 2.南大的 ICS Lab 也不错，如果 xv6 感觉语言有困难的话，可以先看看 ICS 。 <br> 3.熟悉了简化的内核后，可以基于 upstream kernel 写几个内核模块，比如通过 sysfs 操作 GPIO 点亮跑马灯啥的。 https://sysprog21.github.io/lkmpg/ <br> 4.之后就看你有啥需求了，实现需求。 <br> 书大多都很老，分析代码最好跟着 upstream kernel 的代码自己一点点分析，用到啥分析啥就行。工具的话，vscode + `ripgrep` + `fdfind` 足够了。

各位吴彦祖，有推荐的 Kernel 相关的书籍推荐吗？ https://www.v2ex.com/t/798111
- > 不知道你想学什么以及到什么阶段了，general 来说很推荐 MIT 6.S081 https://pdos.csail.mit.edu/6.S081/2020/schedule.html 把 lab 刷完可以学到 syscall, memory allocation, multi threading, file system, network 相关的基础知识
- > 想了解 Kernel Module 开发的话，也可以看看 The Linux Kernel Module Programming Guide https://github.com/sysprog21/lkmpg
- > 有一本入门书，Linux 内核设计与实现，书不厚，记得 200 多页，让你对内核常见模块有个认识。如果想深入，建议直接看代码，编译代码调试，观察
- > 如果非常喜欢内核的话，推荐两本厚书，讲得比较透：linux 内核完全注释-0.11 版，深入 linux 架构

The Linux Kernel Module Programming Guide 升级至 5.0 版并开源！ https://www.v2ex.com/t/797371
```console
台湾成功大学助理教授 黄敬群 (Jim Huang, jserv) 近期将 The Linux Kernel Module Programming Guide (Linux 内核模块编程指南) (针对 Linux Kernel 2.6) 
的内容升级到最新的 kernel versions (v5.x)。

并且大方的开源 LaTeX 、PDF 至 GitHub 上，欢迎对 Linux 内核感兴趣的伙伴们，可以阅读学习。GitHub 项目连结 
https://github.com/sysprog21/lkmpg
```
- > 可以參考下
  * > https://github.com/sysprog21/lkmpg/tree/master/examples
  * > https://github.com/sysprog21/lkmpg/blob/master/lkmpg.tex

Linux 环境编程有什么经典教材吗 https://www.v2ex.com/t/761355
- > 如果不写驱动和内核，看《 The Linux Programming Interface 》这一本就够了，虽然这一本也还是有点老，但是写 Linux 下的应用也够了。
- > 简短的就 APUE 。大部头的就 TLPI，1500 页
- > apue 只讲 posix，tlpi 除了 posix 的部分还要讲 linux 特有的部分，算是 apue 的超集吧。你可以先看 apue 再看 tlpi，不冲突的

首届 eBPF.io Summit 2020 见闻 https://www.v2ex.com/t/720992
- > Linux 内核之旅开源社区（ http://kerneltravel.net ，西安邮电大学陈莉君老师创办）在 eBPF 方面做了很多研究，还有一个 ebpf 的开源项目，有兴趣的可以去看看，顺带给个 star，谢谢~
<br> https://github.com/linuxkerneltravel/lmp

内核态用户态的数据拷贝,有点不明白 https://www.v2ex.com/t/687113
