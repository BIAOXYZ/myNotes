
# Go general

Go语言教程 https://www.yiibai.com/go/

怎么学习 Golang？ https://www.zhihu.com/question/23486344
- 怎么学习 Golang？ - 知乎用户的回答 - 知乎 https://www.zhihu.com/question/23486344/answer/24785991
  - Project Euler https://projecteuler.net/
- 怎么学习 Golang？ - cholerae的回答 - 知乎 https://www.zhihu.com/question/23486344/answer/130837179
  - The Go Programming Language https://golang.org/doc/
    - A Tour of Go https://tour.golang.org/welcome/
  - Go語言聖經（中文版） https://www.gitbook.com/book/wizardforcel/gopl-zh/details
    - https://www.gitbook.com/@wizardforcel

Go指南 -- 函数 https://tour.go-zh.org/basics/4
> Go's Declaration Syntax https://blog.go-zh.org/gos-declaration-syntax 
Go指南 -- 练习：循环与函数 https://tour.go-zh.org/flowcontrol/8
```
计算机通常使用循环来计算 x 的平方根。从某个猜测的值 z 开始，我们可以根据 z² 与 x 的近似度来调整 z，产生一个更好的猜测：
z -= (z*z - x) / (2*z)
（注：如果你对该算法的细节感兴趣，上面的 z² − x 是 z² 到它所要到达的值（即 x）的距离，除以的 2z 为 z² 的导数，我们通过 z² 的
变化速度来改变 z 的调整量。这种通用方法叫做牛顿法。它对很多函数，特别是平方根而言非常有效。） 
```

--------------------------------------------------

极客学院 -- Go 语言
http://wiki.jikexueyuan.com/list/go/
- Go Web 编程 http://wiki.jikexueyuan.com/project/go-web-programming/

系统学习GO，推荐几本靠谱的书? - 知乎用户的回答 - 知乎
https://www.zhihu.com/question/30461290/answer/210414739
- Go编程语言 https://go-zh.org/doc/
  - Go指南 https://tour.go-zh.org/welcome/
- Go语言圣经 https://www.gitbook.com/book/yar999/gopl-zh/details

为什么要使用 Go 语言？Go 语言的优势在哪里？ - asta谢的回答 - 知乎
https://www.zhihu.com/question/21409296/answer/18184584
> (这个就是Go Web 编程的开源版) https://github.com/astaxie/build-web-application-with-golang
>> (在网上搜到gitbook版本，虽然不是原作者搞的) https://www.gitbook.com/book/wizardforcel/build-web-application-with-golang/details

--------------------------------------------------

《深入解析Go语言》 https://www.w3cschool.cn/go_internals/

深入解析Go https://legacy.gitbook.com/book/tiancaiamao/go-internals/details

--------------------------------------------------

- A book about the internals of the Go programming language. https://github.com/teh-cmc/go-internals
- go-internals 本书是关于 Go 程序设计语言内部实现原理的阐释，当前正在进行中。 https://github.com/go-internals-cn/go-internals
> https://go-internals-cn.gitbook.io/go-internals/

--------------------------------------------------

- Go语言圣经 https://github.com/golang-china/gopl-zh 【这个是golang-china的，感觉能更权威点？】
- 《Go语言高级编程》开源图书，涵盖CGO、Go汇编语言、RPC实现、Protobuf插件实现、Web框架实现、分布式系统等高阶主题 https://github.com/chai2010/advanced-go-programming-book

--------------------------------------------------

《The Way to Go》中文译本，中文正式名《Go 入门指南》 https://github.com/Unknwon/the-way-to-go_ZH_CN

--------------------------------------------------

Golang语言社区--腾讯课堂、网易云课堂课程PPT及代码 https://github.com/Golangltd/codeclass

# Go优秀博客

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


# Go语法细节

Go语法速览与实践清单(V0.5) - 王下邀月熊的文章 - 知乎 https://zhuanlan.zhihu.com/p/35085639

GoLang之”奇怪用法“实践总结 - CSDN博客
https://blog.csdn.net/delphiwcdj/article/details/16903649

Go项目目录管理
https://studygolang.com/articles/2233
> 这个主要是因为本地的hello.go和package.go俩放一个文件夹下就报错才想到去查的

为什么 Go 语言把类型放在后面？ - 林建入的回答 - 知乎
https://www.zhihu.com/question/21656696/answer/19027040

#### goroutine

理解 goroutine 的并发 - CSDN博客
https://blog.csdn.net/pmlpml/article/details/78850661

golang技术随笔（二）理解goroutine - CSDN博客
https://blog.csdn.net/justaipanda/article/details/44064811

#### defer, panic, recover

Defer, Panic, and Recover
https://blog.go-zh.org/defer-panic-and-recover

go语言之 panic, recover ——如何在go语言中优雅的处理错误 - CSDN博客
https://blog.csdn.net/hellolingyun/article/details/52433167

Go的异常处理 defer, panic, recover
http://www.cnblogs.com/ghj1976/archive/2013/02/11/2910114.html

#### slice

Go指南 -- 向切片追加元素 https://tour.go-zh.org/moretypes/15
> Go 切片：用法和本质 https://blog.go-zh.org/go-slices-usage-and-internals

Go语言中的Slice学习总结
http://www.jb51.net/article/57121.htm

Go语言中的Array、Slice、Map和Set使用详解
http://www.jb51.net/article/56828.htm

#### go语言闭包

理解Go语言中的函数闭包 - CSDN博客
https://blog.csdn.net/u012296101/article/details/48525605

Go语言闭包的实现
https://www.w3cschool.cn/go_internals/go_internals-d67w282q.html

深入理解Go语言中的闭包
http://www.jb51.net/article/108972.htm

#### go语言interface

【GoLang笔记】浅析Go语言Interface类型的语法行为及用法 
https://studygolang.com/articles/2652


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


# Go其他

### gotour本地编译

结果搞了半天现在的版本已经集成了，没必要构建了。

- 构建离线Go编程指南——gotour-图灵社区 http://www.ituring.com.cn/article/17743
- https://studygolang.com/articles/1517
> “下载相关内容(推荐使用http://gopm.io下载)” http://gopm.io
- https://studygolang.com/articles/7250
> “我今天安装的go1.8 windows 版本，貌似已经集成进来了， 不用在安装了，目录在%GOPATH%\pkg\tool\windows_amd64\tour.exe”

### CGO

CGO，GOLANG调用C库，调用代码、静态库或动态库 https://blog.csdn.net/win_lin/article/details/51734588

# Go Web

Go-Mega Tutorial for Go Web Develop https://github.com/bonfy/go-mega
> Go-Mega https://go-mega.bonfy.im/
