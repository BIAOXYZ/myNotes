
# GDB的set在多线程/多进程调试时的使用

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

GDB调试多线程和多进程(三)：调试多进程应用 https://www.bilibili.com/video/BV1Y4411m7Z5/

# GDB多进程多线程调试

gdb thread https://www.jianshu.com/p/d8c6ebcaa7be
- > `set scheduler-locking off|on|step` 估计是实际使用过多线程调试的人都可以发现，在使用step或者continue命令调试当前被调试线程的时候，其他线程也是同时执行的，怎么只让被调试程序执行呢？通过这个命令就可以实现这个需求。`off` 不锁定任何线程，也就是所有线程都执行，这是默认值。`on` 只有当前被调试程序会执行。`step` 在单步的时候，除了next过一个函数的情况(熟悉情况的人可能知道，这其实是一个设置断点然后continue的行为)以外，只有当前线程会执行。
- > 线程产生通知：在产生新的线程时, gdb会给出提示信息
  ```console
  (gdb) r
  Starting program: /root/thread
  [New Thread 1073951360 (LWP12900)]
  [New Thread 1082342592 (LWP 12907)]---以下三个为新产生的线程
  [New Thread 1090731072 (LWP 12908)]
  [New Thread 1099119552 (LWP 12909)]
  ```
- > 一般情况下多线程的时候, 由于是同时运行的, 最好设置 `set scheduler-locking on` 这样的话,只调试当前线程

GDB调试多线程及多进程 https://ivanzz1001.github.io/records/post/cplusplus/2018/08/19/cpluscplus-gdbusage_part2

GDB 调试多进程或者多线程应用 https://blog.csdn.net/gatieme/article/details/78309696
- > 考虑下面这个三进程系统 :
- > 进程 `ProcessChild` 是 `ProcessParent` 的子进程, `ProcessParentThread` 又是 `ProcParent` 的子线程. 如何使用 GDB 调试 `子进程 ProcessChild` 或者 `子线程 ProcessParentThread` 呢 ?
- > 实际上, GDB 没有对多进程程序调试提供直接支持. 例如, 使用 GDB 调试某个进程, 如果该进程 `fork` 了子进程, GDB 会继续调试该进程, 子进程会不受干扰地运行下去. 如果你事先在子进程代码里设定了断点, 子进程会收到 `SIGTRAP` 信号并终止. 那么该如何调试子进程呢? 其实我们可以利用 GDB 的特点或者其他一些辅助手段来达到目的. 此外, GDB 也在较新内核上加入一些多进程调试支持.
- > 接下来我们详细介绍几种方法, 分别是 `follow-fork-mode` 方法, `attach` 子进程方法和 `GDB wrapper` 方法.
- > 1.1 follow-fork-mode方法简介
  * > 默认设置下, 在调试多进程程序时 GDB 只会调试主进程. 但是 GDB > V7.0 支持多进程的分别以及同时调试, 换句话说, GDB 可以同时调试多个程序. 只需要设置 `follow-fork-mode` (默认值 `parent`) 和 `detach-on-fork` (默认值 `on` )即可.

| follow-fork-mode | detach-on-fork | 说明 |
|:--:|:--:|:--:|
| parent | on | 只调试主进程( `GDB` 默认) |
| child | on | 只调试子进程 |
| parent | off | 同时调试两个进程, `gdb` 跟主进程, 子进程 `block` 在 `fork` 位置 |
| child | off | 同时调试两个进程, `gdb` 跟子进程, 主进程 `block` 在 `fork` 位置 |

gdb调试多进程和多线程命令
http://blog.csdn.net/pbymw8iwm/article/details/7876797

linux gdb-多线程调试
http://blog.csdn.net/lhl_blog/article/details/8888010

使用 GDB 调试多进程程序
https://www.ibm.com/developerworks/cn/linux/l-cn-gdbmp/index.html

# 第二批

gdb的多线程调试 https://www.cnblogs.com/the-capricornus/p/10059223.html
- > 在开始之前先说一些技巧吧：
  * > 1 如果你在程序没运行前想设置 `scheduler-locking` 的状态，总是给出如下的提示：`Target 'exec' cannot support this command.` <br> 那你可以先在 main 函数处打个断点，break main ，等待运行后停在断点处，再执行你的设置。其实可以在任何断点停住的地方进行设置。

Multiprocess debugging in GDB https://undo.io/resources/gdb-watchpoint/multiprocess-debugging-gdb/
- > **Catching the Write Syscall**
  * > We can create two bash sessions, echo $$ to get the Process ID in one and in the other open a GDB session on that PID.
    ```sh
    $ echo $$
    1633190
    ```

# 旧的

fork 多进程调试
http://blog.csdn.net/fingding/article/details/46459095

用gdb调试程序的子进程
http://blog.csdn.net/cjfeii/article/details/21647663
