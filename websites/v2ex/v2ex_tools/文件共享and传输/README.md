
分享一个最近发现的挺好用的「 剪贴板./文件互传 」互传项目吧 https://www.v2ex.com/t/1015956
```console
背景是这样的，日常冲浪/学习需要，很多时候都需要手机或电脑剪贴板互传，用过很多诸如 kde connect 、localsend 、文件闪传等等的局域网文件互传工具，都没很好符合个人的使用需求，

上面之前用过那些或多或少都有都不能完全满足以上几个点，直到过年前几天在逛着酷安发现了这个项目 
https://github.com/doraemonkeys/WindSend

体验了一周确实很不错分享一下，日常使用电脑传到手机，不管是剪贴板文件还是文字甚至是文件夹，只需要在电脑端 ctrl+c ，然后去手机端去 app 复制就完成了，
完美满足了像我这种不需要完全同步剪贴板，但有些时候又需要传输文字或文件还嫌麻烦的人，同时也是加密传输，服务的占用极小
```
- > 试试 https://mfiles.maokebing.com/
- > localsend 吧，体验很不错
- > 直接用微软官方的 link to windows 就好
- > 这个呢？ https://online.bqrdh.com/p2p/transfer

局域网内传输文件最快的方案或软件是什么? https://www.v2ex.com/t/936118
- > 这个完全得看场景吧，自己的两台机器，小文件直接 scp ，大文件走 NFS ；要是和同事互传可能就用 `nc`
- > smb
- > LocalSend https://github.com/localsend/localsend
- > 我一直在用 node 的命令， `http-server -p=8081`
- > 局域网内最快的方案，先升级 2.5G 网口的路由器+交换机+机箱上的网卡也升级成带有 2.5G 网口，或者用一个 2.5G 网口的 USB 千兆网卡（ RTL 部分网卡，还要某些特定版本的驱动才能满速）
局域网共享文件夹 _，
- > smb 共享文件夹，跑满。
- > netsend ，能跑满内网带宽 https://github.com/williamnie/netSend
- > `python -m http.server`
- > dukto
- > sftp
- > 个人感觉，smb 不如 webdav ，推荐一个轻量化 webdav 软件 <br> https://github.com/docblue/chfsgui
- > rsync <br> windows 用 hfs
- > ftp
- > `croc`
- > 答案是 resilio sync, 你们说的都是中心化，P2P 才是最快的
- > https://github.com/KOHGYLW/kiftd 公司局域网找了台机器搭了一个这个，挺好用
- > 自荐： https://github.com/songquanpeng/go-file
- > https://github.com/blenderskool/blaze?ref=appinn <br> webrtc,直接网页就可以 p2p 了
- > iSCSI 挂载 LUN 到本地然后复制
- > 用 `sshfs` 挂载后就跟本地文件夹一样用
  >> //notes：感觉这个好像不错，回头可以试试。但是查了下（ https://github.com/libfuse/sshfs ）好像已经不维护了- -
- > https://github.com/LANDrop/LANDrop 这个也行
- > https://mongoose.ws/binary/ 92kb 的服务器(比 python 的同步服务器好)

跨网，不安装任何软件、服务，怎么传输文件呢？ https://www.v2ex.com/t/882592
```console
单靠浏览器，跨网，不安装任何软件、服务，怎么传输文件呢？ 局域网 drop.ioiox.com 比较靠谱，跨网 file.pizza 根本无法下载。 有好用的跨网传输？
```
- > 单靠浏览器, 可以走 webrtc? https://sendfiles.dev/
- > 有 ssh 的话走 ssh ，有 git 用 github ，有 curl 就用奶牛之类的中转
- > https://wormhole.app/
- > https://webwormhole.io/
- > https://tmp.link/ 无需登录 20g 保持 24 小时
  >> tmplink +1 很好用
- > 走 bashupload.com 连浏览器都不需要，有 curl 就行
- > https://musetransfer.com/
- > https://easychuan.cn/
- > https://github.com/dutchcoders/transfer.sh
- > rsync 试试呢，据说支持续传
- > p2p 的方式跨强可行吗？感觉 UDP 包没出门就被拦截完了
- > 看下 bitwarden 的 send 功能能符合你的需求么,就是默认生成的访问链接太复杂了
- > https://transfer.sh/
- > 
  ```console
  https://anonfile.com/
  https://cowtransfer.com/
  https://wetransfer.com/
  https://www.filemail.com/
  https://send-anywhere.com/
  https://filetransfer.io/
  https://app.tmp.link/
  https://www.file.io/
  ```
- > ngrok + http-server
