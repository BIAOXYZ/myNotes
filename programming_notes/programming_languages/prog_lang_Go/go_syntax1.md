
# Go语法general

Go语法速览与实践清单(V0.5) - 王下邀月熊的文章 - 知乎 https://zhuanlan.zhihu.com/p/35085639

GoLang之”奇怪用法“实践总结 - CSDN博客
https://blog.csdn.net/delphiwcdj/article/details/16903649

Go项目目录管理
https://studygolang.com/articles/2233
> 这个主要是因为本地的hello.go和package.go俩放一个文件夹下就报错才想到去查的

为什么 Go 语言把类型放在后面？ - 林建入的回答 - 知乎
https://www.zhihu.com/question/21656696/answer/19027040

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Go语法待分类

golang新手容易犯的三个错误 - 西二旗搬砖仔的文章 - 知乎 https://zhuanlan.zhihu.com/p/41418726

了解 Go 1.9 的类型别名 https://colobu.com/2017/06/26/learn-go-type-aliases/

## go语法之`...` 

### 用在代码中

golang中的三个点 '...' 的用法 https://blog.csdn.net/jeffrey11223/article/details/79166724
> ‘…’ 其实是go的一种语法糖。它的第一个用法主要是用于函数有多个不定参数的情况，可以接受多个不确定数量的参数。第二个用法是slice可以被打散进行传递。

How to append anything (element, slice or string) to a slice https://yourbasic.org/golang/append-explained/
```go
a := []int{1, 2}
b := []int{11, 22}
a = append(a, b...) // a == [1 2 11 22]

The ... unpacks b. Without the dots, the code would attempt to append the slice as a whole, which is invalid.
```

What is the difference between []string and …string in golang? https://stackoverflow.com/questions/12907653/what-is-the-difference-between-string-and-string-in-golang

### 用在go get命令中

What does the `…` mean in go get https://stackoverflow.com/questions/31938346/what-does-the-mean-in-go-get
- > The `...` (ellipsis) tells `go get` to also fetch the package's subpackages/dependencies.

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## go语法之分号和换行

go语言中换行和分号那点事------理解为什么 https://blog.csdn.net/stpeace/article/details/81697347

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## go语法之枚举和iota

golang枚举类型 - iota用法拾遗 https://www.cnblogs.com/zsy/p/5812676.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## goroutine

理解 goroutine 的并发 - CSDN博客
https://blog.csdn.net/pmlpml/article/details/78850661

golang技术随笔（二）理解goroutine - CSDN博客
https://blog.csdn.net/justaipanda/article/details/44064811

Go goroutine理解 - 孤烟的文章 - 知乎 https://zhuanlan.zhihu.com/p/60613088

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## go channel

`5.4 Channel` https://draveness.me/golang/concurrency/golang-channel.html

`7.1 channel` https://tiancaiamao.gitbooks.io/go-internals/content/zh/07.1.html

Golang中Channel的实现原理 https://blog.csdn.net/skh2015java/article/details/87921666

Go: channel 源码实现 https://www.jianshu.com/p/39a3637804bb

Go语言channel与select原理 https://segmentfault.com/a/1190000010813886

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

# go context

【from 官方】：
- package context https://godoc.org/golang.org/x/net/context
- Package context https://golang.org/pkg/context/

Go语言实战笔记（二十）| Go Context https://www.flysnow.org/2017/05/12/go-in-action-go-context.html

`6.1 上下文` Context https://draveness.me/golang/docs/part3-runtime/ch06-concurrency/golang-context/

Golang Context深入理解 https://juejin.im/post/5a6873fef265da3e317e55b6

context.TODO() vs. context.Background() https://www.programming-books.io/essential/go/context-todo-vs-context-background-d5224e27ff724a33a79cb4e03a5eb333

Context Package Semantics In Go https://www.ardanlabs.com/blog/2019/09/context-package-semantics-in-go.html

Understanding the context package in golang http://p.agnihotry.com/post/understanding_the_context_package_in_golang/

快速掌握 Golang context 包，简单示例 https://deepzz.com/post/golang-context-package-notes.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

# go init()

五分钟理解golang的init函数 - bloomingTony的文章 - 知乎 https://zhuanlan.zhihu.com/p/34211611
- > 示例7：
  ```go
  import _ "net/http/pprof"
  
  golang对没有使用的导入包会编译报错，但是有时我们只想调用该包的init函数，不使用包导出的变量或者方法，这时就采用上面的导入方案。
  执行上述导入后，init函数会启动一个异步协程采集该进程实例的资源占用情况，并以http服务接口方式提供给用户查询。
  ```

Understanding init in Go https://www.digitalocean.com/community/tutorials/understanding-init-in-go

init functions in Go https://medium.com/golangspec/init-functions-in-go-eac191b3860a

