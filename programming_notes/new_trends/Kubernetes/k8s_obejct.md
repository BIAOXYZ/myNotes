
# kubernetes 组件

## kubectl

- docker用户过度到kubectl命令行指南 https://jimmysong.io/kubernetes-handbook/guide/docker-cli-to-kubectl.html
- kubectl 命令技巧大全 https://jimmysong.io/kubernetes-handbook/guide/kubectl-cheatsheet.html

Kubernetes系统常见运维技巧 https://blog.csdn.net/horsefoot/article/details/51594840 【by 容器技术爱好者】

--------------------------------------------------

Imperative/Declarative and a Few `kubectl` tricks https://medium.com/bitnami-perspectives/imperative-declarative-and-a-few-kubectl-tricks-9d6deabdde
> "However you will see very quickly that these CLI wrappers are very limiting. The full schema is not configurable. For example with kubectl run you cannot create a Pod with multiple containers and you cannot create volumes."

Imperative、Declarative和使用配置文件的方法：
- kubectl命令管理kubernetes对象的三种方式 https://blog.csdn.net/dkfajsldfsdfsd/article/details/80916543
- Kubernetes 对象管理的三种方式 https://blog.csdn.net/kikajack/article/details/80216582

Kubectl apply vs kubectl create? https://stackoverflow.com/questions/47369351/kubectl-apply-vs-kubectl-create

--------------------------------------------------

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## kubernetes API

Kubernetes API https://v1-18.docs.kubernetes.io/zh/docs/concepts/overview/kubernetes-api/ || The Kubernetes API https://v1-18.docs.kubernetes.io/docs/concepts/overview/kubernetes-api/

Kubernetes API Concepts https://v1-18.docs.kubernetes.io/docs/reference/using-api/api-concepts/

Kubernetes API 总览 https://v1-18.docs.kubernetes.io/zh/docs/reference/using-api/api-overview/ || Kubernetes API Overview https://v1-18.docs.kubernetes.io/docs/reference/using-api/api-overview/
- > 为了消除字段或重组资源表示形式，Kubernetes 支持多个 API 版本，每个版本在不同的 API 路径下。例如：`/api/v1` 或者 `/apis/extensions/v1beta1`。
- > API 组 使扩展 Kubernetes API 更容易。API 组在 REST 路径和序列化对象的 apiVersion 字段中指定。当前，有几个正在使用的 API 组：
  * **core**（也称为 **legacy**）组，它位于 REST 路径`/api/v1`上，未指定为 apiVersion 字段的一部分，例如`apiVersion: v1`。
  * 特定名称的组位于 REST 路径`/apis/$GROUP_NAME/$VERSION`下，并使用`apiVersion:$GROUP_NAME/$VERSION`（例如，`apiVersion:batch/v1`）。您可以在 Kubernetes API 参考 中找到受支持的 API Group 的完整列表。

The canonical location of the Kubernetes API definition. https://github.com/kubernetes/api

package v1 https://godoc.org/k8s.io/api/core/v1

【[:star:][`*`]】 Kubernetes API 资源使用-应该使用哪个 Group 和 Version? https://www.qikqiak.com/post/k8s-api-resources-group-and-version/
> 原文链接：https://akomljen.com/kubernetes-api-resources-which-group-and-version-to-use/
```sh
kubectl api-resources -o wide

# 您还可以选择获取特定 API 组的 API 资源，例如：
kubectl api-resources --api-group apps -o wide

# 对于上面的每种资源类型，我们都可以使用kubectl explain命令来获取有关的资源详细信息：
kubectl explain configmap

# 需要注意的是explain命令可能会显示旧的group/version，我们可以通过--api-version参数显示设置它
kubectl explain replicaset --api-version apps/v1

# 我们也可以使用下面的命令来获取集群支持的所有 API 版本：
kubectl api-versions

# 有的时候，我们只想检查特定的group/version是否可以用于某些资源即可，大多数的资源都有可用的GET方法，所以我们只需要尝试
# 获取下资源，同时提供 API 的 version 和 group 即可验证，kubectl get <API_RESOURCE_NAME>.<API_VERSION>.<API_GROUP>，例如：
kubectl get deployments.v1.apps -n kube-system

# 如果资源不存在指定的group/version组合或者资源根本不存在，我们将会收到错误信息：
$ kubectl get deployments.v1beta.apps -n kube-system
error: the server doesn't have a resource type "deployments"
```

