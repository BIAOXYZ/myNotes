
Linux 系统的路径，存储设备的挂载点，以及挂载这个操作，究竟要怎么理解比较好，越想越复杂 https://www.v2ex.com/t/809903
```console
我只知道可以创建一个空目录，然后把一块硬盘挂载到这个目录，那以后存到这个目录下的文件就是存在这块硬盘里。
如果在这个目录下再创建一个子目录，再挂载一块新的硬盘，那在这个子目录的文件就会存到这个新的硬盘里。
哦对，还有文件系统这个概念，加上这个更乱了。
```
- > 不要理解成子目录的文件存在新硬盘里。理解成新硬盘的根目录暂时掩盖掉了原来的子目录比较准确，因为非空的目录上也可以挂载硬盘
  >> 确实，忘了考虑这点。。。那这样的话，原本那个子目录下的文件还能访问到吗。
  >>> 无法用原来的路径访问了。但已经打开的文件描述符不受影响。另外还有 bind mount, 可以先把它 bind mount 到其它路径下 <br> 感觉把 mount 当作一种别名机制就可以了。文件系统在硬盘上，mount 之前就没有访问它的入口，mount 后就给了一个目录作为它的名字；通过 bind mount 可以给一个文件系统很多个名字

Linux 上的 df / fdisk / parted 的 size 是怎么计算的，为什么得到的结果不一样 https://www.v2ex.com/t/789073

cron 表达式中，有办法表达每月最后两天吗？ https://www.v2ex.com/t/786138
- > `0 0 0 L-2 * ? *` <br> https://www.freeformatter.com/cron-expression-generator-quartz.html 这么好用的工具安利一下

请教一个 centos7 默认防火墙问题 https://www.v2ex.com/t/780812
- > 问题解决，谢谢各位 参考： https://blog.csdn.net/Jailman/article/details/111591811
  ```
  禁止 docker 管理防火墙
  修改 /etc/docker/daemon.json
  {
  “iptables”:false
  }
  重启 docker
  ```

关于 rsync 的新发现 https://www.v2ex.com/t/776894
```console
至此我才明白，rsync只检查时间和文件大小，就决定两边文件是否一致
如果构造两个文件，内容不一样，但是时间和大小都一样，rsync就会认为两文件一样从而不再传输

比如，创建两个文件，一个内容为 123，一个内容为 321
$ cat file1.txt file2.txt
123
321

然后把他们 touch 成时间相同
$ touch file1.txt file2.txt

然后看一下他们的详细信息
$ stat file1.txt file2.txt
  File: file1.txt
  Size: 4               Blocks: 8          IO Block: 4096   regular file
Device: 10302h/66306d   Inode: 7471107     Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/z)   Gid: ( 1000/z)
Access: 2021-05-14 11:27:13.168183020 +0800
Modify: 2021-05-14 11:27:13.168183020 +0800
Change: 2021-05-14 11:27:13.168183020 +0800
 Birth: -
  File: file2.txt
  Size: 4               Blocks: 8          IO Block: 4096   regular file
Device: 10302h/66306d   Inode: 7471108     Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/z)   Gid: ( 1000/z)
Access: 2021-05-14 11:27:13.168183020 +0800
Modify: 2021-05-14 11:27:13.168183020 +0800
Change: 2021-05-14 11:27:13.168183020 +0800
 Birth: -

然后我们执行rsync
$ rsync -vv -n --no-whole-file --inplace file1.txt file2.txt
delta-transmission enabled
file2.txt is uptodate
total: matches=0  hash_hits=0  false_alarms=0 data=0

sent 46 bytes  received 76 bytes  244.00 bytes/sec
total size is 4  speedup is 0.03 (DRY RUN)

rsync果然没有传输
针对这种情况，还需要加上--ignore-times参数，才能让rsync传输时间、大小都一致的文件
```
- > `--checksum`, `-c` skip based on checksum, not mod-time & size
- > 我一般是 `acvz`，z 还可以压缩下。

问个 Linux 问题，纠结一下午了，关于 user 和 group, /etc/passwd 和 /etc/group https://www.v2ex.com/t/769788
- > （补充组才需要在 /etc/group 里记录，这是约定） <br> 你可以反过来思考下为什么要这样约定 假设不遵循约定会发生什么。。。 <br> 简单说就是数据库设计里避免冗余的方法，如果已经在 passwd 里决定了主组，如果还在 group 里重复记录，那么在出现不一致的时候就会产生歧义，到底按哪个记录为准，现在这样设计就很明确了，登录的时候程序只需要读取 passwd 改变程序的 UID gid，读取 group 扫描有对应用户的 group，通过 setgroups 系统调用设置补充组即可

