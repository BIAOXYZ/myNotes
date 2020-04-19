
# namespace一直处于Terminating状态，但是却删不掉

How to fix — Kubernetes namespace deleting stuck in Terminating state https://medium.com/@clouddev.guru/how-to-fix-kubernetes-namespace-deleting-stuck-in-terminating-state-5ed75792647e
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

deleting namespace stuck at "Terminating" state https://github.com/kubernetes/kubernetes/issues/60807

A namespace is stuck in the Terminating state https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.1/troubleshoot/ns_terminating.html

k8s删除Terminating状态的命名空间 https://juejin.im/post/5dada0bc5188253b2f003eff

Kubernetes删除一直处于Terminating状态的namespace https://segmentfault.com/a/1190000016924414

Namespace “stuck” as Terminating, How do I remove it? https://stackoverflow.com/questions/52369247/namespace-stuck-as-terminating-how-do-i-remove-it

How to Delete a Kubernetes Namespace Stuck in the Terminating State https://success.docker.com/article/kubernetes-namespace-stuck-in-terminating

## 个人实战

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
