
# `patch` v.s. `update`

kubernetes update跟patch区别 https://fafucoder.github.io/2020/09/09/kubernetes-update-patch/

你不了解的K8s资源更新机制，从一个OpenKruise用户疑问开始 https://developer.aliyun.com/article/763212
- > **更新原理**
  * > 其实，对一个 Kubernetes 资源对象做“更新”操作，简单来说就是通知 kube-apiserver 组件我们希望如何修改这个对象。而 K8s 为这类需求定义了两种“通知”方式，分别是 update 和 patch。***在 `update` 请求中，我们需要将整个修改后的对象提交给 K8s；而对于 `patch` 请求，我们只需要将对象中某些字段的修改提交给 K8s***。
- > **Update 机制**
  * > Kubernetes 中的所有资源对象，都有一个全局唯一的版本号（metadata.resourceVersion）。每个资源对象从创建开始就会有一个版本号，而后每次被修改（***不管是 `update` 还是 `patch` 修改***），版本号都会发生变化。
  * > K8s 要求用户 update 请求中提交的对象必须带有 resourceVersion，也就是说我们提交 update 的数据必须先来源于 K8s 中已经存在的对象。因此，一次完整的 update 操作流程是：
  * > ![](https://ata2-img.cn-hangzhou.oss-pub.aliyun-inc.com/1061e09f5b594289771a74e7558ffc1a.png)
- > **Patch 机制**
  * > 相比于 update 的版本控制，K8s 的 patch 机制则显得更加简单。
  * > 当用户对某个资源对象提交一个 patch 请求时，kube-apiserver 不会考虑版本问题，而是“无脑”地接受用户的请求（只要请求发送的 patch 内容合法），也就是将 patch 打到对象上、同时更新版本号。
  * > 不过，patch 的复杂点在于，目前 K8s 提供了 4 种 patch 策略：`json patch`、`merge patch`、`strategic merge patch`、`apply patch`（从 K8s 1.14 支持 server-side apply 开始）。通过 `kubectl patch -h` 命令我们也可以看到这个策略选项（***默认采用 strategic***）：

# kubectl patch官方页面

使用 kubectl patch 更新 API 对象 https://v1-14.docs.kubernetes.io/zh/docs/tasks/run-application/update-api-object-kubectl-patch/ || https://v1-18.docs.kubernetes.io/zh/docs/tasks/run-application/update-api-object-kubectl-patch/ |||| Update API Objects in Place Using kubectl patch https://v1-18.docs.kubernetes.io/docs/tasks/run-application/update-api-object-kubectl-patch/
- > 有关 JSON patch 和 JSON 合并 patch 的比较，查看 JSON patch 和 JSON 合并 patch。
  * JSON Patch and JSON Merge Patch http://erosb.github.io/post/json-patch-vs-merge-patch/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# patch CR

## patcch CR失败的问题

kubectl patch servicemonitor fails with UnsupportedMediaType https://github.com/kubernetes/kubernetes/issues/71024
- https://github.com/kubernetes/kubernetes/issues/71024#issuecomment-438743207
  * > Can you try: `kubectl patch servicemonitor prometheus-prometheus-oper-kubelet --patch "$(cat kubelet-cadvisor-patch.yaml)" --type=merge`? The default type is strategic which is indeed unsupported for CRs
>> //notes：从这个issue看目前默认的patch策略还不能patch自己添加到系统里的custom resource definition对应的CR，但是加上`--type=merge`就可以了。

## 但是后来发现应该只是不能用默认类型的kubectl patch语句去patch CR，别的patch类型（如replace）可以

该教程 https://www.katacoda.com/openshift/courses/operatorframework/go-operator-podset 最后一页
```sh
$ oc create -f deploy/crds/app.example.com_v1alpha1_podset_cr.yaml
podset.app.example.com/example-podset created
$ 
$ oc get podset example-podset -o yaml
apiVersion: app.example.com/v1alpha1
kind: PodSet
metadata:
  creationTimestamp: "2020-04-26T18:03:26Z"
  generation: 1
  name: example-podset
  namespace: myproject
  resourceVersion: "243889"
  selfLink: /apis/app.example.com/v1alpha1/namespaces/myproject/podsets/example-podset
  uid: 3a469c87-87e8-11ea-b41d-0242ac11000d
spec:
  replicas: 3
status:
  podNames:
  - example-podset-podfhjxq
  - example-podset-podcfv52
  - example-podset-pod55lbd
$
$ oc patch podset example-podset --type='json' -p '[{"op": "replace", "path": "/spec/replicas", "value":5}]'
podset.app.example.com/example-podset patched
$
$ oc get podset example-podset -o yaml
apiVersion: app.example.com/v1alpha1
kind: PodSet
metadata:
  creationTimestamp: "2020-04-26T18:03:26Z"
  generation: 2
  name: example-podset
  namespace: myproject
  resourceVersion: "244093"
  selfLink: /apis/app.example.com/v1alpha1/namespaces/myproject/podsets/example-podset
  uid: 3a469c87-87e8-11ea-b41d-0242ac11000d
spec:
  replicas: 5
status:
  podNames:
  - example-podset-podfhjxq
  - example-podset-podcfv52
  - example-podset-pod55lbd
  - example-podset-podgw9qn
  - example-podset-podngzdc
$

// oc和kubectl没多大区别，所以这里后面没在查了，肯定是可以的。
$ kubectl patch podset example-podset --type='json' -p '[{"op": "replace", "path": "/spec/replicas", "value":4}]'
podset.app.example.com/example-podset patched
$
```

## 关于patch语句的单引号和双引号选择，以及写脚本时的小技巧

```sh
# 如下所示，可以用jsonpath的形式直接查出replicas的数量
oc get deployables.apps.open-cluster-management.io testdeploy -o jsonpath={.spec.template.spec.replicas}

{root@bandore1 ~}$ oc get deployables.apps.open-cluster-management.io testdeploy -o jsonpath={.spec.template.spec.replicas}
3{root@bandore1 ~}$
{root@bandore1 ~}$ echo `oc get deployables.apps.open-cluster-management.io testdeploy -o jsonpath={.spec.template.spec.replicas}`
3


# 以下两个（replace类型的）patch语句都正确，但最常见的是第一种（也就是最后中括号部分最外面是单引号，里面的字符串类型字段用双引号）。
oc patch deployables.apps.open-cluster-management.io testdeploy --type='json' -p '[{"op": "replace", "path": "/spec/template/spec/replicas", "value":4}]'
oc patch deployables.apps.open-cluster-management.io testdeploy --type='json' -p "[{'op': 'replace', 'path': '/spec/template/spec/replicas', 'value':4}]"

# 但是其实第一种在写脚本时，如果碰到patch语句里带有变量时不好处理。
# 下面是一个小脚本，目的是每隔一分钟查询下当前这个CR instance的replicas的数量，并在原数值的基础上patch一下，加上1。
# 如果用了第一种方式，会发现变量i没法成功转义，结果patch出来的是 "replicas: $i"，这肯定不行。
# 原因当然很简单，就是shell脚本里单引号不会把里面的变量转义。所以我们用第二种patch语句就可以完美解决该问题。就不再贴结果了，
# 下面脚本保存成 auto_update_replica_num.sh 后，直接 nohup ./auto_update_replica_num.sh & 后台运行，可以达到目的。
``
#!/bin/sh
POD_GROUP='deployables.apps.open-cluster-management.io'
POD_NAME='testdeploy'
while true;
do 
  i=`oc get $POD_GROUP $POD_NAME -o jsonpath={.spec.template.spec.replicas}`
  i=`expr $i + 1`
  ###oc patch $POD_GROUP $POD_NAME --type='json' -p '[{"op": "replace", "path": "/spec/template/spec/replicas", "value":$i}]'
  oc patch $POD_GROUP $POD_NAME --type='json' -p "[{'op': 'replace', 'path': '/spec/template/spec/replicas', 'value':$i}]"
  sleep 60
done
``


# 最后就是：对于自定义对象用默认的patch策略是不行的，可以像上面一样用replace策略来patch。
# 但是其实最简单的办法是加上 --type=merge 参数就行。 
{root@bandore1 ~}$ oc patch deployables.apps.open-cluster-management.io testdeploy -p '{"spec":{"template":{"spec":{"replicas":5}}}}'
Error from server (UnsupportedMediaType): the body of the request was in an unknown format - accepted media types include: application/json-patch+json, application/merge-patch+json, application/apply-patch+yaml
{root@bandore1 ~}$
{root@bandore1 ~}$
{root@bandore1 ~}$ oc patch deployables.apps.open-cluster-management.io testdeploy -p '{"spec":{"template":{"spec":{"replicas":5}}}}' --type=merge
deployable.apps.open-cluster-management.io/testdeploy patched
{root@bandore1 ~}$
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# patch Service

## patch service from clusterIP to NodePort

Updating running Kubernetes resources from the kubectl commandline using the patch command https://technology.amis.nl/2019/03/26/updating-running-kubernetes-resources-from-the-kubectl-commandline-using-the-patch-command/

```yml
[root@temptest ~]# kubectl edit svc kubernetes-dashboard -n kubernetes-dashboard
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: v1
kind: Service
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"labels":{"k8s-app":"kubernetes-dashboard"},"name":"kubernetes-dashboard","namespace":"kubernetes-dashboard"},"spec":{"ports":[{"port":443,"targetPort":8443}],"selector":{"k8s-app":"kubernetes-dashboard"}}}
  creationTimestamp: "2019-10-17T06:22:32Z"
  labels:
    k8s-app: kubernetes-dashboard
  name: kubernetes-dashboard
  namespace: kubernetes-dashboard
  resourceVersion: "5243311"
  selfLink: /api/v1/namespaces/kubernetes-dashboard/services/kubernetes-dashboard
  uid: d09dec1b-673d-4b8a-a198-bed2dd9ff3c9
