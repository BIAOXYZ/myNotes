

# 官方连接

Docker https://www.docker.com/

docker官方文档
- https://docs.docker.com/
- https://docs.docker-cn.com/

Get Started with Docker https://www.docker.com/get-started
- Play with Docker Classroom https://training.play-with-docker.com/

Docker Hub https://hub.docker.com/

--------------------------------------------------

docker中文社区站  http://www.docker.org.cn/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# docker常用命令总结

## docker run
```
Usage:  docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

Run a command in a new container

例子：

docker run -it busybox sh   //以busybox为镜像启动一个容器，并允许交互式地在容器中执行sh
docker run -dit busybox sh   //同上，区别是加了-d参数后该容器会在后台运行。-i -t -d等其实也可以分开写
docker run --name mycontainer -it busybox sh  //--name参数为该容器指定一个名字，不然是随机的名字

docker run -P {images}   //通过-P参数，将容器的端口映射到宿主机的随机端口：
docker run -p {hostPort}:{containerPort} {images}   //通过-p参数，将容器的端口映射到宿主机的制定端口：
```

## docker login
```
Usage:  docker login [OPTIONS] [SERVER]

Log in to a Docker registry

例子：

docker login quay.io   //然后会提示输入用户名和密码 
docker login   //没有指定服务器的话默认登陆的是dockerhub
docker login -u {username} -p {password} [可省的servername]
```

Getting Started with Quay.io https://docs.quay.io/solution/getting-started.html
```
[root@cloudsec2 app-operator]# docker login quay.io
Username: biaoxyz
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```

docker login https://docs.docker.com/engine/reference/commandline/login/

## 其他docker常用命令

- 15 个 Docker 技巧和提示 https://blog.csdn.net/liyingke112/article/details/73920837
```
删除已退出的容器： docker rm $(docker ps -q -f "status=exited") 
//注：有时运行一段时间有不少不用的container，此时用这个删比较好。
```
- 这20个Docker Command，有几个是你会的？ https://blog.csdn.net/mingongge/article/details/80524241

Docker入门 | 学习第一个Docker容器 - 郭志敏的文章 - 知乎 https://zhuanlan.zhihu.com/p/21252578

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Katacoda -- Docker & Containers

***refer the ${tech_essay} folder***

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# docker general

🐳 A curated list of Docker resources and projects https://awesome-docker.netlify.com/ || https://github.com/veggiemonk/awesome-docker

Docker — 从入门到实践 https://legacy.gitbook.com/book/yeasy/docker_practice/details  (or https://github.com/yeasy/docker_practice)
- `安装Docker`->`CentOS 安装 Docker CE` https://yeasy.gitbooks.io/docker_practice/content/install/centos.html
> 警告：切勿在没有配置 Docker YUM 源的情况下直接使用 yum 命令安装 Docker.
- `使用镜像`->`列出镜像` https://yeasy.gitbooks.io/docker_practice/content/image/list.html
> 可以用下面的命令专门显示这类镜像：docker image ls -f dangling=true
- `访问仓库`->`私有仓库` https://yeasy.gitbooks.io/docker_practice/content/repository/registry.html

易百教程 -- Docker教程 https://www.yiibai.com/docker/

Linux容器技术进化史
http://www.infoq.com/cn/articles/how-linux-containers-evolved

Infoq 肖德时
http://www.infoq.com/cn/profile/%E8%82%96%E5%BE%B7%E6%97%B6
- 深入浅出Docker（一）：Docker核心技术预览 http://www.infoq.com/cn/articles/docker-core-technology-preview
- 深入浅出Docker（二）：Docker命令行探秘 http://www.infoq.com/cn/articles/docker-command-line-quest
- 深入浅出Docker（三）：Docker开源之路 http://www.infoq.com/cn/articles/docker-open-source-road
- 深入浅出Docker（四）：Docker的集成测试部署之道 http://www.infoq.com/cn/articles/docker-integrated-test-and-deployment
- 深入浅出Docker（五）：基于Fig搭建开发环境 http://www.infoq.com/cn/articles/docker-build-development-environment-based-on-fig
- 深入浅出Docker（六）：像谷歌一样部署你的应用 http://www.infoq.com/cn/articles/deploy-your-application-like-google

