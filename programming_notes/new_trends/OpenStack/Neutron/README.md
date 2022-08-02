
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
- > **4.2.2.1.2 `qbr` 及 `br-int`**
  * > ***VM 与 qbr 之间通过 `TAP` 连接，qbr 与 br-int 之间，通过 `VETH pair` 连接***。TAP， VETH pair，我们就讲述了，您可以参见相关章节。
  * > qbr 与 br-int 都是 bridge。***`qbr` 的实现载体是 Linux Bridge***，就是我们说的“X86/Linux”原生实现。br-int 的实现载体，也是“X86/Linux”实现，只是不能算作“原生”实现，***因为 `br-int` 的实现载体是 `OVS`（Open vSwitch）***，OVS 是在“X86/Linux”的基础上，又做了一层封装（可以用封装这个词，虽然它写了很多代码）。关于 OVS 笔者也写了相关文章，笔者这里就不再啰嗦。（其实，关于 OVS，我还没有写完，^_^）
  * > 这里强调一点，并不是绝对地说，qbr 就一定是 Linux Bridge，br-int 就一定是 OVS，您也可以用自己的实现方式来替换他们，只不过，这样的实现方式，是当前 OpenStack 解决方案的经典方式而已。在没有更好地实现方式之前，这个也可以说是唯一的实现方式。
  * > ***`qbr` 这个缩写比较有意思，它是 `Quantum Bridge` 的缩写***，而 OpenStack 网络组件的前一个商标名就是Quantum，只不过由于版权的原因，才改为 Neutron。从这个称呼我们也能看到 Neutron 里面 Quantum 的影子。
  * > ***`br-int`，表示的是 `Integration Bridge`， `综合网桥`。到底“综合”了哪些内容，我们这里先不纠结，我们就当作它是一个普通的 bridge，不过实现载体是 OVS 而已***。
  * > 这里面有个问题：***为什么需要两层 bridge？***<ins>***VM 先接 `qbr`（Linux Bridge），`qbr` 再接 `br-int`（OVS）***</ins>，为什么不是 VM 直接接入 br-int？这个原因是：
    + > （1）如果只有一个 qbr，由于 qbr 仅仅是一个 Linux Bridge，它的功能不能满足实际场景的需求（具体哪些场景，我们在后面涉及到时会点到）。毕竟，br-int 的名号，不是瞎取的，^_^
    + > （2）如果只有一个 br-int，由于 br-int 实际是一个 OVS，而 OVS 比较任性，它到现在竟然还不支持基于 iptables 规则的安全组功能，而 OpenStack 偏偏是要基 iptables 规则来实现安全组功能！
  + > 所以，OpenStack 引入 qbr，其目的主要就是辅助 iptables 来实现 security group功能（qbr 有时候也被称为`安全网桥`）;引入 br-int，才是真正为了实现一个`综合网桥`的功能。
- > **4.2.2.1.3 `br-ethx`**
  * > ***`br-ethx` 也是一个 bridge，也是一个 OVS，它的含义是：`Bridge, Ethernet, External`***。顾名思义，br-ethx 负责与“外”部通信，这里的“外”部指的是 Host 外部，但是属于一个 Network（这个 Network 指的是 Neutron 的概念）的内部，对于本小节而已，指的是 VLAN 内部。这非常关键，后面我们还会涉及到“外”部另外的概念。
  * > 值得注意的是，br-ethx 上的接口（图中是“G”），是一个真正的 Host 的网卡接口（NIC Interface， Interface in Network Interface Card）。网卡接口，是网卡物理口上的一个 Interface。确实也应该这样，不然，网络流量如何才能进出一个 Host 呢？
- > **4.2.2.1.4 VLAN 转换**
  * > 我们在“VM 及 VLANID”那一小节中，讲述了 VLANID 有内外之别，这里我们讲述一下这个内外 VLANID 的转换。如下图所示：

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
- > **4.1 network**
  * > **flat**
