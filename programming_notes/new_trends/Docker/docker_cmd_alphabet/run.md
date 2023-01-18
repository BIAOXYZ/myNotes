
# docker run

```sh
Usage:  docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

Run a command in a new container

例子：

docker run -it busybox sh   # 以busybox为镜像启动一个容器，并允许交互式地在容器中执行sh
docker run -dit busybox sh   # 同上，区别是加了-d参数后该容器会在后台运行。-i -t -d等其实也可以分开写
docker run --name mycontainer -it busybox sh  # --name参数为该容器指定一个名字，不然是随机的名字
docker run --rm {image}   # --rm 使得容器结束后会被自动删除，比较适用与临时起个容器随便看看的场景

docker run -P {image}   # 通过-P参数，将容器的端口映射到宿主机的随机端口
docker run -p {hostPort}:{containerPort} {image}  # 通过-p参数，将容器的端口映射到宿主机的制定端口

docker run -v {hostPath}:{containerPath} {image}
```

# 参数解析

# `-p`、`-P`

How to Use Docker Port Binding? https://betterprogramming.pub/how-does-docker-port-binding-work-b089f23ca4c8
- > **Let’s Get Started With an Nginx Docker Container**
  ```sh
  docker container run -d nginx
  ```
  * > You’ll see that the Docker container is active with the Docker container ps command: <br> ![](https://miro.medium.com/max/1400/1*LtL5Nn4V7wmACecQNjUxOg.webp)
  * > Now if you try to connect directly to the Docker container using curl or your browser, it will fail. You cannot connect directly to a Docker container. But why not? The Docker file even says port 80 is exposed… I don’t get it. Don’t worry, I’ll explain it in the following section!
  ```sh
  curl -I 127.0.0.1:80
  curl: (7) Failed to connect to 127.0.0.1 port 80: Connection refused
  ```
- > **2. Expose a specific port**
  ```sh
  docker container run -p 8080:80 -d nginx
  ```
  * > Port `80` of the Nginx container is exposed to the outside world on ***host port `8080`***. You can now connect to the container in multiple ways. For example, by using either `curl` or your browser. Awesome!
  ```sh
  curl -I 0.0.0.0:8080
  HTTP/1.1 200 OK
  Server: nginx/1.17.9
  Date: Sun, 08 Mar 2020 11:38:47 GMT
  Content-Type: text/html
  Content-Length: 612
  Last-Modified: Tue, 03 Mar 2020 14:32:47 GMT
  Connection: keep-alive
  ETag: "5e5e6a8f-264"
  Accept-Ranges: bytes
  ```
  * > Let me also show you how this would look in your browser if you visited `0.0.0.0:8080`. <br> ![](https://miro.medium.com/max/1168/1*dfFtAYgO_8fdbxGNBLquzw.webp)

docker容器内部端口映射到外部宿主机端口 https://blog.csdn.net/An1090239782/article/details/105216225 || https://www.cnblogs.com/kevingrace/p/9453987.html

Docker-端口映射 https://www.jianshu.com/p/b92d4b845ed6

## `-v`、`-volume`

Difference between `-volume` and `-volumes-from` in Docker Volumes https://stackoverflow.com/questions/58435359/difference-between-volume-and-volumes-from-in-docker-volumes
