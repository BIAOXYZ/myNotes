
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
