
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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
