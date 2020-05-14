
# go环境变量

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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# go包管理

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## import和包名、包路径

GO语言基础进阶教程：包的使用 - 茹姐的文章 - 知乎 https://zhuanlan.zhihu.com/p/71822746
- > 同一个目录下的所有.go文件的第一行添加 包定义，以标记该文件归属的包，演示语法：`package 包名`

Golang import 包问题相关详解 https://blog.csdn.net/CMbug/article/details/49339341

golang导入包的几个说明：import https://www.cnblogs.com/shengulong/p/10230644.html
- > 程序的初始化和执行都起始于main包。如果main包还导入了其它的包，那么就会在编译时将它们依次导入。有时一个包会被多个包同时导入，那么它只会被导入一次（例如很多包可能都会用到fmt包，但它只会被导入一次，因为没有必要导入多次）。当一个包被导入时，如果该包还导入了其它的包，那么会先将其它包导入进来，然后再对这些包中的包级常量和变量进行初始化，接着执行init函数（如果有的话），依次类推。等所有被导入的包都加载完毕了，就会开始对main包中的包级常量和变量进行初始化，然后执行main包中的init函数（如果存在的话），最后执行main函数。下图详细地解释了整个执行过程：

【[:star:][`*`]】 Go tips and tricks: almost everything about imports https://scene-si.org/2018/01/25/go-tips-and-tricks-almost-everything-about-imports/
- > Lets quickly go over the basics. Say you want to output something to the terminal. The fmt package takes care of this. So lets go ahead and import it.
  ```go
  import "fmt"

  func main() {
      fmt.Println("Go is great!")
  }
  ```
- > Import aliases
  * > We can leverage this to bypass package name conflicts. If we have two packages with the same package name, we can simply give one an alias. For the next example, lets assume that we want to use two packages with the name `rand`.
    ```go
    import (
        "math/rand"
        crand "crypto/rand"
    )
    ```
    > We can now reference the second import’s functions and variables by using `crand`, allowing us to reference the first import’s functions and variables by using its original package name, `rand`.
