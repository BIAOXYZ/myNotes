
# Go general

怎么学习 Golang？ https://www.zhihu.com/question/23486344
- 怎么学习 Golang？ - 知乎用户的回答 - 知乎 https://www.zhihu.com/question/23486344/answer/24785991
  - Project Euler https://projecteuler.net/
- 怎么学习 Golang？ - cholerae的回答 - 知乎 https://www.zhihu.com/question/23486344/answer/130837179
  - The Go Programming Language https://golang.org/doc/
    - A Tour of Go https://tour.golang.org/welcome/
  - Go語言聖經（中文版） https://www.gitbook.com/book/wizardforcel/gopl-zh/details
    - https://www.gitbook.com/@wizardforcel

系统学习GO，推荐几本靠谱的书? - 飞雪无情的回答 - 知乎 https://www.zhihu.com/question/30461290/answer/210414739
- Go编程语言 https://go-zh.org/doc/
  - Go指南 https://tour.go-zh.org/welcome/
- Go语言圣经 https://www.gitbook.com/book/yar999/gopl-zh/details
- 然后通过《Go语言实战》这本书，In Action系列都是比较经典的，看这本书的实习可以参考我《Go语言实战》这本书的读书笔记，一共近30篇文章，15万字，非常全面，书里没有的我这里也讲到了很多。这里列其中几篇：

为什么要使用 Go 语言？Go 语言的优势在哪里？ - asta谢的回答 - 知乎 https://www.zhihu.com/question/21409296/answer/18184584
> (这个就是Go Web 编程的开源版) https://github.com/astaxie/build-web-application-with-golang
>> (在网上搜到gitbook版本，虽然不是原作者搞的) https://www.gitbook.com/book/wizardforcel/build-web-application-with-golang/details

## A Tour of Go

参见仓库里关于该书单独的笔记吧。

## Effective Go

Effective Go https://golang.org/doc/effective_go.html

Effective Go 中英双语版 https://legacy.gitbook.com/book/bingohuang/effective-go-zh-en/details

## 其他Go教程

--------------------------------------------------

Go语言教程 https://www.yiibai.com/go/

极客学院 -- Go 语言
http://wiki.jikexueyuan.com/list/go/
- Go Web 编程 http://wiki.jikexueyuan.com/project/go-web-programming/

--------------------------------------------------

《深入解析Go语言》 https://www.w3cschool.cn/go_internals/

dig into implemention of the go programming language https://github.com/tiancaiamao/go-internals
> 深入解析Go https://legacy.gitbook.com/book/tiancaiamao/go-internals/details
>> 《深入解析Go》 https://tiancaiamao.gitbooks.io/go-internals/content/zh/index.html

--------------------------------------------------

- A book about the internals of the Go programming language. https://github.com/teh-cmc/go-internals
- go-internals 本书是关于 Go 程序设计语言内部实现原理的阐释，当前正在进行中。 https://github.com/go-internals-cn/go-internals
> https://go-internals-cn.gitbook.io/go-internals/

--------------------------------------------------

- 📚 Go语言圣经中文版 https://github.com/golang-china/gopl-zh 【这个是golang-china的，感觉能更权威点？ --> 好像不一定，还是注意看构建时间吧，选最新的一个】
  * gopl: 《The Go Programming Language》  http://gopl.io
  * Go语言圣经（中文版） https://books.studygolang.com/gopl-zh/
- 《Go语言高级编程》开源图书，涵盖CGO、Go汇编语言、RPC实现、Protobuf插件实现、Web框架实现、分布式系统等高阶主题 https://github.com/chai2010/advanced-go-programming-book
  * https://chai2010.gitbooks.io/advanced-go-programming-book/content/
  * https://chai2010.cn/advanced-go-programming-book/

--------------------------------------------------

- 《The Way to Go》中文译本，中文正式名《Go 入门指南》 https://github.com/Unknwon/the-way-to-go_ZH_CN
- Go 入门指南 -- Github 上《The Way to Go》中文译本的镜像，优化了排版 https://learnku.com/docs/the-way-to-go

--------------------------------------------------