Package initialization and program execution order https://yourbasic.org/golang/package-init-function-main-execution-order/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## defer, panic, recover

Defer, Panic, and Recover
https://blog.go-zh.org/defer-panic-and-recover

go语言之 panic, recover ——如何在go语言中优雅的处理错误 - CSDN博客
https://blog.csdn.net/hellolingyun/article/details/52433167

Go的异常处理 defer, panic, recover
http://www.cnblogs.com/ghj1976/archive/2013/02/11/2910114.html

## go error

Go 1.13中的错误处理 https://tonybai.com/2019/10/18/errors-handling-in-go-1-13/

[译] Part 31: golang 中的自定义 error https://juejin.im/post/5ca1ad13e51d4555c5453899

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## go slice

Go Slices: usage and internals https://blog.golang.org/slices-intro

Go指南 -- 向切片追加元素 https://tour.go-zh.org/moretypes/15
> Go 切片：用法和本质 https://blog.go-zh.org/go-slices-usage-and-internals

Go语言中的Slice学习总结 http://www.jb51.net/article/57121.htm

Go语言中的Array、Slice、Map和Set使用详解 http://www.jb51.net/article/56828.htm

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## go map

How to copy a map? https://stackoverflow.com/questions/23057785/how-to-copy-a-map
>> //notes：总结下就是如果要拷贝一个map到另一个新的map，最稳妥的方式还是申请一个同类型的新map，然后逐个k，v的赋值。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## go语言闭包

理解Go语言中的函数闭包 - CSDN博客
https://blog.csdn.net/u012296101/article/details/48525605

Go语言闭包的实现
https://www.w3cschool.cn/go_internals/go_internals-d67w282q.html

深入理解Go语言中的闭包
http://www.jb51.net/article/108972.htm

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## go语言interface

【GoLang笔记】浅析Go语言Interface类型的语法行为及用法 https://studygolang.com/articles/2652

【[:star:][`*`]】 深度解密Go语言之关于 interface 的10个问题 https://www.cnblogs.com/qcrao-2018/p/10766091.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## go template

Introduction to Hugo Templating https://gohugo.io/templates/introduction/
> The following is only a primer on Go Templates. For an in-depth look into Go Templates, check the official Go docs.
>> Package template https://golang.org/pkg/text/template/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## go泛型

Go：为何带来泛型 ~~https://juejin.im/entry/5d48e24ce51d453bc470de72~~ || https://github.com/llgoer/go-generics/blob/master/README.md
>> //notes：第一个排版不行，要看还是看第二个。而且翻译的有点别扭，英文原版更好：
>>> Why Generics? https://blog.golang.org/why-generics

为什么 Go 语言没有泛型 https://draveness.me/whys-the-design-go-generics/
- > Java 在 1.5 版本引入了泛型，它的泛型是用类型擦除实现的。Java 的泛型只是在编译期间用于检查类型的正确，为了保证与旧版本 JVM 的兼容，类型擦除会删除泛型的相关信息，导致其在运行时不可用。编译器会插入额外的类型转换指令，与 C 语言和 C++ 在运行前就已经实现或者生成代码相比，Java 类型的装箱和拆箱会降低程序的执行效率。
  >> //notes：关于类型擦除
  >>> [揭开Java 泛型类型擦除神秘面纱](https://mp.weixin.qq.com/s/29MqAcvjkISEyIN-_jVV4A) || [Java 泛型背后的原理是什么？](https://mp.weixin.qq.com/s/LVWkMwdKMBVwNHWZG2QxJA) || [面试官问我：“泛型擦除是什么，会带来什么问题？”](https://mp.weixin.qq.com/s/AmdKXQApHlsGDUzcb0yOMA)

GO如何支持泛型 - 罗晓的文章 - 知乎 https://zhuanlan.zhihu.com/p/74525591

GO语言泛型编程实践 https://juejin.im/post/5bf36e51e51d452b196493ec

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## go反射

The Laws of Reflection https://blog.golang.org/laws-of-reflection

Package reflect https://golang.org/pkg/reflect/

`4.3 反射` https://draveness.me/golang/docs/part2-foundation/ch04-basic/golang-reflect/

Golang的反射reflect深入理解和示例 https://juejin.im/post/5a75a4fb5188257a82110544

Go语言学习笔记（四）结构体struct & 接口Interface & 反射reflect https://yq.aliyun.com/articles/644158

### reflect.DeepEqual()

[go]比较两个 slice/struct/map 是否相等 https://mozillazg.com/2014/11/go-compare-struct-slice-map-is-equal.html
- How to compare if two structs, slices or maps are equal? https://stackoverflow.com/questions/24534072/how-to-compare-if-two-structs-slices-or-maps-are-equal

### reflect.TypeOf()

How to find the type of an object in Go? https://stackoverflow.com/questions/20170275/how-to-find-the-type-of-an-object-in-go
