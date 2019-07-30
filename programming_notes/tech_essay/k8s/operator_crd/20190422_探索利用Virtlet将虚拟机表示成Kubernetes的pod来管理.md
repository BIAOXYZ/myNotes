
# introduction

主要是利用Virtlet来试着将虚机表达成pod，从而方便迁移，尤其是有些不容易containerization的application的迁移。

# links and materials

- Kubernetes CRI implementation for running VM workloads https://github.com/Mirantis/virtlet 【[Virtlet: run VMs as Kubernetes pods](https://www.mirantis.com/blog/virtlet-run-vms-as-kubernetes-pods/) —— The Mirantis Blog】
  * > "To try out Virtlet follow the instructions from [Setting up the environment](https://docs.virtlet.cloud/dev/setup/) and [try out examples](https://github.com/Mirantis/virtlet/blob/master/examples/README.md) documents."
  * > "You can watch sample usage session under this [link](https://asciinema.org/a/1a6xp5j4o22rnsx9wpvumd4kt)."
  * > "You can also give Virtlet a quick try using our demo script (requires Docker 1.12+):"

# other commands

## 环境起来前

> 这句是项目主页README里就有的，基本一键搭建demo的脚本。里面还涉及到了用 [kubeadm-dind-cluster](https://github.com/kubernetes-sigs/kubeadm-dind-cluster/)搭建一个[DIND (Docker in Docker)](https://github.com/jpetazzo/dind)的环境，那个dind的脚本两千多行，暂时先不管了。只看demo.sh脚本及其输出。
```
wget https://raw.githubusercontent.com/Mirantis/virtlet/master/deploy/demo.sh && chmod +x demo.sh && ./demo.sh
```

## 环境起来后

需要去到[virtlet的releases页面](https://github.com/Mirantis/virtlet/releases)，把virtletctl下下来。
```
wget https://github.com/Mirantis/virtlet/releases/download/v1.5.0/virtletctl && chmod +x virtletctl

//这两句是README里的，但是我这从没成功过
virtletctl install
kubectl plugin virt ssh cirros@cirros-vm -- -i examples/vmkey

//因此用的是这种方式连接虚拟机（密码gocubsgo）：
./virtletctl ssh cirros@cirros-vm

//连上VM所在的pod后，在里面可以访问其他pod（nginx服务是脚本里还是视频里已经用这句跑起来的--`kubectl run nginx --image=nginx --expose --port 80`）
curl http://nginx.default.svc.cluster.local

//在虚机外部，可以随便起个pod，ping虚机，可以ping通。说明其他pod也可以访问虚机。
kubectl run -it --rm busybox --image busybox /bin/sh
ping ${虚机的pod IP} -c 3

//停止vm pod
kubectl delete pods cirros-vm --grace-period=0 --force

//启动vm pod （从脚本输出里查到的，`export PS4='+{$LINENO:${FUNCNAME[0]}} '`）
/root/.kubeadm-dind-cluster/kubectl create -f https://raw.githubusercontent.com/Mirantis/virtlet/v1.5.0//examples/cirros-vm.yaml

++ /root/.kubeadm-dind-cluster/kubectl get pods -n kube-system -l runtime=virtlet -o name
++ sed 's@.*/@@'
++ head -1
+ virtlet_pod=virtlet-qq2fk
+ /root/.kubeadm-dind-cluster/kubectl exec -n kube-system virtlet-qq2fk -c virtlet -- virsh list --name

//类推，启动一个Ubuntu的VM pod
kubectl create -f https://raw.githubusercontent.com/Mirantis/virtlet/v1.5.0//examples/ubuntu-vm.yaml
```

# stdout on screen

```
$ wget https://raw.githubusercontent.com/Mirantis/virtlet/master/deploy/demo.sh
--2019-04-20 16:48:23--  https://raw.githubusercontent.com/Mirantis/virtlet/master/deploy/demo.sh
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 151.101.120.133
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|151.101.120.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 15087 (15K) [text/plain]
Saving to: ‘demo.sh’

demo.sh                  100%[==================================>]  14.73K  --.-KB/s    in 0s

2019-04-20 16:48:23 (30.3 MB/s) - ‘demo.sh’ saved [15087/15087]

$ chmod +x demo.sh ; ./demo.sh
WARNING: No swap limit support
WARNING: No swap limit support
WARNING: No swap limit support
* Will download dind-cluster-v1.13.sh into current directory
Press Enter to continue or Ctrl-C to stop.

--2019-04-20 16:48:35--  https://raw.githubusercontent.com/kubernetes-sigs/kubeadm-dind-cluster/master/fixed/dind-cluster-v1.13.sh
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 151.101.120.133
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|151.101.120.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 80193 (78K) [text/plain]
Saving to: ‘dind-cluster-v1.13.sh’

dind-cluster-v1.13.sh    100%[==================================>]  78.31K  --.-KB/s    in 0.005s

2019-04-20 16:48:36 (15.4 MB/s) - ‘dind-cluster-v1.13.sh’ saved [80193/80193]

* Will now clear any kubeadm-dind-cluster data on the current Docker
Cirros ssh connection will be open after Virtlet setup is complete, press Ctrl-D to disconnect.
To clean up the cluster, use './dind-cluster-v1.13.sh clean'
Press Enter to continue or Ctrl-C to stop.

WARNING: No swap limit support
WARNING: No swap limit support
WARNING: No swap limit support
WARNING: No swap limit support
Unable to find image 'mirantis/kubeadm-dind-cluster:596f7d093470c1dc3a3e4466bcdfb34438a99b90-v1.13@sha256:0fcb655948a1fa20f5a2100983755edc8f0d763248bda217b3454d82d5cd3be4' locally
sha256:0fcb655948a1fa20f5a2100983755edc8f0d763248bda217b3454d82d5cd3be4: Pulling from mirantis/kubeadm-dind-cluster
d2519f41f710: Pulling fs layer
62bc77b5a5bc: Pulling fs layer
89361b6165e2: Pulling fs layer
63fac53415a9: Pulling fs layer
930aa6818f06: Pulling fs layer
bd4bee337c9c: Pulling fs layer
5c49605ff573: Pulling fs layer
0e26591e6f37: Pulling fs layer
cd34b4ad9820: Pulling fs layer
713c4fd4a18c: Pulling fs layer
ecf1b01d2e76: Pulling fs layer
9f01d4f32321: Pulling fs layer
d766b8e7abcf: Pulling fs layer
666d57260e9c: Pulling fs layer
ad4ef8b461d7: Pulling fs layer
7edb5a935ce0: Pulling fs layer
919e68ed781c: Pulling fs layer
83c7a2d995dc: Pulling fs layer
44506f621f1a: Pulling fs layer
fb1598ae72e5: Pulling fs layer
a096241fe1bf: Pulling fs layer
21a3b05a94d6: Pulling fs layer
ccef30e9fc36: Pulling fs layer
3cdb2a50b191: Pulling fs layer
3a9ba5b20a8a: Pulling fs layer
0ccf60639047: Pulling fs layer
63fac53415a9: Waiting
930aa6818f06: Waiting
bd4bee337c9c: Waiting
5c49605ff573: Waiting
0e26591e6f37: Waiting
cd34b4ad9820: Waiting
713c4fd4a18c: Waiting
ecf1b01d2e76: Waiting
9f01d4f32321: Waiting
d766b8e7abcf: Waiting
666d57260e9c: Waiting
ad4ef8b461d7: Waiting
7edb5a935ce0: Waiting
919e68ed781c: Waiting
83c7a2d995dc: Waiting
44506f621f1a: Waiting
3cdb2a50b191: Waiting
3a9ba5b20a8a: Waiting
0ccf60639047: Waiting
fb1598ae72e5: Waiting
a096241fe1bf: Waiting
21a3b05a94d6: Waiting
ccef30e9fc36: Waiting
89361b6165e2: Verifying Checksum
89361b6165e2: Download complete
d2519f41f710: Verifying Checksum
d2519f41f710: Download complete
d2519f41f710: Pull complete
930aa6818f06: Verifying Checksum
930aa6818f06: Download complete
63fac53415a9: Verifying Checksum
63fac53415a9: Download complete
62bc77b5a5bc: Download complete
bd4bee337c9c: Verifying Checksum
bd4bee337c9c: Download complete
5c49605ff573: Verifying Checksum
5c49605ff573: Download complete
0e26591e6f37: Verifying Checksum
0e26591e6f37: Download complete
cd34b4ad9820: Verifying Checksum
cd34b4ad9820: Download complete
713c4fd4a18c: Verifying Checksum
713c4fd4a18c: Download complete
ecf1b01d2e76: Verifying Checksum
ecf1b01d2e76: Download complete
9f01d4f32321: Verifying Checksum
9f01d4f32321: Download complete
666d57260e9c: Verifying Checksum
666d57260e9c: Download complete
d766b8e7abcf: Verifying Checksum
d766b8e7abcf: Download complete
ad4ef8b461d7: Verifying Checksum
ad4ef8b461d7: Download complete
7edb5a935ce0: Verifying Checksum
7edb5a935ce0: Download complete
919e68ed781c: Verifying Checksum
919e68ed781c: Download complete
83c7a2d995dc: Verifying Checksum
83c7a2d995dc: Download complete
fb1598ae72e5: Verifying Checksum
fb1598ae72e5: Download complete
44506f621f1a: Verifying Checksum
44506f621f1a: Download complete
a096241fe1bf: Verifying Checksum
a096241fe1bf: Download complete
21a3b05a94d6: Verifying Checksum
21a3b05a94d6: Download complete
ccef30e9fc36: Verifying Checksum
ccef30e9fc36: Download complete
3cdb2a50b191: Verifying Checksum
3cdb2a50b191: Download complete
3a9ba5b20a8a: Verifying Checksum
3a9ba5b20a8a: Download complete
0ccf60639047: Verifying Checksum
0ccf60639047: Download complete
62bc77b5a5bc: Pull complete
89361b6165e2: Pull complete
63fac53415a9: Pull complete
930aa6818f06: Pull complete
bd4bee337c9c: Pull complete
5c49605ff573: Pull complete
0e26591e6f37: Pull complete
cd34b4ad9820: Pull complete
713c4fd4a18c: Pull complete
ecf1b01d2e76: Pull complete
9f01d4f32321: Pull complete
d766b8e7abcf: Pull complete
666d57260e9c: Pull complete
ad4ef8b461d7: Pull complete
7edb5a935ce0: Pull complete
919e68ed781c: Pull complete
83c7a2d995dc: Pull complete
44506f621f1a: Pull complete
fb1598ae72e5: Pull complete
a096241fe1bf: Pull complete
21a3b05a94d6: Pull complete
ccef30e9fc36: Pull complete
3cdb2a50b191: Pull complete
3a9ba5b20a8a: Pull complete
0ccf60639047: Pull complete
Digest: sha256:0fcb655948a1fa20f5a2100983755edc8f0d763248bda217b3454d82d5cd3be4
Status: Downloaded newer image for mirantis/kubeadm-dind-cluster@sha256:0fcb655948a1fa20f5a2100983755edc8f0d763248bda217b3454d82d5cd3be4
/root/.kubeadm-dind-cluster/kubectl-v1.13.0: OK
WARNING: No swap limit support
WARNING: No swap limit support
WARNING: No swap limit support
WARNING: No swap limit support
* Making sure DIND image is up to date
sha256:0fcb655948a1fa20f5a2100983755edc8f0d763248bda217b3454d82d5cd3be4: Pulling from mirantis/kubeadm-dind-cluster
Digest: sha256:0fcb655948a1fa20f5a2100983755edc8f0d763248bda217b3454d82d5cd3be4
Status: Image is up to date for mirantis/kubeadm-dind-cluster@sha256:0fcb655948a1fa20f5a2100983755edc8f0d763248bda217b3454d82d5cd3be4
* Starting DIND container: kube-master
* Running kubeadm: init --config /etc/kubeadm.conf --ignore-preflight-errors=all
Initializing machine ID from random generator.
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /lib/systemd/system/docker.service.
Loaded image: mirantis/hypokube:base

real    0m9.560s
user    0m0.524s
sys     0m0.540s
Sending build context to Docker daemon  177.6MB
Step 1/2 : FROM mirantis/hypokube:base
 ---> 6c5c247039c6
Step 2/2 : COPY hyperkube /hyperkube
 ---> e0d2b0928e03
Successfully built e0d2b0928e03
Successfully tagged mirantis/hypokube:final
Created symlink /etc/systemd/system/multi-user.target.wants/kubelet.service → /lib/systemd/system/kubelet.service.
[init] Using Kubernetes version: v1.13.0
[preflight] Running pre-flight checks
        [WARNING FileContent--proc-sys-net-bridge-bridge-nf-call-iptables]: /proc/sys/net/bridge/bridge-nf-call-iptables does not exist
        [WARNING SystemVerification]: this Docker version is not on the list of validated versions:18.09.0. Latest validated version: 18.06
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Activating the kubelet service
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [kube-master localhost] and IPs [10.192.0.2 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [kube-master localhost] and IPs [10.192.0.2 127.0.0.1 ::1]
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [kube-master kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 10.192.0.2]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[controlplane] Adding extra host path mount "hyperkube" to "kube-apiserver"
[controlplane] Adding extra host path mount "hyperkube" to "kube-controller-manager"
[controlplane] Adding extra host path mount "hyperkube" to "kube-scheduler"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[controlplane] Adding extra host path mount "hyperkube" to "kube-apiserver"
[controlplane] Adding extra host path mount "hyperkube" to "kube-controller-manager"
[controlplane] Adding extra host path mount "hyperkube" to "kube-scheduler"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[controlplane] Adding extra host path mount "hyperkube" to "kube-apiserver"
[controlplane] Adding extra host path mount "hyperkube" to "kube-controller-manager"
[controlplane] Adding extra host path mount "hyperkube" to "kube-scheduler"
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[apiclient] All control plane components are healthy after 22.504577 seconds
[uploadconfig] storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config-1.13" in namespace kube-system with the configuration for the kubelets in the cluster
[patchnode] Uploading the CRI Socket information "/var/run/dockershim.sock" to the Node API object "kube-master" as an annotation
[mark-control-plane] Marking the node kube-master as control-plane by adding the label "node-role.kubernetes.io/master=''"
[mark-control-plane] Marking the node kube-master as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
[bootstrap-token] Using token: eaiboj.2dla48ewwml1a6wk
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstraptoken] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstraptoken] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstraptoken] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstraptoken] creating the "cluster-info" ConfigMap in the "kube-public" namespace
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes master has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of machines by running the following on each node
as root:

  kubeadm join 10.192.0.2:6443 --token eaiboj.2dla48ewwml1a6wk --discovery-token-ca-cert-hash sha256:f628a444ed096aa90e35388081bd33bfd206254efef2e556d33520c52290ead6


real    0m39.191s
user    0m5.532s
sys     0m0.252s
Warning: kubectl apply should be used on resource created by either kubectl create --save-config orkubectl apply
configmap/kube-proxy configured
Warning: kubectl apply should be used on resource created by either kubectl create --save-config orkubectl apply
daemonset.extensions/kube-proxy configured
No resources found
* Setting cluster config
Cluster "dind" set.
Context "dind" created.
Switched to context "dind".
* Starting node container: 1
* Starting DIND container: kube-node-1
* Node container started: 1
* Starting node container: 2
* Starting DIND container: kube-node-2
* Node container started: 2
* Joining node: 1
* Joining node: 2
* Running kubeadm: join --ignore-preflight-errors=all --cri-socket=/var/run/dockershim.sock 10.192.0.2:6443 --token eaiboj.2dla48ewwml1a6wk --discovery-token-ca-cert-hash sha256:f628a444ed096aa90e35388081bd33bfd206254efef2e556d33520c52290ead6
* Running kubeadm: join --ignore-preflight-errors=all --cri-socket=/var/run/dockershim.sock 10.192.0.2:6443 --token eaiboj.2dla48ewwml1a6wk --discovery-token-ca-cert-hash sha256:f628a444ed096aa90e35388081bd33bfd206254efef2e556d33520c52290ead6
Initializing machine ID from random generator.
Initializing machine ID from random generator.
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /lib/systemd/system/docker.service.
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /lib/systemd/system/docker.service.
Loaded image: mirantis/hypokube:base

real    0m16.615s
user    0m0.568s
sys     0m0.452s
Loaded image: mirantis/hypokube:base

real    0m16.687s
user    0m0.528s
sys     0m0.496s
Sending build context to Docker daemon  177.6MB
Step 1/2 : FROM mirantis/hypokube:base
 ---> 6c5c247039c6
Step 2/2 : COPY hyperkube /hyperkube
Sending build context to Docker daemon  177.6MB
Step 1/2 : FROM mirantis/hypokube:base
 ---> 6c5c247039c6
Step 2/2 : COPY hyperkube /hyperkube
 ---> 4fbadd85cfc5
Successfully built 4fbadd85cfc5
Successfully tagged mirantis/hypokube:final
 ---> 9072eacf5e6f
Successfully built 9072eacf5e6f
Successfully tagged mirantis/hypokube:final
Created symlink /etc/systemd/system/multi-user.target.wants/kubelet.service → /lib/systemd/system/kubelet.service.
Created symlink /etc/systemd/system/multi-user.target.wants/kubelet.service → /lib/systemd/system/kubelet.service.
[preflight] Running pre-flight checks
[preflight] Running pre-flight checks
        [WARNING FileContent--proc-sys-net-bridge-bridge-nf-call-iptables]: /proc/sys/net/bridge/bridge-nf-call-iptables does not exist
        [WARNING SystemVerification]: this Docker version is not on the list of validated versions:18.09.0. Latest validated version: 18.06
        [WARNING FileContent--proc-sys-net-bridge-bridge-nf-call-iptables]: /proc/sys/net/bridge/bridge-nf-call-iptables does not exist
        [WARNING SystemVerification]: this Docker version is not on the list of validated versions:18.09.0. Latest validated version: 18.06
[discovery] Trying to connect to API Server "10.192.0.2:6443"
[discovery] Created cluster-info discovery client, requesting info from "https://10.192.0.2:6443"
[discovery] Requesting info from "https://10.192.0.2:6443" again to validate TLS against the pinnedpublic key
[discovery] Cluster info signature and contents are valid and TLS certificate validates against pinned roots, will use API Server "10.192.0.2:6443"
[discovery] Successfully established connection with API Server "10.192.0.2:6443"
[join] Reading configuration from the cluster...
[join] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[discovery] Trying to connect to API Server "10.192.0.2:6443"
[discovery] Created cluster-info discovery client, requesting info from "https://10.192.0.2:6443"
[discovery] Requesting info from "https://10.192.0.2:6443" again to validate TLS against the pinnedpublic key
[discovery] Cluster info signature and contents are valid and TLS certificate validates against pinned roots, will use API Server "10.192.0.2:6443"
[discovery] Successfully established connection with API Server "10.192.0.2:6443"
[join] Reading configuration from the cluster...
[join] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[kubelet] Downloading configuration for the kubelet from the "kubelet-config-1.13" ConfigMap in thekube-system namespace
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet] Downloading configuration for the kubelet from the "kubelet-config-1.13" ConfigMap in thekube-system namespace
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Activating the kubelet service
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Activating the kubelet service
[tlsbootstrap] Waiting for the kubelet to perform the TLS Bootstrap...
[tlsbootstrap] Waiting for the kubelet to perform the TLS Bootstrap...
[patchnode] Uploading the CRI Socket information "/var/run/dockershim.sock" to the Node API object "kube-node-1" as an annotation

This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the master to see this node join the cluster.


real    0m2.418s
user    0m0.356s
sys     0m0.092s
* Node joined: 1
[patchnode] Uploading the CRI Socket information "/var/run/dockershim.sock" to the Node API object "kube-node-2" as an annotation

This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the master to see this node join the cluster.


real    0m3.065s
user    0m0.356s
sys     0m0.108s
* Node joined: 2
Creating static routes for bridge/PTP plugin
* Deploying k8s dashboard
deployment.extensions/kubernetes-dashboard created
service/kubernetes-dashboard created
clusterrolebinding.rbac.authorization.k8s.io/add-on-cluster-admin created
* Cluster Info
Network Mode: ipv4
Cluster context: dind
Cluster ID: 0
Management CIDR(s): 10.192.0.0/24
Service CIDR/mode: 10.96.0.0/12/ipv4
Pod CIDR(s): 10.244.0.0/16
* Taking snapshot of the cluster
deployment.extensions/coredns scaled
deployment.extensions/kubernetes-dashboard scaled
pod "kube-proxy-62dtn" deleted
pod "kube-proxy-7mkjv" deleted
pod "kube-proxy-d4k57" deleted
NAME               READY   STATUS    RESTARTS   AGE
kube-proxy-kdj5x   1/1     Running   0          4s
kube-proxy-x4qk6   1/1     Running   0          3s
kube-proxy-zthkc   1/1     Running   0          3s
tar: var/lib/kubelet/device-plugins/kubelet.sock: socket ignored
tar: var/lib/kubelet/device-plugins/kubelet.sock: socket ignored
tar: var/lib/kubelet/device-plugins/kubelet.sock: socket ignored
* Waiting for kube-proxy and the nodes
..........[done]
* Bringing up coredns and kubernetes-dashboard
deployment.extensions/coredns scaled
deployment.extensions/kubernetes-dashboard scaled
.......[done]
NAME          STATUS   ROLES    AGE    VERSION
kube-master   Ready    master   117s   v1.13.0
kube-node-1   Ready    <none>   83s    v1.13.0
kube-node-2   Ready    <none>   83s    v1.13.0
* Access dashboard at: http://127.0.0.1:32768/api/v1/namespaces/kube-system/services/kubernetes-dashboard:/proxy
* Marking mounts used by virtlet as shared in kube-node-1 container
* Bind-mounting /var/lib/virtlet from a docker volume
* Installing CRI proxy package on kube-node-1 container
Selecting previously unselected package criproxy-nodeps.
(Reading database ... 15726 files and directories currently installed.)
Preparing to unpack /criproxy.deb ...
Unpacking criproxy-nodeps (0.14.0) ...
Setting up criproxy-nodeps (0.14.0) ...
Warning: kubelet.service changed on disk. Run 'systemctl daemon-reload' to reload units.
Created symlink /etc/systemd/system/kubelet.service.wants/criproxy.service → /lib/systemd/system/criproxy.service.
* Applying label to kube-node-1: extraRuntime=virtlet
node/kube-node-1 labeled
Will run demo using Virtlet:v1.5.0 for demo and v1.5.0 as docker tag
* Checking for KVM support...
Unable to find image 'mirantis/virtlet:v1.5.0' locally
v1.5.0: Pulling from mirantis/virtlet
7b8b6451c85f: Pulling fs layer
ab4d1096d9ba: Pulling fs layer
e6797d1788ac: Pulling fs layer
e25c5c290bde: Pulling fs layer
53a32780b9b0: Pulling fs layer
f3d15fcde577: Pulling fs layer
60d52fce0727: Pulling fs layer
48f0c3c55062: Pulling fs layer
358b076a6df2: Pulling fs layer
1e399dfccc23: Pulling fs layer
628eaab9ad02: Pulling fs layer
6f9635461b3d: Pulling fs layer
e6f4fba16733: Pulling fs layer
e25c5c290bde: Waiting
53a32780b9b0: Waiting
f3d15fcde577: Waiting
60d52fce0727: Waiting
48f0c3c55062: Waiting
358b076a6df2: Waiting
1e399dfccc23: Waiting
628eaab9ad02: Waiting
6f9635461b3d: Waiting
e6f4fba16733: Waiting
e6797d1788ac: Verifying Checksum
e6797d1788ac: Download complete
ab4d1096d9ba: Verifying Checksum
ab4d1096d9ba: Download complete
e25c5c290bde: Verifying Checksum
e25c5c290bde: Download complete
7b8b6451c85f: Verifying Checksum
7b8b6451c85f: Download complete
53a32780b9b0: Verifying Checksum
53a32780b9b0: Download complete
60d52fce0727: Verifying Checksum
60d52fce0727: Download complete
48f0c3c55062: Verifying Checksum
48f0c3c55062: Download complete
358b076a6df2: Verifying Checksum
358b076a6df2: Download complete
1e399dfccc23: Verifying Checksum
1e399dfccc23: Download complete
628eaab9ad02: Verifying Checksum
628eaab9ad02: Download complete
6f9635461b3d: Verifying Checksum
6f9635461b3d: Download complete
e6f4fba16733: Verifying Checksum
e6f4fba16733: Download complete
f3d15fcde577: Verifying Checksum
f3d15fcde577: Download complete
7b8b6451c85f: Pull complete
ab4d1096d9ba: Pull complete
e6797d1788ac: Pull complete
e25c5c290bde: Pull complete
53a32780b9b0: Pull complete
f3d15fcde577: Pull complete
60d52fce0727: Pull complete
48f0c3c55062: Pull complete
358b076a6df2: Pull complete
1e399dfccc23: Pull complete
628eaab9ad02: Pull complete
6f9635461b3d: Pull complete
e6f4fba16733: Pull complete
Digest: sha256:91b76413e87e92916453a5fc6ddaed9a3ffcc8b67406d92c4e576f1d585b2ebf
Status: Downloaded newer image for mirantis/virtlet:v1.5.0
INFO: Your CPU does not support KVM extensions
KVM acceleration can NOT be used
* Setting up Virtlet configuration *without* KVM support
configmap/virtlet-config created
configmap/virtlet-image-translations created
* Deploying Virtlet DaemonSet with docker tag v1.5.0
Unable to find image 'mirantis/virtlet:v1.5.0' locally
v1.5.0: Pulling from mirantis/virtlet
7b8b6451c85f: Pulling fs layer
ab4d1096d9ba: Pulling fs layer
e6797d1788ac: Pulling fs layer
e25c5c290bde: Pulling fs layer
53a32780b9b0: Pulling fs layer
f3d15fcde577: Pulling fs layer
60d52fce0727: Pulling fs layer
48f0c3c55062: Pulling fs layer
358b076a6df2: Pulling fs layer
1e399dfccc23: Pulling fs layer
628eaab9ad02: Pulling fs layer
6f9635461b3d: Pulling fs layer
e25c5c290bde: Waiting
53a32780b9b0: Waiting
f3d15fcde577: Waiting
60d52fce0727: Waiting
48f0c3c55062: Waiting
358b076a6df2: Waiting
1e399dfccc23: Waiting
628eaab9ad02: Waiting
e6f4fba16733: Pulling fs layer
e6f4fba16733: Waiting
6f9635461b3d: Waiting
e6797d1788ac: Verifying Checksum
e6797d1788ac: Download complete
ab4d1096d9ba: Verifying Checksum
ab4d1096d9ba: Download complete
e25c5c290bde: Verifying Checksum
e25c5c290bde: Download complete
7b8b6451c85f: Verifying Checksum
7b8b6451c85f: Download complete
53a32780b9b0: Verifying Checksum
53a32780b9b0: Download complete
60d52fce0727: Verifying Checksum
60d52fce0727: Download complete
48f0c3c55062: Verifying Checksum
48f0c3c55062: Download complete
358b076a6df2: Verifying Checksum
358b076a6df2: Download complete
1e399dfccc23: Verifying Checksum
1e399dfccc23: Download complete
628eaab9ad02: Verifying Checksum
628eaab9ad02: Download complete
6f9635461b3d: Verifying Checksum
6f9635461b3d: Download complete
e6f4fba16733: Verifying Checksum
e6f4fba16733: Download complete
7b8b6451c85f: Pull complete
f3d15fcde577: Verifying Checksum
f3d15fcde577: Download complete
ab4d1096d9ba: Pull complete
e6797d1788ac: Pull complete
e25c5c290bde: Pull complete
53a32780b9b0: Pull complete
f3d15fcde577: Pull complete
60d52fce0727: Pull complete
48f0c3c55062: Pull complete
358b076a6df2: Pull complete
1e399dfccc23: Pull complete
628eaab9ad02: Pull complete
6f9635461b3d: Pull complete
e6f4fba16733: Pull complete
Digest: sha256:91b76413e87e92916453a5fc6ddaed9a3ffcc8b67406d92c4e576f1d585b2ebf
Status: Downloaded newer image for mirantis/virtlet:v1.5.0
daemonset.apps/virtlet created
clusterrolebinding.rbac.authorization.k8s.io/virtlet created
clusterrole.rbac.authorization.k8s.io/virtlet created
clusterrole.rbac.authorization.k8s.io/configmap-reader created
clusterrole.rbac.authorization.k8s.io/virtlet-userdata-reader created
clusterrolebinding.rbac.authorization.k8s.io/kubelet-node-binding created
clusterrolebinding.rbac.authorization.k8s.io/vm-userdata-binding created
clusterrole.rbac.authorization.k8s.io/virtlet-crd created
clusterrolebinding.rbac.authorization.k8s.io/virtlet-crd created
serviceaccount/virtlet created
customresourcedefinition.apiextensions.k8s.io/virtletimagemappings.virtlet.k8s created
customresourcedefinition.apiextensions.k8s.io/virtletconfigmappings.virtlet.k8s created
* Waiting for: Virtlet DaemonSet
..............................................[done]
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
service/nginx created
deployment.apps/nginx created
* Starting sample CirrOS VM
pod/cirros-vm created
* Waiting for: CirrOS VM
...........................[done]
* Establishing ssh connection to the VM. Use Ctrl-D to disconnect
* Will download demo-cirros-private-key into current directory
--2019-04-20 16:55:26--  https://raw.githubusercontent.com/Mirantis/virtlet/v1.5.0/examples/vmkey
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 151.101.120.133
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|151.101.120.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1679 (1.6K) [text/plain]
Saving to: ‘demo-cirros-private-key’

demo-cirros-private-key  100%[==================================>]   1.64K  --.-KB/s    in 0s

2019-04-20 16:55:26 (275 MB/s) - ‘demo-cirros-private-key’ saved [1679/1679]

Cirros IP is 10.244.2.6.
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
command terminated with exit code 1
Trying to establish ssh connection to cirros-vm...
cirros@cirros-vm's password:
Trying to establish ssh connection to cirros-vm...
Successfully established ssh connection. Press Ctrl-D to disconnect.
```

# the script demo.sh

```shell
#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

KUBE_VERSION="${KUBE_VERSION:-1.13}"
CRIPROXY_DEB_URL="${CRIPROXY_DEB_URL:-https://github.com/Mirantis/criproxy/releases/download/v0.14.0/criproxy-nodeps_0.14.0_amd64.deb}"
NONINTERACTIVE="${NONINTERACTIVE:-}"
NO_VM_CONSOLE="${NO_VM_CONSOLE:-}"
INJECT_LOCAL_IMAGE="${INJECT_LOCAL_IMAGE:-}"
dind_script="dind-cluster-v${KUBE_VERSION}.sh"
kubectl="${HOME}/.kubeadm-dind-cluster/kubectl"
BASE_LOCATION="${BASE_LOCATION:-https://raw.githubusercontent.com/Mirantis/virtlet/master/}"
RELEASE_LOCATION="${RELEASE_LOCATION:-https://github.com/Mirantis/virtlet/releases/download/}"
VIRTLET_DEMO_RELEASE="${VIRTLET_DEMO_RELEASE:-}"
VIRTLET_DEMO_BRANCH="${VIRTLET_DEMO_BRANCH:-}"
VIRTLET_ON_MASTER="${VIRTLET_ON_MASTER:-}"
VIRTLET_MULTI_NODE="${VIRTLET_MULTI_NODE:-}"
IMAGE_REGEXP_TRANSLATION="${IMAGE_REGEXP_TRANSLATION:-1}"
MULTI_CNI="${MULTI_CNI:-}"
DEMO_LOG_LEVEL="${DEMO_LOG_LEVEL:-}"
DIND_CRI="${DIND_CRI:-containerd}"
# Convenience setting for local testing:
# BASE_LOCATION="${HOME}/work/kubernetes/src/github.com/Mirantis/virtlet"
cirros_key="demo-cirros-private-key"
# just initialize it
declare virtlet_release
declare virtlet_docker_tag

virtlet_nodes=()
if [[ ${VIRTLET_ON_MASTER} ]]; then
  virtlet_nodes+=(kube-master)
fi
if [[ !${VIRTLET_ON_MASTER} || ${VIRTLET_MULTI_NODE} ]]; then
  virtlet_nodes+=(kube-node-1)
fi
if [[ ${VIRTLET_MULTI_NODE} ]]; then
  virtlet_nodes+=(kube-node-2)
fi

# In case of linuxkit / moby linux, -v will not work so we can't
# mount /lib/modules and /boot.
using_linuxkit=
if ! docker info|grep -s '^Operating System: .*Docker for Windows' > /dev/null 2>&1 ; then
    if docker info|grep -s '^Kernel Version: .*-moby$' >/dev/null 2>&1 ||
         docker info|grep -s '^Kernel Version: .*-linuxkit-' > /dev/null 2>&1 ; then
        using_linuxkit=1
    fi
fi

function demo::step {
  local OPTS=""
  if [ "$1" = "-n" ]; then
    shift
    OPTS+="-n"
  fi
  GREEN="$1"
  shift
  if [ -t 2 ] ; then
    echo -e ${OPTS} "\x1B[97m* \x1B[92m${GREEN}\x1B[39m $*" >&2
  else
    echo ${OPTS} "* ${GREEN} $*" >&2
  fi
}

function demo::ask-before-continuing {
  if [[ ! ${NONINTERACTIVE} ]]; then
    echo "Press Enter to continue or Ctrl-C to stop." >&2
    read
  fi
}

function demo::ask-user {
  if [[ ${1:-} = "" ]]; then
    echo "no prompt message provided" >&2
    exit 1
  fi

  if [[ ${2:-} = "" ]]; then
    echo "no return var name provided" >&2
    exit 1
  fi

  local  __resultvar=$2
  local reply="false"
  while true; do
    read -p "$(tput bold)$(tput setaf 3) ${1} (yY/nN): $(tput sgr0)" reply
    case $reply in
      Y|y) reply="true"; break;;
      N|n) echo "Abort"; reply="false"; break;;
      *) echo "Please answer y[Y] or n[N].";;
    esac
  done
  eval $__resultvar="'$reply'"
}

function demo::get-dind-cluster {
  download="true"
  if [[ -f ${dind_script} ]]; then
    demo::step "Will update ${dind_script} script to the latest version"
    if [[ ! ${NONINTERACTIVE} ]]; then
        demo::ask-user "Do you want to redownload ${dind_script} ?" download
        if [[ ${download} = "true" ]]; then
          rm "${dind_script}"
        fi
    else
       demo::step "Will now clear existing ${dind_script}"
       rm "${dind_script}"
    fi
  fi

  if [[ ${download} = "true" ]]; then
    demo::step "Will download ${dind_script} into current directory"
    demo::ask-before-continuing
    wget "https://raw.githubusercontent.com/kubernetes-sigs/kubeadm-dind-cluster/master/fixed/${dind_script}"
    chmod +x "${dind_script}"
  fi
}

function demo::get-cirros-ssh-keys {
  if [[ -f ${cirros_key} ]]; then
    return 0
  fi
  demo::step "Will download ${cirros_key} into current directory"
  wget -O ${cirros_key} "https://raw.githubusercontent.com/Mirantis/virtlet/${virtlet_release}/examples/vmkey"
  chmod 600 ${cirros_key}
}

function demo::start-dind-cluster {
  demo::step "Will now clear any kubeadm-dind-cluster data on the current Docker"
  if [[ ! ${NONINTERACTIVE} ]]; then
    echo "Cirros ssh connection will be open after Virtlet setup is complete, press Ctrl-D to disconnect." >&2
  fi
  echo "To clean up the cluster, use './dind-cluster-v${KUBE_VERSION}.sh clean'" >&2
  demo::ask-before-continuing
  "./${dind_script}" clean
  "./${dind_script}" up
}

function demo::jq-patch {
  local node="${1}"
  local expr="${2}"
  local filename="${3}"
  docker exec "${node}" \
         bash -c "jq '${expr}' '${filename}' >/tmp/jqpatch.tmp && mv /tmp/jqpatch.tmp '${filename}'"
}

function demo::install-cni-genie {
  "${kubectl}" apply -f https://docs.projectcalico.org/v2.6/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml
  demo::wait-for "Calico etcd" demo::pods-ready k8s-app=calico-etcd
  demo::wait-for "Calico node" demo::pods-ready k8s-app=calico-node
  "${kubectl}" apply -f https://raw.githubusercontent.com/Huawei-PaaS/CNI-Genie/master/conf/1.8/genie-plugin.yaml

  demo::wait-for "CNI Genie" demo::pods-ready k8s-app=genie
  demo::jq-patch kube-node-1 '.cniVersion="0.3.0"|.default_plugin="calico,flannel"' /etc/cni/net.d/00-genie.conf
  demo::jq-patch kube-node-1 '.cniVersion="0.3.0"' /etc/cni/net.d/10-calico.conf
  demo::jq-patch kube-node-1 '.cniVersion="0.3.0"' /etc/cni/net.d/10-flannel.conflist
}

function demo::install-cri-proxy {
  local virtlet_node="${1}"
  demo::step "Installing CRI proxy package on ${virtlet_node} container"
  if [[ ${DIND_CRI} = containerd ]]; then
    docker exec "${virtlet_node}" /bin/bash -c 'echo criproxy-nodeps criproxy/primary_cri select containerd | debconf-set-selections'
  fi
  docker exec "${virtlet_node}" /bin/bash -c "curl -sSL '${CRIPROXY_DEB_URL}' >/criproxy.deb && DEBIAN_FRONTEND=noninteractive dpkg -i /criproxy.deb && rm /criproxy.deb"
}

function demo::fix-mounts {
  local virtlet_node="${1}"
  demo::step "Marking mounts used by virtlet as shared in ${virtlet_node} container"
  docker exec "${virtlet_node}" mount --make-shared /dind
  docker exec "${virtlet_node}" mount --make-shared /dev
  if [[ ! ${using_linuxkit} ]]; then
    docker exec "${virtlet_node}" mount --make-shared /boot
  fi
  docker exec "${virtlet_node}" mount --make-shared /sys/fs/cgroup
  demo::step "Bind-mounting /var/lib/virtlet from a docker volume"
  docker exec "${virtlet_node}" mkdir -p /dind/virtlet /var/lib/virtlet
  docker exec "${virtlet_node}" mount --bind /dind/virtlet /var/lib/virtlet
}

function demo::inject-local-image {
  local virtlet_node="${1}"
  demo::step "Copying local mirantis/virtlet image into ${virtlet_node} container"
  docker save mirantis/virtlet |
    if [[ ${DIND_CRI} = containerd ]]; then
      docker exec -i "${virtlet_node}" ctr -n k8s.io images import -
    else
      docker exec -i "${virtlet_node}" docker load
    fi
}

function demo::label-and-untaint-node {
  local virtlet_node="${1}"
  demo::step "Applying label to ${virtlet_node}:" "extraRuntime=virtlet"
  "${kubectl}" label node "${virtlet_node}" extraRuntime=virtlet
  if [[ ${VIRTLET_ON_MASTER} ]]; then
      demo::step "Checking/removing master taint from ${virtlet_node}"
    if [[ $("${kubectl}" get node kube-master -o jsonpath='{.spec.taints[?(@.key=="node-role.kubernetes.io/master")]}') ]]; then
      "${kubectl}" taint nodes kube-master node-role.kubernetes.io/master-
    fi
  fi
}

function demo::pods-ready {
  local label="$1"
  local out
  if ! out="$("${kubectl}" get pod -l "${label}" -n kube-system \
                           -o jsonpath='{ .items[*].status.conditions[?(@.type == "Ready")].status }' 2>/dev/null)"; then
    return 1
  fi
  if ! grep -v False <<<"${out}" | grep -q True; then
    return 1
  fi
  return 0
}

function demo::service-ready {
  local name="$1"
  if ! "${kubectl}" describe service -n kube-system "${name}"|grep -q '^Endpoints:.*[0-9]\.'; then
    return 1
  fi
}

function demo::wait-for {
  local title="$1"
  local action="$2"
  local what="$3"
  shift 3
  demo::step "Waiting for:" "${title}"
  while ! "${action}" "${what}" "$@"; do
    echo -n "." >&2
    sleep 1
  done
  echo "[done]" >&2
}

virtlet_pod=
function demo::virsh {
  local opts=
  if [[ ${1:-} = "console" ]]; then
    # using -it with `virsh list` causes it to use \r\n as line endings,
    # which makes it less useful
    local opts="-it"
  fi
  if [[ ! ${virtlet_pod} ]]; then
    virtlet_pod=$("${kubectl}" get pods -n kube-system -l runtime=virtlet -o name|head -1|sed 's@.*/@@')
  fi
  "${kubectl}" exec ${opts} -n kube-system "${virtlet_pod}" -c virtlet -- virsh "$@"
}

function demo::ssh {
  local cirros_ip=

  demo::get-cirros-ssh-keys

  if [[ ! ${virtlet_pod} ]]; then
    virtlet_pod=$("${kubectl}" get pods -n kube-system -l runtime=virtlet -o name|head -1|sed 's@.*/@@')
  fi

  if [[ ! ${cirros_ip} ]]; then
    while true; do
      cirros_ip=$("${kubectl}" get pod cirros-vm -o jsonpath="{.status.podIP}")
      if [[ ! ${cirros_ip} ]]; then
        echo "Waiting for cirros IP..."
        sleep 1
        continue
      fi
      echo "Cirros IP is ${cirros_ip}."
      break
    done
  fi

  echo "Trying to establish ssh connection to cirros-vm..."
  while ! internal::ssh ${virtlet_pod} ${cirros_ip} "echo Hello" | grep -q "Hello"; do
    sleep 1
    echo "Trying to establish ssh connection to cirros-vm..."
  done

  echo "Successfully established ssh connection. Press Ctrl-D to disconnect."
  internal::ssh ${virtlet_pod} ${cirros_ip}
}

function internal::ssh {
  virtlet_pod=${1}
  cirros_ip=${2}
  shift 2

  ssh -oProxyCommand="${kubectl} exec -i -n kube-system ${virtlet_pod} -c virtlet -- nc -q0 ${cirros_ip} 22" \
    -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -q \
    -i ${cirros_key} cirros@cirros-vm "$@"
}

function demo::vm-ready {
  local name="$1"
  # note that the following is not a bulletproof check
  if ! demo::virsh list --name | grep -q "${name}\$"; then
    return 1
  fi
}

function demo::kvm-ok {
  demo::step "Checking for KVM support..."
  # The check is done inside the node container because it has proper /lib/modules
  # from the docker host. Also, it'll have to use mirantis/virtlet image
  # later anyway.
  if [[ ${using_linuxkit} ]]; then
    return 1
  fi
  # use kube-master node as all of the DIND nodes in the cluster are similar
  if ! docker exec kube-master docker run --privileged --rm -v /lib/modules:/lib/modules "mirantis/virtlet:${virtlet_docker_tag}" kvm-ok; then
    return 1
  fi
}

function demo::get-correct-virtlet-release {
  # will use most recently published virtlet release
  # (virtlet releases are pre-releases now so not returned in /latest)
  local  __resultvar=$1
  local jq_filter=".[0].tag_name"
  local last_release
  last_release=$(curl --silent https://api.github.com/repos/Mirantis/virtlet/releases | docker exec-i kube-master jq "${jq_filter}" | sed 's/^\"\(.*\)\"$/\1/')
  if [[ $__resultvar ]]; then
    eval $__resultvar="'$last_release'"
  else
    echo "$last_release"
  fi
}

function demo::start-virtlet {
  local -a virtlet_config=(--from-literal=download_protocol=http --from-literal=image_regexp_translation="$IMAGE_REGEXP_TRANSLATION")
  if [[ ${VIRTLET_DEMO_BRANCH} ]]; then
    if [[ ${VIRTLET_DEMO_BRANCH} = "master" ]]; then
      virtlet_release="master"
      virtlet_docker_tag="latest"
    else
      virtlet_release="${VIRTLET_DEMO_BRANCH}"
      virtlet_docker_tag=$(echo $VIRTLET_DEMO_BRANCH | sed -e "s/\//_/g")
      BASE_LOCATION="https://raw.githubusercontent.com/Mirantis/virtlet/${virtlet_release}/"
    fi
  else
    if [[ ${VIRTLET_DEMO_RELEASE} ]]; then
      virtlet_release="${VIRTLET_DEMO_RELEASE}"
    else
      demo::get-correct-virtlet-release virtlet_release
    fi
    # set correct urls and names
    virtlet_docker_tag="${virtlet_release}"
    BASE_LOCATION="https://raw.githubusercontent.com/Mirantis/virtlet/${virtlet_release}/"
  fi
  echo "Will run demo using Virtlet:${virtlet_release} for demo and ${virtlet_docker_tag} as dockertag"
  if demo::kvm-ok; then
    demo::step "Setting up Virtlet configuration with KVM support"
  else
    demo::step "Setting up Virtlet configuration *without* KVM support"
    virtlet_config+=(--from-literal=disable_kvm=y)
  fi

  "${kubectl}" create configmap -n kube-system virtlet-config "${virtlet_config[@]}"
  # new functionality added post 0.8.2
  # that logic could be removed later
  if [[ ${BASE_LOCATION} == https://* ]]; then
    # remote location so fetch file
    rm -f demo_images.yaml
    status_code=$(curl -w "%{http_code}" --silent -o demo_images.yaml "${BASE_LOCATION}"/deploy/images.yaml)
    if [[ $status_code == "200" ]]; then
      "${kubectl}" create configmap -n kube-system virtlet-image-translations --from-file demo_images.yaml
    fi
  else
    if [[ -f ${BASE_LOCATION}/deploy/images.yaml ]]; then
      "${kubectl}" create configmap -n kube-system virtlet-image-translations --from-file "${BASE_LOCATION}/deploy/images.yaml"
    fi
  fi

  if [[ ${DEMO_LOG_LEVEL} ]]; then
      demo::step "Deploying Virtlet CRDs"
      docker run --rm "mirantis/virtlet:${virtlet_docker_tag}" virtletctl gen --crd |
          "${kubectl}" apply -f -
      "${kubectl}" apply -f - <<EOF
---
apiVersion: "virtlet.k8s/v1"
kind: VirtletConfigMapping
metadata:
  name: demo-log-level
  namespace: kube-system
spec:
  config:
    logLevel: ${DEMO_LOG_LEVEL}
EOF
  fi
  demo::step "Deploying Virtlet DaemonSet with docker tag ${virtlet_docker_tag}"
  docker run --rm "mirantis/virtlet:${virtlet_docker_tag}" virtletctl gen --tag "${virtlet_docker_tag}" |
      "${kubectl}" apply -f -
  demo::wait-for "Virtlet DaemonSet" demo::pods-ready runtime=virtlet
}

function demo::start-nginx {
  "${kubectl}" run nginx --image=nginx --expose --port 80
}

function demo::start-vm {
  demo::step "Starting sample CirrOS VM"
  "${kubectl}" create -f "${BASE_LOCATION}/examples/cirros-vm.yaml"
  demo::wait-for "CirrOS VM" demo::vm-ready cirros-vm
  if [[ ! "${NO_VM_CONSOLE:-}" ]]; then
    demo::step "Establishing ssh connection to the VM. Use Ctrl-D to disconnect"
    demo::ssh
  fi
}

if [[ ${1:-} = "--help" || ${1:-} = "-h" ]]; then
  cat <<EOF >&2
Usage: ./demo.sh

This script runs a simple demo of Virtlet[1] using kubeadm-dind-cluster[2]
ssh connection will be established after Virtlet setup is complete, Ctrl-D
can be used to disconnect from it.
Use 'curl http://nginx.default.svc.cluster.local' from VM console to test
cluster networking.

To clean up the cluster, use './dind-cluster-v${KUBE_VERSION}.sh clean'
[1] https://github.com/Mirantis/virtlet
[2] https://github.com/kubernetes-sigs/kubeadm-dind-cluster
EOF
  exit 0
fi

demo::get-dind-cluster
if [[ ${MULTI_CNI} ]]; then
  export NUM_NODES=1
  export CNI_PLUGIN=flannel
fi
demo::start-dind-cluster
if [[ ${MULTI_CNI} ]]; then
  demo::install-cni-genie
fi
for virtlet_node in "${virtlet_nodes[@]}"; do
  demo::fix-mounts "${virtlet_node}"
  demo::install-cri-proxy "${virtlet_node}"
  if [[ ${INJECT_LOCAL_IMAGE:-} ]]; then
    demo::inject-local-image "${virtlet_node}"
  fi
  demo::label-and-untaint-node "${virtlet_node}"
done
demo::start-virtlet
demo::start-nginx
demo::start-vm
```

