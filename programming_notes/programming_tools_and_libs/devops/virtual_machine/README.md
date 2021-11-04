
Virtualbox vs VMware: Head-to-Head Comparison https://phoenixnap.com/kb/virtualbox-vs-vmware

# 各种镜像下载

Download Ubuntu Desktop https://ubuntu.com/download/desktop
- `wget https://releases.ubuntu.com/20.04.3/ubuntu-20.04.3-desktop-amd64.iso`

# 其他

使用 vmware 还是 docker 来搭建 Linux 实验环境？ https://www.v2ex.com/t/812956
- > `multipass` 试试
- > vmware 自带了一个 `vctl` 命令，和 docker 差不多，你可以试一下，但是这个命令明显不如 docker 好用
- > 看你的内容涉不涉及 linux 网络和 linux 内核，如果不涉及 wsl2 即可。
- > 用这个： https://github.com/VMwareFusion/vctl-docs/blob/master/docs/getting-started.md
- > 看你用啥电脑，***因为 mac 和 window 装 docker desktop 都是先给你装了一个 linux 虚拟机，然后然后容器都在这个 linux 内核上面跑***。。。不过你要是用 wsl2 的话，那就可以直接在上面跑容器里，毕竟 wsl2 本身也是个 linux 虚拟机。。。。我的做法是我有一台闲置的台式机，然后台式机装的 `vmware exsi` ，在上面开若干个 ubuntu server ，然后在里面跑 docker 去，恰好可以玩玩 k8s
- > hyper-v 除了不能直通 usb 设备, 显卡稀烂(Linux, 但 5.14 内核会有 hyper-v drm 驱动, 据说 Wayland 下性能好像有提升了). 其它挺好的啊. hyper-v 的优势: 自带, 不要钱, 性能优秀, 甚至可以说很优秀. <br> 不知道大家知道这个小技巧不: 使用默认交换机来 nat 上网时, guest 的 ip 一直变很烦. 为解决此问题, host 可以使用 xxx.mshome.net 这个 dns 名称来访问 xxx 主机名的这个 guest. 不用 ip 了.
