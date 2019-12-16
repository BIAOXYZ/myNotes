
# OS general

开源版“Windows 操作系统” ReactOS 0.4.9 版发布 - 软件和应用 - cnBeta.COM
https://www.cnbeta.com/articles/soft/751203.htm

最受欢迎的10个Linux发行版 https://www.linuxprobe.com/linux-welcome.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## OS启动

计算机是如何启动的？ http://www.ruanyifeng.com/blog/2013/02/booting.html

简述Linux的启动过程 https://segmentfault.com/a/1190000006872609

Linux 中 rc.local、init.d、rc.x、init 这几个文件（夹）各有什么作用？启动执行的脚本应该均放在 rc.local 中吗？ - 知乎https://www.zhihu.com/question/20126189

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# OS Kernel

Linux 内核揭密 https://github.com/MintCN/linux-insides-zh
  > Linux Insides中文 https://xinqiu.gitbooks.io/linux-insides-cn/content/index.html

Linux 5.4内核将引入安全锁定功能 https://www.ithome.com/0/448/196.htm

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## inode

linux下普通文件和目录文件区别 https://blog.csdn.net/mrjy1475726263/article/details/34436769

inode https://en.wikipedia.org/wiki/Inode 【[inode](https://zh.wikipedia.org/wiki/Inode)】
- > 文件系统创建（格式化）时，就把存储区域分为两大连续的存储区域。一个用来保存文件系统对象的元信息数据，这是由inode组成的表，每个inode默认是256字节或者128字节。另一个用来保存“文件系统对象”的内容数据，划分为512字节的扇区，以及由8个扇区组成的4K字节的块。块是读写时的基本单位。一个文件系统的inode的总数是固定的。这限制了该文件系统所能存储的文件系统对象的总数目。典型的实现下，所有inode占用了文件系统1%左右的存储容量。
  >
  > 文件系统中每个“文件系统对象”对应一个“inode”数据，并用一个整数值来辨识。这个整数常被称为inode号码（“i-number”或“inode number”）。由于文件系统的inode表的存储位置、总条目数量都是固定的，因此可以用inode号码去索引查找inode表。
  >
  > Inode存储了文件系统对象的一些元信息，如所有者、访问权限（读、写、执行）、类型（是文件还是目录）、内容修改时间、inode修改时间、上次访问时间、对应的文件系统存储块的地址，等等。知道了1个文件的inode号码，就可以在inode元数据中查出文件内容数据的存储地址。
  >
  > 文件名与目录名是“文件系统对象”便于使用的别名。一个文件系统对象可以有多个别名，但只能有一个inode，并用这个inode来索引文件系统对象的存储位置。
  >
  * inode不包含文件名或目录名的字符串，只包含文件或目录的“元信息”。
  * Unix的文件系统的目录也是一种文件。打开目录，实际上就是读取“目录文件”。目录文件的结构是一系列目录项（dirent）的列表。每个目录项，由两部分组成：所包含文件或目录的名字，以及该文件或目录名对应的inode号码。
  * 文件系统中的一个文件是指存放在其所属目录的“目录文件”中的一个目录项，其所对应的inode的类别为“文件”；文件系统中的一个目录是指存放在其“父目录文件”中的一个目录项，其所对应的inode的类别为“目录”。可见，多个“文件”可以对应同一个inode;多个“目录”可以对应同一个inode。
  * 文件系统中如果两个文件或者两个目录具有相同的inode号码，那么就称它们是“硬链接”关系。实际上都是这个inode的别名。换句话说，一个inode对应的所有文件（或目录）中的每一个，都对应着文件系统某个“目录文件”中唯一的一个目录项。
  * 创建一个目录时，实际做了3件事：在其“父目录文件”中增加一个条目；分配一个inode；再分配一个存储块，用来保存当前被创建目录包含的文件与子目录。被创建的“目录文件”中自动生成两个子目录的条目，名称分别是：“.”和“..”。前者与该目录具有相同的inode号码，因此是该目录的一个“硬链接”。后者的inode号码就是该目录的父目录的inode号码。所以，任何一个目录的"硬链接"总数，总是等于它的子目录总数（含隐藏目录）加2。即每个“子目录文件”中的“..”条目，加上它自身的“目录文件”中的“.”条目，再加上“父目录文件”中的对应该目录的条目。
  * 通过文件名打开文件，实际上是分成三步实现：首先，操作系统找到这个文件名对应的inode号码；其次，通过inode号码，获取inode信息；最后，根据inode信息，找到文件数据所在的block，读出数据。
