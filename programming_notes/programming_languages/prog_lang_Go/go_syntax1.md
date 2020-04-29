
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

## go语法之`...` 

golang中的三个点 '...' 的用法 https://blog.csdn.net/jeffrey11223/article/details/79166724
> ‘…’ 其实是go的一种语法糖。它的第一个用法主要是用于函数有多个不定参数的情况，可以接受多个不确定数量的参数。第二个用法是slice可以被打散进行传递。

How to append anything (element, slice or string) to a slice https://yourbasic.org/golang/append-explained/
```go
a := []int{1, 2}
b := []int{11, 22}
a = append(a, b...) // a == [1 2 11 22]

The ... unpacks b. Without the dots, the code would attempt to append the slice as a whole, which is invalid.
```

## go语法之枚举和iota

golang枚举类型 - iota用法拾遗 https://www.cnblogs.com/zsy/p/5812676.html

## goroutine

理解 goroutine 的并发 - CSDN博客
https://blog.csdn.net/pmlpml/article/details/78850661

golang技术随笔（二）理解goroutine - CSDN博客
https://blog.csdn.net/justaipanda/article/details/44064811

Go goroutine理解 - 孤烟的文章 - 知乎 https://zhuanlan.zhihu.com/p/60613088

## go channel

`5.4 Channel` https://draveness.me/golang/concurrency/golang-channel.html

`7.1 channel` https://tiancaiamao.gitbooks.io/go-internals/content/zh/07.1.html

Golang中Channel的实现原理 https://blog.csdn.net/skh2015java/article/details/87921666

Go: channel 源码实现 https://www.jianshu.com/p/39a3637804bb

Go语言channel与select原理 https://segmentfault.com/a/1190000010813886

## defer, panic, recover

Defer, Panic, and Recover
https://blog.go-zh.org/defer-panic-and-recover

go语言之 panic, recover ——如何在go语言中优雅的处理错误 - CSDN博客
https://blog.csdn.net/hellolingyun/article/details/52433167

Go的异常处理 defer, panic, recover
http://www.cnblogs.com/ghj1976/archive/2013/02/11/2910114.html

## go slice

Go指南 -- 向切片追加元素 https://tour.go-zh.org/moretypes/15
> Go 切片：用法和本质 https://blog.go-zh.org/go-slices-usage-and-internals

Go语言中的Slice学习总结
http://www.jb51.net/article/57121.htm

Go语言中的Array、Slice、Map和Set使用详解
http://www.jb51.net/article/56828.htm

## go语言闭包

理解Go语言中的函数闭包 - CSDN博客
https://blog.csdn.net/u012296101/article/details/48525605

Go语言闭包的实现
https://www.w3cschool.cn/go_internals/go_internals-d67w282q.html

深入理解Go语言中的闭包
http://www.jb51.net/article/108972.htm

## go语言interface

【GoLang笔记】浅析Go语言Interface类型的语法行为及用法 
https://studygolang.com/articles/2652

## go template

Introduction to Hugo Templating https://gohugo.io/templates/introduction/
> The following is only a primer on Go Templates. For an in-depth look into Go Templates, check the official Go docs.
>> Package template https://golang.org/pkg/text/template/

## go json

JSON处理 https://www.huweihuang.com/golang-notes/text/json.html

golang json inline用法 https://blog.csdn.net/fjgui/article/details/104063806

理解 Go 中的 JSON https://sanyuesha.com/2018/05/07/go-json/
```go
举例来说，比如下面的 Go struct：

type Message struct {
    Name string
    Body string
    Time int64
}

使用 Marshal 序列化：

m := Message{"Alice", "Hello", 1294706395881547000}
b, err := json.Marshal(m) 
fmt.Println(b) //{"Name":"Alice","Body":"Hello","Time":1294706395881547000}
----------------------------------------------------------------------------------------------------
JSON object 中的 name 一般都是小写，我们可以通过 struct tag 来实现：

type MyStruct struct {
    SomeField string `json:"some_field"`
}
SomeField 序列化之后会变成 some_field。
```

golang中struct成员变量的标签（Tag）说明和获取方式 https://www.cnblogs.com/liujie-php/p/10503436.html

【from 人世间】：
- Golang处理JSON（一）--- 编码 https://www.jianshu.com/p/f3c2105bd06b
- Golang处理JSON（二）--- 解码 https://www.jianshu.com/p/31757e530144

## go泛型

Go：为何带来泛型 https://juejin.im/entry/5d48e24ce51d453bc470de72

## go反射

The Laws of Reflection https://blog.golang.org/laws-of-reflection

Package reflect https://golang.org/pkg/reflect/

`4.3 反射` https://draveness.me/golang/docs/part2-foundation/ch04-basic/golang-reflect/

Golang的反射reflect深入理解和示例 https://juejin.im/post/5a75a4fb5188257a82110544

Go语言学习笔记（四）结构体struct & 接口Interface & 反射reflect https://yq.aliyun.com/articles/644158

### reflect.DeepEqual

[go]比较两个 slice/struct/map 是否相等 https://mozillazg.com/2014/11/go-compare-struct-slice-map-is-equal.html
- How to compare if two structs, slices or maps are equal? https://stackoverflow.com/questions/24534072/how-to-compare-if-two-structs-slices-or-maps-are-equal

--------------------------------------------------

## go Test

Go by Example: Testing https://gobyexample.com/testing || Go by Example 中文版: 单元测试 https://gobyexample-cn.github.io/testing

Testing https://www.golang-book.com/books/intro/12
> The `go test` command will look for any tests in any of the files ***in the current folder*** and run them. Tests are identified by starting a function with the word `Test` and taking one argument of type `*testing.T`. In our case since we're testing the `Average` function we name the test function `TestAverage`.
