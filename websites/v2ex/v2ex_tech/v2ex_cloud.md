
Client-Go 免费视频教程来来来了。 https://www.v2ex.com/t/872451
- > 视频地址：https://www.bilibili.com/video/BV1FW4y1m7qH

初学者问一个略显深入的问题： K8S 如何查看 Pod 的 Cgroup https://www.v2ex.com/t/871379
- > 下面这个方式是可以拿到的，AWS EKS 1.22
  ```bash
  kubectl get pods -n namespace -o wide

  ssh ...
  ps -ax | grep nginx | grep -v grep
  cat /proc/$pid/cgroup
  ```

k8s pod 莫名奇妙异常 https://www.v2ex.com/t/862678

k8s pod 可以作为固定的 jenkins agent 吗 https://www.v2ex.com/t/855002
- > k8s pod 作为动态的 agent 是可以的。但考虑 git 代码缓存、maven cache 等如果能作为静态 agent 使用似乎更方便。
- > 用 volume 做 cache 吧 pod 可以随用随销毁
- > agent 之间不建议做共享，会有坑
- > 你直接创建一个 static pod 不就好了。

一个人写的私有云小项目，望大佬指点 https://www.v2ex.com/t/851651
```console
NICLOUD 简介
自己写的私有云小项目， 前端 vue, 后端 golang gin
集成了 libvirt ceph 等
项目地址 https://github.com/niklaus-code/nicloud
```

如何高效掌控 K8s 资源变化？ K8s Informer 实现机制浅析 https://www.v2ex.com/t/808595

关于 k8s 或容器技术相关的博客大家有哪些推荐的？ https://www.v2ex.com/t/802303

问大家一个关于 Pod 中的 Pause 容器的问题 https://www.v2ex.com/t/798088
```console
Pause 容器永远处于 Pause(暂停)状态，这句话应该怎么理解？是跑在一个死循环里吗？
```
- > 看下它源码就行： https://github.com/kubernetes/kubernetes/blob/master/build/pause/linux/pause.c
- > pause 容器本身不做任何事情，只是为了让 pod 在你指定的容器运行前启动以便配置网络等。
- > pause 为你 hold 住一个逻辑的空间，其他 container 可以共享这个空间的网络存储等资源
- > 就是新建个容器，然后之后的容器共享 pause 容器的网络和空间

清理 docker registry 的旧镜像，有什么简单的方法吗？ https://www.v2ex.com/t/779025

Dockerfile 构建的镜像通过 ssh 登录后，环境变量被重置 https://www.v2ex.com/t/778905
```console
直接通过docker exec进去环境变量是正常的，python，pip啥的都有，但通过ssh登录后，啥都没有, 使用场景又是在ssh登录的前提下使用的
目前是手动 ssh 登录进去，命令行执行: export $(cat /proc/1/environ |tr '\0' '\n' | xargs)
有没有一劳永逸的方法，直接在Dockerfile中就搞定环境变量？或者是直接在docker-compose.yml中能处理这个吗
```
- > 問題不是在 docker, 而是 sshd 下的 shell 沒有引用 container 的 enviroment <br> 上面一堆教 Dockerfile 等等的都被樓主帶錯了方向 <br> 用 Google 的話秒查到答案了吧 https://stackoverflow.com/questions/34630571/docker-env-variables-not-set-while-log-via-shell

问问大家关于 k8s 的 deployment 创建过程 https://www.v2ex.com/t/771559
- >
  ```
  我的理解大概就是:
  1. k8s 收到 yaml 内容，验证 yaml 中的属性
  2. yaml 通过验证，然后交给 Development Controller，创建 Pod (名字为 dev name + 随机字符串)，同时创建 ReplicaSet
  3. ReplicaSet 发现 Pod 缺失的时候就会创建新的 Pod 补全 (把 Pod 的 owner reference 设置为 ReplicaSet，Pod 被删除时 ReplicaSet 会收到通知)
  我们现在写 Operator 就是这么做的。
  ```
  ```
  1 楼没写完
  apiserver 校验权限以及 json，将对应的资源写入 etcd 。
  controller 和 scheduler 会 watch api，去调度和创建 rs 等，
  最后是某台主机的 kubelet 会 watch 到 api 中相关的变化，调用本机的 docker api，创建容器和 pod，当然，创建时会先挂载 secret,configmap 或者 pvc 等等
  ```
