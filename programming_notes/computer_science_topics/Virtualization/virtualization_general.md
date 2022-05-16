
# virtualization general

SUSE Linux Enterprise Server 15 SP2 虚拟化指南 https://documentation.suse.com/zh-cn/sles/15-SP2/html/SLES-all/book-virt.html
- 第 II 部分 使用 `libvirt` 管理虚拟机 https://documentation.suse.com/zh-cn/sles/15-SP2/html/SLES-all/part-virt-libvirt.html
  * 8 启动和停止 libvirtd https://documentation.suse.com/zh-cn/sles/15-SP2/html/SLES-all/cha-libvirt-overview.html

## from wikipedia

Category:Virtualization software https://en.wikipedia.org/wiki/Category:Virtualization_software

Comparison of platform virtualization software https://en.wikipedia.org/wiki/Comparison_of_platform_virtualization_software

Hypervisor https://en.wikipedia.org/wiki/Hypervisor

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## others

Virtualization Wars: VMware vs. Hyper-V vs. XenServer vs. KVM https://www.pcworld.com/article/243216/virtualization_wars_vmware_vs_hyperv_vs_xenserver_vs_kvm.html

Linux 桌面玩家指南：07. Linux 中的 Qemu、KVM、VirtualBox、Xen 虚拟机体验 https://www.cnblogs.com/youxia/p/LinuxDesktop007.html

VMware Fusion 12 发布！免费，支持 macOS 运行 Windows/Linux https://www.ithome.com/0/504/597.htm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Libvirt

libvirt https://libvirt.org/

libvirt https://zh.wikipedia.org/wiki/Libvirt || https://en.wikipedia.org/wiki/Libvirt
- > libvirt支持多款虚拟机监视器且被多个管理方案所支持
  >> ![](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Libvirt_support.svg/450px-Libvirt_support.svg.png)

Libvirt (简体中文) https://wiki.archlinux.org/index.php/Libvirt_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

Libvirt 虚拟化库剖析 https://www.ibm.com/developerworks/cn/linux/l-libvirt/index.html

# libvirt 文章