- > Package names vs. package imports
  * > For example: You wish to use [json-iterator/go](https://github.com/json-iterator/go) in your project, you will use it like this:
    ```go
    import "github.com/json-iterator/go"

    var json = jsoniter.ConfigCompatibleWithStandardLibrary
    json.Marshal(&data)
    ```
    > “But wait a minute!” you say. “It’s called `json-iterator/go`, so shouldn’t its functions and variables be referenced with `go.` instead of `jsoniter.`? That’s how it works for packages like `fmt` and `encoding/json` in the standard library, right?”
  * > Yes, people tend to write packages so they match their URL. But the URL doesn’t define how you use the package. If you look at the source code for `json-iterator/go`, you’ll see that each file has `package jsoniter` at the very top. This is what defines how one should reference its variables and functions. The import paths for the standard library packages just happen to be the same as how you use them, that’s how they’re defined in the source code, so it’s easy to think that the trend holds true for all imports.
- > Dot imports
  * > Dot imports are a lesser known and therefore rarely used import method. What it does is it imports the package into the same namespace as the current package, so you no longer have to use the imported package’s name to reference its variables and functions, giving us direct access to them. To dot import a package, you simply give it a full-stop as it’s alias. The example below compares a dot import to a standard import.
    ```go
    import (
        . "math"
        "fmt"
    )

    fmt.Println(Pi)
    ```
    ```go
    import (
        "math"
        "fmt"
    )

    fmt.Println(math.Pi)
    ```
    > As you can see, when we dot imported `math`, we didn’t have to prepend `Pi` with `math.`.
  * > One thing to look out for when using dot imports is that you cannot have functions or variables that are also defined in the dot imported package. For example, if we dot import `fmt` and we define a function called `Println` in our package, the compiler will give out to us for having duplicate function names.
  * > This import style is commonly used in testing. The dot import will import only the public structs and functions, without exposing any private details of the package. This is good for testing because you can be sure that the public interface to your package is fully functional. If you share the namespace of your package with your tests, you may overlook that some property or function isn’t public, and wouldn’t be available to the users of your package.
- > Relative imports
  * > Unfortunately, this doesn’t work and will give you the following error: `local import "./greeting" in non-local package`. **This is because relative imports aren’t allowed in your workspace (most commonly `$GOPATH/src`). They are however allowed anywhere outside of this.**
- > Blank imports
  * > If you’ve ever been annoyed at Go complaining about an unused import, then you’ve most likely come across blank imports. Blank imports are commonly used while coding to stop Go complaining about an import that you’re not using, but might use later, that you don’t want to keep around for when you do need it. However, there is another use for them. If you’ve ever worked with images or databases in Go, you may have seen one of the following being used:
    ```go
    import (
        "database/sql"
        _ "github.com/go-sql-driver/mysql"
    )
    ```
    ```go
    import (  
        "image"
        _ "image/gif"
        _ "image/png"
        _ "image/jpeg"
    )
    ```
    > You probably wondered why they’re being imported that way. Doesn’t that just ignore them? What actually happens when you import them like this is that, instead of being ignored, their `init()` function, if any, is run.

【[:star:][`*`]】 Import declarations in Go https://medium.com/golangspec/import-declarations-in-go-8de0fd3ae8ff
- > 
  ```go
  package main

  import (
      "fmt"
      "math"
  )

  func main() {
      fmt.Println(math.Exp2(10))  // 1024
  }
  ```
  > Above we’ve one `import declaration` with two `ImportSpecs`. Each ImportSpec defines single package import.
- > Package called `main` is used to create executable binary. Program execution starts in package `main` by calling its function which also called `main`.
- > But… there are other, less known options which are useful in various scenarios:
  ```go
  import (
      "math"
      m "math"
      . "math"
      _ "math"
  )
  ```
- > Importing package can reference only exported identifiers from imported package. Exported identifiers are the ones started with Unicode upper case letter — https://golang.org/ref/spec#Exported_identifiers.
- > Anatomy of import declaration
  * > 
    ```go
    ImportDeclaration = "import" ImportSpec
    ImportSpec        = [ "." | "_" | Identifier ] ImportPath
    ```
  * > `Identifier` is any valid identifier which will be used in qualified identifiers
  * > `ImportPath` is string literal (raw or interpreted)
  * > Let’s see some examples:
    ```go
    import . "fmt"
    import _ "io"
    import log "github.com/sirupsen/logrus"
    import m "math"
    ```
- > (Short) import path
  * > String literal used in import specification (each import declaration contains one or more import specification) tells what package to import. This string is called import path. According to language spec it depends on the implementation how import path (string) is interpreted but in real life it’s path relative package’s **vendor** directory or **`go env GOPATH`/src** (more about [GOPATH](https://golang.org/doc/code.html#GOPATH)).
  * > Built-in packages are imported with short import paths like `"math"` or `"fmt"`.
- > Scope of import
  * > The scope of import is the **file block**. It means that it’s reachable from the whole file but not within the entire package:
    ```go
    // github.com/mlowicki/a/main.go
    package main

    import "fmt"

    func main() {
        fmt.Println(a)
    }

    // github.com/mlowicki/a/foo.go
    package main

    var a int = 1

    func hi() {
        fmt.Println("Hi!")
    }
    ```
    > Such program cannot be compiled:
    ```go
    > go build
    # github.com/mlowicki/a
    ./foo.go:6:2: undefined: fmt
    ```
  * > More on scopes in one of previous posts:
    >> Scopes in Go https://medium.com/golangspec/scopes-in-go-a6042bb4298c
- > Types of imports
  * > Custom package name
    ```go
    # github.com/mlowicki/main.go
    package main

    import (
        "fmt"
        "github.com/mlowicki/b"
    )

    func main() {
        fmt.Println(c.B)
    }

    # github.com/mlowicki/b/b.go
    package c

    var B = "b"
    ```
    > Output is simply `b`.
    >
    > It’s possible to pass custom package name for import:
    ```go
    # github.com/mlowicki/b/b.go
    package b

    var B = "b"

    package main

    import (
        "fmt"
        c "github.com/mlowicki/b"
    )

    func main() {
        fmt.Println(c.B)
    }
    ```
    > And the result is the same as before. This form of import can be useful if we’ve package which has the same interface (exported identifiers) as other package.
  * > All exported identifiers into importing block
  * > Import with blank identifier
    + > Import with dot where all exported identifiers are added directly into importing file block fails as well while building — source code. The only variant which works is the one with blank identifier. It’s required to know what init functions are in order to understand why do we need to have import with blank identifier. Throughout introduction to init functions has been covered in one of previous stories:
      >> init functions in Go https://medium.com/golangspec/init-functions-in-go-eac191b3860a
    + > Compiling will fail if package is imported without blank identifier and not used at all.
  * > Circular import
    + > Go specification explicitly forbids `circular imports` — **when package imports itself indirectly**. The most obvious case is when package a imports package b and package b in turn imports package a:
      ```go
      # github.com/mlowicki/a/main.go
      package a

      import "github.com/mlowicki/b"

      var A = b.B

      # github.com/mlowicki/b/main.go
      package b

      import "github.com/mlowicki/a"

      var B = a.A
      ```
      > An attempt to build any of these two packages ends up with an error:
      ```go
      > go build
      can't load package: import cycle not allowed
      package github.com/mlowicki/a
      imports github.com/mlowicki/b
      imports github.com/mlowicki/a
      ```
      > Of course it can be more complex scenario like a → b → c → d → a where x → y means that package x imports package y.
    + > Package cannot import itself neither:
      ```go
      package main

      import (
          "fmt"
          "github.com/mlowicki/a"
      )

      var A = "a"
      
      func main() {
          fmt.Println(a.A)
      }
      ```
      > Compiling such package also gives an error: `can’t load package: import cycle not allowed`. 

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## import私有仓库

Import private go modules from gitlab repositories https://techproject.io/index.php/import-private-go-modules-from-gitlab-repositories/
- > 1st problem: go modules communicates with git over https, while we extensively use ssh for all communication with private repositories (and I would encourage you to do the same). From here on, I would assume you have already set up ssh certificate and use it for communication with your repositories.
  >
  ```sh
  Solution: we need to instruct git to ssh instead by using the following command:
      git config --global url."git@gitlab.com:".insteadof="https://gitlab.com"
  
  That is equivalent with adding this to your `.gitconfig`：
      [url "git@gitlab.com:"] insteadOf = https://gitlab.com
  ```
- > 3rd problem: mysteriously, sometimes the error still occurred and would go away if I additionally set `GOPRIVATE` environment variable:
  ```sh
  export GOPRIVATE="gitlab.com/myprivaterepo"
  ```
  > I would appreciate if someone could explain this magic to me 🙂

Go 1.13 Release Notes https://golang.org/doc/go1.13
- > The new `GOPRIVATE` environment variable indicates module paths that are not publicly available. It serves as the default value for the lower-level `GONOPROXY` and `GONOSUMDB` variables, which provide finer-grained control over which modules are fetched via proxy and verified using the checksum database.
- > The `GOPROXY` environment variable may now be set to a comma-separated list of proxy URLs or the special token direct, and its default value is now https://proxy.golang.org,direct. When resolving a package path to its containing module, the go command will try all candidate module paths on each proxy in the list in succession. An unreachable proxy or HTTP status code other than 404 or 410 terminates the search without consulting the remaining proxies.

Go Modules with Private Git Repositories https://medium.com/cloud-native-the-gathering/go-modules-with-private-git-repositories-dfe795068db4

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## govendor

Go vendor tool that works with the standard vendor file. https://github.com/kardianos/govendor

golang使用vendor目录来管理依赖包 https://www.jianshu.com/p/e52e3e1ad1c0
- > 随着Go 1.5 release版本的发布，vendor目录被添加到除了GOPATH和GOROOT之外的依赖目录查找的解决方案。在Go 1.6之前，你需要手动的设置环境变量`GO15VENDOREXPERIMENT=1`才可以使Go找到Vendor目录，然而在Go 1.6之后，这个功能已经不需要配置环境变量就可以实现了。
- > Note，即使使用vendor，也必须在GOPATH中，在go的工具链中，你逃不掉GOPATH的
- > 那么查找依赖包路径的解决方案如下：
  >> * 当前包下的vendor目录。
  >> * 向上级目录查找，直到找到src下的vendor目录。
  >> * 在GOPATH下面查找依赖包。
  >> * 在GOROOT目录下查找

【by 胡伟煌】：
- Golang包管理工具（一）之govendor的使用 https://blog.csdn.net/huwh_/article/details/77169858
- govendor简介 https://www.huweihuang.com/golang-notes/introduction/package/govendor-usage.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ~~gopkg/gopkg.in~~

gopkg.in -- Stable APIs for the Go language https://labix.org/gopkg.in

Source code for the gopkg.in service. https://github.com/niemeyer/gopkg

使用gopkg.in管理import的第三方package https://lnsyyj.github.io/2018/04/18/%E4%BD%BF%E7%94%A8gopkg-in%E7%AE%A1%E7%90%86import%E7%9A%84%E7%AC%AC%E4%B8%89%E6%96%B9package/

gopkg：一种方便的go pakcage管理方式 https://blog.csdn.net/siddontang/article/details/38083159

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ~~godep~~

~~dependency tool for go https://github.com/tools/godep || https://godoc.org/github.com/tools/godep~~
> Please use dep or another tool instead. The rest of this readme is preserved for those that may still need its contents.

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ~~dep~~

Go dependency management tool https://github.com/golang/dep || https://golang.github.io/dep/

Go依赖管理工具 - dep https://segmentfault.com/a/1190000013561841

go之官方依赖管理工具dep安装和使用 https://blog.csdn.net/guyan0319/article/details/81588316
- > 目前依赖工具有很多，如：glide、godep等。今天主要讲是官方出品的dep,注意它和godep不是一个东西。
- > Gopkg.lock 是生成的文件，不要手工修改
- > Gopkg.toml 是依赖管理的核心文件，可以生成也可以手动修改，
一般情况下Gopkg.toml里面只定义直接依赖项，而Gopkg.lock里面除了包含Gopkg.toml中的所有项之外，还包含传递依赖项。比如我们的项目依赖项目A， 而项目A又依赖B、C，那么只有A会包含在Gopkg.toml中，而A、B、C都会定义在Gopkg.lock中。所以Gopkg.lock定义了所有依赖的项目的详细信息（commit ID和packages），使得每次build我们自己的项目时，始终基于确定不变的依赖项。
- > vendor目录是 golang1.5 以后依赖管理目录，这个目录的依赖代码是优先加载的，类似 node 的 node_module 目录。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ~~vgo~~

~~Command vgo https://godoc.org/golang.org/x/vgo~~

vgo简明教程 https://segmentfault.com/a/1190000015372895

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## go module/go mod

https://github.com/golang/go/wiki/Modules#how-to-install-and-activate-module-support
```console
To use modules, two install options are:
● Install the latest Go 1.11 release.
● Install the Go toolchain from source on the master branch.

Once installed, you can then activate module support in one of two ways:
● Invoke the go command in a directory outside of the $GOPATH/src tree, with a valid go.mod file in the 
current directory or any parent of it and the environment variable GO111MODULE unset (or explicitly set to auto).
● Invoke the go command with GO111MODULE=on environment variable set.
```

https://github.com/golang/go/wiki/Modules#when-do-i-get-old-behavior-vs-new-module-based-behavior
```console
In general, modules are opt-in for Go 1.11, so by design old behavior is preserved by default.

Summarizing when you get the old 1.10 status quo behavior vs. the new opt-in modules-based behavior:
● Inside GOPATH — defaults to old 1.10 behavior (ignoring modules)
● Outside GOPATH while inside a file tree with a `go.mod` — defaults to modules behavior
● GO111MODULE environment variable:
  ∙ unset or `auto` — default behavior above
  ∙ `on` — force module support on regardless of directory location
  ∙ `off` — force module support off regardless of directory location
```

总结下就是，如果想***`启用go module`***，需要做到如下两点之一（假定Go版本大于等于`1.11`）:
1. `GO111MODULE`参数显式`开启`（此时无论项目处于任何路径都无关紧要了！）
2. `GO111MODULE`参数`自动或unset` **+** 且项目**不能**处于`$GOPATH/src`路径下 **+** 且项目里有一个有效的`go.mod`文件

反之，所以如果想使用***`传统的go包管理`***，需要达到如下要求：
1. `GO111MODULE`参数显式`关闭`（此时无论项目处于任何路径都无关紧要了！）
2. `GO111MODULE`参数`自动或unset` **+** 且项目处于`$GOPATH/src`路径下 **+** 且项目里不存在`go.mod`文件
  - 第2种换个更顺口自然的说法：项目仍然处于`$GOPATH/src`下，`GO111MODULE`参数未设置或值为auto，并且项目里不能有`go.mod`文件。

最后总结成表格如下：

| 【`Go module`或`old behavior`情况表】 | 在`$GOPATH/src`中 | 不在`$GOPATH/src`中 |
|--|--|--|
| `GO111MODULE=on`| `Go module` | `Go module` |
| `GO111MODULE=off` |  `old behavior`  | `old behavior` |
| `GO111MODULE=auto/unset` |  `old behavior` (且项目中不能有`go.mod`)  | `Go module` (且项目中必须有合法的`go.mod`) |

--------------------------------------------------

FAQs — go.mod and go.sum https://github.com/golang/go/wiki/Modules#faqs--gomod-and-gosum
- Why does 'go mod tidy' record indirect and test dependencies in my 'go.mod'? https://github.com/golang/go/wiki/Modules#why-does-go-mod-tidy-record-indirect-and-test-dependencies-in-my-gomod

跳出Go module的泥潭 https://colobu.com/2018/08/27/learn-go-module/
- Modules https://github.com/golang/go/wiki/Modules
- Introduction to Go Modules https://roberto.selbach.ca/intro-to-go-modules/

【by The Go Blog】
- Using Go Modules https://blog.golang.org/using-go-modules

初窥Go module https://tonybai.com/2018/07/15/hello-go-module/
- > 当GO111MODULE的值为auto时(不显式设置即为auto)，也就是我们在上面的例子中所展现的那样：使用GOPATH mode还是module-aware mode，取决于要构建的源码目录所在位置以及是否包含go.mod文件。如果要构建的源码目录不在以GOPATH/src为根的目录体系下，且包含go.mod文件(两个条件缺一不可)，那么使用module-aware mode；否则使用传统的GOPATH mode。

【by apocelipes】
- golang包管理解决之道——go modules初探 https://www.cnblogs.com/apocelipes/p/9534885.html
  * > 那么我们怎么进行包管理呢？别担心，当我们使用go build，go test以及go list时，go会自动得更新go.mod文件，将依赖关系写入其中。
  * > 我们发现多了一个go.sum，我们看看它里面是什么内容：没错，你已经猜到了，这是我们直接引用的package和它自身需要的以来的版本记录，go modules就是根据这些去找到需要的packages的。
- 再探go modules：使用与细节 https://www.cnblogs.com/apocelipes/p/10295096.html

Go Modules使用教程 https://segmentfault.com/a/1190000016703769

go mod 使用 https://juejin.im/post/5c8e503a6fb9a070d878184a

--------------------------------------------------

10分钟将你的Go工程转换为Go Module模式 - JFrog杰蛙的文章 - 知乎 https://zhuanlan.zhihu.com/p/111097929
> 要使go客户端能够使用go module，需要设置GO111MODULE=on <br> 注意:从Go 1.13开始，这一步将不再需要，因为Go Module将在默认情况下启用

【[:star:][`*`]】 从 goinstall 到 module —— golang 包管理的前世今生 https://blog.wolfogre.com/posts/golang-package-history/ || https://github.com/wolfogre/blog-utterances/issues/50
- > 可见，这是一个从编译行为上就要做改变的大更新，所以实验阶段这个项目名叫“vgo”，即“带版本的 go”，原先的 `go build`、`go get` 命令都要换成 `vgo build`、`vgo get`。但同时提供两套工具自然是下下策，所以最后正式发布时，“vgo” 和 “go” 事实上是合并了，同样的命令 `go build`、`go get`，在不同的项目里可能有不同的行为，为了方便描述，我们暂且称为`传统模式`和 `module 模式`。
  ```
  ----------------------------------------------------------------------------------------------------
  命令	      传统模式	                                  module 模式
  ----------------------------------------------------------------------------------------------------
  go build	 寻包路径依次是 $GOROOT、vendor、$GOPATH；     寻包路径依次是 $GOROOT、$GOPATH/pkg/mod/；
               如果缺包，报错并中止。	                     默认不支持 vendor；发现缺包，自动获取缺失的包。
  go get	     将包存到到 $GOPATH/src。	                 将包按照版本不同分别存到$GOPATH/pkg/mod/ 下不同路径。
  ----------------------------------------------------------------------------------------------------
  ```
- > 完整的决策逻辑经历了几次调整，所以现在我也有点搞不清了，但这没关系，你可以运行一下 `go env` 命令，看看 `$GOMOD` 这个变量，如果它有值，并指向了一个 `go.mod` 文件，便是处于 `module 模式`，否则则是处于`传统模式`，简单明了。
- > 除了对已有的命令进行改造，go 也添加了新的命令 `go mod`，用于管理 module，这里简单介绍一下它的使用：
  ```go
  go mod init [moduel-name] 来初始化一个 module；
  go tidy 检查当前 module 的依赖并写入 go.mod 和 go.sum；
  go.mod 描述了本 module 的名称、go 版本依赖、依赖包的最小版本；
  go.sum 记录依赖包语义化版本对应的哈希。
  ```
- > 同时 module 模式 `go get` 不再是简单的执行 git clone 了，它有了为其定制的代理协议，由于一些网络方面的原因，这简直是中国人民的福音，一大堆代理实现方案、公开的代理站点如雨后春笋般出现，如 athens、goproxy、goproxy.cn，你可以通过配置 `$GOPROXY`、`$GONOPROXY` 等环境变量来设置代理，详细介绍可以看这里。
  >
  > 且从 go 1.13 开始，module 引入了文件检查，`go get` 会将获取到的包与官方的包哈希数据库，进行对比，你可以通过修改 `$GOSUMDB`、`$GONOSUMDB`、`$GOPRIVATE` 等环境变量来控制这一行为。如果你引入私有包时，因为无法通过文件检查而失败（私有包无法被官方的包哈希数据库收录），可以在这里找到解决方案。
  >
  > 你应该还注意到了一点，go.mod 文件中描述了这个 module 的名字（图中 go.mod 文件的 module github.com/wolfogre/test 一行），而不需要借助 `$GOPATH` 路径，所以 module 项目是不需要放到 `$GOPATH` 下的，可以放在任何位置，编译时也不依赖 `$GOPATH/src` 下存放的包。至此，module 基本摆脱了了对 `$GOPATH` 的依赖，只是需要借 `$GOPATH/pkg/mod` 这个位置存一下文件而已，算不得什么。
  >
  > go module 仍然在迭代中，还是有一些缺点的，尤其是对 vendor 的支持不完善，比如编译时默认不支持 vendor（[#27348](https://github.com/golang/go/issues/27348)），go mod verify 不会帮忙检查 vendor 下文件是否完整（[#33848](https://github.com/golang/go/issues/33848)）等等。

【[:star:][`*`]】 干货满满的 Go Modules 和 goproxy.cn https://github.com/guanhui07/blog/issues/642

go - 使用 go mod 管理项目依赖 https://segmentfault.com/a/1190000019724582

五分钟学会使用 go modules（含在家办公使用技巧） https://www.kubernetes.org.cn/6687.html

再探go modules：使用与细节 https://www.cnblogs.com/apocelipes/p/10295096.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## goproxy (for go module)

GOPROXY.IO - A Global Proxy for Go Modules https://goproxy.io/

Go的包管理工具（四）：Go Module Proxy https://juejin.im/post/5c8f9f8ef265da612c3a34b9

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## glide

Package Management for Golang https://github.com/Masterminds/glide || https://glide.sh/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ~~gopm~~

~~Go Package Manager (gopm) is a package manager and build tool for Go. https://github.com/gpmgo/gopm~~
> In favor of Go Modules Proxy since Go 1.11, this project has been archived and website (gopm.io) will be taken down as of 12/31/2019.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
