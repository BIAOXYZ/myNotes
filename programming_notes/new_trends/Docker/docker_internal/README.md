# docker源码和底层原理

Docker 核心技术与实现原理 https://draveness.me/docker
- > Linux 的命名空间机制提供了以下七种不同的命名空间，包括 `CLONE_NEWCGROUP`、`CLONE_NEWIPC`、`CLONE_NEWNET`、`CLONE_NEWNS`、`CLONE_NEWPID`、`CLONE_NEWUSER` 和 `CLONE_NEWUTS`，通过这七个选项我们能在创建新的进程时设置新进程应该在哪些资源上与宿主机器进行隔离。
- > 当前机器上有很多的进程正在执行，在上述进程中有两个非常特殊，一个是 `pid` 为 1 的 `/sbin/init` 进程，另一个是 `pid` 为 2 的 `kthreadd` 进程，这两个进程都是被 Linux 中的上帝进程 `idle` 创建出来的，其中前者负责执行内核的一部分初始化工作和系统配置，也会创建一些类似 `getty` 的注册进程，而后者负责管理和调度其他的内核进程。
- > 每一个使用 docker run 启动的容器其实都具有单独的网络命名空间，Docker 为我们提供了四种不同的网络模式，`Host`、`Container`、`None` 和 `Bridge` 模式。

## OverlayFS

【[`*`][:star:]】：
- 深入理解overlayfs（一）：初识 https://blog.csdn.net/luckyapple1028/article/details/77916194
- 深入理解overlayfs（二）：使用与原理分析 https://blog.csdn.net/luckyapple1028/article/details/78075358

【Docker 基础知识】存储驱动overlay和overlay2 https://blog.csdn.net/zhonglinzhang/article/details/80970411

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `/var/run/docker.sock`

关于/var/run/docker.sock https://www.jianshu.com/p/6c3fdb0e9cb5
> 运行过Docker Hub的Docker镜像的话，会发现其中一些容器时需要挂载/var/run/docker.sock文件。这个文件是什么呢？为什么有些容器需要使用它？简单地说，它是Docker守护进程(Docker daemon)默认监听的Unix域套接字(Unix domain socket)，容器中的进程可以通过它与Docker守护进程进行通信。

How To Run Docker in Docker Container [3 Easy Methods] https://devopscube.com/run-docker-in-docker/
- > There are three ways to achieve docker in docker
  * > Run docker by mounting docker.sock (DooD Method)
  * > dind method
  * > Using Nestybox sysbox Docker runtime
- > **Method 1: Docker in Docker Using [`/var/run/docker.sock`]**
  * > `/var/run/docker.sock` is the default Unix socket. ***<ins>Sockets are meant for communication between processes on the same host</ins>***. Docker daemon by default listens to `docker.sock`. If you are on the same host where Docker daemon is running, you can use the `/var/run/docker.sock` to manage containers.
  * > For example, if you run the following command, it would return the version of docker engine.
    ```sh
    curl --unix-socket /var/run/docker.sock http://localhost/version
    ```
  * > Now that you have a bit of understanding of what is `docker.sock`, let’s see how to run docker in docker using `docker.sock`
  * > To run docker inside docker, all you have to do is ***just run docker with the default Unix socket `docker.sock` as a volume***. For example,
    ```sh
    docker run -v /var/run/docker.sock:/var/run/docker.sock -ti docker
    ```
    > **Just a word of caution**: If your container gets access to `docker.sock`, it means it has more privileges over your docker daemon. So when used in real projects, understand the security risks, and use it.
  * > Now, from within the container, you should be able to execute docker commands for building and pushing images to the registry.
  * > Here, the actual docker operations happen ***on the VM host*** running your base docker container ***rather than from within the container***. Meaning, even though you are executing the docker commands from within the container, you are instructing the docker client to connect to the VM host docker-engine through `docker.sock`
  * > To test his setup, use the official docker image from the docker hub. It has docker the docker binary in it. <br> Follow the steps given below to test the setup.
  * > **Step 1**: Start Docker container in interactive mode mounting the `docker.sock` as volume. We will use the official docker image.
    ```sh
    docker run -v /var/run/docker.sock:/var/run/docker.sock -ti docker
    ```
  * > **Step 2**: Once you are inside the container, execute the following docker command.
    ```sh
    docker pull ubuntu
    ```
  * > **Step 3**: When you list the docker images, you should see the ubuntu image along with other docker images in your host VM.
    ```sh
    docker images
    ```
  * > **Step 4**: Now create a Dockerfile inside test directory.
    ```sh
    mkdir test && cd test
    vi Dockerfile
    ```
    > Copy the following Dockerfile contents to test the image build from within the container.
    ```Dockerfile
    FROM ubuntu:18.04
    LABEL maintainer="Bibin Wilson <bibinwilsonn@gmail.com>"
    RUN apt-get update && \
        apt-get -qy full-upgrade && \
        apt-get install -qy curl && \
        apt-get install -qy curl && \
        curl -sSL https://get.docker.com/ | sh
    ```
    > Build the Dockerfile
    ```sh
    docker build -t test-image .
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

Allen 谈 Docker 系列 http://guide.daocloud.io/dcs/allen-docker-9153965.html

----------------------------------------------------------------------------------------------------

【From liumiaocn】 深入浅出Docker https://blog.csdn.net/liumiaocn/column/info/dockerheadfirst
- docker基础:从chroot理解namespace的隔离 https://blog.csdn.net/liumiaocn/article/details/52388793
- Docker基础: Linux内核命名空间之（6）user namespace https://blog.csdn.net/liumiaocn/article/details/52549978

----------------------------------------------------------------------------------------------------

https://segmentfault.com/u/wuyangchun/articles 【这哥们linux也写了不少东西】
- 走进docker(05)：docker在本地如何管理image（镜像）? https://segmentfault.com/a/1190000009730986

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
