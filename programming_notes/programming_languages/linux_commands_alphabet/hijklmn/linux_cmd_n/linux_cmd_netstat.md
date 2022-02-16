
# 相关命令

- `ss`
- `lsof`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

Linux netstat命令详解 https://www.cnblogs.com/ggjucheng/archive/2012/01/08/2316661.html

netstat 的10个基本用法 https://linux.cn/article-2434-1.html

Linux netstat命令详解 https://www.cnblogs.com/ftl1012/p/netstat.html

Find (and kill) process locking port 3000 on Mac [closed] https://stackoverflow.com/questions/3855127/find-and-kill-process-locking-port-3000-on-mac
- https://stackoverflow.com/questions/3855127/find-and-kill-process-locking-port-3000-on-mac/3855359#3855359
  * > You can try `netstat`
    ```sh
    netstat -vanp tcp | grep 3000
    ```
  * > For macOS El Capitan and newer (or if your `netstat` doesn't support `-p`), use `lsof`
    ```sh
    lsof -i tcp:3000
    ```
  * > For Centos 7 use:
    ```sh
    netstat -vanp --tcp | grep 3000
    ```
  * 回复里的：
    + > The "terse" flag to lsof produces output suitable for piping to a subsequent kill: `lsof -t -i tcp:1234 | xargs kill`
    + > I have put this into my `~/.bash_profile`: `findandkill() {  port=$(lsof -n -i4TCP:$1 | grep LISTEN | awk '{ print $2 }')  kill -9 $port } alias killport=findandkill`. So now I just have to type `killport 8080` and it saves me some seconds.
    + > Another tip is to add `-P` to the `lsof` command so that the raw port is visible in the output: `lsof -P -i:3000`
    + > My bashprofile function is based on the above suggestions but simplified: `killport() { lsof -t -i tcp:$1 | xargs kill -9 }` Usage: `killport 5000`

# 个人实战
