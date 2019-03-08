

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

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

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

## 其他docker常用命令

- 15 个 Docker 技巧和提示 https://blog.csdn.net/liyingke112/article/details/73920837
```
删除已退出的容器： docker rm $(docker ps -q -f "status=exited") 
//注：有时运行一段时间有不少不用的container，此时用这个删比较好。
```
- 这20个Docker Command，有几个是你会的？ https://blog.csdn.net/mingongge/article/details/80524241

Docker入门 | 学习第一个Docker容器 - 郭志敏的文章 - 知乎 https://zhuanlan.zhihu.com/p/21252578

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

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

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## 阮一峰docker

- Docker 入门教程 http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html
- Docker 微服务教程 http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html

## DaoCloud

- Docker 核心技术与实现原理 http://blog.daocloud.io/edu171201/
- Docker简明教程 http://open.daocloud.io/learning-docker/ (这个是某个人在DaoCloud上的实战过程)
> Docker简明教程 https://jiajially.gitbooks.io/dockerguide/content/ (这个是个某个gitbook，名字一样，开始还弄混了)

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## docker微信帖子

### from 公众号Docker

Docker新手指南 http://mp.weixin.qq.com/s/Fycfuu2OhxblCBNUOH96jA

手把手教你写Docker https://mp.weixin.qq.com/s/26pQoikXyNC7aUFJbCkbjA

这可能是最为详细的Docker入门总结 https://mp.weixin.qq.com/s/3jp9lRORF8Aj6HOxsXRbsQ

Docker 配置与实践清单 https://mp.weixin.qq.com/s/mFk_BjJRMwx5uSnYXI1gpQ

## docker知乎帖子

如何通俗解释Docker是什么？ - 知乎 https://www.zhihu.com/question/28300645

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# docker具体问题

### docker镜像和容器的位置

- Docker---(2)docker pull 下来的镜像存储在哪里 https://blog.csdn.net/weixin_39800144/article/details/79019503
- docker 镜像与容器存储目录结构精讲 https://blog.csdn.net/wanglei_storage/article/details/50299491

### 修改docker镜像和容器的位置

- 两个修改Docker本地镜像与容器的存储位置的方法 https://www.jianshu.com/p/e98ef6d6cfb4
- 自定义CentOS 中Docker的默认镜像和容器位置 https://www.linuxprobe.com/docker-mirror-position.html

### Docker Volume

深入理解Docker Volume(一) https://blog.csdn.net/shanyongxu/article/details/51460930

## Dockerfile

Docker中镜像构建文件Dockerfile与相关命令的详细介绍 https://www.jb51.net/article/105333.htm
> docker build命令会根据Dockerfile文件及上下文构建新Docker镜像。构建上下文是指Dockerfile所在的本地路径或一个URL（Git仓库地址）。构建上下文环境会被递归处理，所以，构建所指定的路径还包括了子目录，而URL还包括了其中指定的子模块。

Docker(二)：Dockerfile 使用介绍 http://ityouknow.com/docker/2018/03/12/docker-use-dockerfile.html

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

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

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# Portainer

Simple management UI for Docker http://portainer.io https://github.com/portainer/portainer

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# docker for windows || docker toolbox

- Windows10下的docker安装与入门 （一）使用docker toolbox安装docker https://www.cnblogs.com/linjj/p/5606687.html
- 解决安装Docker CE for Windows之后VirtualBox无法启动虚拟机的问题 https://blog.csdn.net/zhang197093/article/details/78643708
> 总结一下就是：Windows下用docker途径这篇文章里说了两条：1.用常用的虚拟机（比如Virtual Box）软件搞一个Linux系统然后在该系统里用（docker toolbox是一样的道理）；2.用docker for Windows（和第一种方法主要区别是底层用的Windows自己的虚拟机软件Hyper V）。实际上应该还有一条路，在Windows Subsystem for Linux (WSL)里用。只不过WSL现在BUG太多，应该还不太好。

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# docker-machine

Docker Machine + Compose + Swarm
http://www.cnblogs.com/kevinX/p/5458251.html

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# docker swarm

Docker Swarm https://docs.docker.com/engine/swarm/swarm-tutorial/

深入浅出Docker Swarm
https://www.csdn.net/article/2015-01-26/2823714

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

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

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

