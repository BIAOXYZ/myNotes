
# 官方网址

IBM Cloud Paks https://www.ibm.com/cloud/paks/

IBM Cloud Paks are enterprise-grade containerized software by combining container images with enterprise capabilities for deployment in production use cases with integrations for management and lifecycle operations. Features such as pre-configured deployments based on product expertise, rolling upgrades, rollbacks, security/vulnerability testing… https://github.com/IBM/cloud-pak

# 子产品

IBM Cloud Pak for Multicloud Management https://www.ibm.com/cloud/cloud-pak-for-management 【也就是`CP4MCM`】

IBM Cloud Pak for Data https://www.ibm.com/products/cloud-pak-for-data

IBM Cloud Pak for Applications https://www.ibm.com/cloud/cloud-pak-for-applications

#  CP4MCM相关产品/组件

### ibm-common-service

ibm-common-service-operator/docs/uninstall.md https://github.com/IBM/ibm-common-service-operator/blob/a82f77bb47725b332667cd5a1795d1f076bff2ea/docs/uninstall.md

Installing IBM Cloud Platform Common Services in your OpenShift Container Platform cluster https://www.ibm.com/support/knowledgecenter/SSHKN6/installer/3.x.x/install_operator.html

Troubleshooting certificate management service https://www.ibm.com/support/knowledgecenter/SSBS6K_3.2.0/troubleshoot/ts_cert_mgmt.html

### Application management

Creating and managing hybrid application resources https://www.ibm.com/support/knowledgecenter/SSFC4F_2.0.0/mcm/applications/managing_apps.html

### Infrastructure and Service Management

Provisioning Virtual Machines and Instances https://www.ibm.com/support/knowledgecenter/SSFC4F_2.0.0/Infra_mgmt/provisioning_virtual_machines_and_hosts/index.html

### Technology preview

Managing Runtimes https://www.ibm.com/support/knowledgecenter/SSFC4F_2.0.0/mcm/applications/manage_runtimes.html

## 官网手册类

Creating and managing subscriptions https://www.ibm.com/support/knowledgecenter/SSFC4F_1.2.0/mcm/applications/managing_subscriptions.html

【[:star:][`*`]】【里面是关于CP4MCM几个核心概念的较为详细的介绍】 Managing applications https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/mcm/applications/overview.html

Creating and managing application resources https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/mcm/applications/managing_apps.html

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

CLI tools guide https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/cli/cli_guide_mcm.html
- Managing your cluster with IBM Cloud Pak® CLI (cloudctl) https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/cloudctl/icp_cli.html
- Using the IBM Cloud Pak® CLI (cloudctl) multicluster plug-in (mc) https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/cli/cp_cli_mcm.html
  * IBM Cloud Pak™ CLI (cloudctl) multicluster commands (mc) https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/cli/cli_mc_commands.html 【其实原来cloudctl是ICP的，但是现在一是ICP要放弃并全面转向基于OpenShift的CP4MCM，二是过去的ICP的东西还得兼容，所以在`cloudctl`基础上搞了一个`cloudctl mc`】
- Installing the Helm CLI (helm) https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/helm-cli/3.4.0/create_helm_cli.html

## 新的operator based安装方式

- Installing the IBM Cloud Pak® for Multicloud Management online - DRAFT https://www-03preprod.ibm.com/support/knowledgecenter/SSFC4F_2.0.0/install/online_install.html
- Advanced configuration https://www-03preprod.ibm.com/support/knowledgecenter/SSFC4F_2.0.0/install/config_adv.html

## 导入managed cluster

Importing a target managed cluster to the hub cluster https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/mcm/installing/install_k8s_cloud.html
- Importing a cluster with the CLI https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/mcm/manage_cluster/import_cli.html
- Importing a managed cluster in an air gapped environment https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/mcm/installing/offline_endpoint.html

## LDAP

Onboarding LDAP users https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/icam/install_mcm_ldap.html
- Configuring LDAP connection https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/iam/3.4.0/configure_ldap.html

## 问题解决

IBM Cloud Pak for Multicloud Management troubleshooting https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/mcm/troubleshoot/mcm_troubleshoot.html
- IBM Cloud Pak for Multicloud Management troubleshooting for cluster management https://www.ibm.com/support/knowledgecenter/SSFC4F_1.3.0/mcm/troubleshoot/cluster_manage_trouble.html

### Firefox浏览器上，CP4MCM的console之前可以登陆，后来登陆不上去了（Chrome就没成功过，但是有少数同事说自己成功过，不管了）

I get "corrupted content error" for a site that I can access on a different device. https://support.mozilla.org/en-US/questions/1232935
- >
  ```
  (2) Remove the site's cookies (save any pending work first). While viewing a page on the site, try either:
            right-click and choose View Page Info > Security > "View Cookies"
            Alt+t (open the classic Tools menu) > Page Info > Security > "View Cookies" 
      In the dialog that opens, you can remove the site's cookies individually.
      Then try reloading the page. Does that help?
  ```

>> notes: 实际上这次的解决不只是用`右键CP4MCM console 网页`，然后经过`View Page Info`等步骤，直到最后删除CP4MCM web console对应页面的cookie那么简单。我之前确实是**仅删除**CP4MCM web console对应的网页的cookie就好了，这次也这样却发现不行。都差点重装了。。。 <br> 后来找同事发现他们都能登陆，于是确定问题肯定是在我这边的Fireforx上。最后发现删cookie时把那个弹出的框框里所有涉及的页面的cookie（那个框框会包含一些相关网页的cookie，比如CP4MCM所依赖的Openshift的cookie）全都删掉（我甚至把保存的CP4MCM页面的登陆账号密码也删了，虽然这步可能并没有什么影响），然后再登陆终于好了。

