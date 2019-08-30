
# 链接

First steps with KubeVirt https://www.katacoda.com/kubevirt/scenarios/kubevirt-101

# 过程

```
master $ kubectl get no
NAME     STATUS   ROLES    AGE   VERSION
master   Ready    master   83s   v1.14.0


master $ export KUBEVIRT_VERSION=$(curl -s https://api.github.com/repos/kubevirt/kubevirt/releases/latest | jq -r .tag_name)
master $ echo $KUBEVIRT_VERSION
v0.20.3
master $ kubectl create -f https://github.com/kubevirt/kubevirt/releases/download/${KUBEVIRT_VERSION}/kubevirt-operator.yaml
namespace/kubevirt created
customresourcedefinition.apiextensions.k8s.io/kubevirts.kubevirt.io created
clusterrole.rbac.authorization.k8s.io/kubevirt.io:operator created
serviceaccount/kubevirt-operator created
clusterrole.rbac.authorization.k8s.io/kubevirt-operator created
clusterrolebinding.rbac.authorization.k8s.io/kubevirt-operator created
deployment.apps/virt-operator created
master $
master $ kubectl create configmap kubevirt-config -n kubevirt --from-literal debug.useEmulation=trueconfigmap/kubevirt-config created
master $
master $ kubectl create -f https://github.com/kubevirt/kubevirt/releases/download/${KUBEVIRT_VERSION}/kubevirt-cr.yaml
kubevirt.kubevirt.io/kubevirt created
master $


master $ kubectl get pods -n kubevirt
NAME                             READY   STATUS    RESTARTS   AGE
virt-api-6979dbbc7b-4qbf7        0/1     Running   0          8s
virt-api-6979dbbc7b-lz9kl        0/1     Running   0          7s
virt-operator-6f68c44654-fm5dk   1/1     Running   0          101s
virt-operator-6f68c44654-hczdh   1/1     Running   0          101s
master $
master $
master $ kubectl get pods -n kubevirt
NAME                              READY   STATUS    RESTARTS   AGE
virt-api-6979dbbc7b-4qbf7         1/1     Running   0          42s
virt-api-6979dbbc7b-lz9kl         1/1     Running   0          41s
virt-controller-f746f8f9b-cgxtv   0/1     Running   0          21s
virt-controller-f746f8f9b-xtfzx   0/1     Running   0          21s
virt-handler-cxjt4                1/1     Running   0          21s
virt-operator-6f68c44654-fm5dk    1/1     Running   0          2m15s
virt-operator-6f68c44654-hczdh    1/1     Running   0          2m15s
master $
master $ kubectl get pods -n kubevirt
NAME                              READY   STATUS    RESTARTS   AGE
virt-api-6979dbbc7b-4qbf7         1/1     Running   0          65s
virt-api-6979dbbc7b-lz9kl         1/1     Running   0          64s
virt-controller-f746f8f9b-cgxtv   1/1     Running   0          44s
virt-controller-f746f8f9b-xtfzx   1/1     Running   0          44s
virt-handler-cxjt4                1/1     Running   0          44s
virt-operator-6f68c44654-fm5dk    1/1     Running   0          2m38s
virt-operator-6f68c44654-hczdh    1/1     Running   0          2m38s
master $


master $ wget -O virtctl https://github.com/kubevirt/kubevirt/releases/download/${KUBEVIRT_VERSION}/virtctl-${KUBEVIRT_VERSION}-linux-amd64
--2019-08-30 10:46:51--  https://github.com/kubevirt/kubevirt/releases/download/v0.20.3/virtctl-v0.20.3-linux-amd64
Resolving github.com (github.com)... 140.82.118.4
Connecting to github.com (github.com)|140.82.118.4|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://github-production-release-asset-2e65be.s3.amazonaws.com/76686583/b66fd780-c8f0-11e9-932e-4a9ac4c1fd5d?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20190830%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20190830T104652Z&X-Amz-Expires=300&X-Amz-Signature=3a36eda57690f463762c76824b71f5dffd88f93e3561916234d6ae3abb645831&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3Dvirtctl-v0.20.3-linux-amd64&response-content-type=application%2Foctet-stream [following]
--2019-08-30 10:46:51--  https://github-production-release-asset-2e65be.s3.amazonaws.com/76686583/b66fd780-c8f0-11e9-932e-4a9ac4c1fd5d?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20190830%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20190830T104652Z&X-Amz-Expires=300&X-Amz-Signature=3a36eda57690f463762c76824b71f5dffd88f93e3561916234d6ae3abb645831&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3Dvirtctl-v0.20.3-linux-amd64&response-content-type=application%2Foctet-stream
Resolving github-production-release-asset-2e65be.s3.amazonaws.com (github-production-release-asset-2e65be.s3.amazonaws.com)... 52.216.171.27
Connecting to github-production-release-asset-2e65be.s3.amazonaws.com (github-production-release-asset-2e65be.s3.amazonaws.com)|52.216.171.27|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 38674618 (37M) [application/octet-stream]
Saving to: ‘virtctl’

virtctl                  100%[==================================>]  36.88M  10.3MB/s    in 3.6s

2019-08-30 10:46:55 (10.3 MB/s) - ‘virtctl’ saved [38674618/38674618]

master $
master $ chmod +x virtctl
master $
master $ kubectl apply -f https://raw.githubusercontent.com/kubevirt/demo/master/manifests/vm.yaml
virtualmachine.kubevirt.io/testvm created
master $
master $ kubectl get vms
NAME     AGE   RUNNING   VOLUME
testvm   25s   false
master $
master $ ./virtctl start testvm
VM testvm was scheduled to start
master $
master $ kubectl get vms
NAME     AGE   RUNNING   VOLUME
testvm   53s   true
master $
master $ kubectl get vmis
NAME     AGE   PHASE        IP    NODENAME
testvm   28s   Scheduling
master $


master $ ./virtctl stop testvm
VM testvm was scheduled to stop
master $
master $ kubectl get vms
NAME     AGE   RUNNING   VOLUME
testvm   95s   false
master $
master $ kubectl delete vms testvm
virtualmachine.kubevirt.io "testvm" deleted
master $
master $ kubectl get vms
No resources found.
```