- >
  ```
  创建 yml 提交到 api server （服务监听 etcd ）
  deploy controller 监听 api server 发现变更创建 rs 到 api server，并维护到 deploy 最终状态
  创建 rs 的时候实际上也是创建 yml，同样的 kube scheduler 在 api server 监听，创建 pod
  这里我觉得主要是考虑服务不可用，所以所有东西都创建在 api server 上，通过 listen 和 pull 的方式监听变更
  ```
- >
  ```
  1. kubectl 提交 yaml 后，首先客户端验证，验证 yaml 的定义是否正确；如果正确的话，生成发给 kube-apiserver 的 request
  2. kube-apiserver 收到 client 发来的 request 之后，进行一些列的 client 认证和鉴权，确保 client 有权限创建资源。
  3. request 被一些列 adminssion controller 拦截，进行一些额外计算和默认值计算，例如设定初始资源需求（如果 client 没有指明的话）。
  4. 创建资源对象，存盘到 etcd
  5. 资源对象存盘后，deployment controller 开始控制 loop，创建 replicaset
  6. relicaset controller 开始创建 pod 资源； pod 对象存入 etcd，进入 pending 状态
  7. scheduler 开始介入，开始检查各种 scheduling 限制（例如 taint，affinity ）和资源需求，然后找到可以满足这些条件的 node 。找到 node 后，创建一个 binding 对象，发还给 kube-apiserver，pod 进入 scheduled 状态。
  8. node 上的 kubelet 会定时查询 apiserver，收到 pod 创建事件后，开始在 node 上启动 pod 的准备工作。这里过程包括，准备存储，拉去 image pull secret 等。
  9. kubelet 通过 CRI 通知容器运行时（例如 docker ）启动一个父容器。这里的容器会处于暂停的阶段（直到所有设置完成）
  10. kubelet 通过 CNI 设置容器的网络
  11. 所有设置完成后，开始创建真正的应用容器，包括 init container 和用户指明的其他容器
  12. 完成工作。
  
  我的理解是，这个整个过程有点像是个状态机。
  
  参考文献： https://github.com/jamiehannaford/what-happens-when-k8s
  ```

大家有没有搞过有状态应用上 K8S https://www.v2ex.com/t/770562

docker build go 项目每次都很慢，有什么好的办法吗？ https://www.v2ex.com/t/731045

有大佬用过 Gitlab 的 CICD 吗 https://www.v2ex.com/t/722305

K8S 使用 nodePort 方式暴露服务，发现没有负载均衡的效果，都请求到了一个 pod 里， 求教问题出在哪里？ https://www.v2ex.com/t/715363
- > 可以看看这个文章 《Kubernetes 网络插件工作原理》 http://blog.jwangkun.com/post/IC6DrTsc6/

k8s 拉取私有仓库的镜像时出错 https://www.v2ex.com/t/713336

小白求问： k8s 能生成相同 pod 的不同版本吗？ https://www.v2ex.com/t/713259

Kubernetes 下如何方便地获取不断重启的服务的日志 https://www.v2ex.com/t/713435
- > 容器的话 stdout/stderr 输出的日志可以搜集到 ELK 或者其余后端存储
- > 日志管理直接上 ELK 。“让服务检测机制临时失效” 可以通过修改 YAML 实现，比如让 probes 返回正常，在 command args 里用 bash -c "your-service; tail -f /dev/null" 等待

请问 k8s 如何将 pod 均匀调度到每个 node 上 https://www.v2ex.com/t/699835

k8s 该怎么在多个 replica 的情况下只让其中一个接受流量 https://www.v2ex.com/t/694433
- > 你就起一个 pod 不就好了
  >> LZ回复：但是挂掉时就没法快速切换另一个上。。启动再快也需要时间
  >>
  >> LZ回复：想要达到的效果是能无缝切换，自动重启的话用户的体验可能就会差，重启能被感知
- > 提供一个思路：利用 readinessProbe <br> 从节点定时检测主节点是否存活，存活的话该检测提供失败返回，就不会被 k8s 分配流量，同时也不会被杀死。
- > 用 APIServer 里的资源对象来实现分布式锁，锁释放下一个顶上

关于一个超简单 CIDR 问题，云安全组不知如何写 https://www.v2ex.com/t/693186