spec:
  clusterIP: 10.102.169.149
  ports:
  - port: 443
    protocol: TCP
    targetPort: 8443
  selector:
    k8s-app: kubernetes-dashboard
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}

"/tmp/kubectl-edit-njdgn.yaml" 30L, 1113C


[root@temptest ~]# kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard -p '{"spec": {"type": "NodePort"}}'
service/kubernetes-dashboard patched


[root@temptest ~]# kubectl edit svc kubernetes-dashboard -n kubernetes-dashboard
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: v1
kind: Service
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"labels":{"k8s-app":"kubernetes-dashboard"},"name":"kubernetes-dashboard","namespace":"kubernetes-dashboard"},"spec":{"ports":[{"port":443,"targetPort":8443}],"selector":{"k8s-app":"kubernetes-dashboard"}}}
  creationTimestamp: "2019-10-17T06:22:32Z"
  labels:
    k8s-app: kubernetes-dashboard
  name: kubernetes-dashboard
  namespace: kubernetes-dashboard
  resourceVersion: "5245626"
  selfLink: /api/v1/namespaces/kubernetes-dashboard/services/kubernetes-dashboard
  uid: d09dec1b-673d-4b8a-a198-bed2dd9ff3c9
spec:
  clusterIP: 10.102.169.149
  externalTrafficPolicy: Cluster
  ports:
  - nodePort: 31367
    port: 443
    protocol: TCP
    targetPort: 8443
  selector:
    k8s-app: kubernetes-dashboard
  sessionAffinity: None
  type: NodePort
