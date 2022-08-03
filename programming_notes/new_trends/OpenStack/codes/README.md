
# 综合

## `int32bit`

【[:star:][`*`]】 如何阅读OpenStack源码 - int32bit的文章 - 知乎 https://zhuanlan.zhihu.com/p/28959724
- > 如果你对OpenStack的其它服务以及操作流程感兴趣，可以参考我的openstack-workflow项目, 这个项目是我本人在学习过程中记录，绘制成序列图，上图就是其中一个实例。项目地址为: https://github.com/int32bit/openstack-workflow

## `www.hanbaoying.com`

【[:star:][`*`]】 虚拟机迁移之热迁移(live_migrate) https://www.hanbaoying.com/2016/05/03/%E8%99%9A%E6%8B%9F%E6%9C%BA%E8%BF%81%E7%A7%BB%E4%B9%8B%E7%83%AD%E8%BF%81%E7%A7%BB(live_migrate).html

openstack Restful and RPC https://www.hanbaoying.com/2016/05/12/openstack-restful(nova-api).html
- > **简介**
  * > OpenStack的通信方式有两种，一种是基于HTTP协议的RESTFul API方式，另一种则是RPC调用。
  * > 两种通信方式的应用场景有所不同：
    + > ***RESTFul API主要用于各组件之间的通信（如nova与glance的通信）***
    + > ***RPC用于同一组件中不同模块间的通信（如nova组件中nova-compute与nova-scheduler）***。

## `jmilkfan-fanguiju`

https://www.cnblogs.com/jmilkfan-fanguiju/category/1427543.html
- OpenStack 虚拟机冷/热迁移的实现原理与代码分析 https://www.cnblogs.com/jmilkfan-fanguiju/p/10589712.html
- OpenStack 虚拟机冷/热迁移功能实践与流程分析 https://www.cnblogs.com/jmilkfan-fanguiju/p/10589715.html

https://www.cnblogs.com/jmilkfan-fanguiju/category/1080478.html
- openstack nova 源码解析 — Nova API 执行过程从(novaclient到Action) https://www.cnblogs.com/jmilkfan-fanguiju/p/7532328.html

我非要捅穿这 Neutron（一）网络实现模型篇 https://www.cnblogs.com/jmilkfan-fanguiju/p/10589719.html || https://www.bbsmax.com/A/ZOJP8G3OJv/

我非要捅穿这 Neutron（二）上层资源模型篇 https://www.cnblogs.com/jmilkfan-fanguiju/p/10589718.html || https://www.bbsmax.com/A/rV57QZ8jzP/

我非要捅穿这 Neutron（三）架构分析与代码实现篇（基于 OpenStack Rocky） https://www.cnblogs.com/jmilkfan-fanguiju/p/10589717.html || https://www.bbsmax.com/A/kjdwO7VqdN/

我非要捅穿这 Neutron（四）Open vSwitch in Neutron https://www.cnblogs.com/jmilkfan-fanguiju/p/11825076.html || https://www.bbsmax.com/A/Vx5MZVo3dN/

## 综合类其他

【From yikun.github.com】
- OpenStack-Nova虚拟机冷迁移流程解析.md https://github.com/Yikun/yikun.github.com/blob/hexo/source/_posts/OpenStack-Nova%E8%99%9A%E6%8B%9F%E6%9C%BA%E5%86%B7%E8%BF%81%E7%A7%BB%E6%B5%81%E7%A8%8B%E8%A7%A3%E6%9E%90.md || https://yikun.github.io/2017/10/11/OpenStack-Nova%E8%99%9A%E6%8B%9F%E6%9C%BA%E5%86%B7%E8%BF%81%E7%A7%BB%E6%B5%81%E7%A8%8B%E8%A7%A3%E6%9E%90/
- OpenStack-Nova虚拟机创建流程解析.md https://github.com/Yikun/yikun.github.com/blob/hexo/source/_posts/OpenStack-Nova%E8%99%9A%E6%8B%9F%E6%9C%BA%E5%88%9B%E5%BB%BA%E6%B5%81%E7%A8%8B%E8%A7%A3%E6%9E%90.md
- OpenStack源码分析-挂载卷流程.md https://github.com/Yikun/yikun.github.com/blob/hexo/source/_posts/OpenStack%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%90-%E6%8C%82%E8%BD%BD%E5%8D%B7%E6%B5%81%E7%A8%8B.md

