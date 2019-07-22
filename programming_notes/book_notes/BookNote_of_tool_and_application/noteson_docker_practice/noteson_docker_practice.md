
# 书籍/项目链接

- docker_practice https://github.com/yeasy/docker_practice
- Docker — 从入门到实践 https://legacy.gitbook.com/book/yeasy/docker_practice/details
- Docker — 从入门到实践 https://docker_practice.gitee.io/
- Docker — 从入门到实战 https://www.bookstack.cn/books/docker-practice

(注: 笔记使用本书的1.0.0版本)

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` Docker简介

## `##` [什么是Docker](https://yeasy.gitbooks.io/docker_practice/content/introduction/what.html)

这一页有很多概念，虽然链接大都是wikipedia，但是后续要认真看看。目前大部分都是懂个概念，知道点历史，但是不知道深入的细节，尤其是代码级的细节。
- cgroup, Linux namespace
- AUFS, Union FS
- 操作系统层面的虚拟化技术
- LXC, libcontainer, runC, containerd

## `##` ~[为什么要使用 Docker？](https://yeasy.gitbooks.io/docker_practice/content/introduction/why.html)~

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` 基本概念

## `##` [镜像](https://yeasy.gitbooks.io/docker_practice/content/basic_concept/image.html)

> 我们都知道，操作系统分为内核和用户空间。对于 Linux 而言，内核启动后，会挂载 root 文件系统为其提供用户空间支持。而 Docker 镜像（Image），就相当于是一个 root 文件系统。比如官方镜像 ubuntu:18.04 就包含了完整的一套 Ubuntu 18.04 最小系统的 root 文件系统。

### 分层存储

> 因为镜像包含操作系统完整的 root 文件系统，其体积往往是庞大的，因此在 Docker 设计时，就充分利用 Union FS 的技术，将其设计为分层存储的架构。所以严格来说，镜像并非是像一个 ISO 那样的打包文件，镜像只是一个虚拟的概念，其实际体现并非由一个文件组成，而是由一组文件系统组成，或者说，由多层文件系统联合组成。
>
> 镜像构建时，会一层层构建，前一层是后一层的基础。每一层构建完就不会再发生改变，后一层上的任何改变只发生在自己这一层。比如，删除前一层文件的操作，实际不是真的删除前一层的文件，而是仅在当前层标记为该文件已删除。在最终容器运行的时候，虽然不会看到这个文件，但是实际上该文件会一直跟随镜像。因此，在构建镜像的时候，需要额外小心，每一层尽量只包含该层需要添加的东西，任何额外的东西应该在该层构建结束前清理掉。

## `##` [容器](https://yeasy.gitbooks.io/docker_practice/content/basic_concept/container.html)

//全页内容。。。
> 镜像（`Image`）和容器（`Container`）的关系，就像是面向对象程序设计中的 `类` 和 `实例` 一样，镜像是静态的定义，容器是镜像运行时的实体。容器可以被创建、启动、停止、删除、暂停等。
>
> 容器的实质是进程，但与直接在宿主执行的进程不同，容器进程运行于属于自己的独立的 命名空间。因此容器可以拥有自己的 `root` 文件系统、自己的网络配置、自己的进程空间，甚至自己的用户 ID 空间。容器内的进程是运行在一个隔离的环境里，使用起来，就好像是在一个独立于宿主的系统下操作一样。这种特性使得容器封装的应用比直接在宿主运行更加安全。也因为这种隔离的特性，很多人初学 Docker 时常常会混淆容器和虚拟机。
>
> 前面讲过镜像使用的是分层存储，容器也是如此。每一个容器运行时，是以镜像为基础层，在其上创建一个当前容器的存储层，我们可以称这个为容器运行时读写而准备的存储层为 **容器存储层**。
>
>容器存储层的生存周期和容器一样，容器消亡时，容器存储层也随之消亡。因此，任何保存于容器存储层的信息都会随容器删除而丢失。
>
> 按照 Docker 最佳实践的要求，容器不应该向其存储层内写入任何数据，容器存储层要保持无状态化。所有的文件写入操作，都应该使用 数据卷（Volume）、或者绑定宿主目录，在这些位置的读写会跳过容器存储层，直接对宿主（或网络存储）发生读写，其性能和稳定性更高。
>
> 数据卷的生存周期独立于容器，容器消亡，数据卷不会消亡。因此，使用数据卷后，容器删除或者重新运行之后，数据却不会丢失。

## `##` [仓库(Docker Registry)](https://yeasy.gitbooks.io/docker_practice/content/basic_concept/repository.html)

这一页主要是有个（第一次接触时）容易混淆的概念：`Registry`和`Repository`。实际上，`Registry`才是真正的“**仓库**”，`Repository`更像是该仓库的一个个“**储藏室**”。

