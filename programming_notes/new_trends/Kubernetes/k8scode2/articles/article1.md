
kubernetes https://blog.csdn.net/weixin_42663840/category_7840867.html

深入浅出kubernetes之client-go的Indexer https://blog.csdn.net/weixin_42663840/article/details/81530606

深入浅出kubernetes之client-go的SharedInformer https://blog.csdn.net/weixin_42663840/article/details/81699303
- > 在开始本文内容前，请先阅读《[深入浅出kubernetes之client-go的indexer](https://blog.csdn.net/weixin_42663840/article/details/81530606)》和《[深入浅出kubernetes之client-go的DeltaFIFO](https://blog.csdn.net/weixin_42663840/article/details/81626789)》。

# 1

深入剖析kubernetes的API对象类型定义 https://blog.csdn.net/weixin_42663840/article/details/102558455
- > **1.背景**
  * > 在初学kuberentes的时候，笔者作为码农就非常好奇它的代码实现。于是开始git clone代码，首先就被kuberentes的代码仓库搞蒙了，kuberentes项目有好多仓库，包括`kubernetes`、`client-go`、`api`、`apimachinery`...，我该从哪儿看起？索性就从kubernetes的API对象的定义开始看吧，***跟api有关的仓库有两个`api`、`apimachinery`，同时在`apimachinery仓库`中还有`api、apis两个包`，貌似他们都有`types.go`、`meta.go`、`interface.go`***。此时笔者的心情真是难以言表，但是好奇心又怂恿自己弄明白原理，于是也就有了这篇类似总结的文章。希望本文能够帮助读者初步了解kubernetes代码，成为一篇比较基础的入门文章。
- > **2.分析**
  * > 以前，在笔者印象中API都是各种接口，比较典型的就是操作系统的API。一提到API默认就是函数定义，直到REST API流行起来，API的虽然形式上不再是函数，但是原理上是一样的，只是接口的服务端从本地变成了远程。其实笔者一直都忽略了API的另一个重点，那就是接口类型，也就是接口函数的参数类型，它也是API的一部分。笔者认为：***<ins>操作系统的API强调方法，为方法设计参数类型居多，而Rest API的强调资源，而方法就那么几个</ins>***。在了解一个系统的Rest API时首先就要看有哪些资源，这些资源如何定义，支持哪些操作等等。
  * > kubernetes对外提供的就是Rest API，只是这部分被`client-go`这个项目封装成了类似SDK的形态。而apisever提供的就是基于API对象的各种操作，本文目标是探究一下API对象在kubernetes内部是如何定义以及实现的。
- > **2.1 api**
  * > 现在就来看看kubernetes中Pod类型是如何定义的：
    ```go
    // 代码源自k8s.io/api/core/v1/types.go
    // kubernetes的API对象是单独的git仓库(https://github.com/kubernetes/api.git)，可见API对象
    // 在kubernetes项目中的重要程度。
    type Pod struct {
        // metav1是"k8s.io/apimachinery/pkg/apis/meta/v1"的重命名。额...，apimachinery又是
        // 什么鬼？apis包又是干啥的？起初笔者被这些名字搞得云里雾里，但所有的这些迷雾都会在本文揭开，此处
        // 读者只需要知道这个是类型的meta。那什么又是类型的meta呢？以普通类型int32为例，类型名称
        // “int32”、类型占用内存空间4字节就是类型的meta，简单的说就是类型属性的描述。而kubernetes的
        // API对象的类型meta是如何定义的，后面会有单独章节详细说明。
        metav1.TypeMeta `json:",inline"`
        // 同样是metav1包，这回是对象的meta。同样以int32为例，对象的地址就属于对象meta。在kubernetes
        // 中，API对象都有自己的属性，并且他们都有相同的属性，例如名字、命名空间、标签等等。kuberentes把
        // 这些公共的属性提取出来就是metav1.ObjectMeta，成为了API对象类型的父类。
        metav1.ObjectMeta `json:"metadata,omitempty" protobuf:"bytes,1,opt,name=metadata"`
        // 从名字上看还是比较好理解的，就是Pod规格，最为代表性的就是CPU、内存的资源使用。它和xxx.yaml中
        // spec是关联的。PodSpec不作为本文的说明重点，所以不再详细解释。
        Spec PodSpec `json:"spec,omitempty" protobuf:"bytes,2,opt,name=spec"`
        // Pod的状态，比如是运行还是挂起、Pod的IP、启动时间等等。
        Status PodStatus `json:"status,omitempty" protobuf:"bytes,3,opt,name=status"`
    }
    ```
  * > 从Pod的定义来看，它继承了`metav1.TypeMeta`和`metav1.ObjectMeta`两个类型，同时还定义了`Spec`和`Status`两个成员变量。其实kubernetes绝大部分API对象的类型都是这个结构，他们都继承metav1.TypeMeta和metav1.ObjectMeta，前者用于定义类型的属性，后者用于定义对象的公共属性；Spec用于定义API对象类型的私有属性，也是API对象之间的区别所在(例如Pod和Deployment虽然都继承了两个父类，但是他们二者的区别就是通过Spec实现的。就像是同一对父母的两个孩子，有像的地方，更多的还是不像的地方让他们成为了两个独立的个体，这就是继承的魅力所在)；Status则是用于描述每个对象的状态的，这和每个对象的类型紧密相关的。***细心的读者不难发现，`metav1.TypeMeta`和`metav1.ObjectMeta`对应的是xxx.yaml中的`kind`、`apiVersion`和`metadata`字段，`Spec`对应xxx.yaml中`spec`字段。这一点在代码注释`json:...`可以证实，这里也可以得出另一个结论，那就是xxx.yaml就是Pod类型yaml的序列化***。所以，kubectl create -f xxx.yaml就等同于new(Pod)。
    > 
    > ***此处要对`metav1.TypeMeta`和`metav1.ObjectMeta`多说两句，可以把他们两个看做是kubernetes全部API对象的基类***，类似java中的Object类。语言因为有编译器的存在，类似metav1.TypeMeta的东西被编译屏蔽了，所以开发者看到的所有的类继承于Object。***但在kubernetes中，每个API对象都需要`metav1.TypeMeta`字段用于描述自己是什么类型，这样才能构造相应类型的对象，所以相同类型的所有对象的`metav1.TypeMeta`字段都是相同的***。但是`metav1.ObjectMeta`则不同，***它是定义对象的公共属性，即所有对象都应该具备的属性。这部分就是和对象本身相关，和类型无关，所以相同类型的所有对象的`metav1.ObjectMeta`可能是不同的***。
  * > 在kubernetes的API对象中除了***单体对象***外，还有***对象列表***类型，用于描述一组对象，等同于golang中的slice。对象列表的典型应用场景就是列举，对象列表就可以表达一组对象。可能有些读者会问***为什么不用对象的slice，例如`[]Pod`***，伴随着笔者对对象列表的解释读者就会理解，此处以`PodList`为例进行分析：
    ```go
    // 代码源自k8s.io/api/core/v1/types.go
    type PodList struct {
        // PodList同样需要继承metav1.TypeMeta，毕竟对象列表也好、单体对象也好都需要类型属性。
        // PodList比[]Pod类型在yaml或者json表达上多了类型描述，当需要根据yaml构建对象列表的时候，
        // 就可以根据类型描述反序列成为PodList。而[]Pod则不可以，他必须确保yaml就是[]Pod序列化的
        // 结果，否则就会报错。这就无法实现一个通用的对象序列化/反序列化。
        metav1.TypeMeta `json:",inline"`
        // 与Pod不同，PodList继承了metav1.ListMeta，metav1.ListMeta是所有对象类表类型的父类，
        // 他定义了所有列表类型公共属性。
        metav1.ListMeta `json:"metadata,omitempty" protobuf:"bytes,1,opt,name=metadata"`
        // Items就是PodList定义的本质了，其实就是Pod的slice。说白了PodList就是[]Pod基础上加了一些
        // 跟类型和类表相关的信息，这些信息的作用会在后面的章节做详细解释。
        Items []Pod `json:"items" protobuf:"bytes,2,rep,name=items"`
    }
    ```
  * > 前面已经解释了Pod的定义，`PodList`就不多解释了。此处做一个小结：
    ```console
    metav1.TypeMeta和metav1.ObjectMeta是所有API单体对象的父类；
    metav1.TypeMeta和metav1.ListMeta是所有API列表对象的父类；
    metav1.TypeMeta才是所有API对象的父类，这也很好理解，毕竟所有的对象都要说明自己是什么类型；
    ```
- > **2.2 `metav1`**
  * > `metav1`是`k8s.io/apimachinery/pkg/apis/meta/v1`的缩写，后文会简称为`metav1`。
- > **2.2.1 `MetaType`**
  * > 作为所有API对象的父类，是时候揭开它的真面目了：
    ```go
    // 代码源自：k8s.io/apimachinery/pkg/apis/meta/v1/types.go
    // 同样来自apimachinery仓库，ObjectMeta是xxx.yaml中metadata字段，平时我们填写的metadata
    // 一般只有name、label，其实ObjectMeta字段还是有很多内容了，让笔者逐一介绍一下。
    type ObjectMeta struct {
        // 对象的名字应该不用介绍了。
        Name string `json:"name,omitempty" protobuf:"bytes,1,opt,name=name"`
        // 如果Name为空，系统这为该对象生成一个唯一的名字。
        GenerateName string `json:"generateName,omitempty" protobuf:"bytes,2,opt,name=generateName"`
        // 命名空间，在平时学习、调试的时候很少用，但是在发布的时候会经常用。
        Namespace string `json:"namespace,omitempty" protobuf:"bytes,3,opt,name=namespace"`
        // 对象的URL，由系统生成。
        SelfLink string `json:"selfLink,omitempty" protobuf:"bytes,4,opt,name=selfLink"`
        // 对象的唯一ID，由系统生成。
        UID types.UID `json:"uid,omitempty" protobuf:"bytes,5,opt,name=uid,casttype=k8s.io/kubernetes/pkg/types.UID"`
        // 资源版本，这是一个非常有意思且变量，版本可以理解为对象在时间轴上的一个时间节点，代表着对象最后
        // 一次更新的时刻。如果说Name是在Namespace空间下唯一，那么ResourceVersion则是同名、同类型
        // 对象时间下唯一。因为同名对象在不同时间可能会更新、删除再添加，在比较两个对象谁比较新的情况
        // 非常有用，比如Watch。
        ResourceVersion string `json:"resourceVersion,omitempty" protobuf:"bytes,6,opt,name=resourceVersion"`
        // 笔者很少关注这个值，所以也不太了解是干什么的，读者感兴趣可以自己了解一下。
        Generation int64 `json:"generation,omitempty" protobuf:"varint,7,opt,name=generation"`
        // 对象创建时间，由系统生成。
        CreationTimestamp Time `json:"creationTimestamp,omitempty" protobuf:"bytes,8,opt,name=creationTimestamp"`
        // 对象删除时间，指针类型说明是可选的，当指针不为空的时候说明对象被删除了，也是由系统生成
        DeletionTimestamp *Time `json:"deletionTimestamp,omitempty" protobuf:"bytes,9,opt,name=deletionTimestamp"`
        // 对象被删除前允许优雅结束的时间，单位为秒。
        DeletionGracePeriodSeconds *int64 `json:"deletionGracePeriodSeconds,omitempty" protobuf:"varint,10,opt,name=deletionGracePeriodSeconds"`
        // 对象标签，这个是我们经常用的，不用多解释了
        Labels map[string]string `json:"labels,omitempty" protobuf:"bytes,11,rep,name=labels"`
        // 批注，这个和标签很像，但是用法不同，比如可以用来做配置。
        Annotations map[string]string `json:"annotations,omitempty" protobuf:"bytes,12,rep,name=annotations"`
        // 该对象依赖的对象类表，如果这些依赖对象全部被删除了，那么该对象也会被回收。如果该对象对象被
        // 某一controller管理，那么类表中有一条就是指向这个controller的。例如Deployment对象的
        // OwnerReferences有一条就是指向DeploymentController的。
        OwnerReferences []OwnerReference `json:"ownerReferences,omitempty" patchStrategy:"merge" patchMergeKey:"uid" protobuf:"bytes,13,rep,name=ownerReferences"`
        // 下面这几个变量笔者没有了解过，等笔者知道了再来更新文章吧。
        Finalizers []string `json:"finalizers,omitempty" patchStrategy:"merge" protobuf:"bytes,14,rep,name=finalizers"`
        ClusterName string `json:"clusterName,omitempty" protobuf:"bytes,15,opt,name=clusterName"`
        ManagedFields []ManagedFieldsEntry `json:"managedFields,omitempty" protobuf:"bytes,17,rep,name=managedFields"`
    }
     
    // 代码源自k8s.io/apimachinery/pkg/apis/meta/v1/meta.go，GetObjectMeta是MetaAccessor
    // 的接口函数，这个函数说明了ObjectMeta实现了MetaAccessor。
    func (obj *ObjectMeta) GetObjectMeta() Object { return obj }
     
    // 下面所有的函数是接口Object的ObjectMeta实现，可以看出来基本就是setter/getter方法。纳尼？
    // 又一个Object(这个Object是metav1.Object，本章节简写为Object)?Object是API对象公共属性
    // (meta信息)的抽象，下面的函数是Object所有函数的实现，因为功能比较简单，笔者就不一一注释了。
    func (meta *ObjectMeta) GetNamespace() string                { return meta.Namespace }
    func (meta *ObjectMeta) SetNamespace(namespace string)       { meta.Namespace = namespace }
    func (meta *ObjectMeta) GetName() string                     { return meta.Name }
    func (meta *ObjectMeta) SetName(name string)                 { meta.Name = name }
    func (meta *ObjectMeta) GetGenerateName() string             { return meta.GenerateName }
    func (meta *ObjectMeta) SetGenerateName(generateName string) { meta.GenerateName = generateName }
    func (meta *ObjectMeta) GetUID() types.UID                   { return meta.UID }
    func (meta *ObjectMeta) SetUID(uid types.UID)                { meta.UID = uid }
    func (meta *ObjectMeta) GetResourceVersion() string          { return meta.ResourceVersion }
    func (meta *ObjectMeta) SetResourceVersion(version string)   { meta.ResourceVersion = version }
    func (meta *ObjectMeta) GetGeneration() int64                { return meta.Generation }
    func (meta *ObjectMeta) SetGeneration(generation int64)      { meta.Generation = generation }
    func (meta *ObjectMeta) GetSelfLink() string                 { return meta.SelfLink }
    func (meta *ObjectMeta) SetSelfLink(selfLink string)         { meta.SelfLink = selfLink }
    func (meta *ObjectMeta) GetCreationTimestamp() Time          { return meta.CreationTimestamp }
    func (meta *ObjectMeta) SetCreationTimestamp(creationTimestamp Time) {
        meta.CreationTimestamp = creationTimestamp
    }
    func (meta *ObjectMeta) GetDeletionTimestamp() *Time { return meta.DeletionTimestamp }
    func (meta *ObjectMeta) SetDeletionTimestamp(deletionTimestamp *Time) {
        meta.DeletionTimestamp = deletionTimestamp
    }
    func (meta *ObjectMeta) GetDeletionGracePeriodSeconds() *int64 { return meta.DeletionGracePeriodSeconds }
    func (meta *ObjectMeta) SetDeletionGracePeriodSeconds(deletionGracePeriodSeconds *int64) {
        meta.DeletionGracePeriodSeconds = deletionGracePeriodSeconds
    }
    func (meta *ObjectMeta) GetLabels() map[string]string                 { return meta.Labels }
    func (meta *ObjectMeta) SetLabels(labels map[string]string)           { meta.Labels = labels }
    func (meta *ObjectMeta) GetAnnotations() map[string]string            { return meta.Annotations }
    func (meta *ObjectMeta) SetAnnotations(annotations map[string]string) { meta.Annotations = annotations }
    func (meta *ObjectMeta) GetFinalizers() []string                      { return meta.Finalizers }
    func (meta *ObjectMeta) SetFinalizers(finalizers []string)            { meta.Finalizers = finalizers }
    func (meta *ObjectMeta) GetOwnerReferences() []OwnerReference         { return meta.OwnerReferences }
    func (meta *ObjectMeta) SetOwnerReferences(references []OwnerReference) {
        meta.OwnerReferences = references
    }
    func (meta *ObjectMeta) GetClusterName() string                 { return meta.ClusterName }
    func (meta *ObjectMeta) SetClusterName(clusterName string)      { meta.ClusterName = clusterName }
    func (meta *ObjectMeta) GetManagedFields() []ManagedFieldsEntry { return meta.ManagedFields }
    func (meta *ObjectMeta) SetManagedFields(managedFields []ManagedFieldsEntry) {
        meta.ManagedFields = managedFields
    }
    ```
  * > `ObjectMeta`每个成员变量是干什么用的对于理解本文并没有什么帮助，对于读者来说只需要知道这些属性是所有API对象都有的公共属性。所以笔者对于每个成员变量的注释也仅仅停留在表面定义，并没有做深入的解释。
    > 
    > 此时，可以得出一个结论：***`ObjectMeta`实现了Object和MetaAccessor两个interface***，而kubernetes所有单体对象都继承了`ObjectMeta`，那么所有的API对象就都实现了Object和MetaAccessor。kubernetes中有很多地方访问API对象的这些meta信息并且不区分对象类型，Object是一个不错的选择。
- > **2.2.2 `ListMeta`**
  * > 和`ObjectMeta`功能类似，`ListMeta`定义了所有列表对象的公共属性：
    ```go
    // 代码源自：k8s.io/apimachinery/pkg/apis/meta/v1/types.go
    type ListMeta struct {
        // 下面这两个变量在ObjectMeta相同，不多解释
        SelfLink string `json:"selfLink,omitempty" protobuf:"bytes,1,opt,name=selfLink"`
        ResourceVersion string `json:"resourceVersion,omitempty" protobuf:"bytes,2,opt,name=resourceVersion"`
        // 在列举对象的时候可能会有非常多的对象，kubernetes支持分页获取，类似于SQL的limit，当对象总量
        // 多于单页的总量的时候，这个变量就会被设置。它用来告知用户需要继续获取，并且它包含了下次获取的
        // 起始位置。
        Continue string `json:"continue,omitempty" protobuf:"bytes,3,opt,name=continue"`
        // 从字面意思也能理解，就是还剩多少个对象，这个和Continue是配合使用的，当Continue被设置了
        // 这个变量就不会为空，用来告诉用户还有多少对象没有获取。
        RemainingItemCount *int64 `json:"remainingItemCount,omitempty" protobuf:"bytes,4,opt,name=remainingItemCount"`
    }
     
    // 代码源自k8s.io/apimachinery/pkg/apis/meta/v1/meta.go
    // 下面所有的函数是接口ListInterface的ListMeta实现，ListInterface是API对象列表公共属性(meta)
    // 的抽象。
    func (meta *ListMeta) GetResourceVersion() string        { return meta.ResourceVersion }
    func (meta *ListMeta) SetResourceVersion(version string) { meta.ResourceVersion = version }
    func (meta *ListMeta) GetSelfLink() string               { return meta.SelfLink }
    func (meta *ListMeta) SetSelfLink(selfLink string)       { meta.SelfLink = selfLink }
    func (meta *ListMeta) GetContinue() string               { return meta.Continue }
    func (meta *ListMeta) SetContinue(c string)              { meta.Continue = c }
    func (meta *ListMeta) GetRemainingItemCount() *int64     { return meta.RemainingItemCount }
    func (meta *ListMeta) SetRemainingItemCount(c *int64)    { meta.RemainingItemCount = c }
    ```
- > 此处做一个小结，在`metav1`包中，为API单体对象和对象列表的公共属性(meta)做了抽象，分别为`metav1.Object`和 `metav1.ListInterface`。同时，`metav1`包为这两个抽象做了实现，他们分别为`metav1.ObjectMeta`和`metav.listMeta`，API对象类型可以通过继承这些类实现抽象，是不是有一点apimachinery所定义的那样“类型”、“基础设施”的意思了？
- > **2.3 runtime**
- > **2.3.1 schema**
  * > 前文提到了`metav1.TypeMeta`实现了`schema.ObjectKind`(本节简称ObjectKind)，并且`metav1.TypeMeta`已经非常直观的和xxx.yaml的相应字段对应上了，那`ObjectKind`又是干什么的呢？
    ```go
    // 代码源自k8s.io/apimachinery/pkg/runtime/schema/interfaces.go
    // ObjectKind是接口，两个接口函数是GroupVersionKind类型的setter和getter
    type ObjectKind interface {
        SetGroupVersionKind(kind GroupVersionKind)
        GroupVersionKind() GroupVersionKind
    }
    // GroupVersionKind才是kubernetes的API对象类型真身，他包括Kind、Version和Group。其中Kind和
    // Version还比较好理解，Group又是什么？其实Group/Version才是xxx.yaml的apiVersion字段。
    // 在kuberentes中API对象是分组的，像Pod、Service、ConfigMap都属于core分组，而core分组的对象
    // 无需在apiVersion字段明文写出来，系统会默认将这类的对象归为core分组，正如文章开始那个Pod的例子。
    // 详情可以看下面的代码实现。
    type GroupVersionKind struct {
        Group   string
        Version string
        Kind    string
    }
    // 这个函数在metav1.TypeMeta实现GroupVersionKind()接口的时候调用了，该函数调用了ParseGroupVersion
    // 实现从apiVersion解析Group和Version。
    func FromAPIVersionAndKind(apiVersion, kind string) GroupVersionKind {
        if gv, err := ParseGroupVersion(apiVersion); err == nil {
            return GroupVersionKind{Group: gv.Group, Version: gv.Version, Kind: kind}
        }
        return GroupVersionKind{Kind: kind}
    }
    // 从apiVersion解析Group和Version。
    func ParseGroupVersion(gv string) (GroupVersion, error) {
        // 这种不报错是什么道理？什么情况下会有对象没有Group和Version？
        if (len(gv) == 0) || (gv == "/") {
            return GroupVersion{}, nil
        }
        // 数apiVersion中有几个‘/’
        switch strings.Count(gv, "/") {
        // 没有'/'，就像文章开始的Pod的例子，那么Group就是空字符串，系统默认会把空字符串归为core
        case 0:
            return GroupVersion{"", gv}, nil
        // 有一个'/'，那么就以'/'分割apiVersion，左边为Group，右边为Version。
        case 1:
            i := strings.Index(gv, "/")
            return GroupVersion{gv[:i], gv[i+1:]}, nil
        // 其他则为格式错误。
        default:
            return GroupVersion{}, fmt.Errorf("unexpected GroupVersion string: %v", gv)
        }
    }
    ```
  * > 这就为什么`Deployment`的apiVersion是`apps/v1`或者`extension/v1beta1`了，至此可以总结如下：
    ```console
    schema.ObjecKind是所有API对象类型meta的抽象；
    metav1.TypeMeta是schema.ObjecKind的一个实现，API对象类型通过继承metav1.TypeMeta实现schema.ObjecKind；
    ```
- > **2.3.2 Object**
  * > 如果说`schema.ObjecKind`是所有API对象类型的抽象，配合`metav1.Object`作为所有API单体对象公共属性的抽象，似乎已经找到了所有API对象的根。但是有没有感觉怪怪的，如果想通过一个基类的指针指向任意API单体对象，`schema.ObjecKind`和`metav1.Object`感觉都不合适，因为他们所能访问的域是有限。如果有一个函数需要访问任何API对象的类型和公共属性，那么就要传入同一个对象的两个指针（`schema.ObjecKind`和`metav1.Object`），这就太让人难以接受了。有没有一个类型作为API单体对象的统一的基类呢？这就是本节要讨论的：`runtime.Object`(本章节简称 Object)。
    ```go
    // 代码源自k8s.io/apimachinery/pkg/runtime/interfaces.go
    type Object interface {
        // 有了这个函数，就可以访问对象的类型域
        GetObjectKind() schema.ObjectKind
        // deepcopy是golang深度复制对象的方法，至于什么是深度复制本文就不解释了。这是个不错的函数，
        // 可以通过这个接口复制任何API对象而无需类型依赖。
        DeepCopyObject() Object
        // 就这么两个函数了么？那如果需要访问对象的公共属性域怎么办？不应该有一个类似GetObjectMeta()
        // 的接口么？这一点，kubernetes是通过另一个方式实现的，见下面的代码。
    }
     
    // 代码源自k8s.io/apimachinery/pkg/api/meta/meta.go，注意是api包，不是apis
    // Accessor()函数可以把obj安全的转换为metav1.Object，这样也就避免了每个API对象类型都需要实现
    // 类似GetObjectMeta()的接口了。有的读者肯定会问：所有的API对象都继承了metav1.ObjectMeta，
    // 这个类型不是实现了GetObjectMeta()么？笔者就要在这里做出说明：笔者提到是类似GetObjectMeta()，
    // 如果接口名字是ObjectMeta()，那岂不是继承metav1.ObjectMeta就没用了？一个顶层的类型抽象定义不
    // 应该依赖于相对底层类型的实现。
    func Accessor(obj interface{}) (metav1.Object, error) {
        // 使用了golang的switch type语法
        switch t := obj.(type) {
        // 因为API对象类型都继承了metav1.ObjectMeta，也就自然实现了metav1.Object。
        case metav1.Object:
            return t, nil
        // 在ObjectMeta章节笔者提到了，metav1.ObjectMeta实现了metav1.ObjectMetaAccessor，
        // 所以API对象也自然实现了metav1.ObjectMetaAccessor。但是API对象会在上一个case就返回
        // 了，这个case是给谁用的呢？笔者也比较疑惑，笔者感觉是那些没有直接继承metav1.ObjectMeta
        // 却实现了metav1.ObjectMetaAccessor的类型，笔者暂时还没找到相关类型定义。
        case metav1.ObjectMetaAccessor:
            if m := t.GetObjectMeta(); m != nil {
                return m, nil
            }
            return nil, errNotObject
        default:
            return nil, errNotObject
        }
    }
    ```
  * > 等下，为什么没有看到API对象实现`runtime.Object.DeepCopyObject()`？那是因为deep copy是具体API对象类型需要实现的，存在类型依赖，作为API对象类型的父类不能实现。此处还是以Pod为例，看看Pod是如何实现DeepCopyObject()的。
    ```go
    // +genclient
    // +genclient:method=GetEphemeralContainers,verb=get,subresource=ephemeralcontainers,result=EphemeralContainers
    // +genclient:method=UpdateEphemeralContainers,verb=update,subresource=ephemeralcontainers,input=EphemeralContainers,result=EphemeralContainers
    // +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object
    // 上面+k8s:deepcopy-gen:....就是告诉代码生成工具为下面的类型生成runtime.Object接口的
    // DeepCopyObject()函数实现。因为所有的API对象类型都要实现DeepCopyObject()函数，这是一个相当
    // 大量的重复工作，所以kubernetes用代码生成工具来实现。至于如何实现的不作为本文讨论重点，只要读者
    // 知道deep copy的目的就可以了。
    type Pod struct {
        ......
    }
    ```
- > **3.总结**
  * > 至此，前面各章节的总结都可以忘掉了，因为那些总结都是基于当时的知识背景做的总结，可能缺乏全局性的考虑做出错误的结论，所以在此做出通盘的总结，如下图所示：![](https://img-blog.csdnimg.cn/20191014225213445.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjY2Mzg0MA==,size_16,color_FFFFFF,t_70)
    ```console
    runtime.Object是所有API单体对象的根类(interface)；
    schema.ObjectKind是对API对象类型的抽象(interface)；
    metav1.Object是对API对象公共属性的抽象(interface)；
    metav1.ListInterface是对API对象列表公共属性的抽象(interface)；
    metav1.TypeMeta是schema.ObjectKind的一个实现，API对象类型继承之；
    metav1.ObjectMeta是metav1.Object的一个实现，API对象类型继承之；
    metav1.ListMeta是metav1.ListInterface的一个实现，API对象列表继承之；
    ```
