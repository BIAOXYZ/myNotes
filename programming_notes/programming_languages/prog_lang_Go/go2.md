
--------------------------------------------------
# Go优秀博客
--------------------------------------------------

# 周刊类

## Golang weekly

Golang Weekly https://golangweekly.com/
- https://golangweekly.com/issues/254

## Go夜读

Go 每日阅读和 Go 夜读 > Daily Reading Go and Night Reading Go - Go source reading and offline technical or another articles or discussion on every night. https://github.com/developer-learning/reading-go
- > Go 夜读 https://reading.developerlearning.cn/
- > Go夜读 at Bilibili https://space.bilibili.com/326749661

# 个人类

## Tony Bai

Tony Bai 一个程序员的心路历程 https://tonybai.com/
- 理解Golang包导入 https://tonybai.com/2015/03/09/understanding-import-packages/
  * > "实际测试结果告诉我们：(1)在使用第三方包的时候，当源码和.a均已安装的情况下，编译器链接的是源码。"
  * > "编译器还是去找源码，而不是.a，因此我们要依赖第三方包，就必须搞到第三方包的源码，这也是Golang包管理的一个特点。"
  * > "编译器链接了$GOPATH/pkg下的foo.a。(2)到这里我们明白了所谓的使用第三方包源码，实际上是链接了以该最新源码编译的临时目录下的.a文件而已。"
  * > "找不到fmt包了。显然标准库在编译时也是必须要源码的。不过与自定义包不同的是，即便你修改了fmt包的源码（未重新编译GO安装包），用户源码编译时，也不会尝试重新编译fmt包的，依旧只是在链接时链接已经编译好的fmt.a。"
  * > "这回编译顺利通过，执行结果也是OK的。这样我们得到了结论：(3)import后面的最后一个元素应该是路径，就是目录，并非包名。"
  * > "根据上面一、二两节中得出的结论，我们尝试理解一下m：(4)m指代的是lib/math路径下唯一的那个包。"
- Go module机制下升级major版本号的实践 https://tonybai.com/2019/06/03/the-practice-of-upgrading-major-version-under-go-module/
- Go modules：最小版本选择 https://tonybai.com/2019/12/21/go-modules-minimal-version-selection/

## 飞雪无情的博客

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

Go语言参数传递是传值还是传引用 https://www.flysnow.org/2018/02/24/golang-function-parameters-passed-by-value.html
- > 什么是传值（值传递）
  ```go
  package main
  import "fmt"
  func main() {
  	i:=10
  	ip:=&i
  	fmt.Printf("原始指针的内存地址是：%p\n",&ip)
  	modify(ip)
  	fmt.Println("int值被修改了，新值为:",i)
  }
  func modify(ip *int){
  	fmt.Printf("函数里接收到的指针的内存地址是：%p\n",&ip)
    *ip=1
  }
  //////////////////////////////////////////////////
  原始指针的内存地址是：0xc42000c028
  函数里接收到的指针的内存地址是：0xc42000c038
  int值被修改了，新值为: 1
  ```
- > 什么是传引用(引用传递)
  * > Go语言(Golang)是没有引用传递的，这里我不能使用Go举例子，但是可以通过说明描述。以上面的例子为例，如果在modify函数里打印出来的内存地址是不变的，也是0xc42000c028，那么就是引用传递。
