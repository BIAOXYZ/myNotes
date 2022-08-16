
# 组织

CNCF Special Interest Group for Security (SIG-Security) https://github.com/cncf/sig-security

# 待整理

Kubernetes Security 101: Risks and 29 Best Practices https://www.stackrox.com/post/2020/05/kubernetes-security-101/

Managing the Security of Kubernetes Container Workloads https://www.giantswarm.io/blog/managing-the-security-of-kubernetes-container-workloads
- > Kubernetes has an in-built ImagePolicyWebhook admission controller for this purpose, which relies on an external backend to authorize the use of the images defined for a Pod’s containers. When configured appropriately - before a pod is admitted to the cluster - the backend is sent an ImageReview object containing the details of the container images, which it allows or disallows based on the policy it’s configured with.

Kubernetes security context, security policy, and network policy – Kubernetes security guide (part 2). https://sysdig.com/blog/kubernetes-security-psp-network-policy/

How can I create IBM Cloud Private namespaces, together with PSPs using the commandline? https://stackoverflow.com/questions/53855731/how-can-i-create-ibm-cloud-private-namespaces-together-with-psps-using-the-comm
- > Adding a pod security policy binding to a namespace https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.1/user_management/psp_addbind_ns.html
  >> `kubectl -n appsales create rolebinding ibm-anyuid-clusterrole-rolebinding --clusterrole=ibm-anyuid-clusterrole --group=system:serviceaccounts:appsales`

```sh
# 个人实战以及ibm这些自己定制的psp的地址（仅以 ibm-restricted-psp 为例）：
# https://github.com/IBM/cloud-pak/blob/fc9291358bde7cb391a2a19f14415145a21bcb36/spec/security/psp/ibm-restricted-psp.yaml

[root@c4-infra02 ~]# kubectl get rolebinding -n 1234ns
NAME                                 AGE
ibm-anyuid-clusterrole-rolebinding   25h
[root@c4-infra02 ~]#
[root@c4-infra02 ~]# kubectl -n 1234ns create rolebinding ibm-privileged-clusterrole-rolebinding --clusterrole=ibm-privileged-clusterrole --group=system:serviceaccounts:1234ns
rolebinding.rbac.authorization.k8s.io/ibm-privileged-clusterrole-rolebinding created
[root@c4-infra02 ~]#
[root@c4-infra02 ~]# kubectl get rolebinding -n 1234ns
NAME                                     AGE
ibm-anyuid-clusterrole-rolebinding       25h
ibm-privileged-clusterrole-rolebinding   7s
[root@c4-infra02 ~]#

#// 删除的话直接删掉这个rolebinding就行
[root@c4-infra02 ~]# kubectl delete rolebinding ibm-privileged-clusterrole-rolebinding -n 1234ns
rolebinding.rbac.authorization.k8s.io "ibm-privileged-clusterrole-rolebinding" deleted

#// 真正在stocktrader名字空间执行的语句，和上面类似：
kubectl -n stocktrader create rolebinding ibm-anyuid-clusterrole-rolebinding --clusterrole=ibm-anyuid-clusterrole --group=system:serviceaccounts:stocktrader
```

# k8s security related projects

KubiScan: A tool to scan Kubernetes cluster for risky permissions https://github.com/cyberark/KubiScan

Kyverno -- Kubernetes Native Policy Management https://github.com/kyverno/kyverno/ || https://kyverno.io/

# k8s and 机密计算

Gartner 2020 云安全新兴技术成熟度曲线：机密计算将在 5 年至 10 年得到普遍使用 https://mp.weixin.qq.com/s/cXfxkK1Rs1QSP_PxhhaVuA
- > •用户忠告：Riley说：“提防幻灯片软件（slideware），尤其是针对基于云的交付即服务模式准备不足的老牌厂商提供的幻灯片软件。这种情况下，软件架构和实施很重要。真正的SASE服务是云原生的。”
  >> `slideware` --> 学习了。。。

谷歌将内存加密扩展到 Kubernetes：基于 AMD 最新 EPYC 处理器 https://www.ithome.com/0/508/007.htm

当 Kubernetes 遇到机密计算，阿里巴巴如何保护容器内数据的安全？ https://developer.aliyun.com/article/770904
- > https://developer.aliyun.com/live/43826
- > https://yq.aliyun.com/live/43829

ACK-TEE机密计算介绍 https://help.aliyun.com/document_detail/164536.html

微软将机密计算带入Kubernetes http://www.chinastor.com/netsafe/1121430942019.html

Azure 机密计算 https://azure.microsoft.com/zh-cn/solutions/confidential-compute/
