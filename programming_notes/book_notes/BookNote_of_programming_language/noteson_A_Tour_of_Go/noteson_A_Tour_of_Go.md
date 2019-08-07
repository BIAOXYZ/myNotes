
# 官方网站

[mirror] A Tour of Go https://github.com/golang/tour

***中英文官网目录***：
- A Tour of Go https://tour.golang.org/list
- Go 指南 https://tour.go-zh.org/list

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` Using the tour || 使用本指南

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `##` ~~Welcome! || 欢迎！~~

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` Basics || 基础

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `##` Packages, variables, and functions || 包、变量和函数

### ~~包~~
### ~~导入~~

### 导出名

https://tour.go-zh.org/basics/3
> 在 Go 中，如果一个名字以**大写字母**开头，那么它就是已导出的。例如，`Pizza` 就是个已导出名，`Pi` 也同样，它导出自 `math` 包。`pizza` 和 `pi` 并未以大写字母开头，所以它们是未导出的。
>
> 在导入一个包时，你只能引用其中已导出的名字。任何“未导出”的名字在该包外均无法访问。
>
> 执行代码，观察错误输出。然后将 `math.pi` 改名为 `math.Pi` 再试着执行一次。
```go
package main

import (
	"fmt"
	"math"
)

func main() {
	fmt.Println(math.pi)
}
--------------------------------------------------
//输出（准确说是报错）：
./prog.go:9:14: cannot refer to unexported name math.pi
./prog.go:9:14: undefined: math.pi
```
```go
package main

import (
	"fmt"
	"math"
)

func main() {
	fmt.Println(math.Pi)
}
--------------------------------------------------
//输出：
3.141592653589793
```

### 函数

