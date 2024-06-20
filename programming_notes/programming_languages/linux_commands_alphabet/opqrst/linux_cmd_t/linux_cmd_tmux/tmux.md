
# 源头

# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

Tmux 使用教程 https://www.ruanyifeng.com/blog/2019/10/tmux.html

【[:star:][`*`]】 Linux终端复用神器-Tmux使用梳理 https://www.cnblogs.com/kevingrace/p/6496899.html
- > **需要注意的几点**
  * > 1）进入 `tmux` 面板后，一定要先按 `ctrl+b`，然后松开，再按其他的组合键才生效。
- > **tmux的常规运维命令**
  ```sh
  2）默认创建一个会话，以数字命名。（不推荐）
  [root@Centos6 ~]# tmux

  3）新建会话，比如新创建一个会话以"ccc"命名
  [root@Centos6 ~]# tmux new -s ccc
  加上参数-d，表示在后台新建会话
  root@bobo:~# tmux new -s shibo -d
  root@bobo:~# tmux ls
  shibo: 1 windows (created Tue Oct  2 19:22:32 2018) [135x35]

  5）登录一个已知会话。即从终端环境进入会话。
  第一个参数a也可以写成attach。后面的aaa是会话名称。
  [root@Centos6 ~]# tmux a -t aaa 

  6）退出会话不是关闭：
  登到某一个会话后，依次按键ctrl-b + d，这样就会退化该会话，但不会关闭会话。
  如果直接ctrl + d，就会在退出会话的通话也关闭了该会话！
  ```
- > **tmux的远程批量操作的shell脚本**
  * > 在使用SSH或telnet远程连接服务器时，可能都遇到为一些长时间运行的任务而头疼，比如系统备份、ftp 传输等等。通常情况下我们都是为每一个这样的任务开一个远程终端窗口，因为他们执行的时间太长了。必须等待它执行完毕，在此期间可不能关掉窗口或者断开连接，否则这个任务就会被杀掉，一切半途而废了。也许 `nohup` 命令可以达到这个目的，如果程序的标准输出/标准错误是终端，`nohup` 默认将其重定向到 `nohup.out` 文件。值得注意的是 `nohup` 命令只是使得程序忽略 `SIGHUP` 信号，还需要使用标记 `&` 把它放在后台运行。
    ```sh
    nohup <command> [argument…] &
    ```
  * > 虽然nohup很容易使用，但还是比较“简陋”的，对于简单的命令能够应付过来，对于复杂交互的程序就麻烦了。
  * > 使用 `tmux` 打开一个终端窗口，可以在窗口里执行一个长时间运行的交互式命令操作，令其一直在后台跑着，并且在按键 `ctrl-b + d` 后，可以无感知的退出窗口，而退出后窗口不会关闭，即窗口里执行的交互命令也不会结束。这比起传统的"`nohup command & （然后按ctrl+c）`"的方式要还用很多。
  * > 如何在linux终端里创建一个tmux窗口的同时直接在窗口终端里执行命令呢？这就需要用到 `tmux send -t session_name "command" ENTER` ！！！
  * > **示例一**
    ```sh
    root@bobo:~# tmux new -d -s kevin_session && tmux send -t kevin_session '/usr/local/bin/main' ENTER && tmux attach -t kevin_session
    [detached (from session kevin_session)]
       
    root@bobo:~# tmux ls
    kevin_session: 1 windows (created Tue Oct  2 19:38:36 2018) [135x34]
    ```
    > 上面的命令可以拆分为下面三个：
    ```sh
    root@bobo:~# tmux new -d -s kevin_session
    root@bobo:~# tmux send -t kevin_session '/usr/local/bin/main' ENTER
    root@bobo:~# tmux attach -t kevin_session
    ```
    >> //notes：用 `ping` 可以很简单的就试起来：`tmux new -d -s testping && tmux send -t testping 'ping www.qq.com' ENTER && tmux attach -t testping`
  * > **示例二**
    ```sh
    在创建窗口的同时，可以同时在窗口终端里连续执行两个或多个命令
    root@bobo:~# su - kevin -c "tmux new -d -s haha && tmux send -t haha 'ifconfig' ENTER && tmux send -t haha 'hostname' ENTER"
    kevin_session: 1 windows (created Tue Oct  2 19:38:36 2018) [135x34]
    root@bobo:~# su - kevin
    kevin@bobo:~$ tmux ls
    haha: 1 windows (created Tue Oct  2 19:48:12 2018) [135x34]
    kevin@bobo:~$ tmux a -t haha
       
    如下一个实例：
    在远程进行tmux的批量关闭和批量开启的shell脚本操作
       
    1) 批量关闭/opt/ip.list文件里ip所在机器的main二进制进程（这个main进程是在tmux执行的，一直交互执行的那种）
    [root@shell002 ~]# vim /opt/script/6_main_stop.sh
    #!/bin/bash
    for i in $(cat /opt/ip.list)
    do
    ssh -p22 root@$i 'ps -ef|grep main|grep -v grep|awk -F" " "{print $2}"|xargs kill -9 >/dev/null 2>&1'
    done
       
    2）批量开启/opt/ip/list文件里ip所在机器的tmux窗口里的main二进制进程（即先关闭tmux，再创建tmux窗口以及在里面执行main进程）
    [root@shell002 ~]# vim /opt/script/7_main_start.sh
    #!/bin/bash
    for i in $(cat /opt/ip.list)
    do
    ssh -p22 root@$i 'ps -ef|grep tmux|grep -v grep|awk -F" " "{print $2}"|xargs kill -9 >/dev/null 2>&1'
    ssh -p22 root@$i 'tmux new -d -s kevin_session && tmux send -t kevin_session '/usr/local/bin/main' ENTER'
    done
    ```