Kubernetes REST API https://stackoverflow.com/questions/33024969/kubernetes-rest-api/33027619
- > You can see all the API calls kubectl is making by passing `--v=8` to any kubectl command

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## kubernetes网络

Cluster Networking https://kubernetes.io/docs/concepts/cluster-administration/networking/
- > There are 4 distinct networking problems to address:
  * > Highly-coupled `container-to-container` communications: this is solved by pods and localhost communications.
  * > `Pod-to-Pod` communications: this is the primary focus of this document.
  * > `Pod-to-Service` communications: this is covered by services.
  * > `External-to-Service` communications: this is covered by services.
- > `Every Pod gets its own IP address`. This means you do not need to explicitly create links between Pods and you almost never need to deal with mapping container ports to host ports. This creates a clean, backwards-compatible model where Pods can be treated much like VMs or physical hosts from the perspectives of port allocation, naming, service discovery, load balancing, application configuration, and migration.
- > Kubernetes imposes the following fundamental requirements on any networking implementation (barring any intentional network segmentation policies):
  * > pods on a node can communicate with all pods on all nodes without NAT
  * > agents on a node (e.g. system daemons, kubelet) can communicate with all pods on that node
  * > {Note: For those platforms that support Pods running in the host network (e.g. Linux)}: pods in the host network of a node can communicate with all pods on all nodes without NAT
- > This model is not only less complex overall, but it is principally compatible with the desire for Kubernetes to enable low-friction porting of apps from VMs to containers. If your job previously ran in a VM, your VM had an IP and could talk to other VMs in your project. This is the same basic model.
- > Kubernetes IP addresses exist `at the Pod scope` - ***containers within a Pod share their network namespaces - including their IP address***. This means that ***containers within a Pod can all reach each other’s ports on `localhost`***. This also means that containers within a Pod must coordinate port usage, but this is no different from processes in a VM. ***This is called the “IP-per-pod” model***. <br> How this is implemented is a detail of the particular container runtime in use.
- > It is possible to request ports on the Node itself which forward to your Pod (called host ports), but this is a very niche operation. How that forwarding is implemented is also a detail of the container runtime. ***The Pod itself is blind to the existence or non-existence of host ports***.

Kubernetes技术分析之网络 http://dockone.io/article/545

从外部访问Kubernetes中的Pod https://jimmysong.io/posts/accessing-kubernetes-pods-from-outside-of-the-cluster/

kubernetes网络相关总结 http://codemacro.com/2018/04/01/kube-network/
> Kubernetes网络原理及方案 https://www.kubernetes.org.cn/2059.html

浅析从外部访问 Kubernetes 集群中应用的几种方式 https://www.hi-linux.com/posts/56619.html 【by 运维之美】

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## kubernetes网络之端口相关内容

### 五种port辨析

【[:star:][`*`]】 kubernets 几种端口（port、targetport、contaierport、hostport、nodeport）的区别和关联 http://dockone.io/question/1420
```console
这两个一般用在应用yaml描述文件中,起到的作用类似于docker -p选项
containerport: 容器需要暴露的端口
hostport: 容器暴露的端口映射到的主机端口。

这两个一般用在service中，service 的类型为cluster ip时候:
port: service中clusterip 对应的端口
targetport: clusterIP作为负载均衡， 后端目标实例(容器)的端口。

这一个一般用在service中，service的类型为nodeport:
nodeport: cluster ip 只能集群内部访问(源与目标需要满足两个条件: kube-proxy正常运行，跨主机容器网络通信正常)，
    nodeport会在每个kubelet节点的宿主机开启一个端口，用于应用集群外部访问。
```

端口映射 https://feisky.gitbooks.io/kubernetes/practice/portmap.html
- > 在创建 Pod 时，可以指定容器的 hostPort 和 containerPort 来创建端口映射，这样可以通过 Pod 所在 Node 的 IP:hostPort 来访问服务。比如
  ```yaml
  apiVersion: v1
  kind: Pod
  metadata:
    name: nginx
  spec:
    containers:
    - image: nginx
      name: nginx
      ports:
      - containerPort: 80
        hostPort: 80
    restartPolicy: Always
  ```
- > 使用了 hostPort 的容器只能调度到端口不冲突的 Node 上，除非有必要（比如运行一些系统级的 daemon 服务），不建议使用端口映射功能。如果需要对外暴露服务，建议使用 NodePort Service。

K8s易混点辨析：nodePort、port、targetPort https://blog.csdn.net/yjk13703623757/article/details/79819415

