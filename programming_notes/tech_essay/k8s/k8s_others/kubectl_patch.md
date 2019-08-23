
# patch label

An example of using kubectl patch https://gist.github.com/coresolve/364c80b817eb8d84bfb1c6e2c94d2886

```yaml
$ kubectl run simple --image=quay.io/dcooley/simple-app:plain --replicas=3 --port=80 --labels=app=simple
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/simple created
$
$
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
$
$ kubectl get pods -l app=simple --show-labels
NAME                      READY   STATUS    RESTARTS   AGE   LABELS
simple-67df88b4f9-s6lsx   1/1     Running   0          77s   app=simple,pod-template-hash=67df88b4f9
simple-67df88b4f9-swr7z   1/1     Running   0          77s   app=simple,pod-template-hash=67df88b4f9
simple-67df88b4f9-wlxnd   1/1     Running   0          77s   app=simple,pod-template-hash=67df88b4f9
$
$
$ kubectl patch deployment simple --type=json -p='[{"op": "add", "path": "/spec/template/metadata/labels/this", "value": "that"}]'
deployment.extensions/simple patched
$
$
$ kubectl get pods -l app=simple --show-labels
NAME                      READY   STATUS        RESTARTS   AGE     LABELS
simple-5b6495d76-df5ng    1/1     Running       0          9s      app=simple,pod-template-hash=5b6495d76,this=that
simple-5b6495d76-h9drd    1/1     Running       0          11s     app=simple,pod-template-hash=5b6495d76,this=that
simple-5b6495d76-xb42k    1/1     Running       0          14s     app=simple,pod-template-hash=5b6495d76,this=that
simple-67df88b4f9-s6lsx   0/1     Terminating   0          2m41s   app=simple,pod-template-hash=67df88b4f9
$
$
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


// 看看这个--export除了省略了status部分，还有啥不同。
// 仔细对比了下，除了status部分，也就多了三处，此外有两处不同（这五处都在metadata部分）
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
