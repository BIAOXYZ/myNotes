
# 官方

- 配置对多集群的访问 https://v1-18.docs.kubernetes.io/zh/docs/tasks/access-application-cluster/configure-access-multiple-clusters/ || Configure Access to Multiple Clusters https://v1-18.docs.kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/
  * > 
    ```sh
    Note:
    To delete a user you can run `kubectl --kubeconfig=config-demo config unset users.<name>`
    To remove a cluster, you can run `kubectl --kubeconfig=config-demo config unset clusters.<name>`
    To remove a context, you can run `kubectl --kubeconfig=config-demo config unset contexts.<name>`
    ```
- 使用 kubeconfig 文件组织集群访问 https://v1-18.docs.kubernetes.io/zh/docs/concepts/configuration/organize-cluster-access-kubeconfig/
- kubectl 备忘单 https://v1-18.docs.kubernetes.io/zh/docs/reference/kubectl/cheatsheet/

# 其他文章

Kubernetes RBAC 详解 https://www.qikqiak.com/post/use-rbac-in-k8s/
```sh
# 现在我们可以使用刚刚创建的证书文件和私钥文件在集群中创建新的凭证和上下文(Context):
$ kubectl config set-credentials haimaxy --client-certificate=haimaxy.crt  --client-key=haimaxy.key

# 我们可以看到一个用户haimaxy创建了，然后为这个用户设置新的 Context:
$ kubectl config set-context haimaxy-context --cluster=kubernetes --namespace=kube-system --user=haimaxy
```

# 个人实战

## 实战查看命令参数

```sh
[root@anaemia-inf ~]# kubectl config --help
Modify kubeconfig files using subcommands like "kubectl config set current-context my-context"

 The loading order follows these rules:

  1.  If the --kubeconfig flag is set, then only that file is loaded. The flag may only be set once and no merging takes
place.
  2.  If $KUBECONFIG environment variable is set, then it is used as a list of paths (normal path delimiting rules for
your system). These paths are merged. When a value is modified, it is modified in the file that defines the stanza. When
a value is created, it is created in the first file that exists. If no files in the chain exist, then it creates the
last file in the list.
  3.  Otherwise, ${HOME}/.kube/config is used and no merging takes place.

Available Commands:
  current-context Displays the current-context
  delete-cluster  Delete the specified cluster from the kubeconfig
  delete-context  Delete the specified context from the kubeconfig
  get-clusters    Display clusters defined in the kubeconfig
  get-contexts    Describe one or many contexts
  rename-context  Renames a context from the kubeconfig file.
  set             Sets an individual value in a kubeconfig file
  set-cluster     Sets a cluster entry in kubeconfig
  set-context     Sets a context entry in kubeconfig
  set-credentials Sets a user entry in kubeconfig
  unset           Unsets an individual value in a kubeconfig file
  use-context     Sets the current-context in a kubeconfig file
  view            Display merged kubeconfig settings or a specified kubeconfig file

Usage:
  kubectl config SUBCOMMAND [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).
[root@anaemia-inf ~]#

```

## 查询（context、cluster）和使用context 
//user的话没有专门命令但是也能看出来

### 机器1

```sh
[root@lolls-inf ~]# oc config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://api.lolls.os.fyre.ibm.com:6443
  name: api-lolls-os-fyre-ibm-com:6443
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://api.lolls.os.fyre.ibm.com:6443
  name: lolls
- cluster:
    insecure-skip-tls-verify: true
    server: https://api.lolls.os.fyre.ibm.com:6443
  name: mycluster
contexts:
- context:
    cluster: api-lolls-os-fyre-ibm-com:6443
    user: admin/api-lolls-os-fyre-ibm-com:6443
  name: /api-lolls-os-fyre-ibm-com:6443/admin
- context:
    cluster: lolls
    user: admin
  name: admin
- context:
    cluster: api-lolls-os-fyre-ibm-com:6443
    namespace: default
    user: admin/api-lolls-os-fyre-ibm-com:6443
  name: default/api-lolls-os-fyre-ibm-com:6443/admin
- context:
    cluster: api-lolls-os-fyre-ibm-com:6443
    namespace: default
    user: kube:admin/api-lolls-os-fyre-ibm-com:6443
  name: default/api-lolls-os-fyre-ibm-com:6443/kube:admin
- context:
    cluster: mycluster
    namespace: default
    user: mycluster-user
  name: mycluster-context
current-context: default/api-lolls-os-fyre-ibm-com:6443/admin
kind: Config
preferences: {}
users:
- name: admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
    token: GSfw5OtU4_eqZmUNRgvS_cGYM2cl5V-i64Gej9tLUnZi
- name: admin/api-lolls-os-fyre-ibm-com:6443
  user:
    token: VPAagw_sJUyCpHdi2UmjOdwIwDvh6hn1KG-oXDgy2Gk
- name: kube:admin/api-lolls-os-fyre-ibm-com:6443
  user: {}
- name: mycluster-user
  user:
    token: t2mkR0AaVRWo_DvNJB5j4XaTfzOz2z7vBwNImuqlgKLS
[root@lolls-inf ~]#


#// 仔细对比就会发现了，一共5个contexts，和前面view里显示的是对应的。
#// clusters一共三个，也和前面对应得上。
#// 甚至AUTHINFO也和前面的“users”是对应的，只是没有专门的语句去查（其实查了contexts和clusters，甚至只是contexts就够了）。
[root@lolls-inf ~]# oc config get-contexts
CURRENT   NAME                                                CLUSTER                          AUTHINFO                                    NAMESPACE
          /api-lolls-os-fyre-ibm-com:6443/admin               api-lolls-os-fyre-ibm-com:6443   admin/api-lolls-os-fyre-ibm-com:6443
          admin                                               lolls                            admin
*         default/api-lolls-os-fyre-ibm-com:6443/admin        api-lolls-os-fyre-ibm-com:6443   admin/api-lolls-os-fyre-ibm-com:6443        default
          default/api-lolls-os-fyre-ibm-com:6443/kube:admin   api-lolls-os-fyre-ibm-com:6443   kube:admin/api-lolls-os-fyre-ibm-com:6443   default
          mycluster-context                                   mycluster                        mycluster-user                              default
[root@lolls-inf ~]#
[root@lolls-inf ~]# oc config get-clusters
NAME
lolls
mycluster
api-lolls-os-fyre-ibm-com:6443
[root@lolls-inf ~]#
[root@lolls-inf ~]# oc config current-context
default/api-lolls-os-fyre-ibm-com:6443/admin
[root@lolls-inf ~]#


#// 切换当前context。
[root@lolls-inf ~]# kubectl config use-context admin
Switched to context "admin".
[root@lolls-inf ~]#
[root@lolls-inf ~]# kubectl config current-context
admin
[root@lolls-inf ~]#
[root@lolls-inf ~]# kubectl config use-context default/api-lolls-os-fyre-ibm-com:6443/admin
Switched to context "default/api-lolls-os-fyre-ibm-com:6443/admin".
[root@lolls-inf ~]#
[root@lolls-inf ~]# kubectl config current-context
default/api-lolls-os-fyre-ibm-com:6443/admin
[root@lolls-inf ~]#
```

