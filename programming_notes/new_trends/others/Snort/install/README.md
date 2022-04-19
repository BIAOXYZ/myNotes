
# 安装1

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

# 安装2

Docker Compose based Snort containers for quick demos, BSA bachelor Smart Homes and Assistive Technologies 🐖 🦹‍♂️ https://github.com/bmedicke/snort-demo

docker-snort-ids https://github.com/fabriziogaliano/docker-snort-ids
