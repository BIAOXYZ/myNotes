

# 官方连接

***--------------------------------------------------分割线--------------------------------------------------***

Official Website (官方网站):
- Kubernetes (k8s) is an open-source system for automating deployment, scaling, and management of containerized applications. https://kubernetes.io/
- Kubernetes 是用于自动部署，扩展和管理容器化应用程序的开源系统。 https://kubernetes.io/zh/

Kubernetes Documentation https://kubernetes.io/docs/home/
- Concepts https://kubernetes.io/docs/concepts/
  * Pods https://kubernetes.io/docs/concepts/workloads/pods/
- Tutorials https://kubernetes.io/docs/tutorials/
  * Overview of Kubernetes Online Training https://kubernetes.io/docs/tutorials/online-training/overview/

Kubernetes 文档 https://kubernetes.io/zh/docs/
- 使用命令式的方式管理 Kubernetes 对象 https://kubernetes.io/zh/docs/tutorials/object-management-kubectl/imperative-object-management-command/

--------------------------------------------------  

Production-Grade Container Scheduling and Management https://kubernetes.io || https://github.com/kubernetes/kubernetes

Kubernetes community content https://github.com/kubernetes/community
- Kubernetes Contributor Guide https://github.com/kubernetes/community/blob/master/contributors/guide/README.md

--------------------------------------------------

Kubernetes中文社区 https://www.kubernetes.org.cn/
- 名词解释 Pods https://www.kubernetes.org.cn/kubernetes-pod
- 使用kubeadm安装Kubernetes 1.12 https://www.kubernetes.org.cn/4619.html

Kubernetes中文社区 | 中文文档 http://docs.kubernetes.org.cn/
- Kubernetes kubectl 命令表 http://docs.kubernetes.org.cn/683.html
- Kubernetes 架构 http://docs.kubernetes.org.cn/251.html
  * Kubernetes指南 https://legacy.gitbook.com/book/feisky/kubernetes/details

--------------------------------------------------

Topic: kubernetes https://github.com/topics/kubernetes

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# kubernetes books

Kubernetes中文指南/云原生应用架构实践手册 https://github.com/rootsongjc/kubernetes-handbook
> https://jimmysong.io/kubernetes-handbook/

Kubernetes Handbook （Kubernetes指南） https://github.com/feiskyer/kubernetes-handbook
- Kubernetes指南 https://kubernetes.feisky.xyz
- Kubernetes指南 https://legacy.gitbook.com/book/feisky/kubernetes/details

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# kubernetes general

A curated list for awesome kubernetes sources shiptada https://ramitsurana.github.io/awesome-kubernetes/ || https://github.com/ramitsurana/awesome-kubernetes

https://k8smeetup.github.io/
- Kubernetes Basics https://k8smeetup.github.io/docs/tutorials/kubernetes-basics/

如何学习、了解kubernetes？ - 知乎 https://www.zhihu.com/question/37498459
- 如何学习、了解kubernetes？ - 刘小龙的回答 - 知乎 https://www.zhihu.com/question/37498459/answer/398838177
  * 从零开始搭建Kubernetes集群（一、开篇） https://www.jianshu.com/p/78a5afd0c597
- 如何学习、了解kubernetes？ - Jimmy Song的回答 - 知乎 https://www.zhihu.com/question/37498459/answer/527503822
  * Kubernetes Handbook——Kubernetes中文指南/云原生应用架构实践手册 https://jimmysong.io/kubernetes-handbook/

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# kubernetes 常用命令

Kubernetes By Example -- Brought to you by the OpenShift team http://kubernetesbyexample.com/
- DIY -- Try out for yourself http://kubernetesbyexample.com/diy/
  * Installing Minishift https://docs.okd.io/latest/minishift/getting-started/installing.html
- Pods -- Kubernetes pods by example http://kubernetesbyexample.com/pods/

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# kubernetes 快速开始

Kubernetes系统架构简介 http://www.infoq.com/cn/articles/Kubernetes-system-architecture-introduction

Docker 和 Kubernetes：给程序员的快速指南 - 江宏的文章 - 知乎 https://zhuanlan.zhihu.com/p/39937913

Kubernetes初探 - CSDN博客 https://blog.csdn.net/zhangjun2915/article/details/40598151