Golang语言社区--腾讯课堂、网易云课堂课程PPT及代码 https://github.com/Golangltd/codeclass

--------------------------------------------------

📚 《Go2编程指南》开源图书，重点讲解Go2新特性，以及Go1教程中较少涉及的特性 https://chai2010.cn/go2-book/ || https://github.com/chai2010/go2-book

--------------------------------------------------

Go 标准库中文文档 https://github.com/huangz1990/cngolib.com
> http://cngolib.com/

# Go优秀博客

Golang Weekly https://golangweekly.com/
- https://golangweekly.com/issues/254

Go 每日阅读和 Go 夜读 > Daily Reading Go and Night Reading Go - Go source reading and offline technical or another articles or discussion on every night. https://github.com/developer-learning/reading-go
- > Go 夜读 https://reading.developerlearning.cn/
- > Go夜读 at Bilibili https://space.bilibili.com/326749661

Tony Bai 一个程序员的心路历程 https://tonybai.com/
- 理解Golang包导入 https://tonybai.com/2015/03/09/understanding-import-packages/
  * > "实际测试结果告诉我们：(1)在使用第三方包的时候，当源码和.a均已安装的情况下，编译器链接的是源码。"
  * > "编译器还是去找源码，而不是.a，因此我们要依赖第三方包，就必须搞到第三方包的源码，这也是Golang包管理的一个特点。"
  * > "编译器链接了$GOPATH/pkg下的foo.a。(2)到这里我们明白了所谓的使用第三方包源码，实际上是链接了以该最新源码编译的临时目录下的.a文件而已。"
  * > "找不到fmt包了。显然标准库在编译时也是必须要源码的。不过与自定义包不同的是，即便你修改了fmt包的源码（未重新编译GO安装包），用户源码编译时，也不会尝试重新编译fmt包的，依旧只是在链接时链接已经编译好的fmt.a。"
  * > "这回编译顺利通过，执行结果也是OK的。这样我们得到了结论：(3)import后面的最后一个元素应该是路径，就是目录，并非包名。"
  * > "根据上面一、二两节中得出的结论，我们尝试理解一下m：(4)m指代的是lib/math路径下唯一的那个包。"
  
飞雪无情的博客 专注于Android、Java、Go语言(golang)、移动互联网、项目管理、软件架构 https://www.flysnow.org/
- Go语言环境搭建详解 https://www.flysnow.org/2017/01/05/install-golang.html
  * ```
    如果我们要生成不同平台架构的可执行程序，只要改变这两个环境变量就可以了，比如要生成linux 64位的程序，命令如下：
    GOOS=linux GOARCH=amd64 go build flysnow.org/hello
    前面两个赋值，是更改环境变量，这样的好处是只针对本次运行有效，不会更改我们默认的配置。
    ```
- Go语言实战笔记（一）| Go包管理 http://www.flysnow.org/2017/03/04/go-in-action-go-package.html
  * > "以上是net包的一个目录结构，net本身是一个包，net目录下的http又是一个包。从这个大家可以看到，go语言的包其实就是我们计算机里的目录，或者叫文件夹，通过它们进行目录结构和文件组织，go只是对目录名字做了一个翻译，叫【包】而已。比如这里的net包其实就是net目录，http包其实就是http目录，这也是go语言中的一个命名习惯，包名和文件所在的目录名是一样的。"
  * > "go语言的包的命名，遵循简洁、小写、和go文件所在目录同名的原则，这样就便于我们引用，书写以及快速定位查找。"
  * > "值得了解的是：对于包的查找，是有优先级的，编译器会优先在GOROOT里搜索，其次是GOPATH,一旦找到，就会马上停止搜索。如果最终都没找到，就报编译异常了。"
  * > "如果没有重新命名，那么对于编译器来说，这两个fmt它是区分不清楚的。重命名也很简单，在我们导入的时候，在包名的左侧，起一个新的包名就可以了。"
  * > "Go语言规定，导入的包必须要使用，否则会包编译错误，这是一个非常好的规则，因为这样可以避免我们引用很多无用的代码而导致的代码臃肿和程序的庞大，因为很多时候，我们都不知道哪些包是否使用，这在C和Java上会经常遇到，有时候我们不得不借助工具来查找我们没有使用的文件、类型、方法和变量等，把它们清理掉。"
  * > "每个包都可以有任意多个init函数，这些init函数都会在main函数之前执行。init函数通常用来做初始化变量、设置包或者其他需要在程序执行前的引导工作。比如上面我们讲的需要使用_空标志符来导入一个包的目的，就是想执行这个包里的init函数。"