​    + > flat网络是无vlan tagging的网络。flat网络中的instance能与位于同一网络的instance通信，并且可以跨多个节点。
  * > **vlan**
    + > vlan网络是具有802.1q tagging的网络。vlan是一个二层的广播域，同一vlan中的instance可以通信，不同vlan只能通过router通信。vlan网络可以跨节点，是应用最广泛的网络类型。
  * > **vxlan**
    + > vxlan是基于隧道技术的overlay网络。vxlan网络通过唯一的segmentation ID（也叫VNI）与其他vxlan网络区分。vxlan中数据包会通过VNI封装成UPD包进行传输。因为二层的包通过封装在三层传输，能够克服vlan和物理网络基础设施的限制。
    + > vxlan和vlan相比的优势：
      ```console
      租户数量从4K增加到16M——支持数量增大；
      租户内部通信可以跨越任意IP网络，支持虚拟机任意迁移——跨网络通信；
      一般来说，每个租户逻辑上都有一个网关实例，IP地址可以在租户间进行复用——重复使用不冲突；
      能够结合SDN技术对流量进行优化——支持与其他技术结合应用
      ```
  * > **gre**
    + > gre是与vxlan类似的一种overlay网络。主要区别在于使用IP包而非UDP进行封装。
    + > 不同network之间在二层上是隔离的。
- > **五、Neutron的主要功能**
- > **5.1二层交换VSwitch**
  * > Neutron支持多种虚拟交换机，包括Linux原生的Linux Bridge和Open vSwitch。
  * > Open vSwitch（OVS）是一个开源的虚拟交换机，它支持标准的管理接口和协议。
  * > 利用Linux Bridge和OVS，Neutron除了可以创建传统的VLAN网络，还可以创建基于隧道技术的Overlay网络，比如VxLAN和GRE（Linux Bridge目前只支持VxLAN）。
- > **5.2三层路由VRouter**
  * > 实例可以配置不同网段的IP，Neutron的VRouter（虚拟路由器）实现实例可跨网段通信。一般可以通过IP forwarding、iptables等技术来实现路由和NAT。
- > **5.3负载均衡Load Balance**
- > **5.4防火墙Firewall**

透过现象看本质——谈谈ML2 plugin这回事儿 https://blog.51cto.com/u_14557673/2478779
- > **Neutron Plugin是个什么鬼？**
  * > 我们知道，在OpenStack中，总的来说插件的作用可以理解为：
    + > 处理Neutron Server发来的请求；
    + > 维护OpenStack中网络的状态；
    + > 调用agent处理请求；
  * > 由此也可以明白，在OpenStack Neutron项目中，插件和代理服务是相对应的，而且plugin解决的是在数据库中存放网络信息，需要解决的是网络请求时需要什么配置的问题，而agent解决的是如何具体配置网络的问题，而agent处理时需要通过Neutron provider（网络提供者）提供虚拟或物理网络（Linux Bridge或OVS或其他的物理交换机），也可以说这三者需要配套使用。
  * > 细的来说，Neutron Plugin 有两种，一种是Core Plugin——核心插件,主要是在数据库中维护network、subnet和port的状态，并负责调用相应的agent在network provider上执行相关操作，比如创建network；另一种是Service Plugin——服务插件，主要是在数据库中维护router、load balance、security group等资源的状态，并负责调用相应的agent在network provider上执行相关操作，比如创建router。

透过现象看本质——谈谈L2 agent 这回事儿 https://blog.51cto.com/u_14557673/2479123
- > **（1）基于Linux Bridge的单一flat网络**
  * >  Linux Bridge需要和虚拟机实例建立网络连接，就需要通过一个设备（接口）作为介质，这个设备（接口）就是`tap`。***其实`tap`经常与`tun`一起谈及，二者都属于操作系统内核中的虚拟网络设备（注意！linux中一切皆文件），只不过`tap`位于二层，而`tun`位于三层，而它们之间的差别仅仅在于数据结构封装中的flag不一样而已，这也是如何区分它们的方法，但是它们二者所承载的功能相差甚远***。本文篇幅有限，就不继续深究了。只需要知道tap所对应的数据链路层协议为以太网协议（IEEE 802.3），因此tap设备有时候也被称为"虚拟以太设备"。
  * > `tap`实现linux网桥与虚拟机实例之间的网络通信，构建了整个基于Linux Bridge的单一`flat网络`。
- > **（2）基于Linux Bridge 的vlan网络**
- > **（3）基于OVS的vlan网络**

Openstack Neutron网络实验-03 http://lprincewhn.github.io/2016/04/04/neutron03.html

GRE与Vxlan网络详解 https://www.cnblogs.com/xingyun/p/4620727.html
- > **1.2 Neutron中的GRE**
- > **2.2 Neutron中的vxlan**
  * > ( http://www.opencloudblog.com/?p=300 ) vxlan的br-tun流表与上面GRE类似。