运行关机 shutdown 命令时。能不能自动关闭某些服务 https://www.v2ex.com/t/729734
```console
A 自定义了一个脚本在 /etc/init.d/test，在 A 运行 service test stop，就会 ssh 到 B 机器，shutdown 关机 B 机器。
有没有可能在 A 运行 shutdown 时自关也去跑 service test stop, 从而关闭 A 就是关闭 A+B
```
- > `alias down=ssh userA:passA@hostA "service test stop" && shutdown`
  >> 楼上方法好. 直接写进 init.d 里网络情况和结果异常都没法处理.
- > Let me Google it for you 谷歌第一个链接是 https://opensource.com/life/16/11/running-commands-shutdown-linux 就提到了。runlevel 3 就是关机

如何更好的学习 shell 编程 https://www.v2ex.com/t/728172

rsync,scp 均遇到传输文件 size=0 的尴尬问题 https://www.v2ex.com/t/728073

Linux 怎么查询巨量文件的精确数量？ https://www.v2ex.com/t/721629
```console
linux 一个文件夹里有大概接近 2000 万个文件（没有子文件夹）。
使用 ls . | wc -l 这个命令执行查询数量会内存耗尽，有没有办法能精确查询文件数量呢？
```

请教 mkdir 权限问题 https://www.v2ex.com/t/720459
- >
  ```
  0777 (octal) == 511 (decimal)
  777 (decimal) == 1411 (octal)
  ```

请教，为什么 vim 的强制保存这么厉害？ https://www.v2ex.com/t/714451

DD 命令如何在后台运行? https://www.v2ex.com/t/713421
- > 因为 screen 命令的语法，末尾是 [cmd [args]]，无法接受“dd if.....” 这么复杂的语句
- > 你先 screen 一下，然后执行命令，不要直接 screen xxx 一次性执行
- > 开个 mosh，在里面运行试试呢
- > 把语句写到 bash 文件里，screen 运行 bash 文件
- > 用 tmux 。运行 dd 之后，Ctrl + B, d detach 。然后用 tmux a 就可以恢复
- > 不要用 dd，直接这样就可以：`ssh root@xx.xx.xx.xx "</dev/vda gzip >/mnt/data/win2012.img.gz &"`

Linux 如何显示文件夹拷贝或者移动的进度条 https://www.v2ex.com/t/712956
- > `rsync --info=progress2 source dest`
- > linux 的 gui 复制也都带进度条吧 <br> pv 和 rsync 都可以有进度条复制文件夹，你再查查
- > python 的 tqdm 模块可以实现，pip 安装之后直接就有二进制命令了。使用用法 help 一下就 ok 了
- > `rsync source dest | pv -lpes 文件数量` 这样？
- 自己查询补充的：
  * Rsync Show Progress Bar While Copying Files https://www.cyberciti.biz/faq/show-progress-during-file-transfer/
  * Showing total progress in rsync: is it possible? https://serverfault.com/questions/219013/showing-total-progress-in-rsync-is-it-possible
  * https://explainshell.com/explain?cmd=rsync+-axAXW+--info%3Dprogress2+%2Fmedia%2Fsource%2F+%2Fmedia%2Ftarget%2F

crontab 的 week 位置给定 */2 该如何理解？ https://www.v2ex.com/t/694438

求问 怎么让 Linux hung 住几分钟？ https://www.v2ex.com/t/694281

求问 Linux gdb 有什么命令可以直接把 memory dump 传递到打印机打印到纸上么？ https://www.v2ex.com/t/692088
- > 据我所知 gdb 支持 python/shell 扩展，楼主可以想一下怎么自己实现打印，贴一下我的部分配置：
  ```
  # pretty print qt type value
  # "Lekensteyn/qt5printers" github project needed be cloned into "~/.config/gdb/"
  python
  import sys, os.path
  sys.path.insert(0, os.path.expanduser('~/.config/gdb'))
  import qt5printers
  qt5printers.register_printers(gdb.current_objfile())
  end

  # hexdump specified memory block
  define hexdump
  dump memory /tmp/dump.bin $arg0 $arg0+$arg1
  shell hexdump -C /tmp/dump.bin
  end

  # alias for above hexdump
  define hd
  dump memory /tmp/dump.bin $arg0 $arg0+$arg1
  shell hexdump -C /tmp/dump.bin
  end
  ```
