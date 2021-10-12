
# 文章1

【[:star:][`*`]】 Compile code with Docker https://nextbreakpoint.com/posts/article-compile-code-with-docker.html
- > **Create Dockerfile**
  * > Let's assume we want to create our build environment using Ubuntu as operating system.
  * > All we have to do is creating a Dockerfile, where we declare the commands required to install the tools we need, for example the GNU C compiler:
    ```sh
    mkdir build-compiler-image
    
    cat <<EOF >build-compiler-image/Dockerfile
    FROM ubuntu:16.04
    RUN apt-get update -y && apt-get install -y gcc
    EOF
    ```
- > **Build custom image**
  * > We can create a Docker image using our Dockerfile:
    ```sh
    docker build -t build-c build-compiler-image
    ```
- > **Compile and execute code**
  * > We can easily compile and execute a simple C program using our custom image:
    ```sh
    mkdir -p project/src project/bin
    
    cat <<EOF >project/src/main.c
    #include <stdio.h>
    int main(int argv, char ** argc) {
        printf("Hello Docker!\n");
    }
    EOF
    ```
    ```sh
    docker run -it -v $(pwd)/project:/project build-c gcc -o /project/bin/main /project/src/main.c
    ```
    ```sh
    docker run -it -v $(pwd)/project:/project build-c /project/bin/main
    ```

## 个人实战1
>> //notes：实际上这个实战1没啥可写的，因为作者搞得太好了，直接复制粘贴执行即可。但是还是额外演示了下在最后编译前把宿主机的 `gcc` 先给卸载了，从而说明用的是***容器里的*** `gcc`。

```sh
$ mkdir test && cd test
$ 
$ mkdir build-compiler-image
$ 
$ cat <<EOF >build-compiler-image/Dockerfile
> FROM ubuntu:16.04
> RUN apt-get update -y && apt-get install -y gcc
> EOF
$ 
$ ls
build-compiler-image
$ 
$ tree
.
└── build-compiler-image
    └── Dockerfile

1 directory, 1 file
$ 


$ docker build -t build-c build-compiler-image
Sending build context to Docker daemon  2.048kB
Step 1/2 : FROM ubuntu:16.04
16.04: Pulling from library/ubuntu
58690f9b18fc: Pull complete 
b51569e7c507: Pull complete 
da8ef40b9eca: Pull complete 
fb15d46c38dc: Pull complete 
Digest: sha256:454054f5bbd571b088db25b662099c6c7b3f0cb78536a2077d54adc48f00cd68
Status: Downloaded newer image for ubuntu:16.04
 ---> b6f507652425
Step 2/2 : RUN apt-get update -y && apt-get install -y gcc
 ---> Running in 3bbc16e13f31
Get:1 http://archive.ubuntu.com/ubuntu xenial InRelease [247 kB]
Get:2 http://archive.ubuntu.com/ubuntu xenial-updates InRelease [109 kB]
Get:3 http://security.ubuntu.com/ubuntu xenial-security InRelease [109 kB]
...
...
...
Setting up gcc-5 (5.4.0-6ubuntu1~16.04.12) ...
Setting up gcc (4:5.3.1-1ubuntu1) ...
Setting up libc-dev-bin (2.23-0ubuntu11.3) ...
Setting up linux-libc-dev:amd64 (4.4.0-210.242) ...
Setting up libc6-dev:amd64 (2.23-0ubuntu11.3) ...
Setting up manpages-dev (4.04-2) ...
Processing triggers for libc-bin (2.23-0ubuntu11.3) ...
Removing intermediate container 3bbc16e13f31
 ---> 05420add4ca6
Successfully built 05420add4ca6
Successfully tagged build-c:latest
$ 
$ docker images
REPOSITORY                 TAG                 IMAGE ID            CREATED              SIZE
build-c                    latest              05420add4ca6        About a minute ago   264MB


$ mkdir -p project/src project/bin
$ 
$ cat <<EOF >project/src/main.c
> #include <stdio.h>
> int main(int argv, char ** argc) {
>     printf("Hello Docker!\n");
> }
> EOF
$ 
$ tree
.
├── build-compiler-image
│   └── Dockerfile
└── project
    ├── bin
    └── src
        └── main.c

4 directories, 2 files
$ 


# 注意：这里专门把宿主机上的 gcc 卸载了，就是为显示 “编译时用的是容器里配的环境（这里指容器里的gcc，但是复杂的情况下能配很多别的）” 
$ apt remove -y gcc
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages were automatically installed and are no longer required:
  g++-5 g++-5-multilib lib32stdc++-5-dev libuv1 libx32stdc++-5-dev
Use 'apt autoremove' to remove them.
The following packages will be REMOVED
  build-essential g++ g++-multilib gcc gcc-multilib
0 to upgrade, 0 to newly install, 5 to remove and 0 not to upgrade.
After this operation, 96.3 kB disk space will be freed.
(Reading database ... 115521 files and directories currently installed.)
Removing build-essential (12.1ubuntu2) ...
Removing g++-multilib (4:5.3.1-1ubuntu1) ...
Removing g++ (4:5.3.1-1ubuntu1) ...
update-alternatives: using /usr/bin/clang++ to provide /usr/bin/c++ (c++) in auto mode
Removing gcc-multilib (4:5.3.1-1ubuntu1) ...
Removing gcc (4:5.3.1-1ubuntu1) ...
Processing triggers for man-db (2.7.5-1) ...
$ 
$ gcc --version
The program 'gcc' is currently not installed. You can install it by typing:
apt install gcc
$ 


$ docker run -it -v $(pwd)/project:/project build-c gcc -o /project/bin/main /project/src/main.c
$ 
$ tree
.
├── build-compiler-image
│   └── Dockerfile
└── project
    ├── bin
    │   └── main
    └── src
        └── main.c

4 directories, 3 files
$ 
$ docker run -it -v $(pwd)/project:/project build-c /project/bin/main
Hello Docker!
$ 
```

