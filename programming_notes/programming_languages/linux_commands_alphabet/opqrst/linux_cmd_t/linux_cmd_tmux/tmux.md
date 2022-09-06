
# 源头

# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

Tmux 使用教程 https://www.ruanyifeng.com/blog/2019/10/tmux.html

【[:star:][`*`]】 Linux终端复用神器-Tmux使用梳理 https://www.cnblogs.com/kevingrace/p/6496899.html
- > **需要注意的几点**
  * > 1）进入tmux面板后，一定要先按ctrl+b，然后松开，再按其他的组合键才生效。
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

Linux 终端复用神器 Tmux 使用详解，看完我飘了～ https://mp.weixin.qq.com/s/sc5XKrwrDh6RD1HCM1D1PQ
- 回复里的：
  * > 会 `ctrl-b d`，`tmux attach-session` 就得了，够用

# 个人实战

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
