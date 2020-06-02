
# namespace一直处于Terminating状态，但是却删不掉

【1】 How to fix — Kubernetes namespace deleting stuck in Terminating state https://medium.com/@clouddev.guru/how-to-fix-kubernetes-namespace-deleting-stuck-in-terminating-state-5ed75792647e
```sh
Step 1: Dump the descriptor as JSON to a file
``
kubectl get namespace logging -o json > logging.json
``

Open the file for editing:
``
{
    "apiVersion": "v1",
    "kind": "Namespace",
    "metadata": {
        "creationTimestamp": "2019-05-14T13:55:20Z",
        "labels": {
            "name": "logging"
        },
        "name": "logging",
        "resourceVersion": "29571918",
        "selfLink": "/api/v1/namespaces/logging",
        "uid": "e9516a8b-764f-11e9-9621-0a9c41ba9af6"
    },
    "spec": {
        "finalizers": [
            "kubernetes"
        ]
    },
    "status": {
        "phase": "Terminating"
    }
}
``

Remove kubernetes from the finalizers array:
``
{
    "apiVersion": "v1",
    "kind": "Namespace",
    "metadata": {
        "creationTimestamp": "2019-05-14T13:55:20Z",
        "labels": {
            "name": "logging"
        },
        "name": "logging",
        "resourceVersion": "29571918",
        "selfLink": "/api/v1/namespaces/logging",
        "uid": "e9516a8b-764f-11e9-9621-0a9c41ba9af6"
    },
    "spec": {
        "finalizers": [
        ]
    },
    "status": {
        "phase": "Terminating"
    }
}
``

Step 2: Executing our cleanup command
``
kubectl replace --raw "/api/v1/namespaces/logging/finalize" -f ./logging.json
``

Where: `/api/v1/namespaces/<your_namespace_here>/finalize` # 这里logging就是处于Terminating状态一直删不掉的namespace的名称
```
- 回复：
  * > This is not the right way, especially in a production environment. Today I got into the same problem. By removing the finalizer you’ll end up with leftovers in various states. You should actually find what is keeping the deletion from complete.

【2】 A namespace is stuck in the Terminating state https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.1/troubleshoot/ns_terminating.html
- > 用http接口进行删除

【3】 How to Delete a Kubernetes Namespace Stuck in the Terminating State https://success.docker.com/article/kubernetes-namespace-stuck-in-terminating
- > `kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get -n namespace name`

【4】 k8s删除Terminating状态的命名空间 https://juejin.im/post/5dada0bc5188253b2f003eff
 - > 更好的命令：`kubectl api-resources -o name --verbs=list --namespaced | xargs -n 1 kubectl get --show-kind --ignore-not-found -n <ns_name>`
 - > 有时是有workload在跑的，可以先加--force参数从kubectl强制删除一下该namespace，然后再用清理finalizer的办法就可以删掉了
 - > http接口进行删除

【5】 Kubernetes删除一直处于Terminating状态的namespace https://segmentfault.com/a/1190000016924414
- > 实际上，前面两种用json方式的删除的，完全可以直接kubectl edit，然后把finalizer字段里的kubernetes删掉即可。省得还得存json文件。

deleting namespace stuck at "Terminating" state https://github.com/kubernetes/kubernetes/issues/60807

Namespace “stuck” as Terminating, How do I remove it? https://stackoverflow.com/questions/52369247/namespace-stuck-as-terminating-how-do-i-remove-it

## 个人实战1（先看看到底有啥东西）

