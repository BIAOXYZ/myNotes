
# 相关命令

- `grep`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

linux命令详解：pgrep命令 https://www.cnblogs.com/Alight/p/4802414.html
```sh
pgrep通过匹配其程序名，找到匹配的进程

重要选项
    -l 同时显示进程名和PID
    -o 当匹配多个进程时，显示进程号最小的那个
    -n 当匹配多个进程时，显示进程号最大的那个
    注：进程号越大，并不一定意味着进程的启动时间越晚

使用说明
    查看指定名称的进程信息
    默认只显示PID
       1: [root@master ~]# pgrep ssh
       2: 3686
       3: 7907
       4: 8815
       5: 12874
    同时显示PID和ProcessName : –l
       1: [root@master ~]# pgrep -l sshd
       2: 3686 sshd
       3: 7907 sshd
       4: 8815 sshd
       5: 12874 sshd
    -o 当匹配多个进程时，显示进程号最小的那个
       1: [root@master ~]# pgrep -l sshd
       2: 3686 sshd
       3: 7907 sshd
       4: 8815 sshd
       5: 12874 sshd
       6: [root@master ~]# pgrep -l -o  sshd
       7: 3686 sshd
    -n 当匹配多个进程时，显示进程号最大的那个
       1: [root@master ~]# pgrep -l -n sshd
       2: 12874 sshd

特别说明
    1）pgrep相当于 ps –eo pid,cmd | awk ‘{print $1,$2}’ | grep KeyWord
       1: [root@master ~]# ps -eo pid,cmd | awk '{print $1,$2}'  | grep init
       2: 1 init
       3: [root@master ~]# pgrep init
       4: 1
    2）如1），pgrep查找的是程序名，不包括其参数
    如下，参数里包括要查找的参数，而程序名中不包括，所有没查找到。
       1: [root@master ~]# ps axu | grep name
       2: root     13298  0.0  0.3   5436  1000 pts/4    S    05:52   0:00 sh name.sh
       3: root     13313  0.0  0.2   4876   672 pts/4    R+   05:53   0:00 grep name
       4: [root@master ~]# pgrep name
       5: [root@master ~]# 

总结
    pgrep命令用来查找进程的信息，通常会和kill命令来连用，在指定条件下kill问题进程。
```
