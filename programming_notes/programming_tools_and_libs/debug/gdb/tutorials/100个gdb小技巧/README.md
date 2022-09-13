
《100个gdb小技巧》 https://github.com/hellogcc/100-gdb-tips/blob/master/src/index.md || ~~https://www.gitbook.com/book/wizardforcel/100-gdb-tips/details~~ --> https://wizardforcel.gitbooks.io/100-gdb-tips/content/
- 配置gdb init文件 https://github.com/hellogcc/100-gdb-tips/blob/master/src/config-gdbinit.md
  * > 里面有个.gdbinit的配置文件可以参考下，这里就不列了。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 6.打印

## 6.2 打印STL容器中的内容 https://wizardforcel.gitbooks.io/100-gdb-tips/content/print-STL-container.html

## 6.3 打印大数组中的内容 https://wizardforcel.gitbooks.io/100-gdb-tips/content/print-large-array.html
- > 也可以使用如下命令，设置为没有限制：
  ```sh
  (gdb) set print elements 0
  ```

## 6.12 每行打印一个结构体成员 https://github.com/hellogcc/100-gdb-tips/blob/master/src/set-print-pretty-on.md
- > `set print pretty on`

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 7.多进程/线程

## 7.3 同时调试父进程和子进程##
- > 在调试多进程程序时，gdb***默认只会追踪父进程的运行，而子进程会独立运行，gdb不会控制***。以上面程序为例：
- > 如果要同时调试父进程和子进程，可以使用“set detach-on-fork off”（默认 `detach-on-fork` 是 `on`）命令，这样gdb就能同时调试父子进程，并且在调试一个进程时，另外一个进程处于挂起状态。仍以上面程序为例：
- > 在使用“set detach-on-fork off”命令后，用“i inferiors”（i是info命令缩写）查看进程状态，可以看到父子进程都在被gdb调试的状态，前面显示“`*`”是正在调试的进程。当父进程退出后，用“inferior infno”切换到子进程去调试。
- > 此外，如果想让父子进程都同时运行，可以使用“set schedule-multiple on”（默认 `schedule-multiple` 是 `off`）命令，仍以上述代码为例：

## 7.7 只允许一个线程运行
- > 如果想在调试一个线程时，让其它线程暂停执行，可以使用“set scheduler-locking on”命令

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 10. 改变程序的执行

## 10.2 设置变量的值 https://wizardforcel.gitbooks.io/100-gdb-tips/content/set-var.html
- > 在gdb中，可以用“`set var variable=expr`”命令设置变量的值，以上面代码为例：

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