## 个人实战2
>> //notes：上一部分里编译方法的思路其实是这样的：搞一个镜像（这里是 `build-c`）把编译需要的各种软件（尤其是跨平台时，比如想在linux下交叉编译出Windows下的`.exe`时）、依赖等搞好（但是一些已经在项目里包含的依赖可能就不需要在编译容器里搞了），然后从该镜像启动一个容器直接执行gcc编译命令，当然，需要把宿主机上的项目源码目录挂载到容器里。编译完成后，用类似的方式运行编译好的程序。
>>> 此外还有第二条思路：把项目源码等也打包到制作的镜像里，然后在镜像结尾直接执行编译命令甚至是测试用例——也就是镜像制作完成就意味着这个版本编译完成。后续可以通过类似 `docker run --rm -it --name testcontainer testimage bash`（需要多个terminal联调时，再执行 `docker exec -it testcontainer bash` 附加到该容器即可）启动进入容器运行编译好的二进制、查看日志等。
>>>> 两种方法各有优劣：前者更轻量；后者完全不会污染项目主目录，且只要镜像留着，就随时可以方便地尝试不同版本编好后的样子，但是镜像大，编译速度慢。

# 其他文章
>> //notes：`文章1`比较好的地方就在于，全程直接复制粘贴执行即可，不用自己改任何命令。有了`文章1`之后，其他的就只是复杂度或别的小技巧了。下面的没验证，只是贴一下。

docker容器编译程序 的两种方案 https://blog.csdn.net/qq_39919755/article/details/93890485

Docker Pattern: The Build Container https://medium.com/@alexeiled/docker-pattern-the-build-container-b0d0e86ad601

Build, Package, and Run Spring Boot Apps With Docker https://dzone.com/articles/build-package-and-run-spring-boot-apps-with-docker
