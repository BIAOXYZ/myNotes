
# 官方

Snort (software) https://en.wikipedia.org/wiki/Snort_(software) || Snort https://zh.wikipedia.org/wiki/Snort

Snort 3 is available! https://www.snort.org/

Snort++ https://github.com/snort3/snort3

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

# 其他

Snort安装使用中文手册 https://www.wangan.com/docs/snortnet

Snort的安装以及使用实验 https://blog.51cto.com/u_15127588/2807708