- Go语言实战笔记（二）| Go开发工具 https://www.flysnow.org/2017/03/08/go-in-action-go-tools.html
- Go语言实战笔记（五）| Go 切片 https://www.flysnow.org/2017/03/14/go-in-action-go-slice.html
  * > 切片还有nil切片和空切片，它们的长度和容量都是0，但是它们指向底层数组的指针不一样，nil切片意味着指向底层数组的指针为nil，而空切片对应的指针是个地址。
    ```go
    //nil切片
    var nilSlice []int
    //空切片
    slice:=[]int{}
    ```
    > nil切片表示不存在的切片，而空切片表示一个空集合，它们各有用处。
  * ```
    对于底层数组容量是k的切片slice[i:j]来说
    长度：j-i
    容量:k-i
    ```
  * > `append`函数会智能的增长底层数组的容量，目前的算法是：容量小于1000个时，总是成倍的增长，一旦容量超过1000个，增长因子设为1.25，也就是说每次会增加25%的容量。
  * > 此外，我们还可以通过`...`操作符，把一个切片追加到另一个切片里。
  * > 仔细看，这两个切片的地址不一样，所以可以确认切片在函数间传递是复制的。而我们修改一个索引的值后，发现原切片的值也被修改了，说明它们共用一个底层数组。

骏马金龙--Go语言系列文章 https://www.cnblogs.com/f-ck-need-u/p/9832538.html

run.go: Basic Go Programming Tutorials https://medium.com/rungo
- 【[:star:][`*`]】 Anatomy of goroutines in Go - Concurrency in Go https://medium.com/rungo/anatomy-of-goroutines-in-go-concurrency-in-go-a4cb9272ff88

# Go语法细节

Go语法速览与实践清单(V0.5) - 王下邀月熊的文章 - 知乎 https://zhuanlan.zhihu.com/p/35085639

GoLang之”奇怪用法“实践总结 - CSDN博客
https://blog.csdn.net/delphiwcdj/article/details/16903649

Go项目目录管理
https://studygolang.com/articles/2233
> 这个主要是因为本地的hello.go和package.go俩放一个文件夹下就报错才想到去查的

为什么 Go 语言把类型放在后面？ - 林建入的回答 - 知乎
https://www.zhihu.com/question/21656696/answer/19027040

### goroutine

理解 goroutine 的并发 - CSDN博客
https://blog.csdn.net/pmlpml/article/details/78850661

golang技术随笔（二）理解goroutine - CSDN博客
https://blog.csdn.net/justaipanda/article/details/44064811

### defer, panic, recover

Defer, Panic, and Recover
https://blog.go-zh.org/defer-panic-and-recover

go语言之 panic, recover ——如何在go语言中优雅的处理错误 - CSDN博客
https://blog.csdn.net/hellolingyun/article/details/52433167

Go的异常处理 defer, panic, recover
http://www.cnblogs.com/ghj1976/archive/2013/02/11/2910114.html

### slice

Go指南 -- 向切片追加元素 https://tour.go-zh.org/moretypes/15
> Go 切片：用法和本质 https://blog.go-zh.org/go-slices-usage-and-internals

Go语言中的Slice学习总结
http://www.jb51.net/article/57121.htm

Go语言中的Array、Slice、Map和Set使用详解
http://www.jb51.net/article/56828.htm

### go语言闭包

理解Go语言中的函数闭包 - CSDN博客
https://blog.csdn.net/u012296101/article/details/48525605

Go语言闭包的实现
https://www.w3cschool.cn/go_internals/go_internals-d67w282q.html