tmux常用命令与快捷键 https://www.jianshu.com/p/71999b35ead7
- > **修改tmux的组合键**
- > **session指的是按下tmux命令后 存在的连接便是session**
- > **window在session里，可以有N个window，并且window可以在不同的session里移动**
- > **pane在window里，可以有N个pane，并且pane可以在不同的window里移动、合并、拆分**

tmux常用命令 https://www.cnblogs.com/lizhang4/p/7325086.html

Linux 终端复用神器 Tmux 使用详解，看完我飘了～ https://mp.weixin.qq.com/s/sc5XKrwrDh6RD1HCM1D1PQ
- 回复里的：
  * > 会 `ctrl-b d`，`tmux attach-session` 就得了，够用

操作服务器的神奇工具Tmux https://www.cnblogs.com/bugs-in-life/p/16670718.html

## 已经运行的程序放入 tmux

把一个运行的进程放到 tmux 会话中 https://wgzhao.github.io/notes/tips/move-running-process-into-tmux/

Move a running process into a tmux session https://xai.sh/2020/10/16/Move-running-process-into-tmux-session.html

Migrate a running process into tmux https://words.yudocaa.in/blog/migrate-a-running-process-into-tmux/
- > Then type in the following command as root.
  ```sh
  % echo 0 > /proc/sys/kernel/yama/ptrace_scope
  ```

Transfer current command to a detachable session (tmux/screen) https://superuser.com/questions/623432/transfer-current-command-to-a-detachable-session-tmux-screen

# 相关问题

How do I rename a session in tmux? https://superuser.com/questions/428016/how-do-i-rename-a-session-in-tmux

# 个人实战

## `tmux`常用命令总结

| 命令说明                               | 命令                                    | 等价命令或备注                              |
|----------------------------------------|-----------------------------------------|---------------------------------------------|
| 查看所有 session                       | `tmux ls`                                |                                             |
| 创建匿名 session                       | `tmux`                                   | 等价于： `tmux new`                            |
| 创建匿名 session 且放到后台              | `tmux new -d`                            |                                               |
| 创建自定义名字的 session                 | `tmux new -s <your_session_name>`       | 等价于：`tmux new-session -s <your_session_name>` |
| 创建自定义名字的 session 且放到后台       | `tmux new -s <your_session_name> -d`     |                                             |
| **创建自定义名字、且执行某命令的 session 且放到后台** | `tmux new -d -s <your_session_name> "<your_command>"` | **这个是最核心功能，替代 nohup 就是因为这个（但是其实最简单的做法还是分两步走：第一步先新建一个 session，第二步进入这个 session 去执行你的命令）** |
| 进入 session                           | `tmux a -t <your_session_name>`         | 等价于：`tmux attach -t <your_session_name>` 或 `tmux attach-session -t <your_session_name>` |
| 进入 session （**无参数，此时会 attach 上次进入的那个 session**） | `tmux a` （or `tmux attach`） | **这样的行为使得在大多数情况下，你可以简单地运行 `tmux attach`，而不必记住会话的名称或 ID。这在频繁地切换会话时非常方便。** |
| 【在 session 内操作】退出 session（方法1） | `ctrl-b d` （如果直接 `ctrl d` 就退出并结束 session 了） | 先同时按下 CTRL 和 b，然后同时放开，并在放开的一瞬间快速按一下 d |
| 【在 session 内操作】退出 session（方法2） | `tmux det` （or `tmux detach`）          | 比较推荐方法2，因为方法1同时按 CTRL 和 b 然后再按 d 其实容易操作失败 <br> ***但是如果是某些特殊情形，比如终端一直在不停打印，不好输入 `tmux det`，那还是方法1吧***。。。 |
| 结束所有 session                      | `tmux kill-server`                         |                                             |
| 结束某个 session                      | `tmux kill-session -t <your_session_name>` |                                             |
|====================|====================|====================|
| **切换 session**                       | `tmux swi -t <your_session_name>` | 等价于：`tmux switch -t <your_session_name>`         |
| 重命名某个 session                      | `tmux rename -t <old_session_name> <new_session_name>` | 等价于：`tmux rename-session -t <old_session_name> <new_session_name>` |

