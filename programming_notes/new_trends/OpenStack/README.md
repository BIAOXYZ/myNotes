
# 官方

OpenStack Networking (Neutron). Mirror of code maintained at opendev.org. https://github.com/openstack/neutron
- https://github.com/openstack/neutron/tree/stable/stein

System for quickly installing an OpenStack cloud from upstream git for testing and development. Mirror of code maintained at opendev.org. https://github.com/openstack/devstack/tree/master || https://opendev.org/openstack/devstack

# 源码

【From yikun.github.com】
- OpenStack-Nova虚拟机冷迁移流程解析.md https://github.com/Yikun/yikun.github.com/blob/hexo/source/_posts/OpenStack-Nova%E8%99%9A%E6%8B%9F%E6%9C%BA%E5%86%B7%E8%BF%81%E7%A7%BB%E6%B5%81%E7%A8%8B%E8%A7%A3%E6%9E%90.md
- OpenStack-Nova虚拟机创建流程解析.md https://github.com/Yikun/yikun.github.com/blob/hexo/source/_posts/OpenStack-Nova%E8%99%9A%E6%8B%9F%E6%9C%BA%E5%88%9B%E5%BB%BA%E6%B5%81%E7%A8%8B%E8%A7%A3%E6%9E%90.md
- OpenStack源码分析-挂载卷流程.md https://github.com/Yikun/yikun.github.com/blob/hexo/source/_posts/OpenStack%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%90-%E6%8C%82%E8%BD%BD%E5%8D%B7%E6%B5%81%E7%A8%8B.md

如何阅读OpenStack源码 - int32bit的文章 - 知乎 https://zhuanlan.zhihu.com/p/28959724
- > 如果你对OpenStack的其它服务以及操作流程感兴趣，可以参考我的openstack-workflow项目, 这个项目是我本人在学习过程中记录，绘制成序列图，上图就是其中一个实例。项目地址为: https://github.com/int32bit/openstack-workflow

OpenStack创建虚拟机流程 https://www.cnblogs.com/luohaixian/p/12368164.html

openstack创建虚拟机源码阅读 https://segmentfault.com/a/1190000015371691

OpenStack虚拟机创建的50个步骤和100个知识点 https://mp.weixin.qq.com/s/XIoh9stHIGLrtlAKac9IZA

从数据库分析OpenStack创建虚机流程 https://mp.weixin.qq.com/s/5kdkeC3LRWdSvRULKMjW0A || https://www.sdnlab.com/21244.html

【From 码农这些事儿】
- OpenStack 源码阅读－创建虚拟机（一） https://mp.weixin.qq.com/s/JuwZxf9xF_QZWI1SUsEWyA
- OpenStack源码阅读－创建虚拟机（二） https://mp.weixin.qq.com/s/Vb-UCl2B61f-ITOpD0luTQ
- OpenStack源码阅读－创建虚拟机（三） https://mp.weixin.qq.com/s/z-b-jz6DEy-Ivz36KBr8jA

`17. nova-api分析` https://gtcsq.readthedocs.io/en/latest/openstack/nova_api.html

# 调试

OpenStack断点调试方法总结 - int32bit的文章 - 知乎 https://zhuanlan.zhihu.com/p/63898351

优雅地调试OpenStack https://yikun.github.io/2016/02/22/%E4%BC%98%E9%9B%85%E5%9C%B0%E8%B0%83%E8%AF%95OpenStack/ || https://github.com/Yikun/yikun.github.com/blob/hexo/source/_posts/%E4%BC%98%E9%9B%85%E5%9C%B0%E8%B0%83%E8%AF%95OpenStack.md

`21. OpenStack 调试` https://gtcsq.readthedocs.io/en/latest/openstack/openstack_debug.html
- 调试 OpenStack http://wsfdl.com/openstack/2013/08/28/%E8%B0%83%E8%AF%95OpenStack.html

# 腾讯云TStack
史上最全全全全的Cell V2干货详解在这！ https://cloud.tencent.com/developer/article/1473057

