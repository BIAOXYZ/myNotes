
# 官方

OpenStack Networking (Neutron). Mirror of code maintained at opendev.org. https://github.com/openstack/neutron
- https://github.com/openstack/neutron/tree/stable/stein

Neutron https://wiki.openstack.org/wiki/Neutron

网络 https://docs.openstack.org/zh_CN/user-guide/sdk-neutron-apis.html

# 系列文章

## `世民谈云计算`

Neutron 理解 (2): 使用 Open vSwitch + VLAN 组网 [Neutron Open vSwitch + VLAN Virtual Network] https://www.cnblogs.com/sammyliu/p/4626419.html

Neutron 理解 (3): Open vSwitch + GRE/VxLAN 组网 [Netruon Open vSwitch + GRE/VxLAN Virutal Network] https://www.cnblogs.com/sammyliu/p/4627230.html

## `网事如烟云`

深入理解 OpenStack Neutron https://mp.weixin.qq.com/s/jNPEs1bKInoWAAVKv273Fw

深度探索 OpenStack Neutron：Neutron 实现模型 https://mp.weixin.qq.com/s/-IsfBvXgLOLVRWK93pzvfg || 深度探索 OpenStack Neutron：Neutron 实现模型（1） https://mp.weixin.qq.com/s/oWy5ZjR2F1TZAw6Fr_SQ5Q
- > **第四章 Neutron 网络实现模型**
  * > Neutron 的模型有两种。
  * > 一种是抽象的逻辑模型，比如我们耳熟能详的“Network，Subnet，Port”等等，读者可以参考“https://developer.openstack.org/api-ref/networking/v2/”，有个直观认识。
  * > 另一种模型是这种抽象逻辑模型背后的实现模型。无论一个模型多抽象还是多具体，其归根到底总归要有一个实现它的载体。比如 CloudVPN，OPEN-O 这个开源组织，就通过一系列的网元和一定的组网来实现，如下图所示：

深度探索 OpenStack Neutron：Neutron 架构分析（2） https://mp.weixin.qq.com/s/seB1h0NbD5H1RVZgZ5uxdQ
- > **3.3 Neutron 的 Agents**
  * > ***Neutron Server 接到 RESTful API 业务请求后，会调用 Plugins 的相应接口，进行Neutron数据库的相关操作，同时，Plugins 还会通知对应的 Agents 进行这些网元的配置操作***。“这些网元”，指的是图中的 `br-ethx/br-tun`, `br-ex`, `DHCP`, `Router` 等等。
  * > 每一个 Agent 都是一个进程，部署在相应的网络节点或者计算节点上。在配置文件“`neutron.egg-info/entry_points.txt`”中，定义了这些 driver 的具体实现，比如：
    ```console
    neutron-dhcp-agent = neutron.cmd.eventlet.agents.dhcp:main
    neutron-l3-agent = neutron.cmd.eventlet.agents.l3:main
    neutron-openvswitch-agent = neutron.cmd.eventlet.plugins.ovs_neutron_agent:main
    ```
  * > 从 RPC 的角度，每一个 agent 都是一个 RPC Server（AMQP Consumer），处理相应的 Plugin 发送过来的 RPC 请求。同时，它还是一个 AMQP Producer，反过来调用相应的 Neutron Server 的 RPC 接口，以获取相关信息。
  * > Neutron 采用的是 dnsmasq 来实现 DCHP Service，DHCP Agent 的本质，就是调用 dnsmasq 相应的命令行，进行 DHCP Server 的启停动作，比如下面的命令行就是启动 dnsmasq：
  * > Neutron 也正是借用 Linux 的内核实现“实现路由转发和 SNAT/DNAT”这两个 L3（router）功能。为了做到租户隔离，每一个 router 都被 Linux 的 namespace 进行隔离。也就是说，Neutron 的一个个 L3 Service，其本质上也就是一个个 naemsapce 而已 。
  * > 一个 L3 Service 的创建，从命令行角度来说，就是创建一个 namespace，再加上打开这个 namespace 的转发开关以及配置相应的 SNAT/DNAT 规则。
  * > 删除一个 L3 Service，从命令行角度来说，就是删除一个 namespace。
  * > 在 OVS Agent 代码中，涉及三类 bridge，它们与图中的 bridge 对应关系，如下表所示：

    | OVS Agent bridge 类型 | Neutron 实现模型中的 bridge 类型 |
    |--|--|
    | br-int | br-int |
    | br-tun | br-tun |
    | physical bridge | br-ethx，br-ex |

  * > OVS Agent 会部署在每一个计算节点及网络节点。OVS Agent 在启动时，会首先在每个 Host 上创建这些 bridge（如果还没有创建的话），并建立好各个 `br-tun` 之间的隧道。
  * > 当一个 RPC 请求过来时，比如 port_update 消息，OVS Agent 所要做的是配置对应 bridge 上的内外 VLANID 的转换规则，如下图所示：
- > **第四节 Neutron 的总体架构**

# 其他

OpenStack入门之核心组件梳理（5）——Neutron篇 https://blog.51cto.com/u_14557673/2477886

Openstack Neutron网络实验-03 http://lprincewhn.github.io/2016/04/04/neutron03.html
