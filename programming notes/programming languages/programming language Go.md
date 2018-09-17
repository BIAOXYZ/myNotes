
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

go-internals https://github.com/go-internals-cn/go-internals
> https://go-internals-cn.gitbook.io/go-internals/

### 开发环境搭建

VS code golang 开发环境搭建 - CSDN博客
https://blog.csdn.net/hil2000/article/details/51714607
> https://github.com/golang/tools

在Visual Studio Code配置GoLang开发环境 - CSDN博客
https://blog.csdn.net/chszs/article/details/50076641
> "要注意，GoLang的安装要确保两个环境变量，一个是GOROOT环境变量；二是PATH环境变量要包含$GOROOT\bin值。"


 
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

go环境变量配置 (GOROOT和GOPATH)
https://www.jianshu.com/p/4e699ff478a5
```go
简单总结就是：
- GOROOT就是go的安装路径
- go install/go get和 go的工具等会用到GOPATH环境变量.
  GOPATH是作为编译后二进制的存放目的地和import包时的搜索路径 (其实也是你的工作目录, 你可以在src下创建你自己的go源文件, 然后开始工作)。
- $GOROOT/bin和$GOPATH/bin最好都加到PATH里

PS: 此外在其他帖子看过GOROOT和GOPATH必须是绝对路径。
```

2.2 Go 环境变量 - Go 入门指南 - 极客学院Wiki
http://wiki.jikexueyuan.com/project/the-way-to-go/02.2.html

聊聊GOPATH、GOROOT
https://studygolang.com/articles/10194

Go Web 编程 - 1.2 GOPATH与工作空间
https://github.com/astaxie/build-web-application-with-golang/blob/master/zh/01.2.md
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
