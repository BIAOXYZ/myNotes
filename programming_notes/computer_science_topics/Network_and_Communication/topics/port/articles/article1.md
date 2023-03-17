
# 1

一个端口号可以同时被两个进程绑定吗？ - 一口Linux的文章 - 知乎 https://zhuanlan.zhihu.com/p/280672302

多个程序监听同一端口 - socket端口复用技术 https://www.jianshu.com/p/ce277812eca2

如何多个进程监听同一个端口 https://blog.csdn.net/L13763338360/article/details/106519027
- > 2.方案一：fork
  * > 只要在绑定端口号（bind函数）之后，监听端口号之前（listen函数），用fork（）函数生成子进程，这样子进程就可以克隆父进程，达到监听同一个端口的目的，而且还相互竞争，提高程序效率。
  * > 这里要注意的是，TCP三次握手创建连接是不需要服务进程参数的，而服务进程仅仅要做的事调用accept将已建立的连接构建对应的连接套接字connfd
    ```console
    bind()
    fork()
    listen()
    ```
