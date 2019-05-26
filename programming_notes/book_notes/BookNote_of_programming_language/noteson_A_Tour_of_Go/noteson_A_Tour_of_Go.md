
# 官方网站

[mirror] A Tour of Go https://github.com/golang/tour

***中英文官网目录***：
- A Tour of Go https://tour.golang.org/list
- Go 指南 https://tour.go-zh.org/list

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Using the tour || 使用本指南

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ~~Welcome! || 欢迎！~~

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Basics || 基础

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Packages, variables, and functions || 包、变量和函数

### 函数

https://tour.go-zh.org/basics/4
> （参考 [这篇关于 Go 语法声明的文章](https://blog.go-zh.org/gos-declaration-syntax)了解这种类型声明形式出现的原因。）
>> Go's Declaration Syntax https://blog.go-zh.org/gos-declaration-syntax

### 命名返回值

https://tour.go-zh.org/basics/7
- > Go 的返回值可被命名，它们会被视作定义在函数顶部的变量。
- > 没有参数的 `return` 语句返回已命名的返回值。也就是 `直接` 返回

### 短变量声明

https://tour.go-zh.org/basics/10
- > 在函数中，简洁赋值语句 `:=` 可在类型明确的地方代替 `var` 声明。
- > 函数外的每个语句都必须以关键字开始（`var`, `func` 等等），因此 `:=` 结构不能在函数外使用。

### 类型转换

https://tour.go-zh.org/basics/13

### 常量

https://tour.go-zh.org/basics/15
> 常量不能用 `:=` 语法声明。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Flow control statements: for, if, else, switch and defer || 流程控制语句：for、if、else、switch 和 defer

### for

https://tour.go-zh.org/flowcontrol/1
- > Go 只有一种循环结构：`for` 循环。
- > 初始化语句通常为一句短变量声明，该变量声明仅在 `for` 语句的作用域中可见。
- > 注意：和 C、Java、JavaScript 之类的语言不同，Go 的 `for` 语句后面的三个构成部分外没有`小括号`， 大括号 `{ }` 则是必须的。
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
```

### if

https://tour.go-zh.org/flowcontrol/5
> Go 的 `if` 语句与 `for` 循环类似，表达式外无需小括号 `( )` ，而大括号 `{ }` 则是必须的。
```go
func sqrt(x float64) string {
	if x < 0 {
		return sqrt(-x) + "i"
	}
	return fmt.Sprint(math.Sqrt(x))
}
```

### if 的简短语句

https://tour.go-zh.org/flowcontrol/6
> 同 `for` 一样， `if` 语句可以在条件表达式前执行一个简单的语句。该语句声明的变量作用域仅在 `if` 之内。

### if 和 else

https://tour.go-zh.org/flowcontrol/7
> 在 if 的简短语句中声明的变量同样可以在任何对应的 else 块中使用。
```go
func pow(x, n, lim float64) float64 {
	if v := math.Pow(x, n); v < lim {
		return v
	} else {
		fmt.Printf("%g >= %g\n", v, lim)
	}
	// 这里开始就不能使用 v 了
	return lim
}
```

### 练习：循环与函数

https://tour.go-zh.org/flowcontrol/8
- > 计算机通常使用循环来计算 x 的平方根。从某个猜测的值 z 开始，我们可以根据 z² 与 x 的近似度来调整 z，产生一个更好的猜测：
  >> `z -= (z*z - x) / (2*z)`
  >>> 重复调整的过程，猜测的结果会越来越精确，得到的答案也会尽可能接近实际的平方根。
- >（`*`注：`*` 如果你对该算法的细节感兴趣，上面的 z² − x 是 z² 到它所要到达的值（即 x）的距离， 除以的 2z 为 z² 的导数，我们通过 z² 的变化速度来改变 z 的调整量。 这种通用方法叫做[牛顿法](https://zh.wikipedia.org/wiki/%E7%89%9B%E9%A1%BF%E6%B3%95)。 它对很多函数，特别是平方根而言非常有效。）

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## More types: structs, slices, and maps || 更多类型：struct、slice 和映射

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Methods and interfaces || 方法和接口

## Methods and interfaces || 方法和接口

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Concurrency || 并发

## Concurrency || 并发

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

