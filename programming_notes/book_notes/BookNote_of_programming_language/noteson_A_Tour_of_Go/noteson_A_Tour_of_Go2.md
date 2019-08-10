
# `#` Methods and interfaces || 方法和接口

## `##` Methods and interfaces || 方法和接口

### 方法

https://tour.go-zh.org/methods/1
- > Go 没有类。不过你可以为结构体类型定义方法。***方法就是一类带特殊的 `接收者` 参数的函数***。
- > 方法接收者在它自己的参数列表内，位于 `func` 关键字和方法名之间。
- > 在此例中，`Abs` 方法拥有一个名为 `v`，类型为 `Vertex` 的接收者。
```go
package main

import (
	"fmt"
	"math"
)

type Vertex struct {
	X, Y float64
}

func (v Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func main() {
	v := Vertex{3, 4}
	fmt.Println(v.Abs())
}
--------------------------------------------------
//输出：
5
```

https://tour.go-lang.org/methods/1
- > Go does not have classes. However, ***you can define methods on types***.
- > ***A method is a function with a special receiver argument***.
- > The receiver appears in its own argument list between the `func` keyword and the method name.
- > In this example, the `Abs` method has a receiver of type `Vertex` named `v`.


:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` Concurrency || 并发

## `##` Concurrency || 并发

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

