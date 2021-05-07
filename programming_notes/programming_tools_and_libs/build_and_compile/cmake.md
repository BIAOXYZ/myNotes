
# 官方

CMake https://github.com/Kitware/CMake
- > Mirror of CMake upstream repository https://gitlab.kitware.com/cmake/cmake

CMake Tutorial https://cmake.org/cmake/help/v3.19/guide/tutorial/index.html

# 其他攻略

cmake使用教程（十一）-使用cpack打包源码并编写自动化脚本上传到仓库 https://juejin.cn/post/6844903641443205128

【[:star:][`*`]]】 CMake Examples https://github.com/ttroy50/cmake-examples

【[:star:][`*`]]】 CMake Cookbook https://github.com/dev-cafe/cmake-cookbook || CMake菜谱（CMake Cookbook中文版） https://www.bookstack.cn/books/CMake-Cookbook
- `4.4 使用Boost Test进行单元测试` https://www.bookstack.cn/read/CMake-Cookbook/content-chapter4-4.4-chinese.md
  * https://github.com/dev-cafe/cmake-cookbook/tree/v1.0/chapter-04/recipe-04

# 问题

## `Unknown CMake command "target_link_options"`

Does cmake have something like target_link_options? https://stackoverflow.com/questions/25043458/does-cmake-have-something-like-target-link-options

>> //notes：Ubuntu自带的cmake版本是3.5，这个版本太低了，都没有`target_link_options`参数。一般都是用3.13或以上吧，需要自己升级下。
>>> [ubuntu 16.04 + cmake 升级 - 丁洪凯的文章 - 知乎](https://zhuanlan.zhihu.com/p/93480024)  -->  这个帖子里的方法可行，但是要注意最后建软连接时直接用了 -f 参数，把原来老版本的cmake给覆盖了。自己的常用环境感觉还是要小心点。
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