深入理解Go语言中的闭包
http://www.jb51.net/article/108972.htm

### go语言interface

【GoLang笔记】浅析Go语言Interface类型的语法行为及用法 
https://studygolang.com/articles/2652

### go template

Introduction to Hugo Templating https://gohugo.io/templates/introduction/
> The following is only a primer on Go Templates. For an in-depth look into Go Templates, check the official Go docs.
>> Package template https://golang.org/pkg/text/template/

### go泛型

Go：为何带来泛型 https://juejin.im/entry/5d48e24ce51d453bc470de72

--------------------------------------------------

### go环境变量

聊聊GOPATH、GOROOT https://studygolang.com/articles/10194

go环境变量配置 (GOROOT和GOPATH) https://www.jianshu.com/p/4e699ff478a5
```go
简单总结就是：
- GOROOT就是go的安装路径
- go install/go get和 go的工具等会用到GOPATH环境变量.
  GOPATH是作为编译后二进制的存放目的地和import包时的搜索路径 (其实也是你的工作目录, 你可以在src下创建你自己的go源文件, 然后开始工作)。
- $GOROOT/bin和$GOPATH/bin最好都加到PATH里

PS: 此外在其他帖子看过GOROOT和GOPATH必须是绝对路径。
```
开始编写Golang代码 http://www.cnblogs.com/sunshine-anycall/p/4948533.html

【Go入门教程1】Go 安装，GOROOT，GOPATH，Go工作空间 https://www.cnblogs.com/52php/p/6030990.html
```
原文中有这么句话:
"当有多个GOPATH时，默认会将 go get 的内容放在第一个目录下。"

下面是实战：

以单位windows笔记本为例，在VS Code里打开命令行测试执行下述语句并观察效果：
    go get github.com/astaxie/beedb
    
1.当GOPATH为"GOPATH=C:\Users\LiangLiu\go;E:\go;"时执行上述语句，会在
C:\Users\LiangLiu\go\src\github.com目录下下载这个包的代码。

2.把GOPATH变为"GOPATH=E:\go;C:\Users\LiangLiu\go;"时执行上述语句，此时
因为已经有这个包的代码了，所以不会再下载了。

2.把C:\Users\LiangLiu\go\src\github.com目录下刚下载的代码删除，再次执行上述语句，
此时因为当前所有GOPATH下都没有这个包的代码，会把代码下载到E:\go\src\github.com目录下。
```

2.2 Go 环境变量 - Go 入门指南 - 极客学院Wiki
http://wiki.jikexueyuan.com/project/the-way-to-go/02.2.html

Go Web 编程 - 1.2 GOPATH与工作空间 https://github.com/astaxie/build-web-application-with-golang/blob/master/zh/01.2.md
- Go Web 编程 https://legacy.gitbook.com/book/astaxie/build-web-application-with-golang/details/zh
- Go Web 编程 https://legacy.gitbook.com/book/wizardforcel/build-web-application-with-golang/details

Installing Go from source https://nikhita.github.io/install-multiple-versions-go

## go包管理

### go vendor

golang使用vendor目录来管理依赖包 https://www.jianshu.com/p/e52e3e1ad1c0
- > 随着Go 1.5 release版本的发布，vendor目录被添加到除了GOPATH和GOROOT之外的依赖目录查找的解决方案。在Go 1.6之前，你需要手动的设置环境变量`GO15VENDOREXPERIMENT=1`才可以使Go找到Vendor目录，然而在Go 1.6之后，这个功能已经不需要配置环境变量就可以实现了。
- > Note，即使使用vendor，也必须在GOPATH中，在go的工具链中，你逃不掉GOPATH的
- > 那么查找依赖包路径的解决方案如下：
  >> * 当前包下的vendor目录。
  >> * 向上级目录查找，直到找到src下的vendor目录。
  >> * 在GOPATH下面查找依赖包。
  >> * 在GOROOT目录下查找

【by 胡伟煌】 
- Golang包管理工具（一）之govendor的使用 https://blog.csdn.net/huwh_/article/details/77169858
- govendor简介 https://www.huweihuang.com/golang-notes/introduction/package/govendor-usage.html

