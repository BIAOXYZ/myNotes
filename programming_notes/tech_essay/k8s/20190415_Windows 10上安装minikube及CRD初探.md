
# 零、Windows 10上安装minikube

----------------------------------------------------------------------------------------------------

- Install Minikube https://kubernetes.io/docs/tasks/tools/install-minikube/
- 安装 Minikube https://k8smeetup.github.io/docs/tasks/tools/install-minikube/
```
总结：总体来讲就三步————1.安装虚拟机软件；2.安装kubectl；3.安装minikube

第一步之前已经完成了，有个攻略，一步步来即可。后面两个软件的安装其实很简单：
把对应的二进制文件一下载，然后把相应目录添加到PATH环境变量里，最后启动minikube即可。
————我是把两个exe文件存到D:\bin目录下，然后把该目录加到PATH，最后执行minikube start。
```

----------------------------------------------------------------------------------------------------

- 在Windows10下安装Minikube https://yalishizhude.github.io/2017/12/15/minikube-setup/
> 花了两天时间，终于将Minikube部署成功了，心情久久不能平静，于是写篇文章纪念一下，顺便提醒后来者，避免踩坑~
>> notes：当时看到这段心想安个minikube都得两天啊，这也太。。。但是实际去安了下发现还是有些小坑，比如kubectl版本问题。但是整个过程还是比较简单的。而且如果是完全从头开始的话，主要的工作其实是安VirtualBox虚拟机吧。。。
- windows上用minikube部署k8s(1.9.0) https://www.jianshu.com/p/02bdf2b9457f

----------------------------------------------------------------------------------------------------

```
PS C:\Users\LiangLiu> minikube start
o   minikube v1.0.0 on windows (amd64)
$   Downloading Kubernetes v1.14.0 images in the background ...
>   Creating virtualbox VM (CPUs=2, Memory=2048MB, Disk=20000MB) ...
@   Downloading Minikube ISO ...
2019/04/13 17:58:26 No matching credentials were found, falling back on anonymous
2019/04/13 17:58:26 No matching credentials were found, falling back on anonymous
2019/04/13 17:58:26 No matching credentials were found, falling back on anonymous
2019/04/13 17:58:26 No matching credentials were found, falling back on anonymous
2019/04/13 17:58:26 No matching credentials were found, falling back on anonymous
2019/04/13 17:58:26 No matching credentials were found, falling back on anonymous
2019/04/13 17:58:26 No matching credentials were found, falling back on anonymous
2019/04/13 17:58:26 No matching credentials were found, falling back on anonymous
2019/04/13 17:58:26 No matching credentials were found, falling back on anonymous
2019/04/13 17:58:26 No matching credentials were found, falling back on anonymous
2019/04/13 17:58:26 No matching credentials were found, falling back on anonymous
2019/04/13 17:58:26 No matching credentials were found, falling back on anonymous
2019/04/13 17:58:26 No matching credentials were found, falling back on anonymous
 142.88 MB / 142.88 MB [============================================] 100.00% 0s
-   "minikube" IP address is 192.168.99.100
-   Configuring Docker as the container runtime ...
-   Version of container runtime is 18.06.2-ce
:   Waiting for image downloads to complete ...
-   Preparing Kubernetes environment ...
@   Downloading kubelet v1.14.0
@   Downloading kubeadm v1.14.0
-   Pulling images required by Kubernetes v1.14.0 ...
-   Launching Kubernetes v1.14.0 using kubeadm ...
:   Waiting for pods: apiserver proxy etcd scheduler controller dns
-   Configuring cluster permissions ...
-   Verifying component health .....
+   kubectl is now configured to use "minikube"
=   Done! Thank you for using minikube!
PS C:\Users\LiangLiu>
PS C:\Users\LiangLiu> kubectl version
Client Version: version.Info{Major:"1", Minor:"10", GitVersion:"v1.10.3", GitCommit:"2bba0127d85d5a46ab4b778548be28623b32d0b0", GitTreeState:"clean", BuildDate:"2018-05-21T09:17:39Z", GoVersion:"go1.9.3", Compiler:"gc", Platform:"windows/amd64"}
Server Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.0", GitCommit:"641856db18352033a0d96dbc99153fa3b27298e5", GitTreeState:"clean", BuildDate:"2019-03-25T15:45:25Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"linux/amd64"}
```

