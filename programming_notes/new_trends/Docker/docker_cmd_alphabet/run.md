
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

Difference between `-volume` and `-volumes-from` in Docker Volumes https://stackoverflow.com/questions/58435359/difference-between-volume-and-volumes-from-in-docker-volumes
