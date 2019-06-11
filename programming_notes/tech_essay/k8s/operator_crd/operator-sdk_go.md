
# 零、Steps from https://github.com/operator-framework/operator-sdk

***注意***：
- 此文仅适用于operator-sdk v0.7.x。但是对于后续新版本（尤其是全面支持go module之后的0.8.x版本）操作步骤上变化不大（尽管内部实际上变化不小）。所以后续步骤会看到在git clone完代码后我没有切换到master分支，而是切到了某一个验证过的还处于0.7.x版本的分支。
- 0.8.x版本之后，官方提供了Linux下的operator-sdk的二进制文件（此前只有Mac下有现成的二进制文件- -）。所以想省（少）点（踩）事（坑）的话可以直接下operator-sdk的二进制文件，就不用自己编了————刚出0.8.x的时候我这边就出现了同样配置的虚拟机一台能编过一台编不过的坑——不过比从0.7.x到0.8.x的坑小多了。。。

```
// First, checkout and install the operator-sdk CLI:

$ mkdir -p $GOPATH/src/github.com/operator-framework
$ cd $GOPATH/src/github.com/operator-framework
$ git clone https://github.com/operator-framework/operator-sdk
$ cd operator-sdk
$ git checkout master
$ make dep
$ make install


// Create and deploy an app-operator using the SDK CLI:

# Create an app-operator project that defines the App CR.
$ mkdir -p $GOPATH/src/github.com/example-inc/
# Create a new app-operator project
$ cd $GOPATH/src/github.com/example-inc/
$ operator-sdk new app-operator
$ cd app-operator

# Add a new API for the custom resource AppService
$ operator-sdk add api --api-version=app.example.com/v1alpha1 --kind=AppService

# Add a new controller that watches for AppService
$ operator-sdk add controller --api-version=app.example.com/v1alpha1 --kind=AppService

# Build and push the app-operator image to a public registry such as quay.io
$ operator-sdk build quay.io/example/app-operator
$ docker push quay.io/example/app-operator

# Update the operator manifest to use the built image name (if you are performing these steps on OSX, see note below)
$ sed -i 's|REPLACE_IMAGE|quay.io/example/app-operator|g' deploy/operator.yaml
# On OSX use:
$ sed -i "" 's|REPLACE_IMAGE|quay.io/example/app-operator|g' deploy/operator.yaml

# Setup Service Account
$ kubectl create -f deploy/service_account.yaml
# Setup RBAC
$ kubectl create -f deploy/role.yaml
$ kubectl create -f deploy/role_binding.yaml
# Setup the CRD
$ kubectl create -f deploy/crds/app_v1alpha1_appservice_crd.yaml
# Deploy the app-operator
$ kubectl create -f deploy/operator.yaml

# Create an AppService CR
# The default controller will watch for AppService objects and create a pod for each CR
$ kubectl create -f deploy/crds/app_v1alpha1_appservice_cr.yaml

# Verify that a pod is created
$ kubectl get pod -l app=example-appservice
NAME                     READY     STATUS    RESTARTS   AGE
example-appservice-pod   1/1       Running   0          1m

# Test the new Resource Type
$ kubectl describe appservice example-appservice
Name:         example-appservice
Namespace:    myproject
Labels:       <none>
Annotations:  <none>
API Version:  app.example.com/v1alpha1
Kind:         AppService
Metadata:
  Cluster Name:        
  Creation Timestamp:  2018-12-17T21:18:43Z
  Generation:          1
  Resource Version:    248412
  Self Link:           /apis/app.example.com/v1alpha1/namespaces/myproject/appservices/example-appservice
  UID:                 554f301f-0241-11e9-b551-080027c7d133
Spec:
  Size:  3

# Cleanup
$ kubectl delete -f deploy/crds/app_v1alpha1_appservice_cr.yaml
$ kubectl delete -f deploy/operator.yaml
$ kubectl delete -f deploy/role.yaml
$ kubectl delete -f deploy/role_binding.yaml
$ kubectl delete -f deploy/service_account.yaml
$ kubectl delete -f deploy/crds/app_v1alpha1_appservice_crd.yaml
```

# 一、Set go environment

```
wget https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.11.2.linux-amd64.tar.gz

----------------------------------------------------------------------------------------------------
// 对于0.80全面支持go module之后的版本，大致流程不变，但是内部很多东西都变了。此外，对于新版operator-sdk写
// go operator时（ansible operator好像没啥影响）请尽量使用最新版的go runtime，并且要显式地打开GO111MODULE变量。

wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz && sudo tar -C /usr/local -xzf go1.12.5.linux-amd64.tar.gz 

$ operator-sdk new app-operator
INFO[0000] Creating new Go operator 'app-operator'.
FATA[0000] Dependency manager "modules" has been selected but go modules are not active. Activate modules then run "operator-sdk new app-operator".
$ export GO111MODULE=on
----------------------------------------------------------------------------------------------------

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
```

