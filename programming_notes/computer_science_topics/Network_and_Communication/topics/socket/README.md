
# Unix socket

What's the difference between Unix socket and TCP/IP socket? https://serverfault.com/questions/124517/whats-the-difference-between-unix-socket-and-tcp-ip-socket
```
A UNIX socket is an inter-process communication mechanism that allows bidirectional data exchange 
between processes running on the same machine.

IP sockets (especially TCP/IP sockets) are a mechanism allowing communication between processes 
over the network. In some cases, you can use TCP/IP sockets to talk with processes running on the 
same computer (by using the loopback interface).

UNIX domain sockets know that they’re executing on the same system, so they can avoid some 
checks and operations (like routing); which makes them faster and lighter than IP sockets. So if you 
plan to communicate with processes on the same host, this is a better option than IP sockets.

Edit: As per Nils Toedtmann's comment: UNIX domain sockets are subject to file system permissions, 
while TCP sockets can be controlled only on the packet filter level.
```

Unix domain socket 简介 https://www.cnblogs.com/sparkdev/p/8359028.html
- > Unix domain socket 又叫 IPC(inter-process communication 进程间通信) socket，用于实现同一主机上的进程间通信。socket 原本是为网络通讯设计的，但后来在 socket 的框架上发展出一种 IPC 机制，就是 UNIX domain socket。虽然网络 socket 也可用于同一台主机的进程间通讯(通过 loopback 地址 127.0.0.1)，但是 UNIX domain socket 用于 IPC 更有效率：不需要经过网络协议栈，不需要打包拆包、计算校验和、维护序号和应答等，只是将应用层数据从一个进程拷贝到另一个进程。这是因为，IPC 机制本质上是可靠的通讯，而网络协议是为不可靠的通讯设计的。

Unix Socket Tutorial https://www.tutorialspoint.com/unix_sockets/index.htm

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