- > 推论
  * 一个文件系统对象可以有多个名字，这些具有硬链接关系的文件系统对象名字具有相同的inode号码，彼此是平等的。即首个被创建的文件并没有特殊的地位。这与符号链接不同。一个符号链接文件有自己的inode，符号链接文件的内容是它所指向的文件的名字。因此删除符号链接所指向的文件，将导致这个符号链接文件在访问时报错。
  * 删除一个文件或目录，实际上是把它的inode的链接数减1。这并不影响指向此inode的别的硬链接。
  * 一个inode如果没有硬链接，此时inode的链接数为0，文件系统将回收该inode所指向的存储块，并回收该inode自身。
  * 从一个inode，通常是无法确定是用哪个文件名查到此inode号码的。打开一个文件后，操作系统实际上就抛掉了文件名，只保留了inode号码来访问文件的内容。库函数getcwd()用来查询当前工作目录的绝对路径名。其实现是从当前工作目录的inode逐级查找其上级目录的inode，最后拼出整个绝对路径的名字。
  * 历史上，对目录的硬链接是可能的。这可以使目录结构成为一个有向图，而不是通常的目录树的有向无环图。一个目录甚至可以是自身的父目录。现代文件系统一般禁止这些混淆状态，只有根目录保持了特例：根目录是自身的父目录。ls /..就是根目录的内容。
  * 一个文件或目录在文件系统内部移动时，其inode号码不变。文件系统碎片整理可能会改变一个文件的物理存储位置，但其inode号码不变。非UNIX的FAT及其派生的文件系统是无法实现inode不变这一特点。
  * inode文件系统中安装新库十分容易。当一些进程正在使用一个库时，其它进程可以替换该库文件名字的inode号码指向新创建的inode，随后对该库的访问都被自动引导到新inode所指向的新的库文件的内容。这减少了替换库时重启系统的需要。而旧的inode的链接数已经为0，在使用旧库的进程结束后，旧的inode与旧库文件会被系统自动回收。

理解inode http://www.ruanyifeng.com/blog/2011/12/inode.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 文件描述符(FD)

文件句柄（file handles） & 文件描述符（file descriptors） https://blog.csdn.net/u013256816/article/details/60778709

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## mount

mount (Unix) https://zh.wikipedia.org/wiki/Mount_(Unix)
- > mount是一个UNIX系统上的命令。用户在UNIX操作系统的机器上打开一个文件以前，**包含该文件的文件系统必须先进行挂载的动作**，此时用户要对该文件系统下mount的指令以进行挂载。通常是使用在USB或其他可移除存储设备上，而根目录则保持挂载的状态。但Unix文件系统可以对应一个文件而不一定要是硬件设备

Linux学习笔记（二）：什么是挂载？mount的用处在哪？ https://blog.csdn.net/qq_39521554/article/details/79501714
- > 6.所以Linux下，mount挂载的作用，就是将一个设备（通常是存储设备）挂接到一个已存在的目录上。访问这个目录就是访问该存储设备。 
<br>  7.linux操作系统将所有的设备都看作文件，它将整个计算机的资源都整合成一个大的文件目录。我们要访问存储设备中的文件，必须将文件所在的分区挂载到一个已存在的目录上，然后通过访问这个目录来访问存储设备。挂载就是把设备放在一个目录下，让系统知道怎么管理这个设备里的文件，了解这个存储设备的可读写特性之类的过程。
- > 8.我们不是有/dev/sdb1 吗，直接对它操作不就行了？这不是它的目录吗？ 
<br> 9.这不是它的目录。虽然/dev是个目录，但/dev/sdb1不是目录。可以发现ls/dev/sdb1无法执行。/dev/sdb1，是一个类似指针的东西，指向这个分区的原始数据块。mount前，系统并不知道这个数据块哪部分数据代表文件，如何对它们操作。 
<br> 10.插入CD，系统其实自动执行了 mount /dev/cdrom /media/cdrom。所以可以直接在/media/cdrom中对CD中的内容进行管理。

