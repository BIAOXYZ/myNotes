
# 官方github源码

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `##` controller-runtime

### [package manager] (https://godoc.org/sigs.k8s.io/controller-runtime/pkg/manager)

#### pkg/manager/internal.go

- `func (cm *controllerManager) GetClient() client.Client {` https://github.com/kubernetes-sigs/controller-runtime/blob/fe0e7596fb90a87d024e1d80266b087adbbd36b8/pkg/manager/internal.go#L329

////////////////////////////////////////////////////////////////////////////////////////////////////

- `type controllerManager struct {` https://github.com/kubernetes-sigs/controller-runtime/blob/32b4434331/pkg/manager/internal.go#L58
- `func (cm *controllerManager) Add(r Runnable) error {` https://github.com/kubernetes-sigs/controller-runtime/blob/32b4434331/pkg/manager/internal.go#L212

#### pkg/manager/manager.go

- `type Manager interface {` https://github.com/kubernetes-sigs/controller-runtime/blob/32b4434331e72fed344f71d278982827e08db2a8/pkg/manager/manager.go#L46
  ```go
  // Manager initializes shared dependencies such as Caches and Clients, and provides them to Runnables.
  // A Manager is required to create Controllers.
  type Manager interface {
  	// Add will set requested dependencies on the component, and cause the component to be
  	// started when Start is called.  Add will inject any dependencies for which the argument
  	// implements the inject interface - e.g. inject.Client.
  	// Depending on if a Runnable implements LeaderElectionRunnable interface, a Runnable can be run in either
  	// non-leaderelection mode (always running) or leader election mode (managed by leader election if enabled).
  	Add(Runnable) error
  
  	// Elected is closed when this manager is elected leader of a group of
  	// managers, either because it won a leader election or because no leader
  	// election was configured.
  	Elected() <-chan struct{}
  
  	// SetFields will set any dependencies on an object for which the object has implemented the inject
  	// interface - e.g. inject.Client.
  	SetFields(interface{}) error
  
  //// 还有很多，省略。。。这里只想说明的是： pkg/manager/internal.go 里的 controllerManager 结构体
  //// 实现了一个具体的Manager接口。比如： `Add(r Runnable) error` 方法。
  ```
- `type Options struct {` https://github.com/kubernetes-sigs/controller-runtime/blob/32b4434331e72fed344f71d278982827e08db2a8/pkg/manager/manager.go#L114 【这个Options结构体比`pkg/client/client.go`里的Options结构体严格多出很多成员，因为太长就不贴完整代码了】
  ```go
  // Options are the arguments for creating a new Manager
  type Options struct {
  	// Scheme is the scheme used to resolve runtime.Objects to GroupVersionKinds / Resources
  	// Defaults to the kubernetes/client-go scheme.Scheme, but it's almost always better
  	// idea to pass your own scheme in.  See the documentation in pkg/scheme for more information.
  	Scheme *runtime.Scheme
  
  	// MapperProvider provides the rest mapper used to map go types to Kubernetes APIs
  	MapperProvider func(c *rest.Config) (meta.RESTMapper, error)
  	
  ////剩下的成员不贴了。。。
  ```
- `func New(config *rest.Config, options Options) (Manager, error) {` https://github.com/kubernetes-sigs/controller-runtime/blob/32b4434331e72fed344f71d278982827e08db2a8/pkg/manager/manager.go#L246

### [package cache] (https://godoc.org/sigs.k8s.io/controller-runtime/pkg/cache)

https://github.com/kubernetes-sigs/controller-runtime/blob/b6d18c7c04ab33fe8671cb9cfb2e062b06aa4054/pkg/cache/cache.go

### [package client] (https://godoc.org/sigs.k8s.io/controller-runtime/pkg/client)

#### pkg/client/client.go

