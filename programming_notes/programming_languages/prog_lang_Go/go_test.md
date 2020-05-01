
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

# Ginkgo & Gomega

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

Testing Kubernetes Operators with Ginkgo, Gomega and the Operator Runtime https://itnext.io/testing-kubernetes-operators-with-ginkgo-gomega-and-the-operator-runtime-6ad4c2492379