status:
  loadBalancer: {}

"/tmp/kubectl-edit-1she7.yaml" 32L, 1165C
```

## 另一种更全面的patch service的方法

kubectl - How to edit service spec type to LoadBalancer via command line? https://stackoverflow.com/questions/51559159/kubectl-how-to-edit-service-spec-type-to-loadbalancer-via-command-line
>> 至少经过验证，下面这个答案是可以的。这个答案里的patch语句内容更全，而且好像开了http的端口（之前的dashboard只有https的端口貌似）
```sh
You can't remove the existing port, but you can add the HTTPs port and also change the type using kubectl patch

Example:

kubectl patch svc <my_service> -p '{"spec": {"ports": [{"port": 443,"targetPort": 443,"name": "https"},{"port": 80,"targetPort": 80,"name": "http"}],"type": "LoadBalancer"}}'

----------------------------------------------------------------------------------------------------

$ kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard -p '{"spec": {"ports": [{"port": 443,"targetPort": 443,"name": "https"},{"port": 80,"targetPort": 80,"name": "http"}],"type": "LoadBalancer"}}'
service/kubernetes-dashboard patched
$

#// 不再展示查询结果了，反正成功了。
#// 然后用上面那个patch回去。

$ kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard -p '{"spec": {"type": "NodePort"}}'
service/kubernetes-dashboard patched
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# patch Pod

