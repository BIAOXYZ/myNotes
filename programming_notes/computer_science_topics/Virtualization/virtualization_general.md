
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

libvirt https://wiki.archlinuxcn.org/wiki/Libvirt

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

libvirt-go https://github.com/libvirt/libvirt-go
- > Read-only mirror. Please submit merge requests / issues to https://gitlab.com/libvirt/libvirt-go

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

在qemu中模拟设备 - 知乎用户G0K17q的文章 - 知乎 https://zhuanlan.zhihu.com/p/57526565

Qemu tutorial https://linuxhint.com/qemu-tutorial/

How To Use QEMU From the Linux Command-Line https://www.baeldung.com/linux/qemu-from-terminal

用 qemu-user 在arm linux机器上运行amd64/x86程序 https://www.cnblogs.com/bamanzi/p/run-x86-linux-progs-with-qemu-user-on-arm.html

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

# 虚拟机迁移

迁移虚拟机 https://docs.vmware.com/cn/VMware-vSphere/7.0/com.vmware.vsphere.vcenterhost.doc/GUID-FE2B516E-7366-4978-B75C-64BF0AC676EB.html

6.11. 在主机间迁移虚拟机 https://access.redhat.com/documentation/zh-cn/red_hat_enterprise_virtualization/3.6/html/virtual_machine_management_guide/sect-migrating_virtual_machines_between_hosts

KVM 实现虚拟机在线热迁移 https://cloud.tencent.com/developer/article/1671091
- > **一、KVM 虚拟机的迁移方式**  
  * > **KVM虚拟机的迁移有两种方法**：
    + > 1、***`静态迁移`（`冷迁移`）***：对于冷迁移，就是在虚拟机关闭状态下，将虚拟机的`磁盘文件`及`.xml配置文件`（<ins>这两个文件组成了一个虚拟机</ins>）复制到要迁移到的目标主机上，然后在目标主机上使用“`virsh define *.xml`”命令重新定义虚拟机即可。
    + > 2、***`动态迁移`（`热迁移`）***：对于热迁移，比较常用，通常是这台服务器上正在跑着一些业务，而这些业务又不允许中断，那么就需要使用热迁移了，这篇博文将详细写出热迁移的步骤。
  * > **1、冷迁移**
    + > 通常我们存放虚拟机磁盘的目录都是挂在的一个nfs文件系统的磁盘，而这个磁盘通常是LVM文件系统。所以需要进行冷迁移时，只要在目标主机上挂载这个nfs文件系统，就可以看到要迁移的那个虚拟机的磁盘文件，通常以`.qcow2`或`.raw`结尾的，然后，只需将虚拟机的`.xml`配置文件发送到目标服务器上，然后重新定义一下即可通过“`virsh list --all`”命令查看到迁移过来的虚拟机。
  * > **2、热迁移**
    + > ***如果源宿主机和目的宿主机共享存储系统，则只需要通过网络发送客户机的 vCPU 执行状态、内存中的内容、虚机设备的状态到目的主机上。否则，还需要将客户机的磁盘存储发到目的主机上***。共享存储系统指的是源和目的虚机的镜像文件目录是在一个共享的存储上的。在基于 共享存储系统 时，KVM 动态迁移的具体过程为：
      - > 1、迁移开始时，客户机依然在宿主机上运行，与此同时，客户机的内存页被传输到目的主机上。
      - > 2、QEMU/KVM 会监控并记录下迁移过程中所有已被传输的内页的任何修改，并在所有内存页都传输完成后即开始传输在前面过程中内存页的更改内容。
      - > 3、QEMU/KVM 会估计迁移过程中的传输速度，当剩余的内存数据量能够在一个可以设定的时间周期（默认 30 毫秒）内传输完成时，QEMU/KVM 会关闭源宿主机上的客户机，再将剩余的数据量传输到目的主机上，最后传输过来的内存内容在目的宿主机上恢复客户机的运行状态。
      - > 4、至此，KVM 的动态迁移操作就完成了。迁移后的客户机尽可能与迁移前一致，除非目的主机上缺少一些配置，比如网桥等。注意，***当客户机中内存使用率非常大而且修改频繁时，内存中数据不断被修改的速度大于KVM能够传输的内存速度时，动态迁移的过程是完成不了的，这时候只能静态迁移***。
      >> 【[:star:][`*`]】 //notes：其实热迁移过程的重点是对内存内容进行迁移，整个过程有点像过去做在线扩容特性时的方案。
  * > **3、迁移的注意事项**
    + > 无论是冷迁移还是热迁移，注意事项大都差不多
    + > 迁移前目标服务器的要求如下：
      ```console
      最好迁移的服务器cpu品牌一样；
      64位只能在64位宿主机间迁移，32位可以迁移32位和64位宿主机；
      宿主机中的虚拟机名字不能冲突；
      目的宿主机和源宿主机软件配置尽可能的相同，如 有相同的桥接网卡，资源池等；
      两台迁移的主机 cat /proc/cpuinfo |grep nx 的设置是相同的NX，全名为“No eXecute”，即“禁止运行”，是应用在CPU的一种技术，用作把存储器区域分隔为只供存储处理器指令集，或只供数据使用。任何使用NX技术的存储器，代表仅供数据使用，因此处理器的指令集并不能在这些区域存储。这种技术可防止大多数的缓冲溢出，即一些恶意程序，把自身的恶意指令集放在其他程序的数据存储区并运行，从而把整台计算机控制。
      ```
    + > 1、静态迁移
      ```console
      拷贝镜像文件和虚拟机配置文件；
      重新定义此虚拟机。
      ```
    + > 2、动态迁移
      ```console
      创建共享存储；
      两台机器挂载共享存储(手工挂载；使用资源池)；
      启动动态迁移；
      创建迁移后的虚拟机配置文件；
      重新定义虚拟机。
      ```
