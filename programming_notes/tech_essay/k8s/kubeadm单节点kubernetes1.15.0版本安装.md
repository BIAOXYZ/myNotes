
# 0. 参考链接

## 0.1 主参考链接：

- Installing kubeadm https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/ 【1】
- Creating a single control-plane cluster with kubeadm https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/ 【2】 || 使用 kubeadm 创建一个单主集群 https://kubernetes.io/zh/docs/setup/independent/create-cluster-kubeadm/ 【【2】的中文版】
- 使用kubeadm安装Kubernetes 1.14 【by青蛙小白】 https://blog.frognew.com/2019/04/kubeadm-install-kubernetes-1.14.html 【3】

## 0.2 次要参考链接：

- 10分钟搭建Kubernetes容器集群平台（kubeadm） https://blog.51cto.com/lizhenliang/2296100 【4】
- kubeadm 搭建K8s高可用集群 https://www.jianshu.com/p/8eb81d1674dc 【5】
- 如何在Linux中永久禁用交换 https://www.howtoing.com/disable-swap-partition-in-centos-ubuntu 【6】
> 为了在Linux中永久禁用交换空间，打开 `/etc/fstab` 文件，搜索交换行并在行的前面添加一个 `#`（hashtag） 标记来注释整行，如下图所示

## 0.3 未涉及参考链接：

**//这个是用手动方式部署一个单节点，之前手动装过三节点的。所以纯是留着回头有空看看吧**。

手动部署一个单节点kubernetes https://www.cnblogs.com/breezey/p/9456938.html

# 1. 安装kubeadm（以及kubelet和kubectl）

**//安装过程仍旧是老规矩，尽量以官方为主，官方不够详细/有坑/犹豫不决之处等参考第三方链接**。

> https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/ 【1】
```
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF

# Set SELinux in permissive mode (effectively disabling it)
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

systemctl enable --now kubelet
```

> 实际过程：
```
root@cloudsec1 ~ $ cat <<EOF > /etc/yum.repos.d/kubernetes.repo
> [kubernetes]
> name=Kubernetes
> baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
> enabled=1
> gpgcheck=1
> repo_gpgcheck=1
> gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
> exclude=kube*
> EOF


root@cloudsec1 ~ $ setenforce 0
root@cloudsec1 ~ $ sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config


root@cloudsec1 ~ $ yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
...
...
...
Installed:
  kubeadm.x86_64 0:1.15.0-0                 kubectl.x86_64 0:1.15.0-0                 kubelet.x86_64 0:1.15.0-0

Dependency Installed:
  conntrack-tools.x86_64 0:1.4.4-4.el7                           cri-tools.x86_64 0:1.12.0-0
  kubernetes-cni.x86_64 0:0.7.5-0                                libnetfilter_cthelper.x86_64 0:1.0.0-9.el7
  libnetfilter_cttimeout.x86_64 0:1.0.0-6.el7                    libnetfilter_queue.x86_64 0:1.0.2-2.el7_2
  socat.x86_64 0:1.7.3.2-2.el7

Complete!


root@cloudsec1 ~ $ systemctl enable --now kubelet
Created symlink from /etc/systemd/system/multi-user.target.wants/kubelet.service to /usr/lib/systemd/system/kubelet.service.
```

# 2. 初始化集群并配置好网络和taint

> 按照参考官方链接【2】([Creating a single control-plane cluster with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/))的话现在就是选好`kubeadm init`的参数，然后初始化集群。但是【2】里几乎没有给出什么有用的参数建议，所以综合参考了【3】和【4】后决定使用后面过程中那个语句。此外，开始时没有关闭swap，导致报错。

## 2.1 初次init失败（主要是因为没有关闭swap，跟init没带参数无关），并作出相应的修改