https://tour.go-zh.org/basics/4
> （参考 [这篇关于 Go 语法声明的文章](https://blog.go-zh.org/gos-declaration-syntax)了解这种类型声明形式出现的原因。）
>> externallink: Go's Declaration Syntax https://blog.go-zh.org/gos-declaration-syntax

### ~~函数（续）~~
### ~~多值返回~~

### 命名返回值

https://tour.go-zh.org/basics/7
- > Go 的返回值可被命名，它们会被视作定义在函数顶部的变量。
- > 没有参数的 `return` 语句返回已命名的返回值。也就是 `直接` 返回

### ~~变量~~
### ~~变量的初始化~~

### 短变量声明

https://tour.go-zh.org/basics/10
- > 在函数中，简洁赋值语句 `:=` 可在类型明确的地方代替 `var` 声明。
- > 函数外的每个语句都必须以关键字开始（`var`, `func` 等等），因此 `:=` 结构不能在函数外使用。

### ~~基本类型~~
### ~~零值~~

### 类型转换

https://tour.go-zh.org/basics/13
> 与 C 不同的是，Go 在不同类型的项之间赋值时需要显式转换。试着移除例子中 float64 或 uint 的转换看看会发生什么。
```go
package main

import (
	"fmt"
	"math"
)

func main() {
	var x, y int = 3, 4
	var f float64 = math.Sqrt(float64(x*x + y*y))
	var z uint = uint(f)
	fmt.Println(x, y, z)
}
--------------------------------------------------
//输出：
3 4 5
```
```go
package main

import (
	"fmt"
	"math"
)

func main() {
	var x, y int = 3, 4
	var f float64 = math.Sqrt((x*x + y*y))
	var z uint = uint(f)
	fmt.Println(x, y, z)
}
--------------------------------------------------
//输出（准确说是报错）：
./prog.go:10:33: cannot use x * x + y * y (type int) as type float64 in argument to math.Sqrt
```

### 类型推导

https://tour.go-zh.org/basics/14
- > 在声明一个变量而不指定其类型时（即使用不带类型的 := 语法或 var = 表达式语法），变量的类型由右值推导得出。<br>
  当右值声明了类型时，新变量的类型与其相同：
  ```go
  var i int
  j := i // j 也是一个 int
  ```
- > 不过当右边包含未指明类型的数值常量时，新变量的类型就可能是 int, float64 或 complex128 了，这取决于常量的精度：
```go
package main

import "fmt"

func main() {
	v := 42 // 修改这里！
	fmt.Printf("v is of type %T\n", v)
}
--------------------------------------------------
//输出：
v is of type int
```

### 常量

https://tour.go-zh.org/basics/15
> 常量不能用 `:=` 语法声明。

### 数值常量

https://tour.go-zh.org/basics/16
```go
package main

import "fmt"

const (
	// 将 1 左移 100 位来创建一个非常大的数字
	// 即这个数的二进制是 1 后面跟着 100 个 0
	Big = 1 << 100
	// 再往右移 99 位，即 Small = 1 << 1，或者说 Small = 2
	Small = Big >> 99
)

func needInt(x int) int { return x*10 + 1 }
func needFloat(x float64) float64 {
	return x * 0.1
}

func main() {
	fmt.Println(needInt(Small))
	fmt.Println(needFloat(Small))
	fmt.Println(needFloat(Big))
}
--------------------------------------------------
//输出：
21
0.2
1.2676506002282295e+29
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `##` Flow control statements: for, if, else, switch and defer || 流程控制语句：for、if、else、switch 和 defer

### for

https://tour.go-zh.org/flowcontrol/1
- > Go 只有一种循环结构：`for` 循环。
- > 基本的 for 循环由三部分组成，它们用分号隔开：
  * > 初始化语句：在第一次迭代前执行
  * > 条件表达式：在每次迭代前求值
  * > 后置语句：在每次迭代的结尾执行
- > 初始化语句通常为一句短变量声明，**该变量声明仅在 `for` 语句的作用域中可见**。
- > **注意**：和 C、Java、JavaScript 之类的语言不同，Go 的 `for` 语句后面的三个构成部分外没有`小括号`， 大括号 `{ }` 则是必须的。
```go
package main

import "fmt"

func main() {
	sum := 0
	for i := 0; i < 10; i++ {
		sum += i
	}
	fmt.Println(sum)
}
--------------------------------------------------
//输出：
45
```

### for（续）

https://tour.go-zh.org/flowcontrol/2
> 初始化语句和后置语句是可选的。
```go
package main

import "fmt"

func main() {
	sum := 1
	for ; sum < 1000; {
		sum += sum
	}
	fmt.Println(sum)
}
--------------------------------------------------
//输出：
1024
```

### for 是 Go 中的 “while”

https://tour.go-zh.org/flowcontrol/3
> 此时你可以去掉分号，因为 C 的 `while` 在 Go 中叫做 `for`。
```GO
package main

import "fmt"

func main() {
	sum := 1
	for sum < 1000 {
		sum += sum
	}
	fmt.Println(sum)
}
--------------------------------------------------
//输出：
1024
```

### 无限循环

https://tour.go-zh.org/flowcontrol/4
> 如果省略循环条件，该循环就不会结束，因此无限循环可以写得很紧凑。
```go
package main

func main() {
	for {
	}
}
--------------------------------------------------
//输出（准确说是报错）：
process took too long
```

### if

https://tour.go-zh.org/flowcontrol/5
> Go 的 `if` 语句与 `for` 循环类似，表达式外无需小括号 `( )` ，而大括号 `{ }` 则是必须的。
```go
package main

import (
	"fmt"
	"math"
)

func sqrt(x float64) string {
	if x < 0 {
		return sqrt(-x) + "i"
	}
	return fmt.Sprint(math.Sqrt(x))
}

func main() {
	fmt.Println(sqrt(2), sqrt(-4))
}
--------------------------------------------------
//输出：
1.4142135623730951 2i
```

### if 的简短语句

https://tour.go-zh.org/flowcontrol/6
> 同 `for` 一样， `if` 语句可以在条件表达式前执行一个简单的语句。**该语句声明的变量作用域仅在 `if` 之内**。（在最后的 `return` 语句处使用 `v` 看看。）
```go
package main

import (
	"fmt"
	"math"
)

func pow(x, n, lim float64) float64 {
	if v := math.Pow(x, n); v < lim {
		return v
	}
	return lim
}

func main() {
	fmt.Println(
		pow(3, 2, 10),
		pow(3, 3, 20),
	)
}
--------------------------------------------------
//输出：
9 20
```
```go
package main

import (
	"fmt"
	"math"
)

func pow(x, n, lim float64) float64 {
	if v := math.Pow(x, n); v < lim {
		return v
	}
	return v
}

func main() {
	fmt.Println(
		pow(3, 2, 10),
		pow(3, 3, 20),
	)
}
--------------------------------------------------
//输出（准确说是报错）：
./prog.go:12:9: undefined: v
```

### if 和 else

https://tour.go-zh.org/flowcontrol/7
> 在 if 的简短语句中声明的变量同样可以在任何对应的 `else` 块中使用。
```go
package main

import (
	"fmt"
	"math"
)

func pow(x, n, lim float64) float64 {
	if v := math.Pow(x, n); v < lim {
		return v
	} else {
		fmt.Printf("%g >= %g\n", v, lim)
	}
	// 这里开始就不能使用 v 了
	return lim
}

func main() {
	fmt.Println(
		pow(3, 2, 10),
		pow(3, 3, 20),
	)
}
--------------------------------------------------
//输出：
27 >= 20
9 20
```

### 练习：循环与函数

https://tour.go-zh.org/flowcontrol/8
- > 计算机通常使用循环来计算 x 的平方根。从某个猜测的值 z 开始，我们可以根据 z² 与 x 的近似度来调整 z，产生一个更好的猜测：
  >> `z -= (z*z - x) / (2*z)`
  >>> 重复调整的过程，猜测的结果会越来越精确，得到的答案也会尽可能接近实际的平方根。
- >（`*`注：`*` 如果你对该算法的细节感兴趣，上面的 z² − x 是 z² 到它所要到达的值（即 x）的距离， 除以的 2z 为 z² 的导数，我们通过 z² 的变化速度来改变 z 的调整量。 这种通用方法叫做[牛顿法](https://zh.wikipedia.org/wiki/%E7%89%9B%E9%A1%BF%E6%B3%95)。 它对很多函数，特别是平方根而言非常有效。）
  >> externallink: 牛顿法 https://zh.wikipedia.org/wiki/%E7%89%9B%E9%A1%BF%E6%B3%95

### switch

https://tour.go-zh.org/flowcontrol/9
> Go 的 switch 语句类似于 C、C++、Java、JavaScript 和 PHP 中的，不过 Go 只运行选定的 case，而非之后所有的 case。 实际上，Go 自动提供了在这些语言中每个 case 后面所需的 `break` 语句。 除非以 `fallthrough` 语句结束，否则分支会自动终止。 Go 的另一点重要的不同在于 switch 的 case 无需为常量，且取值不必为整数。

### ~~switch 的求值顺序~~

### 没有条件的 switch

https://tour.go-zh.org/flowcontrol/11
> 没有条件的 switch 同 `switch true` 一样。这种形式能将一长串 if-then-else 写得更加清晰。
```go
package main

import (
	"fmt"
	"time"
)

func main() {
	t := time.Now()
	switch {
	case t.Hour() < 12:
		fmt.Println("Good morning!")
	case t.Hour() < 17:
		fmt.Println("Good afternoon.")
	default:
		fmt.Println("Good evening.")
	}
}
--------------------------------------------------
//输出：
//(其他两种当然也是可能的，目前北京时间 15:39)
Good evening.
```

### defer

https://tour.go-zh.org/flowcontrol/12
- > defer 语句会将函数推迟到外层函数返回之后执行。
- > 推迟调用的函数其参数会立即求值，但直到外层函数返回前该函数都不会被调用。
```go
package main

import "fmt"

func main() {
	defer fmt.Println("world")

	fmt.Println("hello")
}
--------------------------------------------------
//输出：
hello
world
```

### defer 栈

https://tour.go-zh.org/flowcontrol/13
- > 推迟的函数调用会被压入一个栈中。当外层函数返回时，被推迟的函数会按照后进先出的顺序调用。
- > 更多关于 defer 语句的信息，请阅读此[博文](https://blog.go-zh.org/defer-panic-and-recover)。
  >> externallink: Defer, Panic, and Recover https://blog.go-zh.org/defer-panic-and-recover
```go
package main

import "fmt"

func main() {
	fmt.Println("counting")

	for i := 0; i < 10; i++ {
		defer fmt.Println(i)
	}

	fmt.Println("done")
}
--------------------------------------------------
//输出：
counting
done
9
8
7
6
5
4
3
2
1
0
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `##` More types: structs, slices, and maps || 更多类型：struct、slice 和映射

### 指针

https://tour.go-zh.org/moretypes/1
- > 这也就是通常所说的“间接引用”或“重定向”。
- > 与 C 不同，Go 没有指针运算。

https://tour.golang.org/moretypes/1
> This is known as "dereferencing" or "indirecting".

### 结构体

https://tour.go-zh.org/moretypes/2
```go
package main

import "fmt"

type Vertex struct {
	X int
	Y int
}

func main() {
	fmt.Println(Vertex{1, 2})
}
--------------------------------------------------
//输出：
{1 2}
```

### 结构体字段

https://tour.go-zh.org/moretypes/3
> 结构体字段使用点号来访问。
```go
package main

import "fmt"

type Vertex struct {
	X int
	Y int
}

func main() {
	v := Vertex{1, 2}
	v.X = 4
	fmt.Println(v.X)
}
--------------------------------------------------
//输出：
4
```

### 结构体指针

https://tour.go-zh.org/moretypes/4
- > 结构体字段可以通过结构体指针来访问。
- > 如果我们有一个指向结构体的指针 `p`，那么可以通过 `(*p).X` 来访问其字段 `X`。不过这么写太啰嗦了，所以语言也允许我们使用隐式间接引用，直接写 `p.X` 就可以。
```go
package main

import "fmt"

type Vertex struct {
	X int
	Y int
}

func main() {
	v := Vertex{1, 2}
	p := &v
	p.X = 1e9
	fmt.Println(v)
}
--------------------------------------------------
//输出：
{1000000000 2}
```

### 结构体文法

https://tour.go-zh.org/moretypes/5
- > 结构体文法通过直接列出字段的值来新分配一个结构体。
- > 使用 `Name:` 语法可以仅列出部分字段。（字段名的顺序无关。）
- > 特殊的前缀 `&` 返回一个指向结构体的指针。
```go
package main

import "fmt"

type Vertex struct {
	X, Y int
}

var (
	v1 = Vertex{1, 2}  // 创建一个 Vertex 类型的结构体
	v2 = Vertex{X: 1}  // Y:0 被隐式地赋予
	v3 = Vertex{}      // X:0 Y:0
	p  = &Vertex{1, 2} // 创建一个 *Vertex 类型的结构体（指针）
)

func main() {
	fmt.Println(v1, p, v2, v3)
}
--------------------------------------------------
//输出：
{1 2} &{1 2} {1 0} {0 0}
```

### 数组

https://tour.go-zh.org/moretypes/6
- > 类型 `[n]T` 表示拥有 `n` 个 `T` 类型的值的数组。
- > 表达式 
  >> `var a [10]int` 
  >>> 会将变量 `a` 声明为拥有 10 个整数的数组。
- > 数组的长度是其类型的一部分，因此数组不能改变大小。这看起来是个限制，不过没关系，Go 提供了更加便利的方式来使用数组。
```go
package main

import "fmt"

func main() {
	var a [2]string
	a[0] = "Hello"
	a[1] = "World"
	fmt.Println(a[0], a[1])
	fmt.Println(a)

	primes := [6]int{2, 3, 5, 7, 11, 13}
	fmt.Println(primes)
}
--------------------------------------------------
//输出：
Hello World
[Hello World]
[2 3 5 7 11 13]
```

### 切片

https://tour.go-zh.org/moretypes/7
- > 每个数组的大小都是固定的。而切片则为数组元素提供动态大小的、灵活的视角。在实践中，切片比数组更常用。
- > 类型 `[]T` 表示一个元素类型为 `T` 的切片。
- > 切片通过两个下标来界定，即一个上界和一个下界，二者以冒号分隔：
  >> `a[low : high]`
  >>> 它会选择一个半开区间，包括第一个元素，但排除最后一个元素。
- > 以下表达式创建了一个切片，它包含 `a` 中下标从 1 到 3 的元素：
  >> `a[1:4]`
```go
package main

import "fmt"

func main() {
	primes := [6]int{2, 3, 5, 7, 11, 13}

	var s []int = primes[1:4]
	fmt.Println(s)
}
```
```
//输出：
[3 5 7]
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` Methods and interfaces || 方法和接口

## `##` Methods and interfaces || 方法和接口

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` Concurrency || 并发

## `##` Concurrency || 并发

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

