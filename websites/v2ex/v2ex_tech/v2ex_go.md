
为什么在 Go 数组(array)被设计成值，而不跟 C/C++或 Java 一样，设计为一个引用？ https://www.v2ex.com/t/673135

Go Channel 学习的一个疑问，请大佬指教 https://www.v2ex.com/t/672517
```console
为什么这个输出结果一会是 0，1，2，3，一会是 0，1，2，3，4
按道理来说，我在主进程一直阻塞了，应该等 goroutine 全部打印完才对呀，百思不得其解
```
```go
func main() {
	boolChannel()
}

func boolChannel()  {
	ch1 := make(chan int)
	ch2 := make(chan bool)

	go func() {
		for i:=0;i<5;i++ {
			ch1 <- i
		}
		ch2 <- true	//标识位写入 true
	}()

	go func() {
		for x:= range ch1{
			fmt.Println(x)
		}
	}()

	<-ch2 //阻塞标识位
}
```
- > ch2 <- true 改成 close(ch1) <br> ch2 <- true 移到第二个 for 后面
- > 4 进入 ch1 后，true 进入 ch2，
  <br> 情况 1：主程序先得到 ch2，第二个 func 还没来得及得到 ch1 或者没来得及打印， 程序就退出 输出 0,1,2,3
  <br> 情况 2：第二个 func 得到 ch1 并且打印，主程序还没来得及得到 ch2,输出 0,1,2,3,4

go 语言对接 c 语言的问题 https://www.v2ex.com/t/667279

[典藏版]Golang 调度器 GMP 原理与调度全分析 https://www.v2ex.com/t/651092
- > [典藏版]Golang调度器GMP原理与调度全分析 https://www.jianshu.com/p/fa696563c38a

采用 gomod 方式后 gopath 下的 bin 如何处理？ https://www.v2ex.com/t/651007

Go 代码编译为 C 代码 https://www.v2ex.com/t/648000
> A toy programming language base on Golang and compile to C, no name yet https://github.com/kitech/cygo

[7 天用 Go 从零实现系列] 第二期分布式缓存 GeeCache 已经完结 https://www.v2ex.com/t/645362
> 7 days golang apps from scratch (web framework Gee, distributed cache GeeCache, etc) 7天用Go动手写系列[从零实现] https://geektutu.com/post/gee.html || https://github.com/geektutu/7days-golang

Go 101 v1.13.m (v.1.14-pre) 电子书发布 https://www.v2ex.com/t/635029
> Go语言101 : 一本侧重于Go语言语法和语义的编程解释和指导书 https://github.com/golang101/golang101
>> Go语言101 https://gfw.go101.org/article/101.html

GO 切片问题求教 https://www.v2ex.com/t/606165

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