> （接上）实际过程：
```
root@cloudsec1 ~ $ systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/usr/lib/systemd/system/kubelet.service; enabled; vendor preset: disabled)
  Drop-In: /usr/lib/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: activating (auto-restart) (Result: exit-code) since Tue 2019-07-02 03:33:49 CDT; 948ms ago
     Docs: https://kubernetes.io/docs/
  Process: 21219 ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS (code=exited, status=255)
 Main PID: 21219 (code=exited, status=255)

Jul 02 03:33:49 cloudsec1.sl.cloud9.ibm.com systemd[1]: Unit kubelet.service entered failed state.
Jul 02 03:33:49 cloudsec1.sl.cloud9.ibm.com systemd[1]: kubelet.service failed.

root@cloudsec1 ~ $ kubeadm init
[init] Using Kubernetes version: v1.15.0
[preflight] Running pre-flight checks
        [WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
error execution phase preflight: [preflight] Some fatal errors occurred:
        [ERROR Swap]: running with swap on is not supported. Please disable swap
[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`


// 临时关闭swap
root@cloudsec1 ~ $ swapoff -a
// 确认关闭swap成功
root@cloudsec1 ~ $ free -m
              total        used        free      shared  buff/cache   available
Mem:          15879         289        3557         172       12033       15021
Swap:             0           0           0
// 永久关闭swap：编辑/etc/fstab，把里面带swap的行注释掉。参考【6】
root@cloudsec1 ~ $ vi /etc/fstab


// 关闭防火墙，官方没提，可能现在不需要关闭了（不确定，所以以防万一还是执行了下）。
root@cloudsec1 ~ $ systemctl stop firewalld
root@cloudsec1 ~ $ systemctl disable firewalld


// 修改各个节点上docker的cgroup driver为systemd（尽管只是warning，还是改一下吧）。参考【3】
root@cloudsec1 ~ $ ll /etc/docker/
total 4
-rw-------. 1 root root 244 Feb 25 21:22 key.json
root@cloudsec1 ~ $ vi /etc/docker/daemon.json
root@cloudsec1 ~ $ ll /etc/docker/
total 8
-rw-r--r--. 1 root root  51 Jul  2 03:52 daemon.json
-rw-------. 1 root root 244 Feb 25 21:22 key.json
root@cloudsec1 ~ $ cat /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
root@cloudsec1 ~ $ systemctl restart docker
```

## 2.2 再次init成功，注意参数（`9.186.102.53`为该虚拟机对外ip，`10.244.0.0/16`是因为要用flannel，所以用这个网段）

```
root@cloudsec1 ~ $ kubeadm init --kubernetes-version=1.15.0 --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=9.186.102.53
[init] Using Kubernetes version: v1.15.0
[preflight] Running pre-flight checks
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Activating the kubelet service
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [cloudsec1.sl.cloud9.ibm.com kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 9.186.102.53]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [cloudsec1.sl.cloud9.ibm.com localhost] and IPs [9.186.102.53 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [cloudsec1.sl.cloud9.ibm.com localhost] and IPs [9.186.102.53 127.0.0.1 ::1]
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[apiclient] All control plane components are healthy after 21.511811 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config-1.15" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Skipping phase. Please see --upload-certs
[mark-control-plane] Marking the node cloudsec1.sl.cloud9.ibm.com as control-plane by adding the label "node-role.kubernetes.io/master=''"
[mark-control-plane] Marking the node cloudsec1.sl.cloud9.ibm.com as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
[bootstrap-token] Using token: ngjkr7.0r66ovnrvujsnrzy
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 9.186.102.53:6443 --token ngjkr7.0r66ovnrvujsnrzy \
    --discovery-token-ca-cert-hash sha256:6f5709dfc7e4d1842284a58bbd77b99c09673d8f3f0a7052ed9a18ffd2d0d8fc

```

## 2.3 用官方的那三个语句，使得用户可以使用kubectl

```
root@cloudsec1 ~ $ kubectl version
Client Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.0", GitCommit:"e8462b5b5dc2584fdcd18e6bcfe9f1e4d970a529", GitTreeState:"clean", BuildDate:"2019-06-19T16:40:16Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}
The connection to the server localhost:8080 was refused - did you specify the right host or port?