挂载（mount）深入理解 https://www.cnblogs.com/chen-farsight/p/6119404.html
- > 首先引用一句 wiki 上的定义来开篇:
  >> Mounting takes place before a computer can use any kind of storage device (such as a hard drive, CD-ROM, or network share). The user or their operating system must make it accessible through the computer’s file system. A user can only access files on mounted media.
  >
  > 意思是说, “挂载” 发生在计算机想要使用任何类型的存储设备 (如硬盘, CD-ROM, 网络设备) 之前. 操作系统必须将这个设备纳入自己的文件系统中去.要注意的是, 这里的存储设备不一定必须是外部的存储设备, 也可以是你安装系统的硬盘上的分区.
- > 光看上面说的还不够, 先看个例子吧, 这个例子摘自 man mount, 在 man 手册中这个例子下的一句话非常好的解释了 mount 到底是什么.
  >> `mount -t type device dir `
  >
  > 在这个例子下面有这么一句话: This tells the kernel to attach the filesystem found on *device* (which is of type *type*) at the directory *dir*.
  >
  > 这句话非常重要, 我们一定要明白, 挂载操作, 实际上是把设备device中的文件系统附加到dir上, 然后我们就可以通过访问dir来访问这个设备.
  >
  > 明白了这一点, 我们就能明白 “挂载” 的本质了, 挂载的本质就是针对某一设备, 分析出其文件系统结构, 并根据其文件系统类型调用 linux 中相应的驱动, 处理其的元数据, 将这些信息附加到 linux 的目录树上呈现出来.

What is meant by mounting a device in Linux? https://unix.stackexchange.com/questions/3192/what-is-meant-by-mounting-a-device-in-linux
```
Unix systems have a single directory tree. All accessible storage must have an associated location in this 
single directory tree. This is unlike Windows where (in the most common syntax for file paths) there is one 
directory tree per storage component (drive).

Mounting is the act of associating a storage device to a particular location in the directory tree. For example, 
when the system boots, a particular storage device (commonly called the root partition) is associated with the 
root of the directory tree, i.e., that storage device is mounted on / (the root directory).

Let's say you now want to access files on a CD-ROM. You must mount the CD-ROM on a location in the directory 
tree (this may be done automatically when you insert the CD). Let's say the CD-ROM device is /dev/cdrom and the 
chosen mount point is /media/cdrom. The corresponding command is

mount /dev/cdrom /media/cdrom

After that command is run, a file whose location on the CD-ROM is /dir/file is now accessible on your system as 
/media/cdrom/dir/file. When you've finished using the CD, you run the command umount /dev/cdrom or umount /media/cdrom 
(both will work; typical desktop environments will do this when you click on the “eject” or ”safely remove” button).

Mounting applies to anything that is made accessible as files, not just actual storage devices. For example, 
all Linux systems have a special filesystem mounted under /proc. That filesystem (called proc) does not have 
underlying storage: the files in it give information about running processes and various other system 
information; the information is provided directly by the kernel from its in-memory data structures.
```

能否通俗易懂，深入浅出地解释一下linux中的挂载的概念？ - 知乎 https://www.zhihu.com/question/266907637
- 能否通俗易懂，深入浅出地解释一下linux中的挂载的概念？ - 灵剑的回答 - 知乎 https://www.zhihu.com/question/266907637/answer/315386532
- 能否通俗易懂，深入浅出地解释一下linux中的挂载的概念？ - 大叮当的回答 - 知乎 https://www.zhihu.com/question/266907637/answer/317710850
  * > 假如你插入了一个 CD-ROM.你里面有个文件 `/file/hahaha.txt`，设备地址为 `/dev/cdrom`（所有设备在linux下都是文件形式存在的，所以设备会在`/dev文件`下面），这时候如果你想访问里面的数据，你需要建立一个文件来映射该设备，假设你建立了一个 `/media/cdrom` 的文件夹，执行下面的命令 `mount /dev/cdrom /media/cdrom` 就可以通过 `/media/cdrom/file/hahaha.txt` 访问到CD-ROM里面的数据了。如果使用完毕，你也可以使用 `umount /media/cdrom` 将设备卸载。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## namespace