> 一个 **Docker Registry** 中可以包含多个 **仓库**（`Repository`）；每个仓库可以包含多个 **标签**（`Tag`）；每个标签对应一个镜像。
>
> 通常，一个仓库会包含同一个软件不同版本的镜像，而标签就常用于对应该软件的各个版本。我们可以通过 `<仓库名>:<标签>` 的格式来指定具体是这个软件哪个版本的镜像。如果不给出标签，将以 `latest` 作为默认标签。
>
> 以 Ubuntu 镜像 为例，ubuntu 是仓库的名字，其内包含有不同的版本标签，如，`16.04`, `18.04`。我们可以通过 `ubuntu:16.04`，或者 `ubuntu:18.04` 来具体指定所需哪个版本的镜像。如果忽略了标签，比如 `ubuntu`，那将视为 `ubuntu:latest`。
>
> 仓库名经常以 两段式路径 形式出现，比如 `jwilder/nginx-proxy`，前者往往意味着 Docker Registry 多用户环境下的用户名，后者则往往是对应的软件名。但这并非绝对，取决于所使用的具体 Docker Registry 的软件或服务。

补充：前面再加上公开或私有的Registry的地址，后面再加上`:tag`，就是一个完整的确定的镜像了。比如：
- dockerhub上biaoxyz用户的名为myapp的v2版本的镜像：`docker.io/biaoxyz/myapp:v2`
- quay.io上......的镜像：`quay.io/biaoxyz/myapp:v2`
- 本地registry上......的镜像（使用docker官方的docker registry镜像搭建）：`127.0.0.1:5000/biaoxyz/myapp:v2`

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` 安装Docker

## `##` CentOS

## `##` [macOS](https://yeasy.gitbooks.io/docker_practice/content/install/mac.html)

> 如同 macOS 其它软件一样，安装也非常简单，双击下载的 `.dmg` 文件，然后将那只叫 [Moby](https://blog.docker.com/2013/10/call-me-moby-dock/) 的鲸鱼图标拖拽到 `Application` 文件夹即可（其间需要输入用户密码）。
>> 大鲸鱼又恶意卖萌🐶。。。PS：只知道docker项目搞了个Moby出来，真不知道原来给大鲸鱼起名叫这个了。。。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` 使用镜像

## `##` [获取镜像](https://yeasy.gitbooks.io/docker_practice/content/image/pull.html)

> 从 Docker 镜像仓库获取镜像的命令是 docker pull。其命令格式为：
>> `docker pull [选项] [Docker Registry 地址[:端口号]/]仓库名[:标签]`

- > Docker 镜像仓库地址：地址的格式一般是 `<域名/IP>[:端口号]`。默认地址是 Docker Hub。
- > 仓库名：如之前所说，这里的仓库名是**两段式**名称，即 `<用户名>/<软件名>`。对于 Docker Hub，如果不给出用户名，则默认为 `library`，也就是官方镜像。

### 运行

> `docker run -it --rm ubuntu:18.04 bash`

- `-it`：这是两个参数，一个是 `-i`：交互式操作，一个是 `-t`：终端。我们这里打算进入 `bash` 执行一些命令并查看返回结果，因此我们需要交互式终端。
- `--rm`：这个参数是说容器退出后随之将其删除。默认情况下，为了排障需求，退出的容器并不会立即删除，除非手动 `docker rm`。我们这里只是随便执行个命令，看看结果，不需要排障和保留结果，因此使用 `--rm` 可以避免浪费空间。
- `ubuntu:18.04`：这是指用 `ubuntu:18.04` 镜像为基础来启动容器。
- `bash`：放在镜像名后的是 **命令**，这里我们希望有个交互式 Shell，因此用的是 `bash`。


## `##` [列出镜像](https://yeasy.gitbooks.io/docker_practice/content/image/list.html)



## `##` Dockerfile 指令详解

### `###` [ONBUILD 为他人做嫁衣裳](https://yeasy.gitbooks.io/docker_practice/content/image/dockerfile/onbuild.html)

> 那么，问题解决了么？没有。准确说，只解决了一半。如果这个 Dockerfile 里面有些东西需要调整呢？比如 npm install 都需要加一些参数，那怎么办？这一行 RUN 是不可能放入基础镜像的，因为涉及到了当前项目的 ./package.json，难道又要一个个修改么？所以说，这样制作基础镜像，只解决了原来的 Dockerfile 的前4条指令的变化问题，而后面三条指令的变化则完全没办法处理。
>
> ONBUILD 可以解决这个问题。让我们用 ONBUILD 重新写一下基础镜像的 Dockerfile:

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

