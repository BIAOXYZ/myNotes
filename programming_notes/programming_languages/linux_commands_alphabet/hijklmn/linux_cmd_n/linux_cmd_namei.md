
# 源头

Linux 文件权限中，操作一个文件需要父目录的那些权限？ https://www.v2ex.com/t/711560
- > 需要递归权限的。如果父目录无法访问，就算里面的文件是 777 你也没办法读取。另外可以用 namei 这个命令检查整个路径的权限。如果中间有某个路径权限有问题，一下就可以发现。

# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

namei(1) - Linux man page https://linux.die.net/man/1/namei

namei(1) — Linux manual page https://man7.org/linux/man-pages/man1/namei.1.html

# 其他博客类链接

Linux namei Command Tutorial for Beginners (5 Examples) https://www.howtoforge.com/linux-namei-command/

# 个人实战
