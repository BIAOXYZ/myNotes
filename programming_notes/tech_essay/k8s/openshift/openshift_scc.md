
# 如何查看哪些scc被哪些用户使用？

```sh
# 一台完全没改过的OCP
[root@anaemia-inf ~]# oc describe scc anyuid
Name:                                           anyuid
Priority:                                       10
Access:
  Users:                                        <none>
  Groups:                                       system:cluster-admins
Settings:
  Allow Privileged:                             false
  Allow Privilege Escalation:                   true
  Default Add Capabilities:                     <none>
  Required Drop Capabilities:                   MKNOD
  Allowed Capabilities:                         <none>
  Allowed Seccomp Profiles:                     <none>
  Allowed Volume Types:                         configMap,downwardAPI,emptyDir,persistentVolumeClaim,projected,secret
  Allowed Flexvolumes:                          <all>
  Allowed Unsafe Sysctls:                       <none>
  Forbidden Sysctls:                            <none>
  Allow Host Network:                           false
  Allow Host Ports:                             false
  Allow Host PID:                               false
  Allow Host IPC:                               false
  Read Only Root Filesystem:                    false
  Run As User Strategy: RunAsAny
    UID:                                        <none>
    UID Range Min:                              <none>
    UID Range Max:                              <none>
  SELinux Context Strategy: MustRunAs
    User:                                       <none>
    Role:                                       <none>
    Type:                                       <none>
    Level:                                      <none>
  FSGroup Strategy: RunAsAny
    Ranges:                                     <none>
  Supplemental Groups Strategy: RunAsAny
    Ranges:                                     <none>
[root@anaemia-inf ~]#
```

```sh
# 另一台之前执行过某些脚本，改过scc和sa的OCP。其相关的改动语句是：
## oc adm policy add-scc-to-user anyuid system:serviceaccount:openshift-operators:default
## oc adm policy add-scc-to-user anyuid system:serviceaccount:cp4m:default

# 对比上面的查询结果，我们可以看到 Users 那部分的值就体现了上面两个语句的改动。
[root@lolls-inf ~]# oc describe scc anyuid
Name:                                           anyuid
Priority:                                       10
Access:
  Users:                                        system:serviceaccount:openshift-operators:default,system:serviceaccount:cp4m:default
  Groups:                                       system:cluster-admins
Settings:
  Allow Privileged:                             false
  Allow Privilege Escalation:                   true
  Default Add Capabilities:                     <none>
  Required Drop Capabilities:                   MKNOD
  Allowed Capabilities:                         <none>
  Allowed Seccomp Profiles:                     <none>
  Allowed Volume Types:                         configMap,downwardAPI,emptyDir,persistentVolumeClaim,projected,secret
  Allowed Flexvolumes:                          <all>
  Allowed Unsafe Sysctls:                       <none>
  Forbidden Sysctls:                            <none>
  Allow Host Network:                           false
  Allow Host Ports:                             false
  Allow Host PID:                               false
  Allow Host IPC:                               false
  Read Only Root Filesystem:                    false
  Run As User Strategy: RunAsAny
    UID:                                        <none>
    UID Range Min:                              <none>
    UID Range Max:                              <none>
  SELinux Context Strategy: MustRunAs
    User:                                       <none>
    Role:                                       <none>
    Type:                                       <none>
    Level:                                      <none>
  FSGroup Strategy: RunAsAny
    Ranges:                                     <none>
  Supplemental Groups Strategy: RunAsAny
    Ranges:                                     <none>
[root@lolls-inf ~]#


# 但是想从sa直接查scc似乎是不行的。从上面查询结果知道 cp4m 名字空间下的名为 default 的SA是关联了anyuid scc
# 的，但是不论 get 还是 describe 这个SA，都无法看到相关scc的信息。
[root@lolls-inf ~]# oc describe sa default -n cp4m
Name:                default
Namespace:           cp4m
Labels:              <none>
Annotations:         <none>
Image pull secrets:  default-dockercfg-crsw8
Mountable secrets:   default-token-2vxsp
                     default-dockercfg-crsw8
Tokens:              default-token-2vxsp
                     default-token-pvx77
Events:              <none>
[root@lolls-inf ~]#
[root@lolls-inf ~]# oc get sa default -n cp4m -o yaml
apiVersion: v1
imagePullSecrets:
- name: default-dockercfg-crsw8
kind: ServiceAccount
metadata:
  creationTimestamp: "2020-06-02T13:02:33Z"
  name: default
  namespace: cp4m
  resourceVersion: "44446961"
  selfLink: /api/v1/namespaces/cp4m/serviceaccounts/default
  uid: 55580295-7041-409e-9ada-2c0730ffaecb
secrets:
- name: default-token-2vxsp
- name: default-dockercfg-crsw8
[root@lolls-inf ~]#
```
