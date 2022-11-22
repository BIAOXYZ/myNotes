
# 相关命令

- `top`

# 其他博客类链接

为什么 Linux 的 htop 命令完胜 top 命令 https://linux.cn/article-3141-1.html

htop使用详解 https://www.cnblogs.com/yqsun/p/5396363.html
- > **三．Htop的使用**
  * > 左边部分从上至下，分别为，cpu、内存、交换分区的使用情况，右边部分为：Tasks为进程总数，当前运行的进程数、Load average为系统1分钟，5分钟，10分钟的平均负载情况、Uptime为系统运行的时间。![](http://static.open-open.com/lib/uploadImg/20141203/20141203210953_803.png)
  * > ![](http://static.open-open.com/lib/uploadImg/20141203/20141203210953_984.png) 以上各项分别为：
    + > VIRT：进程占用的虚拟内存值
    + > RES：进程占用的物理内存值
    + > SHR：进程占用的共享内存值
    + > S：进程的运行状况，R表示正在运行、S表示休眠，等待唤醒、Z表示僵死状态
    + > %CPU：该进程占用的CPU使用率
    + > %MEM：该进程占用的物理内存和总内存的百分比
    + > TIME+：该进程启动后占用的总的CPU时间
    + > COMMAND：进程启动的启动命令名称

Linux查看CPU状态：htop命令 https://blog.csdn.net/zxgravity/article/details/82224069
