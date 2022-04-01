
# gdbgui远程容器调试实战

之前在 Mac 本地装了 `gdbgui`，因为 Mac 垃圾的 `gdb` 权限问题，导致没有走通；此外远端机器的 Linux 上倒是肯定能调试，但是没有图形界面。。。后来突发奇想：反正 `gdbgui` 也是基于浏览器的，并且支持远程模式，那干脆在远程把 `gdbgui` 跑起来，然后本地浏览器打开去调试。

关于“在远程把 `gdbgui` 跑起来”，有两种方式：一是在远端Linux机器上直接跑；二是在远端Linux机器上启动个容器，在容器里跑，只要注意把相应的端口暴露出去就行。

# 实战1：`gdbgui`运行在远端Linux上的容器里

准备一个开发调试用的容器：
```sh
docker run -itd --privileged -p 5000:5000 --name testremote testubuntu20.04:v1 bash
```

# 参考链接

Guides https://www.gdbgui.com/guides/
- > **Running Remotely**
  * > Because `gdbgui` is a server, it naturally allows you to debug programs running on other computers.
    + > ssh into the computer with the program that needs to be debugged.
    + > run `gdbgui -r` on the remote machine (this will serve publicly so beware of security here)
    + > on your local machine, open your browser and access the remote machine's ip and port
    + > debug the remote computer in your local browser
  + > Note that gnu also distrubutes a program called `gdbserver` which `gdbgui` is compatible with. See the relevant section in this doc.
  >> //notes：所以核心其实就是启动的时候多加个 `-r` 参数，说明是远程调试模式。
