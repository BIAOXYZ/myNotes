
# 源头

# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

mtab https://en.wikipedia.org/wiki/Mtab
- > This file lists all currently mounted filesystems along with their initialization options. `mtab` has a lot in common with [`fstab`](https://en.wikipedia.org/wiki/Fstab), the distinction being that the latter is a configuration file listing which available filesystems should be mounted on which mount points at boot time, whereas the former lists currently mounted ones, which can include manually mounted ones not listed in `fstab`. Therefore, `mtab` is usually in a format similar to that of `fstab`. Most of the time it is possible to directly use lines from `mtab` in `fstab`.
- > The file commonly resides in `/etc/mtab`. In some systems it is a symlink to `/proc/mounts`.

# 其他博客类链接

What is the difference between /etc/fstab and /etc/mtab? https://askubuntu.com/questions/754091/what-is-the-difference-between-etc-fstab-and-etc-mtab

linux专题|/etc/fstab和/etc/mtab的区别 https://www.jianshu.com/p/d39287b704d4

# 个人实战

## 小技巧：`df`命令无法显示磁盘使用情况时怎么办？

```sh
$ df -h
df: cannot read table of mounted file systems: No such file or directory
$
$ mount
# 省略内容，反正此时 mount 命令是可以正常使用的。

$ cat /etc/mtab
cat: /etc/mtab: No such file or directory
$
$ grep -v rootfs /proc/mounts > /etc/mtab
$ cat /etc/mtab
# 省略内容，grep那个语句确实新写了这么一个文件。

$ df -h
# 此时df命令可以正常使用了，所以我猜df命令本身其实就是读 /etc/mtab 里的内容再显示出来- -
```
