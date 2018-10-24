

# 官方连接

docker中文社区站  
http://www.docker.org.cn/

Docker Swarm
https://docs.docker.com/engine/swarm/swarm-tutorial/

kubernetes中文社区
https://www.kubernetes.org.cn/

Kubernetes中文社区 | 中文文档
http://docs.kubernetes.org.cn/


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# docker general

Docker — 从入门到实践 https://legacy.gitbook.com/book/yeasy/docker_practice/details  (or https://github.com/yeasy/docker_practice)
- CentOS 安装 Docker CE https://yeasy.gitbooks.io/docker_practice/content/install/centos.html
> 警告：切勿在没有配置 Docker YUM 源的情况下直接使用 yum 命令安装 Docker.

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



## 阮一峰docker

- Docker 入门教程 http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html
- Docker 微服务教程 http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html

## DaoCloud

- Docker 核心技术与实现原理 http://blog.daocloud.io/edu171201/
- Docker简明教程 http://open.daocloud.io/learning-docker/ (这个是某个人在DaoCloud上的实战过程)
> Docker简明教程 https://jiajially.gitbooks.io/dockerguide/content/ (这个是个某个gitbook，名字一样，开始还弄混了)

## docker微信帖子

Docker新手指南
http://mp.weixin.qq.com/s/Fycfuu2OhxblCBNUOH96jA

手把手教你写Docker
https://mp.weixin.qq.com/s/26pQoikXyNC7aUFJbCkbjA

## docker知乎帖子

如何通俗解释Docker是什么？ - 知乎 https://www.zhihu.com/question/28300645

## docker具体问题

Docker---(2)docker pull 下来的镜像存储在哪里 https://blog.csdn.net/weixin_39800144/article/details/79019503

两个修改Docker本地镜像与容器的存储位置的方法 https://www.jianshu.com/p/e98ef6d6cfb4

## docker个人实战

Spring Boot 2.0(四)：使用 Docker 部署 Spring Boot http://www.ityouknow.com/springboot/2018/03/19/spring-boot-docker.html
- 项目源码在这里：https://github.com/BIAOXYZ/spring-boot-examples/tree/master/spring-boot-docker
- 还有一个官方的教程( https://spring.io/guides/gs/spring-boot-docker/ )，但是最后镜像生成了起不来，回头再看看吧。
> Spring Boot项目打包成docker镜像 https://blog.csdn.net/baidu_31901023/article/details/78773667 【这个有点像上面那个官方教程的部分翻译实践版。虽然没怎么参照它，也记一下吧。】


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# docker for windows || docker toolbox

- Windows10下的docker安装与入门 （一）使用docker toolbox安装docker https://www.cnblogs.com/linjj/p/5606687.html
- 解决安装Docker CE for Windows之后VirtualBox无法启动虚拟机的问题 https://blog.csdn.net/zhang197093/article/details/78643708
> 总结一下就是：Windows下用docker途径这篇文章里说了两条：1.用常用的虚拟机（比如Virtual Box）软件搞一个Linux系统然后在该系统里用（docker toolbox是一样的道理）；2.用docker for Windows（和第一种方法主要区别是底层用的Windows自己的虚拟机软件Hyper V）。实际上应该还有一条路，在Windows Subsystem for Linux (WSL)里用。只不过WSL现在BUG太多，应该还不太好。

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# docker-machine

Docker Machine + Compose + Swarm
http://www.cnblogs.com/kevinX/p/5458251.html


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# docker swarm

深入浅出Docker Swarm
https://www.csdn.net/article/2015-01-26/2823714


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# docker-compose

极客学院 -- <<Docker —— 从入门到实践>> -- Compose 命令说明
http://wiki.jikexueyuan.com/project/docker-technology-and-combat/commands.html

gitbook -- <<Docker —— 从入门到实践>> -- Compose 命令说明
https://yeasy.gitbooks.io/docker_practice/content/compose/commands.html

Docker-compose命令详解 - CSDN博客
https://blog.csdn.net/wanghailong041/article/details/52162293

Docker-compose使用全解 - CSDN博客
https://blog.csdn.net/zhiaini06/article/details/45287663

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# Kubernetes

Docker 和 Kubernetes：给程序员的快速指南 - 江宏的文章 - 知乎 https://zhuanlan.zhihu.com/p/39937913

Kubernetes中文指南/云原生应用架构实践手册 https://github.com/rootsongjc/kubernetes-handbook

Docker官方将支持Kubernetes，容器编排大战宣告结束
http://www.infoq.com/cn/news/2017/10/Docker-Kubernetes-Swarm

Kubernetes系统架构简介
http://www.infoq.com/cn/articles/Kubernetes-system-architecture-introduction

Kubernetes初探 - CSDN博客
https://blog.csdn.net/zhangjun2915/article/details/40598151

Kubernetes基础与架构 https://www.fangzhipeng.com/kubernetes/2018/09/30/k8s-basic1/
> Docker入门与实战 https://www.fangzhipeng.com/docker/2018/09/12/docker-action/

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# Prometheus

还不了解 CNCF？关于 CNCF 的三问三答！ http://blog.daocloud.io/cncf-3/
> Prometheus 是一套开源的监控、报警和时间序列数据库的组合，成立于 2012 年，由 SoundCloud 公司开发，此后许多组织接受和采用了 Prometheus，遂将其独立为开源项目。该项目使用 Go 语言开发，社区氛围非常活跃。