- > 冷迁移呢，比较简单，可以理解为就是在一台电脑上将虚拟机的配置文件复制到另一台电脑上
  ```sh
  #将虚拟机磁盘文件和配置文件都复制到一台新设备上
  [root@kvm-test ~]# scp /kvm/disk/test1.raw root@192.168.171.10:/kvm/disk/              
  [root@kvm-test ~]# scp /etc/libvirt/qemu/test1.xml root@192.168.171.10:/etc/libvirt/qemu/
  #在新设备上可以将配置文件中的UUID上删除掉
  #然后直接在新设备上定义配置文件
  [root@kvm2 ~]# virsh define test1.xml
  #之后就可以启动了
  ```
- > 二、kvm虚拟机热迁移配置实例
  >> 【[:star:][`*`]】 //notes：后面的内容太长，且很多图片，省略了。但是作者用一个一直执行的 `ping` 命令来模拟迁移过程中服务不断掉的思路还是不错的。

vsphere 虚拟机的迁移，冷迁移，vmotion（热迁移） https://www.cnblogs.com/zhangxingeng/p/10019695.html
- > **三、冷迁移**
  >> 【[:star:][`*`]】 //notes：虽然冷迁移相对简单，但是这部分作者给出了整个操作过程的截图，还是挺详细的。
- > **三、vMotion热迁移**  【这里作者序号错了，应该是“`四、vMotion热迁移`”了。】
  * > **2、虚拟机关闭或挂起时，先移动存储到共享存储**
  * > **3、运行中的主机需要热迁移必须先开启配置VMotion**
  * > **4、使用vMotion热迁移虚拟机**
    + > 迁移过程中，虚拟机工作进程可以继续运行
    + > 虚拟机状态会在备用主机上也就是新的主机上运行
    + > 虚拟机的状态信息包括 ***当前内存的内容以及所有定义和标识虚拟机的信息***。内存内容包括事务数据和位于内存中的任意位数的操作系统和应用程序，存储在专题中的定义和标识信息包括所有映射到虚拟机硬件元素（BIOS、设备、CPU）的数据、以太网卡mac地址、芯片组状态、寄存器等。
    + > 通过vMotion迁移虚拟机时，虚拟机的新主机必须满足兼容性要求，才能继续进行迁移。vMotion迁移分3个阶段进行
      ```console
      当请求通过vMotion迁移时，vCenter Server将验证现有虚拟机与其当前主机是否处于稳定状况
      此时，虚拟机状况信息（内存、寄存器和网络连接）将复制到目标主机
      虚拟机将恢复其新主机上的活动
      ```
    + > 如果迁移期间出错，虚拟机将恢复 其原始状态和位置。已挂起虚拟机的迁移以及通过vMotion迁移也称为热迁移，因为他们运行在不关闭虚拟机电源的情况迁移虚拟机
    + > 使用vMotion热迁移的步骤，与冷迁移不同，只是在预迁移虚拟机可以正在运行，在迁移过程虚拟机的业务不会中断，一会我会把主机181上的win10-175 虚拟机迁移到175上
    + > 步骤如下
      - > 10）、全部过程总结：`确定对象---》右键虚拟机开始迁移---》虚拟机互相ping，win10上ping  win10-175---》继续刚才的迁移步骤，选择迁移类型---》仅更改计算资源---》选择计算资源---》选择主机175---》选了网络资源---》保持分布式端口即可vlan1001---》选择优先级---》安排优先级高的vmotion---》完成，等待迁移完成---》查看ping情况`
      >> 【[:star:][`*`]】 //notes：跟上一个文章类似，也是因为后面的内容太长，且很多图片，省略了（但是这个作者有个过程总结，这里贴了一下）。而且我发现这个作者也是和上一篇的作者一样：用一个一直执行的 `ping` 命令来模拟迁移过程中服务不中断。