```sh
# multicluster-endpoint是我司的CP4MCM导入managed cluster后，会在managed cluster上创建的一个namespace。但不幸的是，前期我们只有一个集群，
## 所以只能是拿这个集群既当hub cluster，又（通过导入自己）当managed cluster。所以一导入自己，就会在managed cluster（此时也就是它自己）上
## 建这个名为multicluster-endpoint的namespace。后来先删了导入的集群，再删这个namespace时候就出了该问题：一直Terminating，但是删不掉。
## 我本来以为跟掘金那个帖子【https://juejin.im/post/5dada0bc5188253b2f003eff】一样里面没东西了，一查还真有。。。

[root@lolls-inf ~]# kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get -n multicluster-endpoint
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
NAME                                         CATALOG               AGE
kubemq-operator                              Certified Operators   4d3h
t8c-certified                                Certified Operators   4d3h
serverless-operator                          Red Hat Operators     4d3h
node-problem-detector                        Community Operators   4d3h
service-binding-operator                     Community Operators   4d3h
prometheus                                   Community Operators   4d3h
t8c                                          Community Operators   4d3h
dotscience-operator                          Certified Operators   4d3h
ripsaw                                       Community Operators   4d3h
kong                                         Certified Operators   4d3h
planetscale                                  Community Operators   4d3h
cic-operator                                 Certified Operators   4d3h
cert-utils-operator                          Community Operators   4d3h
rapidbiz-operator-certified                  Certified Operators   4d3h
teiid                                        Community Operators   4d3h
fuse-apicurito                               Red Hat Operators     4d3h
cockroachdb                                  Community Operators   4d3h
joget-openshift-operator                     Certified Operators   4d3h
apicast-operator                             Red Hat Operators     4d3h
codeready-workspaces                         Red Hat Operators     4d3h
federation                                   Community Operators   4d3h
openebs                                      Community Operators   4d3h
ibm-monitoring-grafana-operator-app          Certified Operators   4d3h
ibm-mongodb-operator-app                     Certified Operators   4d3h
presto-operator                              Certified Operators   4d3h
ocean-operator                               Certified Operators   4d3h
enmasse                                      Community Operators   4d3h
atlasmap-operator                            Community Operators   4d3h
microsegmentation-operator                   Community Operators   4d3h
aqua-operator-certified                      Certified Operators   4d3h
knative-kafka-operator                       Community Operators   4d3h
kubeturbo-marketplace-certified              Certified Operators   4d3h
here-service-operator-certified              Certified Operators   4d3h
cost-mgmt-operator                           Community Operators   4d3h
ibm-helm-repo-operator-app                   Certified Operators   4d3h
maistraoperator                              Community Operators   4d3h
ember-csi-operator                           Community Operators   4d3h
crossplane                                   Community Operators   4d3h
couchbase-enterprise-certified               Certified Operators   4d3h
eap                                          Red Hat Operators     4d3h
triggermesh                                  Community Operators   4d3h
argocd-operator-helm                         Community Operators   4d3h
microcks                                     Community Operators   4d3h
skydive-operator                             Community Operators   4d3h
special-resource-operator                    Community Operators   4d3h
traefikee-operator                           Community Operators   4d3h
hazelcast-enterprise-certified               Certified Operators   4d3h
open-enterprise-spinnaker                    Certified Operators   4d3h
open-liberty-certified                       Certified Operators   4d3h
akka-cluster-operator-certified              Certified Operators   4d3h
twistlock-certified                          Certified Operators   4d3h
zabbix-operator-certified                    Certified Operators   4d3h
tidb-operator-certified                      Certified Operators   4d3h
eddi-operator-certified                      Certified Operators   4d3h
3scale-community-operator                    Community Operators   4d3h
robin-operator                               Certified Operators   4d3h
nfd                                          Red Hat Operators     4d3h
keda                                         Community Operators   4d3h
nginx-ingress-operator                       Certified Operators   4d3h
couchdb-operator-certified                   Certified Operators   4d3h
kiali-ossm                                   Red Hat Operators     4d3h
grafana-operator                             Community Operators   4d3h
postgresql                                   Community Operators   4d3h
appranix-cps                                 Certified Operators   4d3h
sriov-network-operator                       Red Hat Operators     4d3h
spark-gcp                                    Community Operators   4d3h
storageos-10tb                               Certified Operators   4d3h
appdynamics-operator                         Certified Operators   4d3h
openshift-pipelines-operator                 Community Operators   4d3h
kube-arangodb                                Certified Operators   4d3h
esindex-operator                             Community Operators   4d3h
postgresql-operator-dev4devs-com             Community Operators   4d3h
crunchy-postgres-operator                    Certified Operators   4d3h
memql-certified                              Certified Operators   4d3h
kubefed                                      Community Operators   4d3h
halkyon                                      Community Operators   4d3h
camel-k                                      Community Operators   4d3h
multicluster-operators-subscription          Community Operators   4d3h
konveyor-operator                            Community Operators   4d3h
kubeturbo-certified                          Certified Operators   4d3h
anchore-engine                               Certified Operators   4d3h
ibm-metering-operator-app                    Certified Operators   4d3h
myvirtualdirectory                           Community Operators   4d3h
cpx-cic-operator                             Certified Operators   4d3h
local-storage-operator                       Red Hat Operators     4d3h
cluster-logging                              Red Hat Operators     4d3h
fuse-online                                  Red Hat Operators     4d3h
portshift-operator                           Certified Operators   4d3h
wavefront-operator                           Certified Operators   4d3h
newrelic-infrastructure                      Certified Operators   4d3h
ibm-helm-api-operator-app                    Certified Operators   4d3h
elasticsearch-operator                       Red Hat Operators     4d3h
nsm-operator-registry                        Community Operators   4d3h
namespace-configuration-operator             Community Operators   4d3h
hazelcast-jet-enterprise-operator            Certified Operators   4d3h
businessautomation-operator                  Red Hat Operators     4d3h
kubeturbo                                    Community Operators   4d3h
federatorai-certified                        Certified Operators   4d3h
aqua-certified                               Certified Operators   4d3h
event-streams-topic                          Community Operators   4d3h
nuodb-ce-certified                           Certified Operators   4d3h
akka-cluster-operator                        Community Operators   4d3h
jaeger                                       Community Operators   4d3h
appsody-operator-certified                   Certified Operators   4d3h
composable-operator                          Community Operators   4d3h
spinnaker-operator                           Community Operators   4d3h
amq-streams                                  Red Hat Operators     4d3h
iot-simulator                                Community Operators   4d3h
ivory-server-app                             Certified Operators   4d3h
splunk-certified                             Certified Operators   4d3h
citrix-cpx-istio-sidecar-injector-operator   Certified Operators   4d3h
amq7-cert-manager                            Red Hat Operators     4d3h
ptp-operator                                 Red Hat Operators     4d3h
aqua                                         Community Operators   4d3h
servicemeshoperator                          Red Hat Operators     4d3h
ibm-block-csi-operator                       Certified Operators   4d3h
twistlock                                    Community Operators   4d3h
sematext                                     Certified Operators   4d3h
infinispan                                   Community Operators   4d3h
xcrypt-operator                              Certified Operators   4d3h
kiali                                        Community Operators   4d3h
metering                                     Community Operators   4d3h
opendatahub-operator                         Community Operators   4d3h
hawtio-operator                              Community Operators   4d3h
insightedge-enterprise-operator2             Certified Operators   4d3h
ibm-platform-api-operator-app                Certified Operators   4d3h
k8s-triliovault                              Certified Operators   4d3h
traefikee-certified                          Certified Operators   4d3h
3scale-operator                              Red Hat Operators     4d3h
oneagent-certified                           Certified Operators   4d3h
datagrid                                     Red Hat Operators     4d3h
radanalytics-spark                           Community Operators   4d3h
apicast-community-operator                   Community Operators   4d3h
ubix-operator                                Certified Operators   4d3h
jenkins-operator                             Community Operators   4d3h
f5-bigip-ctlr-operator                       Certified Operators   4d3h
portworx-certified                           Certified Operators   4d3h
amq-online                                   Red Hat Operators     4d3h
horreum-operator                             Community Operators   4d3h
submariner                                   Community Operators   4d3h
synopsys-certified                           Certified Operators   4d3h
transadv-operator                            Certified Operators   4d3h
kubevirt-hyperconverged                      Red Hat Operators     4d3h
yugabyte-operator                            Certified Operators   4d3h
redhat-marketplace-operator                  Certified Operators   4d3h
hive-operator                                Community Operators   4d3h
joget-dx-operator                            Certified Operators   4d3h
redis-enterprise-operator-cert               Certified Operators   4d3h
nexus-operator-hub                           Community Operators   4d3h
quay                                         Community Operators   4d3h
redis-operator                               Community Operators   4d3h
strimzi-kafka-operator                       Community Operators   4d3h
perceptilabs-operator-package                Certified Operators   4d3h
awss3-operator-registry                      Community Operators   4d3h
tigera-operator                              Certified Operators   4d3h
lightbend-console-operator                   Community Operators   4d3h
keycloak-operator                            Community Operators   4d3h
ibm-auditlogging-operator-app                Certified Operators   4d3h
seldon-operator-certified                    Certified Operators   4d3h
opsmx-spinnaker-operator                     Community Operators   4d3h
must-gather-operator                         Community Operators   4d3h
ibm-management-ingress-operator-app          Certified Operators   4d3h
mongodb-enterprise                           Certified Operators   4d3h
nxrm-operator-certified                      Certified Operators   4d3h
storageos-1tb                                Certified Operators   4d3h
metering-ocp                                 Red Hat Operators     4d3h
openshiftansibleservicebroker                Red Hat Operators     4d3h
ocs-operator                                 Red Hat Operators     4d3h
knative-camel-operator                       Community Operators   4d3h
sysdig-certified                             Certified Operators   4d3h
driverlessai-deployment-operator-certified   Certified Operators   4d3h
openshifttemplateservicebroker               Red Hat Operators     4d3h
syndesis                                     Community Operators   4d3h
etcd                                         Community Operators   4d3h
cockroachdb-certified                        Certified Operators   4d3h
neuvector-certified-operator                 Certified Operators   4d3h
snyk-operator                                Community Operators   4d3h
ibm-spectrum-scale-csi                       Certified Operators   4d3h
hyperfoil-bundle                             Community Operators   4d3h
keepalived-operator                          Community Operators   4d3h
kogito-operator                              Community Operators   4d3h
planetscale-certified                        Certified Operators   4d3h
cortex-certifai-operator                     Certified Operators   4d3h
gpu-operator                                 Community Operators   4d3h
lib-bucket-provisioner                       Community Operators   4d3h
storageos                                    Certified Operators   4d3h
uma-operator                                 Certified Operators   4d3h
openunison-ocp-certified                     Certified Operators   4d3h
datadog-operator-certified                   Certified Operators   4d3h
traefikee-redhat-certified                   Certified Operators   4d3h
resource-locker-operator                     Community Operators   4d3h
apicurito                                    Community Operators   4d3h
api-operator                                 Community Operators   4d3h
citrix-adc-istio-ingress-gateway-operator    Certified Operators   4d3h
csi-operator                                 Community Operators   4d3h
csi-driver-operator                          Certified Operators   4d3h
amq7-interconnect-operator                   Red Hat Operators     4d3h
jaeger-product                               Red Hat Operators     4d3h
instana-agent                                Certified Operators   4d3h
percona-server-mongodb-operator-certified    Certified Operators   4d3h
cam-operator                                 Red Hat Operators     4d3h
descheduler                                  Community Operators   4d3h
knative-eventing-operator                    Community Operators   4d3h
seldon-operator                              Community Operators   4d3h
federatorai                                  Community Operators   4d3h
argocd-operator                              Community Operators   4d3h
orca                                         Certified Operators   4d3h
container-security-operator                  Community Operators   4d3h
codeready-toolchain-operator                 Community Operators   4d3h
kubestone                                    Community Operators   4d3h
eclipse-che                                  Community Operators   4d3h
runtime-component-operator-certified         Certified Operators   4d3h
amq-broker                                   Red Hat Operators     4d3h
egressip-ipam-operator                       Community Operators   4d3h
ibmcloud-operator                            Community Operators   4d3h
percona-xtradb-cluster-operator-certified    Certified Operators   4d3h
openshiftartifactoryha-operator              Certified Operators   4d3h
dv-operator                                  Red Hat Operators     4d3h
ibm-spectrum-scale-csi-operator              Community Operators   4d3h
neuvector-community-operator                 Community Operators   4d3h
cortex-operator                              Certified Operators   4d3h
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
No resources found in multicluster-endpoint namespace.
[root@lolls-inf ~]#

```

