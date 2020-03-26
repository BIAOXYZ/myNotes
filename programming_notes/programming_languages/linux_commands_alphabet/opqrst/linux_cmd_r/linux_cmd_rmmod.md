
# 源头

`rmmod ipip`

# 相关命令

- `lsmod`
- `insmod`
- `modprobe`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

rmmod - Unix, Linux Command https://www.tutorialspoint.com/unix_commands/rmmod.htm

rmmod(8) - Linux man page https://linux.die.net/man/8/rmmod

# 其他博客类链接

图解Linux命令之--rmmod命令 https://blog.csdn.net/Jerry_1126/article/details/55003027
```sh
查看已经加载的驱动模块的信息：
lsmod              能够显示驱动的大小以及被谁使用  
cat /proc/modules  能够显示驱动模块大小、在内核空间中的地址
cat /proc/devices  只显示驱动的主设备号，且是分类显示 
cat /sys/modules   下面存在对应的驱动的目录，目录下包含驱动的分段信息
```

# 个人实战
