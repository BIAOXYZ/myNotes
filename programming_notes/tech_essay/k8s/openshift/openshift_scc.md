
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


# 另一台之前执行过某些脚本，改过scc和sa的OCP。其相关的改动语句是：
## Workaround for catalogsource SCC - investigation in progress
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
```
