
# general

Best practices for writing Dockerfiles https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

附录四：Dockerfile 最佳实践 https://yeasy.gitbook.io/docker_practice/appendix/best_practices

你确定你会写 Dockerfile 吗？ - 云原生实验室的文章 - 知乎 https://zhuanlan.zhihu.com/p/72970159

Docker(三)：Dockerfile 命令详解 - 纯洁的微笑的文章 - 知乎 https://zhuanlan.zhihu.com/p/34688396

# `COPY` v.s. `ADD` 

Dockerfile 中的 COPY 与 ADD 命令 https://www.cnblogs.com/sparkdev/p/9573248.html
- > 对于目录而言，COPY 和 ADD 命令具有相同的特点：**只复制目录中的内容而不包含目录自身**。

What is the difference between the 'COPY' and 'ADD' commands in a Dockerfile? https://stackoverflow.com/questions/24958140/what-is-the-difference-between-the-copy-and-add-commands-in-a-dockerfile

# `CMD` v.s. `ENTRYPOINT`

Dockerfile: ENTRYPOINT和CMD的区别 - dongmao zhang的文章 - 知乎 https://zhuanlan.zhihu.com/p/30555962
- > 和CMD类似, 默认的ENTRYPOINT也在docker run时, 也可以被覆盖. 在运行时, 用 `--entrypoint` 覆盖默认的ENTRYPOINT

Dockerfile RUN，CMD，ENTRYPOINT命令区别 https://www.jianshu.com/p/f0a0f6a43907
- > Dockerfile中RUN，CMD和ENTRYPOINT都能够用于执行命令，下面是三者的主要用途：
  * > `RUN` 命令执行命令并创建新的镜像层，通常用于安装软件包
  * > `CMD` 命令设置容器启动后默认执行的命令及其参数，但CMD设置的命令能够被 docker run 命令后面的命令行参数替换
  * > `ENTRYPOINT` 配置容器启动时的执行命令（不会被忽略，一定会被执行，即使运行 docker run 时指定了其他命令）
