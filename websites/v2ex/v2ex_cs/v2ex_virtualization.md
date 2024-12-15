
除了 VMware,virtualbox 意外，还有其他什么创建一个独立环境的工具吗 https://www.v2ex.com/t/1097313
- > nix-shell? https://nixos.wiki/wiki/Development_environment_with_nix-shell
- > 如果楼主用的是 Linux, 那么 `lxc` 完全够用了，Ubuntu 还封装了一个 `lxd` 作为 Web 前端
- > `vagrant` ，支持 virtualbox vm ，或者就用 docker 起 container
- > wsl2,不做限制，吃满宿主机资源
  >> wsl2 并不完全独立，还是会发生交叉的，前几天才碰到过一次，zx 这个库，在存在 wsl 的时候，会默认调用 wsl 里面的 node 跑脚本，我折腾到通宵才查出问题所在。。。
- > Ubuntu 提供的 multipass ，不过只能用 Ubuntu 系统
- > qemu/kvm 遥遥领先
- > orbstack
- > 你这需求 hyper-V 就行了，别折腾了。
- > linux 的话直接 kvm 一步到位，cpu hostpassthrough + Pci passthrough ，可以把网卡，显卡都直通给虚拟机用，intel 十代以前核显还能开启 intel gvt-g 让主机和虚拟机共享一个显卡，功耗和性能都最优 这些 vmware 和 virtualbox 都做不到
- > 这个时候就要说到 LXC 了， 我发现这个东西是真的挺好用的， 虽然我目前也不怎么懂
- > `lxd` ，除了支持 `lxc` 容器之外，还支持虚拟机；一站式管理。 通过 lxc shell 登陆各个虚机/容器很方便，镜像丰富，支持 dir/zfs 等各种后端存储，还支持快照。也能在其他机器上远程执行 lxc 指令管理机器。
- > PVE
- > 现在的 CPU 硬件虚拟化性能损失很低，主要的性能差距是 IO 。如果你直通磁盘+全额分配 CPU 核心给虚拟机，那性能差异不会很大
- > hyperv 吧，hyperv 有一个好处，就是可以用 Terraform 这样的 iac 工具部署虚拟机
- > windows 的话可以尝试下从 vhdx 启动,和物理机没差别, 想清理环境直接把 vhdx 文件考过去覆盖下又是好汉一条. <br> linux 下就上 btrfs 吧,做好快照, 比 vhdx 更省事.
- > vagrant 创建 libvirt 虚拟机
- > 这场景我熟，开一个虚机就够了，也没必要用 docker 每次重头搭环境，独立环境通过 nix 相关工具维护。 <br> 下边是用来创建独立环境的工具，排名不分先后。效果上你可以理解为 conda, 创建一个具备你要的环境的 shell, 不用了退出去就回到日常环境了（易用性上推荐 `devbox` 和 `flox` ）
  ```console
  devbox
  devenv
  flox
  organist
  nix develop
  guix shell (p.s. 基于 guix 而非 nix, 文档好但包比较老，不推荐)
  ```
- > ventoy 来启动虚拟机镜像,就是物理机加载虚拟机镜像来运行,实现性能 0 损耗, 感兴趣可以去 ventoy 官方看看文档,我现在就是这么玩的, 主系统 ubuntu,利用 vbox 生成 win11 跟 linux 系统镜像, 然后 grub 加入 ventoy 来启动镜像,这样对主系统实现 0 干扰,因为虚拟机系统只想当一个巨大的文件
- > https://github.com/dockur/windows
  >> 突然发现，docker 也能安装 windows

如何学习虚拟化相关技术？ https://www.v2ex.com/t/937955
- > 可参考 https://zhuanlan.zhihu.com/p/400088344 <br> 南大的 NEMU 实验应该比较对口
- > 不知道楼主想了解哪块儿？有看到一个课程 https://github.com/tandasat/Hypervisor-101-in-Rust ，不知道是不是你需要的
- > 从业方向刚好就这一块，搞过 RHEV 、OpenStack 和纯 Libvirt 集群，建议从 KVM 开始学起，Domain 的 XML 关键字段，基本的 CRUD 这些然后再慢慢深入网络这一块。
- > 可以看看那些运维培训的 KVM 课程，那种课程看完下来基本上算是入门了。

老哥们知道怎么远程 ssh 到 KVM 的 guest 系统吗？ https://www.v2ex.com/t/909004
- >
  ```
  1.在 guest 上做 frp
  2.linux 的图形模型转文本模式（ tty?）
  3.使用 virt-manager
  4.使用远程控制软件（如：向日葵）
  ```
- > 用过 qemu/kvm ，启动指令里可以设置一个端口转发，把 sever guest 的 22 端口转发到 sever host 的某个端口，然后 ssh 连 host 上转发的端口就行了
- > 主要取决于你的网络配置，如果是使用 libvirt 默认的 nat 网络（ 192.168.122.0/24 网段），那可以使用：`ssh -J user@host_addr user@guest_addr`
- > 都是用 ssh 去登录管理的，无论虚机还是实体机。除了要装 windows 的 kvm 系统。虚机生产也是一个脚本搞定，用 `cloud-init`

qemu 有没有办法 dump guest 的每个 vcpu 寄存器的值？ https://www.v2ex.com/t/864663

Linux 容器实现的底层原理是什么？和虚拟化技术一样吗？ -- 一个菜鸟的学习笔记分享 https://www.v2ex.com/t/729913