# 一、在工作笔记本上用VirtualBox简单试了下k8s CRD

```
PS C:\Users\LiangLiu> kubectl get CustomResourceDeinitions
error: the server doesn't have a resource type "CustomResourceDeinitions"


PS C:\Users\LiangLiu> kubectl apply -f .\mydata\resourcedefinition.yaml
error: SchemaError(io.k8s.kube-aggregator.pkg.apis.apiregistration.v1.APIServiceList): invalid object doesn't have additional properties
PS C:\Users\LiangLiu>
PS C:\Users\LiangLiu>
PS C:\Users\LiangLiu> kubectl create -f C:\Users\LiangLiu\mydata\resourcedefinition.yaml
error: SchemaError(io.k8s.kube-aggregator.pkg.apis.apiregistration.v1.APIServiceList): invalid object doesn't have additional properties
PS C:\Users\LiangLiu>
PS C:\Users\LiangLiu> kubectl create -f .\mydata\resourcedefinition.yaml
error: SchemaError(io.k8s.kube-aggregator.pkg.apis.apiregistration.v1.APIServiceList): invalid object doesn't have additional properties


//不知道为啥，我明明下的都是最新版，但是kubectl客户端版本老是报v1.10.3。最后这问题咋解决了呢？
//————灵机一动只在D:/bin里用 "./kubectl + 命令"的形式来执行。。。
https://github.com/kubernetes/kubernetes/issues/73111
- https://stackoverflow.com/questions/55417410/kubernetes-create-deployment-unexpected-schemaerror


PS D:\bin> kubectl version
Client Version: version.Info{Major:"1", Minor:"10", GitVersion:"v1.10.3", GitCommit:"2bba0127d85d5a46ab4b778548be28623b32d0b0", GitTreeState:"clean", BuildDate:"2018-05-21T09:17:39Z", GoVersion:"go1.9.3", Compiler:"gc", Platform:"windows/amd64"}
Server Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.0", GitCommit:"641856db18352033a0d96dbc99153fa3b27298e5", GitTreeState:"clean", BuildDate:"2019-03-25T15:45:25Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"linux/amd64"}
PS D:\bin> kubectl.exe version
Client Version: version.Info{Major:"1", Minor:"10", GitVersion:"v1.10.3", GitCommit:"2bba0127d85d5a46ab4b778548be28623b32d0b0", GitTreeState:"clean", BuildDate:"2018-05-21T09:17:39Z", GoVersion:"go1.9.3", Compiler:"gc", Platform:"windows/amd64"}
Server Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.0", GitCommit:"641856db18352033a0d96dbc99153fa3b27298e5", GitTreeState:"clean", BuildDate:"2019-03-25T15:45:25Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"linux/amd64"}
PS D:\bin> ./kubectl.exe version
Client Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.0", GitCommit:"641856db18352033a0d96dbc99153fa3b27298e5", GitTreeState:"clean", BuildDate:"2019-03-25T15:53:57Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"windows/amd64"}
Server Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.0", GitCommit:"641856db18352033a0d96dbc99153fa3b27298e5", GitTreeState:"clean", BuildDate:"2019-03-25T15:45:25Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"linux/amd64"}
PS D:\bin> ./kubectl version
Client Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.0", GitCommit:"641856db18352033a0d96dbc99153fa3b27298e5", GitTreeState:"clean", BuildDate:"2019-03-25T15:53:57Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"windows/amd64"}
Server Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.0", GitCommit:"641856db18352033a0d96dbc99153fa3b27298e5", GitTreeState:"clean", BuildDate:"2019-03-25T15:45:25Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"linux/amd64"}
PS D:\bin>


PS D:\bin> ./kubectl apply -f C:\Users\LiangLiu\mydata\resourcedefinition.yaml
customresourcedefinition.apiextensions.k8s.io/crontabs.stable.example.com created
PS D:\bin>
PS D:\bin> kubectl get CustomResourceDeinitions
error: the server doesn't have a resource type "CustomResourceDeinitions"
PS D:\bin> ./kubectl get CustomResourceDeinitions
error: the server doesn't have a resource type "CustomResourceDeinitions"
PS D:\bin>
PS D:\bin> ./kubectl get crd
NAME                          CREATED AT
crontabs.stable.example.com   2019-04-13T10:55:36Z
PS D:\bin>
PS D:\bin>
PS D:\bin> ./kubectl apply -f C:\Users\LiangLiu\mydata\my-crontab.yaml
crontab.stable.example.com/my-new-cron-object created


PS C:\Users\LiangLiu> kubectl get ct -o yaml
apiVersion: v1
items:
- apiVersion: stable.example.com/v1
  kind: CronTab
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"stable.example.com/v1","kind":"CronTab","metadata":{"annotations":{},"name":"my-new-cron-object","namespace":"default"},"spec":{"cronSpec":"* * * * */5","image":"my-awesome-cron-image"}}
    creationTimestamp: 2019-04-13T11:04:03Z
    generation: 1
    name: my-new-cron-object
    namespace: default
    resourceVersion: "4878"
    selfLink: /apis/stable.example.com/v1/namespaces/default/crontabs/my-new-cron-object
    uid: d90bace5-5ddb-11e9-84fd-0800270296c4
  spec:
    cronSpec: '* * * * */5'
    image: my-awesome-cron-image
kind: List
metadata:
  resourceVersion: ""
  selfLink: ""
PS C:\Users\LiangLiu>
```