从消息队列看OpenStack https://mp.weixin.qq.com/s/7JE4Al31mr-7FXeF6GqvuQ || https://cloud.tencent.com/developer/article/1763043
- > **nova exchange**
  * > 以上一章节中提到的虚拟机启动为例，根据这里的消息队列模型再看一下虚拟机的启动流程，按照上图红色部分从左向右。
  * > 首先controller节点上的nova-api服务进程收到来自用户的虚拟机启动请求；nova-api查询到虚拟机位于计算节点compute上，因此构造rpc请求消息，将消息发送给`nova exchange`，并指定`routing key`为`compute.compute`；消息将根据路由键被发送到`compute.compute`队列中；最终绑定并消费该队列的nova-compute服务(计算节点compute上的进程)将获取到消息，并调用相应的函数执行虚拟机开机操作。***相关的rpc调用代码可以在`nova/compute/rpcapi.py`中找到***
    ```py
    # 1. nova-compute服务默认的rpc topic
    RPC_TOPIC = "compute"

    @profiler.trace_cls("rpc")
    class ComputeAPI(object):
        def __init__(self):
            super(ComputeAPI, self).__init__()
            # 2. 所有nova-compute服务都默认将消息发送到compute topic
            target = messaging.Target(topic=RPC_TOPIC, version='4.0')
            #...

        # 3. 启动虚拟机涉及的rpc调用方法
        def start_instance(self, ctxt, instance):
            version = '4.0'
            # 4. _compute_host(None, instance)将会返回虚拟机所在计算节点主机名，因此最终消息将会发送
            # 给compute.<compute_hostname>队列，如果不指定server参数，则消息将被发送给compute队列
            cctxt = self.router.client(ctxt).prepare(
                    server=_compute_host(None, instance), version=version)
            # 5. 此处cast表明是异步rpc调用，即只是将消息发送给nova-compute服务，不等待计算节点执行完成
            cctxt.cast(ctxt, 'start_instance', instance=instance)
    ```
- > **replay exchange**
  * > 在前面虚拟机启动相关的rpc调用函数中提到`cctxt.cast`方法是用于异步rpc调用的，即不会等待被调用方执行完成。
  * > 在openstack中，还有另外一种rpc调用，即同步rpc调用，对应的方法为`cctxt.call`，该方法被执行后，将会等待被调用方执行完成。
  * > 下面的代码同样来自 ***`nova/compute/rpcapi.py`*** 文件，该方法用于获取计算节点的运行时间。
    ```py
    # 获取计算节点的运行时间
    def get_host_uptime(self, ctxt, host):
        version = '4.0'
        # 通过server参数，指定将rpc调用请求发送给哪个队列，相应的计算节点将会收到消息并处理
        cctxt = self.router.client(ctxt).prepare(
                server=host, version=version)
        # 同步rpc调用`cctxt.call`会等待被调用方执行完成并返回结果
        return cctxt.call(ctxt, 'get_host_uptime')
    ```
  * > 将查询主机运行时间的rpc消息发送给指定的计算节点，这一过程与前面一节是完全一样的。不同点在于同步rpc调用与异步rpc调用，同步rpc调用由于需要获取远端方法的执行结果，因此需要有一种方法能够将远端方法的执行结果返回给调用者。
  * > 用通俗易懂的方式来说就是，***同步rpc调用时，`客户端`在发送给`服务端`的请求中，还会附加一个队列的名字，该队列用于告诉`服务端`，在方法执行完成后将执行结果发送到我给你的队列里面***。而`客户端`在发送了rpc调用请求后，则会一直监听用于返回结果的队列，直到有结果返回或者响应超时。(在返回结果时，原来的`服务端`变成了消息的生产者，`客户端`变成了消息的消费者。)
  * > 在这里提到的用于返回函数执行结果的队列，就是那些以`reply`开头的队列，后面跟着一个随机生成的uuid。这些队列不是绑定到nova exchange上的，而是为这些reply队列创建了同名的exchange，这些exchange的类型为direct类型。
  * > 并且在服务第一次调用call方法时会生成该队列，之后在服务重启之前会一直使用该队列作为reply队列。至此，同步rpc调用的简要流程可以通过下面这个图简要的表示出来
