
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
$ 


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


# 注意：这里专门把宿主机上的 gcc 卸载了，就是为了说明：“编译时用的是容器里配的环境（这里指容器里的gcc，但是复杂的情况下能配很多别的）” 
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
>> //notes：上一部分里编译方法的思路其实是这样的：搞一个镜像（这里指 `build-c`）把编译需要的各种软件（尤其是跨平台时，比如想在 Linux 下交叉编译出 Windows 下的 `.exe` 时）、依赖等搞好（但是一些已经在项目里包含的依赖——比如已经下载到 `proj_root/third_party` 里的第三方库的源文件——可能就不需要在编译镜像里搞了），然后从该镜像启动一个容器直接执行 `gcc` 编译命令，当然，***需要把宿主机上的项目源码目录挂载到容器里***。编译完成后，用类似的方式运行编译好的程序。
>>> //notes2：此外还有第二条思路：***把项目源码等也一起打包到制作的镜像里***，然后在镜像结尾直接执行编译命令甚至是测试用例——也就是***镜像制作完成就意味着这个版本编译完成***。后续可以通过类似 `docker run --rm -it --name testcontainer testimage bash` 的命令从编译好的镜像启动并进入容器内部，运行编译好的二进制、查看日志等（如果需要多个terminal联调时，再执行 `docker exec -it testcontainer bash` 附加到该容器即可）。
>>>> 两种方法各有优劣：
- 前者更轻量，但是编译产生的临时文件（比如二进制、动态库、静态库、测试生成的log等）也会在宿主机的项目目录里（因为这个目录被挂载了）。
- 后者完全不会污染项目主目录，***且只要镜像留着，就随时可以方便地尝试不同版本编好后的样子***。但是镜像大，编译速度慢，~~在特性没成型前的快速开发过程中好像还是前者更合适~~。 —— 不，***现在坚决推荐后者了***：
  * 第一是编译速度不会慢很多，因为利用 `apt`/`yum` 之类的包管理工具和/或其他工具，准备编译环境的过程中所涉及的镜像层docker会缓存，所以每次新的 commit 合入后再build新镜像时，前面的大部分步骤都直接过了。
  * 第二是这种方式真的更加灵活，容器就是一个独立环境，里面随便搞，随时可以删除再启动一个（甚至镜像也可以重新再build，或者带着你当前的改动再build）。当想编译代码的时候，既可以进到容器内部，修改代码，然后在容器内部进行编译（为了方便，需要vsc连接到容器进行开发，可以参考相应部分，已经比较完美地解决了）；也可以在外部（也就是宿主机）修改代码，直接在外部通过build新镜像来编译（需要仓库里有编译脚本，或者Dockerfile里有编译相关语句）
  * 此外，可以参考 vs code 目录下的 [container 部分](../../../programming_tools_and_libs/ide/vsc/vsc_docker/README.md)，里面记录了如何巧用 vsc 的相关插件达到各种方便的效果。

