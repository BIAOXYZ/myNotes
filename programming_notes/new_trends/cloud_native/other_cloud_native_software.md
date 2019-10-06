
# Cloud Native general

技术和架构等相关文档 https://github.com/xunchangguo/km //这个链接在program general那里也记了，但是因为很多cloud native的东西，所以这里也再记下。

## xxx-as-a-Service

Bare metal cloud vs. IaaS – are they the same thing? https://www.redstation.com/blog/bare-metal-cloud-vs-iaas-are-they-the-same-thing/
> Bare metal cloud is an environment in which physical, dedicated servers can be provisioned to customers with cloud-like ease and speed. Bare metal cloud customers are given access to the entire processing power of individual servers, as well as any storage, networking or other services they require.
>
> Within a bare metal infrastructure there is no multi-tenanting (sharing of machines) and the servers provisioned are not virtual ones created on top of any hypervisor.

怎么理解 IaaS、SaaS 和 PaaS 的区别？ - 满尚的回答 - 知乎 https://www.zhihu.com/question/20387284/answer/272965090

IaaS vs. PaaS vs. CaaS如何选择？ https://www.cnblogs.com/geekkiller/p/5007450.html

## lift and shift

lift and shift https://whatis.techtarget.com/definition/lift-and-shift
> Lift and shift is a strategy for moving an application or operation from one environment to another – without redesigning the app. In the lift-and-shift approach, certain workloads and tasks can be moved from on-premises storage to the cloud, or data operations might be transferred from one data center to another.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Prometheus

## Prometheus官网

Prometheus - From metrics to insight https://prometheus.io/

Prometheus https://github.com/prometheus

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Prometheus组件

- The Prometheus time series database layer. https://github.com/prometheus/tsdb
- Exporter for machine metrics https://github.com/prometheus/node_exporter

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Prometheus book

Prometheus操作指南 https://yunlzheng.gitbook.io/prometheus-book/ || https://github.com/yunlzheng/prometheus-book
- 容器监控：cAdvisor https://yunlzheng.gitbook.io/prometheus-book/part-ii-prometheus-jin-jie/exporter/commonly-eporter-usage/use-prometheus-monitor-container
- 使用Node Exporter采集主机数据 https://yunlzheng.gitbook.io/prometheus-book/parti-prometheus-ji-chu/quickstart/prometheus-quick-start/use-node-exporter

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Prometheus源码

- Prometheus 实战于源码分析之scrape https://blog.csdn.net/u010278923/article/details/70946004
- Prometheus 实战于源码分析之collector https://blog.csdn.net/u010278923/article/details/70927773

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Prometheus其他

Kubernetes 集群健康监控 https://supereagle.github.io/2019/05/26/k8s-health-monitoring/
> Kubernetes + Prometheus: `* Kubernetes 必须容器化部署 * 依赖 Prometheus`

还不了解 CNCF？关于 CNCF 的三问三答！ http://blog.daocloud.io/cncf-3/
> Prometheus 是一套开源的监控、报警和时间序列数据库的组合，成立于 2012 年，由 SoundCloud 公司开发，此后许多组织接受和采用了 Prometheus，遂将其独立为开源项目。该项目使用 Go 语言开发，社区氛围非常活跃。

Prometheus架构与实践分享 https://mp.weixin.qq.com/s/beusaP2f3mOMIlEETBhtjg

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

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

深入浅出Kubernetes网络：跨节点网络通信之Flannel https://mp.weixin.qq.com/s/UqsLnVcHVFKi2Ijlr94xVw

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# GlusterFS

Ceph vs GlusterFS vs MooseFS vs HDFS vs DRBD https://computingforgeeks.com/ceph-vs-glusterfs-vs-moosefs-vs-hdfs-vs-drbd/

## Heketi

heketi (Githubwiki) https://github.com/heketi/heketi/wiki

通过Heketi管理GlusterFS为K8S集群提供持久化存储 https://www.cnblogs.com/netonline/p/10288219.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Notary

Notary is a project that allows anyone to have trust over arbitrary collections of data https://github.com/theupdateframework/notary

# CirrOS

CirrOS https://launchpad.net/cirros

cirros https://docs.docker.com/samples/library/cirros/

What distribution is CirrOS based on? https://stackoverflow.com/questions/14987339/what-distribution-is-cirros-based-on

How to install packages in cirros OS https://stackoverflow.com/questions/26606361/how-to-install-packages-in-cirros-os
> As @Harikrishnan commented, cirros does not include a package manager. Cirros is mostly useful to verify that clouds are working correctly, that VMs are started correctly and things like networks, security groups and key pairs are functioning as expected.

# Google Anthos

Anthos, Bringing the cloud to you. https://cloud.google.com/anthos/

Anthos overview https://cloud.google.com/anthos/docs/concepts/anthos-overview

