
# 链接

Go by Example https://gobyexample.com/ || https://github.com/mmcgrana/gobyexample

Go by Example 中文版 https://github.com/gobyexample-cn/gobyexample || ~~https://gobyexample.xgwang.me/~~ --> https://gobyexample-cn.github.io/

# 内容

# Hello World

https://gobyexample-cn.github.io/hello-world
```go
package main

import "fmt"

func main() {
    fmt.Println("hello world")
}
```
```console
$ go run hello-world.go
hello world

$ go build hello-world.go
$ ls
hello-world    hello-world.go

$ ./hello-world
hello world
```

# 值

https://gobyexample-cn.github.io/values
```go
package main

import "fmt"

func main() {

    fmt.Println("go" + "lang")

    fmt.Println("1+1 =", 1+1)
    fmt.Println("7.0/3.0 =", 7.0/3.0)

    fmt.Println(true && false)
    fmt.Println(true || false)
    fmt.Println(!true)
}
```
```console
$ go run values.go
golang
1+1 = 2
7.0/3.0 = 2.3333333333333335
false
true
false
```

# 变量

```go
package main

import "fmt"

func main() {

    var a = "initial"
    fmt.Println(a)

    var b, c int = 1, 2
    fmt.Println(b, c)

    var d = true
    fmt.Println(d)

    var e int
    fmt.Println(e)

    f := "short"
    fmt.Println(f)
}
```
```console
$ go run variables.go
initial
1 2
true
0
short
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

Go by Example: Command-Line Flags https://gobyexample.com/command-line-flags

Go by Example: Goroutines https://gobyexample.com/goroutines

HTTP Client https://dlintw.github.io/gobyexample/public/http-client.html

Go by Example: JSON https://gobyexample.com/json

Go by Example: Maps https://gobyexample.com/maps

Go by Example: String Formatting https://gobyexample.com/string-formatting

Go by Example: Testing https://gobyexample.com/testing

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
