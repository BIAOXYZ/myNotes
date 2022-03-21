
# 相关命令

- `ltrace`
- `ptrace`

# 官方链接

strace - linux syscall tracer https://strace.io/

strace is a diagnostic, debugging and instructional userspace utility for Linux https://github.com/strace/strace

# 其他博客类链接

使用 Linux 的 strace 命令跟踪/调试程序的常用选项 https://linux.cn/article-3935-1.html

Understanding system calls on Linux with strace https://opensource.com/article/19/10/strace

运行个 Hello World 也能出 Bug？Python、Java、C++ 等 16 种语言中枪，最严重可导致文件丢失 https://www.ithome.com/0/608/854.htm || https://mp.weixin.qq.com/s/5m9A2VunlonIUxgaSsKwzQ
- > **Hello World 的 DeBug 过程**
  * > 用 `strace` 命令跟踪这一进程产生的系统调用可以发现，程序确实出现了故障：
    ```sh
    $ strace -etrace=write ./hello > /dev/full
    write(1, "Hello World!\n", 13)          = -1 ENOSPC (No space left on device)
    +++ exited with 0 +++
    ```