Dockerfile 如何传递环境变量文件并执行？ https://www.v2ex.com/t/689312

问一个奇怪的 K8S 集群网络问题 https://www.v2ex.com/t/687268

求教 K8S 架构上如何通过等保三 https://www.v2ex.com/t/685966

k8s 支持桥接不 https://www.v2ex.com/t/685911

用 docker 隔离不同用户 https://www.v2ex.com/t/681633

docker、docker-compose 部署 gitlab,如何配置 https,让 git clone 地址与域名一样不带端口号 https://www.v2ex.com/t/681458

论 sidecar 模式的可行性 https://www.v2ex.com/t/678524

求助，如何让 k8s 的 pod 访问外网的时候从指定网卡出去，求大神看看我这么配置为什么不行 https://www.v2ex.com/t/677765
- > 多半是 rp_filter。rp_filter 有三个值:0/1/2, 具体含意如下:
  ```
  0: 关闭反向路由校验.
  1: 开启严格的反向路由校验. 对每个进来的数据包, 校验其反向路由是否是最佳路由. 如果反向路由不是最佳路由, 则直接丢弃该数据包.
  2: 开启松散的反向路由校验. 对每个进来的数据包, 校验其源地址是否可达, 即反向路由是否能通(通过任意网卡), 如果反向路径不通, 则直接丢弃该数据包.

  当 rp_filter 的值为 1 时, 要求反向路由的出口必须与数据包的入口网卡是同一块, 否则就会丢弃数据包.
  当 rp_filter 的值为 2 时, 要求反向路由必须是可达的, 如果反路由不可达, 则会丢弃数据包.
  把 rp_filter 值设为 0, 关闭反向路由校验:

  for x in /proc/sys/net/ipv4/conf/*/rp_filter
  do
  echo 0 > "${x}"
  done

  查看效果:
  cat /proc/sys/net/ipv4/conf/*/rp_filter
  ```
- > kube-proxy –proxy-mode=iptables 与 rp_filter 冲突 http://julyclyde.org/?p=528

国内有便宜靠谱的 kubernetes 服务吗？ https://www.v2ex.com/t/676056
- > 阿里云上有 serverless k8s 挺不错的只收取容器所占的硬件资源费用
- > 腾讯云的貌似也只是机器收费，集群服务免费
- > kubesail 有免费阶层可以使用，也有付费的，大概 7 刀一个月。
  >> KubeSail https://kubesail.com/

考了容器相关的 CKA 证书，攻略附上供大家参考 https://www.v2ex.com/t/669347
> kodekloud 免登陆练习 https://kodekloud.com/courses/certified-kubernetes-administrator-with-practice-tests/lectures/9816528

centos7 防火墙失效，这是怎么回事？ https://www.v2ex.com/t/657565
- > 这个问题在 Docker 官方文档中说的很明白，显然你是没有阅读官方文档就直接使用的 Docker 。
    <br> Docker 自动设定的 iptables 规则 [DOCKER-USER DOCKER] 比你手动设定的 iptables/firewalld 规则优先级要高，所以除非把规则添加到上述 [] 中才能生效。
    <br> 不过如果你嫌麻烦还可以：
    <br> 0.如果需要外网访问，可在容器内设定防火墙；
    <br> 1.如果不需要外网访问 /爷就喜欢宿主防火墙，Docker 绑定 0.0.0.0 改为 127.0.0.1 。(●'◡'●)
- > 可以禁止 docker 修改 iptables, 编辑 /etc/docker/daemon.json, 添加
    ```
    {
     "iptables": false
    }
    ```

serverless 底层技术是什么 https://www.v2ex.com/t/578918
- > 可以看一下这篇文章，作者尝试去获取 AWS Lambda 应用运行在什么环境里 [如何探测虚拟环境是物理机、虚拟机还是容器？](https://www.infoq.cn/article/536L*XPRudOwCkiTDgM4)
- > aws 有公布过部分的细节，可以看一下 blog。之前开源过 FireCracker，说是 lambda 的基础组件：[亚马逊AWS官方博客宣布推出 Firecracker 开源技术：适用于无服务器计算的安全、快速的 microVM](https://aws.amazon.com/cn/blogs/china/firecracker-open-source-secure-fast-microvm-serverless/)。阿里云无服务器函数印象中似乎是基于 Docker 的，不过似乎没看到一些相关的技术细节介绍

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
