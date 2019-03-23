
# 书籍/项目链接

- docker_practice https://github.com/yeasy/docker_practice
- Docker — 从入门到实践 https://legacy.gitbook.com/book/yeasy/docker_practice/details
- Docker — 从入门到实践 https://docker_practice.gitee.io/

(注: 笔记使用本书的1.0.0版本)

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` Docker简介

## `##` [什么是Docker](https://yeasy.gitbooks.io/docker_practice/content/introduction/what.html)

这一页有很多概念，虽然链接大都是wikipedia，但是后续要认真看看。目前大部分都是懂个概念，知道点历史，但是不知道深入的细节，尤其是代码级的细节。
- cgroup, Linux namespace
- AUFS, Union FS
- 操作系统层面的虚拟化技术
- LXC, libcontainer, runC, containerd

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` 安装Docker

## `##` CentOS


:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` 使用镜像

## `##` Dockerfile 指令详解

### `###` [ONBUILD 为他人做嫁衣裳](https://yeasy.gitbooks.io/docker_practice/content/image/dockerfile/onbuild.html)

> 那么，问题解决了么？没有。准确说，只解决了一半。如果这个 Dockerfile 里面有些东西需要调整呢？比如 npm install 都需要加一些参数，那怎么办？这一行 RUN 是不可能放入基础镜像的，因为涉及到了当前项目的 ./package.json，难道又要一个个修改么？所以说，这样制作基础镜像，只解决了原来的 Dockerfile 的前4条指令的变化问题，而后面三条指令的变化则完全没办法处理。
>
> ONBUILD 可以解决这个问题。让我们用 ONBUILD 重新写一下基础镜像的 Dockerfile:

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