Docker背后的内核知识：命名空间资源隔离 https://linux.cn/article-5057-5.html

Linux Namespace : Mount https://www.cnblogs.com/sparkdev/p/9424649.html 【from sparkdev】

Linux Namespace系列（04）：mount namespaces (CLONE_NEWNS) https://segmentfault.com/a/1190000006912742 【from wuyangchun】

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## cgroups

cgroups https://en.wikipedia.org/wiki/Cgroups

Docker 背后的内核知识——cgroups 资源限制 https://www.infoq.cn/article/docker-kernel-knowledge-cgroups-resource-isolation

CGroup 介绍 https://www.ibm.com/developerworks/cn/linux/1506_cgroup/index.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## kernel module

Loadable kernel module https://en.wikipedia.org/wiki/Loadable_kernel_module

Kernel module (简体中文) https://wiki.archlinux.org/index.php/Kernel_module_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

Writing a Simple Linux Kernel Module https://blog.sourcerer.io/writing-a-simple-linux-kernel-module-d9dc3762c234

The Linux Kernel Module Programming Guide https://linux.die.net/lkmpg/index.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## terminal、shell等相关的知识

### login/non-login shell || interactive/non-interactive shell

登陆shell,非登陆shell 以及交互shell和非交互shell https://juejin.im/post/5d2bf9a06fb9a07eb94fbb3d

