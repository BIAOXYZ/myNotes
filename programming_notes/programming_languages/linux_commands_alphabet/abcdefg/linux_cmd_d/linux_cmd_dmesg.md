
linux 程序被Killed，如何精准查看日志 https://blog.csdn.net/shuihupo/article/details/80905641

Linux dmesg命令介绍 https://www.jianshu.com/p/4a029091b705

讲一讲内存不足问题的定位与处理 https://blog.csdn.net/chen1415886044/article/details/108611513

我的进程去哪儿了，谁杀了我的进程 https://www.cnblogs.com/xybaby/p/8098229.html
- > **Linux Signal**
  * > 一个进程的异常终止，通常有两种情况，一种是crash，另一种是被kill掉了。
  * > crash是指程序出现了自己无法解决的异常情况，只能终止，比如Python语言抛出了一个未被捕获的异常，就会结束程序。对于C、C++，最有名的就是段错误（segmentation fault），如果在Linux下面，那么会生成coredump，程序员通过gdb（有可能）可以分析出crash的原因。当然，要生成coredump也是需要正确的设置，可以通过ulimit（ulimit -c）查看或者设置。
  * > 而进程被kill掉，就是其他进程给目标进程发送了信号（signal），当然也可以是自己给自己发的信号，而目标进程没有正确处理这些信号，或者根本没有机会（权力）处理这些信号，那么目标进程就有可能会终止。
  * > 信号是Unix-like系统进程间通信（IPC）的一种方式，这种通知是异步的，信号是一种软中断，操作系统会将目标进程的正常执行流程暂停，然后处理信号。如果目标进程注册了相应的信号处理函数（signal handler），那么就会调用这个signal handler，否则会执行默认的信号处理函数。
- > **到底是什么信号**
  * > 从上面，我们可以看到，有很多信号都可以终止进程，如果我们没有针对某种信号指定处理函数，那么我们怎么知道进程是被哪一个进程kill掉了呢，那就是strace。
  * > 我们以一段简单的Python代码为例：
    ```py
    # -*- coding: utf-8 -*-
    def func():
        while True:
            pass
    if __name__ == '__main__':
        func()
    ```
- > **OOM**
  * > 关于进程收到了SIGKILL信号，有一种不得不提的情况，那就是OOM（out of memory），简单来说，就是当Linux系统内存不足，在大量使用swap之后，会kill掉内存占用最大的进程。这应该算操作系统系统自身的一种保护机制，以防更多的进程不能正常工作。关于OOM killer，网上有详尽的资料介绍，在这里只是简单看看现象。
  * > 下面是一个简单的Python程序，该程序会无限的分配内存，直到内存不足：
  * > stackoverflow上 [who-killed-my-process-and-why](https://stackoverflow.com/questions/726690/who-killed-my-process-and-why) 一文指出，由于outofmemory被kill掉的进程，会在`/var/log`下的某个文件中留下最终的遗迹，在笔者使用的debian系统中，可以通过`dmesg`查看：`dmesg －T | grep -E -i -B100 'killed process'`