>> 个人总结：
- 【[:star:][`*`]】 首先最关键的一点：`containerport`和`hostport`是写在pod的yaml文件里的；而`nodePort`、`port`和`targetPort`是写在service的yaml文件里的。

### kubectl port-forward V.S. kubectl proxy

Use Port Forwarding to Access Applications in a Cluster https://kubernetes.io/zh/docs/tasks/access-application-cluster/port-forward-access-application-cluster/

How kubectl port-forward works? https://stackoverflow.com/questions/51468491/how-kubectl-port-forward-works

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## kubernetesw网络之Ingress

### ingres from k8s official

- Ingress https://kubernetes.io/docs/concepts/services-networking/ingress/
- Set up Ingress on Minikube with the NGINX Ingress Controller https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/

### ingress from other resources

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

Kubernetes Nginx Ingress 教程 https://mritd.me/2017/03/04/how-to-use-nginx-ingress/

实践kubernetes ingress controller的四个例子 https://tonybai.com/2018/06/21/kubernetes-ingress-controller-practice-using-four-examples/

【[:star:][`*`]】 详解k8s组件Ingress边缘路由器并落地到微服务 https://www.cnblogs.com/justmine/p/8991379.html
- > ![](https://images2018.cnblogs.com/blog/1082769/201805/1082769-20180506230327444-207443165.png)

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## kubernetes网络之DNS

DNS for Services and Pods https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/

使用CoreDNS实现Kubernetes基于DNS的服务发现 https://blog.frognew.com/2018/10/using-coredns-for-kubernetes-service-discovery.html

An Introduction to the Kubernetes DNS Service https://www.digitalocean.com/community/tutorials/an-introduction-to-the-kubernetes-dns-service

Debugging DNS Resolution https://v1-17.docs.kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/

Pod 与 Service 的 DNS https://v1-17.docs.kubernetes.io/zh/docs/concepts/services-networking/dns-pod-service/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## kubernetes网络之Pause Container

【[:star:][`*`]】 The Almighty Pause Container https://www.ianlewis.org/en/almighty-pause-container

What are the pause containers? https://stackoverflow.com/questions/48651269/what-are-the-pause-containers
- > The 'pause' container is a container which holds the network namespace for the pod. Kubernetes creates pause containers to acquire the respective pod’s IP address and set up the network namespace for all other containers that join that pod.
- > You can access below links for details.
  * > https://groups.google.com/forum/#!topic/kubernetes-users/jVjv0QK4b_o
  * > https://www.ianlewis.org/en/almighty-pause-container

Kubernetes Networking: Behind the scenes https://itnext.io/kubernetes-networking-behind-the-scenes-39a1ab1792bb

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## kubernetes client

k8s官方的各种client：
- Official Python client library for kubernetes https://github.com/kubernetes-client/python
- OpenAPI based generated Go Client for Kubernetes https://github.com/kubernetes-client/go

Go client for Kubernetes. https://github.com/kubernetes/client-go 【这个才是常说的`client-go`】

kubernetes client-go包使用示例 https://jimmysong.io/posts/kubernetes-client-go-sample/

Building stuff with the Kubernetes API (Part 4) — Using Go https://medium.com/programming-kubernetes/building-stuff-with-the-kubernetes-api-part-4-using-go-b1d0e3c1c899

使用client-go自定义开发Kubernetes https://xuchao918.github.io/2019/02/13/%E4%BD%BF%E7%94%A8client-go%E8%87%AA%E5%AE%9A%E4%B9%89%E5%BC%80%E5%8F%91Kubernetes/

Kubernetes client-go实战应用 https://juejin.im/post/5bc9d80df265da0ac7272dde

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## kubernetes apiserver

[Kubernetes] Kubernetes核心原理（一）之API Server https://www.huweihuang.com/article/kubernetes/core-principle/kubernetes-core-principle-api-server/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## kubernetes权限和安全

### RBAC

~~Using RBAC Authorization https://kubernetes.io/docs/reference/access-authn-authz/rbac/ || 使用 RBAC 鉴权 https://v1-18.docs.kubernetes.io/zh/docs/reference/access-authn-authz/rbac/~~  【//已转移】

Kubernetes kubectl create clusterrolebinding 命令详解 http://docs.kubernetes.org.cn/494.html

k8s的认证-RBAC机制 https://www.cnblogs.com/shuiguizi/p/13143319.html

RBAC——基于角色的访问控制 https://jimmysong.io/kubernetes-handbook/guide/rbac.html

- Configuring permissions in Kubernetes with RBAC https://medium.com/containerum/configuring-permissions-in-kubernetes-with-rbac-a456a9717d5d
- Configuring RBAC For Your Kubernetes Service Accounts https://medium.com/@lestrrat/configuring-rbac-for-your-kubernetes-service-accounts-c348b64eb242

使用kubectl访问Kubernetes集群时的身份验证和授权 https://tonybai.com/2018/06/14/the-authentication-and-authorization-of-kubectl-when-accessing-k8s-cluster/

***RBAC实战类攻略***：
- KUBERNETES AND RBAC: RESTRICT USER ACCESS TO ONE NAMESPACE https://jeremievallee.com/2018/05/28/kubernetes-rbac-namespace-user.html
- Configure RBAC In Your Kubernetes Cluster https://docs.bitnami.com/kubernetes/how-to/configure-rbac-in-your-kubernetes-cluster/

【[:star:][`*`]】 Kubernetes RBAC 详解 https://www.qikqiak.com/post/use-rbac-in-k8s/

为Kubernetes集群添加用户 - 「已注销」的文章 - 知乎 https://zhuanlan.zhihu.com/p/43237959

Kubernetes中的用户权限管理实战【详细步骤】 https://blog.csdn.net/marlinlm/article/details/122118170

一文读懂k8s RBAC权限控制 https://www.cnblogs.com/eggs0/p/15474352.html || https://cloud.tencent.com/developer/article/1896427

#### aggregationRule
>> //已转移

### kubernetes Security Context
- Configure a Security Context for a Pod or Container https://v1-17.docs.kubernetes.io/docs/tasks/configure-pod-container/security-context/

kubernetes使用securityContext和sysctl http://bazingafeng.com/2017/12/23/kubernetes-uses-the-security-context-and-sysctl/

### kubernetes Pod Security Policy
- Pod 安全策略 https://v1-16.docs.kubernetes.io/zh/docs/concepts/policy/pod-security-policy/ || Pod Security Policies https://v1-16.docs.kubernetes.io/docs/concepts/policy/pod-security-policy/

An illustrated deepdive into Pod Security Policies https://banzaicloud.com/blog/pod-security-policy/

Enable Kubernetes Pod Security Policy with kube-psp-advisor https://sysdig.com/blog/enable-kubernetes-pod-security-policy/

kubernetes支持PodSecurityPolicy https://ieevee.com/tech/2019/02/18/psp.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# kubernetes内部对象

## kubernetes Labels and Annotations

Kubernetes Labels 和 Annotations 最佳实践 https://supereagle.github.io/2019/03/31/k8s-labels/
- > 由于 annotation 的定位是 Kubernetes 资源上附加任意的非标识性元数据，除了在 key 上有跟 label key 完全一样的限制外，在 value 上没有任何限制：可长可短，可结构化可非结构化，可包含任意字符。

## kubernetes Job

***From kubernetes official:***
- Jobs - Run to Completion https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/ 【[:star:][`*`]】
  * > Another way to clean up finished Jobs (either Complete or Failed) automatically is to use a TTL mechanism provided by a **TTL controller** for finished resources, by specifying the .spec.ttlSecondsAfterFinished field of the Job.
    >> TTL Controller for Finished Resources https://kubernetes.io/docs/concepts/workloads/controllers/ttlafterfinished/ --> Alpha Disclaimer: this feature is currently alpha, and can be enabled with **feature gate** TTLAfterFinished.
    >>> Feature Gates https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/    
- 使用工作队列进行精细的并行处理 https://kubernetes.io/zh/docs/tasks/job/fine-parallel-processing-work-queue/

not from kubernetes official:
- Kubernetes对象之Job https://www.jianshu.com/p/bd6cd1b4e076
- 名词解释：Job https://www.kubernetes.org.cn/job
- 使用工作队列进行精细的并行处理 https://k8smeetup.github.io/docs/tasks/job/fine-parallel-processing-work-queue/

## kubernetes CronJob

***From kubernetes official:***
- Running Automated Tasks with a CronJob https://kubernetes.io/docs/tasks/job/automated-tasks-with-cron-jobs/ 【[:star:][`*`]】

Kubernetes对象之CronJob https://www.jianshu.com/p/62b4f0a3134b

Kubernetes的Cron Job https://blog.frognew.com/2017/08/kubernetes-cron-job.html

How to change the schedule of a Kubernetes cronjob or how to start it manually? https://stackoverflow.com/questions/49293736/how-to-change-the-schedule-of-a-kubernetes-cronjob-or-how-to-start-it-manually

## kubernetes static Pods

创建静态 Pod https://kubernetes.io/zh/docs/tasks/configure-pod-container/static-pod/

## kubernetes DaemonSet

Kubernetes对象之DaemonSet https://www.jianshu.com/p/800f049004ec

Kubernetes DaemonSet的滚动升级 https://blog.frognew.com/2017/08/kubernetes-rolling-update-daemonset.html

## kubernetes ReplicaSet

ReplicaSet https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/

Kubernetes对象之ReplicaSet https://www.jianshu.com/p/fd8d8d51741e

### ReplicaSet和另外两个类似对象的区别

Kubernetes Replication Controller, Replica Set and Deployments: Understanding replication options https://www.mirantis.com/blog/kubernetes-replication-controller-replica-set-and-deployments-understanding-replication-options/
- > Replica Sets are declared in essentially the same way as Replication Controllers, except that they have more options for the selector. 
- > Deployments are intended to replace Replication Controllers.  They provide the same replication functions (through Replica Sets) and also the ability to rollout changes and roll them back if necessary.

What is the difference between ReplicaSet and ReplicationController? https://stackoverflow.com/questions/36220388/what-is-the-difference-between-replicaset-and-replicationcontroller

## kubernetes Service

Debug Services https://v1-17.docs.kubernetes.io/docs/tasks/debug-application-cluster/debug-service/ || 调试 Service https://v1-17.docs.kubernetes.io/zh/docs/tasks/debug-application-cluster/debug-service/

Service 的使用 https://www.qikqiak.com/post/use-service-in-k8s/

## kubernetes Taints(污点)和Tolerations(容忍)

Taint 和 Toleration https://kubernetes.io/zh/docs/concepts/configuration/taint-and-toleration/

Kubernetes Pod调度进阶：Taints(污点)和Tolerations(容忍) https://blog.frognew.com/2018/05/taint-and-toleration.html

Kubernetes中的Taint和Toleration（污点和容忍） https://jimmysong.io/posts/kubernetes-taint-and-toleration/

## kubernetes ConfigMap

- Configure a Pod to Use a ConfigMap https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
- 使用ConfigMap来配置Redis https://kubernetes.io/zh/docs/tutorials/configuration/configure-redis-using-configmap/

Kubernetes的ConfigMap详解 https://blog.csdn.net/liukuan73/article/details/79492374

Kubernetes对象之ConfigMap https://www.jianshu.com/p/cf8705a93c6b

【by Jimmy Song】
- Kubernetes的ConfigMap解析 https://jimmysong.io/posts/kubernetes-configmap-introduction/
- Kubernetes ConfigMap热更新测试 https://jimmysong.io/posts/kubernetes-configmap-hot-update/

## kubernetes Volume

emptyDir与hostPath https://www.cnblogs.com/breezey/p/9827570.html
- > **`emptyDir`**
  * > emptyDir类型的volume在pod分配到node上时被创建，kubernetes会在node上自动分配 一个目录，因此无需指定宿主机node上对应的目录文件。这个目录的初始内容为空，当Pod从node上移除时，emptyDir中的数据会被永久删除。emptyDir Volume主要用于某些应用程序无需永久保存的临时目录，多个容器的共享目录等。
- > **`hostPath`**
  * > hostPath Volume为pod挂载宿主机上的目录或文件，使得容器可以使用宿主机的高速文件系统进行存储。缺点是，在k8s中，pod都是动态在各node节点上调度。当一个pod在当前node节点上启动并通过hostPath存储了文件到本地以后，下次调度到另一个节点上启动时，就无法使用在之前节点上存储的文件。

## kubernetes StorageClass
- 改变默认 StorageClass https://v1-18.docs.kubernetes.io/zh/docs/tasks/administer-cluster/change-default-storage-class/ || Change the default StorageClass https://v1-18.docs.kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/
- Storage Classes https://v1-18.docs.kubernetes.io/zh/docs/concepts/storage/storage-classes/

StorageClass https://www.huweihuang.com/kubernetes-notes/storage/storage-class.html

Kubernetes-基于StorageClass的动态存储供应 https://www.kubernetes.org.cn/4078.html

## kubernetes Persistent Volume and Persistent Volume Claim

pod has unbound PersistentVolumeClaims https://stackoverflow.com/questions/52668938/pod-has-unbound-persistentvolumeclaims
- > When using storageClass Kubernetes is going to enable "Dynamic Volume Provisioning" which is not working with the local file system.

### RWX型PV

How To Set Up ReadWriteMany (RWX) Persistent Volumes with NFS on DigitalOcean Kubernetes https://www.digitalocean.com/community/tutorials/how-to-set-up-readwritemany-rwx-persistent-volumes-with-nfs-on-digitalocean-kubernetes

## kubernetes PodDisruptionBudget (PDB)

【from官方】：
- 干扰 https://v1-18.docs.kubernetes.io/zh/docs/concepts/workloads/pods/disruptions/ || Disruptions https://v1-18.docs.kubernetes.io/docs/concepts/workloads/pods/disruptions/
- 指定应用程序的中断预算（Disruption Budget） https://v1-18.docs.kubernetes.io/zh/docs/tasks/run-application/configure-pdb/

Kubernetes in production — PodDisruptionBudget https://itnext.io/kubernetes-in-production-poddisruptionbudget-1380009aaede

Avoiding Outages in your Kubernetes Cluster using PodDisruptionBudgets https://blog.gruntwork.io/avoiding-outages-in-your-kubernetes-cluster-using-poddisruptionbudgets-ef6a4baa5085

kubernetes1.7 新特性:PodDisruptionBudget控制器变化 https://www.kubernetes.org.cn/2486.html

kubernetes之PDB https://www.cnblogs.com/tylerzhou/p/10987576.html

## kubernetes HorizontalPodAutoscaler (HPA)

Pod 水平自动扩缩 https://v1-24.docs.kubernetes.io/zh/docs/tasks/run-application/horizontal-pod-autoscale/

如何根据不同业务场景调节 HPA 扩缩容灵敏度 https://www.cnblogs.com/tencent-cloud-native/p/14245238.html
- > 这样的设计逻辑导致用户无法自定义 HPA 的扩缩容灵敏度，而不同的业务场景对于扩容容灵敏度要求可能是不一样的，比如：
  * > 对于有流量突发的关键业务，在需要的时候应该快速扩容 (即便可能不需要，以防万一)，但缩容要慢 (防止另一个流量高峰)。
  * > 对于一些需要处理大量数据的离线业务，在需要的时候应该尽快扩容以减少处理时间，不需要那么多资源的时候应该尽快缩容以节约成本。
  * > 处理常规数据/网络流量的业务，它们可能会以一般的方式扩大和缩小规模，以减少抖动。

## kubernetes Container Lifecycle Hooks

- Container Lifecycle Hooks https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/
- Attach Handlers to Container Lifecycle Events https://kubernetes.io/docs/tasks/configure-pod-container/attach-handler-lifecycle-event/

容器生命周期的钩子 https://k8smeetup.github.io/docs/concepts/containers/container-lifecycle-hooks/

Kubernetes容器上下文环境 https://www.cnblogs.com/zhenyuyaodidiao/p/6558444.html

## kubernetes Liveness and Readiness Probes

- Configure Liveness and Readiness Probes https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/

配置Liveness和Readiness探针 https://k8smeetup.github.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/

Playing with Kubernetes livenessProbe and readinessProbe probes https://blogs.msdn.microsoft.com/jannemattila/2018/06/07/playing-with-kubernetes-livenessprobe-and-readinessprobe-probes/

Creating Kubernetes liveness and readiness probes https://opensource.com/article/18/3/kubernetes-liveness-readiness-probes
> How to run PostgreSQL on Kubernetes https://opensource.com/article/19/3/how-run-postgresql-kubernetes

Utilizing Kubernetes Liveness and Readiness Probes to Automatically Recover From Failure https://medium.com/spire-labs/utilizing-kubernetes-liveness-and-readiness-probes-to-automatically-recover-from-failure-2fe0314f2b2e

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# kubernetes内部对象II（实际上叫内部对象不太妥当了，比如没有内部对象叫patch）

## kubernetes patch
**// tech essay里专门有个文件有实战总结**

Update API Objects in Place Using kubectl patch https://kubernetes.io/docs/tasks/run-application/update-api-object-kubectl-patch/

使用 kubectl patch 更新 API 对象 https://k8smeetup.github.io/docs/tasks/run-application/update-api-object-kubectl-patch/

## kubernets config

### context

配置对多集群的访问 https://kubernetes.io/zh/docs/tasks/access-application-cluster/configure-access-multiple-clusters/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
