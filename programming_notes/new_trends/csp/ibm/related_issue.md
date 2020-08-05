
## `not enough arguments in call to metrics.Register`

```sh
{root@bandore1 hybridapp-operator}$ operator-sdk run --local --watch-namespace=""
Flag --local has been deprecated, use 'run local' instead
Flag --watch-namespace has been deprecated, use this flag with 'run local' instead
INFO[0000] Running the operator locally; watching namespace ""
# sigs.k8s.io/controller-runtime/pkg/metrics
/root/go/pkg/mod/sigs.k8s.io/controller-runtime@v0.6.0/pkg/metrics/client_go_adapter.go:133:24: not enough arguments in call to metrics.Register
/root/go/pkg/mod/sigs.k8s.io/controller-runtime@v0.6.0/pkg/metrics/client_go_adapter.go:133:25: undefined: metrics.RegisterOpts
# sigs.k8s.io/controller-runtime/pkg/client
/root/go/pkg/mod/sigs.k8s.io/controller-runtime@v0.6.0/pkg/client/typed_client.go:46:5: too many arguments in call to o.resourceMeta.Interface.Post().NamespaceIfScoped(o.Object.GetNamespace(), o.resourceMeta.isNamespaced()).Resource(o.resourceMeta.resource()).Body(obj).VersionedParams(createOpts.AsCreateOptions(), c.paramCodec).Do
        have (context.Context)
        want ()
/root/go/pkg/mod/sigs.k8s.io/controller-runtime@v0.6.0/pkg/client/typed_client.go:65:5: too many arguments in call to o.resourceMeta.Interface.Put().NamespaceIfScoped(o.Object.GetNamespace(), o.resourceMeta.isNamespaced()).Resource(o.resourceMeta.resource()).Name(o.Object.GetName()).Body(obj).VersionedParams(updateOpts.AsUpdateOptions(), c.paramCodec).Do
        have (context.Context)
        want ()
```

// 升级hybridapp-operator的dependency到RHACM 2.0时报了类似下面issue里的错误。但这个issue没有任何解决办法。。。
- build(deps): Bump sigs.k8s.io/controller-runtime from 0.3.0 to 0.6.0 https://github.com/Maistra/istio-workspace/pull/423
  
// 我的是从0.5.2到0.6.0，看了下接口确实变了。
- https://github.com/kubernetes-sigs/controller-runtime/blob/release-0.6/pkg/metrics/client_go_adapter.go#L133
- https://github.com/kubernetes-sigs/controller-runtime/blob/release-0.5/pkg/metrics/client_go_adapter.go#L133

// 但最后还是无脑地改成了[这里] (https://github.com/open-cluster-management/multicloud-operators-subscription/blob/release-2.0/go.mod) 的依赖，然后过去了。之前不知道为什么`go mod tidy`整理不了。