# 二、bug solution（为什么把bug solution写在正式步骤前是有理由的）

## 2.1 Set dep dependencies

dep Binary Installation https://golang.github.io/dep/docs/installation.html
> mkdir -p /root/go/bin && curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh && export GOBIN=/root/go/bin

## 2.2 edit git config file in new operator project or without a git initialization

添加用户名密码即可 ( `git config --global user.name "Scott Chacon"; git config --global user.email "schacon@gmail.com"` )，或者用跳过git初始化那个flag，即`operator-sdk new app-operator --skip-git-init`，于是整句变为：
> mkdir -p `$`GOPATH/src/github.com/example-inc/ && cd `$`GOPATH/src/github.com/example-inc/ && operator-sdk new app-operator --skip-git-init

## 2.3 push image to local docker registry

> docker pull docker.io/registry && docker run -d -p 5000:5000 --name=registry --restart=always --privileged=true  --log-driver=none -v /home/data/registrydata:/tmp/registry registry
>> or simplely: docker run -d -p 5000:5000 --restart=always --name registry registry

> docker tag quay.io/example/app-operator:latest 127.0.0.1:5000/quay.io/example/app-operator:latest && docker push 127.0.0.1:5000/quay.io/example/app-operator


# 三、Main steps

## 3.1 该步骤里的`make dep`需要安装dep，请参考bug solution第一条（实际上之所以把bug solution这部分放到main steps前面也是因为熟悉了以后每次安装直接会先用bug solution里dep安装的语句先安好，免得后面报错了再去按）。

> mkdir -p `$`GOPATH/src/github.com/operator-framework && cd `$`GOPATH/src/github.com/operator-framework && git clone https://github.com/operator-framework/operator-sdk && cd operator-sdk && git checkout -b bak; git reset --hard ef5a723ec6184bd288a9257cf614ffe04a0215ce && make dep && make install
- For `make dep` step, please set dep dependencies.

## 3.2 如果本地的git仓库没有配置好用户名和邮箱，该步骤可能会报仓库init失败的错误。参见bug solution第二条。不是正式开发的话这里推荐直接跳过。

> mkdir -p `$`GOPATH/src/github.com/example-inc/ && cd `$`GOPATH/src/github.com/example-inc/ && operator-sdk new app-operator
- For `operator-sdk new app-operator` step, please set the newly generated git config file after executing `operator-sdk new app-operator`, adding user name and email; Then finish a initial commit.
  * https://blog.csdn.net/liufangbaishi2014/article/details/50037507

## 3.3 推镜像那步没有权限会推送失败，有两条路：1.使用本地镜像仓库；2.推送到自己的远端账号。我这里用的是方法1.

> cd /root/go/src/github.com/example-inc/app-operator && operator-sdk add api --api-version=app.example.com/v1alpha1 --kind=AppService && operator-sdk add controller --api-version=app.example.com/v1alpha1 --kind=AppService && operator-sdk build quay.io/example/app-operator && docker push quay.io/example/app-operator
- For `docker push quay.io/example/app-operator` step, bypass this obstacle by establishing a local docker registry.
  * https://yeasy.gitbooks.io/docker_practice/content/repository/registry.html
  * https://www.cnblogs.com/zhenyuyaodidiao/p/6500950.html


### add api 和 add controller过程中目录的变化