## patch pod metadata

强制删除 StatefulSet 类型的 Pods https://v1-18.docs.kubernetes.io/zh/docs/tasks/run-application/force-delete-stateful-set-pod/
- > 如果在这些命令后 pod 仍处于Unknown状态，请使用以下命令从集群中删除 pod:
  ```sh
  kubectl patch pod <pod> -p '{"metadata":{"finalizers":null}}'
  ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# patch Label

An example of using kubectl patch https://gist.github.com/coresolve/364c80b817eb8d84bfb1c6e2c94d2886

```yaml
#// Start with a simple deployment:
$ kubectl run simple --image=quay.io/dcooley/simple-app:plain --replicas=3 --port=80 --labels=app=simple
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/simple created
$


#// Show the yaml for this deployment:
$ kubectl get deployment simple -o yaml --export
Flag --export has been deprecated, This flag is deprecated and will be removed in future.
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: null
  generation: 1
  labels:
    app: simple
  name: simple
  selfLink: /apis/extensions/v1beta1/namespaces/default/deployments/simple
spec:
  progressDeadlineSeconds: 600
  replicas: 3
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: simple
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: simple
    spec:
      containers:
      - image: quay.io/dcooley/simple-app:plain
        imagePullPolicy: IfNotPresent
        name: simple
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status: {}
$


#// Show the pods with the labels:
$ kubectl get pods -l app=simple --show-labels
NAME                      READY   STATUS    RESTARTS   AGE   LABELS
simple-67df88b4f9-s6lsx   1/1     Running   0          77s   app=simple,pod-template-hash=67df88b4f9
simple-67df88b4f9-swr7z   1/1     Running   0          77s   app=simple,pod-template-hash=67df88b4f9
simple-67df88b4f9-wlxnd   1/1     Running   0          77s   app=simple,pod-template-hash=67df88b4f9
$


#// Make the patch:
$ kubectl patch deployment simple --type=json -p='[{"op": "add", "path": "/spec/template/metadata/labels/this", "value": "that"}]'
deployment.extensions/simple patched
$


#// Show that the pods have the new label:
$ kubectl get pods -l app=simple --show-labels
NAME                      READY   STATUS        RESTARTS   AGE     LABELS
simple-5b6495d76-df5ng    1/1     Running       0          9s      app=simple,pod-template-hash=5b6495d76,this=that
simple-5b6495d76-h9drd    1/1     Running       0          11s     app=simple,pod-template-hash=5b6495d76,this=that
simple-5b6495d76-xb42k    1/1     Running       0          14s     app=simple,pod-template-hash=5b6495d76,this=that
simple-67df88b4f9-s6lsx   0/1     Terminating   0          2m41s   app=simple,pod-template-hash=67df88b4f9
$


