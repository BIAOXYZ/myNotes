
# 相关命令

- `top`

# 其他博客类链接

ps命令--排序 https://blog.csdn.net/lmy4710/article/details/8680763
```
Linux中ps命令会自动选择一列进行排序，但有时这不是我们想要的。

方法一：

ps+sort

sort 选项与参数：

-f  ：忽略大小写的差异，例如 A 与 a 视为编码相同；
-b  ：忽略最前面的空格符部分；
-M  ：以月份的名字来排序，例如 JAN, DEC 等等的排序方法；
-n  ：使用『纯数字』进行排序(默认是以文字型态来排序的)；
-r  ：反向排序；
-u  ：就是 uniq ，相同的数据中，仅出现一行代表；
-t  ：分隔符，默认是用 [tab] 键来分隔；
-k  ：以那个区间 (field) 来进行排序的意思

例如：

ps -eo rss,pmem,pcpu,vsize,args |  sort -k 1 -r -n | less

按内存使用进行降序排列

ps , -e 是显示所有进程, -o是定制显示信息的格式

    rss: resident set size, 表示进程占用RAM(内存)的大小，单位是KB

    pmem: %M, 占用内存的百分比

    pcpu：%C，占用cpu的百分比

    vsize: 表示进程占用的虚拟内存的大小，KB

    args：进程名(command)

    sort命令对ps结果进行排序

    -k 1 :按第一个参数 rss进行排


    -r：逆序


    -n：numeric，按数字来排序



方法二：

使用ps自有参数--sort进行排序

格式：

--sort=[+|-] key

从SORT KEYS段中选一个多字母键.“+”字符是可选地,因为默认地方向就是按数字升序或者词典顺序.

比如：

按内存升序排列：ps aux --sort=rss 
按CPU降序排列：ps aux --sort=-%cpu

排序中运用的值是ps运用地内部值,并非仅用于某些输出格式地伪值.排序键列表见下表：

c cmd   可执行地简单名称 
C cmdline   完整命令行 
f flags   长模式标志 
g pgrp   进程地组ID 
G tpgid   控制tty进程组ID 
j cutime   累计用户时间 
J cstime   累计系统时间 
k utime   用户时间 
K stime   系统时间 
m min_flt   次要页错误地数量 
M maj_flt   重点页错误地数量 
n cmin_flt 累计次要页错误 
N cmaj_flt 累计重点页错误 
o session   对话ID 
p pid   进程ID 
P ppid   父进程ID 
r rss   驻留大小 
R resident 驻留页 

s size   内存大小(千字节) 

S share   共享页地数量 
t tty   tty次要设备号 
T start_time 进程启动地时间 
U uid   UID
u user   用户名
v vsize   总地虚拟内存数量(字节) 
y priority 内核调度优先级
```

修复 "System has not been booted with systemd as init system "的错误。 https://www.cnblogs.com/a5idc/p/13752839.html
- > 如果你按照网上的一些教程，使用systemd命令，如sudo systemctl start。令你惊讶的是，该命令的结果是这样的错误。
  ```console
  System has not been booted with systemd as init system (PID 1). Can't operate.
  ```
- > 原因：您的Linux系统没有使用systemd。
  * > 原因是你想用systemd命令来管理Linux上的服务，但你的系统并没有使用systemd，（很可能）使用的是经典的SysV init（sysvinit）系统。
  * > 但这怎么可能呢？你使用的是Ubuntu，教程也是针对同一版本的Ubuntu。为什么你不能用呢？如果你在Windows里面用WSL使用Ubuntu，那么你的系统就会有SysV而不是systemd，当你运行systemctl命令时，你的系统就会抱怨（针对Linux系统的systemd init系统）。
  * > 如何知道你使用的是哪个init系统？你可以使用这个命令来知道与PID 1（系统上运行的第一个进程）相关联的进程名称。
    ```sh
    ps -p 1 -o comm=
    ```
    > 它应该在输出中显示systemd或sysv（或类似的东西）。
- > 如何解决'System has not been booted with systemd'错误？
  * > 答案很简单，就是不要使用systemctl命令，而是使用等同的sysvinit命令。相反，可以使用对应的sysvinit命令。这并不复杂，而且这两个命令的语法有些相似。这张表应该可以帮助你。
