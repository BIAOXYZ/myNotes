
# 官方

CMake https://github.com/Kitware/CMake
- > Mirror of CMake upstream repository https://gitlab.kitware.com/cmake/cmake

CMake Tutorial https://cmake.org/cmake/help/v3.19/guide/tutorial/index.html

# 系统性攻略

cmake使用教程（十一）-使用cpack打包源码并编写自动化脚本上传到仓库 https://juejin.cn/post/6844903641443205128

【[:star:][`*`]】 CMake Examples https://github.com/ttroy50/cmake-examples || http://ttroy50.github.io/cmake-examples/

【[:star:][`*`]】 CGold: The Hitchhiker’s Guide to the CMake https://cgold.readthedocs.io/en/latest/index.html || https://github.com/ruslo/CGold

【[:star:][`*`]】 CMake Cookbook https://github.com/dev-cafe/cmake-cookbook || CMake菜谱（CMake Cookbook中文版） https://www.bookstack.cn/books/CMake-Cookbook
- 本书相关
  * github翻译地址： https://github.com/xiaoweiChen/CMake-Cookbook
  * gitbook 在线阅读： https://app.gitbook.com/@chenxiaowei/s/cmake-cookbook/
- `4.4 使用Boost Test进行单元测试` https://www.bookstack.cn/read/CMake-Cookbook/content-chapter4-4.4-chinese.md
  * https://github.com/dev-cafe/cmake-cookbook/tree/v1.0/chapter-04/recipe-04

CMake Tutorial https://medium.com/@onur.dundar1/cmake-tutorial-585dd180109b

CMake 入门 https://zh.wikibooks.org/wiki/CMake_%E5%85%A5%E9%96%80
- CMake 入门/运算子 https://zh.wikibooks.org/zh-hans/CMake_%E5%85%A5%E9%96%80/%E9%81%8B%E7%AE%97%E5%AD%90

CMake：
- CMake Day 3 —— 编译二进制或库 https://blog.csdn.net/qq_34347375/article/details/110672947
- CMake Day 4 —— 设置头文件路径和链接库 https://azmddy.github.io/article/%E7%BC%96%E8%AF%91%E6%9E%84%E5%BB%BA/cmake-day-4.html

# 其他攻略

【使用CMake组织C++工程】2：CMake 常用命令和变量 https://elloop.github.io/tools/2016-04-10/learning-cmake-2-commands

使用CMake https://frostime.github.io/2019/03/30/%E4%BD%BF%E7%94%A8CMake/

带你看 CMake https://www.jianshu.com/p/9e8e0566ccc5
- > 说在前面
  * > 6.cmake 指定开关 `-DXXX=XX` eg：`-DOPT1=ON`
- > 指定编译参数
  * > note: 请这样设置 `set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")` 否则会导致修改系统的 `CXXFLAGS`。

CMake 学习笔记 https://www.jianshu.com/p/c417e4ab8b30

VS Code与CMake真乃天作之合 - Pokerpoke的文章 - 知乎 https://zhuanlan.zhihu.com/p/52874931
- > CMake 快成了C/C++开源项目的标配了，`mkdir build && cd build && cmake .. && make && sudo make install` 带来了十分的快感
- > 在VS Code扩展标签中搜索CMake并安装以下两个扩展，安装之后扩展会进行相关初始化
  ```console
  CMake
  CMake Tools
  ```
- 回复：
  * > `cmake -H. -Bbuild && cmake --build build` 可以换掉你那一大串。
  * > QtCreator丑不丑另说，但丫的cmake项目想要debug，就必须编译所有的目标，巨智障。
    >> `cmake --build . --target target_name`
  * > 难道不应该 `cmake -S. -Bbuild -DCMAKE_INSTALL_PRRFIX=~/.local && make -j9 -Cbuild all install` 吗

## 编译debug版本

cmake 管理debug release - spiritsaway的文章 - 知乎 https://zhuanlan.zhihu.com/p/116953293
- > `CMAKE_BUILD_TYPE` 只能指定 `single configuration` 类型的项目配置， 无法指定 `multi configuration` 的项目配置。`multi configuration`的项目配置是在使用者手动指定的时候修改的，默认都是`Debug`。但是对于`multi configuration`的项目，我们可以在触发编译的时候指定是`Debug`还是`Release`:

如何使用Cmake生成debug版本和release版本的程序 https://blog.csdn.net/a794226986/article/details/18605903

### 个人实战1
```sh
cmake . -DCMAKE_BUILD_TYPE=Debug
```

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

在Linux上安装其他版本的cmake 或 升级cmake https://blog.csdn.net/weixin_41010198/article/details/109343347
- > **3 最简单的升级cmake命令的方法，直接使用pip**
  * > 安装我们自己需要的cmake版本
    ```py
    pip install -U cmake==3.17.3
    ```

## 头文件包含还是库链接？

Undefined reference to function CMake https://stackoverflow.com/questions/38530491/undefined-reference-to-function-cmake
