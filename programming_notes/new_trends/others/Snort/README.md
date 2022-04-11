
# 官方

Snort (software) https://en.wikipedia.org/wiki/Snort_(software) || Snort https://zh.wikipedia.org/wiki/Snort

Snort 3 is available! https://www.snort.org/

Snort++ https://github.com/snort3/snort3
- DOCUMENTATION https://github.com/snort3/snort3#documentation
- Snort.conf examples https://www.snort.org/documents/snort-conf-examples

# 安装

How to Install Snort on Ubuntu 20.04 https://linoxide.com/install-snort-on-ubuntu/ + Ubuntu 20.04 Playground https://www.katacoda.com/courses/ubuntu/playground2004
```sh
# 个人实战版，有些语句和原文里不太一样

sudo apt update
sudo apt install -y build-essential libpcap-dev libpcre3-dev libnet1-dev zlib1g-dev luajit hwloc libdnet-dev libdumbnet-dev bison flex liblzma-dev openssl libssl-dev pkg-config libhwloc-dev cmake cpputest libsqlite3-dev uuid-dev libcmocka-dev libnetfilter-queue-dev libmnl-dev autotools-dev libluajit-5.1-dev libunwind-dev
mkdir snort-source-files
cd snort-source-files/

git clone https://github.com/snort3/libdaq.git
cd libdaq
./bootstrap
./configure
make
make install

cd ../
wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.9/gperftools-2.9.0.tar.gz
tar xzf gperftools-2.9.0.tar.gz 
cd gperftools-2.9.0/
./configure
make 
make install

cd ../
git clone https://github.com/snortadmin/snort3.git
cd snort3/
./configure_cmake.sh --prefix=/usr/local --enable-tcmalloc
cd build
make
make install
sudo ldconfig
sudo ln -s /usr/local/bin/snort /usr/sbin/snort
snort -V
```

# 视频

创建带有Snort规则的检测系统 https://www.bilibili.com/video/BV1cA411G7t5

开源入侵检测工具snort的简单实验 https://www.bilibili.com/video/BV1oS4y197Ud

Snort 3 引擎Deep Dive https://www.bilibili.com/video/BV1Vb4y1W7Tj

4.如何使用snort IDS和sgui https://www.bilibili.com/video/BV1bS4y1378z

## Open_Source_IDS

玩转Snort报警可视化 https://www.bilibili.com/video/BV1nh411b7yu

玩转Snort前端—Snowl https://www.bilibili.com/video/BV1XT4y1C7wS

用BASE工具管理四百万条Snort安全事件 https://www.bilibili.com/video/BV1AK4y1V7bK

# 已阅

【[:star:][`*`]】 Snort入侵检测系统简介 https://www.jianshu.com/p/113345bbf2f7

# from CSDN

https://blog.csdn.net/qq_43968080/category_9417149.html
- Snort的使用一：安装、嗅探与记录 https://blog.csdn.net/qq_43968080/article/details/103376873
- Snort的使用二：入侵检测与规则编写 https://blog.csdn.net/qq_43968080/article/details/103378952

snort https://blog.csdn.net/gggyl111/category_10731440.html
- Snort入门（一） https://blog.csdn.net/GGGYL111/article/details/112510623

Snort Rules & Scapy——疯狂踩坑的第一次尝试 https://blog.csdn.net/wu_tongtong/article/details/123610153
- snort2.9规则-学习笔记 https://blog.csdn.net/weixin_44813582/article/details/105918523

snort：预处理器开发HelloWorld https://blog.csdn.net/weixin_43249758/article/details/105524164

snort 日志 mysql_Snort日志输出插件详解 https://blog.csdn.net/weixin_42489917/article/details/114469840

snort的安装、配置和使用 https://blog.csdn.net/qq_37865996/article/details/85088090

# `snort.conf`

Where is the location of snort.conf https://serverfault.com/questions/158438/where-is-the-location-of-snort-conf

# 其他

Snort安装使用中文手册 https://www.wangan.com/docs/snortnet

Snort的安装以及使用实验 https://blog.51cto.com/u_15127588/2807708

snort原理、搭建与应用 https://www.jianshu.com/p/44424498c51c

开源IDS与IPS的搭建与使用: Snort - 可信研究院 https://www.istt.org.cn/NewsDetail/2045553.html

Linux下安装入侵检测系统—Snort https://www.lxlinux.net/6678.html
- > snort使用 ***数据采集器(daq)*** 监听防火墙数据包队列，所以按照daq。需预装的程序有：flex、bison、libcap。

使用Snort检测企业流量 https://green-m.me/2018/01/05/network-detection-with-snort-in-company/

Snort: 5 Steps to Install and Configure Snort on Linux https://www.thegeekstuff.com/2010/08/snort-tutorial/

Configure Snort IDS and Create Rules https://linuxhint.com/configure-snort-ids-create-rules/

# 问题处理

Linux Snort ERROR: Can‘t start DAQ (-1) - SIOCGIFHWADDR: No such device! https://blog.csdn.net/xcyja/article/details/110503124

Linux Snort ERROR: Active response: can‘t open ip! https://blog.csdn.net/xcyja/article/details/110498589
- > 参考：https://stackoverflow.com/questions/34380208/snort-error-active-response-cant-open-ip