- > 如果是不想退出的话，可以参考 https://stackoverflow.com/questions/5941158/gdb-print-to-file-instead-of-stdout ，设置 gdb 把输出写进文件里，之后打印文件什么的应该就没啥困难的了
- > 还有个方法，shell 里执行 script，会把 shell 的所有输出输出到文件

求助一个 crontab 的时间的写法 https://www.v2ex.com/t/692249
- > https://crontab.guru/
- > crontab 好像只支持到分钟级的时间粒度。我推荐你另一个定时器：ofelia
- > 忘记上链接了： https://github.com/mcuadros/ofelia <br> ofelia 支持秒级时间粒度，以及丰富的 schedule 时间语法。但你不会 docker 的话，你可能需要花费点时间，研究怎么去安装他

Linux 可以不可以创建一个除了不叫 root 但是什么都和 root 一样的用户呢？ https://www.v2ex.com/t/691074

真的是无语！平时使用的一个测试机器，新招了个人使用了： sudo chmod -R 777 /usr/bin/ 这个命令，真的是秀 https://www.v2ex.com/t/690945
- > 貌似有个命令对你有帮助：getfacl
- > getfacl setfacl
- > 自己编译的还是放 /usr/local/bin 更佳，即便误操作影响也不大
- > 统一改 0755 是不行的，有些命令要 setuid/setgid

Linux 命令 crontab 使用疑问 https://www.v2ex.com/t/688596

Linux 命令 grep， awk 执行疑惑 https://www.v2ex.com/t/688275

Linux 下删点日志也能搞死人 https://www.v2ex.com/t/687093
```console
在 Linux 下，如何删除一个目录下的所有 log 文件？

目前为止只有一个应聘者能够给出完整的命令：
find -name \*.log -exec rm -f {} \;

我们有一台共享开发机，因为大家都懒得删 log，经常磁盘爆满，后来我们给它加了个 crontab：
0 4 * * * find /home/ -type f -name "*.log*" -size +100M -exec bash -c "echo -n > '{}'" \;
```

如何正确查看进程被 kill 的历史记录呢？ https://www.v2ex.com/t/686286
```console
linux 环境下，当内存不足时，系统好像会 kill 掉内存占用最高的进程，通过下面的命令可以查看到记录

dmesg -T | egrep -i -B100 'killed process'

问题来了，日志中只会显示进程名称，类似下面的。那么有没有什么参数可以显示出详细的信息呢？
比如 ps -f，这样可以知道执行文件的位置，命令的参数等....
```

Linux 如何恢复误 kill 的进程 https://www.v2ex.com/t/682646

同一磁盘使用 ln 创建硬链接提示 Invalid cross-device link? https://www.v2ex.com/t/679359

ssh 免密登陆问题，求大神支援，全网搜未碰到同款问题！ https://www.v2ex.com/t/675922
```console
目前三台服务器 246，249，250 三台机器，首先我 246 用 ssh-copy-id 的方法传公钥到 249 是成功免密登陆的，然后我用脚本
又试了一下，结果现在 246 ssh 无法连接 249，scp 无法传文件，报错也是没见过，全网搜无果，请求支援！看看谁有碰到过吗
``sh
[root@bjsaas .ssh]# ssh 10.230.64.249
ssh: connect to host 10.230.64.249 port 60: Connection refused
``
不知道这个 port60 连接拒绝是个什么情况，有人碰到过知道怎么解决吗?
```
- > less ~/.ssh/config 你指定的端口是 60 吧，估计主机监听的 22，所以报连接被拒绝
  >> 【楼主】对，我监听的是 22，指定的端口是 60，我没做过比如 ssh -p60 这样的指定端口操作，您知道这个指定端口可以在哪修改吗
- > 看下 /etc/ssh/ssh_config 里面是不是设了 port ？
- > 试试 ssh -p22 10.230.64.249 再看看服务器的日志
- > 首先 ssh -vvv 可以看到比较有用的 debug 信息，另外如果没有禁用密码可以用 'PreferredAuthentications=password', 'PubkeyAuthentication=no' 来密码登入看看 auth.log/secure 之类的对比查看问题出在哪里。 <br> 其次，按照你的说法我觉得你本地可能没有 ForwardAgent，所以你本地 → 246 可以连接，然后 246 再 ssh 到 249 就断了。
- > 在 246 上 修改配置文件 ~/.ssh/config 或者 /etc/ssh/ssh_config。Port 60 修改为 Port 22 或者注释掉

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