世民谈云计算 -- 随笔分类 - Docker
- 理解Docker（7）：Docker 存储 - AUFS https://www.cnblogs.com/sammyliu/p/5931383.html


Docker实战（一）：Docker基础命令 - CSDN博客
https://blog.csdn.net/birdben/article/details/49873725

Docker入门实战 - CSDN博客
https://blog.csdn.net/opensure/article/details/46490749

Docker入门与实战讲解 - CSDN博客
https://blog.csdn.net/relax_hb/article/details/69668815

## docker社区版和企业版

(转) Docker EE/Docker CE简介与版本规划 https://www.cnblogs.com/atuotuo/p/6668233.html

Docker CE 还是 Docker EE https://blog.csdn.net/liumiaocn/article/details/60468257

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## 阮一峰docker

- Docker 入门教程 http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html
- Docker 微服务教程 http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html

## DaoCloud

- Docker 核心技术与实现原理 http://blog.daocloud.io/edu171201/
- Docker简明教程 http://open.daocloud.io/learning-docker/ (这个是某个人在DaoCloud上的实战过程)
> Docker简明教程 https://jiajially.gitbooks.io/dockerguide/content/ (这个是个某个gitbook，名字一样，开始还弄混了)

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 其他docker系列教程

每天5分钟玩转 Docker 容器技术 https://www.cnblogs.com/CloudMan6/tag/Docker/   【by CloudMan】
- RUN vs CMD vs ENTRYPOINT - 每天5分钟玩转 Docker 容器技术（17） https://www.cnblogs.com/CloudMan6/p/6875834.html
  * ```
    简单的说：
    RUN 执行命令并创建新的镜像层，RUN 经常用于安装软件包。
    CMD 设置容器启动后默认执行的命令及其参数，但 CMD 能够被 docker run 后面跟的命令行参数替换。
    ENTRYPOINT 配置容器启动时运行的命令。
    ```
  * > RUN 指令通常用于安装应用和软件包。RUN 在当前镜像的顶部执行命令，并通过创建新的镜像层。Dockerfile 中常常包含多个 RUN 指令。
  * > 注意：apt-get update 和 apt-get install 被放在一个 RUN 指令中执行，这样能够保证每次安装的是最新的包。如果 apt-get install 在单独的 RUN 中执行，则会使用 apt-get update 创建的镜像层，而这一层可能是很久以前缓存的。
  * > CMD 指令允许用户指定容器的默认执行的命令。此命令会在容器启动且 docker run 没有指定其他命令时运行。
  * > ENTRYPOINT 看上去与 CMD 很像，它们都可以指定要执行的命令及其参数。不同的地方在于 ENTRYPOINT 不会被忽略，一定会被执行，即使运行 docker run 时指定了其他命令。
  * > 在为 ENTRYPOINT 选择格式时必须小心，因为这两种格式的效果差别很大。
  * > ENTRYPOINT 的 Exec 格式用于设置要执行的命令及其参数，同时可通过 CMD 提供额外的参数。ENTRYPOINT 中的参数始终会被使用，而 CMD 的额外参数可以在容器启动时动态替换掉。
  * > ENTRYPOINT 的 Shell 格式会忽略任何 CMD 或 docker run 提供的参数。
  
----------------------------------------------------------------------------------------------------

Allen 谈 Docker 系列 http://guide.daocloud.io/dcs/allen-docker-9153965.html

----------------------------------------------------------------------------------------------------

深入浅出Docker https://blog.csdn.net/liumiaocn/column/info/dockerheadfirst
- 

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## docker微信帖子

### from 公众号Docker

Docker新手指南 http://mp.weixin.qq.com/s/Fycfuu2OhxblCBNUOH96jA

手把手教你写Docker https://mp.weixin.qq.com/s/26pQoikXyNC7aUFJbCkbjA

这可能是最为详细的Docker入门总结 https://mp.weixin.qq.com/s/3jp9lRORF8Aj6HOxsXRbsQ

Docker 配置与实践清单 https://mp.weixin.qq.com/s/mFk_BjJRMwx5uSnYXI1gpQ

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## docker知乎帖子

