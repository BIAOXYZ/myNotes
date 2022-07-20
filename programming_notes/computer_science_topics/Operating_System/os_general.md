
# OS Book

《用 “芯”探核： 基于龙芯的 Linux 内核探索解析》将在 8 月上旬推出 https://www.ithome.com/0/501/140.htm

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

0.2秒居然复制了100G文件？ 我给同事讲了一个小时，他感动得快哭了... https://mp.weixin.qq.com/s/lxAhVuF2KBhR0w3sr-bhWA

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 文件描述符(FD)

文件句柄（file handles） & 文件描述符（file descriptors） https://blog.csdn.net/u013256816/article/details/60778709

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 管道(pipe)

匿名管道 https://zh.wikipedia.org/wiki/%E5%8C%BF%E5%90%8D%E7%AE%A1%E9%81%93

### 命名管道
// 出处： https://docs.ansible.com/ansible-tower/3.6.3/html/userguide/credentials.html --> `Ansible Tower uses SSH to connect to remote hosts (or the Windows equivalent). In order to pass the key from Tower to SSH, the key must be decrypted before it can be written a named pipe. Tower then uses that pipe to send the key to SSH (so that it is never written to disk).`

命名管道 https://zh.wikipedia.org/wiki/%E5%91%BD%E5%90%8D%E7%AE%A1%E9%81%93 || Named pipe https://en.wikipedia.org/wiki/Named_pipe
- > 命名管道是计算机进程间的一种先进先出通信机制。是类Unix系统传统管道的扩展。传统管道属于匿名管道，其生存期不超过创建管道的进程的生存期。但命名管道的生存期可以与操作系统运行期一样长。
- > 与传统的无名的shell管道不同，命名管道利用了文件系统。使用`mkfifo()`或`mknod()`创建命名管道。两个进程可以通过管道的名字打开、读写管道。
- > PostgreSQL的命令行工具`psql`也支持从命名管道装入数据。

Named Pipe or FIFO with example C program https://www.geeksforgeeks.org/named-pipe-fifo-example-c-program/

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

## virtual memory

为什么 Linux 需要虚拟内存 https://draveness.me/whys-the-design-os-virtual-memory/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## kernel module

Loadable kernel module https://en.wikipedia.org/wiki/Loadable_kernel_module

Kernel module (简体中文) https://wiki.archlinux.org/index.php/Kernel_module_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

Writing a Simple Linux Kernel Module https://blog.sourcerer.io/writing-a-simple-linux-kernel-module-d9dc3762c234

The Linux Kernel Module Programming Guide https://linux.die.net/lkmpg/index.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Unix socket

What's the difference between Unix socket and TCP/IP socket? https://serverfault.com/questions/124517/whats-the-difference-between-unix-socket-and-tcp-ip-socket
```
A UNIX socket is an inter-process communication mechanism that allows bidirectional data exchange 
between processes running on the same machine.

IP sockets (especially TCP/IP sockets) are a mechanism allowing communication between processes 
over the network. In some cases, you can use TCP/IP sockets to talk with processes running on the 
same computer (by using the loopback interface).

UNIX domain sockets know that they’re executing on the same system, so they can avoid some 
checks and operations (like routing); which makes them faster and lighter than IP sockets. So if you 
plan to communicate with processes on the same host, this is a better option than IP sockets.

Edit: As per Nils Toedtmann's comment: UNIX domain sockets are subject to file system permissions, 
while TCP sockets can be controlled only on the packet filter level.
```

Unix domain socket 简介 https://www.cnblogs.com/sparkdev/p/8359028.html
- > Unix domain socket 又叫 IPC(inter-process communication 进程间通信) socket，用于实现同一主机上的进程间通信。socket 原本是为网络通讯设计的，但后来在 socket 的框架上发展出一种 IPC 机制，就是 UNIX domain socket。虽然网络 socket 也可用于同一台主机的进程间通讯(通过 loopback 地址 127.0.0.1)，但是 UNIX domain socket 用于 IPC 更有效率：不需要经过网络协议栈，不需要打包拆包、计算校验和、维护序号和应答等，只是将应用层数据从一个进程拷贝到另一个进程。这是因为，IPC 机制本质上是可靠的通讯，而网络协议是为不可靠的通讯设计的。

Unix Socket Tutorial https://www.tutorialspoint.com/unix_sockets/index.htm

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

# 上下文切换

03 | 基础篇：经常说的 CPU 上下文切换是什么意思？（上） https://shouliang.github.io/2019/01/16/Linux%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96/03%20%7C%20%E5%9F%BA%E7%A1%80%E7%AF%87%EF%BC%9A%E7%BB%8F%E5%B8%B8%E8%AF%B4%E7%9A%84%20CPU%20%E4%B8%8A%E4%B8%8B%E6%96%87%E5%88%87%E6%8D%A2%E6%98%AF%E4%BB%80%E4%B9%88%E6%84%8F%E6%80%9D%EF%BC%9F%EF%BC%88%E4%B8%8A%EF%BC%89/

04 | 基础篇：经常说的 CPU 上下文切换是什么意思？（下） https://shouliang.github.io/2018/11/28/Linux%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96/04%20%7C%20%E5%9F%BA%E7%A1%80%E7%AF%87%EF%BC%9A%E7%BB%8F%E5%B8%B8%E8%AF%B4%E7%9A%84%20CPU%20%E4%B8%8A%E4%B8%8B%E6%96%87%E5%88%87%E6%8D%A2%E6%98%AF%E4%BB%80%E4%B9%88%E6%84%8F%E6%80%9D%EF%BC%9F%EF%BC%88%E4%B8%8B%EF%BC%89/

进程/线程上下文切换会用掉你多少CPU？ - 张彦飞的文章 - 知乎 https://zhuanlan.zhihu.com/p/79772089

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 操作系统中的算法

## 哲学家就餐问题

Dining philosophers problem https://en.wikipedia.org/wiki/Dining_philosophers_problem || 哲学家就餐问题 https://zh.wikipedia.org/wiki/%E5%93%B2%E5%AD%A6%E5%AE%B6%E5%B0%B1%E9%A4%90%E9%97%AE%E9%A2%98
- > 哲学家就餐问题（英语：Dining philosophers problem）是在计算机科学中的一个经典问题，用来演示在并发计算中多线程同步（Synchronization）时产生的问题。
- > 在1971年，著名的计算机科学家艾兹格·迪科斯彻提出了一个同步问题，即假设有五台计算机都试图访问五份共享的磁带驱动器。稍后，这个问题被托尼·霍尔重新表述为哲学家就餐问题。这个问题可以用来解释死锁和资源耗尽。

哲学家就餐问题 https://blog.csdn.net/theLostLamb/article/details/80741319

五个哲学家就餐问题 https://blog.csdn.net/low5252/article/details/104800671

【操作系统】“哲学家进餐”问题 https://blog.csdn.net/qq_28602957/article/details/53538329

## 银行家算法

Banker's algorithm https://en.wikipedia.org/wiki/Banker%27s_algorithm || 银行家算法 https://zh.wikipedia.org/wiki/%E9%93%B6%E8%A1%8C%E5%AE%B6%E7%AE%97%E6%B3%95

操作系统——银行家算法（Banker's Algorithm） https://www.cnblogs.com/wkfvawl/p/11929508.html

计算机操作系统_银行家算法 https://blog.csdn.net/qq_36260974/article/details/84404369

银行家算法 https://blog.csdn.net/weixin_43886592/article/details/107582347

银行家算法详解（C语言） https://blog.csdn.net/weixin_43362002/article/details/106153822
