
# apt & apt-get

***其实感觉不用管细节区别了，无脑用apt就差不多***
- What is the difference between apt and apt-get? https://askubuntu.com/questions/445384/what-is-the-difference-between-apt-and-apt-get
- What is the difference between apt and apt-get command? https://www.2daygeek.com/comparison-between-apt-vs-apt-get-difference/

***这俩内容差不多，并且都是转自同一个帖子。都记下来是因为：第二个内容更全，第一个排版更好。***
- apt 和 apt-get的区别 https://blog.csdn.net/liudsl/article/details/79200134
- Linux中apt与apt-get命令的区别与解释 https://blog.csdn.net/maizousidemao/article/details/79859669

apt-get命令 http://man.linuxde.net/apt-get

## 有 `apt list` 但是没有 `apt-get list`

如何列出 Ubuntu 和 Debian 上已安装的软件包 https://linux.cn/article-10562-1.html || https://zhuanlan.zhihu.com/p/57472336
- > `apt-get` 命令 没有类似列出已安装软件包的简单的选项，但是 `apt` 有一个这样的命令：
  ```sh
  apt list --installed
  ```
  > 这个会显示使用 `apt` 命令安装的所有的软件包。同时也会包含由于依赖而被安装的软件包。也就是说***不仅会包含你曾经安装的程序，而且会包含大量库文件和间接安装的软件包***。
