
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

Vagrant 替换 PVE 和 EXSI 咋样？ https://www.v2ex.com/t/815520
- > esxi 劝退，pve 值得拥有。
- > 看公司规模，或者应用场景 我这个公司的本地环境虚拟化用 vagrant ，我个人觉得没啥问题
- > PVE 是可以拿来跑生产的，vagrant 是给你构建开发环境的。你公司服务器如果只是拿来开发，小鸡都是随手开随手删的，那换 vagrant 倒是无所谓。
- > 我个人体验觉得还是 esxi 好，什么管理工具都全
- > pve 创建高可用集群，模板，备份之类的都很灵活
- > 只是普通虚拟机管理，不需要直通硬件，不考虑性能的话，vagrant 够用了
- > PVE 的模板都是 LXC 这种容器，ESXI 使用模板每次都要上传。vagrant 的模板 box 只需要导入即可，下次要用就很方便，模板也更新很及时，像 rockylinux 这种马上就出来了
  >> ESXi 模板的正确使用方法是：1.第一次需要根据自己的需求，建立一台模板虚拟机。2.需要使用模板时，直接链接克隆就行，既不需要导入，更不需要下载，比 PVE 、vagrant 、Docker 还要方便且定制性高。建议你试试。
  >>> 是的，我的意思是没有现成的系统，比如像 rockylinux 就需要自己安装制作模板
- > exsi 似乎没有免费版？试用版安装好以后只能用 60 天，要么每次都先迁移后重装，要么破解 但是公司商业环境用破解版不怕被查水表吗？个人建议还是 pve 吧！
  >> 免费版是要注册账号申请一个 Key 并输入的。输入 Key 后会产生限制，每个 VM 最高 8 核，并且 vCenter 和 vStorage 会关闭
