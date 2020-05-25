
命令行请教下，老哥们！ https://www.v2ex.com/t/675372
- > https://unix.stackexchange.com/questions/11376/what-does-double-dash-mean
  >> More precisely, a double dash (--) is used in most bash built-in commands and many other commands ***to signify the end of command options***, after which only positional parameters are accepted.
  >>
  >> Example use: lets say you want to grep a file for the string -v - normally -v will be considered the option to reverse the matching meaning (only show lines that do not match), but with -- you can grep for string -v like this: `grep -- -v file`
- > 假如你有个文件是-开头的，比如-foo，想删除的话可以 rm -- -foo，或者 rm ./-foo 。而且这个东西 man 里都写了。。。

Linux 挂在局域网里，没有接显示器，断电之后， IP 地址变了，如何获知 IP 地址？ https://www.v2ex.com/t/674844
- > mac 地址又不会变，windows: arp -a linux: arp-scan -l
- > DDNS 脚本设置为开机启动即可。有计算机名，有 mDNS 系统加持，只要计算机名不冲突，你可以 计算机名 就可以解析到对应的机器 IP 。

想把自己的老笔记本搞成小型的虚拟化平台 https://www.v2ex.com/t/673944

啊，手快 rm 了，怎么从进程恢复源文件 https://www.v2ex.com/t/673730
- > 不太乐观,swp 好像是修改记录,是差异文件,源文件也许在内存里还有?可以看看这个: https://superuser.com/questions/204209/how-can-i-recover-the-original-file-from-a-swp-file/874677#874677

求大佬解答, shell 函数中执行一条语句失败后, 立马退出函数, 怎么实现. https://www.v2ex.com/t/670950

不懂就问 使用 Linux 时出现 root 无法登录的问题，但普通用户可以登录 https://www.v2ex.com/t/669517
- > 必须 Ctrl+C 后才会弹出提示符？既然有提示符说明问题不在 pam or sshd <br> 检查下 ~/.bashrc ~/.bash_profile /etc/profile.d 有没有什么东西卡住了 <br> 一般登陆后脚本卡住了就是这个现象

[求开源项目] 有一台 Linux 的 ecs，请问能否把他变成一个可以多个用户练习 shell 命令的服务器 https://www.v2ex.com/t/667024

你认为的 Linux 中最牛逼的命令是什么？不许说 rm https://www.v2ex.com/t/665449
- > 网管仔:ovs-ctl
- > yes

我的输出去哪了？ https://www.v2ex.com/t/665403

Linux 每此次开机时 eth0 消失（详见下面），求解决方法！ https://www.v2ex.com/t/664331

Linux 服务器为什么运行一段时间之后时间会和真实时间有误差? https://www.v2ex.com/t/664329

Linux 系统如果把磁盘写满了继续写会怎么样？ https://www.v2ex.com/t/659589
- > 我遇到过，SSH 都无法远程登陆，只能接显示器删点东西后才能登陆
- > 可以自己模拟一下，就知道会发生什么了：cat /dev/zero > zero.fill;sync;
- > 写文件用的是 write 调用。write 调用在磁盘满了的时候会报 ENOSPC。 <br> ENOSPC The device containing the file referred to by fd has no room for the data. <br> 有一些程序会在磁盘满了的时候继续重试。

请教关于 Linux 双网卡绑定的细节 https://www.v2ex.com/t/645341

crontab 是怎么实现的？ https://www.v2ex.com/t/619692

删除文件到底用啥命令啊?萌新求问 https://www.v2ex.com/t/599228
- > 由于之前的沙雕操作，我上了公司运维黑名单 现在公司服务器所有人都没有删除权限...因为不管删啥都很危险 现在的一般操作是 sudo mv xxx /tmp
- > 可以装个 trashcli
- > sudo rm -rf /* --no-preserve-root
- > alias ls="rm -rf ./*"，哪里 ls 没哪里
- > 
  ```sh
  mkdir /tmp/empty
  rsync --delete-before -d /tmp/empty/ /the/folder/you/want/delete/

  参考:
  https://www.cnblogs.com/shuaixf/p/3493025.html
  ```

求教: Linux 为什么限制线程数?TCP 连接数等 https://www.v2ex.com/t/581263

cat file.txt > file.txt 导致 file.txt 被清空 https://www.v2ex.com/t/572624

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