## 个人实战2（实战删除）

### hub (cluser) 上的 multicluster-endpoint

```sh
#// 查查Terminating的namespace的具体信息。发现和这个里的描述有些相似：
#// Bug 1768820 - Projects get stuck in Terminating status with "object *v1beta1.ServiceBindingList does not implement the protobuf marshalling interface and cannot be encoded to a protobuf message ..." https://bugzilla.redhat.com/show_bug.cgi?id=1768820
[root@lolls-inf ~]# kubectl get namespace multicluster-endpoint -o yaml
apiVersion: v1
kind: Namespace
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Namespace","metadata":{"annotations":{},"creationTimestamp":null,"name":"multicluster-endpoint"},"spec":{},"status":{}}
    mcm.ibm.com/accountID: id-mycluster-account
    mcm.ibm.com/type: System
    openshift.io/sa.scc.mcs: s0:c25,c0
    openshift.io/sa.scc.supplemental-groups: 1000600000/10000
    openshift.io/sa.scc.uid-range: 1000600000/10000
  creationTimestamp: "2020-04-16T13:15:31Z"
  deletionTimestamp: "2020-04-17T07:57:22Z"
  name: multicluster-endpoint
  resourceVersion: "43698995"
  selfLink: /api/v1/namespaces/multicluster-endpoint
  uid: 756bdf85-7ae3-490f-b207-10c01a7a70e6
spec:
  finalizers:
  - kubernetes
status:
  conditions:
  - lastTransitionTime: "2020-06-01T18:24:42Z"
    message: All resources successfully discovered
    reason: ResourcesDiscovered
    status: "False"
    type: NamespaceDeletionDiscoveryFailure
  - lastTransitionTime: "2020-04-17T07:57:30Z"
    message: All legacy kube types successfully parsed
    reason: ParsedGroupVersions
    status: "False"
    type: NamespaceDeletionGroupVersionParsingFailure
  - lastTransitionTime: "2020-06-01T18:24:42Z"
    message: 'Failed to delete all resource types, 7 remaining: object *v1alpha1.ClusterList
      does not implement the protobuf marshalling interface and cannot be encoded
      to a protobuf message, object *v1alpha1.ClusterStatusList does not implement
      the protobuf marshalling interface and cannot be encoded to a protobuf message,
      object *v1alpha1.PlacementBindingList does not implement the protobuf marshalling
      interface and cannot be encoded to a protobuf message, object *v1alpha1.PlacementPolicyList
      does not implement the protobuf marshalling interface and cannot be encoded
      to a protobuf message, object *v1alpha1.ResourceViewList does not implement
      the protobuf marshalling interface and cannot be encoded to a protobuf message,
      object *v1alpha1.WorkList does not implement the protobuf marshalling interface
      and cannot be encoded to a protobuf message, object *v1alpha1.WorkSetList does
      not implement the protobuf marshalling interface and cannot be encoded to a
      protobuf message'
    reason: ContentDeletionFailed
    status: "True"
    type: NamespaceDeletionContentFailure
  - lastTransitionTime: "2020-04-17T07:58:13Z"
    message: All content successfully removed
    reason: ContentRemoved
    status: "False"
    type: NamespaceContentRemaining
  - lastTransitionTime: "2020-04-17T07:57:30Z"
    message: All content-preserving finalizers finished
    reason: ContentHasNoFinalizers
    status: "False"
    type: NamespaceFinalizersRemaining
  phase: Terminating
[root@lolls-inf ~]#


#// 强删 multicluster-endpoint 并成功
[root@lolls-inf uninstall]# kubectl get namespace multicluster-endpoint -o json > terminating_multicluster_endpoint.json
[root@lolls-inf uninstall]#
[root@lolls-inf uninstall]# cp terminating_multicluster_endpoint.json terminating_multicluster_endpoint2.json
[root@lolls-inf uninstall]#
[root@lolls-inf uninstall]# vi terminating_multicluster_endpoint2.json
[root@lolls-inf uninstall]#
[root@lolls-inf uninstall]#
[root@lolls-inf uninstall]# kubectl replace --raw "/api/v1/namespaces/multicluster-endpoint/finalize" -f terminating_multicluster_endpoint2.json
{"kind":"Namespace","apiVersion":"v1","metadata":{"name":"multicluster-endpoint","selfLink":"/api/v1/namespaces/multicluster-endpoint/finalize","uid":"756bdf85-7ae3-490f-b207-10c01a7a70e6","resourceVersion":"43698995","creationTimestamp":"2020-04-16T13:15:31Z","deletionTimestamp":"2020-04-17T07:57:22Z","annotations":{"kubectl.kubernetes.io/last-applied-configuration":"{\"apiVersion\":\"v1\",\"kind\":\"Namespace\",\"metadata\":{\"annotations\":{},\"creationTimestamp\":null,\"name\":\"multicluster-endpoint\"},\"spec\":{},\"status\":{}}\n","mcm.ibm.com/accountID":"id-mycluster-account","mcm.ibm.com/type":"System","openshift.io/sa.scc.mcs":"s0:c25,c0","openshift.io/sa.scc.supplemental-groups":"1000600000/10000","openshift.io/sa.scc.uid-range":"1000600000/10000"}},"spec":{},"status":{"phase":"Terminating","conditions":[{"type":"NamespaceDeletionDiscoveryFailure","status":"False","lastTransitionTime":"2020-06-01T18:24:42Z","reason":"ResourcesDiscovered","message":"All resources successfully discovered"},{"type":"NamespaceDeletionGroupVersionParsingFailure","status":"False","lastTransitionTime":"2020-04-17T07:57:30Z","reason":"ParsedGroupVersions","message":"All legacy kube types successfully parsed"},{"type":"NamespaceDeletionContentFailure","status":"True","lastTransitionTime":"2020-06-01T18:24:42Z","reason":"ContentDeletionFailed","message":"Failed to delete all resource types, 7 remaining: object *v1alpha1.ClusterList does not implement the protobuf marshalling interface and cannot be encoded to a protobuf message, object *v1alpha1.ClusterStatusList does not implement the protobuf marshalling interface and cannot be encoded to a protobuf message, object *v1alpha1.PlacementBindingList does not implement the protobuf marshalling interface and cannot be encoded to a protobuf message, object *v1alpha1.PlacementPolicyList does not implement the protobuf marshalling interface and cannot be encoded to a protobuf message, object *v1alpha1.ResourceViewList does not implement the protobuf marshalling interface and cannot be encoded to a protobuf message, object *v1alpha1.WorkList does not implement the protobuf marshalling interface and cannot be encoded to a protobuf message, object *v1alpha1.WorkSetList does not implement the protobuf marshalling interface and cannot be encoded to a protobuf message"},{"type":"NamespaceContentRemaining","status":"False","lastTransitionTime":"2020-04-17T07:58:13Z","reason":"ContentRemoved","message":"All content successfully removed"},{"type":"NamespaceFinalizersRemaining","status":"False","lastTransitionTime":"2020-04-17T07:57:30Z","reason":"ContentHasNoFinalizers","message":"All content-preserving finalizers finished"}]}}
[root@lolls-inf uninstall]#
[root@lolls-inf uninstall]# kubectl get ns | grep multicluster-endpoint
[root@lolls-inf uninstall]#
```

