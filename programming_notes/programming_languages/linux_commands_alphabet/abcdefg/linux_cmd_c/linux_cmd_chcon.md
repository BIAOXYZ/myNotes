
# 源头

## 源头1

```sh
# 1.安装CP4MCM时，要ssh到几个worker节点执行下述chcon命令
ssh core@worker0 "sudo chcon -Rt svirt_sandbox_file_t /var/lib/kubelet/plugins_registry/storageos"
ssh core@worker1 "sudo chcon -Rt svirt_sandbox_file_t /var/lib/kubelet/plugins_registry/storageos"
ssh core@worker2 "sudo chcon -Rt svirt_sandbox_file_t /var/lib/kubelet/plugins_registry/storageos"
ssh core@worker3 "sudo chcon -Rt svirt_sandbox_file_t /var/lib/kubelet/plugins_registry/storageos"
ssh core@worker4 "sudo chcon -Rt svirt_sandbox_file_t /var/lib/kubelet/plugins_registry/storageos"

## 注意：实际上只有前三个worker节点上才装有CP4MCM
[root@lolls-inf ~]# oc get node
NAME                            STATUS   ROLES                  AGE   VERSION
master0.lolls.os.fyre.ibm.com   Ready    master                 46d   v1.16.2
master1.lolls.os.fyre.ibm.com   Ready    master                 46d   v1.16.2
master2.lolls.os.fyre.ibm.com   Ready    master                 46d   v1.16.2
worker0.lolls.os.fyre.ibm.com   Ready    cp-master,worker       46d   v1.16.2
worker1.lolls.os.fyre.ibm.com   Ready    cp-proxy,worker        46d   v1.16.2
worker2.lolls.os.fyre.ibm.com   Ready    cp-management,worker   46d   v1.16.2
worker3.lolls.os.fyre.ibm.com   Ready    worker                 46d   v1.16.2
worker4.lolls.os.fyre.ibm.com   Ready    worker                 46d   v1.16.2
```

## 源头2

https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/mcm/troubleshoot/delete_import.html
```sh
# If Security-Enhanced Linux (SELinux) is enabled in your cluster, you must change the security context 
# to allow access to the /tmp folder.
chcon -Rt svirt_sandbox_file_t /tmp
```

# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

# 个人实战
