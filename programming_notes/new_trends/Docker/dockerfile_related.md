
# general

Best practices for writing Dockerfiles https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

附录四：Dockerfile 最佳实践 https://yeasy.gitbook.io/docker_practice/appendix/best_practices

你确定你会写 Dockerfile 吗？ - 云原生实验室的文章 - 知乎 https://zhuanlan.zhihu.com/p/72970159

Docker(三)：Dockerfile 命令详解 - 纯洁的微笑的文章 - 知乎 https://zhuanlan.zhihu.com/p/34688396

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
