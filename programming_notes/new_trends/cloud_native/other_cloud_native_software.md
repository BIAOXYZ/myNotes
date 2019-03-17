
# Cloud Native general

技术和架构等相关文档 https://github.com/xunchangguo/km //这个链接在program general那里也记了，但是因为很多cloud native的东西，所以这里也再记下。

# Prometheus

还不了解 CNCF？关于 CNCF 的三问三答！ http://blog.daocloud.io/cncf-3/
> Prometheus 是一套开源的监控、报警和时间序列数据库的组合，成立于 2012 年，由 SoundCloud 公司开发，此后许多组织接受和采用了 Prometheus，遂将其独立为开源项目。该项目使用 Go 语言开发，社区氛围非常活跃。

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# Flannel

flannel 0.10.0 Documentation https://coreos.com/flannel/docs/latest/

flannel is a network fabric for containers, designed for Kubernetes https://github.com/coreos/flannel

- Flannel 原理简析及安装 https://www.hi-linux.com/posts/30481.html
- Kubernetes基于flannel的网络配置 https://jimmysong.io/posts/kubernetes-network-config/
- DockOne技术分享（十八）：一篇文章带你了解Flannel http://dockone.io/article/618
- Docker 配置Flannel网络过程及原理 https://blog.csdn.net/liukuan73/article/details/54897594

理解Kubernetes网络之Flannel网络 https://tonybai.com/2017/01/17/understanding-flannel-network-for-kubernetes/

Kubernetes-基于flannel的集群网络 https://www.kubernetes.org.cn/4105.html
> "2）运行容器时，在宿主机上创建虚拟网卡veth pair设备，veth pair设备是成对出现的，从而组成一个数据通道，数据从一个设备进入，就会从另一个设备出来。将veth pair设备的一端放在新创建的容器中，命名为eth0；另一端放在宿主机的docker0中，以veth为前缀的名字命名。通过 brctl show 命令查看放在docker0中的veth pair设备"

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# Notary

Notary is a project that allows anyone to have trust over arbitrary collections of data https://github.com/theupdateframework/notary
