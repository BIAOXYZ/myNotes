
# code-server

code-server -- VS Code in the browser https://github.com/cdr/code-server/
- Install https://github.com/cdr/code-server/blob/main/docs/install.md 【`-->` 没有用仓库首页 README.md 里的一句脚本的安装方式，而是用了这个页面的安装方式。】【`-->` 后来发现用仓库首页那种一句脚本的安装方式也挺不错的。】
- issues：
  * How to exit from code-server #1257 https://github.com/cdr/code-server/issues/1257

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# code-server实战

## 1

【[:star:][`*`]】 走通了以后，后续的使用还是很简单的。***而且亲测安装了 Python Extension 后可以在 Mac 的 Chrome 浏览器里直接单步调试远程 Linux 上的 Python 脚本***，美滋滋～PS：安装 Docker 插件后，远程 Linux 上的容器也能看见，并且也可以 “Attach Shell”，但是想完美连接一把（“Open in Browser”）的时候，提示 “No valid ports are available” —— ***我怀疑远程 Linux 上的容器如果对外暴露了端口，应该也可以在浏览器里直接连接***，无敌～
```sh
# 一句脚本安装 code-server
curl -fsSL https://code-server.dev/install.sh | sh

# 不怕在当前目录生成 nohup.out 文件时的版本
export PASSWORD="<your_password>" && nohup code-server --host 0.0.0.0 --port 9999 &
# 随时启动，不用担心会生成 nohup.out 文件的版本
export PASSWORD="<your_password>" && nohup code-server --host 0.0.0.0 --port 9999 >/dev/null 2>&1 &
```

>> //notes：这俩标题虽然一样，但是第二个比第一个有一点强：`nohup` 后会重定向到 `/dev/null`，其他的内容是第一个比第二个强（尤其是插件部分，感觉后期可能会有用），所以都记下了。
>>> 但是在实战过程中遇到了一个问题：我用普通用户直接执行，有权限问题；于是我在后面加了 `sudo`，完整语句是：`export PASSWORD="<your_password>" && sudo code-server --host 0.0.0.0 --port 9999`，结果发现**自定义密码**根本没有设置成功，所以虽然 Mac 上的浏览器里页面都出来了，但是还是无法访问远程 Linux 上的项目。。。
>>>> 于是按屏幕上打出的提示，试了试**当前用户**下的 `~/.config/code-server/config.yaml` 里的**随机密码**，也不行。后来才发现要用 **`root`用户** 下的 `~/.config/code-server/config.yaml` 里的**随机密码**才能正确连接。。。不过好在最终是走通了，虽然只是http，不是https，但暂时也不管了。
>>>>> 路上想了想，感觉应该是因为前半句 `export` 设置的是当前用户下的 `$PASSWORD`，但是为了解决权限问题后半句加了 `sudo`，等于后半句是 `root` 在执行了，那密码当然不对了。。。第二天又切换到 `root` 用户下试了试（后半句不带 `sudo` 版本的）这个命令：`export PASSWORD="<your_password>" && code-server --host 0.0.0.0 --port 9999`，结果果然可以用**自定义密码**连接了，证实了我的猜测。
>>>>>> 日哦，刚才用普通用户也可以直接执行 `export PASSWORD="<your_password>" && code-server --host 0.0.0.0 --port 9999` 并连接成功了，最开始遇到的权限问题没有了。。。坑爹啊- -

Ubuntu下部署code-server——浏览器里的vscode https://blog.csdn.net/qq_35356972/article/details/104819583
- > code-server的插件市场和vscode的插件市场是不共用的，所以有些vscode里面的插件在code-server里面可能无法找到，不过可以通过VSIX的形式进行安装。
- > 用上面的方法进行部署之后直接退出和服务器的连接是可行的，不过服务器上会始终运行一个终端，在阿里云里面通过网页上的远程连接方式连接之后如果断开连接终端是默认关掉的，这样终端中所运行的code-server服务也会随之消失，如果要使其成为后台运行的服务，需要使用 nohup 命令和命令末尾加 & 的方式来启动后台进程。
  ```sh
  export PASSWORD="你自己的密码" && nohup ./code-server --host 0.0.0.0 --port 80 &
  ```
- > 有时候code-server会莫名其妙的终止进程（笔者至今还没发现原因），所以只好搞了个定时检测进程的脚本，通过cron服务做定时检测，检测当前是否有目标进程，如果没有的话则启动相应进程。
- > 默认采用http协议连接，保密性不是很好，按照官方文档的描述，可以通过https进行连接，不过得先为服务器申请一个证书......

Ubuntu下部署code-server——浏览器里的vscode https://blog.csdn.net/qq_18156959/article/details/108770975
- > 整理后的命令如下：
  ```sh
  export PASSWORD="你自己的密码" && nohup ./code-server --host 0.0.0.0 --port 80 >/dev/null 2>&1 &
  ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
