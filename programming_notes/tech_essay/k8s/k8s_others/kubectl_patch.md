
# kubectl patch官方页面

使用 kubectl patch 更新 API 对象 https://v1-14.docs.kubernetes.io/zh/docs/tasks/run-application/update-api-object-kubectl-patch/

## 其他

kubectl patch servicemonitor fails with UnsupportedMediaType https://github.com/kubernetes/kubernetes/issues/71024
>> notes：从这个issue看目前还不能patch自己添加到系统里的custom resource definition对应的CR。

# patch service

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

# patch label

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
