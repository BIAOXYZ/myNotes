
# 升级高版本GCC

## 编译安装

1. 先按这个帖子来： [How to Install GCC on Debian 9](https://linuxhostsupport.com/blog/how-to-install-gcc-on-debian-9/) ，然后会出现报错：`error: Cannot download mpfr-3.1.4.tar.bz2 from ftp://gcc.gnu.org/pub/gcc/infrastructure/`。
2. 上面那个报错是因为下载方式的原因，可以手动下载 gcc 脚本里自动下载失败的包，参考：[Re: Regarding download_prerequisite](https://gcc.gnu.org/legacy-ml/gcc-help/2018-05/msg00123.html)
3. 编译安装成功后还有个问题：机器自带的 gcc （g++也一样，不再重复）是在 `/usr/bin` 下的，但是前面源码编译出来的 gcc 是在 `/usr/local/bin` 下的。最简单的办法应该是做个软连接，比如下面这个[帖子](https://blog.csdn.net/m0_37605642/article/details/120325517)里的，不过我的语句稍微改了一点点。
```sh
sudo ln -s /usr/bin/gcc-7 /usr/bin/gcc
sudo ln -s /usr/bin/g++-7 /usr/bin/g++
```
```sh
# 我机器的版本是：
cd /usr/bin
mv gcc gcc--bak
mv g++ g++--bak
sudo ln -s /usr/local/bin/gcc /usr/bin/gcc
sudo ln -s /usr/local/bin/g++ /usr/bin/g++
```