如何通俗解释Docker是什么？ - 知乎 https://www.zhihu.com/question/28300645

一篇不一样的docker原理解析 提高篇 - uncle creepy的文章 - 知乎 https://zhuanlan.zhihu.com/p/22403015

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# docker源码和底层原理

## OverlayFS

【[`*`][:star:]】：
- 深入理解overlayfs（一）：初识 https://blog.csdn.net/luckyapple1028/article/details/77916194
- 深入理解overlayfs（二）：使用与原理分析 https://blog.csdn.net/luckyapple1028/article/details/78075358

【Docker 基础知识】存储驱动overlay和overlay2 https://blog.csdn.net/zhonglinzhang/article/details/80970411

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# docker具体问题

## docker image

Docker学习：Image的本地存储结构 https://segmentfault.com/a/1190000017579626
- > 镜像build过程可以理解为基于一个镜像启动一个容器，在容器内执行Dockerfile里的一条命令，生成一个新的镜像。根据上述的输入，test-image的构建过程可以表示为：
- > 如前面所述，digest是有docker repository生成，因为本地构建完之后并没有推送至远程仓库，所以为None。
- > 事实上，如果我们认为镜像是一个打包的静态OS，那么Layer可以认为是描述该OS的fs变化，即文件系统中文件或者目录发生的改变，很明显上述两行命令并不会引起fs的变化，只是会写入该镜像的config中，在生成容器时读取即可，自然也就不存在diff id。
- > 至此，解释完了Image相关的目录，总结一下，单个Image的配置信息在content目录中，以image id为文件名存储，Image之间关联信息在metadata中，以parent文件存储。然后，我们根据image生成容器的时候，可是生成了一个文件系统，但是上述这些信息并不包含fs的数据。因为真正的fs数据是存储在Layer中的。如前面所述，Layer的信息存储在layerdb目录下，所以我们转战layerdb目录。
- > 进一步研究才知道这里目录名其实是layer的chain id，而非diff id，关于这两这个的区别，我们可以理解为diff id用来描述单个变化，而chain id用来便于一些列的变化，diff id和chain id之间的计算公式可以在image-spec中看到。
- > Image Size是如何计算的？

### docker镜像和容器的位置

- Docker---(2)docker pull 下来的镜像存储在哪里 https://blog.csdn.net/weixin_39800144/article/details/79019503
- docker 镜像与容器存储目录结构精讲 https://blog.csdn.net/wanglei_storage/article/details/50299491

### 修改docker镜像和容器的位置

- 两个修改Docker本地镜像与容器的存储位置的方法 https://www.jianshu.com/p/e98ef6d6cfb4
- 自定义CentOS 中Docker的默认镜像和容器位置 https://www.linuxprobe.com/docker-mirror-position.html

## Docker Volume

深入理解Docker Volume(一) https://blog.csdn.net/shanyongxu/article/details/51460930

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Dockerfile

Docker中镜像构建文件Dockerfile与相关命令的详细介绍 https://www.jb51.net/article/105333.htm
> docker build命令会根据Dockerfile文件及上下文构建新Docker镜像。构建上下文是指Dockerfile所在的本地路径或一个URL（Git仓库地址）。构建上下文环境会被递归处理，所以，构建所指定的路径还包括了子目录，而URL还包括了其中指定的子模块。

Docker(二)：Dockerfile 使用介绍 http://ityouknow.com/docker/2018/03/12/docker-use-dockerfile.html

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

「Allen 谈 Docker 系列」docker build 的 cache 机制 http://dockone.io/article/674

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## docker其他

关于/var/run/docker.sock https://www.jianshu.com/p/6c3fdb0e9cb5
> 运行过Docker Hub的Docker镜像的话，会发现其中一些容器时需要挂载/var/run/docker.sock文件。这个文件是什么呢？为什么有些容器需要使用它？简单地说，它是Docker守护进程(Docker daemon)默认监听的Unix域套接字(Unix domain socket)，容器中的进程可以通过它与Docker守护进程进行通信。

【Docker】daemon.json的作用（八） https://blog.csdn.net/u013948858/article/details/79974796

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## docker个人实战

