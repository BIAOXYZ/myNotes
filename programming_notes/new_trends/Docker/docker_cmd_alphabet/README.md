
Use the Docker command line https://docs.docker.com/engine/reference/commandline/cli/

# docker常用命令总结

## docker login
```sh
Usage:  docker login [OPTIONS] [SERVER]

Log in to a Docker registry

例子：

docker login quay.io   # 然后会提示输入用户名和密码 
docker login   # 没有指定服务器的话默认登陆的是dockerhub
docker login -u {username} -p {password} [可省的servername] 
# docker login的-p参数的值也可以是一个token，从而提供更强的安全性：一旦token泄露，直接去生成token的地方revoke掉该token即可。
# 例：docker login hyc-cp4mcm-team-docker-local.artifactory.swg-devops.com -u liulliu@cn.ibm.com -p u3esYXCLPSy8eQm3i2tYiZkZhG2urviQEXKHMHPMevKXw63LVRLR7
# 隐私原因，上面那个token值其实已经删掉了20位。。。此外，生成该token的地方是 https://na.artifactory.swg-devops.com/artifactory/webapp/#/home
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

## docker ps
```
docker ps -a --no-trunc  //主要是--no-trunc参数，可以显示完整的command。直接照搬 `ps -ef | cat` 不行。
```

## docker save/load
```sh
# https://stackoverflow.com/questions/23935141/how-to-copy-docker-images-from-one-host-to-another-without-using-a-repository
docker save -o <path for generated tar file> <image name>
docker load -i <path to image tar file>

# https://www.cnblogs.com/bigben0123/p/7592970.html
docker save -o 要保存的文件名 要保存的镜像
  例：docker save -o java8.tar lwieske/java-8

docker load --input 文件
docker load < 文件名
  例：docker load < java8.tar

----------------------------------------------------------------------------------------------------

# 1.在导出路径的最后镜像名字必须有；2.不是必须打成tar包，没后缀也不影响，比如下面的busyboximage。
$ docker save busybox:1 -o ~/test/busyboximage
$ ls ~/test/
busyboximage

$ docker load -i ~/test/busyboximage 
eac247cb7af5: Loading layer [==================================================>] 1.437 MB/1.437 MB
Loaded image: busybox:1
```

## docker cp

### 如何 docker cp 整个目录？
>> //notes：其实核心就是如果是整个目录里的文件的话，需要在目录斜杠后面加 `.` 号。

"docker cp" all files from a folder to existing container folder https://stackoverflow.com/questions/32566624/docker-cp-all-files-from-a-folder-to-existing-container-folder
- https://stackoverflow.com/questions/32566624/docker-cp-all-files-from-a-folder-to-existing-container-folder/32576340#32576340
- https://stackoverflow.com/questions/32566624/docker-cp-all-files-from-a-folder-to-existing-container-folder/48657895#48657895
  * > Copy files/folders between a container and the local filesystem is like below formats:
    + > Copy file to folder inside container:
      ```sh
      docker cp ./src/build/index.html ContainerName:/app/
      ```
      > above example shows index.html file is copying to app folder inside container
    + > Copy all files to folder inside container:
      ```sh
      docker cp ./src/build/. ContainerName:/app/
      ```
      > above example shows all files inside build folder are copying to app folder inside container

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他docker常用命令

- 15 个 Docker 技巧和提示 https://blog.csdn.net/liyingke112/article/details/73920837
```
删除已退出的容器： docker rm $(docker ps -q -f "status=exited") 
//注：有时运行一段时间有不少不用的container，此时用这个删比较好。
```
- 这20个Docker Command，有几个是你会的？ https://blog.csdn.net/mingongge/article/details/80524241

Docker入门 | 学习第一个Docker容器 - 郭志敏的文章 - 知乎 https://zhuanlan.zhihu.com/p/21252578

如何快速清理 docker 资源 https://www.cnblogs.com/sparkdev/p/9177283.html 【From `sparkdev`】
- > **查看 docker 占用的资源**
  * > 在进行资源清理之前我们有必要搞清楚 docker 都占用了哪些系统的资源。这需要综合使用不同的命令来完成。
    ```sh
    docker container ls：默认只列出正在运行的容器，-a 选项会列出包括停止的所有容器。
    docker image ls：列出镜像信息，-a 选项会列出 intermediate 镜像(就是其它镜像依赖的层)。
    docker volume ls：列出数据卷。
    docker network ls：列出 network。
    docker info：显示系统级别的信息，比如容器和镜像的数量等。
    ```
- > **只删除那些未被使用的资源**
  * > Docker 提供了方便的 `docker system prune` 命令来删除那些已停止的容器、dangling 镜像、未被容器引用的 network 和构建过程中的 cache：
    ```sh
    $ docker system prune
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Katacoda -- Docker & Containers

***refer the ${tech_essay} folder***

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