# 其他链接

IBM Cloud Pak Skills and Certification Program https://w3.ibm.com/w3publisher/cloud-paks-skills-and-certification

【[:star:][`*`]】【里面是较为详细的例子】 IBM Cloud Pak for Multicloud Management - Multi-cluster Application Management https://www.ibm.com/cloud/garage/dte/tutorial/multi-cluster-application-management/
- > **Define application channel**
  * > The concept is similar to subscription model of TV channels. In this model, all the applications, which are packaged as helm charts, are hosted in one or more repositories. The repositories, which contain the application packages, are defined as channels that broadcast across the clusters. If you want to deploy an application, then define a subscription to the channel with the name of the application (one or more) you want to deploy.
  * > Channels (Channel.app.ibm.com) define a namespace within the hub cluster and point to a physical place where resources are stored for deployment; such as an object store, Kubernetes namespace, or Helm repository.
  * > The modresort application component consists of a deployment resource definition and a service resource definition.
To enable these components to be used by the channel subscription, each of the resources need to be wrapped by a new custom resource definition (CRD) called Deployable.
  * > Refer to the online documentation for details on the construct of the Deployable definition: https://www.ibm.com/support/knowledgecenter/en/SSFC4F_1.2.0/mcm/applications/managing_deployables.html
- > **Create a Subscription**
  * > The subscription to a channel package contains:
    + > Application Definition
    + > Placement Rules Definition
    + > Subscription Definition
  * > **Applications** (Application.app.k8s.io) in IBM Multicloud Manager are used for grouping application components.
  * > **Placement rules** (PlacementRule.app.ibm.com) define the target clusters where deployables can be deployed. You can use placement rules to help you facilitate the multi-cluster deployment of your deployables. Placement rules can be referenced by deployables and subscriptions.
  * > **Subscriptions** (Subscription.app.ibm.com) are sets of definitions that identify deployables within channels by using annotations, labels, and versions.
  * > The subscription controller can monitor the channel for new or updated deployables, such as an updated Helm release or a new Kubernetes deployable object. Then, the controller can download the Kubernetes deployable object or Helm release directly from the source location (Helm repository, object store, or namespace) to the target-managed clusters.
  * > Refer to the online documentation for details on configuring the Application resource: https://www.ibm.com/support/knowledgecenter/en/SSFC4F_1.2.0/mcm/applications/app_lifecycle.html
  * > Refer to the online documentation for details on configuring the Placement Rules resource: https://www.ibm.com/support/knowledgecenter/en/SSFC4F_1.2.0/mcm/applications/managing_placement_rules.html
  * > Now, let’s create the subscription file. This contains the details of relating the placement rule definition with the application specification.
  * > Refer to the online documentation for details on configuring the Subscription resource: https://www.ibm.com/support/knowledgecenter/en/SSFC4F_1.2.0/mcm/applications/managing_subscriptions.html
- > **Deploy the application**
  * > The subscription is deployed to a different namespace than the channel. Never deploy the subscription to the same namespace as the channel. Hence, deploy the subscription to the other namespace, modresort-project.
- > **Validate the application**
  * > Verify that your subscriptions are propagated correctly by running the command. <br> `oc get subscription.app.ibm.com --all-namespaces` <br> The subscription from the **mcm hub** should be in the **Propagated** state.
- > **Move the application between clusters**
  * > Applications deployed using the Subscription model are deployed to clusters based on PlacementRules. The placement rules for deployables can be defined as a stand-alone resource and referenced by the deployable. The placement rules use cluster labels to determine where to place the applications.
  * > In the following steps, you move the application from the **Dev** cluster to the **QA** cluster by changing the placement policy. You also learn how to use cluster replicas.
  * > What if you want to run the application on both the clusters? This is possible by changing clusterReplicas and matchingLabel. Let’s do it! Back to the Multicluster Management page, on the Editor, change **clusterReplicas** to **2**. On the spec **matchLabels** setting, remove the **environment** label, and add **vendor** label with value **Openshift**. The label, vendor, exists on both the clusters and the value matches OpenShift.
- > **Summary**  
  * > If you would like to learn more about Cloud Pak for Multicloud Management, refer to:
    + > Cloud Pak for Multicloud Management [home page](https://www.ibm.com/cloud/cloud-pak-for-management)
    + > Cloud Pak for Multicloud Management [Demos](https://www.ibm.com/demos/collection/Cloud-Pak-for-Multicloud-Management/)

Documentation for IBM CloudPak playbooks. https://github.com/ibm-cloud-architecture/cloudpak8s
> IBM Cloud Paks Playbook https://cloudpak8s.io/

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

```sh
# 必须要指定namespace。。。

[root@lolls-inf ~]# cloudctl login -a https://icp-console.apps.lolls.os.fyre.ibm.com:443 -u admin -p admin --skip-ssl-validation
Authenticating...
OK

Targeted account mycluster Account

Enter a namespace >
FAILED
No namespace selected. You need to select a namespace.
[root@lolls-inf ~]#
[root@lolls-inf ~]# cloudctl login -a https://icp-console.apps.lolls.os.fyre.ibm.com:443 -u admin -p admin --skip-ssl-validation -n default
Authenticating...
OK

Targeted account mycluster Account

Targeted namespace default

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
[root@lolls-inf ~]#
```