- `func New(config *rest.Config, options Options) (Client, error) {` 【`client.New(config, options)`】 https://github.com/kubernetes-sigs/controller-runtime/blob/b6d18c7c04ab33fe8671cb9cfb2e062b06aa4054/pkg/client/client.go#L52
- `type Options struct {` 【`client.Options`】 https://github.com/kubernetes-sigs/controller-runtime/blob/b6d18c7c04ab33fe8671cb9cfb2e062b06aa4054/pkg/client/client.go#L34
  ```go
  // Options are creation options for a Client
  type Options struct {
  	// Scheme, if provided, will be used to map go structs to GroupVersionKinds
  	Scheme *runtime.Scheme
  
  	// Mapper, if provided, will be used to map GroupVersionKinds to Resources
  	Mapper meta.RESTMapper
  }
  ```
- `type client struct {` 【`client.Client`】 https://github.com/kubernetes-sigs/controller-runtime/blob/b6d18c7c04ab33fe8671cb9cfb2e062b06aa4054/pkg/client/client.go#L97
  ```go
  // client is a client.Client that reads and writes directly from/to an API server.  It lazily initializes
  // new clients at the time they are used, and caches the client.
  type client struct {
	  typedClient        typedClient
	  unstructuredClient unstructuredClient
  }
  ```
- `func (c *client) Status() StatusWriter {` https://github.com/kubernetes-sigs/controller-runtime/blob/b6d18c7c04/pkg/client/client.go#L178
  ```go
  // Status implements client.StatusClient
  func (c *client) Status() StatusWriter {
  	return &statusWriter{client: c}
  }
  ```

#### pkg/client/typed_client.go

`type typedClient struct {` https://github.com/kubernetes-sigs/controller-runtime/blob/b6d18c7c04/pkg/client/typed_client.go#L27

#### pkg/client/client_cache.go

`type clientCache struct {` https://github.com/kubernetes-sigs/controller-runtime/blob/b6d18c7c04ab33fe8671cb9cfb2e062b06aa4054/pkg/client/client_cache.go#L33:6

#### pkg/client/interfaces.go

- `type Client interface {` https://github.com/kubernetes-sigs/controller-runtime/blob/b6d18c7c04/pkg/client/interfaces.go#L104
  ```go
  // Client knows how to perform CRUD operations on Kubernetes objects.
  type Client interface {
  	Reader
  	Writer
  	StatusClient
  }
  ```

### [[package config]] ((https://godoc.org/sigs.k8s.io/controller-runtime/pkg/client/config))

#### pkg/client/config/config.go
- `func GetConfig() (*rest.Config, error) {` https://github.com/kubernetes-sigs/controller-runtime/blob/39ddbc7bb0c23cde453d59fdc6d20f977df318e8/pkg/client/config/config.go#L64

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `##` client-go

### package rest

`type Config struct {` 【`rest.Config`】 https://github.com/kubernetes/client-go/blob/release-1.18/rest/config.go#L52

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `##` apimachinery

### package runtime

`type Scheme struct {` 【`runtime.Scheme`】 https://github.com/kubernetes/apimachinery/blob/release-1.18/pkg/runtime/scheme.go#47

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `##` apiextensions-apiserver

### [[[package clientset]]] (((https://godoc.org/k8s.io/apiextensions-apiserver/pkg/client/clientset/clientset)))

#### pkg/client/clientset/clientset/clientset.go
- `type Clientset struct {` https://github.com/kubernetes/apiextensions-apiserver/blob/b67f03be04c227253425b766ea8cdf1c15cc9dae/pkg/client/clientset/clientset/clientset.go#L39
  ```go
  // Clientset contains the clients for groups. Each group has exactly one
  // version included in a Clientset.
  type Clientset struct {
  	*discovery.DiscoveryClient
  	apiextensionsV1beta1 *apiextensionsv1beta1.ApiextensionsV1beta1Client
  	apiextensionsV1      *apiextensionsv1.ApiextensionsV1Client
  }
  ```
- `func NewForConfig(c *rest.Config) (*Clientset, error) {` https://github.com/kubernetes/apiextensions-apiserver/blob/b67f03be04c227253425b766ea8cdf1c15cc9dae/pkg/client/clientset/clientset/clientset.go#L66

### [[[[[[package v1beta1]]]]]] ((((((https://godoc.org/k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1beta1))))))

