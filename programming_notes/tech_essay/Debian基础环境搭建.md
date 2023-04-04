
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

# Python相关

## 卸载已有Python 

linux 彻底删除python https://juejin.cn/s/linux%20%E5%BD%BB%E5%BA%95%E5%88%A0%E9%99%A4python
- > 要彻底删除在 Linux 系统上安装的 Python，你需要执行以下步骤：
- > 1.检查系统中已安装的 Python 版本：
  * > 在终端中执行以下命令来列出所有已安装的 Python 版本：
    ```sh
    $ which -a python
    ```
    > 此命令会输出你系统中所有 Python 版本的路径。你可以通过在路径前加上 "ls" 命令来查看每个版本的安装位置和相关文件。例如：
    ```sh
    $ ls -l /usr/bin/python
    $ ls -l /usr/local/bin/python
    ```
- > 2.卸载 Python：
  * > 使用以下命令卸载 Python：
    ```sh
    $ sudo apt-get remove python
    ```
    > 如果你安装了多个 Python 版本，则需要使用 "python" 命令后面加上版本号来卸载特定的版本。例如，要卸载 Python 3.8，可以执行以下命令：
    ```sh
    $ sudo apt-get remove python3.8
    ```
- > 3.删除相关文件：
  * > 卸载 Python 后，需要删除与其相关的文件和目录。以下是一些常见的文件和目录：
    ```console
    /usr/local/lib/pythonX.X/
    /usr/lib/pythonX.X/
    /usr/local/bin/pythonX.X
    /usr/bin/pythonX.X
    /usr/local/include/pythonX.X/
    /usr/include/pythonX.X/
    /usr/share/man/manX/pythonX.X.*
    ```
    > 注意，上面的文件和目录名称中 "X.X" 部分应该替换为你要删除的 Python 版本号。
  * > 你可以使用以下命令删除这些文件和目录：
    ```sh
    $ sudo rm -rf /usr/local/lib/pythonX.X/
    $ sudo rm -rf /usr/lib/pythonX.X/
    $ sudo rm /usr/local/bin/pythonX.X
    $ sudo rm /usr/bin/pythonX.X
    $ sudo rm -rf /usr/local/include/pythonX.X/
    $ sudo rm -rf /usr/include/pythonX.X/
    $ sudo rm /usr/share/man/manX/pythonX.X.*
    ```
    > 这些步骤应该可以彻底删除在 Linux 系统上安装的 Python。请注意，删除文件和目录时需要谨慎，以免意外删除其他重要文件。

How to remove all traces of python from Ubuntu https://askubuntu.com/questions/1321421/how-to-remove-all-traces-of-python-from-ubuntu  【这个回答的意思是不要删，因为系统会依赖自带的 Python，而是用虚环境来解决。】