- > **fanout exchange**
  * > 以`fanout`结尾的exchange的作用是对所有相关的服务进行广播，以nova-scheduler服务为例，当有多个nova-scheduler服务进程时，每个nova-scheduler进程都会生成一个队列并绑定到scheduler_fanout exchange上。
  * > 在通过这个scheduler_fanout进行消息广播时，所有的nova-scheduler进程都将接收到消息。
  * > 使用广播给服务发送消息的方式，***在nova中主要用于通知nova-scheduler服务更新缓存信息***，比如通知所有的nova-scheduler服务进程更新主机可用域信息。在用户调用nova-api接口修改主机所在可用域的时候，nova-api服务就会通过广播的方式将计算节点的可用域信息广播给所有的nova-scheduler服务进程，使得nova-scheduler服务能够及时的更新内存中缓存的可用域信息，以便于正确的完成虚拟机调度。
  * > 下面的代码来自 ***`nova/scheduler/rpcapi.py`*** 文件，其作用就是通过广播的方式通知所有nova-scheduler服务进程完成内存数据的更新
    ```py
    def update_aggregates(self, ctxt, aggregates):
        # 通过fanout参数指定操作为广播操作
        cctxt = self.client.prepare(fanout=True, version='4.1')
        cctxt.cast(ctxt, 'update_aggregates', aggregates=aggregates)
    ```
  * > 这里同样使用一个图来简要的表示一下fanout exchange与nova服务之间的关系。下面这个图展示了在有两个控制节点，且每个控制节点上都有两个nova-scheduler进程时的scheduer_fanout exchange及其绑定的队列信息。
  * > 从图中可以看到，每个nova-scheduler服务都会有一个队列连接到scheduler_fanout exchange上。因此nova-api在进行广播消息时，每个`scheduler_fanout_<uuid>`队列里面都将收到消息，所有的nova-scheduler服务进程都能够处理消息。
- > **Nova高可用**
  * > nova组件的高可用分为两种，***一种是以暴露端口对外提供http调用的服务，比较典型的是nova-api服务***，另外还有像placement服务和nova-novncproxy服务；***第二种就是像nova-scheduler、nova-conductor这样的服务，这些服务是通过消息队列来接收和处理请求的***。
  * > 下面的代码来自 ***`nova/scheduler/rpcapi.py`***，其功能就是通过rpc同步调用nova-scheduler完成虚拟机的调度
    ```py
    # 1. 通过rpc同步调用nova-scheduler完成虚拟机调度，通常由nova-conductor服务发起调用
    def select_destinations(self, ctxt, spec_obj, instance_uuids):
        version = '4.4'
        #...
        # 2. 注意这里prepare方法没有指定server参数，因此消息将被发送给scheduler队列。
        # 如果指定了server=controller01，则消息将被发送给scheduler.controller01队列，此时
        # 虚拟机调度请求消息将只能被controller01节点上的nova-scheduler服务进程获取并处理。
        cctxt = self.client.prepare(version=version)
        # 3. rpc同步调用，等待虚拟机调度结果
        return cctxt.call(ctxt, 'select_destinations', **msg_args)
    ```

# 其他文章

Openstack工作原理——消息通讯机制 https://mp.weixin.qq.com/s/f8dTxqA1jPy1mVCIS_kB7A
- > **Openstack RPC**
  * > Openstack RPC实现了AMQP协议中的请求应答和数据处理等中间流程，并提供了几种发送AMQP消息的方法：
    + > **`RPC.call`**：发送请求到消息队列，等待返回最终结果。
    + > **`RPC.cast`**：发送请求到消息队列，不需要等待最终返回的结果。
  * > Openstack每个组件都会连接消息服务器，一个组件可能是一个消息发送者Invoker（如API、Scheduler），也可能是一个消息接收者Worker（如compute、volume、network）。***Invoker发送消息有两种方式：同步调用`rpc.call`和异步调用`rpc.cast`***，Worker接受并根据rpc.call的信息返回消息。