# 二、后面发现就周六时间不够，最后还是在katacoda的环境搞定了

## 1.basic

```
kubectl get crd

kubectl apply -f resourcedefinition.yaml
kubectl apply -f my-crontab.yaml

kubectl get crontab
kubectl get ct
kubectl get ct -o yaml

kubectl get crontabs  // will work
kubectl get cts  // will fail

kubectl delete -f resourcedefinition.yaml
```

```
cat << EOF | tee resourcedefinition.yaml
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  # name must match the spec fields below, and be in the form: <plural>.<group>
  name: crontabs.stable.example.com
spec:
  # group name to use for REST API: /apis/<group>/<version>
  group: stable.example.com
  # list of versions supported by this CustomResourceDefinition
  versions:
    - name: v1
      # Each version can be enabled/disabled by Served flag.
      served: true
      # One and only one version must be marked as the storage version.
      storage: true
  # either Namespaced or Cluster
  scope: Namespaced
  names:
    # plural name to be used in the URL: /apis/<group>/<version>/<plural>
    plural: crontabs
    # singular name to be used as an alias on the CLI and for display
    singular: crontab
    # kind is normally the CamelCased singular type. Your resource manifests use this.
    kind: CronTab
    # shortNames allow shorter string to match your resource on the CLI
    shortNames:
    - ct
EOF
```

```
cat << EOF | tee my-crontab.yaml
apiVersion: "stable.example.com/v1"
kind: CronTab
metadata:
  name: my-new-cron-object
spec:
  cronSpec: "* * * * */5"
  image: my-awesome-cron-image
EOF
```

## 2.add validation

```
kubectl apply -f resourcedefinition2.yaml
kubectl apply -f my-crontab2.yaml  // will fail
```

