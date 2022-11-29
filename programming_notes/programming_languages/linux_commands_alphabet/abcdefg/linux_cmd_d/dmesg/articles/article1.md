
# 1

我的进程去哪儿了，谁杀了我的进程 https://www.cnblogs.com/xybaby/p/8098229.html
- > 一个大型系统一般包含多个进程，同一个服务也可能是有多个进程组成，那么可以将这组进程逐步更新：先让一部分进程停止提供服务，等待已有的请求都完毕之后，重启这些服务，然后再更新替他进程。 <br> 即使，我们需要关闭所有服务，也需要优雅（graceful）地停止这些进程。所谓的优雅，就是保证已有的请求都能处理完，需要持久化的状态、数据都保存成功，然后再结束进程，一般来说，可以通过发送信号或者通过哨兵（sentinel）来结束。 <br> 只要是预期内的进程结束，那么都是ok的。而预期之外的进程结束往往令程序员抓狂，线上服务器的问题往往意味着分分钟几位数的损失、KPI、年终奖......想想就很恐怖。
- > **Linux Signal**
  * > 一个进程的异常终止，通常有两种情况，一种是crash，另一种是被kill掉了。
  * > ***crash是指程序出现了自己无法解决的异常情况，只能终止，比如Python语言抛出了一个未被捕获的异常，就会结束程序***。对于C、C++，最有名的就是段错误（segmentation fault），如果在Linux下面，那么会生成coredump，程序员通过`gdb`（有可能）可以分析出crash的原因。当然，要生成coredump也是需要正确的设置，可以通过`ulimit`（`ulimit -c`）查看或者设置。
  * > 而进程被`kill`掉，就是其他进程给目标进程发送了信号（signal），当然也可以是自己给自己发的信号，而目标进程没有正确处理这些信号，或者根本没有机会（权力）处理这些信号，那么目标进程就有可能会终止。
  * > 信号是Unix-like系统进程间通信（`IPC`）的一种方式，***这种通知是异步的，信号是一种软中断，操作系统会将目标进程的正常执行流程暂停，然后处理信号***。如果 ***目标进程注册了相应的信号处理函数（signal handler），那么就会调用这个signal handler，否则会执行默认的信号处理函数***。
  * > 不同的操作系统，支持的信号可能略有差异，可以使用`kill -l`查看系统所有的信号。下面是Linux上常见的信号以及处理机制
    ```console
    信号 　　　值    处理动作 发出信号的原因 
    ---------------------------------------------------------------------- 
    SIGHUP   1        A   终端挂起或者控制进程终止 
    SIGINT   2        A   键盘中断（如break键被按下） 
    SIGQUIT  3        C   键盘的退出键被按下 
    SIGILL   4        C   非法指令 
    SIGABRT  6        C   由abort(3)发出的退出指令 
    SIGFPE   8        C   浮点异常 
    SIGKILL  9        AEF Kill信号 
    SIGSEGV  11       C   无效的内存引用 
    SIGPIPE  13       A   管道破裂: 写一个没有读端口的管道 
    SIGALRM  14       A   由alarm(2)发出的信号 
    SIGTERM  15       A   终止信号 
    SIGUSR1  30,10,16 A   用户自定义信号1 
    SIGUSR2  31,12,17 A   用户自定义信号2 
    SIGCHLD  20,17,18 B   子进程结束信号 
    SIGCONT  19,18,25     进程继续（曾被停止的进程） 
    SIGSTOP  17,19,23 DEF 终止进程 
    SIGTSTP  18,20,24 D   控制终端（tty）上按下停止键 
    SIGTTIN  21,21,26 D   后台进程企图从控制终端读 
    SIGTTOU  22,22,27 D   后台进程企图从控制终端写 
    ```
    > 处理动作一项中的字母含义如下
    ```console
    A　　缺省的动作是终止进程
    B　　缺省的动作是忽略此信号
    C　　缺省的动作是终止进程并进行内核映像转储（dump core）
    D　　缺省的动作是停止进程
    E　　信号不能被捕获
    F　　信号不能被忽略
    ```
