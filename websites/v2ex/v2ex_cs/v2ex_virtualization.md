
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
