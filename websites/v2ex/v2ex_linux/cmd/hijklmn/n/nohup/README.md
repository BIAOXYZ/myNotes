
如何比较方便的杀死 nohup 起的进程及其所有子进程? https://www.v2ex.com/t/802716

Linux 执行一段 shell 命令加与不加 nohup 到底有什么区别？ https://www.v2ex.com/t/802649
- > 退出终端后，你之前那个终端派生的进程都变成了孤儿进程，会响应系统的 SIGHUP 信号把进程挂掉，nohup 干的就是无视这个信号和重定向输出。你跑的那个 java 如果自己实现了 daemon 就不受影响了啊
