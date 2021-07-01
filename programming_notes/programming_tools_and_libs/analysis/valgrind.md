
# 安装

~~Install valgrind on Debian https://snapcraft.io/install/valgrind/debian~~  -->  NND写了一堆，最后运行不起来！总是提示 memcheck 工具找不到，搞毛线！
```
$ ./valgrind --help
valgrind: failed to start tool 'memcheck' for platform 'amd64-linux': No such file or directory
```

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
