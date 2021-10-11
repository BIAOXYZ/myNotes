
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

# 其他文章
>> //notes：`文章1`比较好的地方就在于，全程直接复制粘贴执行即可，不用自己改任何命令。有了`文章1`之后，其他的就只是复杂度或别的小技巧了。下面的没验证，只是贴一下。

docker容器编译程序 的两种方案 https://blog.csdn.net/qq_39919755/article/details/93890485

Docker Pattern: The Build Container https://medium.com/@alexeiled/docker-pattern-the-build-container-b0d0e86ad601

Build, Package, and Run Spring Boot Apps With Docker https://dzone.com/articles/build-package-and-run-spring-boot-apps-with-docker
