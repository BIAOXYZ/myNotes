
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