```
operator-sdk add api --api-version=app.example.com/v1alpha1 --kind=AppService

// 这步会影响build/和deploy/

$ ll
total 76
drwxr-x---  9 root root  4096 May  6 13:26 ./
drwxr-xr-x  3 root root  4096 May  6 13:23 ../
drwxr-x---  3 root root  4096 May  6 13:23 build/
drwxr-x---  3 root root  4096 May  6 13:23 cmd/
drwxr-x---  2 root root  4096 May  6 13:23 deploy/
drwxr-xr-x  8 root root  4096 May  6 13:42 .git/
-rw-r--r--  1 root root  1204 May  6 13:23 .gitignore
-rw-r--r--  1 root root 30706 May  6 13:26 Gopkg.lock
-rw-r--r--  1 root root  2042 May  6 13:23 Gopkg.toml
drwxr-x---  4 root root  4096 May  6 13:23 pkg/
drwxr-xr-x 12 root root  4096 May  6 13:25 vendor/
drwxr-x---  2 root root  4096 May  6 13:23 version/
$
$ operator-sdk add api --api-version=app.example.com/v1alpha1 --kind=AppService
INFO[0000] Generating api version app.example.com/v1alpha1 for kind AppService.
INFO[0000] Created pkg/apis/app/v1alpha1/appservice_types.go
INFO[0000] Created pkg/apis/addtoscheme_app_v1alpha1.go
INFO[0000] Created pkg/apis/app/v1alpha1/register.go
INFO[0000] Created pkg/apis/app/v1alpha1/doc.go
INFO[0000] Created deploy/crds/app_v1alpha1_appservice_cr.yaml
W0506 13:50:26.442908   31074 parse.go:239] Ignoring child directory github.com/example-inc/app-operator/pkg/apis/app: No files for pkg "github.com/example-inc/app-operator/pkg/apis/app"
INFO[0001] Created deploy/crds/app_v1alpha1_appservice_crd.yaml
INFO[0008] Running deepcopy code-generation for Custom Resource group versions: [app:[v1alpha1], ]
INFO[0009] Code-generation complete.
INFO[0013] Running OpenAPI code-generation for Custom Resource group versions: [app:[v1alpha1], ]
2019/05/06 13:50:39 Code for OpenAPI definitions generated
INFO[0014] Created deploy/crds/app_v1alpha1_appservice_crd.yaml
INFO[0014] Code-generation complete.
INFO[0014] API generation complete.
$
$ ll
total 76
drwxr-x---  9 root root  4096 May  6 13:26 ./
drwxr-xr-x  3 root root  4096 May  6 13:23 ../
drwxr-x---  4 root root  4096 May  6 13:50 build/
drwxr-x---  3 root root  4096 May  6 13:23 cmd/
drwxr-x---  3 root root  4096 May  6 13:50 deploy/
drwxr-xr-x  8 root root  4096 May  6 13:42 .git/
-rw-r--r--  1 root root  1204 May  6 13:23 .gitignore
-rw-r--r--  1 root root 30706 May  6 13:26 Gopkg.lock
-rw-r--r--  1 root root  2042 May  6 13:23 Gopkg.toml
drwxr-x---  4 root root  4096 May  6 13:23 pkg/
drwxr-xr-x 12 root root  4096 May  6 13:25 vendor/
drwxr-x---  2 root root  4096 May  6 13:23 version/

// 准确说影响了build/下的_output/和deploy/下的crds/以及role.yaml

$ ll build
total 20
drwxr-x--- 4 root root 4096 May  6 13:50 ./
drwxr-x--- 9 root root 4096 May  6 13:26 ../
drwxr-x--- 2 root root 4096 May  6 13:23 bin/
-rw-r--r-- 1 root root  344 May  6 13:23 Dockerfile
drwxr-xr-x 3 root root 4096 May  6 13:50 _output/
$
$ ll deploy/
total 28
drwxr-x--- 3 root root 4096 May  6 13:50 ./
drwxr-x--- 9 root root 4096 May  6 13:26 ../
drwxr-x--- 2 root root 4096 May  6 13:50 crds/
-rw-r--r-- 1 root root  808 May  6 13:23 operator.yaml
-rw-r--r-- 1 root root  225 May  6 13:23 role_binding.yaml
-rw-r--r-- 1 root root  670 May  6 13:50 role.yaml
-rw-r--r-- 1 root root   67 May  6 13:23 service_account.yaml
```

```
operator-sdk add controller --api-version=app.example.com/v1alpha1 --kind=AppService

// 这步会影响pkg/，但是从提示信息可以发现，上一步其实也影响了pkg/。所以得有个精确统计的办法。

$ ll
total 76
drwxr-x---  9 root root  4096 May  6 13:26 ./
drwxr-xr-x  3 root root  4096 May  6 13:23 ../
drwxr-x---  4 root root  4096 May  6 13:50 build/
drwxr-x---  3 root root  4096 May  6 13:23 cmd/
drwxr-x---  3 root root  4096 May  6 13:50 deploy/
drwxr-xr-x  8 root root  4096 May  6 13:42 .git/
-rw-r--r--  1 root root  1204 May  6 13:23 .gitignore
-rw-r--r--  1 root root 30706 May  6 13:26 Gopkg.lock
-rw-r--r--  1 root root  2042 May  6 13:23 Gopkg.toml
drwxr-x---  4 root root  4096 May  6 13:23 pkg/
drwxr-xr-x 12 root root  4096 May  6 13:25 vendor/
drwxr-x---  2 root root  4096 May  6 13:23 version/
$
$ operator-sdk add controller --api-version=app.example.com/v1alpha1 --kind=AppService
INFO[0000] Generating controller version app.example.com/v1alpha1 for kind AppService.
INFO[0000] Created pkg/controller/appservice/appservice_controller.go
INFO[0000] Created pkg/controller/add_appservice.go
INFO[0000] Controller generation complete.
$
$ ll
total 76
drwxr-x---  9 root root  4096 May  6 13:26 ./
drwxr-xr-x  3 root root  4096 May  6 13:23 ../
drwxr-x---  4 root root  4096 May  6 13:50 build/
drwxr-x---  3 root root  4096 May  6 13:23 cmd/
drwxr-x---  3 root root  4096 May  6 13:50 deploy/
drwxr-xr-x  8 root root  4096 May  6 13:42 .git/
-rw-r--r--  1 root root  1204 May  6 13:23 .gitignore
-rw-r--r--  1 root root 30706 May  6 13:26 Gopkg.lock
-rw-r--r--  1 root root  2042 May  6 13:23 Gopkg.toml
drwxr-x---  4 root root  4096 May  6 13:23 pkg/
drwxr-xr-x 12 root root  4096 May  6 13:25 vendor/
drwxr-x---  2 root root  4096 May  6 13:23 version/
$
$ ll pkg
total 16
drwxr-x--- 4 root root 4096 May  6 13:23 ./
drwxr-x--- 9 root root 4096 May  6 13:26 ../
drwxr-x--- 3 root root 4096 May  6 13:50 apis/
drwxr-x--- 3 root root 4096 May  6 13:56 controller/
```

