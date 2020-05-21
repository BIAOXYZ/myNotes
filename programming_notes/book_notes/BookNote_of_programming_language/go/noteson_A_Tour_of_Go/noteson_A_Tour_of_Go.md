
# 官方网站

[mirror] A Tour of Go https://github.com/golang/tour

***中英文官网目录***：
- A Tour of Go https://tour.golang.org/list
- Go 指南 https://tour.go-zh.org/list

## 国内可直接访问地址

Go 指南 http://tour.studygolang.com/list

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

### ~~恭喜！~~

https://tour.go-zh.org/basics/17

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

### ~~恭喜！~~

https://tour.go-zh.org/flowcontrol/14

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

[Struct Literals](https://tour.golang.org/moretypes/5)
- > A struct literal denotes a newly allocated struct value by ***listing the values of its fields***.
- > You can list just a subset of fields by using the `Name:` syntax. (And the order of named fields is irrelevant.)
- > The special prefix `&` returns a pointer to the struct value.

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
--------------------------------------------------
//输出：
[3 5 7]
```

### 切片就像数组的引用

https://tour.go-zh.org/moretypes/8
> **切片并不存储任何数据**，它只是描述了底层数组中的一段。**更改切片的元素会修改其底层数组中对应的元素**。与它共享底层数组的切片都会观测到这些修改。
```go
package main

import "fmt"

func main() {
	names := [4]string{
		"John",
		"Paul",
		"George",
		"Ringo",
	}
	fmt.Println(names)

	a := names[0:2]
	b := names[1:3]
	fmt.Println(a, b)

	b[0] = "XXX"
	fmt.Println(a, b)
	fmt.Println(names)
}
--------------------------------------------------
//输出：
[John Paul George Ringo]
[John Paul] [Paul George]
[John XXX] [XXX George]
[John XXX George Ringo]
```

### 切片文法 

https://tour.go-zh.org/moretypes/9
- > 切片文法类似于没有长度的数组文法。
- > 这是一个数组文法：
  ```go
  [3]bool{true, true, false}
  ```
- > 下面这样则会创建一个和上面相同的数组，然后构建一个引用了它的切片：
  ```go
  []bool{true, true, false}
  ```
```go
package main

import "fmt"

func main() {
	q := []int{2, 3, 5, 7, 11, 13}
	fmt.Println(q)

	r := []bool{true, false, true, true, false, true}
	fmt.Println(r)

	s := []struct {
		i int
		b bool
	}{
		{2, true},
		{3, false},
		{5, true},
		{7, true},
		{11, false},
		{13, true},
	}
	fmt.Println(s)
}
--------------------------------------------------
//输出：
[2 3 5 7 11 13]
[true false true true false true]
[{2 true} {3 false} {5 true} {7 true} {11 false} {13 true}]
```

### 切片的默认行为

https://tour.go-zh.org/moretypes/10
- > 在进行切片时，你可以利用它的默认行为来忽略上下界。
- > 切片下界的默认值为 `0`，上界则是该切片的长度。
- > 对于数组
  ```go
  var a [10]int
  ```
- > 来说，以下切片是等价的：
  ```go
  a[0:10]
  a[:10]
  a[0:]
  a[:]
  ```
```go
package main

import "fmt"

func main() {
	s := []int{2, 3, 5, 7, 11, 13}

	s = s[1:4]
	fmt.Println(s)

	s = s[:2]
	fmt.Println(s)

	s = s[1:]
	fmt.Println(s)
}
--------------------------------------------------
//输出：
[3 5 7]
[3 5]
[5]
```

### 切片的长度与容量

https://tour.go-zh.org/moretypes/11
> 切片拥有 `长度` 和 `容量`。切片的长度就是它所包含的元素个数。切片的容量是从它的第一个元素开始数，到其底层数组元素末尾的个数。切片 `s` 的长度和容量可通过表达式 `len(s)` 和 `cap(s)` 来获取。你可以通过重新切片来扩展一个切片，给它提供足够的容量。试着修改示例程序中的切片操作，向外扩展它的容量，看看会发生什么。
```go
package main

import "fmt"

func main() {
	s := []int{2, 3, 5, 7, 11, 13}
	printSlice(s)

	// 截取切片使其长度为 0
	s = s[:0]
	printSlice(s)

	// 拓展其长度
	s = s[:4]
	printSlice(s)

	// 舍弃前两个值
	s = s[2:]
	printSlice(s)
}

func printSlice(s []int) {
	fmt.Printf("len=%d cap=%d %v\n", len(s), cap(s), s)
}
--------------------------------------------------
//输出：
len=6 cap=6 [2 3 5 7 11 13]
len=0 cap=6 []
len=4 cap=6 [2 3 5 7]
len=2 cap=4 [5 7]
```
```go
package main

import "fmt"

func main() {
	s := []int{2, 3, 5, 7, 11, 13}
	printSlice(s)

	// 截取切片使其长度为 0
	s = s[:0]
	printSlice(s)

	// 拓展其长度 --> 这里改成8
	s = s[:8]
	printSlice(s)

	// 舍弃前两个值
	s = s[2:]
	printSlice(s)
}

func printSlice(s []int) {
	fmt.Printf("len=%d cap=%d %v\n", len(s), cap(s), s)
}
--------------------------------------------------
//输出（及报错信息）：
len=6 cap=6 [2 3 5 7 11 13]
len=0 cap=6 []
panic: runtime error: slice bounds out of range
```
```go
package main

import "fmt"

func main() {
	s := []int{2, 3, 5, 7, 11, 13}
	printSlice(s)

	// 截取切片使其长度为 0
	s = s[:0]
	printSlice(s)

	// 拓展其长度
	s = s[:4]
	printSlice(s)

	// 舍弃前两个值 --> 这里改成8
	s = s[8:]
	printSlice(s)
}

func printSlice(s []int) {
	fmt.Printf("len=%d cap=%d %v\n", len(s), cap(s), s)
}
--------------------------------------------------
//输出（及报错信息）：
len=6 cap=6 [2 3 5 7 11 13]
len=0 cap=6 []
len=4 cap=6 [2 3 5 7]
panic: runtime error: slice bounds out of range
```

### nil 切片

https://tour.go-zh.org/moretypes/12
> 切片的零值是 `nil`。nil 切片的长度和容量为 `0` 且**没有底层数组**。
```go
package main

import "fmt"

func main() {
	var s []int
	fmt.Println(s, len(s), cap(s))
	if s == nil {
		fmt.Println("nil!")
	}
}
--------------------------------------------------
//输出：
[] 0 0
nil!
```

### 用 make 创建切片

https://tour.go-zh.org/moretypes/13
- > 切片可以用内建函数 `make` 来创建，这也是你创建动态数组的方式。
- > `make` 函数会分配一个元素为零值的数组并返回一个引用了它的切片：
  ```go
  a := make([]int, 5)  // len(a)=5
  ```
- > 要指定它的容量，需向 `make` 传入第三个参数：
  ```go
  b := make([]int, 0, 5) // len(b)=0, cap(b)=5
  
  b = b[:cap(b)] // len(b)=5, cap(b)=5
  b = b[1:]      // len(b)=4, cap(b)=4
  ```
```go
package main

import "fmt"

func main() {
	a := make([]int, 5)
	printSlice("a", a)

	b := make([]int, 0, 5)
	printSlice("b", b)

	c := b[:2]
	printSlice("c", c)

	d := c[2:5]
	printSlice("d", d)
}

func printSlice(s string, x []int) {
	fmt.Printf("%s len=%d cap=%d %v\n",
		s, len(x), cap(x), x)
}
--------------------------------------------------
//输出：
a len=5 cap=5 [0 0 0 0 0]
b len=0 cap=5 []
c len=2 cap=5 [0 0]
d len=3 cap=3 [0 0 0]
```

### 切片的切片

https://tour.go-zh.org/moretypes/14
> 切片可包含任何类型，甚至包括其它的切片。
```go
package main

import (
	"fmt"
	"strings"
)

func main() {
	// 创建一个井字板（经典游戏）
	board := [][]string{
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
	}

	// 两个玩家轮流打上 X 和 O
	board[0][0] = "X"
	board[2][2] = "O"
	board[1][2] = "X"
	board[1][0] = "O"
	board[0][2] = "X"

	for i := 0; i < len(board); i++ {
		fmt.Printf("%s\n", strings.Join(board[i], " "))
	}
}
--------------------------------------------------
//输出：
X _ X
O _ X
_ _ O
```

### 向切片追加元素

https://tour.go-zh.org/moretypes/15
- > 为切片追加新的元素是种常用的操作，为此 Go 提供了内建的 `append` 函数。内建函数的[文档](https://go-zh.org/pkg/builtin/#append)对此函数有详细的介绍。
   ```go
   func append(s []T, vs ...T) []T
   ```
- > `append` 的第一个参数 `s` 是一个元素类型为 `T` 的切片，其余类型为 `T` 的值将会追加到该切片的末尾。
- > `append` 的结果是一个包含原切片所有元素加上新添加元素的切片。
- > 当 `s` 的底层数组太小，不足以容纳所有给定的值时，它就会分配一个更大的数组。返回的切片会指向这个新分配的数组。（要了解关于切片的更多内容，请阅读文章 [Go 切片：用法和本质](https://blog.go-zh.org/go-slices-usage-and-internals)。）
  >> Go 切片：用法和本质 https://blog.go-zh.org/go-slices-usage-and-internals
```go
package main

import "fmt"

func main() {
	var s []int
	printSlice(s)

	// 添加一个空切片
	s = append(s, 0)
	printSlice(s)

	// 这个切片会按需增长
	s = append(s, 1)
	printSlice(s)

	// 可以一次性添加多个元素
	s = append(s, 2, 3, 4)
	printSlice(s)
}

func printSlice(s []int) {
	fmt.Printf("len=%d cap=%d %v\n", len(s), cap(s), s)
}
--------------------------------------------------
//输出：
len=0 cap=0 []
len=1 cap=2 [0]
len=2 cap=2 [0 1]
len=5 cap=8 [0 1 2 3 4]
```

https://tour.go-lang.org/moretypes/15 【从英文原版就能看出来第一个注释`// 添加一个空切片`翻译得太烂了！人家原意明明是`append适用于nil切片`】【这里有个问题还是没想通，为什么在nil切片后面追加一个元素切片的容量会从0变成2而不是1？】
```
package main

import "fmt"

func main() {
	var s []int
	printSlice(s)

	// append works on nil slices.
	s = append(s, 0)
	printSlice(s)

	// The slice grows as needed.
	s = append(s, 1)
	printSlice(s)

	// We can add more than one element at a time.
	s = append(s, 2, 3, 4)
	printSlice(s)
}

func printSlice(s []int) {
	fmt.Printf("len=%d cap=%d %v\n", len(s), cap(s), s)
}
--------------------------------------------------
//输出：
len=0 cap=0 []
len=1 cap=2 [0]
len=2 cap=2 [0 1]
len=5 cap=8 [0 1 2 3 4]
```


### Range

https://tour.go-zh.org/moretypes/16
> `for` 循环的 `range` 形式可遍历切片或映射。当使用 `for` 循环遍历切片时，每次迭代都会返回两个值。第一个值为当前元素的下标，第二个值为该下标所对应元素的一份副本。
```go
package main

import "fmt"

var pow = []int{1, 2, 4, 8, 16, 32, 64, 128}

func main() {
	for i, v := range pow {
		fmt.Printf("2**%d = %d\n", i, v)
	}
}
--------------------------------------------------
//输出：
2**0 = 1
2**1 = 2
2**2 = 4
2**3 = 8
2**4 = 16
2**5 = 32
2**6 = 64
2**7 = 128
```

### range（续）

https://tour.go-zh.org/moretypes/17
- > 可以将下标或值赋予 `_` 来忽略它。
  ```go
  for i, _ := range pow
  for _, value := range pow
  ```
- > 若你只需要索引，忽略第二个变量即可。
  ```go
  for i := range pow
  ```
```go
package main

import "fmt"

func main() {
	pow := make([]int, 10)
	for i := range pow {
		pow[i] = 1 << uint(i) // == 2**i
	}
	for _, value := range pow {
		fmt.Printf("%d\n", value)
	}
}
--------------------------------------------------
//输出：
1
2
4
8
16
32
64
128
256
512
```

### 练习：切片

https://tour.go-zh.org/moretypes/18

### 映射

https://tour.go-zh.org/moretypes/19
- > 映射将`键`映射到`值`。
- > 映射的零值为 `nil` 。`nil 映射`既没有键，也不能添加键。
- > `make` 函数会返回给定类型的映射，并将其初始化备用。
```go
package main

import "fmt"

type Vertex struct {
	Lat, Long float64
}

var m map[string]Vertex

func main() {
	m = make(map[string]Vertex)
	m["Bell Labs"] = Vertex{
		40.68433, -74.39967,
	}
	fmt.Println(m["Bell Labs"])
}
--------------------------------------------------
//输出：
{40.68433 -74.39967}
```

### 映射的文法

https://tour.go-zh.org/moretypes/20
> 映射的文法与结构体相似，不过必须有键名。
```go
package main

import "fmt"

type Vertex struct {
	Lat, Long float64
}

var m = map[string]Vertex{
	"Bell Labs": Vertex{
		40.68433, -74.39967,
	},
	"Google": Vertex{
		37.42202, -122.08408,
	},
}

func main() {
	fmt.Println(m)
}
--------------------------------------------------
//输出：
map[Bell Labs:{40.68433 -74.39967} Google:{37.42202 -122.08408}]
```

### 映射的文法（续）

https://tour.go-zh.org/moretypes/21
> 若顶级类型只是一个类型名，你可以在文法的元素中省略它。

Map literals continued https://tour.golang.org/moretypes/21
> If the top-level type is just a type name, you can omit it from the elements of the literal.

```go
package main

import "fmt"

type Vertex struct {
	Lat, Long float64
}

var m = map[string]Vertex{
	"Bell Labs": {40.68433, -74.39967},
	"Google":    {37.42202, -122.08408},
}

func main() {
	fmt.Println(m)
}
--------------------------------------------------
//输出：
map[Bell Labs:{40.68433 -74.39967} Google:{37.42202 -122.08408}]
```

### 修改映射

https://tour.go-zh.org/moretypes/22
- > 在映射 `m` 中插入或修改元素：
  ```go
  m[key] = elem
  ```
  获取元素：
  ```go
  elem = m[key]
  ```
  删除元素：
  ```go
  delete(m, key)
  ```
- > 通过双赋值检测某个键是否存在：
  ```go
  elem, ok = m[key]
  ```
  若 `key` 在 `m` 中，`ok` 为 `true` ；否则，`ok` 为 `false`。若 `key` 不在映射中，那么 `elem` 是该映射元素类型的`零值`。
- > 同样的，***当从映射中读取某个不存在的键时，结果是映射的元素类型的`零值`***。
- > 注 ：若 `elem` 或 `ok` 还未声明，你可以使用短变量声明：
  ```go
  elem, ok := m[key]
  ```
```go
package main

import "fmt"

func main() {
	m := make(map[string]int)

	m["Answer"] = 42
	fmt.Println("The value:", m["Answer"])

	m["Answer"] = 48
	fmt.Println("The value:", m["Answer"])

	delete(m, "Answer")
	fmt.Println("The value:", m["Answer"])

	v, ok := m["Answer"]
	fmt.Println("The value:", v, "Present?", ok)
}
--------------------------------------------------
//输出：
The value: 42
The value: 48
The value: 0
The value: 0 Present? false
```

### 练习：映射

https://tour.go-zh.org/moretypes/23

### 函数值

https://tour.go-zh.org/moretypes/24
- > 函数也是***值***。它们可以像其它值一样传递。
- > 函数值可以用作函数的参数或返回值。
```go
package main

import (
	"fmt"
	"math"
)

func compute(fn func(float64, float64) float64) float64 {
	return fn(3, 4)
}

func main() {
	hypot := func(x, y float64) float64 {
		return math.Sqrt(x*x + y*y)
	}
	fmt.Println(hypot(5, 12))

	fmt.Println(compute(hypot))
	fmt.Println(compute(math.Pow))
}
--------------------------------------------------
//输出：
13
5
81
```

### 函数的闭包

https://tour.go-zh.org/moretypes/25
- > Go 函数可以是一个闭包。闭包是一个函数值，它引用了其函数体之外的变量。该函数可以访问并赋予其引用的变量的值，换句话说，该函数被这些变量“绑定”在一起。
- > 例如，函数 `adder` 返回一个闭包。每个闭包都被绑定在其各自的 `sum` 变量上。

Function closures https://tour.golang.org/moretypes/25
- > Go functions may be closures. A closure is a function value that references variables from outside its body. The function may access and assign to the referenced variables; in this sense the function is "bound" to the variables.
- > For example, the `adder` function returns a closure. Each closure is bound to its own `sum` variable.

```go
package main

import "fmt"

func adder() func(int) int {
	sum := 0
	return func(x int) int {
		sum += x
		return sum
	}
}

func main() {
	pos, neg := adder(), adder()
	for i := 0; i < 10; i++ {
		fmt.Println(
			pos(i),
			neg(-2*i),
		)
	}
}
--------------------------------------------------
//输出：
0 0
1 -2
3 -6
6 -12
10 -20
15 -30
21 -42
28 -56
36 -72
45 -90
```

### 练习：斐波纳契闭包

https://tour.go-zh.org/moretypes/26

### ~~恭喜！~~

https://tour.go-zh.org/moretypes/27
