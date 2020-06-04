
Kubernetes Security 101: Risks and 29 Best Practices https://www.stackrox.com/post/2020/05/kubernetes-security-101/

Managing the Security of Kubernetes Container Workloads https://www.giantswarm.io/blog/managing-the-security-of-kubernetes-container-workloads
- > Kubernetes has an in-built ImagePolicyWebhook admission controller for this purpose, which relies on an external backend to authorize the use of the images defined for a Pod’s containers. When configured appropriately - before a pod is admitted to the cluster - the backend is sent an ImageReview object containing the details of the container images, which it allows or disallows based on the policy it’s configured with.

Kubernetes security context, security policy, and network policy – Kubernetes security guide (part 2). https://sysdig.com/blog/kubernetes-security-psp-network-policy/

How can I create IBM Cloud Private namespaces, together with PSPs using the commandline? https://stackoverflow.com/questions/53855731/how-can-i-create-ibm-cloud-private-namespaces-together-with-psps-using-the-comm
- > Adding a pod security policy binding to a namespace https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.1/user_management/psp_addbind_ns.html
  >> `kubectl -n appsales create rolebinding ibm-anyuid-clusterrole-rolebinding --clusterrole=ibm-anyuid-clusterrole --group=system:serviceaccounts:appsales`

```sh
# 实战

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