## `tmux`常用命令具体实战

**创建session：**
```sh
$ tmux ls
no server running on /tmp/tmux-1001/default

# 创建自定义名字的 session
$ tmux new -s ccc
[detached (from session ccc)]
$ tmux ls
ccc: 1 windows (created Tue Jun 11 15:47:21 2024) [254x56]

# 创建匿名 session
$ tmux
[detached (from session 1)]
$ tmux ls
1: 1 windows (created Tue Jun 11 15:49:14 2024) [254x56]
ccc: 1 windows (created Tue Jun 11 15:47:21 2024) [254x56]
$ tmux
[detached (from session 2)]
$ tmux ls
1: 1 windows (created Tue Jun 11 15:49:14 2024) [254x56]
2: 1 windows (created Tue Jun 11 15:49:33 2024) [254x56]
ccc: 1 windows (created Tue Jun 11 15:47:21 2024) [254x56]
```

**<ins>`tmux` 能替换 `nohup` 的原因</ins>：**
```sh
# 创建一个执行 ping 命令的 session 并放到后台
$ tmux new -d -s myping "ping www.qq.com"
$ tmux ls
myping: 1 windows (created Wed Jun 12 02:28:53 2024) [80x24]
$
# attach 进去看看
$ tmux attach
[detached (from session myping)]
$

# 注意这是在 myping 这个 session 里了
64 bytes from 42.81.179.153 (42.81.179.153): icmp_seq=490 ttl=51 time=4.27 ms
64 bytes from 42.81.179.153 (42.81.179.153): icmp_seq=491 ttl=51 time=4.30 ms
64 bytes from 42.81.179.153 (42.81.179.153): icmp_seq=492 ttl=51 time=4.28 ms
64 bytes from 42.81.179.153 (42.81.179.153): icmp_seq=493 ttl=51 time=4.28 ms
64 bytes from 42.81.179.153 (42.81.179.153): icmp_seq=494 ttl=51 time=4.31 ms
64 bytes from 42.81.179.153 (42.81.179.153): icmp_seq=495 ttl=51 time=4.26 ms
...
...
# 退出 myping 这个 session
`ctrl-b d`

$ tmux ls
myping: 1 windows (created Wed Jun 12 02:28:53 2024) [254x56]
```

```sh
# TODO:把已经运行起来的程序放到 tmux 里
```

**结束 session：**
```sh
# 一键结束所有 session
$ tmux ls
1: 1 windows (created Tue Jun 11 15:49:14 2024) [254x56]
2: 1 windows (created Tue Jun 11 15:49:33 2024) [254x56]
3: 1 windows (created Tue Jun 11 15:49:44 2024) [254x56]
ccc: 1 windows (created Tue Jun 11 15:47:21 2024) [254x56]
$ tmux kill-server
$ tmux ls
no server running on /tmp/tmux-1001/default
```

```sh
# 准备三个 session
$ tmux
$ tmux new -s ccc -d
$ tmux
$ tmux ls
0: 1 windows (created Wed Jun 12 01:03:03 2024) [254x56]
2: 1 windows (created Wed Jun 12 01:04:33 2024) [254x56]
ccc: 1 windows (created Wed Jun 12 01:03:33 2024) [80x24]

# 根据数字名字杀掉 session 0
$ tmux kill-session -t 0
$ tmux ls
2: 1 windows (created Wed Jun 12 01:04:33 2024) [254x56]
ccc: 1 windows (created Wed Jun 12 01:03:33 2024) [80x24]
# 根据自定义名字杀掉 session
$ tmux kill-session -t ccc
$ tmux ls
2: 1 windows (created Wed Jun 12 01:04:33 2024) [254x56]
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