- > 如果你阅读过 [apt 与 apt-get 对比的文章](https://itsfoss.com/apt-vs-apt-get-difference/)，你可能已经知道 ***`apt` 和 `apt-get` 命令都是基于 `dpkg`***。也就是说用 `dpkg` 命令可以列出 Debian 系统的所有已经安装的软件包。
  ```sh
  dpkg-query -l
  ```
- > 现在你可以搞定列出 Debian 的软件包管理器安装的应用了。那 Snap 和 Flatpak 这个两种应用呢？如何列出它们？因为它们不能被 `apt` 和 `dpkg` 访问。
- > **显示最近安装的软件包**
  * > 有两个方法可以来做。用 `dpkg` 命令的日志或者 `apt` 命令的日志。你仅仅需要用 grep 命令过滤已经安装的软件包日志。
    ```sh
    grep " install " /var/log/dpkg.log
    ```
    > 这会显示所有的软件安装包，其中包括最近安装的过程中所依赖的软件包。
  * > 你也可以查看 `apt` 历史命令日志。这个仅会显示用 `apt` 命令安装的的程序。***但不会显示被依赖安装的软件包***，详细的日志在日志里可以看到。有时你只是想看看对吧？
    ```sh
    grep " install " /var/log/apt/history.log
    ```

## `--allow-unauthenticated`

Force update from unsigned repository https://askubuntu.com/questions/732985/force-update-from-unsigned-repository

Ubuntu学习之apt-get update 升级错误 https://blog.csdn.net/gpf19930310/article/details/82461306

# `apt-key`

apt-get软件包管理命令 和 apt-key命令 https://www.cnblogs.com/saysmy/p/10390277.html
```console
apt-key命令用于管理Debian Linux系统中的软件包密钥。每个发布的deb包，都是通过密钥认证的，apt-key用来管理密钥。

用法：apt-key [--keyring file] [command] [arguments]

参数：

apt-key add <file>          - 把下载的key添加到本地trusted数据库中
apt-key del <keyid>         - 从本地trusted数据库通过keyid删除key
apt-key export <keyid>      - 通过keyid导出key
apt-key exportall           - 导出本地trusted数据库中的所有key
apt-key update              - 通过key包来更新key,更新本地trusted数据库，删除过期没用的key
apt-key net-update          - 通过网络更新key
apt-key list                - 列出已保存在系统中key
apt-key finger              - 列出所有验证指纹
apt-key adv                 - 设置key的高级配置, Pass advanced options to gpg
```

How To Delete A Repository And GPG Key In Ubuntu https://ostechnix.com/how-to-delete-a-repository-and-gpg-key-in-ubuntu/

MySQL: An error occurred during the signature verification [duplicate] https://askubuntu.com/questions/1389928/mysql-an-error-occurred-during-the-signature-verification
- https://askubuntu.com/questions/1389928/mysql-an-error-occurred-during-the-signature-verification/1389929#1389929
  * > You will want to import the missing GPG keys for the repository like this:
    ```sh
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys <the_PUBKEY_in_error_message>
    ```
  * > Then update:
    ```sh
    sudo apt update
    ```

# apt源相关

## apt换源/增加源

How To Add Apt Repository In Ubuntu https://linuxize.com/post/how-to-add-apt-repository-in-ubuntu/
- > An APT repository is a ***network server*** or a ***local directory*** containing ***`deb` packages*** and ***metadata files*** that are readable by the APT tools.
- > In this tutorial, we will show you two ways to add ***apt repository*** on Ubuntu and Debian systems. The first method is by using the `add-apt-repository` command and the second one is to manually add the repository using a text editor.
- > **Apt Sources**
  * > On Ubuntu and all other Debian based distributions, the `apt` software repositories are defined in the ***`/etc/apt/sources.list`*** file or in separate files under the ***`/etc/apt/sources.list.d/`*** directory.
  * > The names of the repository files inside the `/etc/apt/sources.list.d/` directory must end with `.list`.
  * > The general syntax of the `/etc/apt/sources.list` file takes the following format:
    ```console
    deb http://repo.tld/ubuntu distro component...
    ```
    + > The first entry in the line defines the type of the archive. ***The archive type can be either `deb` or `deb-src`***. `Deb` implies that the repository contains `.deb` packages while `deb-src` implies source packages.
    + > The second entry is the repository URL.
    + > The third entry specifies the distribution code name, such as beaver, xenial and so on.
    + > The last entries are the repository components or categories. ***The default Ubuntu repositories are split into four components - `main`, `restricted`, `universe` and `multiverse`***. Generally, third-party repositories have only one category.
  * > The format for the files under the `/etc/apt/sources.list.d/` directory is the same as for the regular `sources.list` file.
  * > Most repositories are providing a public key to authenticate downloaded packages which need to be downloaded and imported.
- > **Installing `add-apt-repository` (`add-apt-repository` command not found)**
  ```sh
  sudo apt update
  sudo apt install software-properties-common
  ```
- > **Adding Repositories with `add-apt-repository`**
  * > The basic syntax of the `add-apt-repository` command is as follows:
    ```sh
    add-apt-repository [options] repository
    ```
    >> //notes：个人实战如下：
    ```sh
    sudo apt-add-repository 'deb http://ftp.us.debian.org/debian stretch main contrib non-free'
    ```
  * > **Adding PPA Repositories**

How to Add a Package Repository to Debian https://linuxhint.com/how-to-add-a-package-repository-to-debian/
- > **Adding a Package Repository Using apt on Debian**
  * > You can also remove a PPA or a package repository with the following command:
    ```sh
    $ sudo apt-add-repository -r YOUR_REPOSITORY
    ```

Ubuntu20.04软件源更换 - 舟公的文章 - 知乎 https://zhuanlan.zhihu.com/p/142014944

## 查看某个版本的软件属于哪一个源

How can I check the available version of a package in the repositories? https://askubuntu.com/questions/340530/how-can-i-check-the-available-version-of-a-package-in-the-repositories
- https://askubuntu.com/questions/340530/how-can-i-check-the-available-version-of-a-package-in-the-repositories/340536#340536
  * > Use the command:
    ```sh
    apt-cache policy <packageName>
    ```
  * > This gives you information of all available package versions. Example:
    ```sh
    alaa@aa-lu:~$ apt-cache policy vlc
    vlc:
      Installed: 2.0.8-0ubuntu0.13.04.1
      Candidate: 2.0.8-0ubuntu0.13.04.1
      Version table:
     *** 2.0.8-0ubuntu0.13.04.1 0
            500 http://ae.archive.ubuntu.com/ubuntu/ raring-updates/universe i386 Packages
            500 http://security.ubuntu.com/ubuntu/ raring-security/universe i386 Packages
            100 /var/lib/dpkg/status
         2.0.6-1 0
            500 http://ae.archive.ubuntu.com/ubuntu/ raring/universe i386 Packages
    ```
    + > From the output, you can see that there are two versions available: `2.0.8-0ubuntu0.13.04.1` and `2.0.6-1`. It also tells you which repositories they are coming from.
    + > `Installed:` tells you the version you have installed. If you don't have the package installed, you'll see `(none)`.
    + > `Candidate:` is the version that will be installed if you use `apt-get install vlc`. If you want to install the other version, you would do `apt-get install vlc=2.0.6-1`.

How do I find out which repository a package comes from? https://askubuntu.com/questions/8560/how-do-i-find-out-which-repository-a-package-comes-from

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# dpkg

***From（Ubuntu或Debian）官方网站:***
- dpkg https://help.ubuntu.com/lts/serverguide/dpkg.html
- 5.4. 通过dpkg来操作软件包 https://www.debian.org/doc/manuals/debian-handbook/sect.manipulating-packages-with-dpkg.zh-cn.html

Ubuntu下deb包的安装方法 https://blog.csdn.net/kevinhg/article/details/5934462

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 安装本地包 or 离线安装

20 apt Command to Know as Sysadmin to Manage Ubuntu or Debian Packages https://geekflare.com/apt-command-examples/
- > **6 Install Specific Version**
  ```sh
  sudo apt install [package-name]=[version]
  ```
  > Example:
  ```sh
  sudo apt install unzip=6.0-25ubuntu1
  ```
- > **15 Check Package Dependencies**
  ```sh
  apt depends [package-name]
  ```
- > **17 Download a Package**
  ```sh
  apt download [package-name]
  ```
  > Example:
  ```sh
  apt download unzip
  ```
- > **19 Edit Sources**
  ```sh
  sudo apt edit-sources
  ```

How to install a deb file, by dpkg -i or by apt? https://unix.stackexchange.com/questions/159094/how-to-install-a-deb-file-by-dpkg-i-or-by-apt

3 Command Line Tools to Install Local Debian (.DEB) Packages https://www.tecmint.com/install-local-deb-packages-in-debian-ubuntu-linux-mint/

What do the various dpkg flags like 'ii' 'rc' mean? https://askubuntu.com/questions/18804/what-do-the-various-dpkg-flags-like-ii-rc-mean
- https://askubuntu.com/questions/18804/what-do-the-various-dpkg-flags-like-ii-rc-mean/18807#18807
