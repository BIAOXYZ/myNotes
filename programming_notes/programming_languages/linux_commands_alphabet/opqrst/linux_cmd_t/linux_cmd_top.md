
# 源头

# 相关命令

- `atop`
- [`btop`](https://github.com/aristocratos/btop)
- `htop`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

每天一个linux命令（44）：top命令 https://www.cnblogs.com/peida/archive/2012/12/24/2831353.html

`8. top linux下的任务管理器` https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/top.html
```sh
$top
    top - 09:14:56 up 264 days, 20:56,  1 user,  load average: 0.02, 0.04, 0.00
    Tasks:  87 total,   1 running,  86 sleeping,   0 stopped,   0 zombie
    Cpu(s):  0.0%us,  0.2%sy,  0.0%ni, 99.7%id,  0.0%wa,  0.0%hi,  0.0%si,  0.2%st
    Mem:    377672k total,   322332k used,    55340k free,    32592k buffers
    Swap:   397308k total,    67192k used,   330116k free,    71900k cached
    PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
    1 root      20   0  2856  656  388 S  0.0  0.2   0:49.40 init
    2 root      20   0     0    0    0 S  0.0  0.0   0:00.00 kthreadd
    3 root      20   0     0    0    0 S  0.0  0.0   7:15.20 ksoftirqd/0
    4 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 migration/0
----------------------------------------------------------------------------------------------------
第一行
    09:14:56 ： 系统当前时间
    264 days, 20:56 ： 系统开机到现在经过了多少时间
    1 users ： 当前2用户在线
    load average: 0.02, 0.04, 0.00： 系统1分钟、5分钟、15分钟的CPU负载信息
第二行
    Tasks：任务;
    87 total：很好理解，就是当前有87个任务，也就是87个进程。
    1 running：1个进程正在运行
    86 sleeping：86个进程睡眠
    0 stopped：停止的进程数
    0 zombie：僵死的进程数
第三行
    Cpu(s)：表示这一行显示CPU总体信息
    0.0%us：用户态进程占用CPU时间百分比，不包含renice值为负的任务占用的CPU的时间。
    0.7%sy：内核占用CPU时间百分比
    0.0%ni：改变过优先级的进程占用CPU的百分比
    99.3%id：空闲CPU时间百分比
    0.0%wa：等待I/O的CPU时间百分比
    0.0%hi：CPU硬中断时间百分比
    0.0%si：CPU软中断时间百分比
    注：这里显示数据是所有cpu的平均值，如果想看每一个cpu的处理情况，按1即可；折叠，再次按1；
第四行
    Men：内存的意思
    8175320k total：物理内存总量
    8058868k used：使用的物理内存量
    116452k free：空闲的物理内存量
    283084k buffers：用作内核缓存的物理内存量
第五行
    Swap：交换空间
    6881272k total：交换区总量
    4010444k used：使用的交换区量
    2870828k free：空闲的交换区量
    4336992k cached：缓冲交换区总量
进程信息
    PID：进程的ID
    USER：进程所有者
    PR：进程的优先级别，越小越优先被执行
    NInice：值
    VIRT：进程占用的虚拟内存
    RES：进程占用的物理内存
    SHR：进程使用的共享内存
    S：进程的状态。S表示休眠，R表示正在运行，Z表示僵死状态，N表示该进程优先值为负数
    %CPU：进程占用CPU的使用率
    %MEM：进程使用的物理内存和总内存的百分比
    TIME+：该进程启动后占用的总的CPU时间，即占用CPU使用时间的累加值。
    COMMAND：进程启动命令名称
----------------------------------------------------------------------------------------------------
实例1：多核CPU监控
在top基本视图中，按键盘数字“1”，可监控每个逻辑CPU的状况；
```

top命令输出详解 https://www.cnblogs.com/makelu/p/11169270.html

# 个人实战

## top后按1显示多核cpu各个核心负载情况的信息

```sh
[root@c4-infra02 ~]# top
top - 14:37:02 up 174 days,  4:58,  5 users,  load average: 0.86, 1.53, 1.94
Tasks: 678 total,   1 running, 677 sleeping,   0 stopped,   0 zombie
%Cpu(s):  3.2 us,  1.5 sy,  0.0 ni, 94.4 id,  0.8 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem : 32742556 total,   705664 free, 18001204 used, 14035688 buff/cache
KiB Swap: 16516092 total, 15523388 free,   992704 used. 12183360 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
 1245 1000      20   0 4555852 722112  12052 S  10.6  2.2  11069:36 java
 8914 root      20   0 6197932 358720  49228 S   9.6  1.1  40205:10 hyperkube
17699 1000      20   0 4915608   1.3g  14640 S   5.9  4.1  10766:34 java
 6574 root      20   0 4320800 182160  23576 S   5.6  0.6  24828:14 dockerd
17702 root      20   0 3310156 922772  42468 S   5.3  2.8  28127:32 hyperkube
22933 root      20   0 2226792 185828  46824 S   5.3  0.6 665:12.94 hyperkube
12754 root      20   0   56940  29992  13812 S   3.3  0.1  97:32.75 calico-node
17700 1000      20   0 8568956   1.8g  20596 S   3.3  5.6  12699:39 java
17474 root      20   0   10.4g 303408  14116 S   3.0  0.9   6834:15 etcd
13055 nfsnobo+  20   0  122168   5464   2832 S   2.3  0.0   3890:29 nginx
 6164 dbus      20   0   58384   2560   1740 S   1.7  0.0   5044:20 dbus-daemon
    1 root      20   0  198884  11472   2640 S   1.3  0.0   4175:26 systemd
12918 nfsnobo+  20   0 1412724 781456  26144 S   1.3  2.4   9565:56 prometheus
23109 root      20   0 1773544  76416  42036 S   1.3  0.2 145:21.05 hyperkube
 7030 root      20   0 7627132  67696  11180 S   1.0  0.2   3498:32 docker-containe
 7937 root      20   0   92748  34572   4028 S   1.0  0.1   1894:29 filebeat
18774 1000      20   0 3359712  25648   4900 S   1.0  0.1   2100:54 db
18856 polkitd   20   0 3101532   1.4g  19484 S   1.0  4.4   3206:20 mongod

# 在top运行时正在动态显示系统负载的时候按1，会发现上面多了一些显示cpu各个核的利用率情况的信息
[root@c4-infra02 ~]# top
top - 14:37:32 up 174 days,  4:58,  5 users,  load average: 1.11, 1.53, 1.92
Tasks: 678 total,   1 running, 677 sleeping,   0 stopped,   0 zombie
%Cpu0  :  4.7 us,  1.3 sy,  0.0 ni, 92.7 id,  1.3 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu1  :  3.6 us,  2.0 sy,  0.3 ni, 93.7 id,  0.3 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu2  :  3.7 us,  3.0 sy,  0.0 ni, 93.0 id,  0.3 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu3  :  5.0 us,  2.3 sy,  0.0 ni, 92.1 id,  0.7 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu4  :  3.3 us,  1.7 sy,  0.0 ni, 94.0 id,  1.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu5  :  2.6 us,  2.0 sy,  0.0 ni, 94.0 id,  1.3 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu6  :  3.0 us,  1.3 sy,  0.0 ni, 94.7 id,  1.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu7  :  4.6 us,  1.7 sy,  0.0 ni, 93.4 id,  0.3 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu8  :  2.0 us,  1.3 sy,  0.3 ni, 95.7 id,  0.7 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu9  :  3.0 us,  3.4 sy,  0.0 ni, 93.0 id,  0.7 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu10 :  5.0 us,  2.0 sy,  0.3 ni, 90.0 id,  2.7 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu11 :  1.7 us,  1.7 sy,  0.3 ni, 96.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu12 :  2.0 us,  1.3 sy,  0.0 ni, 96.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu13 :  2.6 us,  2.3 sy,  0.3 ni, 94.0 id,  0.7 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu14 :  1.3 us,  1.3 sy,  0.0 ni, 97.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu15 :  2.0 us,  1.0 sy,  0.0 ni, 97.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem : 32742556 total,   706464 free, 17999436 used, 14036656 buff/cache
KiB Swap: 16516092 total, 15523388 free,   992704 used. 12185296 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
 8914 root      20   0 6197932 358720  49228 S   9.9  1.1  40205:15 hyperkube
 6574 root      20   0 4320800 182160  23576 S   8.9  0.6  24828:17 dockerd
 1245 1000      20   0 4555852 722112  12052 S   6.9  2.2  11069:37 java
17702 root      20   0 3310156 922772  42468 S   6.2  2.8  28127:35 hyperkube
22933 root      20   0 2226792 185828  46824 S   5.3  0.6 665:14.42 hyperkube
17699 1000      20   0 4915608   1.3g  14640 S   3.9  4.1  10766:35 java
12754 root      20   0   56940  29992  13812 S   3.0  0.1  97:33.39 calico-node
17474 root      20   0   10.4g 294100  14116 S   2.6  0.9   6834:16 etcd
```    