### go dep

Go依赖管理工具 - dep https://segmentfault.com/a/1190000013561841

go之官方依赖管理工具dep安装和使用 https://blog.csdn.net/guyan0319/article/details/81588316
- > 目前依赖工具有很多，如：glide、godep等。今天主要讲是官方出品的dep,注意它和godep不是一个东西。
- > Gopkg.lock 是生成的文件，不要手工修改
- > Gopkg.toml 是依赖管理的核心文件，可以生成也可以手动修改，
一般情况下Gopkg.toml里面只定义直接依赖项，而Gopkg.lock里面除了包含Gopkg.toml中的所有项之外，还包含传递依赖项。比如我们的项目依赖项目A， 而项目A又依赖B、C，那么只有A会包含在Gopkg.toml中，而A、B、C都会定义在Gopkg.lock中。所以Gopkg.lock定义了所有依赖的项目的详细信息（commit ID和packages），使得每次build我们自己的项目时，始终基于确定不变的依赖项。
- > vendor目录是 golang1.5 以后依赖管理目录，这个目录的依赖代码是优先加载的，类似 node 的 node_module 目录。

### go module/go mod

Modules https://github.com/golang/go/wiki/Modules

初窥Go module https://tonybai.com/2018/07/15/hello-go-module/
- > 当GO111MODULE的值为auto时(不显式设置即为auto)，也就是我们在上面的例子中所展现的那样：使用GOPATH mode还是module-aware mode，取决于要构建的源码目录所在位置以及是否包含go.mod文件。如果要构建的源码目录不在以GOPATH/src为根的目录体系下，且包含go.mod文件(两个条件缺一不可)，那么使用module-aware mode；否则使用传统的GOPATH mode。

【by apocelipes】
- golang包管理解决之道——go modules初探 https://www.cnblogs.com/apocelipes/p/9534885.html
  * > 那么我们怎么进行包管理呢？别担心，当我们使用go build，go test以及go list时，go会自动得更新go.mod文件，将依赖关系写入其中。
  * > 我们发现多了一个go.sum，我们看看它里面是什么内容：没错，你已经猜到了，这是我们直接引用的package和它自身需要的以来的版本记录，go modules就是根据这些去找到需要的packages的。
- 再探go modules：使用与细节 https://www.cnblogs.com/apocelipes/p/10295096.html

Go Modules使用教程 https://segmentfault.com/a/1190000016703769

# Go其他

## go命令

### go generate

go generate介绍 https://www.jianshu.com/p/a866147021da

Golang Generate命令说明与使用 https://yushuangqi.com/blog/2017/go-command-generate.html

### gotour本地编译

结果搞了半天现在的版本已经集成了，没必要构建了。

- 构建离线Go编程指南——gotour-图灵社区 http://www.ituring.com.cn/article/17743
- https://studygolang.com/articles/1517
> “下载相关内容(推荐使用http://gopm.io下载)” http://gopm.io
- https://studygolang.com/articles/7250
> “我今天安装的go1.8 windows 版本，貌似已经集成进来了， 不用在安装了，目录在%GOPATH%\pkg\tool\windows_amd64\tour.exe”

# go工具

[mirror] Go Tools https://godoc.org/golang.org/x/tools || https://github.com/golang/tools/

## gops

gops: A tool to list and diagnose Go processes currently running on your system https://github.com/google/gops

gops - Go语言程序查看和诊断工具 https://www.cnblogs.com/snowInPluto/p/7785651.html

gops 工作原理 https://blog.wolfogre.com/posts/mechanism-of-gops/

## go-callvis

Visualize call graph of a Go program using dot format. https://github.com/TrueFurby/go-callvis

## CGO

CGO，GOLANG调用C库，调用代码、静态库或动态库 https://blog.csdn.net/win_lin/article/details/51734588

## GoConvey

Go testing in the browser. Integrates with `go test`. Write behavioral tests in Go. http://goconvey.co

# Go Web

Go-Mega Tutorial for Go Web Develop https://github.com/bonfy/go-mega
> Go-Mega https://go-mega.bonfy.im/
