
# 1

ubuntu 16.04 + cmake 升级 - 丁洪凯的文章 - 知乎 https://zhuanlan.zhihu.com/p/93480024  -->  这个帖子里的方法可行，但是要注意最后建软连接时直接用了 `-f` 参数，把原来老版本的cmake给覆盖了。自己的常用环境感觉还是要小心点。
```sh
wget https://cmake.org/files/v3.13/cmake-3.13.0-Linux-x86_64.tar.gz
tar -xzvf cmake-3.13.0-Linux-x86_64.tar.gz
mv cmake-3.13.0-Linux-x86_64/ /opt/cmake-3.13.0/
ln -sf /opt/cmake-3.13.0/bin/*  /usr/bin/
```

```sh
wget https://github.com/Kitware/CMake/releases/download/v3.20.2/cmake-3.20.2-linux-x86_64.tar.gz
tar -xzvf cmake-3.20.2-Linux-x86_64.tar.gz
mv cmake-3.20.2-Linux-x86_64/ /opt/cmake-3.20.2/
ln -sf /opt/cmake-3.20.2/bin/*  /usr/bin/

# 如果github release链接下载不了，可以用snap装。但是装完后路径不是那么好找，参见后面链接，一个命令即可。

## https://snapcraft.io/docs/installing-snap-on-debian
sudo apt update
sudo apt install snapd
sudo snap install core

## https://snapcraft.io/cmake
sudo snap install cmake --classic

$ sudo snap install cmake --classic
cmake 3.20.2 from Crascit✓ installed

# 本来想把软连接做到 /usr/local/bin/。 后来想想还是算了，还是老老实实做到 /usr/bin/，覆盖就覆盖吧。
ln -sf /snap/cmake/870/bin/*  /usr/bin/
```

怎样找到用snap安装后的文件路径 https://blog.csdn.net/u011279649/article/details/89031454
```sh
mount | grep snapd
```

在Linux上安装其他版本的cmake 或 升级cmake https://blog.csdn.net/weixin_41010198/article/details/109343347
- > **3 最简单的升级cmake命令的方法，直接使用pip**
  * > 安装我们自己需要的cmake版本
    ```py
    pip install -U cmake==3.17.3
    ```

## 卸载源码编译安装的 cmake

Remove CMake from standard installation locations. Tested on Ubuntu. https://gist.github.com/datatypevoid/86240308911c901fd198eb4df804cc49
>> //notes：其实核心就是最后那几句 `rm -rf ......`。注意有的时候 `/usr/local/bin` 下面还有 `cpack` 和 `ctest`，也不知道不删会不会有影响，反正一股脑删了就行！
```sh
rm_options="-rf"

rm ${rm_options} /usr/local/share/cmake* \
  /usr/local/lib/cmake \
  /usr/local/doc/cmake* \
  /usr/local/bin/cmake \
  /usr/local/share/aclocal/cmake.m4
```

https://askubuntu.com/questions/942713/how-do-i-remove-cmake-after-installing-it-from-source
