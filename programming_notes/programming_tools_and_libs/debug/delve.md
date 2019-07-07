
# Delve官方

Delve is a debugger for the Go programming language. https://github.com/go-delve/delve

Delve Documentation https://github.com/go-delve/delve/tree/master/Documentation
- Command Line Interface https://github.com/go-delve/delve/tree/master/Documentation/cli

# Delve其他攻略

Debugging Go programs with Delve https://blog.gopheracademy.com/advent-2015/debugging-with-delve/

3.9 Delve调试器 https://chai2010.cn/advanced-go-programming-book/ch3-asm/ch3-09-debug.html

【后面那个是原版，原版格式更好】~~Golang调试工具Delve https://juejin.im/entry/5aa1f98d6fb9a028c522c84b~~ || golang调试工具Delve https://www.cnblogs.com/li-peng/p/8522592.html

GO语言调试利器——dlv https://www.jianshu.com/p/7373042bba83

# Delve问题

## go: github.com/derekparker/delve@v1.2.0: parsing go.mod: unexpected module path "github.com/go-delve/delve"

>> 问题描述：Go版本均为当前最新版（1.12.5），在某些机器上使用`go get -u github.com/derekparker/delve/cmd/dlv`没问题，但是在某台机器上执行时报如下错误：
```
root@myopenshift:go$ go get -u github.com/derekparker/delve/cmd/dlv
go: finding github.com/derekparker/delve/cmd/dlv latest
go: finding github.com/derekparker/delve/cmd latest
go: github.com/derekparker/delve@v1.2.0: parsing go.mod: unexpected module path "github.com/go-delve/delve"
go get: error loading module requirements
```

>> 搜了一下网上有两种解决办法。第一种是我从一个相关帖子里搜到的，试了试也确实可以。但是我深深地怀疑，关了`GO111MODULE`后下载的版本应该一直都是比较旧的版本。这一点在第二种方法里也（大概）得到了验证：我按第一种放法试过以后，再用第二种方法的语句`go get -u github.com/go-delve/delve/cmd/dlv`，仍然下了一堆包。所以怎么看都是第二种方法更靠谱，因此把dlv命令总结部分的语句也改成了第二种。
- 安装Bee失败 https://github.com/beego/bee/issues/582
  * > 我看见是go.mod 里面引用了github.com/derekparker/delve v0.12.1 但是dlv 迁移到了github.com/go-delve/delve ，这个应该合入吧，否则我一直都go get 不会成功
  * > `GO111MODULE=off go get -u github.com/beego/bee` 先把go mod给关闭了，再安装就可以了
- GO 1.09版本转GO 1.12的问题 https://blog.csdn.net/aileen5150/article/details/90257724
  * > 最后还是在 https://github.com/go-delve/delve上 README.md中找到解决问题的办法，Installation->windows，执行命令为
    >> `go get -u github.com/go-delve/delve/cmd/dlv`

## dlv带参数调试

这就是新兴的debuger和稳定的debuger比起来差的地方，官方有一些相关issue，基本是用**“双横杠”**来带参数。但是多参数情况下看来仍然有问题。先记下来后面继续跟踪吧：
- https://github.com/go-delve/delve/issues/126
- https://github.com/go-delve/delve/issues/178
- https://github.com/go-delve/delve/issues/562
- https://github.com/go-delve/delve/issues/715

# dlv命令总结

```
(dlv) help
The following commands are available:
    args ------------------------ Print function arguments.
    break (alias: b) ------------ Sets a breakpoint.
    breakpoints (alias: bp) ----- Print out info for active breakpoints.
    call ------------------------ Resumes process, injecting a function call (EXPERIMENTAL!!!)
    clear ----------------------- Deletes breakpoint.
    clearall -------------------- Deletes multiple breakpoints.
    condition (alias: cond) ----- Set breakpoint condition.
    config ---------------------- Changes configuration parameters.
    continue (alias: c) --------- Run until breakpoint or program termination.
    deferred -------------------- Executes command in the context of a deferred call.
    disassemble (alias: disass) - Disassembler.
    down ------------------------ Move the current frame down.
    edit (alias: ed) ------------ Open where you are in $DELVE_EDITOR or $EDITOR
    exit (alias: quit | q) ------ Exit the debugger.
    frame ----------------------- Set the current frame, or execute command on a differentframe.
    funcs ----------------------- Print list of functions.
    goroutine (alias: gr) ------- Shows or changes current goroutine
    goroutines (alias: grs) ----- List program goroutines.
    help (alias: h) ------------- Prints the help message.
    libraries ------------------- List loaded dynamic libraries
    list (alias: ls | l) -------- Show source code.
    locals ---------------------- Print local variables.
    next (alias: n) ------------- Step over to next source line.
    on -------------------------- Executes a command when a breakpoint is hit.
    print (alias: p) ------------ Evaluate an expression.
    regs ------------------------ Print contents of CPU registers.
    restart (alias: r) ---------- Restart process.
    set ------------------------- Changes the value of a variable.
    source ---------------------- Executes a file containing a list of delve commands
    sources --------------------- Print list of source files.
    stack (alias: bt) ----------- Print stack trace.
    step (alias: s) ------------- Single step through program.
    step-instruction (alias: si)  Single step a single cpu instruction.
    stepout --------------------- Step out of the current function.
    thread (alias: tr) ---------- Switch to the specified thread.
    threads --------------------- Print out info for every traced thread.
    trace (alias: t) ------------ Set tracepoint.
    types ----------------------- Print list of types
    up -------------------------- Move the current frame up.
    vars ------------------------ Print package variables.
    whatis ---------------------- Prints type of an expression.
Type help followed by a command for full documentation.
```

```
# 下载dlv包： 
//原来的语句：go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/go-delve/delve/cmd/dlv

# 启动调试：
dlv debug ${文件名} //例：dlv debug ./main.go

# 打断点：
b ${函数名} //例：b main.main
b ${文件完整路径}:行号 //例：b /root/tutorial/go/src/github.com/mytest/main.go:20

# 删除断点（用clear真可以。。。我代表gdb家族的delete鄙视你）：
```

# 其他Go调试工具

Golang程序调试工具介绍(gdb vs dlv) http://lday.me/2017/02/27/0005_gdb-vs-dlv/

[译]使用 LLDB 调试 Go 程序 https://cloud.tencent.com/developer/article/1187603