Spring Boot 2.0(四)：使用 Docker 部署 Spring Boot http://www.ityouknow.com/springboot/2018/03/19/spring-boot-docker.html
- 项目源码在这里：https://github.com/BIAOXYZ/spring-boot-examples/tree/master/spring-boot-docker
- 还有一个官方的教程( https://spring.io/guides/gs/spring-boot-docker/ )，但是最后镜像生成了起不来，回头再看看吧。
> Spring Boot项目打包成docker镜像 https://blog.csdn.net/baidu_31901023/article/details/78773667 【这个有点像上面那个官方教程的部分翻译实践版。虽然没怎么参照它，也记一下吧。】
- Docker：Spring Boot应用发布到Docker https://lw900925.github.io/docker/docker-springboot.html

这俩其实就只是参考Dockerfile文件
- 将Spring Boot程序打包成docker镜像 https://yq.aliyun.com/articles/42283
- 将Spring Boot程序打包成docker镜像-超简版 https://yq.aliyun.com/articles/42305

Maven 插件之 docker-maven-plugin 的使用 https://blog.csdn.net/aixiaoyang168/article/details/77453974 【这个给出了另外一种spring boot项目打包成docker镜像的方式，不用单独的Dockerfile，而是把Dockerfile的内容嵌入到pom.xml中】

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# docker security

Docker Awarded FIPS 140-2 Validation by NIST https://www.docker.com/docker-news-and-press/docker-awarded-fips-140-2-validation-nist
- https://csrc.nist.gov/Projects/Cryptographic-Module-Validation-Program/Certificate/3304
- https://blog.docker.com/2018/10/docker-achieves-fips-140-2-validation/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Portainer

Simple management UI for Docker http://portainer.io https://github.com/portainer/portainer

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# docker for windows || docker toolbox

- Windows10下的docker安装与入门 （一）使用docker toolbox安装docker https://www.cnblogs.com/linjj/p/5606687.html
- 解决安装Docker CE for Windows之后VirtualBox无法启动虚拟机的问题 https://blog.csdn.net/zhang197093/article/details/78643708
> 总结一下就是：Windows下用docker途径这篇文章里说了两条：1.用常用的虚拟机（比如Virtual Box）软件搞一个Linux系统然后在该系统里用（docker toolbox是一样的道理）；2.用docker for Windows（和第一种方法主要区别是底层用的Windows自己的虚拟机软件Hyper V）。实际上应该还有一条路，在Windows Subsystem for Linux (WSL)里用。只不过WSL现在BUG太多，应该还不太好。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# docker-machine

Docker Machine + Compose + Swarm http://www.cnblogs.com/kevinX/p/5458251.html

Docker(五)：Docker 三剑客之 Docker Machine http://www.ityouknow.com/docker/2018/03/30/docker-machine.html 【by 纯洁的微笑】

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# docker swarm

Docker Swarm https://docs.docker.com/engine/swarm/swarm-tutorial/

深入浅出Docker Swarm
https://www.csdn.net/article/2015-01-26/2823714

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# docker-compose

极客学院 -- <<Docker —— 从入门到实践>> -- Compose 命令说明
http://wiki.jikexueyuan.com/project/docker-technology-and-combat/commands.html

gitbook -- <<Docker —— 从入门到实践>> -- Compose 命令说明
https://yeasy.gitbooks.io/docker_practice/content/compose/commands.html

Docker-compose命令详解 - CSDN博客
https://blog.csdn.net/wanghailong041/article/details/52162293

Docker-compose使用全解 - CSDN博客
https://blog.csdn.net/zhiaini06/article/details/45287663

docker-compose教程（安装，使用, 快速入门） https://blog.csdn.net/pushiqiang/article/details/78682323

docker-compose.yml 配置文件编写详解 https://blog.csdn.net/qq_36148847/article/details/79427878

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

https://www.cnblogs.com/sparkdev/tag/docker/default.html
- RunC 简介 https://www.cnblogs.com/sparkdev/p/9032209.html
- 从 docker 到 runC https://www.cnblogs.com/sparkdev/p/9129334.html

Container Training https://container.training/
