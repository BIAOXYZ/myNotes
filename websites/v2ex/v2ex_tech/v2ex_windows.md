
win 下的 Linux 环境选择 https://www.v2ex.com/t/874664

WSL 网络突然不可用了，真的是得远离瘟到死 https://www.v2ex.com/t/808578
```console
之前一切正常，最近也没有安装啥更新的
突然间今天发现开发工具连不上 WSL 里的 mysql 了，遂进去检查，发现 wsl 里的网络没有了
没有到 Ubuntu 报的是没有网络设备
什么重置网络、重新启用 Linux 子系统，全都试了没用
wsl 也没有 netplan 、networking 什么乱七八糟的东西，网络都是不能配置的，也不能重启相关网络服务
真的不知道怎么操作了
```
```console
谢谢大家得帮助，我最终通过 Google + stackoverflow 解决了问题
解决方法是 Disable swap
在 windows 中添加如下文件 %userprofile%.wslconfig，内容是：
``
[wsl2]
swap=0
``
但具体是因为什么原因导致的，还不清楚
```
```console
结帖
找到问题的原因了，简单说就是不要启用磁盘压缩，磁盘压缩了 swap，导致了问题
但至于为啥 swap 压缩会影响网络，不知道
以及微软官方说的压缩只是 ntfs 4k 的问题，而非真正的文件压缩，是怎么影响到功能的，不知道

感谢 @mxT52CRuqR6o5 提供的链接
https://stackoverflow.com/questions/66338549/wsl2-network-unreachable
https://github.com/microsoft/WSL/issues/5437#issuecomment-647161596
```
```console
感谢 @weiceshi 的讲解
具体问题详情大家可以看#27 、#29 、#31 楼
```