// 官方原始语句，出自链接【2】。按官方说法是为了使普通用户也可以运行kubectl，但是我觉得不如说为了当前用户可以运行kubectl。
// 看看这三个语句执行前后的差别就明白了。
root@cloudsec1 ~ $ mkdir -p $HOME/.kube
root@cloudsec1 ~ $ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
root@cloudsec1 ~ $ sudo chown $(id -u):$(id -g) $HOME/.kube/config

root@cloudsec1 ~ $ kubectl version
Client Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.0", GitCommit:"e8462b5b5dc2584fdcd18e6bcfe9f1e4d970a529", GitTreeState:"clean", BuildDate:"2019-06-19T16:40:16Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.0", GitCommit:"e8462b5b5dc2584fdcd18e6bcfe9f1e4d970a529", GitTreeState:"clean", BuildDate:"2019-06-19T16:32:14Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}

// 这句出自链接【3】
root@cloudsec1 ~ $ kubectl get cs
NAME                 STATUS    MESSAGE             ERROR
controller-manager   Healthy   ok
scheduler            Healthy   ok
etcd-0               Healthy   {"health":"true"}

root@cloudsec1 ~ $ docker ps
CONTAINER ID        IMAGE                  COMMAND                  CREATED             STATUS              PORTS               NAMES
531f85f9d97c        d235b23c3570           "/usr/local/bin/kube…"   24 minutes ago      Up 24 minutes                           k8s_kube-proxy_kube-proxy-cmrvx_kube-system_a4380eea-0e25-4311-961c-593b53ac85b6_0
07623de67c1f        k8s.gcr.io/pause:3.1   "/pause"                 24 minutes ago      Up 24 minutes                           k8s_POD_kube-proxy-cmrvx_kube-system_a4380eea-0e25-4311-961c-593b53ac85b6_0
8a455d3bce02        201c7a840312           "kube-apiserver --ad…"   25 minutes ago      Up 25 minutes                           k8s_kube-apiserver_kube-apiserver-cloudsec1.sl.cloud9.ibm.com_kube-system_ed98ccaf02b8fd7f5d54ccf435a772f7_0
a0cb1052c525        2c4adeb21b4f           "etcd --advertise-cl…"   25 minutes ago      Up 25 minutes                           k8s_etcd_etcd-cloudsec1.sl.cloud9.ibm.com_kube-system_62c29e8753baf8b42d76b1d4934c068c_0
567ee7238e8d        2d3813851e87           "kube-scheduler --bi…"   25 minutes ago      Up 25 minutes                           k8s_kube-scheduler_kube-scheduler-cloudsec1.sl.cloud9.ibm.com_kube-system_31d9ee8b7fb12e797dc981a8686f6b2b_0
af351f4dbb2d        8328bb49b652           "kube-controller-man…"   25 minutes ago      Up 25 minutes                           k8s_kube-controller-manager_kube-controller-manager-cloudsec1.sl.cloud9.ibm.com_kube-system_5510ce1d5c20814655586b3b5526a39b_0
d83ef8bff5f5        k8s.gcr.io/pause:3.1   "/pause"                 25 minutes ago      Up 25 minutes                           k8s_POD_kube-apiserver-cloudsec1.sl.cloud9.ibm.com_kube-system_ed98ccaf02b8fd7f5d54ccf435a772f7_0
a73fcaa257ca        k8s.gcr.io/pause:3.1   "/pause"                 25 minutes ago      Up 25 minutes                           k8s_POD_etcd-cloudsec1.sl.cloud9.ibm.com_kube-system_62c29e8753baf8b42d76b1d4934c068c_0
b0653ba83c39        k8s.gcr.io/pause:3.1   "/pause"                 25 minutes ago      Up 25 minutes                           k8s_POD_kube-scheduler-cloudsec1.sl.cloud9.ibm.com_kube-system_31d9ee8b7fb12e797dc981a8686f6b2b_0
d3004457c8a6        k8s.gcr.io/pause:3.1   "/pause"                 25 minutes ago      Up 25 minutes                           k8s_POD_kube-controller-manager-cloudsec1.sl.cloud9.ibm.com_kube-system_5510ce1d5c20814655586b3b5526a39b_0
```

## 2.4 但此时master节点还是不行，应该是网络的原因。coredns也先不用管了，后面flannel一好自动就好了。

```
root@cloudsec1 .kube $ kubectl get node
NAME                          STATUS     ROLES    AGE   VERSION
cloudsec1.sl.cloud9.ibm.com   NotReady   master   23m   v1.15.0