About Libvirt https://linuxhint.com/about_libvirt/
- > **Background**
  * > If you are already familiar with tools like [`virsh`, `virt-install`, `virt-manager`, `oVirt`, etc](https://libvirt.org/apps.html) then you are already using `libvirt` without even knowing it. The aforementioned tools use `libvirt` in the backend and provide a user-friendly interface be it command line or GUI.
- > **Architecture**
  * > Libvirt is designed to work with any hypervisor and has grown over the years to work with [a wide array of hypervisors](https://libvirt.org/hvsupport.html). The `libvirt daemon` exposes an API that can be used by apps like `virt-manager` or `virsh` (and even ***your custom Python scripts***). The user requests are received by the API. These requests could be anything like create a KVM guest, or show me the memory used by a given LX contianer, etc.
  * > The `libvirt daemon` then delegates the request to the appropriate `libvirt hypervisor driver`. This driver understands and implements all the specifics of a given virtualization technology and carries out the instructions accordingly.
  * > There’s a different class of drivers for handling storage and even networks of VMs.
- > **Pools and Volumes**
  * > In `libvirt` vernacular, a <ins>`single virtual storage device`</ins> associated with any VM, like the `qcow2`, `raw` or `vmdk` image file of a VM or mountable ISO is known as a ***`volume`***. The <ins>`storage media`</ins> used on the host to store a group of associated volumes is known as a ***`pool`***. You can ***use an NFS servers as a `pool`, or a ZFS dataset, as previously mentioned***. If you don’t have a fancy storage solution, then ***you can simply use a directory***.
  * > By default, `libvirt` has two different pools. First is `/var/lib/libvirt/images` and `/var/lib/libvirt/boot`. ***Volumes for a single VM can be split across multiple pools***. For example, I store all the clean cloud images and OS installer ISOs in the /var/lib/libvirt/boot pool and for individual VMs rootfs is installed in image files stored in /var/lib/libvirt/images.
- > **Configurations**
  * > Virsh is a popular tool to configure everything from your VM, virtual machine networking and even storage. The configuration files themselves live in the XML format. You will find yourself issuing commands like:
    ```sh
    $ virsh dumpxml VM1
    $ virsh edit VM1
    ```
  * > And similarly, there are subcommands like `net-dumpxml` and `pool-edit` to view or configure the configuration of pools, networks, etc. If you are curious to where these configuration files live, you can go to `/etc/libvirt/` and find your hypervisors concerned directory.  The parent directory `/etc/libvirt/` itself contains a lot of global configurations like `drivers` (e.g `qemu.conf` and `lxc.conf` ) and their configuration and the default behaviour of `libvirt`.
  * > To look at specific configuration of individual components like the VMs, pools and volumes you have to go to the corresponding directories. For qemu guests this is `/etc/libvirt/qemu`
    ```sh
    root@deb:/etc/libvirt/qemu# ls -al
    total 24
    drwxr-xr-x 4 root root 4096 Apr 21 10:39 .
    drwxr-xr-x 6 root root 4096 Apr 28 17:19 ..
    drwxr-xr-x 2 root root 4096 Apr 21 10:39 autostart
    drwxr-xr-x 3 root root 4096 Apr 14 13:49 networks
    -rw------- 1 root root 3527 Apr 20 19:10 VM1.xml
    -rw------- 1 root root 3527 Apr 20 19:09 VM2.xml
    ```
    > The autostart directory will contain symlinks to VM1.xml and VM2.xml if you have confiured the VMs to autostart when the host system boots ( `$ virsh autostart VM1` ).
  * > Similarly, the `/etc/libvirt/qemu/network` contains a configurations for the default network a `qemu guest`. The `/etc/libvirt/storage` contains XMLs defining the storage pools.
- > **Conclusion**
  * > After that you can start playing with `virsh` CLI and see and manage entities like `Domain` (***`libvirt` calls `guest VMs` a `domain`***) `networks`, `storage pools` and `volumes`. This will make you comfortable enough with the technology that you can move on to other concepts like `snapshots` and `network filter`. I hope this article will prove to be a good starting point for you.

# 其他语言的 libvirt api

## libvirt go

go-libvirt https://github.com/digitalocean/go-libvirt
- > Package go-libvirt provides a pure Go interface for interacting with libvirt.
- > Rather than using libvirt's C bindings, this package makes use of libvirt's RPC interface, as documented [here](https://libvirt.org/internals/rpc.html). Connections to the libvirt server may be local, or remote. RPC packets are encoded using the XDR standard as defined by RFC 4506.

nicloud/nicloud/libvirtd/libvit.go https://github.com/niklaus-code/nicloud/blob/1eb6788b15b3fe815394c2763cb37345a42db3cb/nicloud/libvirtd/libvit.go

## libvirt python

Libvirt Application Development Guide Using Python https://libvirt.org/docs/libvirt-appdev-guide-python/en-US/html/
- https://libvirt.org/docs/libvirt-appdev-guide-python/en-US/html/libvirt_application_development_guide_using_python-Connections.html

Libvirt with Python https://linuxhint.com/libvirt_python/
- > In one of my previous posts, I showed how one can get started with [Libvirt and KVM](https://linuxhint.com/libvirt_qemu_kvm_debian/).
  * Setting up Libvirt QEMU and KVM stack on Debian https://linuxhint.com/libvirt_qemu_kvm_debian/
- > **Virsh and Starting the Default Network**
  * > The xml file can show you the range of possible IP addresses and the how they will communicate with the outside world. ***Basically, the traffic will come to them via a NAT and they won’t be a part of your host’s external network. You can use Bridge Networking to expose each VM to the host machine’s LAN***.
- > **To start a Virtual Machine**
  * > To start a virtual machine we need an installation media (like the installation ISO for any operating system) and how many CPUs and how much memory needs to be allocated to the VM, and if it needs VNC. This step is where you can really appreciate a GUI installer like `virt-manager`, however, we will do it using a rather complex `virt-install` command.
- > **Establishing Connection with the Libvirtd service**
  * > Libvirt can be used to manage a number of different virtualization and containerization stack. KVM-QEMU, Xen and LXC are the most popular of these. So when you enter `libvirt.open(‘qemu:///system’)` libvirt enables you to gather information about, and manage, QEMU guests. You can just as well, talk to LXD daemon or Xen hypervisor using `lxc:///system` or `xen:///system` respectively.
  * > Similarly, the method `libvirt.open()` is not the only one at your disposal. `open(name)`, `openAuth(uri, auth, flags)` and `openReadOnly(name)` are three different calls each of which returns a ***`virConnect`*** object and offers varying level of control over the host. You can read more about them [here](https://libvirt.org/docs/libvirt-appdev-guide-python/en-US/html/libvirt_application_development_guide_using_python-Connections.html). For now, we have conn as an object of the virConnect class. This object is a gateway for doing almost anything from configuring the hypervisor itself to modifying the guests and their resource allocation.
- > **Listing and Monitoring VMs**
  * > If you are maintaining a large array of VMs you need a method to create hundreds of VMs with uniform configuration which also scale properly from simple single threaded workloads to multi-core, multi-threaded processing. ***Libvirt calls the guest VMs (or containers if you are using LXC) `Domains`*** and you can list information about individual `domains` as well as configure them if your `virConnect` object has sufficient privileges.
  * > This returns an array of domain IDs which are just small integers for a simple libvirt setup. A more reliable way of labeling your VMs, without having two VMs (let’s say on different nodes) with the same ID or name, is to use UUIDs. ***In libvirt everything can have a `UUID`***, which is randomly generated `128 bit number`. The chances of you creating two identical UUID are quite small indeed.
  * > Now that we have a ***`libvirt.virDomain`*** object, let’s use it to list various details about this running VM.
    ```py
    >>> domain.info()
    ```
    > This gives you the information regarding the state of the VM, maximum memory and cpu cores as shown here.
    > 
    > You can also find other information about the VM using different methods like OSType()
    ```py
    >>> domain.OSType()
    'hvm'
    ```

Python libvirt API - create a Virtual Machine https://stackoverflow.com/questions/33892909/python-libvirt-api-create-a-virtual-machine
- https://stackoverflow.com/questions/33892909/python-libvirt-api-create-a-virtual-machine/33914064#33914064
  * > I finally found and answer to my problems- so I'm posting the solution here in case anyone ever hits the same problem.
  * > The libvirt connection object can work with storage pools.
  * > From the libvirt.org: `"A storage pool is a quantity of storage set aside by an administrator, often a dedicated storage administrator, for use by virtual machines. Storage pools are divided into storage volumes either by the storage administrator or the system administrator, and the volumes are assigned to VMs as block devices."`
  * > Basically a volume is what `quemu-img create` creates. Once you create a storage pool in the same directory where all the `.img` (created using `qemu-img`) files are; the files created with `qemu-img` are seen as volumes.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# QEMU

QEMU https://zh.wikipedia.org/wiki/QEMU

QEMU (简体中文) https://wiki.archlinux.org/index.php/QEMU_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

【工程技术】QEMU运行Linux Kernel环境配置 https://blog.csdn.net/HaoBBNuanMM/article/details/106625017

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Xen

虚拟化 - KVM 和 Xen 比较 https://www.cnblogs.com/sammyliu/articles/4389981.html

LINUX的XEN和KVM到底区别在什么地方？ - 知乎 https://www.zhihu.com/question/19844004

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Hyper-V

A curated list of Hyper-V exploitation resources, fuzzing and vulnerability research. https://github.com/shogunlab/awesome-hyper-v-exploitation

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vCenter and vSphere

vSphere, ESXi 和 vCenter 的区别 - 张雷的文章 - 知乎 https://zhuanlan.zhihu.com/p/32873934

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# [WSL(Windows Subsystem for Linux)](https://blogs.msdn.microsoft.com/wsl/)

## WSL安装

- ~~Windows 10 Installation Guide https://docs.microsoft.com/zh-cn/windows/wsl/install-win10~~  -->  安装 WSL https://docs.microsoft.com/zh-cn/windows/wsl/install
- 不用装双系统，直接在 Windows 上体验 Linux：Windows Subsystem for Linux https://sspai.com/post/43813 【这个比官方的更好】

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## WSL其他

用 WSL 的人多吗？个人认为 win10 最大特点之一的 WSL 身边竟然没多少人用 https://www.v2ex.com/t/632880
> bash 中通过 python -m SimpleHTTPServer 命令可以快速创建一个 localhost:8000 静态服务器，用于调试 html，或者共享文件，其他电脑输入局域网 ip:8000 可快速下载文件；

为什么微软 WSL 的默认终端输入体验比其他同类的应用好？ https://www.oschina.net/news/112320/why-typing-inside-wsl-terminal-better-than-every-other-app

windows linux子系统(Windows Subsystem for Linux)的存放目录 https://www.cnblogs.com/lynsyklate/p/7911189.html

Windows、WSL与Linux性能对比 https://www.ithome.com/0/463/355.htm

请问如何 ssh 到家里的 WSL 上？ https://www.v2ex.com/t/838221
- https://felixsmli.gitlab.io/posts/share-a-windows-pc-through-ssh/