Difference between Login Shell and Non-Login Shell? https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell
> A login shell is the first process that executes under your user ID when you log in for an interactive session. The login process tells the shell to behave as a login shell with a convention: passing argument 0, which is normally the name of the shell executable, with a - character prepended (e.g. -bash whereas it would normally be bash. Login shells typically read a file that does things like setting environment variables: /etc/profile and ~/.profile for the traditional Bourne shell, ~/.bash_profile additionally for bash†, /etc/zprofile and ~/.zprofile for zsh†, /etc/csh.login and ~/.login for csh, etc.
>
> When you log in on a text console, or through SSH, or with `su -`, you get an **interactive login** shell. When you log in in graphical mode (on an X display manager), you don't get a login shell, instead you get a session manager or a window manager.
>
> It's rare to run a **non-interactive login** shell, but some X settings do that when you log in with a display manager, so as to arrange to read the profile files. Other settings (this depends on the distribution and on the display manager) read `/etc/profile` and `~/.profile` explicitly, or don't read them. Another way to get a non-interactive login shell is to log in remotely with a command passed through standard input which is not a terminal, e.g. `ssh example.com <my-script-which-is-stored-locally` (as opposed to `ssh example.com my-script-which-is-on-the-remote-machine`, which runs a `non-interactive, non-login` shell).
>
> When you start a shell in a terminal in an existing session (screen, X terminal, Emacs terminal buffer, a shell inside another, etc.), you get an **interactive, non-login** shell. That shell might read a shell configuration file (`~/.bashrc` for bash invoked as `bash`, `/etc/zshrc` and `~/.zshrc` for zsh, `/etc/csh.cshrc` and `~/.cshrc` for csh, the file indicated by the `ENV` variable for POSIX/XSI-compliant shells such as dash, ksh, and bash when invoked as `sh`, `$ENV` if set and `~/.mkshrc` for mksh, etc.).
>
> When a shell runs a script or a command passed on its command line, it's a **non-interactive, non-login** shell. Such shells run all the time: it's very common that when a program calls another program, it really runs a tiny script in a shell to invoke that other program. Some shells read a startup file in this case (bash runs the file indicated by the `BASH_ENV` variable, zsh runs `/etc/zshenv` and `~/.zshenv`), but this is risky: the shell can be invoked in all sorts of contexts, and there's hardly anything you can do that might not break something.

### tty、terminal、console等的区别与联系

Teleprinter https://en.wikipedia.org/wiki/Teleprinter

Linux TTY/PTS概述 https://segmentfault.com/a/1190000009082089

终端、虚拟终端、shell、控制台、tty的区别 https://blog.csdn.net/ltx06/article/details/52170852

What is the difference between Terminal, Console, Shell, and Command Line? https://askubuntu.com/questions/506510/what-is-the-difference-between-terminal-console-shell-and-command-line

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Windows系

微软团队成员谈Windows Kernel的结构 - Windows - cnBeta.COM https://www.cnbeta.com/articles/tech/781961.htm

【IT之家学院】如何在Windows 10中重置和注销Linux子系统 https://www.ithome.com/0/415/133.htm

Windows 10 源码一览：0.5T 代码、400 万文件、50 万文件夹 - Windows 10 - cnBeta.COM https://www.cnbeta.com/articles/tech/837143.htm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 各个发行版的关系

浅析CentOS和RedHat Linux的区别 https://www.cnblogs.com/zjoch/p/6394150.html
- > CentOS是Community ENTerprise Operating System的简称，我们有很多人叫它社区企业操作系统，不管你怎么叫它，它都是Linux操作系统的一个发行版本。
  >
  > CentOS并不是全新的Linux发行版，倘若一说到Red Hat这个大名，大家似乎都听过。在Red Hat家族中有企业版的产品，它是Red Hat Enterprise Linux（以下称之为RHEL），CentOS正是这个RHEL的克隆版本。RHEL是很多企业采用的Linux发行版本，需要向Red Hat付费才可以使用，并能得到付过费用的服务和技术支持和版本升级。CentOS可以像RHEL一样的构筑Linux系统环境，但不需要向Red Hat付任何的产品和服务费用，同时也得不到任何有偿技术支持和升级服务。
  >
  > Red Hat公司的产品中，有Red Hat Linux（如Redhat8,9）和针对企业发行的版本Red Hat Enterprise Linux，都能够通过网络FTP免费的获得并使用，但是在2003年的时候，Red Hat Linux停止了发布，它的项目由Fedora Project这个项目所取代，并以Fedora Core这个名字发行并提供给普通用户免费使用。Fedora Core这个Linux发行版更新很快，大约半年左右就有新的版本发布。目前的版本是Fedora Core 6，这个Fedora Core试验的韵味比较浓厚，每次发行都有新的功能被加入到其中，得到的成功结果将被采用道RHEL的发布中。虽说这样，频繁的被改进更新的不安定产品对于企业来说并不是最好的选择，大多数企业还是会选择有偿的RHEL产品（这里面有很深的含义，比如说企业用Linux赚钱，赚到的钱回报给企业，资金在企业间流通，回报社会，提高服务水准等）。
- > RHEL 一直都提供源代码的发行方式，CentOS 就是将 RHEL 发行的源代码从新编译一次，形成一个可使用的二进制版本。由于 LINUX 的源代码是 GNU，所以从获得 RHEL 的源代码到编译成新的二进制，都是合法。只是 REDHAT 是商标，所以必须在新的发行版里将 REDHAT 的商标去掉。

Linux江湖之群雄割据的发行版本 https://www.jianshu.com/p/596acf900d8a
- > <div align="center"><img width="800" height="200" src="https://upload-images.jianshu.io/upload_images/3845101-728c5840ae4b8458.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp"/></div>

最全Linux的发行版简介，一文读懂各发行版之间的联系和区别 https://cloud.tencent.com/developer/article/1114589

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# RedHat系

## [CentOS](https://www.centos.org/)

> VirtualBox虚拟机里装了CentOS7.5，装完后yum update等都没法用。然后发现ping命令ping数字形式的ip地址可以，但是ping网址就不行，于是猜测是DNS的问题。经过查询后发现应该是要在 `/etc/resolv.conf` 里增加一些可用的DNS（比如8.8.8.8，114.114.114.114等），然后用`service network restart`重启一下网络服务即可。道理是这个道理，但是蛋疼的是只要一重启网络， `/etc/resolv.conf` 这个文件内容就还原了。。。擦！于是后面就是查一查怎样让修改永久生效。下面三个帖子综合看一下吧，反正核心点是修改 `/etc/sysconfig/network-scripts/ifcfg-eth<N>`，在这个文件里添加 `PEERDNS=no DNS1=XXX.XXX.XXX.XXX DNS2=XXX.XXX.XXX.XXX`等。我是加了如下的就好了。
`PEERDNS=no
DNS1=192.168.1.1
DNS2=8.8.8.8
DNS3=114.114.114.114`

- CentOS修改DNS重启或者重启network服务后丢失问题处理 https://www.linuxidc.com/Linux/2015-09/122761.htm
- /etc/resolv.conf 的更改在重启后丢失的解决办法 https://blog.csdn.net/qq_29350001/article/details/51785176
- linux resolv.conf 配置信息丢失解决方法 https://blog.csdn.net/wt346326775/article/details/56840619

--------------------------------------------------

CentOS 7 中 hostnamectl 的使用 https://www.linuxprobe.com/centos-7-hostnamectl.html
```
1.查看状态

# hostnamectl 或者 # hostnamectl status   (显示的结果都一样）

   Static hostname: localhost.localdomain
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 049717292ec9452890e50401d432e43c
           Boot ID: 2e69a66a7c724db6a44a8536f1670f7f
    Virtualization: kvm
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-229.el7.x86_64
      Architecture: x86_64
```
```
2.修改主机名称

# hostnamectl set-hostname Linuxprobe
# hostnamectl status

   Static hostname: linuxprobe
   Pretty hostname: Linuxprobe
         Icon name: computer-vm
           Chassis: vm
        Machine ID: dc99c115d7414d159fa4c5c0c0541c55
           Boot ID: 6236b67c13af4d98b5fa3780e66dfdeb
    Virtualization: kvm
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-229.el7.x86_64
      Architecture: x86_64
```

centos7 最小化安装 无 ifconfig,netstat 的安装 https://www.cnblogs.com/cocoajin/p/4064547.html
```
今天要用netstat命令，然后知道了两件事：
(1)CentOS Minimal不带netstat
(2)netstat工具对应的包不叫netstat（之前也碰到过这种情况，忘了是哪个软件了）

[root@cloudsec2 ~]# yum install -y netstat
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
No package netstat available.
Error: Nothing to do

--------------------------------------------------

然后是下面的内容是上面那个帖子里的解决方法以及一丢丢知识：

centos7 最小化安装之后，默认是没有 ifconfig,netstat命令的；我们可以直接使用 yum -y install net-tools 即可；

1. 先来看下 net-tools的信息
    yum info net-tools
2. 安装net-tools ，需要管理员权限
    yum -y install net-tools
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

CentOS 8 正式版发布 https://www.ithome.com/0/447/093.htm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Debian系

## Debian

Debian 26 岁生日快乐！Happy DebianDay! https://www.debian.cn/archives/3359 【2019-08-16】
- > 美国当地时间 8 月 16 日（即今天），Debian 在官网发文庆祝诞生26周年。文中说到，26 年前的今天，Ian Murdock 在 comp.os.linux.development 新闻组中宣布完成了一个全新的 Linux 发行版，将其称为”Debian”。
- > 从那天起，Debian 产生了超过 1,288,688,830 行代码，生成了超过 300 个衍生版本，增加了 6155 个已知贡献者，并提交了 975,619 个bug报告。

Debian Linux正在投票是否支持非systemd初始化系统 https://www.ithome.com/0/462/554.htm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 嵌入式设备OS

BusyBox: The Swiss Army Knife of Embedded Linux https://busybox.net/about.html

BusyBox 简化嵌入式 Linux 系统 https://www.ibm.com/developerworks/cn/linux/l-busybox/index.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 移动设备OS

PrimeOS开启公测：在笔记本上运行Android应用和游戏 - 软件和应用 - cnBeta.COM https://www.cnbeta.com/articles/tech/785527.htm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他OS

用于年幼学童教学的 Linux 发行版 PrimTux 发布第 4 版 - Linux - cnBeta.COM
https://www.cnbeta.com/articles/soft/781939.htm
