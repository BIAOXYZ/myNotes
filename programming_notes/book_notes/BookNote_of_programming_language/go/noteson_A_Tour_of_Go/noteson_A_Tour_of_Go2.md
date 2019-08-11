
# `#` Methods and interfaces || 方法和接口

## `##` Methods and interfaces || 方法和接口

### 方法

https://tour.go-zh.org/methods/1
- > Go 没有类。不过你可以为结构体类型定义方法。***方法就是一类带特殊的 `接收者` 参数的`函数`***。
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
- > Go does not have classes. However, ***you can define methods on `types`***.
- > ***A method is a `function` with `a special receiver argument`***.
- > The receiver appears in its own argument list between the `func` keyword and the method name.
- > In this example, the `Abs` method has a receiver of type `Vertex` named `v`.

### 方法即函数

https://tour.go-zh.org/methods/2
> 记住：***方法只是个`带接收者参数`的`函数`***。现在这个 `Abs` 的写法就是个正常的函数，功能并没有什么变化。
```go
package main

import (
	"fmt"
	"math"
)

type Vertex struct {
	X, Y float64
}

func Abs(v Vertex) float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func main() {
	v := Vertex{3, 4}
	fmt.Println(Abs(v))
}
--------------------------------------------------
//输出：
5
```

### 方法（续）

https://tour.go-zh.org/methods/3
- > 你也可以为***非结构体类型***声明方法。
- > 在此例中，我们看到了一个带 `Abs` 方法的数值类型 `MyFloat`。
- > 你只能为在同一包内定义的类型的接收者声明方法，而不能为其它包内定义的类型（包括 `int` 之类的内建类型）的接收者声明方法。
  >> （译注：就是***接收者的`类型定义`和`方法声明`必须在同一包内***；不能为***内建类型***声明方法。）
```go
package main

import (
	"fmt"
	"math"
)

type MyFloat float64

func (f MyFloat) Abs() float64 {
	if f < 0 {
		return float64(-f)
	}
	return float64(f)
}

func main() {
	f := MyFloat(-math.Sqrt2)
	fmt.Println(f.Abs())
}
--------------------------------------------------
//输出：
1.4142135623730951
```

### 指针接收者

https://tour.go-zh.org/methods/4
- > 你可以为***指针接收者***声明方法。
- > 这意味着对于某类型 `T`，接收者的类型可以用 `*T` 的文法。（此外，`T` 不能是像 `*int` 这样的指针。）
  >> 例如，这里为 `*Vertex` 定义了 `Scale` 方法。
- > 指针接收者的方法可以修改接收者指向的值（就像 `Scale` 在这做的）。由于方法经常需要修改它的接收者，指针接收者比值接收者更常用。
- > 试着移除第 16 行 `Scale` 函数声明中的 `*`，观察此程序的行为如何变化。
  >> 若使用值接收者，那么 `Scale` 方法会对原始 `Vertex` 值的副本进行操作。（对于函数的其它参数也是如此。）`Scale` 方法必须用指针接受者来更改 `main` 函数中声明的 `Vertex` 的值。
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

