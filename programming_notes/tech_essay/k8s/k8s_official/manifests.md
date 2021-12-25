
# 快速多行内容模板

1.基本形式
```
cat > filename << EOF

EOF
```

2.基本形式II：交换一下位置的形式 【这个是个人最常用的了】
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

6.用echo的方式，但真正的内容不是另起一行开始的（此外`内容开始`和`内容结尾`要紧接着引号，不然打出的yaml文件也是有空格的 --> 其实结尾处有空格还好，至少不会报错；但是yaml开头有空格会报错的。）
```
echo "内容开始

内容结尾" >> filename
```

7.用echo且直接创建的方式
```
echo '

' | kubectl create -f -
```

8.直接创建，但是既不涉及cat也不涉及echo
```
kubectl apply -f - << EOF

EOF
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
//我找了个1.13的环境，直接就成功了。所以，这个失败仅仅是因为k8s版本的问题，与这种cat + EOF的方法无关。
$ kubectl create -f jobttl.yaml
error: error validating "jobttl.yaml": error validating data: ValidationError(Job.spec): unknown field "ttlSecondsAfterFinished" in io.k8s.api.batch.v1.JobSpec; if you choose to ignore these errors, turn validation off with --validate=false

$ kubectl create -f cronjob.yaml
cronjob.batch/hello created

$ kubectl create -f job10completion.yaml
job.batch/pi-with-10completion created

//这个出错就是因为这种cat + EOF的方法，$符号是无法处理的，回来查查怎么处理这个问题。
//当然，就算手动改好了，$对应的环境变量的内容也得有，所以这个例子不是多好用就是了。
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

## 关于`$`问题的解决：转义就好。

使用cat和EOF添加多行数据 https://blog.csdn.net/lym152898/article/details/83306993 || 该文转自: http://www.361way.com/cat-eof-cover-append/4298.html
```
需要注意的是，不论是覆盖还是追加，在涉及到变量操作时是需要进行转义的，例如：

#!/bin/bash
cat <<EOF >> /root/a.txt
PATH=\$PATH:\$HOME/bin
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/10.2.0/db_1
export ORACLE_SID=yqpt
export PATH=\$PATH:\$ORACLE_HOME/bin
export NLS_LANG="AMERICAN_AMERICA.AL32UTF8"
EOF
```
> 补充：我觉得这哥们第一行的`#!/bin/bash`应该写在cat的内容里面吧？或者他是为了保证当前的shell确实是bash才先这么搞一下？反正个人感觉，`#!/bin/bash`这行内容一般都是只有在文件开头才会看见，从没见过在shell命令行里直接来一句`#!/bin/bash`的。但是呢，记录这个的主要目的是为了解决`$`的问题，这个`#!/bin/bash`到底在哪、是不是不太恰当，只是个插曲。
>> 此外，这个例子还说明了两个小的点：1.filename可以和路径一起指定；2.这种用法除了创建新文件还可以用于在已有文件上追加多行内容。

# 实例

## 形式1：基本形式

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

## 形式1：基本形式

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

## 形式4：管道+tee的形式

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

## 形式1：基本形式

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

## 形式3. EOF换成12345

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

## 形式5.

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

## 形式8.

```
# https://medium.com/@janeman98/ibm-cloud-private-community-edition-for-kubeflow-for-beginners-697a044522a 

kubectl apply -f — <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
EOF

kubectl apply -f — <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
EOF
```

##

>> 无法处理$符号
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

>> 可以处理$符号
```
echo "apiVersion: v1
kind: Secret
metadata:
  name: test-secret
type: Opaque
data:
  username: \$username
  password: \$password" >> secret1.yaml
```

>> from: https://github.com/kubernetes/ingress-nginx/blob/master/docs/examples/rewrite/README.md
```
echo '
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$2
  name: rewrite
  namespace: default
spec:
  rules:
  - host: rewrite.bar.com
    http:
      paths:
      - backend:
          serviceName: http-svc
          servicePort: 80
        path: /something(/|$)(.*)
' | kubectl create -f -
```

# 后来补充

Bash Heredoc https://linuxize.com/post/bash-heredoc/
- > In the following example, we are passing two lines of text containing an environment variable and a command to cat using a here document.
  ```sh
  cat << EOF
  The current working directory is: $PWD
  You are logged in as: $(whoami)
  EOF
  ```
- > As you can see from the output below, both the variable and the command output are substituted:
  ```console
  The current working directory is: /home/linuxize
  You are logged in as: linuxize
  ```
- > Let’s see what will happen if we enclose the delimiter in single or double quotes.
  ```sh
  cat <<- "EOF"
  The current working directory is: $PWD
  You are logged in as: $(whoami)
  EOF
  ```
- > You can notice that when the delimiter is quoted no parameter expansion and command substitution is done by the shell.
  ```console
  The current working directory is: $PWD
  You are logged in as: $(whoami)
  ```