### 机器2

```sh
#// 这个是一个新的OCP：就一个context、一个cluster和一个user，对应关系更加一目了然了。
[root@anaemia-inf ~]# kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://api.anaemia.os.fyre.ibm.com:6443
  name: anaemia
contexts:
- context:
    cluster: anaemia
    user: admin
  name: admin
current-context: admin
kind: Config
preferences: {}
users:
- name: admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
[root@anaemia-inf ~]#
[root@anaemia-inf ~]# kubectl config get-contexts
CURRENT   NAME    CLUSTER   AUTHINFO   NAMESPACE
*         admin   anaemia   admin
[root@anaemia-inf ~]#
```

## 删除context和cluster 
//`unset`看起来是通用的，但是对于context和cluster来说，其实本身有`delete-context`和`delete-cluster`

```sh
{root@bandore1 multicloud-operators-test}$ kubectl config get-contexts
CURRENT   NAME                                                     CLUSTER                               AUTHINFO                                         NAMESPACE
          default/api-oprinstall-cp-fyre-ibm-com:6443/kube:admin   api-oprinstall-cp-fyre-ibm-com:6443   kube:admin/api-oprinstall-cp-fyre-ibm-com:6443   default
*         kubernetes-admin@kubernetes                              kubernetes                            kubernetes-admin
{root@bandore1 multicloud-operators-test}$
{root@bandore1 multicloud-operators-test}$ oc config delete-context default/api-oprinstall-cp-fyre-ibm-com:6443/kube:admin
deleted context default/api-oprinstall-cp-fyre-ibm-com:6443/kube:admin from /root/.kube/config
{root@bandore1 multicloud-operators-test}$
{root@bandore1 multicloud-operators-test}$ kubectl config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin
{root@bandore1 multicloud-operators-test}$


{root@bandore1 multicloud-operators-test}$ oc config view
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://api.oprinstall.cp.fyre.ibm.com:6443
  name: api-oprinstall-cp-fyre-ibm-com:6443
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://9.46.87.88:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kube:admin/api-oprinstall-cp-fyre-ibm-com:6443
  user:
    token: MclcT5qSZPEkOEFVJkloGEkFkdqLSWTmTsuE4kR1iCU
- name: kubernetes-admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
{root@bandore1 multicloud-operators-test}$
{root@bandore1 multicloud-operators-test}$ oc config delete-cluster api-oprinstall-cp-fyre-ibm-com:6443
deleted cluster api-oprinstall-cp-fyre-ibm-com:6443 from /root/.kube/config
{root@bandore1 multicloud-operators-test}$
{root@bandore1 multicloud-operators-test}$ oc config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://9.46.87.88:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kube:admin/api-oprinstall-cp-fyre-ibm-com:6443
  user:
    token: MclcT5qSZPEkOEFVJkloGEkFkdqLSWTmTsuE4kR1iCU
- name: kubernetes-admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
{root@bandore1 multicloud-operators-test}$

#// 接上来继续测试下用unset删user。
{root@bandore1 configs}$ oc config unset users.kube:admin/api-oprinstall-cp-fyre-ibm-com:6443
Property "users.kube:admin/api-oprinstall-cp-fyre-ibm-com:6443" unset.
{root@bandore1 configs}$
{root@bandore1 configs}$ oc config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://9.46.87.88:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
{root@bandore1 configs}$
```
