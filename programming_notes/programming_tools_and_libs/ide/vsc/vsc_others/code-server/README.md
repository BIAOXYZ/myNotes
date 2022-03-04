
# code-server

code-server -- VS Code in the browser https://github.com/cdr/code-server/
- Install https://github.com/cdr/code-server/blob/main/docs/install.md 【`-->` 没有用仓库首页 README.md 里的一句脚本的安装方式，而是用了这个页面的安装方式。】【`-->` 后来发现用仓库首页那种一句脚本的安装方式也挺不错的。】
- issues：
  * How to exit from code-server #1257 https://github.com/cdr/code-server/issues/1257

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# code-server实战

## 1.Linux下基本部署

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

### 使用systemd使其自动启动

How To Set Up the code-server Cloud IDE Platform on Ubuntu 18.04 [Quickstart] https://www.digitalocean.com/community/tutorials/how-to-set-up-the-code-server-cloud-ide-platform-on-ubuntu-18-04-quickstart

在浏览器中优雅的使用VS Code https://juejin.cn/post/6915016226150285319

### 用定时任务解决：不知道什么原因会自动断掉，每次第二天来都得重新启动 code-server 的问题

```sh
$ mkdir crontabfiles/
$ cd crontabfiles/
$ 
$ crontab -l
no crontab for root
$ 
$ vi checkcodeserver
$ cat checkcodeserver
* * * * * export PASSWORD="2022" && nohup code-server --host 0.0.0.0 --port 9999 > /dev/null 2 >&1 &
$ 
$ crontab checkcodeserver
$ crontab -l
* * * * * export PASSWORD="2022" && nohup code-server --host 0.0.0.0 --port 9999 > /dev/null 2 >&1 &
```
>> 【[:star:][`*`]】 //notes：后来试了下即使自己手动 `kill -9` 杀掉已经启动的 `code-server` 进程，很快（这里 `crontab` 设置的是一分钟）就会自动拉起来，美滋滋～

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 2.容器化部署
>> //notes：总体来讲容器化的方式和直接用命令行的方式各有千秋吧：容器化方式不用担心远端 Linux 宿主机上的 code-server 服务端即使用了前面的 `nohup` 启动方式也会断掉（结果每次第二天来了还得重新再启动——这个问题我也不清楚什么原因，之前用 nohup 后台跑过别的程序，第二天也没见断掉。。。）的问题。但是容器化方式第一没命令行方式方便，***第二就算用 `-v` 挂载了宿主机上的代码仓库，如果不做特殊处理，在容器里的用户一般不能 git push 往远端推代码***。估计需要把证书/SSHkey之类的也挂载进去或者做一些别的设置才行。 <br> 实际用 docker 启动时使用的是下述语句，同时参考了官方和其他攻略：
```sh
cd ~/project_root_in_host_machine/
# 当然也可以把下面的 $PWD 换成项目仓库在宿主机的实际路径，这样就可以在任意的地方随时启动。
docker run -itd --name code-server-in-docker -p 0.0.0.0:9998:8080 \
  -v "$HOME/.config:/home/coder/.config" \
  -v "$PWD:/home/coder/project_root" \
  -u "$(id -u):$(id -g)" \
  -e "DOCKER_USER=$USER" \
  -e PASSWORD="<your_password>" \
  codercom/code-server:latest
```

Install -- Docker https://github.com/coder/code-server/blob/main/docs/install.md#docker
```sh
# This will start a code-server container and expose it at http://127.0.0.1:8080.
# It will also mount your current directory into the container as `/home/coder/project`
# and forward your UID/GID so that all file system operations occur as your user outside
# the container.
#
# Your $HOME/.config is mounted at $HOME/.config within the container to ensure you can
# easily access/modify your code-server config in $HOME/.config/code-server/config.json
# outside the container.
mkdir -p ~/.config
docker run -it --name code-server -p 127.0.0.1:8080:8080 \
  -v "$HOME/.config:/home/coder/.config" \
  -v "$PWD:/home/coder/project" \
  -u "$(id -u):$(id -g)" \
  -e "DOCKER_USER=$USER" \
  codercom/code-server:latest
```

使用Code Server容器部署VS Code Online - Binning的文章 - 知乎 https://zhuanlan.zhihu.com/p/403073128
- > **运行Code Server**
  * > Code Server是支持ssl证书的，参考其文档。因为我使用Code Server容器的话，所以直接在Docker运行配置中添加对应参数即可。运行命令如下：
    ```sh
    docker run -dit --cap-add SYS_PTRACE --name 命名运行的容器 -p 0.0.0.0:8100:8080 \
      -v /宿主机中的创建的home文件夹路径:/home/coder \
      -v /宿主机中证书路径/cert.pem:/容器中证书路径/cert.pem \
      -v /宿主机中公钥路径/key.pem:/容器中公钥路径/key.pem \
      -u "$(id -u):$(id -g)" \
      -e PASSWORD=设置的登录密码 \
      构建的镜像名字 --cert /容器中证书路径/cert.pem --cert-key /容器中公钥路径/key.pem
    ```
    + > `--cap-add SYS_PTRACE` 给容器添加权限（否则 `gdb` 会无法运行）
    + > `--name` 给运行容器命名（需要符合规范：英文字符1-英文字符2）
    + > `-p 0.0.0.0:8100:8080` `8100` 是服务器（宿主机）上的端口也是实际访问的端口，需要在防火墙中放开，自行修改；`8080` 是Code Server默认的运行端口不需要修改。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 补充
>> //notes：貌似 Eclipse Theia 也能达到类似的效果，回头再研究下了。
- 云端编辑器-Theia使用体验报告 - 我好无聊阿的文章 - 知乎 https://zhuanlan.zhihu.com/p/340662255

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