### managed cluser 上的 multicluster-endpoint

```sh
# 上面那个是在CP4MCM的hub上，下面这个在managed cluster上的multicluster-endpoint namespace用这种方法开始没成功。。。
# 后来发现应该是还有workload在的原因，于是 kubectl delete ns <ns_name> --force --grace-period=0 先强制删除一下workload，再用上面方法就成功了。


#// 这里的 multicluster-endpoint 就和上面那个情况不太一样，这里提示的这个namespace下还有些workloads。
[root@anaemia-inf uninstall]# oc get ns multicluster-endpoint -o yaml
apiVersion: v1
kind: Namespace
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Namespace","metadata":{"annotations":{},"creationTimestamp":null,"name":"multicluster-endp
    openshift.io/sa.scc.mcs: s0:c23,c17
    openshift.io/sa.scc.supplemental-groups: 1000540000/10000
    openshift.io/sa.scc.uid-range: 1000540000/10000
  creationTimestamp: "2020-04-17T09:05:42Z"
  deletionTimestamp: "2020-06-02T05:06:28Z"
  name: multicluster-endpoint
  resourceVersion: "24076610"
  selfLink: /api/v1/namespaces/multicluster-endpoint
  uid: 0e66a812-cd27-4717-aa3d-c19a39acbee0
spec:
  finalizers:
  - kubernetes
status:
  conditions:
  - lastTransitionTime: "2020-06-02T05:06:40Z"
    message: All resources successfully discovered
    reason: ResourcesDiscovered
    status: "False"
    type: NamespaceDeletionDiscoveryFailure
  - lastTransitionTime: "2020-06-02T05:06:40Z"
    message: All legacy kube types successfully parsed
    reason: ParsedGroupVersions
    status: "False"
    type: NamespaceDeletionGroupVersionParsingFailure
  - lastTransitionTime: "2020-06-02T05:07:20Z"
    message: All content successfully deleted, may be waiting on finalization
    reason: ContentDeleted
    status: "False"
    type: NamespaceDeletionContentFailure
  - lastTransitionTime: "2020-06-02T05:06:40Z"
    message: 'Some resources are remaining: applicationmanagers.multicloud.ibm.com
      has 1 resource instances, certmanagers.multicloud.ibm.com has 1 resource instances,
      connectionmanagers.multicloud.ibm.com has 1 resource instances, endpoints.multicloud.ibm.com
      has 1 resource instances, policycontrollers.multicloud.ibm.com has 1 resource
      instances, searchcollectors.multicloud.ibm.com has 1 resource instances, serviceregistries.multicloud.ibm.com
      has 1 resource instances, tillers.multicloud.ibm.com has 1 resource instances,
      topologycollectors.multicloud.ibm.com has 1 resource instances, workmanagers.multicloud.ibm.com
      has 1 resource instances'
    reason: SomeResourcesRemain
    status: "True"
    type: NamespaceContentRemaining
  - lastTransitionTime: "2020-06-02T05:06:40Z"
    message: 'Some content in the namespace has finalizers remaining: endpoint-appmgr
      in 1 resource instances, endpoint-certmgr in 1 resource instances, endpoint-connmgr
      in 1 resource instances, endpoint-policyctrl in 1 resource instances, endpoint-search
      in 1 resource instances, endpoint-svcreg in 1 resource instances, endpoint-tiller
      in 1 resource instances, endpoint-topology in 1 resource instances, endpoint-workmgr
      in 1 resource instances, uninstall-helm-release in 9 resource instances'
    reason: SomeFinalizersRemain
    status: "True"
    type: NamespaceFinalizersRemaining
  phase: Terminating
[root@anaemia-inf uninstall]# 


#// 还是跟上面一样的步骤，但是结果尴尬了。。。没删掉。。。
[root@anaemia-inf uninstall]# kubectl get namespace multicluster-endpoint -o json > terminating_multicluster_endpoint.json
[root@anaemia-inf uninstall]# cp terminating_multicluster_endpoint.json terminating_multicluster_endpoint2.json
[root@anaemia-inf uninstall]# vi terminating_multicluster_endpoint.json
[root@anaemia-inf uninstall]# kubectl replace --raw "/api/v1/namespaces/multicluster-endpoint/finalize" -f terminating_multicluster_endpoint2.json
{"kind":"Namespace","apiVersion":"v1","metadata":{"name":"multicluster-endpoint","selfLink":"/api/v1/namespaces/multicluster-endpoint/finalize","uid":"0e66a812-cd27-4717-aa3d-c19a39acbee0","resourceVersion":"24076610","creationTimestamp":"2020-04-17T09:05:42Z","deletionTimestamp":"2020-06-02T05:06:28Z","annotations":{"kubectl.kubernetes.io/last-applied-configuration":"{\"apiVersion\":\"v1\",\"kind\":\"Namespace\",\"metadata\":{\"annotations\":{},\"creationTimestamp\":null,\"name\":\"multicluster-endpoint\"},\"spec\":{},\"status\":{}}\n","openshift.io/sa.scc.mcs":"s0:c23,c17","openshift.io/sa.scc.supplemental-groups":"1000540000/10000","openshift.io/sa.scc.uid-range":"1000540000/10000"}},"spec":{"finalizers":["kubernetes"]},"status":{"phase":"Terminating","conditions":[{"type":"NamespaceDeletionDiscoveryFailure","status":"False","lastTransitionTime":"2020-06-02T05:06:40Z","reason":"ResourcesDiscovered","message":"All resources successfully discovered"},{"type":"NamespaceDeletionGroupVersionParsingFailure","status":"False","lastTransitionTime":"2020-06-02T05:06:40Z","reason":"ParsedGroupVersions","message":"All legacy kube types successfully parsed"},{"type":"NamespaceDeletionContentFailure","status":"False","lastTransitionTime":"2020-06-02T05:07:20Z","reason":"ContentDeleted","message":"All content successfully deleted, may be waiting on finalization"},{"type":"NamespaceContentRemaining","status":"True","lastTransitionTime":"2020-06-02T05:06:40Z","reason":"SomeResourcesRemain","message":"Some resources are remaining: applicationmanagers.multicloud.ibm.com has 1 resource instances, certmanagers.multicloud.ibm.com has 1 resource instances, connectionmanagers.multicloud.ibm.com has 1 resource instances, endpoints.multicloud.ibm.com has 1 resource instances, policycontrollers.multicloud.ibm.com has 1 resource instances, searchcollectors.multicloud.ibm.com has 1 resource instances, serviceregistries.multicloud.ibm.com has 1 resource instances, tillers.multicloud.ibm.com has 1 resource instances, topologycollectors.multicloud.ibm.com has 1 resource instances, workmanagers.multicloud.ibm.com has 1 resource instances"},{"type":"NamespaceFinalizersRemaining","status":"True","lastTransitionTime":"2020-06-02T05:06:40Z","reason":"SomeFinalizersRemain","message":"Some content in the namespace has finalizers remaining: endpoint-appmgr in 1 resource instances, endpoint-certmgr in 1 resource instances, endpoint-connmgr in 1 resource instances, endpoint-policyctrl in 1 resource instances, endpoint-search in 1 resource instances, endpoint-svcreg in 1 resource instances, endpoint-tiller in 1 resource instances, endpoint-topology in 1 resource instances, endpoint-workmgr in 1 resource instances, uninstall-helm-release in 9 resource instances"}]}}
[root@anaemia-inf uninstall]#
[root@anaemia-inf uninstall]# kubectl get ns | grep multicluster-endpoint
multicluster-endpoint                                   Terminating   46d
[root@anaemia-inf uninstall]#


#// 换用http方式也一样没删掉。。。
[root@anaemia-inf uninstall]# curl -k -H "Content-Type: application/json" -X PUT --data-binary @terminating_multicluster_en001/api/v1/namespaces/multicluster-endpoint/finalize
{
  "kind": "Namespace",
  "apiVersion": "v1",
  "metadata": {
    "name": "multicluster-endpoint",
    "selfLink": "/api/v1/namespaces/multicluster-endpoint/finalize",
    "uid": "0e66a812-cd27-4717-aa3d-c19a39acbee0",
    "resourceVersion": "24076610",
    "creationTimestamp": "2020-04-17T09:05:42Z",
    "deletionTimestamp": "2020-06-02T05:06:28Z",
    "annotations": {
      "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Namespace\",\"metadata\":{\"anamp\":null,\"name\":\"multicluster-endpoint\"},\"spec\":{},\"status\":{}}\n",
      "openshift.io/sa.scc.mcs": "s0:c23,c17",
      "openshift.io/sa.scc.supplemental-groups": "1000540000/10000",
      "openshift.io/sa.scc.uid-range": "1000540000/10000"
    }
  },
  "spec": {
    "finalizers": [
      "kubernetes"
    ]
  },
  "status": {
    "phase": "Terminating",
    "conditions": [
      {
        "type": "NamespaceDeletionDiscoveryFailure",
        "status": "False",
        "lastTransitionTime": "2020-06-02T05:06:40Z",
        "reason": "ResourcesDiscovered",
        "message": "All resources successfully discovered"
      },
      {
        "type": "NamespaceDeletionGroupVersionParsingFailure",
        "status": "False",
        "lastTransitionTime": "2020-06-02T05:06:40Z",
        "reason": "ParsedGroupVersions",
        "message": "All legacy kube types successfully parsed"
      },
      {
        "type": "NamespaceDeletionContentFailure",
        "status": "False",
        "lastTransitionTime": "2020-06-02T05:07:20Z",
        "reason": "ContentDeleted",
        "message": "All content successfully deleted, may be waiting on finalization"
      },
      {
        "type": "NamespaceContentRemaining",
        "status": "True",
        "lastTransitionTime": "2020-06-02T05:06:40Z",
        "reason": "SomeResourcesRemain",
        "message": "Some resources are remaining: applicationmanagers.multicloud.ibm.com has 1 resource instances, certmanaesource instances, connectionmanagers.multicloud.ibm.com has 1 resource instances, endpoints.multicloud.ibm.com has 1 resous.multicloud.ibm.com has 1 resource instances, searchcollectors.multicloud.ibm.com has 1 resource instances, serviceregistrsource instances, tillers.multicloud.ibm.com has 1 resource instances, topologycollectors.multicloud.ibm.com has 1 resourceloud.ibm.com has 1 resource instances"
      },
      {
        "type": "NamespaceFinalizersRemaining",
        "status": "True",
        "lastTransitionTime": "2020-06-02T05:06:40Z",
        "reason": "SomeFinalizersRemain",
        "message": "Some content in the namespace has finalizers remaining: endpoint-appmgr in 1 resource instances, endpoices, endpoint-connmgr in 1 resource instances, endpoint-policyctrl in 1 resource instances, endpoint-search in 1 resource iresource instances, endpoint-tiller in 1 resource instances, endpoint-topology in 1 resource instances, endpoint-workmgr inl-helm-release in 9 resource instances"
      }
    ]
  }
}[root@anaemia-inf uninstall]#
[root@anaemia-inf uninstall]#
[root@anaemia-inf uninstall]# kubectl get ns | grep multicluster-endpoint
multicluster-endpoint                                   Terminating   46d
[root@anaemia-inf uninstall]#


#// 从掘金那个链接【4】里得到启发，想着先清除一下workload说不定就行了。
#// 但是那么多workload，手动清不现实。于是就用这个语句让系统自己清。清完再用之前的方法就成功了。
[root@anaemia-inf uninstall]# kubectl delete ns multicluster-endpoint --force --grace-period=0
warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may indefinitely.
namespace "multicluster-endpoint" force deleted
^C
[root@anaemia-inf uninstall]#
[root@anaemia-inf uninstall]#
[root@anaemia-inf uninstall]# kubectl replace --raw "/api/v1/namespaces/multicluster-endpoint/finalize" -f terminating_multicluster_endpoint2.json
{"kind":"Namespace","apiVersion":"v1","metadata":{"name":"multicluster-endpoint","selfLink":"/api/v1/namespaces/multicluste6a812-cd27-4717-aa3d-c19a39acbee0","resourceVersion":"24076610","creationTimestamp":"2020-04-17T09:05:42Z","deletionTimestaotations":{"kubectl.kubernetes.io/last-applied-configuration":"{\"apiVersion\":\"v1\",\"kind\":\"Namespace\",\"metadata\":{mestamp\":null,\"name\":\"multicluster-endpoint\"},\"spec\":{},\"status\":{}}\n","openshift.io/sa.scc.mcs":"s0:c23,c17","opgroups":"1000540000/10000","openshift.io/sa.scc.uid-range":"1000540000/10000"}},"spec":{},"status":{"phase":"Terminating","DeletionDiscoveryFailure","status":"False","lastTransitionTime":"2020-06-02T05:06:40Z","reason":"ResourcesDiscovered","messy discovered"},{"type":"NamespaceDeletionGroupVersionParsingFailure","status":"False","lastTransitionTime":"2020-06-02T05:0sions","message":"All legacy kube types successfully parsed"},{"type":"NamespaceDeletionContentFailure","status":"False","l05:07:20Z","reason":"ContentDeleted","message":"All content successfully deleted, may be waiting on finalization"},{"type":atus":"True","lastTransitionTime":"2020-06-02T05:06:40Z","reason":"SomeResourcesRemain","message":"Some resources are remaicloud.ibm.com has 1 resource instances, certmanagers.multicloud.ibm.com has 1 resource instances, connectionmanagers.multictances, endpoints.multicloud.ibm.com has 1 resource instances, policycontrollers.multicloud.ibm.com has 1 resource instanceibm.com has 1 resource instances, serviceregistries.multicloud.ibm.com has 1 resource instances, tillers.multicloud.ibm.comlogycollectors.multicloud.ibm.com has 1 resource instances, workmanagers.multicloud.ibm.com has 1 resource instances"},{"tyng","status":"True","lastTransitionTime":"2020-06-02T05:06:40Z","reason":"SomeFinalizersRemain","message":"Some content in maining: endpoint-appmgr in 1 resource instances, endpoint-certmgr in 1 resource instances, endpoint-connmgr in 1 resource in 1 resource instances, endpoint-search in 1 resource instances, endpoint-svcreg in 1 resource instances, endpoint-tiller nt-topology in 1 resource instances, endpoint-workmgr in 1 resource instances, uninstall-helm-release in 9 resource instanc
[root@anaemia-inf uninstall]#
[root@anaemia-inf uninstall]# kubectl get ns | grep multicluster-endpoint
[root@anaemia-inf uninstall]#
```
