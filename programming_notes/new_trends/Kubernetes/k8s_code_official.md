
# `#` controller-runtime

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## [package manager] (https://godoc.org/sigs.k8s.io/controller-runtime/pkg/manager)

### pkg/manager/internal.go

- `func (cm *controllerManager) GetClient() client.Client {` https://github.com/kubernetes-sigs/controller-runtime/blob/fe0e7596fb90a87d024e1d80266b087adbbd36b8/pkg/manager/internal.go#L329

////////////////////////////////////////////////////////////////////////////////////////////////////

- `type controllerManager struct {` https://github.com/kubernetes-sigs/controller-runtime/blob/32b4434331/pkg/manager/internal.go#L58
- `func (cm *controllerManager) Add(r Runnable) error {` https://github.com/kubernetes-sigs/controller-runtime/blob/32b4434331/pkg/manager/internal.go#L212

### pkg/manager/manager.go

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

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## [package cache] (https://godoc.org/sigs.k8s.io/controller-runtime/pkg/cache)

https://github.com/kubernetes-sigs/controller-runtime/blob/b6d18c7c04ab33fe8671cb9cfb2e062b06aa4054/pkg/cache/cache.go

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## [package client] (https://godoc.org/sigs.k8s.io/controller-runtime/pkg/client)

### pkg/client/client.go

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

### pkg/client/typed_client.go

`type typedClient struct {` https://github.com/kubernetes-sigs/controller-runtime/blob/b6d18c7c04/pkg/client/typed_client.go#L27

### pkg/client/client_cache.go

`type clientCache struct {` https://github.com/kubernetes-sigs/controller-runtime/blob/b6d18c7c04ab33fe8671cb9cfb2e062b06aa4054/pkg/client/client_cache.go#L33:6

### pkg/client/interfaces.go

- `type Client interface {` https://github.com/kubernetes-sigs/controller-runtime/blob/b6d18c7c04/pkg/client/interfaces.go#L104
  ```go
  // Client knows how to perform CRUD operations on Kubernetes objects.
  type Client interface {
  	Reader
  	Writer
  	StatusClient
  }
  ```

## [[package config]] ((https://godoc.org/sigs.k8s.io/controller-runtime/pkg/client/config))

### pkg/client/config/config.go
- `func GetConfig() (*rest.Config, error) {` https://github.com/kubernetes-sigs/controller-runtime/blob/39ddbc7bb0c23cde453d59fdc6d20f977df318e8/pkg/client/config/config.go#L64

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` client-go

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## package rest

`type Config struct {` 【`rest.Config`】 https://github.com/kubernetes/client-go/blob/release-1.18/rest/config.go#L52

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` apimachinery

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## [[[package v1]]] (https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1)

### pkg/apis/meta/v1/time.go

- `type Time struct {` 【`metav1.Time`】 https://github.com/kubernetes/apimachinery/blob/release-1.18/pkg/apis/meta/v1/time.go#L33

### pkg/apis/meta/v1/types.go

- `type TypeMeta struct {` https://github.com/kubernetes/apimachinery/blob/release-1.18/pkg/apis/meta/v1/types.go#L41
- `type ObjectMeta struct {` https://github.com/kubernetes/kubernetes/blob/release-1.18/staging/src/k8s.io/apimachinery/pkg/apis/meta/v1/types.go#L110 【[:star:][`*`]】 || https://github.com/kubernetes/apimachinery/blob/release-1.18/pkg/apis/meta/v1/types.go#L110

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## [package runtime] (https://godoc.org/k8s.io/apimachinery/pkg/runtime)

### pkg/runtime/interfaces.go

- `type Decoder interface {` https://github.com/kubernetes/apimachinery/blob/release-1.18/pkg/runtime/interfaces.go#L73
- `type Object interface {` https://github.com/kubernetes/apimachinery/blob/release-1.18/pkg/runtime/interfaces.go#L299
  * > runtime.RawExtension里的Object成员就是这个接口类型。

### pkg/runtime/register.go 

- `func (obj *TypeMeta) SetGroupVersionKind(gvk schema.GroupVersionKind) {` https://github.com/kubernetes/apimachinery/blob/release-1.18/pkg/runtime/register.go#L22
- `func (obj *TypeMeta) GroupVersionKind() schema.GroupVersionKind {` https://github.com/kubernetes/apimachinery/blob/release-1.18/pkg/runtime/register.go#L27

### pkg/runtime/scheme.go

`type Scheme struct {` 【`runtime.Scheme`】 https://github.com/kubernetes/apimachinery/blob/release-1.18/pkg/runtime/scheme.go#47

### pkg/runtime/types.go

- `type RawExtension struct {` 【`runtime.RawExtension`】 https://github.com/kubernetes/apimachinery/blob/release-1.18/pkg/runtime/types.go#L94
  * 【[:star:][`*`]】 Golang RawExtension.Object Examples https://golang.hotexamples.com/examples/k8s.io.kubernetes.pkg.runtime/RawExtension/Object/golang-rawextension-object-method-examples.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` apiextensions-apiserver

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## [[[package clientset]]] (((https://godoc.org/k8s.io/apiextensions-apiserver/pkg/client/clientset/clientset)))

### pkg/client/clientset/clientset/clientset.go
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

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## [[[[[[package v1beta1]]]]]] ((((((https://godoc.org/k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1beta1))))))

### pkg/client/clientset/clientset/typed/apiextensions/v1beta1/customresourcedefinition.go
- `func (c *customResourceDefinitions) Get(name string, options v1.GetOptions) (result *v1beta1.CustomResourceDefinition, err error) {` https://github.com/kubernetes/apiextensions-apiserver/blob/b67f03be04/pkg/client/clientset/clientset/typed/apiextensions/v1beta1/customresourcedefinition.go#L65

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` api

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## [package v1] (https://godoc.org/k8s.io/api/core/v1)

### core/v1/types.go

- `type Pod struct {` https://github.com/kubernetes/api/blob/release-1.18/core/v1/types.go#L3537
- `type ObjectReference struct {` 【`corev1.ObjectReference`】 https://github.com/kubernetes/api/blob/release-1.18/core/v1/types.go#L5044

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` operator-sdk

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## [package k8sutil] (https://godoc.org/github.com/operator-framework/operator-sdk/pkg/k8sutil)

### pkg/k8sutil/k8sutil.go 

`func GetGVKsFromAddToScheme(addToSchemeFunc func(*runtime.Scheme) error) ([]schema.GroupVersionKind, error) {` https://github.com/operator-framework/operator-sdk/blob/4622d6bb7eb6e1f09256a28b19ebd6b9ac1c91ea/pkg/k8sutil/k8sutil.go#L145

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
