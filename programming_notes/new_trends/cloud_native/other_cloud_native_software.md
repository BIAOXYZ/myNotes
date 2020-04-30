
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

# Rancher

# Rancher official

Rancher 1.6 Docs https://rancher.com/docs/rancher/latest/zh/

# Rancher others

使用Rancher光速搭建K8s集群 https://how2realize.gitbook.io/project/zen-yang-shi-xian-de/shi-yong-rancher-guang-su-da-jian-k8s-ji-qun

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

# Calico

## Calico官方

Cloud native networking and network security https://docs.projectcalico.org/ || https://github.com/projectcalico/calico

## Calico其他

calico网络模型中的路由原理 https://segmentfault.com/a/1190000016565044

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# GlusterFS

Ceph vs GlusterFS vs MooseFS vs HDFS vs DRBD https://computingforgeeks.com/ceph-vs-glusterfs-vs-moosefs-vs-hdfs-vs-drbd/

## Heketi

heketi (Githubwiki) https://github.com/heketi/heketi/wiki

通过Heketi管理GlusterFS为K8S集群提供持久化存储 https://www.cnblogs.com/netonline/p/10288219.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Tekton

## Tekton官网

Tekton https://tekton.dev/ || https://github.com/tektoncd

## Tekton其他

【是的，没有弄错。标题是Knative，里面全是Tekton】Knative 初体验：CI/CD 极速入门 https://www.infoq.cn/article/aObvliqZ-50LseaTyZ3E

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Tectonic

Introducing Tectonic - a Kubernetes + CoreOS Platform https://tectonic.com/blog/announcing-tectonic/

We’re integrating Tectonic with Red Hat OpenShift https://coreos.com/tectonic/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Notary

Notary is a project that allows anyone to have trust over arbitrary collections of data https://github.com/theupdateframework/notary

# CirrOS

CirrOS https://launchpad.net/cirros

cirros https://docs.docker.com/samples/library/cirros/

What distribution is CirrOS based on? https://stackoverflow.com/questions/14987339/what-distribution-is-cirros-based-on

How to install packages in cirros OS https://stackoverflow.com/questions/26606361/how-to-install-packages-in-cirros-os
> As @Harikrishnan commented, cirros does not include a package manager. Cirros is mostly useful to verify that clouds are working correctly, that VMs are started correctly and things like networks, security groups and key pairs are functioning as expected.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Hybrid Cloud / Multi-Cloud

## CP4MCM
// 参见专门的页面

## Google Anthos

Anthos, Bringing the cloud to you. https://cloud.google.com/anthos/

Anthos overview https://cloud.google.com/anthos/docs/concepts/anthos-overview

## Azure Arc

## VMware Tanzu

## Red Hat RHACM (Red Hat Advanced Cluster Management for Kubernetes)

Red Hat Advanced Cluster Management for Kubernetes https://www.redhat.com/en/technologies/management/advanced-cluster-management

Red Hat Advanced Cluster Management for Kubernetes documentation https://github.com/open-cluster-management/rhacm-docs

## Rancher Fleet

Fleet Management for Kubernetes is Here https://rancher.com/blog/2020/fleet-management-kubernetes/

Manage large fleets of Kubernetes clusters https://github.com/rancher/fleet

Fleet vs Rancher https://stackshare.io/stackups/fleet-vs-rancher

Fleet Management of Kubernetes Clusters at Scale — Rancher’s Fleet https://itnext.io/fleet-management-of-kubernetes-clusters-at-scale-ranchers-fleet-de161cc52325

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# AWS

AWS 云服务大全（71 种） https://linux.cn/article-8591-1.html
