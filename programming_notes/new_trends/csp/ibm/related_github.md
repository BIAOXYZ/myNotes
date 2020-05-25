
# 公网github

## International Business Machines https://github.com/IBM

IBM Cloud Paks are enterprise-grade containerized software by combining container images with enterprise capabilities for deployment in production use cases with integrations for management and lifecycle operations. Features such as pre-configured deployments based on product expertise, rolling upgrades, rollbacks, security/vulnerability testing… https://github.com/IBM/cloud-pak

## Open Cluster Management https://github.com/open-cluster-management

### multicloud-operators-deployable

Multicloud application management with a deployable CRD. https://github.com/open-cluster-management/multicloud-operators-deployable
- `func CheckAndInstallCRD(crdconfig *rest.Config, pathname string) error {` https://github.com/open-cluster-management/multicloud-operators-deployable/blob/1e78c3fec1/pkg/utils/kubernetes.go#L56

【:x:】
- `placementv1alpha1 "github.com/open-cluster-management/multicloud-operators-placementrule/pkg/apis/apps/v1"` https://github.com/open-cluster-management/multicloud-operators-deployable/blob/release-2.0/pkg/apis/apps/v1/deployable_types.go#L22

### multicloud-operators-subscription

CRD and controller for Subscription (Channel Subscription model) for Multicloud Application. https://github.com/open-cluster-management/multicloud-operators-subscription
- `func CheckAndInstallCRD(crdconfig *rest.Config, pathname string) error {` https://github.com/open-cluster-management/multicloud-operators-subscription/blob/6f4f30ceb6/pkg/utils/kubernetes.go#L35
- `err = CheckAndInstallCRD(cfg, "../../deploy/crds/apps.open-cluster-management.io_subscriptions_crd.yaml")` https://github.com/open-cluster-management/multicloud-operators-subscription/blob/6f4f30ceb6/pkg/utils/util_test.go#L53

【:x:】 
- `dplv1alpha1 "github.com/open-cluster-management/multicloud-operators-deployable/pkg/apis/apps/v1"` https://github.com/open-cluster-management/multicloud-operators-subscription/blob/release-2.0/pkg/apis/apps/v1/subscription_types.go#L24
- `plrv1alpha1 "github.com/open-cluster-management/multicloud-operators-placementrule/pkg/apis/apps/v1"` https://github.com/open-cluster-management/multicloud-operators-subscription/blob/release-2.0/pkg/apis/apps/v1/subscription_types.go#L25
 

## Hybrid Application Model https://github.com/hybridapp-io

Operator to deploy Hybrid Application Model https://github.com/hybridapp-io/ham-deploy

Deployable to wrap resources for Hybrid Application model https://github.com/hybridapp-io/ham-deployable-operator

## Multi Cloud Lab https://github.com/multicloudlab

Kubernetes Cluster API Provider IBM VPC Cloud 【IBM VPC Cloud (Gen2)】 https://github.com/multicloudlab/cluster-api-provider-ibmvpccloud   -->   IBM Cloud Provider for Cluster API 【IBM Cloud (Gen1 SoftLayer)】 https://github.com/kubernetes-sigs/cluster-api-provider-ibmcloud/

# 公司github

Operator to handle the compatibility of api groups between cp4mcm and RHACM https://github.ibm.com/IBMPrivateCloud/applicationcompatibility-operator