OpenStack https://blog.csdn.net/bill_xiang_/category_6444961.html
- 开启OpenStack社区贡献之路 https://blog.csdn.net/Bill_Xiang_/article/details/52719234
- OpenStack公共组件oslo之六——oslo.messaging https://blog.csdn.net/Bill_Xiang_/article/details/78500769
- OpenStack Trove组件WSGI和RPC调用流程 https://blog.csdn.net/Bill_Xiang_/article/details/72909927

# 创建虚拟机

OpenStack创建虚拟机流程 https://www.cnblogs.com/luohaixian/p/12368164.html

openstack创建虚拟机源码阅读 https://segmentfault.com/a/1190000015371691

OpenStack虚拟机创建的50个步骤和100个知识点 https://mp.weixin.qq.com/s/XIoh9stHIGLrtlAKac9IZA

从数据库分析OpenStack创建虚机流程 https://mp.weixin.qq.com/s/5kdkeC3LRWdSvRULKMjW0A || https://www.sdnlab.com/21244.html

【From 码农这些事儿】
- OpenStack 源码阅读－创建虚拟机（一） https://mp.weixin.qq.com/s/JuwZxf9xF_QZWI1SUsEWyA
- OpenStack源码阅读－创建虚拟机（二） https://mp.weixin.qq.com/s/Vb-UCl2B61f-ITOpD0luTQ
- OpenStack源码阅读－创建虚拟机（三） https://mp.weixin.qq.com/s/z-b-jz6DEy-Ivz36KBr8jA

# 迁移

OPENSTACK之虚机热迁移代码解析 https://www.cnblogs.com/voidy/p/4056329.html

Openstack R版热迁移代码封装实现研究 https://blog.csdn.net/jmz19910110/article/details/115304610 || https://pythontechworld.com/article/detail/YipvODWNhn51

OpenStack源码学习笔记6 https://www.hi-roy.com/posts/openstack%E6%BA%90%E7%A0%81%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B06/

