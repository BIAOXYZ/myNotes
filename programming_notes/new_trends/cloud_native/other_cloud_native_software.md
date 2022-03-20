
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

## [SLA]()、[SLO]()

Service-level objective https://en.wikipedia.org/wiki/Service-level_objective

Service-level agreement https://en.wikipedia.org/wiki/Service-level_agreement || 服务级别协议 https://zh.wikipedia.org/wiki/%E6%9C%8D%E5%8A%A1%E7%BA%A7%E5%88%AB%E5%8D%8F%E8%AE%AE
- > 服务级别协议（英语：service-level agreement，缩写SLA）也称服务等级协议、服务水平协议，是服务提供商与客户之间定义的正式承诺。服务提供商与受服务用户之间具体达成了承诺的服务指标——质量、可用性，责任。SLA最常见的组成部分是以合同约定向客户提供的服务。例如，互联网服务供应商（ISP）和电信公司通常在与客户的合同条款内包含简单定义的服务级别协议。在此事例下，SLA通常定义有平均故障间隔（MTBF）、平均修复时间或平均修复时间（MTTR）；哪一方负责报告错误与支付费用；吞吐量；抖动；或类似的可衡量细节。

The Difference between SLI, SLO, and SLA https://enqueuezero.com/the-difference-between-sli-slo-and-sla.html

What is an SLA? Best practices for service-level agreements https://www.cio.com/article/2438284/outsourcing-sla-definitions-and-solutions.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Rancher

# Rancher official

Rancher 1.6 Docs https://rancher.com/docs/rancher/latest/zh/

## rke

rke -- Rancher Kubernetes Engine, an extremely simple, lightning fast Kubernetes installer that works everywhere. https://github.com/rancher/rke

RKE Kubernetes Installation https://rancher.com/docs/rke/latest/en/installation/

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

# rook

***`Quickstart`***:
- Ceph Storage Quickstart https://rook.io/docs/rook/v1.3/ceph-quickstart.html
  * > Deploy the Rook Operator
  * > Create a Rook Ceph Cluster
  * > Storage
    + > [Block Storage] (https://rook.io/docs/rook/v1.3/ceph-block.html)   【1】
    + > [Shared Filesystem] (https://rook.io/docs/rook/v1.3/ceph-filesystem.html)   【2】
- Network Filesystem (NFS) https://rook.io/docs/rook/v1.3/nfs.html


个人实战1：安装rook-ceph block类型的存储（`RWO`型的）。
```sh
# 在OCP上的实战。需注意一下几点：
# 第二步建operator时，OCP应该用operator-openshift.yaml，而不是operator.yaml。
# storageclass.yaml是我从【1】里复制下来的，但是其实直接用下面文件是一样的：
    `仓库根目录(也就是rook)/cluster/examples/kubernetes/ceph/csi/rbd/storageclass.yaml`

export KUBEADMINPASSWD=orw6b-Bnj2g-MPJov-TwWKi
oc login -u kubeadmin -p $KUBEADMINPASSWD --server=https://api.oprinstall.cp.fyre.ibm.com:6443 --insecure-skip-tls-verify=true
oc create -f ~/mcminstall-operator/rook/cluster/examples/kubernetes/ceph/common.yaml
oc create -f ~/mcminstall-operator/rook/cluster/examples/kubernetes/ceph/operator-openshift.yaml
oc create -f ~/mcminstall-operator/rook/cluster/examples/kubernetes/ceph/cluster.yaml
sleep 5s && oc create -f ~/mcminstall-operator/rook/cluster/examples/kubernetes/ceph/manually/storageclass.yaml
kubectl patch storageclass rook-ceph-block -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

个人实战2：安装rook-cephfs类型的存储（`RWX`型的）。
```sh
# 登陆那两句（一个export，一个oc login，参见上面部分）就直接省略了。
oc create -f ~/mcminstall-operator/rook/cluster/examples/kubernetes/ceph/common.yaml
oc create -f ~/mcminstall-operator/rook/cluster/examples/kubernetes/ceph/operator-openshift.yaml
oc create -f ~/mcminstall-operator/rook/cluster/examples/kubernetes/ceph/cluster.yaml
oc create -f ~/mcminstall-operator/rook/cluster/examples/kubernetes/ceph/csi/cephfs/storageclass.yaml
oc patch storageclass rook-cephfs -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
#// 这里后来发现还得创建下面这个才行。
oc create -f ~/mcminstall-operator/rook/cluster/examples/kubernetes/ceph/filesystem.yaml
```

***`Ceph Storage`***:
- Shared Filesystem https://rook.io/docs/rook/v1.3/ceph-filesystem.html
- Ceph CSI Drivers https://rook.io/docs/rook/v1.3/ceph-csi-drivers.html

***`Ceph Tools`***:
- Rook Toolbox https://rook.io/docs/rook/v1.3/ceph-toolbox.html

OpenShift https://rook.io/docs/rook/v1.1/openshift.html

`rook/cluster/examples/kubernetes/ceph/` https://github.com/rook/rook/tree/release-1.1/cluster/examples/kubernetes/ceph

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

Docker内容信任之Notary镜像签名方案初调研 https://medium.com/@xiaoxiaosue/docker%E5%86%85%E5%AE%B9%E4%BF%A1%E4%BB%BB%E4%B9%8Bnotary%E9%95%9C%E5%83%8F%E7%AD%BE%E5%90%8D%E6%96%B9%E6%A1%88%E5%88%9D%E8%B0%83%E7%A0%94-ce7c322ce68f

# CirrOS

CirrOS https://launchpad.net/cirros

cirros https://docs.docker.com/samples/library/cirros/

What distribution is CirrOS based on? https://stackoverflow.com/questions/14987339/what-distribution-is-cirros-based-on

How to install packages in cirros OS https://stackoverflow.com/questions/26606361/how-to-install-packages-in-cirros-os
> As @Harikrishnan commented, cirros does not include a package manager. Cirros is mostly useful to verify that clouds are working correctly, that VMs are started correctly and things like networks, security groups and key pairs are functioning as expected.

cirros用例 https://github.com/yifengyou/cirros

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# cert-manager

Installation -- OpenShift https://cert-manager.io/docs/installation/openshift/

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

INSTALL
- https://access.redhat.com/documentation/en-us/red_hat_advanced_cluster_management_for_kubernetes/1.0/html-single/install/index
- https://access.redhat.com/documentation/en-us/red_hat_advanced_cluster_management_for_kubernetes/2.0/html/install/installing#installing-red-hat-advanced-cluster-management-from-the-console
  * > i. Copy your OpenShift Container Platform pull secret from [cloud.redhat.com/openshift/install/pull-secret](https://cloud.redhat.com/openshift/install/pull-secret) by selecting Copy pull secret. You will use the content of this pull secret in an step later in this procedure. Your OpenShift Container Platform pull secret is associated with your Red Hat Customer Portal ID, and is the same across all Kubernetes providers.

## Rancher Fleet

Fleet Management for Kubernetes is Here https://rancher.com/blog/2020/fleet-management-kubernetes/

Manage large fleets of Kubernetes clusters https://github.com/rancher/fleet

Fleet vs Rancher https://stackshare.io/stackups/fleet-vs-rancher

Fleet Management of Kubernetes Clusters at Scale — Rancher’s Fleet https://itnext.io/fleet-management-of-kubernetes-clusters-at-scale-ranchers-fleet-de161cc52325

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# AWS

AWS 云服务大全（71 种） https://linux.cn/article-8591-1.html
