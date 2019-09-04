
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

# 其他

骏马金龙--Go语言系列文章 https://www.cnblogs.com/f-ck-need-u/p/9832538.html

## run.go

run.go: Basic Go Programming Tutorials https://medium.com/rungo
- Getting started with Go https://medium.com/rungo/working-in-go-workspace-3b0576e0534a
- 【[:star:][`*`]】 Anatomy of goroutines in Go - Concurrency in Go https://medium.com/rungo/anatomy-of-goroutines-in-go-concurrency-in-go-a4cb9272ff88

### run.go长笔记

[Anatomy of goroutines in Go - Concurrency in Go](https://medium.com/rungo/anatomy-of-goroutines-in-go-concurrency-in-go-a4cb9272ff88)
- ***`☛ What is a goroutine?`***
- > Well, a goroutine is simply a function or method that is running in background concurrently with other goroutines. It’s not a function or method definition that determines if it is a goroutine, it is determined by how we call it.
```go
// https://play.golang.org/p/pIGsToIA2hL
--------------------------------------------------
package main

import "fmt"

func printHello() {
	fmt.Println("Hello World!")
}

func main() {
	fmt.Println("main execution started")

	// call function
	printHello()

	fmt.Println("main execution stopped")
}
--------------------------------------------------
main execution started
Hello World!
main execution stopped
```
- > In the above program, we created a function `printHello` which prints `Hello World!` to the console. In `main` function, we called `printHello()` like a normal function call and we got the desired result.

////////////////////////////////////////////////////////////////////////////////////////////////////

- > Now let’s create **goroutine** from the same `printHello` function.
```go
// https://play.golang.org/p/LWXAgDpTcJP
--------------------------------------------------
package main

import "fmt"

func printHello() {
	fmt.Println("Hello World!")
}

func main() {
	fmt.Println("main execution started")

	// create goroutine
	go printHello()

	fmt.Println("main execution stopped")
}
--------------------------------------------------
main execution started
main execution stopped
```
- > It is a bit strange that `Hello World` did not get printed. So what happened?
- > goroutines always run in the background. When a goroutine is executed, here, Go does not block the program execution, unlike normal function call as we have seen in the previous example. Instead, the control is returned immediately to the next line of code and any returned value from goroutine is ignored. **But even then, why we can’t see the function output?**
- > By default, every Go standalone application creates one goroutine. This is known as the **main goroutine** that the **`main`** function operates on. In the above case, the main goroutine spawns another goroutine of `printHello` function, let’s call it **printHello goroutine**. Hence when we execute the above program, there are two goroutines running concurrently. As we saw in the earlier program, goroutines are scheduled cooperatively. Hence when the main goroutine starts executing, go scheduler dot not pass control to the **printHello goroutine** until the main goroutine does not execute completely. Unfortunately, when the main goroutine is done with execution, the program terminates immediately and scheduler did not get time to schedule **printHello goroutine**. But as we know from other lessons, using blocking condition, we can pass control to other goroutines manually AKA telling the scheduler to schedule other available goroutines. Let’s use `time.Sleep()` call to do it.
```go
// https://play.golang.org/p/ujQKjpALlRJ
--------------------------------------------------
package main

import (
	"fmt"
	"time"
)

func printHello() {
	fmt.Println("Hello World!")
}

func main() {
	fmt.Println("main execution started")

	// create goroutine
	go printHello()

	// schedule another goroutine
	time.Sleep(10 * time.Millisecond)
	fmt.Println("main execution stopped")
}
--------------------------------------------------
main execution started
Hello World!
main execution stopped
```
- > We have modified program in such a way that before **main goroutine** pass control to the last line of code, we pass control to **printHello goroutine** using `time.Sleep(10 * time.Millisecond)` call. In this case, the main goroutine sleeps for 10 milli-seconds and won’t be scheduled again for another 10 milliseconds. Once **printHello goroutine** executes, it prints **‘Hello World!’** to the console and terminates, then the main goroutine is scheduled again (after 10 milliseconds) to execute the last line of code **where stack pointer is**.

////////////////////////////////////////////////////////////////////////////////////////////////////

- > If we add a sleep call inside the function which will tell goroutine to schedule another available goroutine, in this case, the main goroutine. But from the last lesson, we learned that only `non-sleeping` goroutines are considered for scheduling, main won’t be scheduled again for 10 milli-seconds while it’s sleeping. Hence the main goroutine will print ‘main execution started’, spawning **printHello goroutine** but still actively running, then sleeping for 10 milli-seconds and passing control to **printHello goroutine**. **printHello goroutine** then will sleep for 1 milli-second telling the scheduler to schedule another goroutine but since there isn’t any available, waking up after 1 milli-second and printing **‘Hello World!’** and then dying. Then the main goroutine will wake up after a few milliseconds, printing ‘main execution stopped’ and exiting the program.
```go
// https://play.golang.org/p/rWvzS8UeqD6
--------------------------------------------------
package main

import (
	"fmt"
	"time"
)

func printHello() {
	time.Sleep(time.Millisecond)
	fmt.Println("Hello World!")
}

func main() {
	fmt.Println("main execution started")

	// create goroutine
	go printHello()

	// schedule another goroutine
	time.Sleep(10 * time.Millisecond)
	fmt.Println("main execution stopped")
}
--------------------------------------------------
main execution started
Hello World!
main execution stopped
```

////////////////////////////////////////////////////////////////////////////////////////////////////

- > What if, instead of 1 milli-second, **printHello goroutine** sleeps for 15 milliseconds.
```go
// https://play.golang.org/p/Pc2nP2BtRiP
--------------------------------------------------
package main

import (
	"fmt"
	"time"
)

func printHello() {
	time.Sleep(15 * time.Millisecond)
	fmt.Println("Hello World!")
}

func main() {
	fmt.Println("main execution started")

	// create goroutine
	go printHello()

	// schedule another goroutine
	time.Sleep(10 * time.Millisecond)
	fmt.Println("main execution stopped")
}
--------------------------------------------------
main execution started
main execution stopped
```
- > In that case, the main goroutine will be available to schedule for scheduler before **printHello goroutine** wakes up, which will also terminate the program immediately before scheduler had time to schedule **printHello goroutine** again.

////////////////////////////////////////////////////////////////////////////////////////////////////

- ***`☛ Working with multiple goroutines`***
- > As I said earlier, you can create as many goroutines as you can. Let’s define two simple functions, one prints characters of the string and another prints digit of the integer slice.
```go
// https://play.golang.org/p/SJano_g1wTV
--------------------------------------------------
package main

import (
	"fmt"
	"time"
)

func getChars(s string) {
	for _, c := range s {
		fmt.Printf("%c ", c)
	}
}

func getDigits(s []int) {
	for _, d := range s {
		fmt.Printf("%d ", d)
	}
}

func main() {
	fmt.Println("main execution started")

	// getChars goroutine
	go getChars("Hello")

	// getDigits goroutine
	go getDigits([]int{1, 2, 3, 4, 5})

	// schedule another goroutine
	time.Sleep(time.Millisecond)

	fmt.Println("\nmain execution stopped")
}
--------------------------------------------------
main execution started
H e l l o 1 2 3 4 5 
main execution stopped
```
- > In the above program, we are creating 2 goroutines from 2 function calls in series. Then we are scheduling any of the two goroutines and which goroutines to schedule is determined by the scheduler. 

////////////////////////////////////////////////////////////////////////////////////////////////////

- > Above result again proves that goroutines are cooperatively scheduled. Let’s add another `time.Sleep` call in-between print operation in the function definition to tell the scheduler to schedule other available goroutines.
```go
// https://play.golang.org/p/lrSIEdNxSaH
--------------------------------------------------
package main

import (
	"fmt"
	"time"
)

var start time.Time

func init() {
	start = time.Now()
}

func getChars(s string) {
	for _, c := range s {
		fmt.Printf("%c at time %v\n", c, time.Since(start))
		time.Sleep(10 * time.Millisecond)
	}
}

func getDigits(s []int) {
	for _, d := range s {
		fmt.Printf("%d at time %v\n", d, time.Since(start))
		time.Sleep(30 * time.Millisecond)
	}
}

func main() {
	fmt.Println("main execution started at time", time.Since(start))

	// getChars goroutine
	go getChars("Hello")

	// getDigits goroutine
	go getDigits([]int{1, 2, 3, 4, 5})

	// schedule another goroutine
	time.Sleep(200 * time.Millisecond)

	fmt.Println("\nmain execution stopped at time", time.Since(start))
}
--------------------------------------------------
main execution started at time 0s
H at time 0s
1 at time 0s
e at time 10ms
l at time 20ms
l at time 30ms
2 at time 30ms
o at time 40ms
3 at time 60ms
4 at time 90ms
5 at time 120ms

main execution stopped at time 200ms
```
- > In the above program, we printed extra information to see when a print statement is executing since the time of execution of the program. In theory, the main goroutine will sleep for 200 milliseconds, hence all other goroutines must do their job in 200 milliseconds before it wakes up and kills the program. `getChars` goroutine will print 1 character and sleep for 10 milli-second, passing control to `getDigits` goroutine which will print a digit and sleeping for 3 milli-seconds passing control to `getChars` goroutine again when it wakes up. Since `getChars` goroutine can **print and sleep** multiple times, at least 2 times while other goroutines are sleeping, we are hoping to see more characters printed in succession than digits.
- > Below result is taken from running above program in **Windows** machine.
```console
main execution started at time 0s

H at time 1.0012ms                         <-|
1 at time 1.0012ms                           | almost at the same time
e at time 11.0283ms                        <-|
l at time 21.0289ms                          | ~10ms apart 
l at time 31.0416ms
2 at time 31.0416ms
o at time 42.0336ms
3 at time 61.0461ms                        <-|
4 at time 91.0647ms                          | 
5 at time 121.0888ms                         | ~30ms apart

main execution stopped at time 200.3137ms    | exiting after 200ms
```
- > Now we understood how to create goroutine and how to work with them. But using `time.Sleep` is just a hack to see the result. In production, we don’t know how much time a goroutine is going to take for the execution. Hence we can't just add random sleep call in the main function. We want our goroutines to tell when they finished the execution. Also at this point, we don’t know how we can get data back from other goroutines or pass data to them, simply, communicate with them. This is where **channels** comes in. Let’s talk about them in the next lesson.

////////////////////////////////////////////////////////////////////////////////////////////////////

- ***`☛ Anonymous goroutines`***
- > If an anonymous function can exist then anonymous goroutine can also exit. Please read `Immediately invoked function` from `functions` lesson to understand this section. Let’s modify our earlier example of **printHello goroutine**.
```go
// https://play.golang.org/p/KSzsPIuG-Ph
--------------------------------------------------
package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println("main execution started")

	// create goroutine
	go func() {
		fmt.Println("Hello World!")
	}()

	// schedule another goroutine
	time.Sleep(10 * time.Millisecond)
	fmt.Println("main execution stopped")
}
--------------------------------------------------
main execution started
Hello World!
main execution stopped
```
- > The result is quite obvious as we defined the function and executed as goroutine in the same statement.
- > *All goroutines are anonymous as we learned from `concurrency` lesson as goroutine does not have an identity. But we are calling that in the sense that function from which it was created was anonymous*.
