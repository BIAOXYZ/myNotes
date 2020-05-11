
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
