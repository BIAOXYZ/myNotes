
# `#` Concurrency || 并发

## `##` Concurrency || 并发

### Go 程  // -->  知道为什么有的部分要上英文版了吧。。。

https://tour.go-zh.org/concurrency/1
- > Go 程（goroutine）是由 Go 运行时管理的轻量级线程。
  ```go
  go f(x, y, z)
  ```
  > 会启动一个新的 Go 程并执行
  ```go
  f(x, y, z)
  ```
  > `f, x, y` 和 `z` 的求值发生在***当前的 Go 程中***，而 `f` 的执行发生在***新的 Go 程中***。
- > Go 程在***相同的`地址空间`***中运行，因此***在访问`共享的内存`时必须`进行同步`***。`sync` 包提供了这种能力，不过在 Go 中并不经常用到，因为还有其它的办法（见下一页）。
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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
