
# Go故障处理

## `no new variables on left side of :=`

no new variables on left side of := https://errorsingo.com/compliation-no-new-variables-on-left-side-of/

no new variables on left side of := https://stackoverflow.com/questions/13329154/no-new-variables-on-left-side-of

>> notes：上面的链接里的情况都是对已有变量再次使用`:=`造成的（`:=`是既声明又赋值，所以对已经声明过的变量再用肯定报错），但我是因为不太一样的情况：
```go
// 最初的语句
crd, err := crdClient.ApiextensionsV1beta1().CustomResourceDefinitions().Get(crdobj.GetName(), metav1.GetOptions{})

// 但是这个crd在我要的功能里用不着，Go语言里声明了变量但是不用也不行，所以改成了下面的形式：
_, err := crdClient.ApiextensionsV1beta1().CustomResourceDefinitions().Get(crdobj.GetName(), metav1.GetOptions{})

// 然后vscode就提示 `no new variables on left side of :=`了，正确的改法是下面的：
_, err = crdClient.ApiextensionsV1beta1().CustomResourceDefinitions().Get(crdobj.GetName(), metav1.GetOptions{})
```

## `panic: runtime error: invalid memory address or nil pointer dereference`

Go 指针声明后赋值，出现 panic: runtime error: invalid memory address or nil pointer dereference https://blog.csdn.net/qq_36431213/article/details/82967982

Invalid memory address or nil pointer dereference https://yourbasic.org/golang/gotcha-nil-pointer-dereference/

## `invalid composite literal type xxx`

https://github.com/golang/tour/issues/191#issuecomment-508743525
> I have had the same issue. I don't think the tour mentions how to initialise types that are based on built-in types. i.e.
> `type ErrNegativeSqrt float64`
> 
> The [page before](https://tour.golang.org/methods/19) shows how to initialise a struct-based error type:
> `type MyError struct {...}`
> ` return &MyError{ time.Now(), "it didn't work", }`
> but, unintuitively, ErrNegativeSqrt has to be created with () instead of {} and its address cannot be taken directly with & so that `&MyError{...}` in [tour.golang.org/methods/19](https://tour.golang.org/methods/19) needs to be `ErrNegativeSqrt(...)` in [tour.golang.org/methods/20](https://tour.golang.org/methods/20).
> 
> The problem is fairly subtle and almost impossible to Google using either the error messages or keywords like "type float golang literal".

```go
// https://github.com/open-cluster-management/multicloud-operators-deployable/blob/a429faaac3b4f41434b9ac37aa75dde152a94e2a/pkg/apis/app/v1alpha1/deployable_types.go#L99
type DeployablePhase string

// 下面用大括号就是错的（vscode里鼠标放上去报错信息为 "invalid composite literal type v1alpha1.DeployablePhase"）：
testPhase := ibmdeployablev1alpha1.DeployablePhase{"Propagated"}

// 改成用小括号就对了：
testPhase := ibmdeployablev1alpha1.DeployablePhase("Propagated")
```
