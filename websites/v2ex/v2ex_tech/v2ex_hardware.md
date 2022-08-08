
Linux 高速写入的性能问题 https://www.v2ex.com/t/871334

不懂就问： 32 位操作系统是如何突破 4G 内存限制的？ https://www.v2ex.com/t/713933

SSD 有风险，存储重要数据需谨慎。 https://www.v2ex.com/t/695160
- > ![](https://i.imgur.com/YANIsVb.png)

Linux 下如何关闭 CPU cache？ https://www.v2ex.com/t/691081

Linux 内核如何在启动时配置参数到/sys/bus/pci/devices https://www.v2ex.com/t/684233

MAC 地址会消耗光吗？它与 IP 有没有可比性？ https://www.v2ex.com/t/681010
- > mac 只要在同一网关下不重复就行，就像通过省长 /市长 /村长来找人，人名就够了
- > 跨了 3 层交换机 mac 地址就没用了。。 你觉得呢
- > 为什么 Mac 地址不需要全球唯一 https://draveness.me/whys-the-design-non-unique-mac-address/

请教如何查询一个试图登录 Linux 的机器 MAC 地址 https://www.v2ex.com/t/680864
- > 局域网可以用 arp 请求
- > mac 地址是二层的。。。 建议你回去看看 OSI 七层模型
- > 网站？那基本都是跨三层访问吧，源 MAC 地址信息早就丢失了，除非像某些防火墙那样拿 SNMP 去用户侧网关上取。但一般主机的策略只做到三层（ IP ），二层（ MAC ）策略交给网络设备。
- > 在不考虑代理的情况下，数据包每到一个三层，就把源 MAC 替换成自己的出接口 MAC，目标 MAC 替换成下一跳 MAC，不跨三层不替换。所以你的需求不科学，或者你的网站只在纯二层提供访问？

出于好奇：代码只如何运行的？或者说更底层的一些东西是如何实现的？ https://www.v2ex.com/t/659337
- > 严重推荐你一本《编码: 隐匿在计算机软硬件背后的语言》(code: the hidden language of computer hardware and software)，作者是 Windows 编程界传奇人物 Charles Petzold。书从两个小孩用手电筒一亮一暗打暗号给你讲起，你会逐渐明白代码是如何转换成电信号，这些电信号又如何存储、作用在硬件上

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

不小心把 iso 文件 cp 到硬盘… https://www.v2ex.com/t/626910
```console
本来想弄个 Debian 10 的启动盘，不小心把 iso 文件 cp 到 sda （正确应该是 cp 到 sdb ）…就是执行了一下命令：
sudo cp ~/Download/debian-10.2.0-amd64-i386-netinst.iso /dev/sda

幸好第一个分区是 Windows，没伤及 Ubuntu 系统分区。唉，心塞…明天再恢复分区表吧
```
- > lsblk 看清楚再打字
- > 类似的还有 dd 的 if of 反了，233。
- > /dev/sda 是设备啊，又不是文件系统里的目录，不能接受文件 cp 吧？
  >> @dandycheung #4 所以这里的 cp 就变成了把 iso 文件写入数据到设备，而不是复制 iso 文件到某个目录
- > 复制最后一个参数一般是目录或者文件，楼主直接写设备也是骚操作
  >> @mikeguan #9 这是官方教程的命令，用于生成 U 盘启动盘。操作是没问题的，只是我搞错了设备

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

龙芯 & Golang！ https://www.v2ex.com/t/606364

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
