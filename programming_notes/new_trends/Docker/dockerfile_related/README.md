
# general

Best practices for writing Dockerfiles https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
- > **RUN**
  * > Always combine `RUN apt-get update` with `apt-get install` in the same `RUN` statement. For example:
    ```dockerfile
    RUN apt-get update && apt-get install -y \
        package-bar \
        package-baz \
        package-foo  \
        && rm -rf /var/lib/apt/lists/*
    ```
- > **ENTRYPOINT**
  * > For example, the [Postgres Official Image](https://hub.docker.com/_/postgres/) uses the following script as its ENTRYPOINT:
- > **WORKDIR**
  * > For clarity and reliability, you should always use absolute paths for your `WORKDIR`. Also, you should ***use `WORKDIR` instead of proliferating instructions like `RUN cd … && do-something`***, which are hard to read, troubleshoot, and maintain.

附录四：Dockerfile 最佳实践 https://yeasy.gitbook.io/docker_practice/appendix/best_practices

你确定你会写 Dockerfile 吗？ - 云原生实验室的文章 - 知乎 https://zhuanlan.zhihu.com/p/72970159

Docker(三)：Dockerfile 命令详解 - 纯洁的微笑的文章 - 知乎 https://zhuanlan.zhihu.com/p/34688396

RUN vs CMD vs ENTRYPOINT - 每天5分钟玩转 Docker 容器技术（17） https://www.cnblogs.com/CloudMan6/p/6875834.html
- >
   ```console
    简单的说：
    RUN 执行命令并创建新的镜像层，RUN 经常用于安装软件包。
    CMD 设置容器启动后默认执行的命令及其参数，但 CMD 能够被 docker run 后面跟的命令行参数替换。
    ENTRYPOINT 配置容器启动时运行的命令。
    ```
- > RUN 指令通常用于安装应用和软件包。RUN 在当前镜像的顶部执行命令，并通过创建新的镜像层。Dockerfile 中常常包含多个 RUN 指令。
- > ***注意：apt-get update 和 apt-get install 被放在一个 RUN 指令中执行，这样能够保证每次安装的是最新的包。如果 apt-get install 在单独的 RUN 中执行，则会使用 apt-get update 创建的镜像层，而这一层可能是很久以前缓存的***。
- > CMD 指令允许用户指定容器的默认执行的命令。此命令会在容器启动且 docker run 没有指定其他命令时运行。
- > ENTRYPOINT 看上去与 CMD 很像，它们都可以指定要执行的命令及其参数。不同的地方在于 ENTRYPOINT 不会被忽略，一定会被执行，即使运行 docker run 时指定了其他命令。
- > 在为 ENTRYPOINT 选择格式时必须小心，因为这两种格式的效果差别很大。
- > ENTRYPOINT 的 Exec 格式用于设置要执行的命令及其参数，同时可通过 CMD 提供额外的参数。ENTRYPOINT 中的参数始终会被使用，而 CMD 的额外参数可以在容器启动时动态替换掉。
- > ENTRYPOINT 的 Shell 格式会忽略任何 CMD 或 docker run 提供的参数。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `COPY` v.s. `ADD` 

Dockerfile 中的 COPY 与 ADD 命令 https://www.cnblogs.com/sparkdev/p/9573248.html 【From `sparkdev`】
- > **Build 上下文的概念**
  * > 在使用 `docker build` 命令通过 Dockerfile 创建镜像时，会产生一个 build 上下文(context)。***所谓的 build 上下文就是 docker build 命令的 PATH 或 URL 指定的路径中的文件的集合***。在镜像 build 过程中可以引用上下文中的任何文件，比如我们要介绍的 `COPY` 和 `ADD` 命令，就可以引用上下文中的文件。
  * > 默认情况下 `docker build -t testx .` 命令中的 `.` 表示 build 上下文为当前目录。当然我们可以指定一个目录作为上下文，比如下面的命令：
    ```sh
    $ docker build -t testx /home/nick/hc
    ```
    > 我们指定 `/home/nick/hc` 目录为 build 上下文，默认情况下 docker 会使用在上下文的根目录下找到的 `Dockerfile` 文件。
- > **`COPY` 和 `ADD` 命令不能拷贝上下文之外的本地文件**
  * > 对于 `COPY` 和 `ADD` 命令来说，如果要把本地的文件拷贝到镜像中，那么本地的文件必须是在上下文目录中的文件。其实这一点很好解释，***因为在执行 build 命令时，docker 客户端会把上下文中的所有文件发送给 docker daemon***。考虑 docker 客户端和 docker daemon 不在同一台机器上的情况，build 命令只能从上下文中获取文件。如果我们在 Dockerfile 的 `COPY` 和 `ADD` 命令中引用了上下文中没有的文件，就会收到类似下面的错误：
- > **与 `WORKDIR` 协同工作**
  * > WORKDIR 命令为后续的 RUN、CMD、COPY、ADD 等命令配置工作目录。在设置了 WORKDIR 命令后，接下来的 COPY 和 ADD 命令中的相对路径就是相对于 WORKDIR 指定的路径。比如我们在 Dockerfile 中添加下面的命令：
    ```dockerfile
    WORKDIR /app
    COPY checkredis.py .
    ```
  * > 然后构建名称为 testx 的容器镜像，并运行一个容器查看文件路径：`checkredis.py` 文件就是被复制到了 `WORKDIR /app` 目录下。
- > **COPY 命令的简单性**
  * > 对于目录而言，`COPY` 和 `ADD` 命令具有相同的特点：**只复制目录中的内容而不包含目录自身**。
  * > COPY 命令区别于 ADD 命令的一个用法是在 multistage 场景下。关于 multistage 的介绍和用法请参考笔者的《Dockerfile 中的 multi-stage》一文。在 multistage 的用法中，可以使用 COPY 命令把前一阶段构建的产物拷贝到另一个镜像中，比如：
- > **ADD 命令还可以干其它事情**
  * > 除了不能用在 multistage 的场景下，ADD 命令可以完成 COPY 命令的所有功能，并且还可以完成两类超酷的功能：
    + > 解压压缩文件并把它们添加到镜像中
    + > 从 url 拷贝文件到镜像中

What is the difference between the 'COPY' and 'ADD' commands in a Dockerfile? https://stackoverflow.com/questions/24958140/what-is-the-difference-between-the-copy-and-add-commands-in-a-dockerfile

# `CMD` v.s. `ENTRYPOINT`

Dockerfile: ENTRYPOINT和CMD的区别 - dongmao zhang的文章 - 知乎 https://zhuanlan.zhihu.com/p/30555962
- > 和CMD类似, 默认的ENTRYPOINT也在docker run时, 也可以被覆盖. 在运行时, 用 `--entrypoint` 覆盖默认的ENTRYPOINT

Dockerfile RUN，CMD，ENTRYPOINT命令区别 https://www.jianshu.com/p/f0a0f6a43907
- > Dockerfile中RUN，CMD和ENTRYPOINT都能够用于执行命令，下面是三者的主要用途：
  * > `RUN` 命令执行命令并创建新的镜像层，通常用于安装软件包
  * > `CMD` 命令设置容器启动后默认执行的命令及其参数，但CMD设置的命令能够被 docker run 命令后面的命令行参数替换
  * > `ENTRYPOINT` 配置容器启动时的执行命令（不会被忽略，一定会被执行，即使运行 docker run 时指定了其他命令）

Difference between RUN vs CMD vs ENTRYPOINT Docker Commands https://www.geeksforgeeks.org/difference-between-run-vs-cmd-vs-entrypoint-docker-commands/
```sh
$ cat dockerfile 
FROM ubuntu
ENTRYPOINT ["echo", "Geeksforgeeks "]
CMD ["Docker Tutorials"]
$ 
$ docker build -t image .
Sending build context to Docker daemon  2.048kB
Step 1/3 : FROM ubuntu
latest: Pulling from library/ubuntu
7b1a6ab2e44d: Pull complete 
Digest: sha256:626ffe58f6e7566e00254b638eb7e0f3b11d4da9675088f4781a50ae288f3322
Status: Downloaded newer image for ubuntu:latest
 ---> ba6acccedd29
Step 2/3 : ENTRYPOINT ["echo", "Geeksforgeeks "]
 ---> Running in ead86017ffb4
Removing intermediate container ead86017ffb4
 ---> cb5e607a52d5
Step 3/3 : CMD ["Docker Tutorials"]
 ---> Running in 4228c9cb68d6
Removing intermediate container 4228c9cb68d6
 ---> 0ae1fc7b79fc
Successfully built 0ae1fc7b79fc
Successfully tagged image:latest
$ 
$ docker run -it image
Geeksforgeeks  Docker Tutorials
$ 
$ docker run -it image bash
Geeksforgeeks  bash
$
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Dockerfile【old articles】

Docker中镜像构建文件Dockerfile与相关命令的详细介绍 https://www.jb51.net/article/105333.htm
> docker build命令会根据Dockerfile文件及上下文构建新Docker镜像。构建上下文是指Dockerfile所在的本地路径或一个URL（Git仓库地址）。构建上下文环境会被递归处理，所以，构建所指定的路径还包括了子目录，而URL还包括了其中指定的子模块。

Docker(二)：Dockerfile 使用介绍 http://ityouknow.com/docker/2018/03/12/docker-use-dockerfile.html

### CMD, RUN, ENTRYPOING

Dockerfile里指定执行命令用ENTRYPOING和用CMD有何不同？ https://segmentfault.com/q/1010000000417103
```
RUN是在Build时运行的，先于CMD和ENTRYPOINT。Build完成了，RUN也运行完成后，再运行CMD或者ENTRYPOINT。

ENTRYPOINT和CMD的不同点在于执行docker run时参数传递方式，CMD指定的命令可以被docker run传递的命令覆盖
...
...
而ENTRYPOINT会把容器名后面的所有内容都当成参数传递给其指定的命令（不会对命令覆盖）
...
...
```

Docker RUN vs CMD vs ENTRYPOINT https://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/

「Allen 谈 Docker 系列」docker build 的 cache 机制 http://dockone.io/article/674

***第二批***：
- 【[:star:][`*`]】 Dockerfile编写注意事项 https://www.cnblogs.com/bigberg/p/9001584.html
- 【[:star:][`*`]】 DOCKERFILE注意事项 https://www.cnblogs.com/styshoo/p/6431748.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 问题

How to make builder RUN use /bin/bash instead of /bin/sh #7281 https://github.com/moby/moby/issues/7281
- https://github.com/moby/moby/issues/7281#issuecomment-389440503

How to use sudo inside a docker container? https://stackoverflow.com/questions/25845538/how-to-use-sudo-inside-a-docker-container
- https://stackoverflow.com/questions/25845538/how-to-use-sudo-inside-a-docker-container/25908200#25908200
  * > Just got it. As regan pointed out, I had to add the user to the sudoers group. But the main reason was I'd forgotten to update the repositories cache, so apt-get couldn't find the sudo package. It's working now. Here's the completed code:
    ```dockerfile
    FROM ubuntu:12.04
    
    RUN apt-get update && \
          apt-get -y install sudo
    
    RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
    
    USER docker
    CMD /bin/bash
    ```
