
# 1. 本地单台机器 docker 方式手动搭建 ray 集群

## ~~1.1~~ 【如果纯 docker 方式还是用 ray 官方提供的镜像吧，比自己这种手动方式方便多了。】

使用Ray集群简单创建Python分布式应用程序 https://www.jb51.net/article/222831.htm || 如何用 Python 实现分布式计算？ https://cloud.tencent.com/developer/article/1924875

```sh
# 1.启动容器
docker pull ubuntu
## head 节点的容器可以把 ray dashboard 的端口暴露出去，方便 host 或者能访问 host 的远端机器查看集群状态
docker run -itd --name ubuntu-00 -p 8265:8265 ubuntu bash
docker run -itd --name ubuntu-01 ubuntu bash
docker run -itd --name ubuntu-02 ubuntu bash

# 2.安装 ray
## 三个容器里每个都是下面这套命令：
apt update
apt install -y python3 python3-pip
pip3 install 'ray[default]'

# 3.启动ray集群
## head 节点执行
ray start --head --include-dashboard 1 --dashboard-host 0.0.0.0
## 其他节点执行
ray start --address='<your_node_ip>:6379'

# 选装的包
## ip
sudo apt install -y iproute2
## ping
sudo apt install -y iputils-ping
## nc
sudo apt install -y netcat
sudo apt install -y lsof
```

## 1.2

RAY: AN OPEN-SOURCE API FOR EASY, SCALABLE DISTRIBUTED COMPUTING IN PYTHON – PART 2 DISTRIBUTED SCALING http://www.andrewjanowczyk.com/ray-an-open-source-api-for-easy-scalable-distributed-computing-in-python-part-2-distributed-scaling/
- > **Setting up Ray in Docker**
  * > After pulling the docker image on both machines, we need to start a container. I’ll be using this command on both machines (for simplicity), which i discuss the particular parameters for below:
    ```sh
    docker run --shm-size=2g -t -i -v`pwd`:/data -p8888:8888 -p6379:6379 -p10001:10001 -p8265:8265 rayproject/ray
    ```
    > Then we have a series of port forwardings, these are a combination of those which are needed for our local environment container (i.e., ***in windows we want port 8888 so we can use jupyter***) and for the server (i.e., in linux we open `8265` so we can access the Ray dashboard, `6379` so we can add nodes to this cluster, and `10001` so we can use this cluster, to be explained more below). You can be more refined/secure and open up only the ports needed.
    >> 【[:star:][`*`]】 //notes：所以 8888 端口不是必须的，但是剩下三个端口都是必须的（当然你可以换成其他端口号）。***`6379` 不用多说了，想添加节点需要用；`8265` 之前踩过坑了，不暴露这个端口，容器外面看不了 ray dashboard；`10001` 这个是因为不暴露这个，容器外面（不管你是在 host 还是远端）无法用 ray 集群执行任务***。

PS：从[官方文档](https://docs.ray.io/en/latest/ray-observability/ray-metrics.html)来看，是不是 `9090`（for `Prometheus`）和 `3000`（for `Grafana`）最好也暴露下。。。

***个人文章实战***：
```sh
docker pull rayproject/ray
docker run -itd --name rayhead -p8888:8888 -p6379:6379 -p10001:10001 -p8265:8265 rayproject/ray
docker run -itd --name raynode1 rayproject/ray
docker run -itd --name raynode2 rayproject/ray

docker exec -it rayhead bash
ray start --head --dashboard-host=0.0.0.0
exit

docker exec -it raynode1 bash
ray start --address='<your_node_ip>:6379'
exit

docker exec -it raynode2 bash
ray start --address='<your_node_ip>:6379'
exit
```

```py
import ray
# 如果是在容器所在的主机上执行任务，那么可以用下面这行，也就是地址直接用 127.0.0.1 都可以。
# ray.init(address='ray://127.0.0.1:10001')
ray.init(address='ray://<your_node_ip>:10001')

@ray.remote
def add(a, b):
    return a + b

x = 5
y = 3
tmp = add.remote(x, y)
z = ray.get(tmp)
print(z)
```
```sh
# 在另一台远端主机上
$ python3 raytest.py 
8
```

# 2. 本地单台机器 docker-compose 方式搭建 ray 集群

What is best practice for local setup? https://discuss.ray.io/t/what-is-best-practice-for-local-setup/6507
