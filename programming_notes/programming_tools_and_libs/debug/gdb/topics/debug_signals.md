
查看信号处理信息 https://wizardforcel.gitbooks.io/100-gdb-tips/content/info-signals.html  【`100个gdb小技巧`】

GDB调试之信号 http://tianyu-code.top/GDB%E8%B0%83%E8%AF%95/GDB%E8%B0%83%E8%AF%95%E4%B9%8B%E4%BF%A1%E5%8F%B7/ || https://kind-ptolemy-135b80.netlify.app/gdb%E8%B0%83%E8%AF%95/gdb%E8%B0%83%E8%AF%95%E4%B9%8B%E4%BF%A1%E5%8F%B7/

# 已阅

gdb 调试总结 https://markrepo.github.io/tools/2018/06/22/gdb/

GDB命令基础，让你的程序bug无处躲藏 https://deepzz.com/post/gdb-debug.html
- > **信号**
  * > 信号是一种软中断，是一种处理异步事件的方法。一般来说，操作系统都支持许多信号。尤其是UNIX，比较重要应用程序一般都会处理信号。UNIX定义了许多信号，比如 `SIGINT` 表示中断字符信号，也就是 `Ctrl+C` 的信号，`SIGBUS` 表示硬件故障的信号；`SIGCHLD` 表示子进程状态改变信号；`SIGKILL` 表示终止程序运行的信号，等等。信号量编程是UNIX下非常重要的一种技术。
  * > GDB有能力在你调试程序的时候处理任何一种信号，你可以告诉GDB需要处理哪一种信号。你可以要求GDB收到你所指定的信号时，马上停住正在运行的程序，以供你进行调试。你可以用GDB的 `handle` 命令来完成这一功能。
    ```console
    (gdb) handle <signal> <keywords...>
    ```
  * > 在GDB中定义一个信号处理。信号 `<signal>` 可以以 `SIG` 开头或不以 `SIG` 开头，可以用定义一个要处理信号的范围（如：`SIGIO-SIGKILL`，表示处理从 `SIGIO` 信号到 `SIGKILL` 的信号，其中包括`SIGIO`，`SIGIOT`，`SIGKILL` 三个信号），也可以使用关键字 `all` 来标明要处理所有的信号。一旦被调试的程序接收到信号，运行程序马上会被GDB停住，以供调试。其 `<keywords>` 可以是以下几种关键字的一个或多个。
    ```console
    nostop            # 当被调试的程序收到信号时，GDB不会停住程序的运行，但会打出消息告诉你收到这种信号。
    stop              # 当被调试的程序收到信号时，GDB会停住你的程序。
    print             # 当被调试的程序收到信号时，GDB会显示出一条信息。
    noprint           # 当被调试的程序收到信号时，GDB不会告诉你收到信号的信息。
    pass/noignore     # 当被调试的程序收到信号时，GDB不处理信号。这表示，GDB会把这个信号交给被调试程序会处理。
    nopass/ignore     # 当被调试的程序收到信号时，GDB不会让被调试程序来处理这个信号。
    ```
  * > 查看有哪些信号在被GDB检测中。
    ```console
    (gdb) info signals
    (gdb) info handle
    ```
- > **产生信号量**
  * > 使用singal命令，可以产生一个信号量给被调试的程序。如：中断信号 `Ctrl+C`。这非常方便于程序的调试，可以在程序运行的任意位置设置断点，并在该断点用GDB产生一个信号量，这种精确地在某处产生信号非常有利程序的调试。语法是：
    ```console
    (gdb) signal <singal>
    ```
  * > UNIX的系统信号量通常`从1到15`。所以 `<singal>` 取值也在这个范围。
  * > `signal` 命令和shell的 `kill` 命令不同，系统的 `kill` 命令发信号给被调试程序时，是由GDB截获的，而 `signal` 命令所发出一信号则是直接发给被调试程序的。
