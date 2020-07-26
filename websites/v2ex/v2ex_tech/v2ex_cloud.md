
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
