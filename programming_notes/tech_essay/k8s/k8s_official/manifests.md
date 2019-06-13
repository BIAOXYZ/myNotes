
# 快速多行内容模板

1.基本形式
```
cat > filename << EOF

EOF
```

2.基本形式II：交换一下位置的形式
```
cat << EOF > filename 

EOF
```

3.或者用其它不会在文件内容中用到字符串做终止字符：`STOP`，`12345`等都可以
```
cat > filename << STOP

STOP
```

4.或者使用`管道+tee`的形式
```
cat << EOF | tee filename

EOF
```

5.直接创建，不涉及具体文件
```
cat << EOF | kubectl create -f -

EOF
```

6.用echo的方式
```
echo 

   >> filename
```

# （实例）结果

```
$ kubectl create -f pod-multi-container.yaml
pod/my-two-container-pod created

$ kubectl create -f job.yaml
job.batch/pi created

$ kubectl create -f jobtimeout.yaml
job.batch/pi-with-timeout created

//这个不成功主要是因为ttl特性的flag在1.12以后才能设置打开，这种方法创建文件并没有问题。
$ kubectl create -f jobttl.yaml
error: error validating "jobttl.yaml": error validating data: ValidationError(Job.spec): unknown field "ttlSecondsAfterFinished" in io.k8s.api.batch.v1.JobSpec; if you choose to ignore these errors, turn validation off with --validate=false

$ kubectl create -f cronjob.yaml
cronjob.batch/hello created

$ kubectl create -f job10completion.yaml
job.batch/pi-with-10completion created

//这个出错就是因为这种cat + EOF的方法，$符号是无法处理的，回来查查怎么处理这个问题。
//当然，就算手动改好了，$对于的环境变量内容也得有，所以这个例子不是多好用就是了
//————凡是带$的例子都有这个问题，算是“不那么独立的yaml”吧，其实用来做例子不算多好，
//————但是我主要是为了说明在这种cat + EOF的方法下$无法处理的问题。
$ kubectl create -f jobdelete.yaml
error: error validating "jobdelete.yaml": error validating data: ValidationError(Job.spec): unknownfield "serviceAccountName" in io.k8s.api.batch.v1.JobSpec; if you choose to ignore these errors, turn validation off with --validate=false

$ cat <<EOF | kubectl create -f -
> kind: PersistentVolumeClaim
> apiVersion: v1
> metadata:
>   name: myclaim
> spec:
>   accessModes:
>     - ReadWriteOnce
>   resources:
>     requests:
>       storage: 8Gi
>   storageClassName: gp2-resize
> EOF
persistentvolumeclaim/myclaim created

//至少目前看，echo也无法处理多行内容中的$符号问题。
$ kubectl create -f secret.yaml
error: error validating "secret.yaml": error validating data: [unknown object type "nil" in Secret.data.password, unknown object type "nil" in Secret.data.username]; if you choose to ignore these errors, turn validation off with --validate=false
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