openstack源码分析 https://blog.csdn.net/comprel/category_8812446.html
- openstack-nova源码分析(九）冷迁移 https://blog.csdn.net/comprel/article/details/97616533

OpenStack https://blog.csdn.net/qq_33909098/category_9573005.html
- openstack冷迁移/Resize源码分析（一） https://blog.csdn.net/qq_33909098/article/details/118578133
- openstack冷迁移/Resize源码分析（二） https://blog.csdn.net/qq_33909098/article/details/118960184 || https://codetreasures.com/blog/detail/emQnwGpRtX

Nova组件源码分析之冷迁移与Resize https://itcn.blog/p/2010401099.html

OpenStack内存迁移简介 https://blog.csdn.net/huang987246510/article/details/110535704
- > OpenStack引入WSGI（Web Server Gateway Interface）用来将HTTP到后端对应操作的映射以一种标准的接口实现，在WSGI中，每个资源被抽象成一个Controller对象，它包含很多操作，每个操作对应一个HTTP请求和响应。当HTTP请求到达时，WSGI首先将其路由到对应的Controller，调用Controller对应的操作函数，这是一个通用的操作。对于想要添加一个API的开发者来说，它会将其对应的实现封装成Controller的子类，在WSGI框架的调用流程中，会根据HTTP请求的不同最终调用到开发者自己提供的接口。

# 网络

Nova中VIF的实现 http://niusmallnan.com/_build/html/_templates/openstack/nova_vif.html
- > VM安装完成后，需要为其设置网络接口，以便和主机网络，VM之间的网络通信。
- > KVM 客户机网络连接主要有两种方式:
  * > 用户网络(User Networking): 让虚拟机访问主机、互联网或本地网络上的资源的简单方法，***但是不能从网络或其他的客户机访问客户机***，性能上也需要大的调整。NAT方式，***虚拟机利用host机器的ip进行上网，对外显示一个ip***。
  * > 虚拟网桥(Virtual Bridge): 这种方式要比用户网络复杂一些，但是设置好后客户机与互联网，客户机与主机之间的通信都很容易。Bridge方式，将虚拟机桥接到host机器的网卡上，***VM和host机器都通过bridge上网，对外不同的ip***。
- > 那么在Openstack的云环境中，很明显Bridge模式更适合虚拟机网络，因为这样外部网络可以直接能访问到VM。

Neutron Core Plugins - ML2 https://blog.mazhangjing.com/2021/06/22/neutron-plugin/

openstack开发实践（六）：Neutron源码解析 https://blog.csdn.net/weixin_41977332/article/details/104856575
- > 从中我们可以看出Neutron中的组件可以分为4种
  * > 2.**Plugins**: 负责管理Agents，Neutron Plugin继承自`neutron/neutron_plugin_base.py`，代码如下图所示，实现其中定义的CRUD操作。在Neutron的早期版本种有很多针对各种底层交换机实现的Plugins，比如Linux Bridge Plugin、Open vSwitch Plugin等，如今的Neutron版本中引入了ML2 Plugin，各个交换机相关的代码转移到ML2 Plugin下一级的Mechanism Drivers中。ML2 Plugin的Driver分为两种：`Type Drivers`和`Mechanism Drivers`。***Type Drivers定义了Neutron的网络类型***，Neutron目前支持的网络类型包括Local网络（类似VirtualBox中的Host-only网络），Flat网络（所有虚机都处在同一个二层网络中），VLAN网络（网络拓扑结构和Flat模式类似，但是每个玩网络都带有VLAN ID），VXLAN网络（可以使用VxLAN协议在计算节点之间建立Overlay网络），GRE网络（使用GRE协议在计算节点之间建立Overlay网络）。***Mechanism Drivers可以对接各种二层网络技术和物理交换设备***。Neutron支持在一个虚拟网络中同时使用多种Type Driver和Mechanism Drivers。
  * > 3.**Agents**：向虚拟机提供二层和三层的网络联通，处理逻辑网络和物理网络之间的转换、同时也提供一些拓展服务。***Agents包括提供二层网络联通服务的Layer 2 agents，比如`Linux Bridge`和`OVS`；提供三层IP和路由服务的Layer 3 agents，比如`L3`和`DHCP`；***提供一些杂项服务的Miscellaneous agents，比如Metadata；
- > 上图所示为neutron源码的目录结构，这里主要讲解一下plugins、agent，里面包含了neutron中plugins和agent实现源码。plugins目录如下所示，在Neutron中，实现一个插件包括两部分内容，一部分是与数据库db打交道的，称为plugin，另一部分是调用具体的网络设备真正干活的，称为agent。与db交互的plugin在功能上有很多重复，所以在代码上有很多重复，因此ml2目录下提供了一个与数据库交互的公共plugin，即`plugins/ml2/db.py`，部分代码截图如下所示
- > **Neutron启动分析**

OpenStack中创建路由过程，代码和Linux主机的分析。 https://blog.csdn.net/mr1jie/article/details/102669333

OpenStack干货分享 | Neutron源码分析之L3 https://mp.weixin.qq.com/s/HuozAW0fvOr5JeX4PRwyZQ || https://www.sohu.com/a/122957372_573950 || https://icode.best/i/16560143163894

openstack系列之--neutronclient源码分析 https://mp.weixin.qq.com/s/dTxfSlfCASSJt4c8yfPSfg

【转载并修改】OpenStack Neutron源码分析：ovs-neutron-agent启动源码解析 https://www.cnblogs.com/qxxnxxFight/p/10791714.html

Neutron https://www.aboutyun.com/forum-192-1.html
- Neutron分析（1）——neutron-server启动过程分析 https://www.aboutyun.com/thread-9527-1-1.html
- openstack Neutron分析（2）—— neutron-l3-agent https://www.aboutyun.com/thread-9529-1-1.html

# 其他

OpenStack Nova 架构及源码分析 https://jckling.github.io/2021/05/23/OpenStack/OpenStack%20Nova/
- > **整体架构**
  * > nova 和其他组件之间的交互使用 HTTP 请求
  * > 内部组件之间使用 `oslo_messaging` 库实现 RPC 调用，这里还涉及消息队列 `RabbitMQ` ，遵循 AMQP 协议
  * > 大部分 nova 组件都可以运行在多个服务器上，然后使用一个管理器监听 RPC 消息
  * > 而 nova-compute 是运行在计算主机上的单进程，用于管理计算资源
  * > nova 内部组件共享本地数据库，通过对象层访问，确保兼容性和安全性
  * > nova-compute 访问数据库由 nova-conductor 代理
  * > 当用户发起一个新的请求时，该请求会先在 nova-api 中处理。nova-api 会对请求进行一系列检查，包括请求是否合法，配额是否足够等；当检查用过后，nova-api 就会为该请求分配一个唯一的虚拟机 ID ，并在数据库中新建对应的项来记录虚拟机的状态；然后，nova-api 会将请求发送给 nova-conductor 处理。
  * > nova-conductor 主要管理服务之间的通信并进行任务处理。它在接收到请求之后，会为 nova-scheduler 创建一个 RequestSpec 对象用来包装与调度相关的所有请求信息，然后调用 nova-scheduler 服务的 select_destination 接口。
  * > nova-scheduler 通过接收到的 RequestSpec 对象，首先将 RequestSpec 对象转换成 ResourceRequest 对象，并将该对象发送给 Placement 进行一次预筛选，然后会根据数据库中最新的系统状态做出调度决定，并告诉 nova-conductor 把该请求调度到合适的计算节点上。
  * > nova-conductor 在得知调度决定后，会把请求发送给对应的 nova-compute 服务。
  * > 每个 nova-compute 服务都有独立的资源监视器（Resource Tracker）用来监视本地主机的资源使用情况。当计算节点接收到请求时，资源监视器能够检查主机是否有足够的资源。
- > **RPC**
  * > nova 使用 AMQP 中的直连（direct）、扇型（fanout）、主题（topic）交换；
  * > nova 使用适配器类（adapter）将消息封装和解封从而调用函数，实现了两种 RPC 调用
    + > rpc.call：请求 + 响应，api 作为消费者（consumer）
    + > rpc.cast：单向，api 作为发布者（publisher）
  * > 每个 nova 内部组件都连接到消息代理，根据不同的作用，把消息队列作为：
    + > 调用者（Invoker）：nova-api、nova-scheduler；通过 rpc.call 和 rpc.cast 向消息队列发送消息
    + > 工作者（Worker）：nova-compute；从消息队列接收消息，根据 rpc.call 进行响应
- > **API 请求路由**
  * > nova-api 读取 `etc/nova/api-paste.ini` 并加载 WSGI 程序，最终 API 入口点都位于 `nova.api.openstack.compute` 中
  * > `nova/api/openstack/compute/routes.py` 中的 `APIRouterV21` 主要用来完成路由规则的创建，其中 ROUTE_LIST 保存了 URL 与 Controller 之间的映射关系。
  * > APIRouterV21 基于 ROUTE_LIST，使用 Routes 模块作为 URL 映射的工具，将各个模块所实现的 API 对应的 URL 注册到 mapper 中，并把每个资源都封装成 `nova.api.openstack.wsgi.Resource` 对象，当解析 URL 请求时，可以通过 URL 映射找到 API 对应的 Resource 对象。
  * > `nova/api/wsgi.py` 解析 URL 映射，通过 `_dispatch` 回调，调用 Resource 对象的 `_call_` 方法，最终通过请求调用 API 对应的模块中的方法。
- > **API 实现**
  * > `nova/api/openstack/compute/` 目录包含每个 API 对应的 `Controller` 实现，Resource 对象将请求的 API 映射到相应的 `Controller` 方法上。
- > **`nova-conductor`**
  * > 使用 RPC 的子组件通常包含以下文件：
    + > api.py 对 RPC 接口进行封装，类似提供 SDK
    + > rpcapi.py 暴露给其他内部组件的 RPC 接口，RPC 客户端
    + > manager.py 处理 RPC API 调用
  * > nova-compute 访问数据库的操作都要由 nova-conductor 代理，用 `nova/conductor/manager.py` 的 `ConductorManager` 类完成，出于安全性考虑，nova-conductor 和 nova-compute 不能部署在同一服务器上。
  * > `nova/objects` 定义了 nova object，***封装数据库 CURD 操作，每个类对应数据库中的一张表***。

`17. nova-api分析` https://gtcsq.readthedocs.io/en/latest/openstack/nova_api.html

Nova的Object Model源码分析 https://blog.csdn.net/chengqiuming/article/details/79672973
- > Object Model应该说是Nova中数据库访问的分水岭，在此之前，对每一个表的操作都放在同一个文件里，比如flavor.py，使用时直接调用这个文件中的函数去修改数据库。而Object Model引入后，新建立了Flavor对象与flavor表相对应，将对flavor表的操作都封装在Flavor对象里，需要通过Flavor对象的函数去进行数据操作。
- > Object Model并不是一个单独的服务，只是使用面向对象思想对数据库访问进行了包装，Object Model引入之后nova-compute访问数据库的流程发生了变化。
- > nova-compute需要更新数据库时候，将通过Object Model调用`nova.conductor.rcpapi.ConductorAPI`提供的RPC接口。
  ```py
  # nova/conductor/rpcapi.py
  class ConductorAPI(object):
      def service_create(self, context, values):
          cctxt = self.client.prepare()
          return cctxt.call(context, 'service_create', values=values)
  ```
- > nova-conductor接受RPC请求之后，通过本地的Object Model完成数据库更新。
  ```py
  #nova/conductor/manager.py
  class ConductorManager(manager.Manager):
      def service_create(self, context, values):
          svc = self.db.service_create(context, values)
          return jsonutils.to_primitive(svc)
  ```
- > nova-computer与nova-conductor部署在同一个节点时，nova-computer将直接通过Object Model的封装操作数据库，并不通过nava-conductor。
- > Object Model代码位于`nova/objects`目录，里面的每个类都对应数据库中的一个表，***比如`类ComputeNode`对应了数据库的`compute_nodes`表***。
- > `nova/objects/base.py`中定义了两个非常重要的修饰函数：`remotable_classmethod`和`remotable`，前者用于修饰类的方法，后者用于修饰类的实例的方法。
  ```py
  def remotable_classmethod(fn):
      """Decorator for remotable classmethods."""
      @functools.wraps(fn)
      def wrapper(cls, context, *args, **kwargs):
          if NovaObject.indirection_api:
              result = NovaObject.indirection_api.object_class_action(
                  context, cls.obj_name(), fn.__name__, cls.VERSION,
                  args, kwargs)
          else:
              result = fn(cls, context, *args, **kwargs)
              if isinstance(result, NovaObject):
                  result._context = context
          return result
      # NOTE(danms): Make this discoverable
      wrapper.remotable = True
      wrapper.original_fn = fn
  return classmethod(wrapper)
  ```
- > 如果nova-conductor与nova-compute部署在不同节点，nova-compute初始化时会将`NovaObject.indirection_api`初始化为`nova.conductor.rpcapi.ConductorAPI`,此时调用`remotable_classmethod`修饰的函数时，会通过RPC将其交给nova-conductor处理，RPC请求中包括了函数名，nova-conductor接受到RPC请求时会调用对应的Object Model函数完成数据库操作。
