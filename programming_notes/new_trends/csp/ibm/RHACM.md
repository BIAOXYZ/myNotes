
# 个人实战

RHACM的安装脚本还是不错的。
```sh
{root@bandore1 deploy2.1}$ printf "2.1.0-SNAPSHOT-2020-10-10-03-29-09" | ./start.sh --watch
* Testing connection
* Using baseDomain: oprinstall.cp.fyre.ibm.com
* oc CLI Client Version: openshift-clients-4.3.0-201910250623-88-g6a937dfe
Find snapshot tags @ https://quay.io/repository/open-cluster-management/acm-custom-registry?tab=tags
Enter SNAPSHOT TAG: (Press ENTER for default: 2.1.0-SNAPSHOT-2020-10-10-03-29-09)
* Downstream:    Release Version: 2.1.0
* Composite Bundle: true   Image Registry (CUSTOM_REGISTRY_REPO): quay.io/open-cluster-management
* Using: 2.1.0-SNAPSHOT-2020-10-10-03-29-09

* Applying SNAPSHOT to multiclusterhub-operator subscription
* Applying CUSTOM_REGISTRY_REPO to multiclusterhub-operator subscription
* Applying SUBSCRIPTION_CHANNEL to multiclusterhub-operator subscription
* Applying multicluster-hub-cr values

##### Creating the open-cluster-management namespace
namespace/open-cluster-management created

##### Applying prerequisites
Warning: kubectl apply should be used on resource created by either kubectl create --save-config or kubectl apply
namespace/open-cluster-management configured
Warning: kubectl apply should be used on resource created by either kubectl create --save-config or kubectl apply
serviceaccount/default configured
secret/multiclusterhub-operator-pull-secret created

##### Applying acm-operator subscription #####
service/acm-custom-registry created
deployment.apps/acm-custom-registry created
operatorgroup.operators.coreos.com/default created
catalogsource.operators.coreos.com/acm-custom-registry created
subscription.operators.coreos.com/acm-operator-subscription created

#####
Wait for multiclusterhub-operator to reach running state (4min).
* STATUS: Waiting
* STATUS: Waiting
* STATUS: Waiting
* STATUS: Waiting
* STATUS: Waiting
* STATUS: Waiting
* STATUS: Waiting
* STATUS: Waiting
* STATUS: Waiting
* STATUS: Waiting
* STATUS: Waiting
* STATUS: Waiting
* STATUS: Waiting
* STATUS: Waiting
* STATUS: multiclusterhub-operator-78769468b-7n5tr                          0/1     ContainerCreating   0          2s
* STATUS: multiclusterhub-operator-78769468b-7n5tr                          0/1     ContainerCreating   0          6s
* STATUS: multiclusterhub-operator-78769468b-7n5tr                          0/1     ContainerCreating   0          10s
* STATUS: multiclusterhub-operator-78769468b-7n5tr                          0/1     ContainerCreating   0          13s
* multiclusterhub-operator is running

* Beginning deploy...
* Applying the multiclusterhub-operator to install Red Hat Advanced Cluster Management for Kubernetes
multiclusterhub.operator.open-cluster-management.io/multiclusterhub created

#####
Wait for multicluster-operators-application to reach running state (4min).
* STATUS: multicluster-operators-application-6dff7fdd77-47bwz               0/4     ContainerCreating   0          20s
* STATUS: multicluster-operators-application-6dff7fdd77-47bwz               0/4     ContainerCreating   0          24s
* STATUS: multicluster-operators-application-6dff7fdd77-47bwz               0/4     ContainerCreating   0          27s
* STATUS: multicluster-operators-application-6dff7fdd77-47bwz               0/4     ContainerCreating   0          31s
* STATUS: multicluster-operators-application-6dff7fdd77-47bwz               0/4     Running             0          34s
* STATUS: multicluster-operators-application-6dff7fdd77-47bwz               0/4     Running             0          38s
* STATUS: multicluster-operators-application-6dff7fdd77-47bwz               1/4     Running     0          42s
* STATUS: multicluster-operators-application-6dff7fdd77-47bwz               1/4     Running     0          45s
* multicluster-operators-application is running

#####
Waited 0/1200 seconds for MCH to reach Ready Status.  Current Status: Installing

Waited 30/1200 seconds for MCH to reach Ready Status.  Current Status: Installing

Waited 60/1200 seconds for MCH to reach Ready Status.  Current Status: Installing

Waited 90/1200 seconds for MCH to reach Ready Status.  Current Status: Installing
Detected ACM Console URL: https://multicloud-console.apps.oprinstall.cp.fyre.ibm.com

Waited 120/1200 seconds for MCH to reach Ready Status.  Current Status: Installing
Detected ACM Console URL: https://multicloud-console.apps.oprinstall.cp.fyre.ibm.com

Waited 150/1200 seconds for MCH to reach Ready Status.  Current Status: Installing
Detected ACM Console URL: https://multicloud-console.apps.oprinstall.cp.fyre.ibm.com

Waited 180/1200 seconds for MCH to reach Ready Status.  Current Status: Installing
Detected ACM Console URL: https://multicloud-console.apps.oprinstall.cp.fyre.ibm.com

Waited 210/1200 seconds for MCH to reach Ready Status.  Current Status: Installing
Detected ACM Console URL: https://multicloud-console.apps.oprinstall.cp.fyre.ibm.com

Waited 240/1200 seconds for MCH to reach Ready Status.  Current Status: Installing
Detected ACM Console URL: https://multicloud-console.apps.oprinstall.cp.fyre.ibm.com

MCH reached Running status after 270 seconds.
Detected ACM Console URL: https://multicloud-console.apps.oprinstall.cp.fyre.ibm.com

#####
* Red Hat ACM URL: https://multicloud-console.apps.oprinstall.cp.fyre.ibm.com
#####
Done!
{root@bandore1 deploy2.1}$
```
