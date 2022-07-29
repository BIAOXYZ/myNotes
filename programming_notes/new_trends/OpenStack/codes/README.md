
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
- OpenStack-Nova虚拟机冷迁移流程解析.md https://github.com/Yikun/yikun.github.com/blob/hexo/source/_posts/OpenStack-Nova%E8%99%9A%E6%8B%9F%E6%9C%BA%E5%86%B7%E8%BF%81%E7%A7%BB%E6%B5%81%E7%A8%8B%E8%A7%A3%E6%9E%90.md
- OpenStack-Nova虚拟机创建流程解析.md https://github.com/Yikun/yikun.github.com/blob/hexo/source/_posts/OpenStack-Nova%E8%99%9A%E6%8B%9F%E6%9C%BA%E5%88%9B%E5%BB%BA%E6%B5%81%E7%A8%8B%E8%A7%A3%E6%9E%90.md
- OpenStack源码分析-挂载卷流程.md https://github.com/Yikun/yikun.github.com/blob/hexo/source/_posts/OpenStack%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%90-%E6%8C%82%E8%BD%BD%E5%8D%B7%E6%B5%81%E7%A8%8B.md

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

openstack冷迁移/Resize源码分析（二） https://blog.csdn.net/qq_33909098/article/details/118960184

Nova组件源码分析之冷迁移与Resize https://itcn.blog/p/2010401099.html

# 网络

Nova中VIF的实现 http://niusmallnan.com/_build/html/_templates/openstack/nova_vif.html
- > VM安装完成后，需要为其设置网络接口，以便和主机网络，VM之间的网络通信。
- > KVM 客户机网络连接主要有两种方式:
  * > 用户网络(User Networking): 让虚拟机访问主机、互联网或本地网络上的资源的简单方法，***但是不能从网络或其他的客户机访问客户机***，性能上也需要大的调整。NAT方式，***虚拟机利用host机器的ip进行上网，对外显示一个ip***。
  * > 虚拟网桥(Virtual Bridge): 这种方式要比用户网络复杂一些，但是设置好后客户机与互联网，客户机与主机之间的通信都很容易。Bridge方式，将虚拟机桥接到host机器的网卡上，***VM和host机器都通过bridge上网，对外不同的ip***。
- > 那么在Openstack的云环境中，很明显Bridge模式更适合虚拟机网络，因为这样外部网络可以直接能访问到VM。

Neutron Core Plugins - ML2 https://blog.mazhangjing.com/2021/06/22/neutron-plugin/

openstack开发实践（六）：Neutron源码解析 https://blog.csdn.net/weixin_41977332/article/details/104856575

OpenStack中创建路由过程，代码和Linux主机的分析。 OpenStack中创建路由过程，代码和Linux主机的分析。

OpenStack干货分享 | Neutron源码分析之L3 https://www.sohu.com/a/122957372_573950 || https://icode.best/i/16560143163894

openstack系列之--neutronclient源码分析 https://mp.weixin.qq.com/s/dTxfSlfCASSJt4c8yfPSfg

【转载并修改】OpenStack Neutron源码分析：ovs-neutron-agent启动源码解析 https://www.cnblogs.com/qxxnxxFight/p/10791714.html

Neutron https://www.aboutyun.com/forum-192-1.html
- Neutron分析（1）——neutron-server启动过程分析 https://www.aboutyun.com/thread-9527-1-1.html
- openstack Neutron分析（2）—— neutron-l3-agent https://www.aboutyun.com/thread-9529-1-1.html

# 其他

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