#// Show the new deployment:
$ kubectl get deployment simple -o yaml --export
Flag --export has been deprecated, This flag is deprecated and will be removed in future.
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "2"
  creationTimestamp: null
  generation: 1
  labels:
    app: simple
  name: simple
  selfLink: /apis/extensions/v1beta1/namespaces/default/deployments/simple
spec:
  progressDeadlineSeconds: 600
  replicas: 3
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: simple
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: simple
        this: that
    spec:
      containers:
      - image: quay.io/dcooley/simple-app:plain
        imagePullPolicy: IfNotPresent
        name: simple
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status: {}
$

----------------------------------------------------------------------------------------------------

#// 看看这个--export除了省略了status部分，还有啥不同。
#// 仔细对比了下，除了status部分，也就多了三处，此外有两处不同（这五处都在metadata部分）
$ kubectl get deployment simple -o yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "2"
  creationTimestamp: "2019-08-23T11:05:13Z"
  generation: 2
  labels:
    app: simple
  name: simple
  namespace: default
  resourceVersion: "809"
  selfLink: /apis/extensions/v1beta1/namespaces/default/deployments/simple
  uid: c07ba7a6-42b6-4e82-afa7-5c4e7eb66fef
spec:
  progressDeadlineSeconds: 600
  replicas: 3
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: simple
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: simple
        this: that
    spec:
      containers:
      - image: quay.io/dcooley/simple-app:plain
        imagePullPolicy: IfNotPresent
        name: simple
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 3
  conditions:
  - lastTransitionTime: "2019-08-23T11:05:24Z"
    lastUpdateTime: "2019-08-23T11:05:24Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2019-08-23T11:05:13Z"
    lastUpdateTime: "2019-08-23T11:07:47Z"
    message: ReplicaSet "simple-5b6495d76" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 2
  readyReplicas: 3
  replicas: 3
  updatedReplicas: 3
$
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# patch StorageClass

改变默认 StorageClass https://v1-18.docs.kubernetes.io/zh/docs/tasks/administer-cluster/change-default-storage-class/ || Change the default StorageClass https://v1-18.docs.kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/