func (v *Vertex) Scale(f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

func main() {
	v := Vertex{3, 4}
	v.Scale(10)
	fmt.Println(v.Abs())
}
--------------------------------------------------
//输出：
50
```
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

func (v Vertex) Scale(f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

func main() {
	v := Vertex{3, 4}
	v.Scale(10)
	fmt.Println(v.Abs())
}
--------------------------------------------------
//输出：
5
```

### 指针与函数

https://tour.go-zh.org/methods/5
- > 现在我们要把 `Abs` 和 `Scale` 方法重写为函数。
- > 同样，我们先试着移除掉第 16 的 `*`。你能看出为什么程序的行为改变了吗？要怎样做才能让该示例顺利通过编译？（若你不确定，继续往下看。）
```go
package main

import (
	"fmt"
	"math"
)

type Vertex struct {
	X, Y float64
}

func Abs(v Vertex) float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func Scale(v *Vertex, f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

func main() {
	v := Vertex{3, 4}
	Scale(&v, 10)
	fmt.Println(Abs(v))
}
--------------------------------------------------
//输出：
50
```
```go
package main

import (
	"fmt"
	"math"
)

type Vertex struct {
	X, Y float64
}

func Abs(v Vertex) float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func Scale(v Vertex, f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

func main() {
	v := Vertex{3, 4}
	Scale(&v, 10)
	fmt.Println(Abs(v))
}
--------------------------------------------------
//输出（准确说是报错）：
./prog.go:23:8: cannot use &v (type *Vertex) as type Vertex in argument to Scale
```
```go
package main

import (
	"fmt"
	"math"
)

type Vertex struct {
	X, Y float64
}

func Abs(v Vertex) float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func Scale(v Vertex, f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

func main() {
	v := Vertex{3, 4}
	Scale(v, 10)
	fmt.Println(Abs(v))
}
--------------------------------------------------
//输出：
5
```

### 方法与指针重定向

https://tour.go-zh.org/methods/6
- > 比较前两个程序，你大概会注意到带指针参数的函数必须接受一个指针：
  ```go
  var v Vertex
  ScaleFunc(v, 5)  // 编译错误！
  ScaleFunc(&v, 5) // OK
  ```
- > 而以指针为接收者的方法被调用时，接收者既能为值又能为指针：
  ```go
  var v Vertex
  v.Scale(5)  // OK
  p := &v
  p.Scale(10) // OK
  ```
- > 对于语句 `v.Scale(5)`，即便 `v` 是个值而非指针，带指针接收者的方法也能被直接调用。 也就是说，由于 `Scale` 方法有一个指针接收者，为方便起见，Go 会将语句 `v.Scale(5)` 解释为 `(&v).Scale(5)`。
```go
package main

import "fmt"

type Vertex struct {
	X, Y float64
}

func (v *Vertex) Scale(f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

func ScaleFunc(v *Vertex, f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

func main() {
	v := Vertex{3, 4}
	v.Scale(2)
	ScaleFunc(&v, 10)

	p := &Vertex{4, 3}
	p.Scale(3)
	ScaleFunc(p, 8)

	fmt.Println(v, p)
}
--------------------------------------------------
//输出：
{60 80} &{96 72}
```

### 方法与指针重定向（续）

https://tour.go-zh.org/methods/7
- > 同样的事情也发生在相反的方向。
- > 接受一个值作为参数的函数必须接受一个指定类型的值：
  ```go
  var v Vertex
  fmt.Println(AbsFunc(v))  // OK
  fmt.Println(AbsFunc(&v)) // 编译错误！
- > 而以值为接收者的方法被调用时，接收者既能为值又能为指针：
  ```go
  var v Vertex
  fmt.Println(v.Abs()) // OK
  p := &v
  fmt.Println(p.Abs()) // OK
- > 这种情况下，方法调用 `p.Abs()` 会被解释为 `(*p).Abs()`。
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

func AbsFunc(v Vertex) float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func main() {
	v := Vertex{3, 4}
	fmt.Println(v.Abs())
	fmt.Println(AbsFunc(v))

	p := &Vertex{4, 3}
	fmt.Println(p.Abs())
	fmt.Println(AbsFunc(*p))
}
--------------------------------------------------
//输出：
5
5
5
5
```

### 选择值或指针作为接收者

https://tour.go-zh.org/methods/8
- > 使用指针接收者的原因有二：
  * > 首先，方法能够修改其接收者指向的值。
  * > 其次，这样可以避免在每次调用方法时复制该值。若值的类型为大型结构体时，这样做会更加高效。
- > 在本例中，`Scale` 和 `Abs` 接收者的类型为 `*Vertex`，即便 `Abs` 并不需要修改其接收者。
- > 通常来说，所有给定类型的方法都应该有值或指针接收者，但并不应该二者混用。（我们会在接下来几页中明白为什么。）
```go
package main

import (
	"fmt"
	"math"
)

type Vertex struct {
	X, Y float64
}

func (v *Vertex) Scale(f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

func (v *Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func main() {
	v := &Vertex{3, 4}
	fmt.Printf("Before scaling: %+v, Abs: %v\n", v, v.Abs())
	v.Scale(5)
	fmt.Printf("After scaling: %+v, Abs: %v\n", v, v.Abs())
}
--------------------------------------------------
//输出：
Before scaling: &{X:3 Y:4}, Abs: 5
After scaling: &{X:15 Y:20}, Abs: 25
```

### 接口

https://tour.go-zh.org/methods/9
- > **`接口类型`** 是由一组方法签名定义的集合。
- > 接口类型的变量可以保存任何实现了这些方法的值。
- > 注意: 示例代码的 22 行存在一个错误。由于 `Abs` 方法只为 `*Vertex` （指针类型）定义，因此 `Vertex`（值类型）并未实现 `Abser`。
```go
package main

import (
	"fmt"
	"math"
)

type Abser interface {
	Abs() float64
}

func main() {
	var a Abser
	f := MyFloat(-math.Sqrt2)
	v := Vertex{3, 4}

	a = f  // a MyFloat 实现了 Abser
	a = &v // a *Vertex 实现了 Abser

	// 下面一行，v 是一个 Vertex（而不是 *Vertex）
	// 所以没有实现 Abser。
	a = v

	fmt.Println(a.Abs())
}

type MyFloat float64

func (f MyFloat) Abs() float64 {
	if f < 0 {
		return float64(-f)
	}
	return float64(f)
}

type Vertex struct {
	X, Y float64
}

func (v *Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}
--------------------------------------------------
//输出（准确说是报错）：
./prog.go:22:4: cannot use v (type Vertex) as type Abser in assignment:
	Vertex does not implement Abser (Abs method has pointer receiver)
```

```go
package main

import (
	"fmt"
	"math"
)

type Abser interface {
	Abs() float64
}

func main() {
	var a Abser
	f := MyFloat(-math.Sqrt2)
	v := Vertex{3, 4}

	a = f  // a MyFloat 实现了 Abser
	a = &v // a *Vertex 实现了 Abser

	// 下面一行，v 是一个 Vertex（而不是 *Vertex）
	// 所以没有实现 Abser。
	////a = v 【注释掉该行即可】
	//////【也可以连上面的 v := Vertex{3, 4} 和 a = &v 两行也注释掉，这样结果为1.4142135623730951】

	fmt.Println(a.Abs())
}

type MyFloat float64

func (f MyFloat) Abs() float64 {
	if f < 0 {
		return float64(-f)
	}
	return float64(f)
}

type Vertex struct {
	X, Y float64
}

func (v *Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}
--------------------------------------------------
//输出：
5
```
```go
package main

import (
	"fmt"
	"math"
)

type Abser interface {
	Abs() float64
}

func main() {
	var a Abser
	f := MyFloat(-math.Sqrt2)
	v := Vertex{3, 4}

	a = f  // a MyFloat 实现了 Abser
	////a = &v // a *Vertex 实现了 Abser

	// 下面一行，v 是一个 Vertex（而不是 *Vertex）
	// 所以没有实现 Abser。
	////a = v

	fmt.Println(a.Abs())
}

type MyFloat float64

func (f MyFloat) Abs() float64 {
	if f < 0 {
		return float64(-f)
	}
	return float64(f)
}

type Vertex struct {
	X, Y float64
}

func (v *Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}
--------------------------------------------------
//输出（准确说是报错）：
./prog.go:15:2: v declared and not used
```
```go
package main

import (
	"fmt"
	"math"
)

type Abser interface {
	Abs() float64
}

func main() {
	var a Abser
	f := MyFloat(-math.Sqrt2)
	////v := Vertex{3, 4}

	a = f  // a MyFloat 实现了 Abser
	////a = &v // a *Vertex 实现了 Abser

	// 下面一行，v 是一个 Vertex（而不是 *Vertex）
	// 所以没有实现 Abser。
	////a = v

	fmt.Println(a.Abs())
}

type MyFloat float64

func (f MyFloat) Abs() float64 {
	if f < 0 {
		return float64(-f)
	}
	return float64(f)
}

type Vertex struct {
	X, Y float64
}

func (v *Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}
--------------------------------------------------
//输出：
1.4142135623730951
```

### 接口与隐式实现

https://tour.go-zh.org/methods/10
- > ***类型通过实现一个接口的所有方法来实现该接口***。既然无需专门显式声明，也就没有“implements”关键字。
- > 隐式接口从接口的实现中解耦了定义，这样接口的实现可以出现在任何包中，无需提前准备。因此，也就无需在每一个实现上增加新的接口名称，这样同时也鼓励了明确的接口定义。

Interfaces are implemented implicitly https://tour.go-lang.org/methods/10
- > A type implements an interface by implementing its methods. There is no explicit declaration of intent, no "implements" keyword.
- > Implicit interfaces decouple the definition of an interface from its implementation, which could then appear in any package without prearrangement.

```go
package main

import "fmt"

type I interface {
	M()
}

type T struct {
	S string
}

// 此方法表示类型 T 实现了接口 I，但我们无需显式声明此事。
func (t T) M() {
	fmt.Println(t.S)
}

func main() {
	var i I = T{"hello"}
	i.M()
}
--------------------------------------------------
//输出：
hello
```

### 接口值

https://tour.go-zh.org/methods/11
- > ***接口也是值***。它们可以像其它值一样传递。接口值可以用作函数的参数或返回值。
- > 在内部，接口值可以看做包含值和具体类型的元组：
  ```go
  (value, type)
  ```
- > ***接口值保存了一个具体底层类型的具体值***。
- > ***接口值调用方法时会执行其底层类型的同名方法***。

Interface values https://tour.go-lang.org/methods/11
- > Under the hood, interface values can be thought of as ***a tuple of a value and a concrete type***:
  ```go
  (value, type)
  ```
- > ***An interface value holds a value of a specific underlying concrete type***.
- > Calling a method on an interface value executes the method of the same name on its underlying type.

```go
package main

import (
	"fmt"
	"math"
)

type I interface {
	M()
}

type T struct {
	S string
}

func (t *T) M() {
	fmt.Println(t.S)
}

type F float64

func (f F) M() {
	fmt.Println(f)
}

func main() {
	var i I

	i = &T{"Hello"}
	describe(i)
	i.M()

	i = F(math.Pi)
	describe(i)
	i.M()
}

func describe(i I) {
	fmt.Printf("(%v, %T)\n", i, i)
}
--------------------------------------------------
//输出：
(&{Hello}, *main.T)
Hello
(3.141592653589793, main.F)
3.141592653589793
```

### 底层值为 nil 的接口值

https://tour.go-zh.org/methods/12
- > 即便接口内的具体值为 `nil`，方法仍然会被 `nil` 接收者调用。
- > 在一些语言中，这会触发一个空指针异常，但在 Go 中通常会写一些方法来优雅地处理它（如本例中的 `M` 方法）。
- > 注意: 保存了 `nil` 具体值的接口其自身并不为 `nil`。

Interface values with nil underlying values https://tour.go-lang.org/methods/12
- > If the ***concrete value inside the interface itself*** is `nil`, the method will be called with a ***`nil receiver`***.
- > In some languages this would trigger a null pointer exception, but in Go it is common to write methods that gracefully handle being called with a nil receiver (as with the method M in this example.)
- > Note that ***an interface value*** that ***holds `a nil concrete value`*** is itself non-nil.

```go
package main

import "fmt"

type I interface {
	M()
}

type T struct {
	S string
}

func (t *T) M() {
	if t == nil {
		fmt.Println("<nil>")
		return
	}
	fmt.Println(t.S)
}

func main() {
	var i I

	var t *T
	i = t
	describe(i)
	i.M()

	i = &T{"hello"}
	describe(i)
	i.M()
}

func describe(i I) {
	fmt.Printf("(%v, %T)\n", i, i)
}
--------------------------------------------------
//输出：
(<nil>, *main.T)
<nil>
(&{hello}, *main.T)
hello
```

### nil 接口值

https://tour.go-zh.org/methods/13
- > `nil` 接口值既不保存值也不保存具体类型。
- > 为 `nil` 接口调用方法会产生运行时错误，因为接口的元组内并未包含能够指明该调用哪个 **具体** 方法的类型。

Nil interface values https://tour.go-lang.org/methods/13
- > A `nil interface value` holds ***neither value nor concrete type***.
- > Calling a method on `a nil interface` is a run-time error because there is no type inside the interface tuple to indicate which concrete method to call.

```go
package main

import "fmt"

type I interface {
	M()
}

func main() {
	var i I
	describe(i)
	i.M()
}

func describe(i I) {
	fmt.Printf("(%v, %T)\n", i, i)
}
--------------------------------------------------
//输出（准确说是报错）：
(<nil>, <nil>)
panic: runtime error: invalid memory address or nil pointer dereference
[signal SIGSEGV: segmentation violation code=0xffffffff addr=0x0 pc=0xd9864]

goroutine 1 [running]:
main.main()
	/tmp/sandbox720983772/prog.go:12 +0x84
```

### 空接口

https://tour.go-zh.org/methods/14
- > 指定了***零个方法***的接口值被称为 *空接口*：
  ```go
  interface{}
  ```
- > 空接口可保存任何类型的值。（因为每个类型都至少实现了零个方法。）
- > 空接口被用来处理未知类型的值。例如，`fmt.Print` 可接受类型为 `interface{}` 的任意数量的参数。
```go
package main

import "fmt"

func main() {
	var i interface{}
	describe(i)

	i = 42
	describe(i)

	i = "hello"
	describe(i)
}

func describe(i interface{}) {
	fmt.Printf("(%v, %T)\n", i, i)
}
--------------------------------------------------
//输出：
(<nil>, <nil>)
(42, int)
(hello, string)
```

### 类型断言

https://tour.go-zh.org/methods/15
- > **`类型断言`** 提供了访问接口值底层具体值的方式。
  ```go
  t := i.(T)
  ```
- > 该语句断言接口值 `i` 保存了具体类型 `T`，并将其底层类型为 `T` 的值赋予变量 `t`。若 `i` 并未保存 `T` 类型的值，该语句就会触发一个`恐慌`。
- > 为了 **判断** 一个接口值是否保存了一个特定的类型，类型断言可返回两个值：其`底层值`以及一个`报告断言是否成功的布尔值`。
  ```go
  t, ok := i.(T)
  ```
- > 若 `i` 保存了一个 `T`，那么 `t` 将会是其底层值，而 `ok` 为 `true`。否则，`ok` 将为 `false` 而 `t` 将为 `T` 类型的零值，***程序并不会产生恐慌***。
- > 请注意这种语法和读取一个映射时的相同之处。
```go
package main

import "fmt"

func main() {
	var i interface{} = "hello"

	s := i.(string)
	fmt.Println(s)

	s, ok := i.(string)
	fmt.Println(s, ok)

	f, ok := i.(float64)
	fmt.Println(f, ok)

	f = i.(float64) // 报错(panic)
	fmt.Println(f)
}
--------------------------------------------------
//输出（准确说是报错）：
hello
hello true
0 false
panic: interface conversion: interface {} is string, not float64

goroutine 1 [running]:
main.main()
	/tmp/sandbox162458816/prog.go:17 +0x220
```

### 类型选择

https://tour.go-zh.org/methods/16
- > **`类型选择`** 是一种按顺序从几个类型断言中选择分支的结构。
- > 类型选择与一般的 `switch` 语句相似，不过类型选择中的 `case` 为类型（而非值），它们针对给定接口值所存储的值的类型进行比较。
  ```go
  switch v := i.(type) {
  case T:
      // v 的类型为 T
  case S:
      // v 的类型为 S
  default:
      // 没有匹配，v 与 i 的类型相同
  }
  ```
- > 类型选择中的***声明与类型断言 `i.(T)` 的语法相同***，只是具体类型 `T` 被替换成了关键字 `type`。
- > 此选择语句判断接口值 `i` 保存的值类型是 `T` 还是 `S`。在 `T` 或 `S` 的情况下，变量 `v` 会分别按 `T` 或 `S` 类型保存 `i` 拥有的值。在默认（即没有匹配）的情况下，变量 `v`与 `i` 的接口类型和值相同。
```go
package main

import "fmt"

func do(i interface{}) {
	switch v := i.(type) {
	case int:
		fmt.Printf("Twice %v is %v\n", v, v*2)
	case string:
		fmt.Printf("%q is %v bytes long\n", v, len(v))
	default:
		fmt.Printf("I don't know about type %T!\n", v)
	}
}

func main() {
	do(21)
	do("hello")
	do(true)
}
--------------------------------------------------
//输出：
Twice 21 is 42
"hello" is 5 bytes long
I don't know about type bool!
```

### Stringer

https://tour.go-zh.org/methods/17
- > `fmt` 包中定义的 `Stringer` 是最普遍的接口之一。
  ```go
  type Stringer interface {
      String() string
  }
  ```
- > `Stringer` 是一个可以用字符串描述自己的类型。`fmt` 包（还有很多包）都通过此接口来打印值。
```go
package main

import "fmt"

type Person struct {
	Name string
	Age  int
}

func (p Person) String() string {
	return fmt.Sprintf("%v (%v years)", p.Name, p.Age)
}

func main() {
	a := Person{"Arthur Dent", 42}
	z := Person{"Zaphod Beeblebrox", 9001}
	fmt.Println(a, z)
}
--------------------------------------------------
//输出：
Arthur Dent (42 years) Zaphod Beeblebrox (9001 years)
```

### 练习：Stringer

https://tour.go-zh.org/methods/18

### 错误

https://tour.go-zh.org/methods/19
- > Go 程序使用 `error` 值来表示错误状态。
- > 与 `fmt.Stringer` 类似，`error` 类型是一个***内建接口***：
  ```go
  type error interface {
      Error() string
  }
  ```
  > （与 `fmt.Stringer` 类似，`fmt` 包在打印值时也会满足 `error`。）
- > 通常函数会返回一个 `error` 值，调用的它的代码应当判断这个错误是否等于 `nil` 来进行错误处理。
  ```go
  i, err := strconv.Atoi("42")
  if err != nil {
      fmt.Printf("couldn't convert number: %v\n", err)
      return
  }
  fmt.Println("Converted integer:", i)
  ```
- > `error` 为 `nil` 时表示成功；非 `nil` 的 `error` 表示失败。
```go
package main

import (
	"fmt"
	"time"
)

type MyError struct {
	When time.Time
	What string
}

func (e *MyError) Error() string {
	return fmt.Sprintf("at %v, %s",
		e.When, e.What)
}

func run() error {
	return &MyError{
		time.Now(),
		"it didn't work",
	}
}

func main() {
	if err := run(); err != nil {
		fmt.Println(err)
	}
}
--------------------------------------------------
//输出：
at 2009-11-10 23:00:00 +0000 UTC m=+0.000000001, it didn't work
```

### 练习：错误

https://tour.go-zh.org/methods/20

### Reader

https://tour.go-zh.org/methods/21
- > `io` 包指定了 `io.Reader` 接口，它表示从数据流的末尾进行读取。
- > Go 标准库包含了该接口的[许多实现](https://go-zh.org/search?q=Read#Global)，包括文件、网络连接、压缩和加密等等。
- > `io.Reader` 接口有一个 `Read` 方法：
  ```go
  func (T) Read(b []byte) (n int, err error)
  ```
- > `Read` 用数据填充给定的字节切片并返回填充的字节数和错误值。在遇到数据流的结尾时，它会返回一个 `io.EOF` 错误。
- > 示例代码创建了一个 `strings.Reader` 并以每次 8 字节的速度读取它的输出。
```go
package main

import (
	"fmt"
	"io"
	"strings"
)

func main() {
	r := strings.NewReader("Hello, Reader!")

	b := make([]byte, 8)
	for {
		n, err := r.Read(b)
		fmt.Printf("n = %v err = %v b = %v\n", n, err, b)
		fmt.Printf("b[:n] = %q\n", b[:n])
		if err == io.EOF {
			break
		}
	}
}
--------------------------------------------------
//输出：
n = 8 err = <nil> b = [72 101 108 108 111 44 32 82]
b[:n] = "Hello, R"
n = 6 err = <nil> b = [101 97 100 101 114 33 32 82]
b[:n] = "eader!"
n = 0 err = EOF b = [101 97 100 101 114 33 32 82]
b[:n] = ""
```

### 练习：Reader

https://tour.go-zh.org/methods/22

### 练习：rot13Reader

https://tour.go-zh.org/methods/23

### 图像

https://tour.go-zh.org/methods/24
- > `image` 包定义了 `Image` 接口：
  ```go
  package image
  
  type Image interface {
      ColorModel() color.Model
      Bounds() Rectangle
      At(x, y int) color.Color
  }
  ```
  > 注意: `Bounds` 方法的返回值 `Rectangle` 实际上是一个 `image.Rectangle`，它在 `image` 包中声明。（请参阅[文档](https://go-zh.org/pkg/image/#Image)了解全部信息。）
- > `color.Color` 和 `color.Model` 类型也是接口，但是通常因为直接使用预定义的实现 `image.RGBA` 和 `image.RGBAModel` 而被忽视了。这些接口和类型由 `image/color` 包定义。
```go
package main

import (
	"fmt"
	"image"
)

func main() {
	m := image.NewRGBA(image.Rect(0, 0, 100, 100))
	fmt.Println(m.Bounds())
	fmt.Println(m.At(0, 0).RGBA())
}
--------------------------------------------------
//输出：
(0,0)-(100,100)
0 0 0 0
```

### 练习：图像

https://tour.go-zh.org/methods/25

### ~~恭喜！~~

https://tour.go-zh.org/methods/26

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

