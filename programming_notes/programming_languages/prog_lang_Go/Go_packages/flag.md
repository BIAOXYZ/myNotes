
# 官方

Package flag https://golang.org/pkg/flag/

## 官方github

### src/flag/flag.go

- `type FlagSet struct {` https://github.com/golang/go/blob/release-branch.go1.14/src/flag/flag.go#L320
  ```go
  // A FlagSet represents a set of defined flags. The zero value of a FlagSet
  // has no name and has ContinueOnError error handling.
  //
  // Flag names must be unique within a FlagSet. An attempt to define a flag whose
  // name is already in use will cause a panic.
  type FlagSet struct {
  	// Usage is the function called when an error occurs while parsing flags.
  	// The field is a function (not a method) that may be changed to point to
  	// a custom error handler. What happens after Usage is called depends
  	// on the ErrorHandling setting; for the command line, this defaults
  	// to ExitOnError, which exits the program after calling Usage.
  	Usage func()
  
  	name          string
  	parsed        bool
  	actual        map[string]*Flag
  	formal        map[string]*Flag
  	args          []string // arguments after flags
  	errorHandling ErrorHandling
  	output        io.Writer // nil means stderr; use out() accessor
  }
  ```
- `func Args() []string { return CommandLine.args }` https://github.com/golang/go/blob/release-branch.go1.14/src/flag/flag.go#L619
- `var CommandLine = NewFlagSet(os.Args[0], ExitOnError)` 【`flag.CommandLine`】 https://github.com/golang/go/blob/release-branch.go1.14/src/flag/flag.go#L1010

# 其他

Go by Example 中文版: 命令行标志 https://gobyexample-cn.github.io/command-line-flags || Go by Example: Command-Line Flags https://gobyexample.com/command-line-flags

Golang : flag 包简介 https://www.cnblogs.com/sparkdev/p/10812422.html

golang flag包使用笔记 https://www.jianshu.com/p/f9cf46a4de0e

How To Use the Flag Package in Go https://www.digitalocean.com/community/tutorials/how-to-use-the-flag-package-in-go

Where to Define Command-Line Flags in Go https://thoughtbot.com/blog/where-to-define-command-line-flags-in-go
- > When building a command-line tool in Go, you’ll eventually want to accept arguments as flags.
- > If you’re using the standard library’s flag package, you’ll have to decide where in your package to define your flags. The only requirement of `flag` is that the flags be defined before `flag.Parse()` is called.

Dealing with Command Line Options in Golang: flag package https://medium.com/what-i-talk-about-when-i-talk-about-technology/dealing-with-command-line-options-in-golang-flag-package-e5fb6ef1a79e

Using Command Line Flags in Go https://flaviocopes.com/go-command-line-flags/