***实战过程***：
```sh
mkdir test && cd test

mkdir -p project/src project/bin
cat << EOF > project/src/main.c
#include <stdio.h>
int main(int argv, char ** argc) {
    printf("Hello Docker!\n");
}
EOF

# 这一部分在后面的补充部分里有其他替换方法，可以达到 build 镜像的过程顺便就编译源码和跑测试用例。
cat << EOF > project/Dockerfile
FROM ubuntu:18.04
RUN apt-get update -y && apt-get install -y gcc
WORKDIR /proj_root
COPY . .
CMD gcc -o /proj_root/bin/main /proj_root/src/main.c
CMD /proj_root/bin/main
EOF

cd project/
docker build -t image-with-code .

# 其实上面的镜像名可以更有含义一点，比如我一般叫 mr16 或者 pr16，表示仓库的第16个合入。
# 同理，下面语句里的容器名 123 可以换成根据镜像名来起，比如 mr16-1。但其实就固定叫123也可以，方便后续 vscode 插件的使用，好记好找。
# 另外如果只是随便试试某个编译，可以用 --rm；如果正用这个容器在开发，就不要加 --rm 了。
docker run --rm -it --name 123 image-with-code bash
# 然后在容器内进行编译，此时容器内部就是一个独立的干净环境。不想要了直接删了容器重新起一个。
# 此外，在仓库里可以搞一个编译脚本，在build镜像的尾声直接执行这个编译脚本。
# 测试脚本也是同理，加了编译脚本和测试脚本后，可以直接通过build某次合入的镜像，就知道该次提交是否能编译成功，以及是否通过所有测试用例。
gcc -o ./bin/main ./src/main.c
./bin/main
```
```sh
$ mkdir test && cd test
$ 
$ mkdir -p project/src project/bin
$ cat << EOF > project/src/main.c
> #include <stdio.h>
> int main(int argv, char ** argc) {
>     printf("Hello Docker!\n");
> }
> EOF
$ 
$ tree
.
└── project
    ├── bin
    └── src
        └── main.c

3 directories, 1 file
$ 
$ cat << EOF > project/Dockerfile
> FROM ubuntu:18.04
> RUN apt-get update -y && apt-get install -y gcc
> WORKDIR /proj_root
> COPY . .
> CMD gcc -o /proj_root/bin/main /proj_root/src/main.c
> CMD /proj_root/bin/main
> EOF
$ 
$ tree
.
└── project
    ├── bin
    ├── Dockerfile
    └── src
        └── main.c

3 directories, 2 files
$ 


$ cd project/
$ 
$ docker build -t image-with-code .
Sending build context to Docker daemon  4.096kB
Step 1/6 : FROM ubuntu:18.04
18.04: Pulling from library/ubuntu
284055322776: Pull complete 
Digest: sha256:0fedbd5bd9fb72089c7bbca476949e10593cebed9b1fb9edf5b79dbbacddd7d6
Status: Downloaded newer image for ubuntu:18.04
 ---> 5a214d77f5d7
Step 2/6 : RUN apt-get update -y && apt-get install -y gcc
 ---> Running in 9ffd06dc4840
Get:1 http://archive.ubuntu.com/ubuntu bionic InRelease [242 kB]
Get:2 http://archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]
Get:3 http://archive.ubuntu.com/ubuntu bionic-backports InRelease [74.6 kB]
...
...
...
Step 6/6 : CMD /proj_root/bin/main
 ---> Running in 8fd39756d532
Removing intermediate container 8fd39756d532
 ---> d44f9a1abcbc
Successfully built d44f9a1abcbc
Successfully tagged image-with-code:latest
$ 
$ docker images
REPOSITORY                 TAG                 IMAGE ID            CREATED              SIZE
image-with-code            latest              d44f9a1abcbc        About a minute ago   212MB
ubuntu                     18.04               5a214d77f5d7        2 weeks ago          63.1MB
$ 


$ docker run --rm -it --name 123 image-with-code bash
root@c692f1a3ea53:/proj_root# 
root@c692f1a3ea53:/proj_root# ls
Dockerfile  bin  src
root@c692f1a3ea53:/proj_root#                               
root@c692f1a3ea53:/proj_root# gcc -o ./bin/main ./src/main.c
root@c692f1a3ea53:/proj_root# 
root@c692f1a3ea53:/proj_root# ./bin/main 
Hello Docker!
root@c692f1a3ea53:/proj_root# 
root@c692f1a3ea53:/proj_root# exit
exit
$ 
```

## 补1
>> //notes：前面也提到过，在上面的例子中，镜像构建时没有编译代码，而我们希望在构建镜像时就顺便编译一次（可以用来保证新合入代码的正确性），甚至希望运行测试用例。

```sh
# 前面生成 Dockerfile 的语句，把里面的两行 CMD 改成这一行 RUN（当然也可以改两行，但是 RUN 会添加新的层，所以尽量合并），
# 就可以保证每次去 build 景象的时候都一定会编译和运行一次，这里其实就是模拟了门禁系统里的合入编译和跑测试用例。
cat << EOF > project/Dockerfile
FROM ubuntu:18.04
RUN apt-get update -y && apt-get install -y gcc
WORKDIR /proj_root
COPY . .
RUN gcc -o /proj_root/bin/main /proj_root/src/main.c && /proj_root/bin/main
EOF


# 也可以用下面两个 heredoc 来替代上面的单个 heredoc，效果就更像是前面描述的，用脚本来跑程序的 build 和 test。
cat << EOF > project/build.sh
gcc -o /proj_root/bin/main /proj_root/src/main.c && /proj_root/bin/main
EOF

cat << EOF > project/Dockerfile
FROM ubuntu:18.04
RUN apt-get update -y && apt-get install -y gcc
WORKDIR /proj_root
COPY . .
RUN bash -x ./build.sh
EOF
```

# 其他文章
>> //notes：`文章1`比较好的地方就在于，全程直接复制粘贴执行即可，不用自己改任何命令。有了`文章1`之后，其他的就只是复杂度或别的小技巧了。下面的没验证，只是贴一下。

docker容器编译程序 的两种方案 https://blog.csdn.net/qq_39919755/article/details/93890485

Docker Pattern: The Build Container https://medium.com/@alexeiled/docker-pattern-the-build-container-b0d0e86ad601

Build, Package, and Run Spring Boot Apps With Docker https://dzone.com/articles/build-package-and-run-spring-boot-apps-with-docker