Kubernetes基础与架构 https://www.fangzhipeng.com/kubernetes/2018/09/30/k8s-basic1/
> Docker入门与实战 https://www.fangzhipeng.com/docker/2018/09/12/docker-action/

Kubernetes新手快速入门指南 https://mp.weixin.qq.com/s/lMyMZyskekmN5BWwqjFDsQ

Learn Kubernetes in Under 3 Hours: A Detailed Guide to Orchestrating Containers https://medium.freecodecamp.org/learn-kubernetes-in-under-3-hours-a-detailed-guide-to-orchestrating-containers-114ff420e882

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# kubernetes 组件

## kubectl

- docker用户过度到kubectl命令行指南 https://jimmysong.io/kubernetes-handbook/guide/docker-cli-to-kubectl.html
- kubectl 命令技巧大全 https://jimmysong.io/kubernetes-handbook/guide/kubectl-cheatsheet.html

--------------------------------------------------

Imperative/Declarative and a Few `kubectl` tricks https://medium.com/bitnami-perspectives/imperative-declarative-and-a-few-kubectl-tricks-9d6deabdde
> "However you will see very quickly that these CLI wrappers are very limiting. The full schema is not configurable. For example with kubectl run you cannot create a Pod with multiple containers and you cannot create volumes."

- kubectl命令管理kubernetes对象的三种方式 https://blog.csdn.net/dkfajsldfsdfsd/article/details/80916543
- Kubernetes 对象管理的三种方式 https://blog.csdn.net/kikajack/article/details/80216582

--------------------------------------------------

## Ingress

- Ingress https://kubernetes.io/docs/concepts/services-networking/ingress/
- Kubernetes Ingress 101: NodePort, Load Balancers, and Ingress Controllers https://blog.getambassador.io/kubernetes-ingress-nodeport-load-balancers-and-ingress-controllers-6e29f1c44f2d
  * > "Note that an ingress controller typically doesn’t eliminate the need for an external load balancer — the ingress controller simply adds an additional layer of routing and control behind the load balancer." --> 这个不一定吧？感觉各种在变，说法不一样。
- Kubernetes Ingress with Nginx Example https://matthewpalmer.net/kubernetes-app-developer/articles/kubernetes-ingress-guide-nginx-example.html
  * > "Ingress, on the other hand, is a completely independent resource to your service. You declare, create and destroy it separately to your services.
    >
    > This makes it decoupled and isolated from the services you want to expose. It also helps you to consolidate routing rules into one place.
    >
    > The one downside is that you need to configure an Ingress Controller for your cluster. But that’s pretty easy—in this example, we’ll use the Nginx Ingress Controller."
- Understanding kubernetes networking: ingress https://medium.com/google-cloud/understanding-kubernetes-networking-ingress-1bc341c84078
- Kubernetes ingress解析 https://jimmysong.io/posts/kubernetes-ingress-resource/

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# kubernetes源码

kubeadm源码分析（内含kubernetes离线包，三步安装） https://www.kubernetes.org.cn/4015.html

编译和运行Kubernetes源码 https://www.kubernetes.org.cn/5033.html

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# kubernetes others

Ryan Yang #Kubernetes https://www.yangcs.net/categories/kubernetes/
- Kubernetes DNS 高阶指南 https://www.yangcs.net/posts/kubernetes-dns/
- Kubernetes 的奇技淫巧 -- 打造高效的命令行终端 https://www.yangcs.net/posts/kubernetes-fucking-trick/

50+ 顶级开源 Kubernetes 工具列表 https://www.infoq.cn/article/RPA-wswoEyjuRZfTMcut

## kubernetes news

Docker官方将支持Kubernetes，容器编排大战宣告结束 http://www.infoq.com/cn/news/2017/10/Docker-Kubernetes-Swarm

对不起Linux，Kubernetes现在是更重要的操作系统！ http://www.sohu.com/a/277404425_610730
> Sorry, Linux. Kubernetes is now the OS that matters https://www.infoworld.com/article/3322120/kubernetes/sorry-linux-kubernetes-is-now-the-os-that-matters.html
>> 对不起，小麦。馒头现在是更重要的食物！

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