root@cloudsec1 ~ $ kubectl get pod --all-namespaces
NAMESPACE     NAME                                                  READY   STATUS    RESTARTS   AGE
kube-system   coredns-5c98db65d4-8rk47                              0/1     Pending   0          28m
kube-system   coredns-5c98db65d4-zz2s9                              0/1     Pending   0          28m
kube-system   etcd-cloudsec1.sl.cloud9.ibm.com                      1/1     Running   0          27m
kube-system   kube-apiserver-cloudsec1.sl.cloud9.ibm.com            1/1     Running   0          27m
kube-system   kube-controller-manager-cloudsec1.sl.cloud9.ibm.com   1/1     Running   0          27m
kube-system   kube-proxy-cmrvx                                      1/1     Running   0          28m
kube-system   kube-scheduler-cloudsec1.sl.cloud9.ibm.com            1/1     Running   0          27m

root@cloudsec1 ~ $ cat > pod-multi-container.yaml << EOF
> apiVersion: v1
> kind: Pod
> metadata:
>   name: my-two-container-pod
>   namespace: default
>   labels:
>     environment: dev
> spec:
>   containers:
>     - name: server
>       image: nginx:1.13-alpine
>       ports:
>         - containerPort: 80
>           protocol: TCP
>     - name: side-car
>       image: alpine:latest
>       command: ["/usr/bin/tail", "-f", "/dev/null"]
>   restartPolicy: Never
> EOF

root@cloudsec1 ~ $ kubectl create -f pod-multi-container.yaml
pod/my-two-container-pod created
root@cloudsec1 ~ $ kubectl get pod
NAME                   READY   STATUS    RESTARTS   AGE
my-two-container-pod   0/2     Pending   0          12s
root@cloudsec1 ~ $ kubectl describe pod my-two-container-pod
...
...
...
Events:
  Type     Reason            Age                From               Message
  ----     ------            ----               ----               -------
  Warning  FailedScheduling  26s (x2 over 26s)  default-scheduler  0/1 nodes are available: 1 node(s) had taints that the pod didn't tolerate.
```

## 2.5 从这里可以看出来一旦安装好网络插件（如flannel），master节点状态就变`ready`了。但是应用的pod还是不行，是因为调度的问题。

```
// 安装flannel的语句出自官方，实际上我觉得结合【3】和【4】的语句可能更好（官方的看起来是某个特定版本的yml文件），但是官方既然给了，还是按官方。
root@cloudsec1 ~ $ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/62e44c867a2846fefb68bd5f178daf4da3095ccb/Documentation/kube-flannel.yml
podsecuritypolicy.extensions/psp.flannel.unprivileged created
clusterrole.rbac.authorization.k8s.io/flannel created
clusterrolebinding.rbac.authorization.k8s.io/flannel created
serviceaccount/flannel created
configmap/kube-flannel-cfg created
daemonset.extensions/kube-flannel-ds-amd64 created
daemonset.extensions/kube-flannel-ds-arm64 created
daemonset.extensions/kube-flannel-ds-arm created
daemonset.extensions/kube-flannel-ds-ppc64le created
daemonset.extensions/kube-flannel-ds-s390x created