```
$ operator-sdk add api --api-version=app.example.com/v1alpha1 --kind=AppService
INFO[0000] Generating api version app.example.com/v1alpha1 for kind AppService.
INFO[0000] Created pkg/apis/app/v1alpha1/appservice_types.go
INFO[0000] Created pkg/apis/addtoscheme_app_v1alpha1.go
INFO[0000] Created pkg/apis/app/v1alpha1/register.go
INFO[0000] Created pkg/apis/app/v1alpha1/doc.go
INFO[0000] Created deploy/crds/app_v1alpha1_appservice_cr.yaml
W0507 01:44:51.766264   30589 parse.go:239] Ignoring child directory github.com/example-inc/app-operator/pkg/apis/app: No files for pkg "github.com/example-inc/app-operator/pkg/apis/app"
INFO[0002] Created deploy/crds/app_v1alpha1_appservice_crd.yaml
INFO[0008] Running deepcopy code-generation for Custom Resource group versions: [app:[v1alpha1], ]
INFO[0009] Code-generation complete.
INFO[0013] Running OpenAPI code-generation for Custom Resource group versions: [app:[v1alpha1], ]
2019/05/07 01:45:04 Code for OpenAPI definitions generated
INFO[0014] Created deploy/crds/app_v1alpha1_appservice_crd.yaml
INFO[0014] Code-generation complete.
INFO[0014] API generation complete.
$
$ find ./ -mmin 1
./deploy
./deploy/crds
./deploy/crds/app_v1alpha1_appservice_cr.yaml
./deploy/crds/app_v1alpha1_appservice_crd.yaml
./deploy/role.yaml
./pkg/apis
./pkg/apis/addtoscheme_app_v1alpha1.go
./pkg/apis/app
./pkg/apis/app/v1alpha1
./pkg/apis/app/v1alpha1/appservice_types.go
./pkg/apis/app/v1alpha1/zz_generated.deepcopy.go
./pkg/apis/app/v1alpha1/zz_generated.openapi.go
./pkg/apis/app/v1alpha1/register.go
./pkg/apis/app/v1alpha1/doc.go
./build
./build/_output
./build/_output/bin
./build/_output/bin/deepcopy-gen
./build/_output/bin/openapi-gen
./build/_output/bin/lister-gen
./build/_output/bin/informer-gen
./build/_output/bin/client-gen

$ operator-sdk add controller --api-version=app.example.com/v1alpha1 --kind=AppService && find . -mmin 1
INFO[0000] Generating controller version app.example.com/v1alpha1 for kind AppService.
INFO[0000] Created pkg/controller/appservice/appservice_controller.go
INFO[0000] Created pkg/controller/add_appservice.go
INFO[0000] Controller generation complete.
./pkg/controller
./pkg/controller/appservice
./pkg/controller/appservice/appservice_controller.go
./pkg/controller/add_appservice.go
```

## 3.4 替换operator.yaml文件里的镜像，用我们build的本地仓库的镜像进行替换。

> cp deploy/operator.yaml deploy/operator.yamlbak && sed -i 's|REPLACE_IMAGE|127.0.0.1:5000/quay.io/example/app-operator|g' deploy/operator.yaml && diff deploy/operator.yaml deploy/operator.yamlbak

## 3.5 后面就是创建crd,sa,role,rolebinding,cr等，不再赘述。
