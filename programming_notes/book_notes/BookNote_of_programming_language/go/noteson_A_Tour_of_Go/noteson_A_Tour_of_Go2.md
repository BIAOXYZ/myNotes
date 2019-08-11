
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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` Concurrency || 并发

## `##` Concurrency || 并发

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