- > 迷惑Map
  * > 了解清楚了传值和传引用，但是对于Map类型来说，可能觉得还是迷惑，一来我们可以通过方法修改它的内容，二来它没有明显的指针。
    ```go
    package main
    import "fmt"
    func main() {
    	persons:=make(map[string]int)
    	persons["张三"]=19
    
    	mp:=&persons
    
    	fmt.Printf("原始map的内存地址是：%p\n",mp)
    	modify(persons)
    	fmt.Println("map值被修改了，新值为:",persons)
    }
    func modify(p map[string]int){
        fmt.Printf("函数里接收到map的内存地址是：%p\n",&p)
        p["张三"]=20
    }
    //////////////////////////////////////////////////
    原始map的内存地址是：0xc42000c028
    函数里接收到map的内存地址是：0xc42000c038
    map值被修改了，新值为: map[张三:20]
    ```
  * > 两个内存地址是不一样的，所以这又是一个值传递（值的拷贝），那么为什么我们可以修改Map的内容呢？先不急，我们先看一个自己实现的struct。
    ```go
    package main
    import "fmt"
    func main() {
    	p:=Person{"张三"}
    	fmt.Printf("原始Person的内存地址是：%p\n",&p)
    	modify(p)
    	fmt.Println(p)
    }
    type Person struct {
    	Name string
    }
    func modify(p Person) {
        fmt.Printf("函数里接收到Person的内存地址是：%p\n",&p)
        p.Name = "李四"
    }
    //////////////////////////////////////////////////
    原始Person的内存地址是：0xc4200721b0
    函数里接收到Person的内存地址是：0xc4200721c0
    {张三}
    ```
  * > 我们发现，我们自己定义的Person类型，在函数传参的时候也是值传递，但是它的值(Name字段)并没有被修改，我们想改成李四，发现最后的结果还是张三。这也就是说，map类型和我们自己定义的struct类型是不一样的。我们尝试把modify函数的接收参数改为Person的指针。
    ```go
    package main
    import "fmt"
    func main() {
    	p:=Person{"张三"}
    	modify(&p)
    	fmt.Println(p)
    }
    type Person struct {
        Name string
    }
    func modify(p *Person) {
        p.Name = "李四"
    }
    //////////////////////////////////////////////////
    {李四}
    ```
  * > 在运行查看输出，我们发现，这次被修改了。我们这里省略了内存地址的打印，因为我们上面int类型的例子已经证明了指针类型的参数也是值传递的。 指针类型可以修改，非指针类型不行，那么我们可以大胆的猜测，我们使用make函数创建的map是不是一个指针类型呢？看一下源代码:
    ```go
    // makemap implements a Go map creation make(map[k]v, hint)
    // If the compiler has determined that the map or the first bucket
    // can be created on the stack, h and/or bucket may be non-nil.
    // If h != nil, the map can be created directly in h.
    // If bucket != nil, bucket can be used as the first bucket.
    func makemap(t *maptype, hint int64, h *hmap, bucket unsafe.Pointer) *hmap {
        //省略无关代码
    }
    ```
- > 通过查看 `src/runtime/hashmap.go` 源代码发现，的确和我们猜测的一样，`make`函数返回的是一个`hmap`类型的指针`*hmap`。也就是说`map===*hmap`。 现在看`func modify(p map)`这样的函数，其实就等于`func modify(p *hmap)`，和我们前面第一节什么是值传递里举的`func modify(ip *int)`的例子一样，可以参考分析。
- > 所以在这里，Go语言通过`make`函数，字面量的包装，为我们省去了指针的操作，让我们可以更容易的使用`map`。这里的`map`可以理解为引用类型，但是记住引用类型不是传引用。
- 个人补充：
  ```go
  /*
  起因是使用 hdfs 的 go sdk 的 Read 函数时，发现了如下问题：
  - 如果变量 buff 用 make 的方式定义，则可以成功把 fileReader 里的内容读到 buff 里去，并打印出来。
  - 如果变量 buff 用（注释掉的那句）var 的方式定义，则 fileReader 里的内容读不进去，打印结果为空。
  */
  
  //var buff []byte
  buff := make([]byte, 1024*1024)
  fileReader.Read(buff)
  fmt.Println("111")
  fmt.Println(string(buff))
  fmt.Println("222")
  ```

# 其他

骏马金龙--Go语言系列文章 https://www.cnblogs.com/f-ck-need-u/p/9832538.html

## Golang技术分享`

- 简洁的 Go 多版本管理机制 https://www.ithome.com/0/642/559.htm
