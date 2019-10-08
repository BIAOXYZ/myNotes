
# `#` Concurrency || 并发

## `##` Concurrency || 并发

### Go 程  // -->  知道为什么有的部分要上英文版了吧。。。

https://tour.go-zh.org/concurrency/1
- > Go 程（goroutine）是由 Go 运行时管理的***轻量级线程***。
  ```go
  go f(x, y, z)
  ```
  > 会启动一个新的 Go 程并执行
  ```go
  f(x, y, z)
  ```
  > `f, x, y` 和 `z` 的求值发生在***当前的 Go 程中***，而 `f` 的执行发生在***新的 Go 程中***。
- > Go 程在***相同的`地址空间`***中运行，因此***在访问`共享的内存`时必须`进行同步`***。`sync` 包提供了这种能力，不过在 Go 中并不经常用到，因为还有其它的办法（见下一页）。

Goroutines https://tour.go-lang.org/concurrency/1
- > A `goroutine` is a lightweight thread managed by the Go runtime.
  ```go
  go f(x, y, z)
  ```
  > starts a new goroutine running
  ```go
  f(x, y, z)
  ```
  > The evaluation of `f, x, y`, and `z` happens in the current goroutine and the execution of `f` happens in the new goroutine.
- > Goroutines run in the same address space, so access to shared memory must be synchronized. The `sync` package provides useful primitives, although you won't need them much in Go as there are other primitives. (See the next slide.)

```go
package main

import (
	"fmt"
	"time"
)

func say(s string) {
	for i := 0; i < 5; i++ {
		time.Sleep(100 * time.Millisecond)
		fmt.Println(s)
	}
}

func main() {
	go say("world")
	say("hello")
}
--------------------------------------------------
//输出：
world
hello
hello
world
world
hello
hello
world
world
hello
```

```go
//// 自己给原来的函数加上一个统计时间，从而更容易看清具体的调度情况。

package main

import (
	"fmt"
	"time"
)

////添加一个start变量好计算时间。
var start time.Time
func init() {
	start = time.Now()
}

func say(s string) {
	for i := 0; i < 5; i++ {
		time.Sleep(100 * time.Millisecond)
		////注意Println要变成Printf，不然%d，%s，%v之类格式化输出形式的不生效。
		fmt.Printf("This the %d-th %s at time %v\n", i, s, time.Since(start))
	}
}

func main() {
	go say("world")
	say("hello")
}
--------------------------------------------------
//输出：
This the 0-th world at time 100ms
This the 0-th hello at time 100ms
This the 1-th hello at time 200ms
This the 1-th world at time 200ms
This the 2-th world at time 300ms
This the 2-th hello at time 300ms
This the 3-th hello at time 400ms
This the 3-th world at time 400ms
This the 4-th world at time 500ms
This the 4-th hello at time 500ms
```

### 信道 // --> 反正channel不管翻译成信道还是通道，都那样

https://tour.go-zh.org/concurrency/2
- > 信道是带有类型的管道，你可以通过它用信道操作符 `<-` 来发送或者接收值。
  ```go
  ch <- v    // 将 v 发送至信道 ch。
  v := <-ch  // 从 ch 接收值并赋予 v。
  ```
  > （“箭头”就是数据流的方向。）
- > 和映射与切片一样，信道在使用前必须创建：
  ```go
  ch := make(chan int)
  ```
- > 默认情况下，发送和接收操作在另一端准备好之前都会阻塞。这使得 Go 程可以在没有显式的锁或竞态变量的情况下进行同步。
- > 以下示例对切片中的数进行求和，将任务分配给两个 Go 程。一旦两个 Go 程完成了它们的计算，它就能算出最终的结果。

Channels https://tour.go-lang.org/concurrency/2
- > Channels are a typed **conduit** through which you can send and receive values with the channel operator, `<-`.
  ```go
  ch <- v    // Send v to channel ch.
  v := <-ch  // Receive from ch, and assign value to v.
  ```
  (The data flows in the direction of the arrow.)
- > Like maps and slices, channels must be created before use:
  ```go
  ch := make(chan int)
  ```
- > By default, sends and receives block until the other side is ready. This allows goroutines to synchronize without explicit locks or condition variables.
- > The example code sums the numbers in a slice, distributing the work between two goroutines. Once both goroutines have completed their computation, it calculates the final result.

```go
package main

import "fmt"

func sum(s []int, c chan int) {
	sum := 0
	for _, v := range s {
		sum += v
	}
	c <- sum // 将和送入 c
}

func main() {
	s := []int{7, 2, 8, -9, 4, 0}

	c := make(chan int)
	go sum(s[:len(s)/2], c)
	go sum(s[len(s)/2:], c)
	x, y := <-c, <-c // 从 c 中接收

	fmt.Println(x, y, x+y)
}
--------------------------------------------------
//输出：
-5 17 12
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
