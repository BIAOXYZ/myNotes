
# go Test general

Go by Example: Testing https://gobyexample.com/testing || Go by Example 中文版: 单元测试 https://gobyexample-cn.github.io/testing

Testing https://www.golang-book.com/books/intro/12
> The `go test` command will look for any tests in any of the files ***in the current folder*** and run them. Tests are identified by starting a function with the word `Test` and taking one argument of type `*testing.T`. In our case since we're testing the `Average` function we name the test function `TestAverage`.

`1. testing - 单元测试` https://books.studygolang.com/The-Golang-Standard-Library-by-Example/chapter09/09.1.html
- > `testing` 为 Go 语言 package 提供自动化测试的支持。通过 `go test` 命令，能够自动执行如下形式的任何函数：
  ```go
  func TestXxx(*testing.T)
  ```
  > 注意：`Xxx` 可以是任何字母数字字符串，但是第一个字母不能是小些字母。在这些函数中，使用 Error, Fail 或相关方法来发出失败信号。
- > 要编写一个新的测试套件，需要创建一个名称以 `_test.go` 结尾的文件，该文件包含 `TestXxx` 函数，如上所述。 将该文件放在与被测试的包相同的包中。该文件将被排除在正常的程序包之外，但在运行 “ go test ” 命令时将被包含。 有关详细信息，请运行 “ go help test ” 和 “ go help testflag ” 了解。

Unit Testing made easy in Go https://medium.com/rungo/unit-testing-made-easy-in-go-25077669318

Go 测试，go test 工具的具体指令 flag https://deepzz.com/post/the-command-flag-of-go-test.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Ginkgo & Gomega

## Ginkgo & Gomega 官方

Ginkgo: BDD Testing Framework for Go https://github.com/onsi/ginkgo || http://onsi.github.io/ginkgo/

package ginkgo https://godoc.org/github.com/onsi/ginkgo
> package ginkgo https://pkg.go.dev/github.com/onsi/ginkgo?tab=doc

Gomega: Ginkgo's Preferred Matcher Library https://github.com/onsi/gomega || http://onsi.github.io/gomega/

package gomega https://godoc.org/github.com/onsi/gomega
> `Pkg.go.dev is a new destination for Go discovery & docs. Check it out at pkg.go.dev/github.com/onsi/gomega and share your feedback.`
>> package gomega https://pkg.go.dev/github.com/onsi/gomega

Announcing Ginkgo and Gomega: BDD-Style Testing for Golang https://tanzu.vmware.com/content/blog/announcing-ginkgo-and-gomega-bdd-style-testing-for-golang
- > Google’s Golang treats testing as a first-class citizen. Go has builtin support for writing and running unit tests in the Xunit style. Go, however, does not come with an assertion/matcher library. Nor does it provide any of the higher-level testing constructs that those in the BDD school of testing have grown fond of. Go’s authors have made it clear that these omissions are intentional.
- > Ginkgo and Gomega are heavily influenced by Cedar (BDD for Objective-C) and Jasmine (BDD for Javascript). If you’re familiar with either you’ll feel right at home with Ginkgo.
- > About the Author: Onsi Fakhouri is the Senior Vice President, Cloud R&D of Pivotal.
  >> notes: 因为作者是Pivotal的，所以这个库基本就算VMware的呗，而且这个新闻的网页就是VMware Tanzu的。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Ginkgo 官方代码

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Gomega 官方代码

- `6be6c439588487cd908a3a700795660c2a16dfec`对应了1.9.0这个tag，但是仓库没有专门的分支，所以只能切1.9.0tag对应的hash值。

### gomega_dsl.go

- `func Ω(actual interface{}, extra ...interface{}) Assertion {` https://github.com/onsi/gomega/blob/6be6c439588487cd908a3a700795660c2a16dfec/gomega_dsl.go#L129
  ```go
  // Ω and Expect are identical
  func Ω(actual interface{}, extra ...interface{}) Assertion {
	  return ExpectWithOffset(0, actual, extra...)
  }
  ```
- `func Expect(actual interface{}, extra ...interface{}) Assertion {` https://github.com/onsi/gomega/blob/6be6c439588487cd908a3a700795660c2a16dfec/gomega_dsl.go#L150
  ```go
  // Expect and Ω are identical
  func Expect(actual interface{}, extra ...interface{}) Assertion {
	  return ExpectWithOffset(0, actual, extra...)
  }
  ```
- `type Assertion interface {` https://github.com/onsi/gomega/blob/6be6c439588487cd908a3a700795660c2a16dfec/gomega_dsl.go#L333
  ```go
  // Assertion is returned by Ω and Expect and compares the actual value to the matcher
  // passed to the Should/ShouldNot and To/ToNot/NotTo methods.
  //
  // Typically Should/ShouldNot are used with Ω and To/ToNot/NotTo are used with Expect
  // though this is not enforced.
  //
  // All methods take a variadic optionalDescription argument.
  // This argument allows you to make your failure messages more descriptive.
  // If a single argument of type `func() string` is passed, this function will be lazily evaluated if a failure occurs
  // and the returned string is used to annotate the failure message.
  // Otherwise, this argument is passed on to fmt.Sprintf() and then used to annotate the failure message.
  //
  // All methods return a bool that is true if the assertion passed and false if it failed.
  //
  // Example:
  //
  //    Ω(farm.HasCow()).Should(BeTrue(), "Farm %v should have a cow", farm)
  type Assertion interface {
  	Should(matcher types.GomegaMatcher, optionalDescription ...interface{}) bool
  	ShouldNot(matcher types.GomegaMatcher, optionalDescription ...interface{}) bool
  
  	To(matcher types.GomegaMatcher, optionalDescription ...interface{}) bool
  	ToNot(matcher types.GomegaMatcher, optionalDescription ...interface{}) bool
  	NotTo(matcher types.GomegaMatcher, optionalDescription ...interface{}) bool
  }
  ```
