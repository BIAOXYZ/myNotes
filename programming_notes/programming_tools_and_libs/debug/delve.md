
# Delve官方

Delve is a debugger for the Go programming language. https://github.com/go-delve/delve

Delve Documentation https://github.com/go-delve/delve/tree/master/Documentation
- Command Line Interface https://github.com/go-delve/delve/tree/master/Documentation/cli

# Delve其他攻略

Debugging Go programs with Delve https://blog.gopheracademy.com/advent-2015/debugging-with-delve/

3.9 Delve调试器 https://chai2010.cn/advanced-go-programming-book/ch3-asm/ch3-09-debug.html

【后面那个是原版，原版格式更好】~~Golang调试工具Delve https://juejin.im/entry/5aa1f98d6fb9a028c522c84b~~ || golang调试工具Delve https://www.cnblogs.com/li-peng/p/8522592.html

GO语言调试利器——dlv https://www.jianshu.com/p/7373042bba83
- > 2、dlv run|debug：run命令已被debug命令取代，运行dlv debug test.go会先编译go源文件，同时执行attach命令进入调试模式，该命令会在当前目录下生成一个名为debug的可执行二进制文件，退出调试模式会自动被删除。

Go调试工具—— Delve https://www.cnblogs.com/wanghui-garcia/p/10455217.html

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