#### pkg/client/clientset/clientset/typed/apiextensions/v1beta1/customresourcedefinition.go
- `func (c *customResourceDefinitions) Get(name string, options v1.GetOptions) (result *v1beta1.CustomResourceDefinition, err error) {` https://github.com/kubernetes/apiextensions-apiserver/blob/b67f03be04/pkg/client/clientset/clientset/typed/apiextensions/v1beta1/customresourcedefinition.go#L65

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` api

## [package v1] (https://godoc.org/k8s.io/api/core/v1)

### core/v1/types.go

- `type Pod struct {` https://github.com/kubernetes/api/blob/release-1.18/core/v1/types.go#L3537
- `type ObjectReference struct {` 【`corev1.ObjectReference`】 https://github.com/kubernetes/api/blob/release-1.18/core/v1/types.go#L5044

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` operator-sdk

## [package k8sutil] (https://godoc.org/github.com/operator-framework/operator-sdk/pkg/k8sutil)

### pkg/k8sutil/k8sutil.go 

`func GetGVKsFromAddToScheme(addToSchemeFunc func(*runtime.Scheme) error) ([]schema.GroupVersionKind, error) {` https://github.com/operator-framework/operator-sdk/blob/4622d6bb7eb6e1f09256a28b19ebd6b9ac1c91ea/pkg/k8sutil/k8sutil.go#L145

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Kubernetes源码分析系列文章

随笔分类 - 《看懂每一行代码 - kubernetes》 https://www.cnblogs.com/cloudgeek/category/1231156.html
- 写在最前面 - 《看懂每一行代码 - kubernetes》 https://www.cnblogs.com/cloudgeek/p/9194998.html

【by 张忠琳】：
- 【kubernetes/k8s源码分析】operator controller-runtime源码分析 https://blog.csdn.net/zhonglinzhang/article/details/105023103
- 【kubernetes/k8s源码分析】client-go Informer分析 https://blog.csdn.net/zhonglinzhang/article/details/86604491
- 【kubernetes/k8s源码分析】kube-scheduler 源码分析 https://blog.csdn.net/zhonglinzhang/article/details/77197834

【From Draveness's Blog 【面向信仰编程】】：
- 详解 Kubernetes Pod 的实现原理 https://draveness.me/kubernetes-pod
- 详解 Kubernetes Deployment 的实现原理 https://draveness.me/kubernetes-deployment
- 详解 Kubernetes DaemonSet 的实现原理 https://draveness.me/kubernetes-daemonset
- 详解 Kubernetes Job 和 CronJob 的实现原理 https://draveness.me/kubernetes-job-cronjob
- 详解 Kubernetes 垃圾收集器的实现原理 https://draveness.me/kubernetes-garbage-collector

【by 程序员欣宸】：
- Kubernetes源码学习之一:下载和编译源码 https://blog.csdn.net/boling_cavalry/article/details/88591982
- Kubernetes深入学习之二:编译和部署镜像(api-server) https://blog.csdn.net/boling_cavalry/article/details/88603293
- k8s自定义controller三部曲之一:创建CRD（Custom Resource Definition） https://blog.csdn.net/boling_cavalry/article/details/88917818

【by shida_csdn】K8S 源码探秘 https://blog.csdn.net/shida_csdn/column/info/28699
- K8S 源码探秘 之 命令行解析工具 cobra https://blog.csdn.net/shida_csdn/article/details/82979697
- 基于 sample-controller 实现自定义 CRD 控制器（Operator）的一般步骤 https://blog.csdn.net/shida_csdn/article/details/87102801
- K8s 的 UUID 是如何生成的? https://blog.csdn.net/shida_csdn/article/details/104892977

【by cloudvtech】：
- kubernetes系列之十四：Kubernetes CRD(CustomResourceDefinition)概览 https://blog.csdn.net/cloudvtech/article/details/80277960
- kubernetes系列之十六：Kubernetes CRD sample-controller的编译和测试 https://blog.csdn.net/cloudvtech/article/details/80466656

【by 哎_小羊_168】：
- Kubernetes CRD (CustomResourceDefinition) 自定义资源类型 https://blog.csdn.net/aixiaoyang168/article/details/81875907
- 使用 client-go 对 Kubernetes 进行自定义开发及源码分析 https://blog.csdn.net/aixiaoyang168/article/details/84752005

kubelet 源码分析：启动流程 https://cizixs.com/2017/06/06/kubelet-source-code-analysis-part-1/

【From 书栈网】：
- k8s-1.13版本源码分析 https://www.bookstack.cn/books/k8s-source-code-analysis
- 胡伟煌 Kubernetes 学习笔记 - 源码分析 https://www.bookstack.cn/read/huweihuang-kubernetes-notes/code-analysis.md

【by u010278923】：
- kubernetes容器启动详解 https://blog.csdn.net/u010278923/article/details/72993499
- kubelet启动pod的源码分析 https://blog.csdn.net/u010278923/article/details/78829649

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# kubeadm相关源码/流程

kubeadm源码分析（内含kubernetes离线包，三步安装） https://www.kubernetes.org.cn/4015.html

Kubernetes搭建之kubeadm-init探究 https://jingwei.link/2018/11/28/kubeadm-init-research.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# client-go相关源码

11.1. client-go的使用及源码分析 https://www.huweihuang.com/kubernetes-notes/develop/client-go.html

Kubernetes源码分析：Client-go https://supereagle.github.io/2017/07/16/k8s-clientgo/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# controller相关源码

如何基于kubernetes开发自定义的Controller https://blog.csdn.net/jiangmingjun1234/article/details/79296542
- > [源码分析] client-go的使用及源码分析 https://www.huweihuang.com/article/source-analysis/client-go-source-analysis/

利用 kubebuilder 优化 Kubernetes Operator 开发体验 - 高策的文章 - 知乎 https://zhuanlan.zhihu.com/p/67406200 || 利用 kubebuilder 优化 Kubernetes Operator 开发体验 - 才云Caicloud的文章 - 知乎 https://zhuanlan.zhihu.com/p/69423429

【How we built a controller using KubeBuilder with Test Driven development】：
- How we built a controller using KubeBuilder with Test Driven development, Part 1 https://engineering.pivotal.io/post/gp4k-kubebuilder-lessons/
- How we built a controller using KubeBuilder with test-driven development, Part 2 https://engineering.pivotal.io/post/gp4k-kubebuilder-tdd/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# finalizer相关源码

kube-controller分析(二)-finalizer机制-v1.5.2 https://fankangbest.github.io/2017/10/24/kube-controller%E5%88%86%E6%9E%90(%E4%BA%8C)-finalizer%E6%9C%BA%E5%88%B6-v1-5-2/

Kubernetes 实战-Operator Finalizers 实现 https://zdyxry.github.io/2019/09/13/Kubernetes-%E5%AE%9E%E6%88%98-Operator-Finalizers/

Using Finalizers https://github.com/kubernetes-sigs/kubebuilder/blob/8b53abeb4280186e494b726edf8f54ca7aa64a49/docs/book/src/reference/using-finalizers.md

Kubernetes CRD Finalizer https://stackoverflow.com/questions/53057185/kubernetes-crd-finalizer
> This sample repository show demo use of Finalizer and Initializer. Finalizer are used here for garbage collection.
>> Practice code for kubernetes initializer and finalizer https://github.com/hossainemruz/k8s-initializer-finalizer-practice

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 待分类源码分析

编译和运行Kubernetes源码 https://www.kubernetes.org.cn/5033.html

使用VS code 调试 Kubernetes 源代码 https://blog.csdn.net/cloudnativeapp/article/details/79213731

kube-proxy源码解析 https://segmentfault.com/a/1190000015379277

Kubernetes CronJob Controller源码分析 https://www.ichenfu.com/2018/05/10/k8s-cronjob-source-code/

kubernetes源码阅读 kubelet初探 - fanbin的文章 - 知乎 https://zhuanlan.zhihu.com/p/35710779

🤔 What happens when I type kubectl run? https://github.com/jamiehannaford/what-happens-when-k8s

Kubernetes scheduler学习笔记 https://mp.weixin.qq.com/s/EWXHBDV562qsJcMz1_psRA

Kubernetes1.5源码分析(二) apiServer之资源注册 https://segmentfault.com/a/1190000008700595

K8S日志库源码分析：klog https://bamboox.online/2019/10/01/k8s-klog/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
