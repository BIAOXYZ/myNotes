
# ray cmd 官方

Monitoring Ray States https://docs.ray.io/en/latest/ray-observability/state/state-api.html

# 远端可以访问 ray dashboard
>> 【[:star:][`*`]】 //notes：只用最基本的命令 `ray start --head` 启动的 ray 集群的控制面板是没法远程访问的。后来在某篇[文章](https://medium.com/@fengliplatform/ray-quick-hands-on-ecf744eb304f)里看到了这句：`ray start --head --include-dashboard 1 --dashboard-host 0.0.0.0 --dashboard-port 8888 --num-cpus 0`。尽管不知道 `--include-dashboard 1` 这个参数有没有起到作用，但是试了下，是可以work的。 —— ***注意看第二次能够远程访问 ray dashboard 的启动方式下，`To monitor and debug Ray, view the dashboard at` 这一句提示信息下面的地址是不一样的***。 <br> 题外话：笔记里我把提示信息里的 `数字ip` 手动换成了 `<your_node_ip>` 的形式。神烦，就是给人增加负担。。。
>>> //notes2：依稀记得好像碰到过用 `pip3 install ray` 安装的ray没有默认带（或者不会默认启动？） dashboard，保险些就用 `pip3 install 'ray[default]'` 来安装。

```sh
$ ray start --head
Usage stats collection is disabled.

Local node IP: <your_node_ip>

--------------------
Ray runtime started.
--------------------

Next steps
  To connect to this Ray runtime from another node, run
    ray start --address='<your_node_ip>:6379'

  Alternatively, use the following Python code:
    import ray
    ray.init(address='auto')

  To see the status of the cluster, use
    ray status
  To monitor and debug Ray, view the dashboard at
    127.0.0.1:8265

  If connection fails, check your firewall settings and network configuration.

  To terminate the Ray runtime, run
    ray stop
$
```
```sh
$ ray start --head --include-dashboard 1 --dashboard-host 0.0.0.0 --dashboard-port 8877
Usage stats collection is disabled.

Local node IP: <your_node_ip>

--------------------
Ray runtime started.
--------------------

Next steps
  To connect to this Ray runtime from another node, run
    ray start --address='<your_node_ip>:6379'

  Alternatively, use the following Python code:
    import ray
    ray.init(address='auto')

  To see the status of the cluster, use
    ray status
  To monitor and debug Ray, view the dashboard at
    <your_node_ip>:8877

  If connection fails, check your firewall settings and network configuration.

  To terminate the Ray runtime, run
    ray stop
$
```