>> 实战：试了一下dlv的双斜杠带多参数调试，至少我这边`operator-sdk`这个项目的下述语句是没问题的，**并且新的helm operator项目也确实创建起来了**。用法和gdb带参数启动很类似（**只不过gdb的`set args`是进到gdb里面以后用的，这个是启动dlv前用的**）。注：原始语句应为`operator-sdk new nginx-operator --api-version=example.com/v1alpha1 --kind=Nginx --type=helm`(https://github.com/operator-framework/operator-sdk/blob/master/doc/helm/user-guide.md)
```
root@cloudsec1 operator-sdk [dev] $ dlv debug ./main.go -- new nginx-operator --api-version=example.com/v1alpha1 --kind=Nginx --type=helm
Type 'help' for list of commands.
(dlv) b main.main
Breakpoint 1 set at 0x2148fcb for main.main() ./main.go:47
(dlv) c
> main.main() ./main.go:47 (hits goroutine(1):1 total:1) (PC: 0x2148fcb)
    42:         log "github.com/sirupsen/logrus"
    43:         "github.com/spf13/cobra"
    44:         "github.com/spf13/viper"
    45: )
    46: 
=>  47: func main() {
    48:         root := &cobra.Command{
    49:                 Use:   "operator-sdk",
    50:                 Short: "An SDK for building operators with ease",
    51:                 PersistentPreRun: func(cmd *cobra.Command, args []string) {
    52:                         if viper.GetBool(flags.VerboseOpt) {
(dlv) n
> main.main() ./main.go:51 (PC: 0x2148fe2)
    46: 
    47: func main() {
    48:         root := &cobra.Command{
    49:                 Use:   "operator-sdk",
    50:                 Short: "An SDK for building operators with ease",
=>  51:                 PersistentPreRun: func(cmd *cobra.Command, args []string) {
    52:                         if viper.GetBool(flags.VerboseOpt) {
    53:                                 if err := projutil.SetGoVerbose(); err != nil {
    54:                                         log.Fatalf("Could not set GOFLAGS: (%v)", err)
    55:                                 }
    56:                                 log.SetLevel(log.DebugLevel)
(dlv) list
> main.main() ./main.go:51 (PC: 0x2148fe2)
    46: 
    47: func main() {
    48:         root := &cobra.Command{
    49:                 Use:   "operator-sdk",
    50:                 Short: "An SDK for building operators with ease",
=>  51:                 PersistentPreRun: func(cmd *cobra.Command, args []string) {
    52:                         if viper.GetBool(flags.VerboseOpt) {
    53:                                 if err := projutil.SetGoVerbose(); err != nil {
    54:                                         log.Fatalf("Could not set GOFLAGS: (%v)", err)
    55:                                 }
    56:                                 log.SetLevel(log.DebugLevel)
(dlv) s
> main.main() ./main.go:49 (PC: 0x2149031)
    44:         "github.com/spf13/viper"
    45: )
    46: 
    47: func main() {
    48:         root := &cobra.Command{
=>  49:                 Use:   "operator-sdk",
    50:                 Short: "An SDK for building operators with ease",
    51:                 PersistentPreRun: func(cmd *cobra.Command, args []string) {
    52:                         if viper.GetBool(flags.VerboseOpt) {
    53:                                 if err := projutil.SetGoVerbose(); err != nil {
    54:                                         log.Fatalf("Could not set GOFLAGS: (%v)", err)
(dlv) n
> main.main() ./main.go:50 (PC: 0x214905a)
    45: )
    46: 
    47: func main() {
    48:         root := &cobra.Command{
    49:                 Use:   "operator-sdk",
=>  50:                 Short: "An SDK for building operators with ease",
    51:                 PersistentPreRun: func(cmd *cobra.Command, args []string) {
    52:                         if viper.GetBool(flags.VerboseOpt) {
    53:                                 if err := projutil.SetGoVerbose(); err != nil {
    54:                                         log.Fatalf("Could not set GOFLAGS: (%v)", err)
    55:                                 }
(dlv) s
> main.main() ./main.go:51 (PC: 0x2149088)
    46: 
    47: func main() {
    48:         root := &cobra.Command{
    49:                 Use:   "operator-sdk",
    50:                 Short: "An SDK for building operators with ease",
=>  51:                 PersistentPreRun: func(cmd *cobra.Command, args []string) {
    52:                         if viper.GetBool(flags.VerboseOpt) {
    53:                                 if err := projutil.SetGoVerbose(); err != nil {
    54:                                         log.Fatalf("Could not set GOFLAGS: (%v)", err)
    55:                                 }
    56:                                 log.SetLevel(log.DebugLevel)
(dlv) s
> main.main() ./main.go:48 (PC: 0x21490b4)
    43:         "github.com/spf13/cobra"
    44:         "github.com/spf13/viper"
    45: )
    46: 
    47: func main() {
=>  48:         root := &cobra.Command{
    49:                 Use:   "operator-sdk",
    50:                 Short: "An SDK for building operators with ease",
    51:                 PersistentPreRun: func(cmd *cobra.Command, args []string) {
    52:                         if viper.GetBool(flags.VerboseOpt) {
    53:                                 if err := projutil.SetGoVerbose(); err != nil {
(dlv) stepout
INFO[0042] Creating new Helm operator 'nginx-operator'. 
INFO[0042] Created helm-charts/nginx                    
INFO[0042] Generating RBAC rules                        
WARN[0042] The RBAC rules generated in deploy/role.yaml are based on the chart's default manifest. Some rules may be missing for resources that are only enabled with custom values, and some existing rules may be overly broad. Double check the rules generated in deploy/role.yaml to ensure they meet the operator's permission requirements. 
INFO[0042] Created build/Dockerfile                     
INFO[0042] Created watches.yaml                         
INFO[0042] Created deploy/service_account.yaml          
INFO[0042] Created deploy/role.yaml                     
INFO[0042] Created deploy/role_binding.yaml             
INFO[0042] Created deploy/operator.yaml                 
INFO[0042] Created deploy/crds/example_v1alpha1_nginx_crd.yaml 
INFO[0042] Created deploy/crds/example_v1alpha1_nginx_cr.yaml 
INFO[0042] Project creation complete.                   
> runtime.main() /usr/local/go/src/runtime/proc.go:209 (PC: 0x434f7f)
Warning: debugging optimized function
Values returned:

   204: 
   205:         // Make racy client program work: if panicking on
   206:         // another goroutine at the same time as main returns,
   207:         // let the other goroutine finish printing the panic trace.
   208:         // Once it does, it will exit. See issues 3934 and 20018.
=> 209:         if atomic.Load(&runningPanicDefers) != 0 {
   210:                 // Running deferred functions should not take long.
   211:                 for c := 0; c < 1000; c++ {
   212:                         if atomic.Load(&runningPanicDefers) == 0 {
   213:                                 break
   214:                         }
(dlv) n
> runtime.main() /usr/local/go/src/runtime/proc.go:218 (PC: 0x434fb1)
Warning: debugging optimized function
   213:                                 break
   214:                         }
   215:                         Gosched()
   216:                 }
   217:         }
=> 218:         if atomic.Load(&panicking) != 0 {
   219:                 gopark(nil, nil, waitReasonPanicWait, traceEvGoStop, 1)
   220:         }
   221: 
   222:         exit(0)
   223:         for {
(dlv) c
Process 25244 has exited with status 0
(dlv) q
Process 25244 has exited with status 0
root@cloudsec1 operator-sdk [dev] $ pwd
/root/go/src/github.com/operator-framework/operator-sdk/cmd/operator-sdk
root@cloudsec1 operator-sdk [dev] $ ll
total 72
drwxr-xr-x. 2 root root 4096 Jul  3 10:20 add
drwxr-xr-x. 3 root root 4096 Jul  3 10:20 alpha
drwxr-xr-x. 2 root root 4096 Jul  3 10:20 build
drwxr-xr-x. 2 root root 4096 Jul  3 10:20 completion
drwxr-xr-x. 2 root root 4096 Jul  3 10:20 generate
drwxr-xr-x. 3 root root 4096 Jul  3 10:20 internal
-rw-r--r--. 1 root root 5376 Jul  3 10:20 main.go
drwxr-xr-x. 2 root root 4096 Jul  3 10:20 migrate
drwxr-xr-x. 2 root root 4096 Jul  3 10:20 new
drwxr-xr-x. 5 root root 4096 Jul  7 04:01 nginx-operator
drwxr-xr-x. 2 root root 4096 Jul  3 10:20 olmcatalog
drwxr-xr-x. 2 root root 4096 Jul  3 10:20 printdeps
drwxr-xr-x. 2 root root 4096 Jul  3 10:20 run
drwxr-xr-x. 2 root root 4096 Jul  3 10:20 scorecard
drwxr-xr-x. 2 root root 4096 Jul  3 10:20 test
drwxr-xr-x. 2 root root 4096 Jul  3 10:20 up
drwxr-xr-x. 2 root root 4096 Jul  3 10:20 version
root@cloudsec1 operator-sdk [dev] $ git status
# On branch dev
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       nginx-operator/
nothing added to commit but untracked files present (use "git add" to track)
```

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

# 调试Go Test文件

Debugging Go tests in Visual Studio Code https://stackoverflow.com/questions/43092364/debugging-go-tests-in-visual-studio-code

Debug a single test https://github.com/microsoft/vscode-go/issues/318

Debugging GoLang tests with Visual Studio Code and Delve https://www.klefz.se/debugging-golang-tests-with-visual-studio-code-and-delve

# 调试 Go core dump

如何保留 Go 程序崩溃现场 https://www.ithome.com/0/642/301.htm || https://mp.weixin.qq.com/s/RktnMydDtOZFwEFLLYzlCA
- 回复里的：
  * > 没用过go，不明白go如何拥有c++的指针特性并且不会像c++那样宕机的，哪个go大佬能说下嘛。
    >> go一般不会直接操作指针，对指针操作有很大的限制，取地址也是语法糖封装后，直接操作对象。操作指针需要unsafe包，这个大部分情况用不到

# 其他Go调试工具

Golang程序调试工具介绍(gdb vs dlv) http://lday.me/2017/02/27/0005_gdb-vs-dlv/

[译]使用 LLDB 调试 Go 程序 https://cloud.tencent.com/developer/article/1187603