```sh
#// 最开始OCP里有这么四个sc，其中第一个是自己手动装的，后面三个是OCP系统自己装的。但是没有默认的。
[root@lolls-inf ~]# oc get sc
NAME                               PROVISIONER                     AGE
fast                               storageos                       47d
rook-ceph-block-internal           rook-ceph.rbd.csi.ceph.com      48d
rook-ceph-cephfs-internal          rook-ceph.cephfs.csi.ceph.com   48d
rook-ceph-delete-bucket-internal   ceph.rook.io/bucket             48d
[root@lolls-inf ~]#
[root@lolls-inf ~]# oc get sc rook-ceph-block-internal -o yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  creationTimestamp: "2020-04-15T11:43:34Z"
  name: rook-ceph-block-internal
  resourceVersion: "21731"
  selfLink: /apis/storage.k8s.io/v1/storageclasses/rook-ceph-block-internal
  uid: 7a2b11dc-185c-427d-be8b-ac6fcef6431e
parameters:
  clusterID: rook-ceph
  csi.storage.k8s.io/fstype: ext4
  csi.storage.k8s.io/node-stage-secret-name: rook-csi-rbd-node
  csi.storage.k8s.io/node-stage-secret-namespace: rook-ceph
  csi.storage.k8s.io/provisioner-secret-name: rook-csi-rbd-provisioner
  csi.storage.k8s.io/provisioner-secret-namespace: rook-ceph
  imageFeatures: layering
  imageFormat: "2"
  pool: rbd
provisioner: rook-ceph.rbd.csi.ceph.com
reclaimPolicy: Delete
volumeBindingMode: Immediate
[root@lolls-inf ~]#

#// patch成功后，会发现查sc的时候默认的sc多了小括号括起来的default。此外，具体看它的yaml会发现多了个annotation。
[root@lolls-inf ~]# kubectl patch storageclass rook-ceph-block-internal -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
storageclass.storage.k8s.io/rook-ceph-block-internal patched
[root@lolls-inf ~]#
[root@lolls-inf ~]# oc get sc
NAME                                 PROVISIONER                     AGE
fast                                 storageos                       47d
rook-ceph-block-internal (default)   rook-ceph.rbd.csi.ceph.com      48d
rook-ceph-cephfs-internal            rook-ceph.cephfs.csi.ceph.com   48d
rook-ceph-delete-bucket-internal     ceph.rook.io/bucket             48d
[root@lolls-inf ~]#
[root@lolls-inf ~]# oc get sc rook-ceph-block-internal -o yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
  creationTimestamp: "2020-04-15T11:43:34Z"
  name: rook-ceph-block-internal
  resourceVersion: "45148590"
  selfLink: /apis/storage.k8s.io/v1/storageclasses/rook-ceph-block-internal
  uid: 7a2b11dc-185c-427d-be8b-ac6fcef6431e
parameters:
  clusterID: rook-ceph
  csi.storage.k8s.io/fstype: ext4
  csi.storage.k8s.io/node-stage-secret-name: rook-csi-rbd-node
  csi.storage.k8s.io/node-stage-secret-namespace: rook-ceph
  csi.storage.k8s.io/provisioner-secret-name: rook-csi-rbd-provisioner
  csi.storage.k8s.io/provisioner-secret-namespace: rook-ceph
  imageFeatures: layering
  imageFormat: "2"
  pool: rbd
provisioner: rook-ceph.rbd.csi.ceph.com
reclaimPolicy: Delete
volumeBindingMode: Immediate
[root@lolls-inf ~]#
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# patch ServiceAccount

```sh
[root@lolls-inf ~]# oc get sa default -n openshift-marketplace -o yaml
apiVersion: v1
imagePullSecrets:
- name: default-dockercfg-j78dv
- name: ibm-management-pull-secret
- name: ibm-management-pull-secret
kind: ServiceAccount
metadata:
  creationTimestamp: "2020-04-15T11:18:31Z"
  name: default
  namespace: openshift-marketplace
  resourceVersion: "44454310"
  selfLink: /api/v1/namespaces/openshift-marketplace/serviceaccounts/default
  uid: f33b764a-c33f-4707-8783-ae73489310f7
secrets:
- name: default-token-wflcl
- name: default-dockercfg-j78dv
[root@lolls-inf ~]#
[root@lolls-inf ~]# oc patch sa default -n openshift-marketplace --type=json -p '[{"op":"add","path":"/imagePullSecrets/-","value":{"name":"ibm-management-pull-secret"}}]'
serviceaccount/default patched
[root@lolls-inf ~]#
[root@lolls-inf ~]# oc get sa default -n openshift-marketplace -o yaml
apiVersion: v1
imagePullSecrets:
- name: default-dockercfg-j78dv
- name: ibm-management-pull-secret
- name: ibm-management-pull-secret
- name: ibm-management-pull-secret
kind: ServiceAccount
metadata:
  creationTimestamp: "2020-04-15T11:18:31Z"
  name: default
  namespace: openshift-marketplace
  resourceVersion: "45294131"
  selfLink: /api/v1/namespaces/openshift-marketplace/serviceaccounts/default
  uid: f33b764a-c33f-4707-8783-ae73489310f7
secrets:
- name: default-token-wflcl
- name: default-dockercfg-j78dv
[root@lolls-inf ~]#

#// 但是patch的"op"值是没有delete还是别的原因，反正我想用patch的方式删是没成功。
[root@lolls-inf ~]# oc patch sa default -n openshift-marketplace --type=json -p '[{"op":"delete","path":"/imagePullSecrets/-","value":{"name":"ibm-management-pull-secret"}}]'
The request is invalid
[root@lolls-inf ~]#
```
