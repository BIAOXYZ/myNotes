
# 安装

## Debian 9

~~Install valgrind on Debian https://snapcraft.io/install/valgrind/debian~~  -->  NND写了一堆，最后运行不起来！总是提示 memcheck 工具找不到，搞毛线！
```
$ ./valgrind --help
valgrind: failed to start tool 'memcheck' for platform 'amd64-linux': No such file or directory
```

>> //notes：后来又试了用 `apt` 去装，同样能安装成功，但是一运行还是报同样的错，和用 `snap` 装的一个鸟样。就在我已经不抱希望、死马当活马医的时候，随便按照下面帖子试了下源码编译安装竟然没有任何问题。。。可能还是机器上少了什么东西（库或者潜在的二进制文件，比如上面的报错就是说 `memcheck` 工具找不到），但是源码编译都会编出来。

How to install valgrind properly? https://stackoverflow.com/questions/24935217/how-to-install-valgrind-properly
- https://stackoverflow.com/questions/24935217/how-to-install-valgrind-properly/51671524#51671524
```console
1. Uninstall the non working valgrind version with root rights (eg. sudo): apt-get --purge valgrind or dpkg --remove valgrind or yum remove valgrind
2. Obtain sources from here. https://www.valgrind.org/downloads/
3. Identify the latest version (for example 3.17.0)
4. Download sources: wget https://sourceware.org/pub/valgrind/valgrind-3.17.0.tar.bz2
5. Decompress archive tar xvf valgrind-3.17.0.tar.bz2
6. Go to uncompressed archive cd valgrind-3.17.0
7. Configure ./configure
8. Compile make
9. Install make install (with root rights, eg. sudo)
```
```sh
# 实战时候直接从上面第 4 步开始安装就行：
wget https://sourceware.org/pub/valgrind/valgrind-3.17.0.tar.bz2
tar xvf valgrind-3.17.0.tar.bz2
cd valgrind-3.17.0
./configure
make
make install
```

## Ubuntu

Install valgrind on Ubuntu https://snapcraft.io/install/valgrind/ubuntu
```sh
# Enable snapd
## If you’re running Ubuntu 16.04 LTS (Xenial Xerus) or later, including Ubuntu 18.04 LTS (Bionic Beaver) and Ubuntu 20.04 LTS (Focal Fossa), you don’t need to do anything. Snap is already installed and ready to go.
## For versions of Ubuntu between 14.04 LTS (Trusty Tahr) and 15.10 (Wily Werewolf), as well as Ubuntu flavours that don’t include snap by default, snap can be installed from the Ubuntu Software Centre by searching for snapd. Alternatively, snapd can be installed from the command line:
sudo apt update
sudo apt install snapd

# Install valgrind
sudo snap install valgrind --classic
```

//notes：人家Ubuntu装完也不用搞软连接那一套，直接在 `/snap/bin/` 下面所有的软件都可以直接运行，所以可以只要把这个路径加到 `PATH` 里就方便得很。Debian 还是没做好，它也有这个目录，但是有bug导致这里的软连接不能直接用。
```sh
$ pwd
/snap/bin
$ 
$ ll
total 8
drwxr-xr-x 2 root root 4096 Jul  1 13:46 ./
drwxr-xr-x 6 root root 4096 Jul  1 13:46 ../
lrwxrwxrwx 1 root root   27 Jul  1 13:46 callgrind_annotate -> valgrind.callgrind-annotate*
lrwxrwxrwx 1 root root   26 Jul  1 13:46 callgrind_control -> valgrind.callgrind-control*
lrwxrwxrwx 1 root root   20 Jul  1 13:46 cg_annotate -> valgrind.cg-annotate*
lrwxrwxrwx 1 root root   16 Jul  1 13:46 cg_diff -> valgrind.cg-diff*
lrwxrwxrwx 1 root root   17 Jul  1 13:46 cg_merge -> valgrind.cg-merge*
lrwxrwxrwx 1 root root   17 Jul  1 13:46 ms_print -> valgrind.ms-print*
lrwxrwxrwx 1 root root   13 Jul  1 13:46 valgrind -> /usr/bin/snap*
lrwxrwxrwx 1 root root   13 Jul  1 13:46 valgrind.callgrind-annotate -> /usr/bin/snap*
lrwxrwxrwx 1 root root   13 Jul  1 13:46 valgrind.callgrind-control -> /usr/bin/snap*
lrwxrwxrwx 1 root root   13 Jul  1 13:46 valgrind.cg-annotate -> /usr/bin/snap*
lrwxrwxrwx 1 root root   13 Jul  1 13:46 valgrind.cg-diff -> /usr/bin/snap*
lrwxrwxrwx 1 root root   13 Jul  1 13:46 valgrind.cg-merge -> /usr/bin/snap*
lrwxrwxrwx 1 root root   27 Jul  1 13:46 valgrind-di-server -> valgrind.valgrind-di-server*
lrwxrwxrwx 1 root root   26 Jul  1 13:46 valgrind-listener -> valgrind.valgrind-listener*
lrwxrwxrwx 1 root root   13 Jul  1 13:46 valgrind.ms-print -> /usr/bin/snap*
lrwxrwxrwx 1 root root   13 Jul  1 13:46 valgrind.valgrind-di-server -> /usr/bin/snap*
lrwxrwxrwx 1 root root   13 Jul  1 13:46 valgrind.valgrind-listener -> /usr/bin/snap*
lrwxrwxrwx 1 root root   13 Jul  1 13:46 valgrind.vgdb -> /usr/bin/snap*
lrwxrwxrwx 1 root root   13 Jul  1 13:46 vgdb -> valgrind.vgdb*
$ 
$ ./valgrind
valgrind: no program specified
valgrind: Use --help for more information.
```

# 文章

Linux 性能分析valgrind（一）之memcheck使用 - Xin Lee的文章 - 知乎 https://zhuanlan.zhihu.com/p/92074597
- > **Valgrind 怎么用**
  * > 2.运行
    + > `valgrind --tool=toolname args-val program args-pro`
- > **使用 Valgrind Memcheck**
  * > memcheck工具的使用方式如下:
    + > `valgrind --tool=memcheck ./a.out`
- > **工程实践注意**：
  * > 需要测试***运行中***的内存泄漏问题，可以使用如下命令：
    + > `valgrind --log-file=valgrind.log --tool=memcheck --leak-check=full --show-leak-kinds=all ./your_app arg1 arg2`
- > **该工具可以检测下列与内存相关的问题**:
  ```console
  未释放内存的使用
  对释放后内存的读/写
  对已分配内存块尾部的读/写
  内存泄露
  不匹配的使用malloc/new/new[] 和 free/delete/delete[]
  重复释放内存
  ```

实例介绍利用valgrind定位内存异常释放问题（double free 和wrong free） https://blog.csdn.net/stpeace/article/details/61624382

C++内存泄漏检查工具——Valgrind（--tool = memcheck） https://www.cnblogs.com/developing/articles/10979109.html

C/C++ 内存泄漏检测工具：Valgrind https://murphypei.github.io/blog/2019/04/valgrind-memory-leaky

# 相关软件

## KCachegrind 

GUI to profilers such as Valgrind https://github.com/KDE/kcachegrind