```
cat << EOF | tee resourcedefinition2.yaml
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: crontabs.stable.example.com
spec:
  group: stable.example.com
  versions:
    - name: v1
      served: true
      storage: true
  version: v1
  scope: Namespaced
  names:
    plural: crontabs
    singular: crontab
    kind: CronTab
    shortNames:
    - ct
  validation:
   # openAPIV3Schema is the schema for validating custom objects.
    openAPIV3Schema:
      properties:
        spec:
          properties:
            cronSpec: #--must be sting and with the form of regular expression 
              type: string
              pattern: '^(\d+|\*)(/\d+)?(\s+(\d+|\*)(/\d+)?){4}$'
            replicas: #--must be integer and the value should be 1 ≤ v ≤ 10
              type: integer
              minimum: 1
              maximum: 10
EOF
```

```
cat << EOF | tee my-crontab2.yaml
apiVersion: "stable.example.com/v1"
kind: CronTab
metadata:
  name: my-new-cron-object
spec:
  cronSpec: "* * * *"
  image: my-awesome-cron-image
  replicas: 15
EOF
```

## 3.add printer columns

```
kubectl apply -f resourcedefinition3.yaml
kubectl apply -f my-crontab3.yaml
```

```
cat << EOF | tee resourcedefinition3.yaml
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: crontabs.stable.example.com
spec:
  group: stable.example.com
  version: v1
  scope: Namespaced
  names:
    plural: crontabs
    singular: crontab
    kind: CronTab
    shortNames:
    - ct
  additionalPrinterColumns:
  - name: Spec
    type: string
    description: The cron spec defining the interval a CronJob is run
    JSONPath: .spec.cronSpec
  - name: Replicas
    type: integer
    description: The number of jobs launched by the CronJob
    JSONPath: .spec.replicas
  - name: Age
    type: date
    JSONPath: .metadata.creationTimestamp
EOF
```

> the same as my-crontab.yaml
```
cat << EOF | tee my-crontab3.yaml
apiVersion: "stable.example.com/v1"
kind: CronTab
metadata:
  name: my-new-cron-object
spec:
  cronSpec: "* * * * */5"
  image: my-awesome-cron-image
EOF
```

## 4.auto scale with subresource

```
kubectl apply -f resourcedefinition4.yaml
kubectl apply -f my-crontab4.yaml

kubectl describe ct | grep Replicas

kubectl scale --replicas=5 crontabs/my-new-cron-object

kubectl describe ct | grep Replicas
```

```
cat << EOF | tee resourcedefinition4.yaml
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: crontabs.stable.example.com
spec:
  group: stable.example.com
  versions:
    - name: v1
      served: true
      storage: true
  scope: Namespaced
  names:
    plural: crontabs
    singular: crontab
    kind: CronTab
    shortNames:
    - ct
  # Description of subresource
  subresources:
    status: {}
    # turn on scale subresource
    scale:
      specReplicasPath: .spec.replicas
      statusReplicasPath: .status.replicas
      labelSelectorPath: .status.labelSelector
EOF
```

```
cat << EOF | tee my-crontab4.yaml
apiVersion: "stable.example.com/v1"
kind: CronTab
metadata:
  name: my-new-cron-object
spec:
  cronSpec: "* * * * */5"
  image: my-awesome-cron-image
  replicas: 3
EOF
```

## 5.group CRD via category

```
kubectl apply -f resourcedefinition5.yaml
kubectl apply -f my-crontab5.yaml
```

```
cat << EOF | tee resourcedefinition5.yaml
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: crontabs.stable.example.com
spec:
  group: stable.example.com
  versions:
    - name: v1
      served: true
      storage: true
  scope: Namespaced
  names:
    plural: crontabs
    singular: crontab
    kind: CronTab
    shortNames:
    - ct
    # the attribute categories indicate the group of CronTab
    categories:
    - all
EOF
```

> the same as my-crontab.yaml
```
cat << EOF | tee my-crontab5.yaml
apiVersion: "stable.example.com/v1"
kind: CronTab
metadata:
  name: my-new-cron-object
spec:
  cronSpec: "* * * * */5"
  image: my-awesome-cron-image
EOF
```
