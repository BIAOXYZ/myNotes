
# 相关命令

- `awk`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

cut (Unix) https://en.wikipedia.org/wiki/Cut_(Unix)

Cut https://en.wikibooks.org/wiki/Cut

cut(1) — Linux manual page https://man7.org/linux/man-pages/man1/cut.1.html

cut(1) - Linux man page https://linux.die.net/man/1/cut

# 其他博客类链接

cut command in Linux with examples https://www.geeksforgeeks.org/cut-command-linux-examples/

linux之cut用法 https://www.cnblogs.com/dong008259/archive/2011/12/09/2282679.html
```sh
（7）域是怎么回事呢？解释解释:)

为什么会有“域”的提取呢，因为刚才提到的-b和-c只能在固定格式的文档中提取信息，而对于非固定格式的信息则束手无策。这时候“域”就派上用场了。如果你观察过/etc/passwd
文件，你会发现，它并不像who的输出信息那样具有固定格式，而是比较零散的排放。但是，冒号在这个文件的每一行中都起到了非常重要的作用，冒号用来隔开每一个项。

我们很幸运，cut命令提供了这样的提取方式，具体的说就是设置“间隔符”，再设置“提取第几个域”，就OK了！

以/etc/passwd的前五行内容为例：

[rocrocket@rocrocket programming]$ cat /etc/passwd|head -n 5
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
[rocrocket@rocrocket programming]$ cat /etc/passwd|head -n 5|cut -d : -f 1
root
bin
daemon
adm
lp

看到了吧，用-d来设置间隔符为冒号，然后用-f来设置我要取的是第一个域，再按回车，所有的用户名就都列出来了！呵呵 有成就感吧！
当然，在设定-f时，也可以使用例如3-5或者4-类似的格式：

[rocrocket@rocrocket programming]$ cat /etc/passwd|head -n 5|cut -d : -f 1,3-5
root:0:0:root
bin:1:1:bin
daemon:2:2:daemon
adm:3:4:adm
lp:4:7:lp
[rocrocket@rocrocket programming]$ cat /etc/passwd|head -n 5|cut -d : -f 1,3-5,7
root:0:0:root:/bin/bash
bin:1:1:bin:/sbin/nologin
daemon:2:2:daemon:/sbin/nologin
adm:3:4:adm:/sbin/nologin
lp:4:7:lp:/sbin/nologin
[rocrocket@rocrocket programming]$ cat /etc/passwd|head -n 5|cut -d : -f -2
root:x
bin:x
daemon:x
adm:x
lp:x

```

Linux 下 cut 命令的 4 个实用示例 https://linux.cn/article-9895-1.html
- > 译自：linuxhandbook.com 作者： Sylvain Leroux
  >> 4 Essential and Practical Usage of Cut Command in Linux https://linuxhandbook.com/cut-command/

Cut Command in Linux https://linuxize.com/post/linux-cut-command/

linux之cut用法 https://www.cnblogs.com/dong008259/archive/2011/12/09/2282679.html

# 个人实战