// 注意，master好了。
root@cloudsec1 ~ $ kubectl get node
NAME                          STATUS   ROLES    AGE   VERSION
cloudsec1.sl.cloud9.ibm.com   Ready    master   60m   v1.15.0

// 新增了flannel的pod；同时coredns的pod的也好了。但是应用的pod仍然不行。
root@cloudsec1 ~ $ kubectl get pod --all-namespaces
NAMESPACE     NAME                                                  READY   STATUS    RESTARTS   AGE
default       my-two-container-pod                                  0/2     Pending   0          26m
kube-system   coredns-5c98db65d4-8rk47                              1/1     Running   0          57m
kube-system   coredns-5c98db65d4-zz2s9                              1/1     Running   0          57m
kube-system   etcd-cloudsec1.sl.cloud9.ibm.com                      1/1     Running   0          56m
kube-system   kube-apiserver-cloudsec1.sl.cloud9.ibm.com            1/1     Running   0          56m
kube-system   kube-controller-manager-cloudsec1.sl.cloud9.ibm.com   1/1     Running   0          56m
kube-system   kube-flannel-ds-amd64-bppf7                           1/1     Running   0          41s
kube-system   kube-proxy-cmrvx                                      1/1     Running   0          57m
kube-system   kube-scheduler-cloudsec1.sl.cloud9.ibm.com            1/1     Running   0          56m
```

## 2.6 对master节点使用taint，使得pod可以调度到master节点上。

```
root@cloudsec1 ~ $ kubectl get pod
NAME                   READY   STATUS    RESTARTS   AGE
my-two-container-pod   0/2     Pending   0          57m

// 出自官方文档【2】，但是主要是因为就这一个master节点，所以图省事用了--all参数。
root@cloudsec1 ~ $ kubectl taint nodes --all node-role.kubernetes.io/master-
node/cloudsec1.sl.cloud9.ibm.com untainted

``
//修改前
root@cloudsec1 ~ $ kubectl describe node | grep Taints
Taints:             node-role.kubernetes.io/master:NoSchedule
//修改后
root@cloudsec1 ~ $ kubectl describe node | grep Taints
Taints:             <none>
``

root@cloudsec1 ~ $ kubectl get pod
NAME                   READY   STATUS              RESTARTS   AGE
my-two-container-pod   0/2     ContainerCreating   0          57m
root@cloudsec1 ~ $ kubectl get pod
NAME                   READY   STATUS    RESTARTS   AGE
my-two-container-pod   2/2     Running   0          59m

root@cloudsec1 ~ $ kubectl get pod --all-namespaces
NAMESPACE     NAME                                                  READY   STATUS    RESTARTS   AGE
default       my-two-container-pod                                  2/2     Running   0          61m
kube-system   coredns-5c98db65d4-8rk47                              1/1     Running   0          91m
kube-system   coredns-5c98db65d4-zz2s9                              1/1     Running   0          91m
kube-system   etcd-cloudsec1.sl.cloud9.ibm.com                      1/1     Running   0          91m
kube-system   kube-apiserver-cloudsec1.sl.cloud9.ibm.com            1/1     Running   0          91m
kube-system   kube-controller-manager-cloudsec1.sl.cloud9.ibm.com   1/1     Running   0          91m
kube-system   kube-flannel-ds-amd64-bppf7                           1/1     Running   0          35m
kube-system   kube-proxy-cmrvx                                      1/1     Running   0          91m
kube-system   kube-scheduler-cloudsec1.sl.cloud9.ibm.com            1/1     Running   0          91m
```

# ~~3. beyond单节点~~

## ~~3.1 加入其他node节点~~

# ~~4. master节点高可用~~
