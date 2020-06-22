
# 源头

CDL的x86 quota已经满了，然后某天新员工突然跟我说她看到P类型的机器还有很多quota，问那个能行吗？

# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

# 个人实战

```sh
# 我哪想到Power的OCP集群连OS都直接是RH 8。。。
[root@powerocp-inf ~]# arch
ppc64le
[root@powerocp-inf ~]# cat /etc/os-release
NAME="Red Hat Enterprise Linux"
VERSION="8.2 (Ootpa)"
ID="rhel"
ID_LIKE="fedora"
VERSION_ID="8.2"
PLATFORM_ID="platform:el8"
PRETTY_NAME="Red Hat Enterprise Linux 8.2 (Ootpa)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:redhat:enterprise_linux:8.2:GA"
HOME_URL="https://www.redhat.com/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"

REDHAT_BUGZILLA_PRODUCT="Red Hat Enterprise Linux 8"
REDHAT_BUGZILLA_PRODUCT_VERSION=8.2
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux"
REDHAT_SUPPORT_PRODUCT_VERSION="8.2"
[root@powerocp-inf ~]#

# 对比下另一台x86机器的查询结果
[root@anaemia-inf ~]# arch
x86_64
```

```sh
# 另外补充点和这个arch命令没啥关系的内容吧，纯好奇查的。

## 内存看起来没啥区别，但是不知道为啥Power的机器明明是root却看不了 /proc/meminfo。
## 另外top命令的内容就不对比了，太多了。。。
[root@powerocp-inf ~]# free -m
              total        used        free      shared  buff/cache   available
Mem:           7964         618        6124         254        1221        7026
Swap:          4091           0        4091
[root@powerocp-inf ~]#
[root@powerocp-inf ~]# vmstat
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0      0 6267712   4224 1248000    0    0     0     1    6   11  0  0 100  0  0
[root@powerocp-inf ~]#
[root@powerocp-inf ~]# /proc/meminfo
-bash: /proc/meminfo: Permission denied
[root@powerocp-inf ~]#


[root@anaemia-inf ~]# free -m
              total        used        free      shared  buff/cache   available
Mem:           1837         182         178          96        1476        1384
Swap:         16383           0       16383
[root@anaemia-inf ~]#
[root@anaemia-inf ~]# vmstat
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0    768 182916   2072 1510364    0    0     0     1    1    3  0  0 100  0  0
[root@anaemia-inf ~]#
[root@anaemia-inf ~]# cat /proc/meminfo
MemTotal:        1881896 kB
MemFree:          183072 kB
MemAvailable:    1418204 kB
Buffers:            2072 kB
Cached:          1415328 kB
SwapCached:           40 kB
Active:           746932 kB
Inactive:         760500 kB
Active(anon):      79128 kB
Inactive(anon):   109544 kB
Active(file):     667804 kB
Inactive(file):   650956 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:      16777212 kB
SwapFree:       16776444 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:         90052 kB
Mapped:            24908 kB
Shmem:             98640 kB
Slab:             113932 kB
SReclaimable:      95068 kB
SUnreclaim:        18864 kB
KernelStack:        2672 kB
PageTables:         5324 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    17718160 kB
Committed_AS:     507428 kB
VmallocTotal:   34359738367 kB
VmallocUsed:       16948 kB
VmallocChunk:   34359718892 kB
HardwareCorrupted:     0 kB
AnonHugePages:     32768 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:       94056 kB
DirectMap2M:     2002944 kB
DirectMap1G:           0 kB
[root@anaemia-inf ~]#
```

```sh
## CPU不一样，Power的显式的内容好像简单得多。
[root@powerocp-inf ~]# cat /proc/cpuinfo
processor       : 0
cpu             : POWER8 (architected), altivec supported
clock           : 2893.000000MHz
revision        : 2.0 (pvr 004d 0200)

processor       : 1
cpu             : POWER8 (architected), altivec supported
clock           : 2893.000000MHz
revision        : 2.0 (pvr 004d 0200)

processor       : 2
cpu             : POWER8 (architected), altivec supported
clock           : 2893.000000MHz
revision        : 2.0 (pvr 004d 0200)

processor       : 3
cpu             : POWER8 (architected), altivec supported
clock           : 2893.000000MHz
revision        : 2.0 (pvr 004d 0200)

timebase        : 512000000
platform        : pSeries
model           : IBM pSeries (emulated by qemu)
machine         : CHRP IBM pSeries (emulated by qemu)
MMU             : Hash
[root@powerocp-inf ~]#


[root@anaemia-inf ~]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 94
model name      : Intel Core Processor (Skylake, IBRS)
stepping        : 3
microcode       : 0x1
cpu MHz         : 2199.984
cache size      : 16384 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology eagerfpu pni pclmulqdq vmx ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single ssbd ibrs ibpb tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt arat md_clear spec_ctrl
bogomips        : 4399.96
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 94
model name      : Intel Core Processor (Skylake, IBRS)
stepping        : 3
microcode       : 0x1
cpu MHz         : 2199.984
cache size      : 16384 KB
physical id     : 1
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology eagerfpu pni pclmulqdq vmx ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single ssbd ibrs ibpb tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt arat md_clear spec_ctrl
bogomips        : 4399.96
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management:

[root@anaemia-inf ~]#
```
