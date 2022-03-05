
# 参考链接

kubernetes系列之十一：在Kubernetes平台对容器进行debug https://blog.csdn.net/cloudvtech/article/details/80267479

## 使用环境

Launch Single Node Kubernetes Cluster https://www.katacoda.com/courses/kubernetes/launch-single-node-cluster

# 个人实战过程

```sh
$ mkdir test
$ cd test/
$ touch Dockerfile

cat << 1234 > Dockerfile
FROM centos:latest
RUN yum install -y gdb strace lsof tcpdump net-tools ftp openssh-clients iproute
ENTRYPOINT []
CMD ["/bin/bash"]
1234

$ docker build -t debug-container .

// 随便起个deployment（当然也可以用docker随便起个容器并直接指定名字更省事）并查一下容器的名字，比如这个例子中是：
$ kubectl create deployment first-deployment --image=katacoda/docker-http-server
$ docker ps
CONTAINER ID        IMAGE                         COMMAND                  CREATED             STATUS              PORTS               NAMES
6d0fa1fa9870        katacoda/docker-http-server   "/app"                   14 seconds ago      Up 12 seconds                           k8s_docker-http-server_first-deployment-8cbf74484-jxwzm_default_9c3581ef-9589-478b-8e52-7c347f6ea1c3_0

// docker run -it --pid=container:test-ats --net=container:test-ats --privileged debug-container sh
$ export conname=k8s_docker-http-server_first-deployment-8cbf74484-jxwzm_default_9c3581ef-9589-478b-8e52-7c347f6ea1c3_0
$ docker run -it --pid=container:$conname --net=container:$conname --privileged debug-container sh
sh-4.2#

// 注意"CMD"那一列的值"/app"说明了确实是在目标容器里了。
sh-4.2# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 09:20 ?        00:00:00 /app
root         9     0  0 09:22 pts/0    00:00:00 sh
root        14     9  0 09:22 pts/0    00:00:00 ps -ef
```
