
# 官方网址

IBM Cloud Paks https://www.ibm.com/cloud/paks/

IBM Cloud Paks are enterprise-grade containerized software by combining container images with enterprise capabilities for deployment in production use cases with integrations for management and lifecycle operations. Features such as pre-configured deployments based on product expertise, rolling upgrades, rollbacks, security/vulnerability testing… https://github.com/IBM/cloud-pak

## 子产品

IBM Cloud Pak for Multicloud Management https://www.ibm.com/cloud/cloud-pak-for-management 【也就是`CP4MCM`】

IBM Cloud Pak for Data https://www.ibm.com/products/cloud-pak-for-data

IBM Cloud Pak for Applications https://www.ibm.com/cloud/cloud-pak-for-applications

## 官网手册类

Creating and managing subscriptions https://www.ibm.com/support/knowledgecenter/SSFC4F_1.2.0/mcm/applications/managing_subscriptions.html

IBM Cloud Pak™ CLI (cloudctl) multicluster commands (mc) https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/cli/cli_mc_commands.html 【其实原来cloudctl是ICP的，但是现在一是ICP要放弃并全面转向基于OpenShift的CP4MCM，二是过去的ICP的东西还得兼容，所以在`cloudctl`基础上搞了一个`cloudctl mc`】

## CP(K)安装

【[:star:][`*`]】【适用于在已有ocp集群基础上装cp4mcm】 Installing the IBM Cloud Pak® for Multicloud Management offline https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/install/cloud_pak_foundation.html

Uninstalling the IBM Cloud Pak® for Multicloud Management offline https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/install/uninstall.html
```sh
cd /<installation_directory>/cluster
sudo docker run -t --net=host -e LICENSE=accept -v $(pwd):/installer/cluster:z -v /var/run:/var/run:z -v /etc/docker:/etc/docker:z --security-opt label:disable ibmcom/mcm-inception-amd64:3.2.5 uninstall-with-openshift
```

Getting started with IBM Cloud Pak for Multicloud Management https://cloud.ibm.com/docs/cloud-pak-multicloud-management?topic=cloud-pak-multicloud-management-getting-started
- Changing the cluster administrator username https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/iam/3.4.0/change_admin_passwd.html

Supported OpenShift versions and platforms https://www.ibm.com/support/knowledgecenter/en/SSFC4F_1.3.0/install/supported_os.html

## 导入managed cluster

Importing a target managed cluster to the hub cluster https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/mcm/installing/install_k8s_cloud.html
- Importing a cluster with the CLI https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/mcm/manage_cluster/import_cli.html
- Importing a managed cluster in an air gapped environment https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/mcm/installing/offline_endpoint.html

# 其他链接

IBM Cloud Pak for Multicloud Management - Multi-cluster Application Management https://www.ibm.com/cloud/garage/dte/tutorial/multi-cluster-application-management/

IBM Cloud Paks Playbook https://cloudpak8s.io/

# 个人实战

```sh
# 登陆CP4MCM和ICP的命令一样

[root@apmsvtocp5-inf ~]# cloudctl login -a https://icp-console.apps.apmsvtocp5.os.fyre.ibm.com:443 -u admin -p admin -n kube-system --skip-ssl-validation 
Authenticating...
OK

Targeted account mycluster Account

Targeted namespace kube-system

Configuring kubectl ...
Property "clusters.mycluster" unset.
Property "users.mycluster-user" unset.
Property "contexts.mycluster-context" unset.
Cluster "mycluster" set.
User "mycluster-user" set.
Context "mycluster-context" created.
Switched to context "mycluster-context".
OK

Configuring helm: /root/.helm
OK
[root@apmsvtocp5-inf ~]#
[root@apmsvtocp5-inf ~]# cloudctl logout
Logging out...
OK

Removing kubectl configuration ...
Property "clusters.mycluster" unset.
Property "users.mycluster-user" unset.
Property "contexts.mycluster-context" unset.
OK

Removing Helm certificates: /root/.helm
OK
[root@apmsvtocp5-inf ~]#
```
