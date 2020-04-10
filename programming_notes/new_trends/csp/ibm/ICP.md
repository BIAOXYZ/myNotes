
# 官方网址

What is IBM Cloud Private? https://www.ibm.com/blogs/cloud-computing/2017/10/31/what-is-ibm-cloud-private/

Introduction to IBM Cloud Private https://www.ibm.com/cloud/architecture/content/course/ibm-cloud-private-introduction/ibm-cloud-private-solutions

IBM Cloud Private overview https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.2/getting_started/introduction.html

Docker Image for IBM Cloud private-CE (Community Edition) https://hub.docker.com/r/ibmcom/icp-inception/

## 使用指南

IBM Cloud Private 3.1.2 -- CLI tools guide https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.2/manage_cluster/cli_guide.html

Setting up the Helm CLI https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0.3/app_center/create_helm_cli.html

## 故障排除

Deployment errors for ClusterImagePolicy and PodSecurityPolicy https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/troubleshoot/deploy_cluster_impo.html

Enforcing container image security https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.0/manage_images/image_security.html

# 其他攻略

使用 IBM Cloud Private 在多个云上运行 Kubernetes https://v1-17.docs.kubernetes.io/zh/docs/setup/production-environment/turnkey/icp/

IBM Cloud Private — Community Edition for Kubeflow (for Beginners) https://medium.com/@janeman98/ibm-cloud-private-community-edition-for-kubeflow-for-beginners-697a044522a

How to install IBM Cloud Private? https://containerized.me/how-to-install-ibm-cloud-private-updated/

# 个人实战

```sh
[root@c4-infra02 ~]# cloudctl login -a https://30.0.4.2:8443 -n kube-system --skip-ssl-validation -u admin -p ${PASSWD}
Authenticating...
OK

Targeted account mycluster Account (id-mycluster-account)

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
[root@c4-infra02 ~]#
```

```sh
[root@c4-infra02 stocktrader-helm]# helm package stocktrader
Successfully packaged chart and saved it to: /root/stocktraderrepo/stocktrader-helm/stocktrader-0.1.8.tgz
[root@c4-infra02 stocktrader-helm]#
[root@c4-infra02 stocktrader-helm]# git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       stocktrader-0.1.8.tgz
nothing added to commit but untracked files present (use "git add" to track)

[root@c4-infra02 stocktrader-helm]# cloudctl catalog load-chart --archive stocktrader-0.1.8.tgz --repo local-charts
Loading helm chart
Loaded helm chart

Synch charts
Synch started
OK
[root@c4-infra02 stocktrader-helm]#
```
```sh
[root@c4-infra02 4redis]# cloudctl catalog charts | grep redis
redis                                7.0.1      ibm-community-charts   Open source, advanced key-value store.
[root@c4-infra02 4redis]#
[root@c4-infra02 4redis]# cloudctl catalog repos
Name                   URL                                                                    Local
ibm-charts             https://raw.githubusercontent.com/IBM/charts/master/repo/stable/       false
local-charts           https://mycluster.icp:8443/helm-repo/charts                            true
mgmt-charts            https://mycluster.icp:8443/mgmt-repo/charts                            true
ppc64le-isv-charts     https://raw.githubusercontent.com/ppc64le/charts/master/repo/stable/   false
ibm-community-charts   https://raw.githubusercontent.com/IBM/charts/master/repo/community/    false
ibm-charts-public      https://registry.bluemix.net/helm/ibm/                                 false
[root@c4-infra02 4redis]#
```
