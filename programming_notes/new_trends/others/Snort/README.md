
# 官方

Snort (software) https://en.wikipedia.org/wiki/Snort_(software) || Snort https://zh.wikipedia.org/wiki/Snort

Snort 3 is available! https://www.snort.org/

Snort++ https://github.com/snort3/snort3
- DOCUMENTATION https://github.com/snort3/snort3#documentation

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

# 已阅

【[:star:][`*`]】 Snort入侵检测系统简介 https://www.jianshu.com/p/113345bbf2f7

# 其他

Snort安装使用中文手册 https://www.wangan.com/docs/snortnet

Snort的安装以及使用实验 https://blog.51cto.com/u_15127588/2807708

snort原理、搭建与应用 https://www.jianshu.com/p/44424498c51c

开源IDS与IPS的搭建与使用: Snort - 可信研究院 https://www.istt.org.cn/NewsDetail/2045553.html

https://blog.csdn.net/qq_43968080/category_9417149.html
- Snort的使用一：安装、嗅探与记录 https://blog.csdn.net/qq_43968080/article/details/103376873
- Snort的使用二：入侵检测与规则编写 https://blog.csdn.net/qq_43968080/article/details/103378952