- `func (g *WithT) Expect(actual interface{}, extra ...interface{}) Assertion {` https://github.com/onsi/gomega/blob/6be6c439588487cd908a3a700795660c2a16dfec/gomega_dsl.go#L380
  ```go
  // Expect is used to make assertions. See documentation for Expect.
  func (g *WithT) Expect(actual interface{}, extra ...interface{}) Assertion {
	  return assertion.New(actual, testingtsupport.BuildTestingTGomegaFailWrapper(g.t), 0, extra...)
  }
  ```

### matchers.go

- `func BeZero() types.GomegaMatcher {` https://github.com/onsi/gomega/blob/6be6c43958/matchers.go#L255
  ```go
  //BeZero succeeds if actual is the zero value for its type or if actual is nil.
  func BeZero() types.GomegaMatcher {
  	return &matchers.BeZeroMatcher{}
  }
  ```

### internal/assertion/assertion.go

- `func New(actualInput interface{}, failWrapper *types.GomegaFailWrapper, offset int, extra ...interface{}) *Assertion {` 【`assertion.New()`】 https://github.com/onsi/gomega/blob/6be6c43958/internal/assertion/assertion.go#L17
- `func (assertion *Assertion) Should(matcher types.GomegaMatcher, optionalDescription ...interface{}) bool {` https://github.com/onsi/gomega/blob/6be6c43958/internal/assertion/assertion.go#L26
  ```go
  func (assertion *Assertion) Should(matcher types.GomegaMatcher, optionalDescription ...interface{}) bool {
  	assertion.failWrapper.TWithHelper.Helper()
  	return assertion.vetExtras(optionalDescription...) && assertion.match(matcher, true, optionalDescription...)
  }
  ```
- https://github.com/onsi/gomega/blob/6be6c43958/internal/assertion/assertion.go#L31
  ```go
  func (assertion *Assertion) ShouldNot(matcher types.GomegaMatcher, optionalDescription ...interface{}) bool {
  	assertion.failWrapper.TWithHelper.Helper()
  	return assertion.vetExtras(optionalDescription...) && assertion.match(matcher, false, optionalDescription...)
  }
  ```
- `func (assertion *Assertion) match(matcher types.GomegaMatcher, desiredMatch bool, optionalDescription ...interface{}) bool {` 【`assertion.match()`】 https://github.com/onsi/gomega/blob/6be6c43958/internal/assertion/assertion.go#L63  
- `func (assertion *Assertion) vetExtras(optionalDescription ...interface{}) bool {` 【`assertion.vetExtras()`】 https://github.com/onsi/gomega/blob/6be6c43958/internal/assertion/assertion.go#L86
- `func vetExtras(extras []interface{}) (bool, string) {` https://github.com/onsi/gomega/blob/6be6c43958/internal/assertion/assertion.go#L98

### matchers/be_zero_matcher.go

- `type BeZeroMatcher struct {` https://github.com/onsi/gomega/blob/6be6c439588487cd908a3a700795660c2a16dfec/matchers/be_zero_matcher.go#L9:6
  ```go
  type BeZeroMatcher struct {
  }
  ```
- `func (matcher *BeZeroMatcher) Match(actual interface{}) (success bool, err error) {` https://github.com/onsi/gomega/blob/6be6c43958/matchers/be_zero_matcher.go#L12

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Ginkgo & Gomega 其他

https://gowalker.org/github.com/onsi/gomega/matchers

Testing Kubernetes Operators with Ginkgo, Gomega and the Operator Runtime https://itnext.io/testing-kubernetes-operators-with-ginkgo-gomega-and-the-operator-runtime-6ad4c2492379
- > I’d suggest you read the following 2 guides first. 
  * > Unit testing in Go with Ginkgo: Part 1 https://medium.com/boldly-going/unit-testing-in-go-with-ginkgo-part-1-ce6ff06eb17f
  * > Getting Started: Writing Your First Test https://onsi.github.io/ginkgo/#getting-started-writing-your-first-test

Writing Expressive tests in Go with Ginkgo and Gomega https://lanre.wtf/blog/2017/06/23/expressive-testing-go/

Can Gomega's Equal() handle multiple values ? https://stackoverflow.com/questions/49828807/can-gomegas-equal-handle-multiple-values

一个 Golang 的BDD(行为驱动开发)测试框架 https://www.ginkgo.wiki/

高效测试框架推荐之Ginkgo https://www.cnblogs.com/jinsdu/p/12183298.html

Ginkgo使用指南 https://blog.csdn.net/Goodboynihaohao/article/details/79392500

开发工具 从 Go 语言的依赖库讲起 1：Ginkgo、testify 和 GoMock https://gocn.vip/topics/9760
