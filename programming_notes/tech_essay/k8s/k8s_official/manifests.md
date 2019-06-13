

# 模板

# （实例）结果

```
$ kubectl create -f pod-multi-container.yaml
pod/my-two-container-pod created

$ kubectl create -f job.yaml
job.batch/pi created

$ kubectl create -f jobtimeout.yaml
job.batch/pi-with-timeout created

$ kubectl create -f jobttl.yaml
error: error validating "jobttl.yaml": error validating data: ValidationError(Job.spec): unknown field "ttlSecondsAfterFinished" in io.k8s.api.batch.v1.JobSpec; if you choose to ignore these errors, turn validation off with --validate=false

$ kubectl create -f cronjob.yaml
cronjob.batch/hello created

$ kubectl create -f job10completion.yaml
job.batch/pi-with-10completion created

$ kubectl create -f jobdelete.yaml
error: error validating "jobdelete.yaml": error validating data: ValidationError(Job.spec): unknownfield "serviceAccountName" in io.k8s.api.batch.v1.JobSpec; if you choose to ignore these errors, turn validation off with --validate=false
```

# 实例

##

```
cat > pod-multi-container.yaml << EOF
apiVersion: v1
kind: Pod
metadata:
  name: my-two-container-pod
  namespace: default
  labels:
    environment: dev
spec:
  containers:
    - name: server
      image: nginx:1.13-alpine
      ports:
        - containerPort: 80
          protocol: TCP
    - name: side-car
      image: alpine:latest
      command: ["/usr/bin/tail", "-f", "/dev/null"]
  restartPolicy: Never
EOF
```

##

```
cat > job.yaml << EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: pi
spec:
  template:
    spec:
      containers:
      - name: pi
        image: perl
        command: ["perl",  "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
  backoffLimit: 4
EOF
```

```
cat > jobtimeout.yaml << EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: pi-with-timeout
spec:
  backoffLimit: 5
  activeDeadlineSeconds: 15
  template:
    spec:
      containers:
      - name: pi
        image: perl
        command: ["perl",  "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
EOF
```

```
cat << EOF | tee jobttl.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: pi-with-ttl
spec:
  ttlSecondsAfterFinished: 25
  template:
    spec:
      containers:
      - name: pi
        image: perl
        command: ["perl",  "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
EOF
```

```
cat > cronjob.yaml << EOF
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: hello
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: busybox
            args:
            - /bin/sh
            - -c
            - date; echo Hello from the Kubernetes cluster
          restartPolicy: OnFailure
EOF
```
 
#

```
cat > job10completion.yaml << 12345
apiVersion: batch/v1
kind: Job
metadata:
  name: pi-with-10completion
spec:
  completions: 10
  parallelism: 5
  template:
    spec:
      containers:
      - name: pi
        image: perl
        command: ["perl",  "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
  backoffLimit: 4
12345
```

#

```
cat > jobdelete.yaml << EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: cleanup
spec:
  serviceAccountName: service-account-that-has-access-to-api
  template:
    spec:
      containers:
      - name: cleanup
        # image: image-that-has-curl
        image: appropriate/curl
        command:
        - curl
        - -ik 
        - -X
        - DELETE
        - -H
        - "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)"
        # - https://kubernetes.default.svc.cluster.local/api/v1/namespaces/{namespace}/pods/{name}
        - https://kubernetes.default.svc.cluster.local/api/v1/namespaces/default/pods/my-two-container-pod
      restartPolicy: Never
  backoffLimit: 4
EOF
```

#

```
cat <<EOF | kubectl create -f -
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: myclaim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 8Gi
  storageClassName: gp2-resize
EOF
```

#

```
echo "apiVersion: v1
kind: Secret
metadata:
  name: test-secret
type: Opaque
data:
  username: $username
  password: $password" >> secret.yaml
```