- > 如果默认处理动作是C（coredump），那么就会生成coredump，然后终止进程，在上一篇文章[《啊，我的程序为啥卡住啦》](http://www.cnblogs.com/xybaby/p/8025435.html)中，提到用`kill -11 pid`来终止、调试卡住的程序，这个`11`就是指信号`SIGSEGV`。
- > 注意 **`SIGKILL` `SIGSTOP`这两个信号，既不可以被捕获，也不能被忽略**，就是说收到这两个信号，程序就会不留痕迹地终止。
- > **到底是什么信号**
  * > 从上面，我们可以看到，有很多信号都可以终止进程，如果我们没有针对某种信号指定处理函数，那么我们怎么知道进程是被哪一个进程kill掉了呢，那就是`strace`。
  * > 我们以一段简单的Python代码为例：
    ```py
    # -*- coding: utf-8 -*-
    def func():
        while True:
            pass
    if __name__ == '__main__':
        func()
    ```
  * > 运行该代码：　
    ```console
    python run_forever.py &
    [1] 1035
    ```
    > 可以看到`pid`是1035，我们使用`strace`查看该进程：`$ strace -T -tt -e trace=all -p 1035`， 然后另起终端`kill`这个Python进程： `$kill -9 1035`。在`strace`可以看到：
    ```sh
    $ strace -T -tt -e trace=all -p 1035
    Process 1035 attached
    16:19:52.092202 +++ killed by SIGKILL +++
    ```
    > 也可以使用其他信号`kill`，比如，重新运行Python程序，进程为32599， `kill -10 32599`，那么`strace`的结果是
    ```sh
    $strace -T -tt -e trace=all -p 32599
    Process 32599 attached
    16:09:20.264993 --- SIGUSR1 {si_signo=SIGUSR1, si_code=SI_USER, si_pid=29373, si_uid=3010} ---
    16:09:20.265656 +++ killed by SIGUSR1 +++
    ```
    > 对比`kill -9`，`kill -10`多了一行信息，这是非常有用的信息，因为有了两个非常重要的字段，`si_pid`、`si_uid`
    ```console
    pid_t si_pid; // sending process ID
    pid_t si_uid; // Real user ID of sending process
    ```
    > ***即`si_pid`说明是哪一个进程发送的信息，`si_uid`是哪一个用户发出的信息***，使用`id si_uid`就能看出详细的用户信息。这样就直接定位了谁发送的信息。
  * > 不过，很多时候，进程被干掉，都是使用了`kill -9`（`SIGKILL`），那么即使使用`strace`也只是知道被干掉了，也没法知道被谁干掉了。而且，除非一个程序经常被`kill`掉，否则很少有人有`strace`长期监控这个进程。
- > **OOM**
  * > 关于进程收到了`SIGKILL`信号，有一种不得不提的情况，那就是`OOM（out of memory）`，简单来说，就是当Linux系统内存不足，在大量使用swap之后，***会`kill`掉内存占用最大的进程***。这应该算操作系统系统自身的一种保护机制，以防更多的进程不能正常工作。关于OOM killer，网上有详尽的资料介绍，在这里只是简单看看现象。
  * > 下面是一个简单的Python程序，该程序会无限的分配内存，直到内存不足：
    ```py
    # -*- coding: utf-8 -*-
    def func():
        l = [1]
        while True:
            l.append(l * 2)
    if __name__ == '__main__':
        func()
    ```
    > 运行该程序，然后用`strace`追踪，前面都是正常的内存分配相关的系统调用，直到最后
    ```console
    16:02:19.192409 mprotect(0x7f4aa886b000, 552960, PROT_READ|PROT_WRITE) = 0 <0.000014>
    16:02:19.744000 mmap(NULL, 552960, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 ENOMEM (Cannot allocate memory) <0.000108>
    16:02:19.755545 mprotect(0x7f4aa88f2000, 552960, PROT_READ|PROT_WRITE) = 0 <0.000019>
    16:02:23.404805 mmap(NULL, 552960, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <ptrace(SYSCALL):No such process>
    16:02:25.325272 +++ killed by SIGKILL +++
    [1]+ Killed python will_be_killed.py
    ```
  * > stackoverflow上 [who-killed-my-process-and-why](https://stackoverflow.com/questions/726690/who-killed-my-process-and-why) 一文指出，由于outofmemory被kill掉的进程，会在`/var/log`下的某个文件中留下最终的遗迹，在笔者使用的debian系统中，可以通过`dmesg`查看：
    ```sh
    dmesg －T | grep -E -i -B100 'killed process'
    ```
    > 日志如下：
    ```console
    [月 12日 24 16:02:24 2017] [ pid ] uid tgid total_vm rss nr_ptes swapents oom_score_adj name
    [月 12日 24 16:02:24 2017] [ 172] 0 172 10553 722 23 1375 0 systemd-journal
    [月 12日 24 16:02:24 2017] [ 181] 0 181 10201 398 22 134 -1000 systemd-udevd
    [月 12日 24 16:02:24 2017] [ 518] 0 518 8738 361 21 70 0 cron
    [月 12日 24 16:02:24 2017] [ 519] 0 519 4756 314 13 45 0 atd
    [月 12日 24 16:02:24 2017] [ 520] 0 520 13795 412 31 143 -1000 sshd
    [月 12日 24 16:02:24 2017] [ 525] 0 525 4964 161 14 65 0 systemd-logind
    [月 12日 24 16:02:24 2017] [ 536] 105 536 10531 172 26 98 -900 dbus-daemon
    [月 12日 24 16:02:24 2017] [ 580] 0 580 1064 362 8 34 0 acpid
    [月 12日 24 16:02:24 2017] [ 602] 0 602 4926 373 13 37 0 agetty
    [月 12日 24 16:02:24 2017] [ 605] 0 605 4881 373 14 37 0 agetty
    [月 12日 24 16:02:24 2017] [ 643] 108 643 8346 283 22 134 0 ntpd
    [月 12日 24 16:02:24 2017] [ 889] 104 889 12794 369 26 158 0 exim4
    [月 12日 24 16:02:24 2017] [11640] 0 11640 4188 1118 15 0 0 atop
    [月 12日 24 16:02:24 2017] [29370] 0 29370 14434 420 30 177 0 sshd
    [月 12日 24 16:02:24 2017] [29372] 3010 29372 14434 189 29 147 0 sshd
    [月 12日 24 16:02:24 2017] [29373] 3010 29373 7813 491 20 587 0 bash
    [月 12日 24 16:02:24 2017] [30731] 0 30731 14434 429 30 177 0 sshd
    [月 12日 24 16:02:24 2017] [30733] 3010 30733 14434 328 29 154 0 sshd
    [月 12日 24 16:02:24 2017] [30734] 3010 30734 7810 432 19 606 0 bash
    [月 12日 24 16:02:24 2017] [30746] 3010 30746 13967 408 30 102 0 su
    [月 12日 24 16:02:24 2017] [30747] 0 30747 7389 422 19 194 0 bash
    [月 12日 24 16:02:24 2017] [31688] 0 31688 13967 408 31 101 0 su
    [月 12日 24 16:02:24 2017] [31689] 3010 31689 7808 482 19 566 0 bash
    [月 12日 24 16:02:24 2017] [32128] 3010 32128 7761 445 19 32 0 top
    [月 12日 24 16:02:24 2017] [32132] 3010 32132 2357921 1868878 4581 467803 0 python
    [月 12日 24 16:02:24 2017] [32133] 3010 32133 1255 152 7 57 0 strace
    [月 12日 24 16:02:24 2017] Out of memory: Kill process 32132 (python) score 957 or sacrifice child
    [月 12日 24 16:02:24 2017] Killed process 32132 (python) total-vm:9431684kB, anon-rss:7473936kB, file-rss:1576kB 
    ```
  * > 由于进程使用内存最多，而且没有设置保护机制，所以32122这个python进程就被`kill`掉了。
  * > 所以，如果机器内存使用率较高，那么当进程消失的时候不妨用`dmesg`看看。

