
# 调试 coredump 文件

<<详解coredump>> http://blog.csdn.net/tenfyguo/article/details/8159176
- > core文件默认的存储位置与对应的可执行程序在同一目录下，文件名是core，大家可以通过下面的命令看到core文件的存在位置：
  ```sh
  cat /proc/sys/kernel/core_pattern
  ```
  > 缺省值是 `core` 
  >> //notes：个人补充：有的时候系统默认值不是 `core`，比如，见过默认值是这个的： `|/etc/sysop/coredump/bin/coredump_handler %P %t %E` --> 我也不知道前面那个竖线是什么意思，但是确定能在那个目录下正确生成core文件。
  >>> //notes2：很多时候我们只需要一个core dump文件调试就够了，此时用语句 `echo "core" > /proc/sys/kernel/core_pattern` 设置成默认就行。
  >>>> //notes3：不过如果都走到这一步了，何不再加上`程序名`、`时间`、`进程ID`之类的信息呢？其实只需要稍复杂一点点就可以了，如下两个语句效果是等价的：
  ```sh
  $ echo "./core.%e.%t.%p" > /proc/sys/kernel/core_pattern
  $ cat /proc/sys/kernel/core_pattern
  ./core.%e.%t.%p
  $ 
  $ echo "core.%e.%t.%p" > /proc/sys/kernel/core_pattern
  $ cat /proc/sys/kernel/core_pattern
  core.%e.%t.%p
  $
  ```
- > 1.产生coredump的条件，首先需要确认当前会话的 `ulimit –c`，若为0，则不会产生对应的coredump，需要进行修改和设置。
  ```sh
  ulimit  -c unlimited
  ```
- > 3.Core_pattern的格式
  ```console
  可以在core_pattern模板中使用变量还很多，见下面的列表：
  %% 单个%字符
  %p 所dump进程的进程ID
  %u 所dump进程的实际用户ID
  %g 所dump进程的实际组ID
  %s 导致本次core dump的信号
  %t core dump的时间 (由1970年1月1日计起的秒数)
  %h 主机名
  %e 程序文件名
  ```
- //notes：另外补充一下——当core文件生成后，调试core文件的命令是：`gdb 程序文件名 core文件名`。对于带参数的情形，应该是用：`gdb --args 程序文件名 参数列表 core文件名`。

gdb调试coredump(使用篇) http://blog.csdn.net/sunxiaopengsun/article/details/72974548

Linux生成core文件、core文件路径设置 https://blog.csdn.net/u011417820/article/details/71435031
