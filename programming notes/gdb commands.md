

handle SIGPIPE nostop
handle all nostop // 应该是这句？


一个小技巧，大家在gdb调试mppdb时，总需要屏蔽信号：
可以这样让gdb每次自动加载这个屏蔽功能，不用每次自己输入
```
alias gdb="gdb -x ~/.gdbinit"
wangct@linux207:~> cat ~/.gdbinit 
handle SIGUSR2 noprint nostop
```

```
save breakpoints bps.cfg
source bps.cfg
```

follow-fork-mode的用法为：
```
set follow-fork-mode [parent|child]
```
parent: fork之后继续调试父进程，子进程不受影响。
child: fork之后调试子进程，父进程不受影响。
因此如果需要调试子进程，在启动gdb后：set follow-fork-mode child

此外还有：
```
set detach-on-fork [on|off]
```
on: 断开调试follow-fork-mode指定的进程。
off: gdb将控制父进程和子进程。follow-fork-mode指定的进程将被调试，另一个进程置于暂停（suspended）状态。

线程跳转吧？？锁定线程
```
set scheduler-locking on
```

### gdb插件

http://blog.csdn.net/gatieme/article/details/63254211


## 其他参考链接：

<<gdb学习笔记(一)>>
http://simohayha.iteye.com/blog/493091


http://blog.csdn.net/pbymw8iwm/article/details/7876797

http://blog.csdn.net/lhl_blog/article/details/8888010
