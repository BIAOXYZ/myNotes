
# Delve官方

Delve is a debugger for the Go programming language. https://github.com/go-delve/delve

Delve Documentation https://github.com/go-delve/delve/tree/master/Documentation
- Command Line Interface https://github.com/go-delve/delve/tree/master/Documentation/cli

# Delve其他攻略

Debugging Go programs with Delve https://blog.gopheracademy.com/advent-2015/debugging-with-delve/

3.9 Delve调试器 https://chai2010.cn/advanced-go-programming-book/ch3-asm/ch3-09-debug.html

【后面那个是原版，原版格式更好】~~Golang调试工具Delve https://juejin.im/entry/5aa1f98d6fb9a028c522c84b~~ || golang调试工具Delve https://www.cnblogs.com/li-peng/p/8522592.html

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
go get -u github.com/derekparker/delve/cmd/dlv

# 启动调试：
dlv debug ${文件名} //例：dlv debug ./main.go

# 打断点：
b ${函数名} //例：b main.main
b ${文件完整路径}:行号 //例：b /root/tutorial/go/src/github.com/mytest/main.go:20
```
